using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.LogicQueue;
using ACT.Model;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.MissionSystem;

public class MissionManager : Singleton<MissionManager>, IMissionManagerInternal, IMissionManagerServerCall
{
	public enum MissionManagerStatus
	{
		Prepare,
		Running
	}

	public enum MissionTaskOperation
	{
		WaitFail,
		Wait,
		StartUp,
		AfterUpdateCondition,
		UpdateTracing,
		Offline
	}

	public struct MissionTask(int missionId, int missionVersion, MissionTaskOperation taskOperation, object taskParam)
	{
		public readonly int MissionId = missionId;

		public readonly int MissionVersion = missionVersion;

		public readonly MissionTaskOperation TaskOperation = taskOperation;

		public readonly object TaskParam = taskParam;
	}

	public class InteractObject
	{
		public int Swid;

		public int MissionId;

		public int IconConfigId;
	}

	private sealed class MissionTaskDispatcher
	{
		private readonly MissionManager m_MissionManager;

		private Dictionary<MissionTaskOperation, Func<MissionTask, bool>> m_OperationHandlers;

		public MissionTaskDispatcher(MissionManager manager)
		{
			m_MissionManager = manager;
			m_OperationHandlers = new Dictionary<MissionTaskOperation, Func<MissionTask, bool>>();
			m_OperationHandlers[MissionTaskOperation.StartUp] = TryScheduleStartUpTask;
			m_OperationHandlers[MissionTaskOperation.WaitFail] = TryScheduleWaitFailTask;
			m_OperationHandlers[MissionTaskOperation.Wait] = TryScheduleWaitTask;
			m_OperationHandlers[MissionTaskOperation.AfterUpdateCondition] = TryScheduleUpdateConditionTask;
			m_OperationHandlers[MissionTaskOperation.UpdateTracing] = TryScheduleUpdateTracingTask;
			m_OperationHandlers[MissionTaskOperation.Offline] = TryScheduleOffline;
		}

		public bool TryScheduleTask(MissionTask missionTask)
		{
			if (m_OperationHandlers.TryGetValue(missionTask.TaskOperation, out var value))
			{
				return value(missionTask);
			}
			Debug.LogError($"Unsupported task operation: {missionTask.TaskOperation}");
			return false;
		}

		private bool TryScheduleStartUpTask(MissionTask missionTask)
		{
			EnqueueMissionLogicAction(async (CancellationToken token) =>
			{
				await m_MissionManager.StartUpMission(m_MissionManager.GetMission(missionTask.MissionId), missionTask.MissionVersion, token);
			});
			return true;
		}

		private bool TryScheduleWaitFailTask(MissionTask missionTask)
		{
			EnqueueMissionLogicAction(async (CancellationToken token) =>
			{
				await UniTask.Yield();
				await m_MissionManager.OpenWaitMission(missionTask.MissionId, missionTask.MissionVersion, token);
			});
			return true;
		}

		private bool TryScheduleWaitTask(MissionTask missionTask)
		{
			EnqueueMissionLogicAction(async (CancellationToken token) =>
			{
				await m_MissionManager.OpenWaitMission(missionTask.MissionId, missionTask.MissionVersion, token);
			});
			return true;
		}

		private bool TryScheduleUpdateConditionTask(MissionTask missionTask)
		{
			object taskParam = missionTask.TaskParam;
			AfterFinishConditionStateTaskParam taskParam2 = taskParam as AfterFinishConditionStateTaskParam;
			if (taskParam2 == null)
			{
				Debug.LogError("TaskParam is not UpdateConditionStateTaskParam");
				return false;
			}
			EnqueueMissionLogicAction(async (CancellationToken token) =>
			{
				int missionId = missionTask.MissionId;
				int missionVersion = missionTask.MissionVersion;
				int conditionId = taskParam2.ConditionId;
				bool isFirst = taskParam2.IsFirst;
				await m_MissionManager.AfterFinishCondition(missionId, missionVersion, conditionId, isFirst, token);
				AfterFinishConditionStateTaskParam.Release(taskParam2);
			});
			return true;
		}

		private int GetPriority(MissionType missionType)
		{
			switch (missionType)
			{
			case MissionType.Main:
			case MissionType.MainActivity:
				return 0;
			case MissionType.Legend:
				return 1;
			case MissionType.Side:
			case MissionType.SideActivity:
				return 2;
			case MissionType.Daily:
			case MissionType.DailyActivity:
				return 3;
			default:
				return -1;
			}
		}

		private bool TryScheduleUpdateTracingTask(MissionTask missionTask)
		{
			EnqueueMissionLogicAction((CancellationToken token) =>
			{
				if (missionTask.MissionId == -1)
				{
					if (m_MissionManager.GetTracingMission() != 0 && m_MissionManager.IsAccepting(m_MissionManager.GetTracingMission()))
					{
						return UniTask.CompletedTask;
					}
					MissionFlow missionFlow = null;
					List<int> list = ListPool<int>.Get();
					m_MissionManager.GetAllMissions(list);
					foreach (int item in list)
					{
						MissionFlow mission = m_MissionManager.GetMission(item);
						if (mission.Data.Config.MissionTypeEnum != MissionType.Error && m_MissionManager.CanTrace(mission.Id))
						{
							if (missionFlow == null)
							{
								missionFlow = mission;
							}
							else
							{
								int priority = GetPriority(missionFlow.Data.Config.MissionTypeEnum);
								if (GetPriority(mission.Data.Config.MissionTypeEnum) <= priority)
								{
									missionFlow = mission;
								}
							}
						}
					}
					ListPool<int>.Release(list);
					if (missionFlow != null)
					{
						m_MissionManager.UpdateTracing(missionFlow.Id);
					}
				}
				else
				{
					m_MissionManager.UpdateTracing(missionTask.MissionId);
				}
				return UniTask.CompletedTask;
			});
			return true;
		}

		private bool TryScheduleOffline(MissionTask missionTask)
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_Offline, null);
			return true;
		}

		private void EnqueueMissionLogicAction(Func<CancellationToken, UniTask> action)
		{
			MissionFlowTaskLogicAction missionFlowTaskLogicAction = new MissionFlowTaskLogicAction(m_MissionManager.m_MissionActionQueue, action);
			m_MissionManager.m_MissionActionQueue.Enqueue(missionFlowTaskLogicAction);
			Singleton<GameLogicQueue>.instance.Execute(missionFlowTaskLogicAction);
		}
	}

	private CancellationTokenSource m_CTS;

	private Dictionary<int, MissionData> m_MissionDatas;

	private Transform m_MissionManagerRoot;

	private IMissionDatabase m_MissionDatabase;

	private IMissionDebugger m_MissionDebugger;

	private MissionTaskDispatcher m_TaskDispatcher;

	private Dictionary<int, int> m_BlockedMapArea = new Dictionary<int, int>();

	private Dictionary<int, int> m_ImplicitTracingMissions = new Dictionary<int, int>();

	private MissionManagerStatus m_Status;

	private Dictionary<int, MissionFlow> m_Missions;

	private Dictionary<int, int> m_MissionRef;

	private bool m_TaskProcessing;

	private LinkedList<MissionTask> m_TaskList;

	private Queue<LogicAction> m_MissionActionQueue;

	private List<MissionFlow> m_Buffer;

	private UnityEngine.Pool.ObjectPool<InteractObject> m_InteractObjectPool;

	private Dictionary<int, HashSet<InteractObject>> m_InteractObjects;

	public Transform MissionManagerRoot => m_MissionManagerRoot;

	public IMissionDatabase MissionDatabase => m_MissionDatabase;

	public CancellationToken CancellationToken => m_CTS.Token;

	public MissionConfig GetMissionConfig(int missionId)
	{
		m_MissionDatas.TryGetValue(missionId, out var value);
		return value?.Config ?? default(MissionConfig);
	}

	public MissionData GetMissionData(int missionId)
	{
		m_MissionDatas.TryGetValue(missionId, out var value);
		return value;
	}

	public void GetAllMissions(List<int> result)
	{
		result.Clear();
		foreach (KeyValuePair<int, MissionFlow> mission in m_Missions)
		{
			if (IsAccepting(mission.Key))
			{
				result.Add(mission.Key);
			}
		}
	}

	public void GetAllCreatedMissionFlows(List<int> result)
	{
		result.Clear();
		foreach (KeyValuePair<int, MissionFlow> mission in m_Missions)
		{
			if (!IsAccepting(mission.Key))
			{
				result.Add(mission.Key);
			}
		}
	}

	public int GetTracingMission()
	{
		return m_MissionDatabase.ExplicitTrackingMission;
	}

	public bool IsFinished(int missionId)
	{
		return m_MissionDatabase.QueryMissionState(missionId)?.IsFinished ?? false;
	}

	public bool IsAccepting(int missionId)
	{
		return m_MissionDatabase.QueryMissionState(missionId)?.IsClientAccepting ?? false;
	}

	public MissionFlow GetMissionFlow(int missionId)
	{
		return GetMission(missionId);
	}

	public bool IsAccepted(int missionId)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState == null)
		{
			return false;
		}
		if (readOnlyMissionState.FinishCount > 0)
		{
			return true;
		}
		if (readOnlyMissionState.IsClientAccepting)
		{
			return true;
		}
		if (readOnlyMissionState.StateEnum != ACT.Game.Data.MissionStateEnum.MissionStateWaitAccept && readOnlyMissionState.StateEnum != ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
		{
			return true;
		}
		return false;
	}

	public bool IsMissionGroupFinished(int missionGroupId)
	{
		if (!RuntimeConfigs.data.missionRGroups.TryGetValue(missionGroupId, out var value))
		{
			return false;
		}
		int lastMission = value.lastMission;
		return IsFinished(lastMission);
	}

	public int ResolveJumpMissionId(int param)
	{
		if (RuntimeConfigs.data.missionBases.ContainsKey(param))
		{
			return param;
		}
		if (!RuntimeConfigs.data.missionRGroups.ContainsKey(param))
		{
			return param;
		}
		int num = 0;
		int num2 = 0;
		foreach (MissionBase value in RuntimeConfigs.data.missionBases.Values)
		{
			if (value.groupID == param)
			{
				if (num2 == 0 || value.id < num2)
				{
					num2 = value.id;
				}
				if (IsAccepting(value.id) && (num == 0 || value.id < num))
				{
					num = value.id;
				}
			}
		}
		if (num == 0)
		{
			return num2;
		}
		return num;
	}

	public bool GetMissionItemSubmit(int missionId, out List<ItemSubmit> itemSubmitInfo)
	{
		MissionFlow mission = GetMission(missionId);
		if (mission == null)
		{
			itemSubmitInfo = null;
			return false;
		}
		if (!(mission.Blackboard.Get("ItemSubmitCondition") is ItemSubmitCondition itemSubmitCondition))
		{
			itemSubmitInfo = null;
			return false;
		}
		if (!(itemSubmitCondition.Param is ItemSubmitConditionParam itemSubmitConditionParam))
		{
			itemSubmitInfo = null;
			return true;
		}
		itemSubmitInfo = itemSubmitConditionParam.items;
		return true;
	}

	public bool GetMissionRedpointState(int missionId)
	{
		return G.localPlayer.redPoints.Missions.GetValueOrDefault(missionId, defaultValue: false);
	}

	public void RefreshRedDot()
	{
		foreach (KeyValuePair<int, MissionFlow> mission in m_Missions)
		{
			MissionFlow value = mission.Value;
			MissionConfig missionConfig = GetMissionConfig(value.Id);
			MissionRedDotCategory missionRedDotCategory = MissionRedDotCategory.All;
			switch (missionConfig.MissionTypeEnum)
			{
			case MissionType.Main:
			case MissionType.MainActivity:
				missionRedDotCategory = MissionRedDotCategory.Main;
				break;
			case MissionType.Side:
			case MissionType.SideActivity:
				missionRedDotCategory = MissionRedDotCategory.Side;
				break;
			case MissionType.Daily:
			case MissionType.DailyActivity:
				missionRedDotCategory = MissionRedDotCategory.Daily;
				break;
			case MissionType.Legend:
				missionRedDotCategory = MissionRedDotCategory.Legend;
				break;
			}
			int id = value.Id;
			string nodeFullPath = RedDotPathDefine.Task + "|" + (int)missionRedDotCategory + "|" + id;
			string nodeFullPath2 = RedDotPathDefine.Task + "|" + 0 + "|" + id;
			if (IsFinished(id))
			{
				if (Singleton<RedDotManager>.instance.IsNodeActive(nodeFullPath))
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
				}
				if (Singleton<RedDotManager>.instance.IsNodeActive(nodeFullPath2))
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath2, active: false);
				}
			}
			else
			{
				bool missionRedpointState = GetMissionRedpointState(id);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, missionRedpointState);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath2, missionRedpointState);
			}
		}
	}

	public UpdateTracingMissionResultType RequestTracingMission(int missionId)
	{
		return UpdateTracing(missionId);
	}

	public async UniTask<bool> RequestAcceptMission(int missionId, Action<bool> callback = null)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState == null)
		{
			m_MissionDebugger?.LogError("服务器与本地数据不一致，本地缺少任务ID：" + missionId);
			callback?.Invoke(obj: false);
			return false;
		}
		if (readOnlyMissionState.IsClientAccepting)
		{
			m_MissionDebugger?.LogError("不能重复接取：" + missionId);
			callback?.Invoke(obj: false);
			return false;
		}
		bool flag = await ManualAcceptMission(missionId, readOnlyMissionState.Version);
		callback?.Invoke(flag);
		return flag;
	}

	public void RequestGiveUpMission(int missionId, Action<bool> callback = null)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState == null)
		{
			m_MissionDebugger?.LogError("服务器与本地数据不一致，本地缺少任务ID：" + missionId);
			callback?.Invoke(obj: false);
		}
		else if (readOnlyMissionState.StateEnum != ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
		{
			callback?.Invoke(obj: true);
		}
		else
		{
			bool obj = GiveUpMission(missionId, readOnlyMissionState.Version);
			callback?.Invoke(obj);
		}
	}

	public bool RequestFailureMission(int missionId)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState == null)
		{
			m_MissionDebugger?.LogError("服务器与本地数据不一致，本地缺少任务ID：" + missionId);
			return false;
		}
		if (readOnlyMissionState.StateEnum != ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
		{
			return false;
		}
		FailureMission(missionId, readOnlyMissionState.Version);
		return true;
	}

	public IEnumerable<ConditionDescription> GetConditionDescription(int missionId, int conditionId)
	{
		MissionFlow mission = GetMission(missionId);
		if (mission == null || mission.GetConditionById(conditionId) == null)
		{
			yield break;
		}
		foreach (ConditionDescription conditionDescription in mission.GetConditionDescriptions(conditionId))
		{
			yield return conditionDescription;
		}
	}

	public IEnumerable<ConditionDescription> GetMissionDescriptions(int id)
	{
		MissionFlow mission = GetMission(id);
		if (mission == null)
		{
			yield break;
		}
		foreach (ConditionDescription description in mission.GetDescriptions())
		{
			yield return description;
		}
	}

	public bool IsInBlockedMapArea(int selectedMissionId)
	{
		return MissionDatabase.QueryMissionState(selectedMissionId)?.IsInBlockedMapArea ?? false;
	}

	public override void Init()
	{
		if (m_MissionDebugger == null)
		{
			m_MissionDebugger = new MissionDebugger();
		}
		if (m_CTS != null && !m_CTS.IsCancellationRequested)
		{
			m_CTS?.Cancel();
			m_CTS?.Dispose();
		}
		m_CTS = new CancellationTokenSource();
		if (m_MissionDatas == null)
		{
			m_MissionDatas = new Dictionary<int, MissionData>();
			foreach (KeyValuePair<int, MissionBase> missionBasis in RuntimeConfigs.data.missionBases)
			{
				int key = missionBasis.Key;
				MissionBase value = missionBasis.Value;
				if (value.isValid)
				{
					MissionDetail missionDetail = RuntimeConfigs.data.missionDetails[key];
					MissionRGroup missionRGroup = RuntimeConfigs.data.missionRGroups[value.groupID];
					MainmissionData chapter = RuntimeConfigs.data.mainmissionDatas[value.chapterID];
					MissionData value2 = new MissionData(new MissionConfig(value, missionDetail, chapter, missionRGroup));
					m_MissionDatas[key] = value2;
				}
			}
			foreach (KeyValuePair<int, MissionData> missionData in m_MissionDatas)
			{
				MissionData value3 = missionData.Value;
				foreach (MissionConditionData condition in value3.Stages[0].conditions)
				{
					if (!(condition.Param is IMissionDependencies missionDependencies))
					{
						continue;
					}
					foreach (int missionDependency in missionDependencies.MissionDependencies)
					{
						if (!m_MissionDatas.TryGetValue(missionDependency, out var value4))
						{
							Debug.LogWarning($"Mission not found: {value3.Id} -> {missionDependency}");
							continue;
						}
						value3.AddPreMission(value4);
						if (value3.Config.IsValid)
						{
							value4.AddNextMission(value3);
						}
					}
				}
			}
		}
		if (m_MissionManagerRoot == null)
		{
			m_MissionManagerRoot = new GameObject("MissionManager").transform;
			UnityEngine.Object.DontDestroyOnLoad(m_MissionManagerRoot);
		}
		(m_MissionDatabase ?? (m_MissionDatabase = new MissionLocalDatabase(localMode: false, m_MissionDatas))).Init();
		if (m_TaskDispatcher == null)
		{
			m_TaskDispatcher = new MissionTaskDispatcher(this);
		}
		(m_BlockedMapArea ?? (m_BlockedMapArea = new Dictionary<int, int>())).Clear();
		(m_ImplicitTracingMissions ?? (m_ImplicitTracingMissions = new Dictionary<int, int>())).Clear();
		(m_Missions ?? (m_Missions = new Dictionary<int, MissionFlow>())).Clear();
		(m_MissionRef ?? (m_MissionRef = new Dictionary<int, int>())).Clear();
		(m_TaskList ?? (m_TaskList = new LinkedList<MissionTask>())).Clear();
		(m_MissionActionQueue ?? (m_MissionActionQueue = new Queue<LogicAction>())).Clear();
		(m_Buffer ?? (m_Buffer = new List<MissionFlow>())).Clear();
		InitInteractObject();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change, OnSceneChangedStart);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, OnSceneChangedOver);
		m_Status = MissionManagerStatus.Prepare;
	}

	public override void UnInit()
	{
		m_Status = MissionManagerStatus.Prepare;
		m_TaskList.Clear();
		m_MissionActionQueue.Clear();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change, OnSceneChangedStart);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnSceneChangedOver);
		if (m_Missions != null)
		{
			foreach (KeyValuePair<int, MissionFlow> mission in m_Missions)
			{
				mission.Value.Close();
			}
		}
		m_Missions?.Clear();
		m_BlockedMapArea?.Clear();
		m_ImplicitTracingMissions?.Clear();
		m_MissionDatabase.UnInit();
		m_CTS?.Cancel();
		m_CTS?.Dispose();
		UnInitInteractObject();
		if ((bool)m_MissionManagerRoot)
		{
			UnityEngine.Object.Destroy(m_MissionManagerRoot.gameObject);
			m_MissionManagerRoot = null;
		}
	}

	public async UniTask Begin()
	{
		CancellationToken token = CancellationToken;
		BeginUpdate(token).Forget();
		if (m_MissionDatabase.ExplicitTrackingMission != 0 && !IsMissionValid(m_MissionDatabase.ExplicitTrackingMission))
		{
			m_MissionDatabase.UpdateExplicitTracingMission(0);
		}
		List<MissionFlow> tmpList = ListPool<MissionFlow>.Get();
		foreach (MissionState missionState in m_MissionDatabase.MissionStateList)
		{
			int missionId = missionState.MissionId;
			if (!IsMissionValid(missionId) || missionState.StateEnum != ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
			{
				continue;
			}
			CreateRunningMission(missionState.MissionId, missionState.Version);
			MissionFlow mission = GetMission(missionState.MissionId);
			for (int i = 0; i < mission.Failure.ConditionCount; i++)
			{
				if (mission.Failure != null && mission.Failure.GetConditionByIndex(i) is OfflineCondition offlineCondition)
				{
					offlineCondition.Offline = true;
				}
			}
			tmpList.Add(mission);
		}
		tmpList.Sort((MissionFlow a, MissionFlow b) => GetMissionPriority(a).CompareTo(GetMissionPriority(b)));
		foreach (MissionFlow item in tmpList)
		{
			IReadOnlyMissionState readOnlyMissionState = MissionDatabase.QueryMissionState(item.Id);
			await StartUpMission(GetMission(item.Id), readOnlyMissionState.Version, token);
			if (token.IsCancellationRequested)
			{
				break;
			}
		}
		ListPool<MissionFlow>.Release(tmpList);
		if (token.IsCancellationRequested)
		{
			return;
		}
		foreach (MissionState missionState2 in m_MissionDatabase.MissionStateList)
		{
			int missionId2 = missionState2.MissionId;
			MissionData missionData = GetMissionData(missionId2);
			if (!IsMissionValid(missionId2) || missionData.Config.MissionBase.manualAccept || missionState2.StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
			{
				continue;
			}
			if (missionData.NextMissions.Count > 0)
			{
				bool flag = false;
				foreach (MissionData nextMission in missionData.NextMissions)
				{
					IReadOnlyMissionState readOnlyMissionState2 = m_MissionDatabase.QueryMissionState(nextMission.Id);
					if (readOnlyMissionState2 != null && IsMissionValid(readOnlyMissionState2.MissionId) && !readOnlyMissionState2.IsFinished && !readOnlyMissionState2.IsServerAccepting && !readOnlyMissionState2.IsClientAccepting && readOnlyMissionState2.StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateWaitAccept)
					{
						flag = true;
					}
				}
				if (!flag)
				{
					continue;
				}
			}
			if (missionData.PreMissions.Count > 0)
			{
				bool flag2 = true;
				foreach (MissionData preMission in missionData.PreMissions)
				{
					IReadOnlyMissionState readOnlyMissionState3 = m_MissionDatabase.QueryMissionState(preMission.Id);
					if (readOnlyMissionState3 != null)
					{
						flag2 &= readOnlyMissionState3.FinishCount > 0;
					}
				}
				if (!flag2 && missionData.Stages[0].conditionGroups[0].conditions.Length != missionData.PreMissions.Count)
				{
					flag2 = true;
				}
				if (flag2)
				{
					m_TaskList.AddLast(new MissionTask(missionState2.MissionId, missionState2.Version, MissionTaskOperation.Wait, null));
				}
			}
			else
			{
				m_TaskList.AddLast(new MissionTask(missionState2.MissionId, missionState2.Version, MissionTaskOperation.Wait, null));
			}
		}
		ProcessTasks();
	}

	private void AddMissionRef(int missionId)
	{
		m_MissionRef.TryAdd(missionId, 0);
		m_MissionRef[missionId]++;
		MissionData missionData = GetMissionData(missionId);
		if (m_MissionRef[missionId] > 0 && !m_Missions.ContainsKey(missionId))
		{
			MissionFlow value = new MissionFlow(missionData);
			m_Missions.Add(missionId, value);
		}
	}

	private void RemoveMissionRef(int missionId)
	{
		m_MissionRef.TryAdd(missionId, 0);
		m_MissionRef[missionId]--;
		if (m_MissionRef[missionId] <= 0)
		{
			m_Missions.Remove(missionId);
		}
	}

	private void ProcessTasks()
	{
		if (m_TaskProcessing)
		{
			return;
		}
		try
		{
			m_TaskProcessing = true;
			while (m_TaskList.First != null && m_Status == MissionManagerStatus.Running)
			{
				LinkedListNode<MissionTask> first = m_TaskList.First;
				MissionTask value = first.Value;
				m_TaskList.Remove(first);
				if (!TryScheduleTask(value))
				{
					m_MissionDebugger?.LogError($"Failed to schedule mission task: {value.TaskOperation}");
				}
			}
		}
		catch (Exception exception)
		{
			m_MissionDebugger?.LogError(exception);
		}
		finally
		{
			m_TaskProcessing = false;
		}
	}

	private async UniTaskVoid BeginUpdate(CancellationToken token)
	{
		while (!token.IsCancellationRequested)
		{
			m_Buffer.Clear();
			m_Buffer.AddRange(m_Missions.Values);
			foreach (MissionFlow item in m_Buffer)
			{
				if (Singleton<GameManager>.instance?.worldManager?.HasActiveWorld == true)
				{
					bool inMissionWorld = InMissionWorld(item.Id);
					item.SetInMissionWorld(inMissionWorld);
				}
				item.Update();
			}
			ProcessTasks();
			await UniTask.Yield(PlayerLoopTiming.Update, token);
		}
	}

	private void OnSceneChangedStart(BaseEventContent obj)
	{
		m_Status = MissionManagerStatus.Prepare;
	}

	private void OnSceneChangedOver(BaseEventContent obj)
	{
		m_Status = MissionManagerStatus.Running;
		m_TaskList.AddLast(new MissionTask(-1, 0, MissionTaskOperation.UpdateTracing, null));
		ProcessTasks();
	}

	private MissionFlow GetMission(int missionId)
	{
		m_Missions.TryGetValue(missionId, out var value);
		return value;
	}

	private bool InMissionWorld(int missionId)
	{
		MissionConfig missionConfig = GetMissionConfig(missionId);
		if (!missionConfig.IsValid)
		{
			return false;
		}
		return Singleton<GameManager>.instance.worldManager.ActiveWorldId == missionConfig.World;
	}

	public bool IsMissionValid(int missionId)
	{
		MissionData missionData = GetMissionData(missionId);
		if (missionData == null)
		{
			return false;
		}
		MissionConfig config = missionData.Config;
		if (!config.MissionBase.isValid)
		{
			return false;
		}
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (config.MissionBase.effectiveCount >= 0 && readOnlyMissionState.FinishCount >= config.MissionBase.effectiveCount)
		{
			return false;
		}
		return true;
	}

	public bool CanTrace(int missionId)
	{
		if (!IsAccepting(missionId))
		{
			return false;
		}
		MissionData missionData = GetMissionData(missionId);
		if (missionData == null)
		{
			return false;
		}
		if (!missionData.Config.MissionBase.isValid)
		{
			return false;
		}
		if (missionData.Config.MissionBase.isHidden)
		{
			return false;
		}
		return true;
	}

	private static void TryDispatchEvent(Action action)
	{
		try
		{
			action();
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	private ConditionPriority GetMissionPriority(MissionFlow mission)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(mission.Id);
		if (readOnlyMissionState.CurrentStage >= mission.StageCount)
		{
			return ConditionPriority.Normal;
		}
		if (readOnlyMissionState.CurrentStage < 0)
		{
			return ConditionPriority.Normal;
		}
		return mission.GetStage(readOnlyMissionState.CurrentStage).GetPriority();
	}

	private bool IsTracingMission(int missionId)
	{
		if (m_MissionDatabase.ExplicitTrackingMission != missionId)
		{
			return m_ImplicitTracingMissions.ContainsKey(missionId);
		}
		return true;
	}

	private void InitInteractObject()
	{
		if (m_InteractObjectPool == null)
		{
			m_InteractObjectPool = new UnityEngine.Pool.ObjectPool<InteractObject>(() => new InteractObject(), (InteractObject item) =>
			{
				item.MissionId = 0;
				item.IconConfigId = 0;
			});
		}
		if (m_InteractObjects == null)
		{
			m_InteractObjects = new Dictionary<int, HashSet<InteractObject>>();
		}
	}

	private void UnInitInteractObject()
	{
		m_InteractObjectPool.Dispose();
		m_InteractObjects.Clear();
	}

	public InteractObject GetInteractObject(int swid)
	{
		if (m_InteractObjects.TryGetValue(swid, out var value) && value != null)
		{
			using HashSet<InteractObject>.Enumerator enumerator = value.GetEnumerator();
			if (enumerator.MoveNext())
			{
				return enumerator.Current;
			}
		}
		return null;
	}

	public InteractObject RegisterInteractObject(int swid, int missionId)
	{
		InteractObject interactObject = m_InteractObjectPool.Get();
		interactObject.Swid = swid;
		interactObject.MissionId = missionId;
		switch (GetMissionData(missionId).Config.MissionTypeEnum)
		{
		case MissionType.Main:
		case MissionType.MainActivity:
			interactObject.IconConfigId = 0;
			break;
		case MissionType.Side:
		case MissionType.SideActivity:
			interactObject.IconConfigId = 1;
			break;
		case MissionType.Daily:
		case MissionType.DailyActivity:
			interactObject.IconConfigId = 10;
			break;
		case MissionType.Legend:
			interactObject.IconConfigId = 11;
			break;
		}
		if (!m_InteractObjects.TryGetValue(swid, out var value))
		{
			value = CollectionPool<HashSet<InteractObject>, InteractObject>.Get();
			m_InteractObjects.Add(swid, value);
		}
		value.Add(interactObject);
		return interactObject;
	}

	public void UnRegisterInteractObject(InteractObject interactObject)
	{
		if (m_InteractObjects.TryGetValue(interactObject.Swid, out var value) && value != null)
		{
			value.Remove(interactObject);
			m_InteractObjectPool.Release(interactObject);
			if (value.Count == 0)
			{
				m_InteractObjects.Remove(interactObject.Swid);
				CollectionPool<HashSet<InteractObject>, InteractObject>.Release(value);
			}
		}
	}

	MissionFlow IMissionManagerInternal.GetMission(int missionId)
	{
		return GetMission(missionId);
	}

	UniTask<bool> IMissionManagerInternal.UpdateConditionState(int missionId, int conditionId, bool serverVerify, int progress, bool success, CancellationToken token)
	{
		return UpdateMissionState(missionId, conditionId, serverVerify, progress, success, token);
	}

	UniTask<bool> IMissionManagerInternal.FinishServerAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType, CancellationToken token)
	{
		return FinishServerAction(missionId, stageIndex, stageType, conditionGroupIndex, actionId, actionType, token);
	}

	bool IMissionManagerInternal.FinishAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType)
	{
		return FinishAction(missionId, stageIndex, stageType, conditionGroupIndex, actionId, actionType);
	}

	private async UniTask OpenWaitMission(int missionId, int missionVersion, CancellationToken token = default(CancellationToken))
	{
		MissionData missionData = GetMissionData(missionId);
		if (missionData == null)
		{
			m_MissionDebugger?.LogError($"任务数据不存在 {missionId}");
			return;
		}
		if (missionData.Config.MissionBase.manualAccept)
		{
			m_MissionDebugger?.LogError($"这不是自动接取的任务 {missionId}");
			return;
		}
		if (!IsMissionValid(missionId))
		{
			m_MissionDebugger?.LogError($"任务已经失效，不能接取{missionId}");
			return;
		}
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version == missionVersion)
		{
			if (GetMission(missionId) != null)
			{
				m_MissionDebugger?.LogError($"任务已经存在，不能重复接取{missionId}");
			}
			else if (m_MissionDatabase.WaitingMission(missionId))
			{
				await CreateAndStartUpMission(missionId, readOnlyMissionState.Version, token);
			}
		}
	}

	private async UniTask<bool> ManualAcceptMission(int missionId, int missionVersion, bool gm = false)
	{
		MissionData missionData = GetMissionData(missionId);
		if (missionData == null)
		{
			m_MissionDebugger?.LogError($"任务数据不存在 {missionId}");
			return false;
		}
		if (!gm)
		{
			if (!missionData.Config.MissionBase.manualAccept)
			{
				m_MissionDebugger?.LogError($"这不是手动接取的任务 {missionId}");
				return false;
			}
			if (missionData.Stages[0].conditions.Count > 0)
			{
				m_MissionDebugger?.LogError($"手动接取的任务不能有初始条件 {missionId}");
				return false;
			}
			if (missionData.Stages[0].actions.Count > 0)
			{
				m_MissionDebugger?.LogError($"手动接取的任务不能有接取行为 {missionId}");
				return false;
			}
			if (!IsMissionValid(missionId))
			{
				m_MissionDebugger?.LogError($"任务已经失效，不能接取{missionId}");
				return false;
			}
		}
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version != missionVersion)
		{
			return false;
		}
		if (GetMission(missionId) != null)
		{
			m_MissionDebugger?.LogError($"任务已经存在，不能重复接取{missionId}");
			return false;
		}
		if (missionData.Config.MissionBase.manualAccept)
		{
			if (!m_MissionDatabase.ManualAcceptMission(missionId))
			{
				return false;
			}
			CreateAndStartUpMission(missionId, readOnlyMissionState.Version, CancellationToken).Forget();
			if (CanTrace(missionId))
			{
				RequestTracingMission(missionId);
			}
			return true;
		}
		if (!m_MissionDatabase.WaitingMission(missionId))
		{
			return false;
		}
		CreateAndStartUpMission(missionId, readOnlyMissionState.Version, CancellationToken).Forget();
		return true;
	}

	private bool GiveUpMission(int missionId, int missionVersion, bool gm = false)
	{
		if (m_MissionDatabase.QueryMissionState(missionId).Version != missionVersion)
		{
			return false;
		}
		MissionFlow mission = GetMission(missionId);
		if (mission != null)
		{
			mission.Close();
			RemoveMissionRef(missionId);
		}
		m_MissionDatabase.GiveUpMission(missionId);
		if (mission != null)
		{
			TryDispatchEvent(() =>
			{
				MissionNGiveUpEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNGiveUpEvt>();
				evt.missionId = missionId;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_GiveUp, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			});
			if (m_MissionDatabase.ExplicitTrackingMission == missionId)
			{
				UpdateTracing(0);
			}
		}
		return true;
	}

	private bool CreateRunningMission(int missionId, int missionVersion)
	{
		if (GetMissionData(missionId) == null)
		{
			m_MissionDebugger?.LogError($"任务数据不存在 {missionId}");
			return false;
		}
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.StateEnum != ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
		{
			return false;
		}
		if (readOnlyMissionState.Version != missionVersion)
		{
			return false;
		}
		if (GetMission(missionId) != null)
		{
			return false;
		}
		AddMissionRef(missionId);
		MissionFlow mission = GetMission(missionId);
		mission.SyncInBlockedMap(readOnlyMissionState.IsInBlockedMapArea);
		mission.SetTracing(IsTracingMission(missionId));
		mission.SetInMissionWorld(InMissionWorld(missionId));
		mission.Open();
		return true;
	}

	private async UniTask StartUpMission(MissionFlow mission, int missionVersion, CancellationToken token = default(CancellationToken))
	{
		int missionId = mission.Id;
		IReadOnlyMissionState missionState = m_MissionDatabase.QueryMissionState(missionId);
		int currentStageIndex = missionState.ValidCurrentStage;
		IReadOnlyStageState currentStageState = missionState.StageStates[currentStageIndex];
		IReadOnlyStageState failureStageState = missionState.FailureState;
		MissionStage currentStage = mission.GetStage(currentStageIndex);
		for (int conditionIndex = 0; conditionIndex < currentStage.ConditionCount; conditionIndex++)
		{
			MissionCondition conditionByIndex = currentStage.GetConditionByIndex(conditionIndex);
			if (!currentStageState.GetConditionState(conditionByIndex.Id).Finished)
			{
				await TryFinishPreCheckedCondition(missionId, currentStage, conditionByIndex, token);
			}
		}
		MissionStage failureStage = mission.Failure;
		for (int conditionIndex = 0; conditionIndex < failureStage.ConditionCount; conditionIndex++)
		{
			MissionCondition conditionByIndex2 = failureStage.GetConditionByIndex(conditionIndex);
			if (!failureStageState.GetConditionState(conditionByIndex2.Id).Finished)
			{
				await TryFinishPreCheckedCondition(missionId, failureStage, conditionByIndex2, token);
			}
		}
		NotifyAcceptedMissionAddedToModel(missionId);
		IReadOnlyList<IReadOnlyStageState> stageStates = missionState.StageStates;
		if ((!stageStates[stageStates.Count - 1].IsArchive() || mission.Data.Config.MissionBase.resetGroupOnFailure) && currentStageIndex > 1 && failureStageState.ConditionStates.Count > 0)
		{
			for (int conditionIndex = 0; conditionIndex < failureStageState.ConditionGroupStates.Count; conditionIndex++)
			{
				if (failureStageState.ConditionGroupStates[conditionIndex].IsAchieve())
				{
					await ExecuteFailureActions(missionId, missionVersion, conditionIndex);
				}
			}
			if (failureStageState.IsCompleted())
			{
				FailureMission(missionId, missionVersion);
				return;
			}
		}
		if (currentStageState.IsArchive())
		{
			await CompleteStageStart(missionId, missionVersion, currentStageIndex);
		}
		for (int conditionIndex = 0; conditionIndex < currentStageState.ConditionGroupStates.Count; conditionIndex++)
		{
			if (currentStageState.ConditionGroupStates[conditionIndex].IsAchieve() && missionState.CurrentStage == currentStageIndex && missionState.StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
			{
				await ExecuteStageActions(missionId, missionVersion, currentStageIndex, conditionIndex);
			}
		}
		if (currentStageState.IsCompleted())
		{
			await CompleteStageEnd(missionId, missionVersion, currentStageIndex);
		}
		else
		{
			mission.ChangeState(MissionFlow.StateEnum.Stage, missionState.CurrentStage);
		}
	}

	private async UniTask<bool> CreateAndStartUpMission(int missionId, int missionVersion, CancellationToken token = default(CancellationToken))
	{
		if (!CreateRunningMission(missionId, missionVersion))
		{
			return false;
		}
		MissionFlow mission = GetMission(missionId);
		await StartUpMission(mission, missionVersion, token);
		return IsAccepting(missionId);
	}

	private async UniTask<bool> TryFinishPreCheckedCondition(int missionId, MissionStage stage, MissionCondition condition, CancellationToken token)
	{
		if (!stage.IsConditionRequired(condition))
		{
			return false;
		}
		if (!condition.PreCheckCondition())
		{
			return false;
		}
		if (condition.ServerVerify)
		{
			return await m_MissionDatabase.FinishConditionWithServerVerify(missionId, stage.Data.stageType, stage.StageIndex, condition.Id, 1, token);
		}
		IReadOnlyConditionState readOnlyConditionState = m_MissionDatabase.QueryMissionState(missionId)?.GetConditionState(condition.Id);
		return m_MissionDatabase.UpdateCondition(missionId, stage.Data.stageType, stage.StageIndex, condition.Id, readOnlyConditionState?.Progress ?? 1, success: true);
	}

	private void NotifyAcceptedMissionAddedToModel(int missionId)
	{
		if (IsAccepting(missionId))
		{
			WorldLevelTaskNotifyEvt evt = Singleton<EventManager>.instance.GetEvt<WorldLevelTaskNotifyEvt>();
			evt.taskId = missionId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.HasWorldLevelTaskNotify, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private async UniTask<bool> UpdateMissionState(int missionId, int conditionId, bool serverVerify, int progress, bool success, CancellationToken token)
	{
		IReadOnlyMissionState missionState = m_MissionDatabase.QueryMissionState(missionId);
		IReadOnlyConditionState conditionState = missionState.GetConditionState(conditionId);
		if (conditionState == null)
		{
			return false;
		}
		MissionFlow mission = GetMission(missionId);
		if (mission == null)
		{
			m_MissionDebugger?.LogError($"任务不存在 {missionId}");
			return false;
		}
		MissionCondition foundCondition = mission.GetConditionById(conditionId);
		if (foundCondition == null)
		{
			m_MissionDebugger?.LogError($"条件不存在 {missionId} {conditionId}");
			return false;
		}
		if (!foundCondition.Stage.IsActive || !foundCondition.Stage.IsConditionRequired(foundCondition))
		{
			return false;
		}
		if (conditionState.Finished && !foundCondition.IsRepeat)
		{
			m_MissionDebugger?.LogError($"非重复条件不能重复完成 {missionId} {conditionId}");
			return false;
		}
		MissionStage stage = foundCondition.Stage;
		if (stage.StageType == MissionStageType.Stage && stage.StageIndex == 0 && missionState.StateEnum != ACT.Game.Data.MissionStateEnum.MissionStateOngoing && !m_MissionDatabase.WaitingMission(missionId))
		{
			m_MissionDebugger?.LogError($"本地没有找到任务 {missionId} {conditionId}");
		}
		bool firstFinishCondition = !conditionState.Finished;
		if (!((!serverVerify) ? m_MissionDatabase.UpdateCondition(missionId, stage.Data.stageType, stage.StageIndex, conditionId, progress, success) : (await m_MissionDatabase.FinishConditionWithServerVerify(missionId, stage.Data.stageType, stage.StageIndex, conditionId, progress, token))))
		{
			if (serverVerify)
			{
				foundCondition.OnServerVerifyFailed();
			}
			m_MissionDebugger?.LogError($"本地没有找到任务，或者没有找到条件, 或者服务器验证不通过 {missionId} {conditionId}");
			return false;
		}
		stage.RefreshConditionActivation();
		TryDispatchEvent(() =>
		{
			MissionNConditionUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNConditionUpdateEvt>();
			evt.missionId = missionId;
			evt.conditionId = conditionId;
			evt.progress = progress;
			evt.finished = success;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_ConditionUpdate, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		});
		if (!success)
		{
			return true;
		}
		AfterFinishConditionStateTaskParam afterFinishConditionStateTaskParam = AfterFinishConditionStateTaskParam.Create();
		afterFinishConditionStateTaskParam.MissionId = missionId;
		afterFinishConditionStateTaskParam.ConditionId = conditionId;
		afterFinishConditionStateTaskParam.IsFirst = firstFinishCondition;
		m_TaskList.AddLast(new MissionTask(missionId, missionState.Version, MissionTaskOperation.AfterUpdateCondition, afterFinishConditionStateTaskParam));
		ProcessTasks();
		return true;
	}

	private async UniTask<bool> AfterFinishCondition(int missionId, int missionVersion, int conditionId, bool isFirst, CancellationToken token)
	{
		if (token.IsCancellationRequested)
		{
			return false;
		}
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version != missionVersion)
		{
			return false;
		}
		if (readOnlyMissionState.GetConditionState(conditionId) == null)
		{
			return false;
		}
		MissionFlow mission = GetMission(missionId);
		if (mission == null)
		{
			m_MissionDebugger?.LogError($"任务不存在 {missionId}");
			return false;
		}
		MissionCondition conditionById = mission.GetConditionById(conditionId);
		if (conditionById == null)
		{
			m_MissionDebugger?.LogError($"条件不存在 {missionId} {conditionId}");
			return false;
		}
		if (!conditionById.Stage.IsActive)
		{
			return false;
		}
		MissionStage stage = conditionById.Stage;
		MissionStageType stageType = stage.Data.stageType;
		int stageIndex = stage.StageIndex;
		IReadOnlyStageState stageState = null;
		switch (conditionById.Stage.Data.stageType)
		{
		case MissionStageType.Stage:
			stageState = readOnlyMissionState.StageStates[stageIndex];
			break;
		case MissionStageType.Fail:
			stageState = readOnlyMissionState.FailureState;
			break;
		case MissionStageType.Extra:
			stageState = readOnlyMissionState.ExtraState;
			break;
		}
		switch (stageType)
		{
		case MissionStageType.Stage:
		{
			if (stageState.IsArchive())
			{
				await CompleteStageStart(missionId, missionVersion, stageIndex);
			}
			for (int conditionGroupIndex = 0; conditionGroupIndex < stage.ConditionGroupCount; conditionGroupIndex++)
			{
				IReadOnlyConditionGroupState readOnlyConditionGroupState2 = stageState.ConditionGroupStates[conditionGroupIndex];
				if (readOnlyConditionGroupState2.GetConditionState(conditionId) != null && readOnlyConditionGroupState2.IsAchieve())
				{
					await ExecuteStageActions(missionId, missionVersion, stage.StageIndex, conditionGroupIndex);
				}
			}
			if (stageState.IsCompleted())
			{
				await CompleteStageEnd(missionId, missionVersion, stageIndex);
			}
			break;
		}
		case MissionStageType.Fail:
		{
			for (int conditionGroupIndex = 0; conditionGroupIndex < stage.ConditionGroupCount; conditionGroupIndex++)
			{
				IReadOnlyConditionGroupState readOnlyConditionGroupState3 = stageState.ConditionGroupStates[conditionGroupIndex];
				if (readOnlyConditionGroupState3.GetConditionState(conditionId) != null && readOnlyConditionGroupState3.IsAchieve())
				{
					await ExecuteFailureActions(missionId, missionVersion, conditionGroupIndex);
				}
			}
			if (stageState.IsCompleted())
			{
				FailureMission(missionId, missionVersion);
			}
			break;
		}
		case MissionStageType.Extra:
		{
			for (int conditionGroupIndex = 0; conditionGroupIndex < stage.ConditionGroupCount; conditionGroupIndex++)
			{
				IReadOnlyConditionGroupState readOnlyConditionGroupState = stageState.ConditionGroupStates[conditionGroupIndex];
				if (readOnlyConditionGroupState.GetConditionState(conditionId) != null && readOnlyConditionGroupState.IsAchieve() && (stage.GetConditionGroupByIndex(conditionGroupIndex).ActionTriggerMode != MissionConditionGroupTriggerType.Once || isFirst))
				{
					await ExecuteExtraActions(missionId, missionVersion, conditionGroupIndex);
				}
			}
			break;
		}
		}
		return true;
	}

	private bool FinishAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState == null)
		{
			m_MissionDebugger?.LogError($"任务不存在 {missionId}");
			return false;
		}
		if (GetMission(missionId) == null)
		{
			m_MissionDebugger?.LogError($"任务实例不存在 {missionId}");
			return false;
		}
		IReadOnlyStageState readOnlyStageState = null;
		if ((stageType switch
		{
			MissionStageType.Stage => readOnlyMissionState.StageStates[stageIndex], 
			MissionStageType.Fail => readOnlyMissionState.FailureState, 
			MissionStageType.Extra => readOnlyMissionState.ExtraState, 
			_ => throw new ArgumentOutOfRangeException("stageType", stageType, null), 
		}).ConditionGroupStates[conditionGroupIndex].GetActionState(actionId) == null)
		{
			m_MissionDebugger?.LogError($"任务行为不存在 {missionId} {stageIndex} {conditionGroupIndex} {actionId}");
			return false;
		}
		m_MissionDatabase.FinishAction(missionId, stageIndex, stageType, conditionGroupIndex, actionId, actionType);
		return true;
	}

	private async UniTask<bool> FinishServerAction(int missionId, int stageIndex, MissionStageType stageType, int conditionGroupIndex, int actionId, int actionType, CancellationToken token)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState == null)
		{
			m_MissionDebugger?.LogError($"任务不存在 {missionId}");
			return false;
		}
		if (GetMission(missionId) == null)
		{
			m_MissionDebugger?.LogError($"任务实例不存在 {missionId}");
			return false;
		}
		if (readOnlyMissionState.StageStates[stageIndex].ConditionGroupStates[conditionGroupIndex].GetActionState(actionId) == null)
		{
			m_MissionDebugger?.LogError($"任务行为不存在 {missionId} {stageIndex} {conditionGroupIndex} {actionId}");
			return false;
		}
		return await m_MissionDatabase.FinishServerAction(missionId, stageType, stageIndex, conditionGroupIndex, actionId, actionType, token);
	}

	private async UniTask SuccessMission(int missionId, int missionVersion)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version != missionVersion)
		{
			return;
		}
		m_MissionDatabase.SuccessMission(missionId);
		TryDispatchEvent(() =>
		{
			MissionNSuccessEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNSuccessEvt>();
			evt.missionId = missionId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_Success, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		});
		MissionFlow mission = GetMission(missionId);
		MissionData data = mission.Data;
		try
		{
			mission?.Close();
			RemoveMissionRef(missionId);
		}
		catch (Exception exception)
		{
			m_MissionDebugger?.LogError(exception);
		}
		try
		{
			if (m_MissionDatabase.ExplicitTrackingMission == missionId)
			{
				UpdateTracing(0);
			}
		}
		catch (Exception exception2)
		{
			m_MissionDebugger?.LogError(exception2);
		}
		LinkedListNode<MissionTask> linkedListNode = null;
		if (!data.Config.MissionBase.manualAccept && IsMissionValid(missionId))
		{
			linkedListNode = m_TaskList.AddFirst(new MissionTask(readOnlyMissionState.MissionId, readOnlyMissionState.Version, MissionTaskOperation.Wait, null));
		}
		foreach (MissionData nextMission in mission.Data.NextMissions)
		{
			if (IsMissionValid(nextMission.Id))
			{
				IReadOnlyMissionState readOnlyMissionState2 = m_MissionDatabase.QueryMissionState(nextMission.Id);
				linkedListNode = ((linkedListNode == null) ? m_TaskList.AddFirst(new MissionTask(nextMission.Id, readOnlyMissionState2.Version, MissionTaskOperation.Wait, null)) : m_TaskList.AddAfter(linkedListNode, new MissionTask(nextMission.Id, readOnlyMissionState2.Version, MissionTaskOperation.Wait, null)));
			}
		}
		if (!data.Config.MissionBase.isHidden)
		{
			m_TaskList.AddLast(new MissionTask(-1, 0, MissionTaskOperation.UpdateTracing, null));
		}
		if (mission.Data.Config.MissionBase.withForceFinishHint)
		{
			await PopView(mission.Data, isOpen: false, CancellationToken);
		}
	}

	private void FailureMission(int missionId, int missionVersion)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version != missionVersion)
		{
			return;
		}
		MissionFlow mission = GetMission(missionId);
		MissionData data = mission.Data;
		m_MissionDatabase.FailureMission(missionId);
		mission.Close();
		RemoveMissionRef(missionId);
		TryDispatchEvent(() =>
		{
			MissionNFailureEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNFailureEvt>();
			evt.missionId = missionId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_Failure, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		});
		if (data.Config.MissionBase.resetGroupOnFailure)
		{
			int[] missions = data.Config.Group.missions;
			foreach (int missionId2 in missions)
			{
				MissionFlow mission2 = GetMission(missionId2);
				if (mission2 != null)
				{
					mission2.Close();
					RemoveMissionRef(missionId2);
				}
			}
			if (m_MissionDatabase.ExplicitTrackingMission == missionId)
			{
				UpdateTracing(0);
			}
			m_TaskList.AddLast(new MissionTask(-1, 0, MissionTaskOperation.UpdateTracing, null));
		}
		else
		{
			if (m_MissionDatabase.ExplicitTrackingMission == missionId)
			{
				UpdateTracing(0);
			}
			if (!data.Config.MissionBase.manualAccept && IsMissionValid(missionId))
			{
				m_TaskList.AddFirst(new MissionTask(missionId, readOnlyMissionState.Version, MissionTaskOperation.WaitFail, null));
			}
			m_TaskList.AddLast(new MissionTask(-1, 0, MissionTaskOperation.UpdateTracing, null));
		}
	}

	private async UniTask PopView(MissionData missionData, bool isOpen, CancellationToken token)
	{
		try
		{
			MissionType missionTypeEnum = missionData.Config.MissionTypeEnum;
			if ((uint)(missionTypeEnum - 1) <= 5u)
			{
				MonoSideMissionView.SideMissionData data = new MonoSideMissionView.SideMissionData
				{
					missionId = missionData.Id,
					isOpen = isOpen
				};
				Model<BattleMainModel>.Interface.HudPositionUIEnqueue(UIPosition.Center, HudComponentType.SideMissionSuccessTip, data, 10f, (!isOpen) ? 1 : 3);
			}
		}
		catch (Exception exception)
		{
			m_MissionDebugger?.LogError(exception);
		}
	}

	private UpdateTracingMissionResultType UpdateTracing(int missionId)
	{
		if (Model<RaidModel>.HasInstance() && Model<RaidModel>.Interface.CurrentRaidId != 0 && RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value) && value.bindMissionGroupId != 0)
		{
			MissionData missionData = GetMissionData(missionId);
			if (missionId != 0 && missionData != null && missionData.Config.MissionGroupId != value.bindMissionGroupId)
			{
				return UpdateTracingMissionResultType.Reject;
			}
		}
		if (missionId != 0 && !CanTrace(missionId))
		{
			return UpdateTracingMissionResultType.Fail;
		}
		if (missionId != 0 && MissionDatabase.QueryMissionState(missionId).IsInBlockedMapArea)
		{
			return UpdateTracingMissionResultType.Reject;
		}
		int explicitTrackingMission = m_MissionDatabase.ExplicitTrackingMission;
		if (!m_MissionDatabase.UpdateExplicitTracingMission(missionId))
		{
			return UpdateTracingMissionResultType.Fail;
		}
		MissionFlow mission = GetMission(explicitTrackingMission);
		MissionFlow mission2 = GetMission(missionId);
		mission?.SetTracing(IsTracingMission(explicitTrackingMission));
		mission2?.SetTracing(IsTracingMission(missionId));
		TryDispatchEvent(() =>
		{
			MissionNTracingEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNTracingEvt>();
			evt.missionId = missionId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_Tracing, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		});
		return UpdateTracingMissionResultType.Succeed;
	}

	private async UniTask CompleteStageStart(int missionId, int missionVersion, int stageIndex)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version != missionVersion)
		{
			return;
		}
		MissionFlow mission = GetMission(missionId);
		if (mission != null && stageIndex == readOnlyMissionState.CurrentStage && stageIndex == 0)
		{
			TryDispatchEvent(() =>
			{
				MissionNAcceptEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNAcceptEvt>();
				evt.missionId = missionId;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_Accept, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			});
			if (mission.Data.Config.MissionBase.withForceAccpectHint)
			{
				await PopView(mission.Data, isOpen: true, CancellationToken);
			}
		}
	}

	private async UniTask CompleteStageEnd(int missionId, int missionVersion, int stageIndex)
	{
		IReadOnlyMissionState missionState = m_MissionDatabase.QueryMissionState(missionId);
		if (missionState.Version != missionVersion)
		{
			return;
		}
		MissionFlow mission = GetMission(missionId);
		if (mission == null || stageIndex != missionState.CurrentStage)
		{
			return;
		}
		TryDispatchEvent(() =>
		{
			MissionNStageCompleteEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNStageCompleteEvt>();
			evt.missionId = missionId;
			evt.stageIndex = stageIndex;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_StageComplete, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		});
		if (GetTracingMission() == missionId)
		{
			TryDispatchEvent(() =>
			{
				MissionNStageCompleteEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNStageCompleteEvt>();
				evt.missionId = missionId;
				evt.stageIndex = stageIndex;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_TracingStageComplete, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			});
		}
		if (stageIndex + 1 >= missionState.StageStates.Count)
		{
			await SuccessMission(missionId, missionVersion);
			return;
		}
		int newStageIndex = stageIndex + 1;
		m_MissionDatabase.UpdateStage(missionId, newStageIndex);
		if (stageIndex == 0)
		{
			TryDispatchEvent(() =>
			{
				MissionNAcceptEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNAcceptEvt>();
				evt.missionId = missionId;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_AcceptEnd, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			});
			NotifyAcceptedMissionAddedToModel(missionId);
		}
		try
		{
			mission.ChangeState(MissionFlow.StateEnum.Stage, newStageIndex);
			TryDispatchEvent(() =>
			{
				MissionNStageUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNStageUpdateEvt>();
				evt.missionId = missionId;
				evt.stageIndex = newStageIndex;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_StageUpdate, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			});
			if (GetTracingMission() == missionId)
			{
				TryDispatchEvent(() =>
				{
					MissionNStageUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNStageUpdateEvt>();
					evt.missionId = missionId;
					evt.stageIndex = newStageIndex;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionN_TracingStageUpdate, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				});
			}
		}
		catch (Exception exception)
		{
			m_MissionDebugger?.LogError(exception);
		}
		if (stageIndex == 0)
		{
			int tracingMission = GetTracingMission();
			MissionData missionData = GetMissionData(tracingMission);
			if (missionData == null || mission.Data.Config.MissionTypeEnum == MissionType.Main || mission.Data.Config.MissionTypeEnum == MissionType.MainActivity)
			{
				UpdateTracing(missionId);
			}
			else if (missionData.Config.MissionTypeEnum != MissionType.Main && missionData.Config.MissionTypeEnum != MissionType.MainActivity)
			{
				UpdateTracing(missionId);
			}
		}
		IReadOnlyStageState newStageState = missionState.StageStates[newStageIndex];
		if (newStageState.IsArchive())
		{
			await CompleteStageStart(missionId, missionVersion, newStageIndex);
		}
		for (int conditionGroupIndex = 0; conditionGroupIndex < newStageState.ConditionGroupStates.Count; conditionGroupIndex++)
		{
			if (newStageState.ConditionGroupStates[conditionGroupIndex].IsAchieve() && missionState.CurrentStage == newStageIndex && missionState.StateEnum == ACT.Game.Data.MissionStateEnum.MissionStateOngoing)
			{
				await ExecuteStageActions(missionId, missionVersion, newStageIndex, conditionGroupIndex);
			}
		}
		if (newStageState.IsCompleted())
		{
			await CompleteStageEnd(missionId, missionVersion, newStageIndex);
		}
	}

	private UniTask ExecuteStageActions(int missionId, int missionVersion, int stageIndex, int conditionGroupIndex)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version != missionVersion)
		{
			return UniTask.CompletedTask;
		}
		MissionFlow mission = GetMission(missionId);
		if (mission == null)
		{
			return UniTask.CompletedTask;
		}
		IReadOnlyConditionGroupState conditionGroupState = readOnlyMissionState.StageStates[stageIndex].ConditionGroupStates[conditionGroupIndex];
		return mission.ExecuteStageActions(stageIndex, conditionGroupIndex, conditionGroupState);
	}

	private async UniTask ExecuteFailureActions(int missionId, int missionVersion, int conditionGroupIndex)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version == missionVersion && RuntimeConfigs.data.missionBases.TryGetValue(missionId, out var value) && value.isValid)
		{
			MissionFlow mission = GetMission(missionId);
			if (mission != null)
			{
				IReadOnlyConditionGroupState conditionGroupState = readOnlyMissionState.FailureState.ConditionGroupStates[conditionGroupIndex];
				await mission.ExecuteFailureActions(conditionGroupIndex, conditionGroupState);
			}
		}
	}

	private async UniTask ExecuteExtraActions(int missionId, int missionVersion, int conditionGroupIndex)
	{
		IReadOnlyMissionState readOnlyMissionState = m_MissionDatabase.QueryMissionState(missionId);
		if (readOnlyMissionState.Version == missionVersion && RuntimeConfigs.data.missionBases.TryGetValue(missionId, out var value) && value.isValid)
		{
			MissionFlow mission = GetMission(missionId);
			if (mission != null)
			{
				IReadOnlyConditionGroupState conditionGroupState = readOnlyMissionState.ExtraState.ConditionGroupStates[conditionGroupIndex];
				await mission.ExecuteExtraActions(conditionGroupIndex, conditionGroupState);
			}
		}
	}

	public void AddBlockedMapArea(int subMapArea)
	{
		if (m_BlockedMapArea.TryGetValue(subMapArea, out var value))
		{
			m_BlockedMapArea[subMapArea] = value + 1;
			return;
		}
		m_BlockedMapArea.Add(subMapArea, 1);
		UpdateMissionBlocked(subMapArea, value: true);
	}

	public void RemoveBlockedMapArea(int subMapArea)
	{
		if (m_BlockedMapArea.TryGetValue(subMapArea, out var value))
		{
			if (value <= 1)
			{
				m_BlockedMapArea.Remove(subMapArea);
				UpdateMissionBlocked(subMapArea, value: false);
			}
			else
			{
				m_BlockedMapArea[subMapArea] = value - 1;
			}
		}
	}

	private void UpdateMissionBlocked(int subMapArea, bool value)
	{
		foreach (MissionState missionState in MissionDatabase.MissionStateList)
		{
			MissionData missionData = GetMissionData(missionState.MissionId);
			if (missionData == null)
			{
				continue;
			}
			MissionType missionTypeEnum = missionData.Config.MissionTypeEnum;
			if ((uint)(missionTypeEnum - 3) <= 4u && missionData.Config.MissionBase.subMapArea != 0 && missionData.Config.MissionBase.subMapArea == subMapArea)
			{
				missionState.IsInBlockedMapArea = value;
				if (m_Missions.TryGetValue(missionState.MissionId, out var value2))
				{
					value2.SyncInBlockedMap(value);
				}
			}
		}
	}

	public void AddImplicitTracingMission(int missionId)
	{
		if (m_ImplicitTracingMissions.TryGetValue(missionId, out var value))
		{
			m_ImplicitTracingMissions[missionId] = value + 1;
			return;
		}
		m_ImplicitTracingMissions.Add(missionId, 1);
		GetMission(missionId)?.SetTracing(IsTracingMission(missionId));
	}

	public void RemoveImplicitTracingMission(int missionId)
	{
		if (m_ImplicitTracingMissions.TryGetValue(missionId, out var value))
		{
			if (value <= 1)
			{
				m_ImplicitTracingMissions.Remove(missionId);
				GetMission(missionId)?.SetTracing(IsTracingMission(missionId));
			}
			else
			{
				m_ImplicitTracingMissions[missionId] = value - 1;
			}
		}
	}

	void IMissionManagerServerCall.InitMissions(MissionRNtf missions)
	{
		foreach (KeyValuePair<long, MissionR> mission in missions.Missions)
		{
			int missionId = (int)mission.Value.Id;
			if (!(m_MissionDatabase.QueryMissionState(missionId) is MissionState missionState))
			{
				m_MissionDebugger?.LogError("服务器与本地数据不一致，本地缺少任务ID：" + missionId);
				continue;
			}
			MissionR value = mission.Value;
			ACT.Game.Data.MissionStateEnum state = mission.Value.State;
			MissionData missionData = GetMissionData(missionId);
			int currentStage = Mathf.Max(value.Flows.Count - 1, 0);
			missionState.FinishCount = value.CompletedNum;
			missionState.StateEnum = state;
			missionState.CurrentStage = currentStage;
			if (value.ExtraFlows.Count > 0)
			{
				ACT.Game.Data.MissionFlow remoteStageState = value.ExtraFlows[0];
				StageState extraState = missionState.ExtraState;
				InitLocalStageState(remoteStageState, missionState, extraState);
			}
			InitLocalStageState(value.FailFlow, missionState, missionState.FailureState);
			for (int i = 0; i < value.Flows.Count; i++)
			{
				if (i >= missionState.StageStates.Length || missionData == null)
				{
					continue;
				}
				ACT.Game.Data.MissionFlow missionFlow = value.Flows[i];
				StageState stageState = missionState.StageStates[i];
				if (stageState?.ConditionGroupStates == null)
				{
					continue;
				}
				for (int j = 0; j < missionFlow.ConditionActionPairs.Count; j++)
				{
					if (j >= stageState.ConditionGroupStates.Length)
					{
						continue;
					}
					TriggerConditionActionPair triggerConditionActionPair = missionFlow.ConditionActionPairs[j];
					ConditionGroupState conditionGroupState = stageState.ConditionGroupStates[j];
					if (conditionGroupState == null)
					{
						continue;
					}
					for (int k = 0; k < triggerConditionActionPair.Conditions.Count; k++)
					{
						TriggerCondition triggerCondition = triggerConditionActionPair.Conditions[k];
						if (missionState.ConditionStateDict.TryGetValue(triggerCondition.Id, out var value2))
						{
							value2.Finished = triggerCondition.Done;
							value2.Progress = triggerCondition.Progress;
							value2.StartTs = triggerCondition.StartTs;
						}
					}
					for (int l = 0; l < triggerConditionActionPair.Actions.Count; l++)
					{
						TriggerAction triggerAction = triggerConditionActionPair.Actions[l];
						if (conditionGroupState.ActionStateDict.TryGetValue(triggerAction.Id, out var value3))
						{
							value3.Finished = triggerAction.Done;
						}
					}
				}
			}
		}
	}

	void IMissionManagerServerCall.InitTracingMission(int missionId)
	{
		(m_MissionDatabase as MissionLocalDatabase).InitExplicitTrackingMission(missionId);
	}

	private void InitLocalStageState(ACT.Game.Data.MissionFlow remoteStageState, MissionState localMissionState, StageState localStageState)
	{
		if (remoteStageState == null || localMissionState == null || localStageState == null || localStageState?.ConditionGroupStates == null)
		{
			return;
		}
		for (int i = 0; i < remoteStageState.ConditionActionPairs.Count; i++)
		{
			if (i >= localStageState.ConditionGroupStates.Length)
			{
				continue;
			}
			TriggerConditionActionPair triggerConditionActionPair = remoteStageState.ConditionActionPairs[i];
			ConditionGroupState conditionGroupState = localStageState.ConditionGroupStates[i];
			if (conditionGroupState == null)
			{
				continue;
			}
			for (int j = 0; j < triggerConditionActionPair.Conditions.Count; j++)
			{
				TriggerCondition triggerCondition = triggerConditionActionPair.Conditions[j];
				if (localMissionState.ConditionStateDict.TryGetValue(triggerCondition.Id, out var value))
				{
					value.Finished = triggerCondition.Done;
					value.Progress = triggerCondition.Progress;
					value.StartTs = triggerCondition.StartTs;
				}
			}
			for (int k = 0; k < triggerConditionActionPair.Actions.Count; k++)
			{
				TriggerAction triggerAction = triggerConditionActionPair.Actions[k];
				if (conditionGroupState.ActionStateDict.TryGetValue(triggerAction.Id, out var value2))
				{
					value2.Finished = triggerAction.Done;
				}
			}
		}
	}

	private bool TryScheduleTask(MissionTask missionTask)
	{
		if (m_TaskDispatcher != null)
		{
			return m_TaskDispatcher.TryScheduleTask(missionTask);
		}
		return false;
	}
}
