using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Utility;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class MissionFlow
{
	public enum StateEnum
	{
		None,
		Stage
	}

	private readonly MissionData m_Data;

	private AssetLoadHandle m_EnvAssetHandle;

	private GameObject m_Env;

	private bool m_Initialized;

	private CancellationTokenSource m_CTS;

	private MissionFSM m_FSM;

	private MissionFSM m_FailureFSM;

	private MissionFSM m_ExtraFSM;

	private Blackboard m_Blackboard;

	private MissionStateEnum m_State;

	private MissionStage m_Failure;

	private MissionStage m_Extra;

	private MissionStage[] m_Stages;

	private Dictionary<int, MissionCondition> m_ConditionIdMap;

	private Action<string> m_SignalListeners;

	private LocalizedString m_Description;

	private bool m_IsOpening;

	private bool m_IsTracing;

	private bool m_IsBlockedMap;

	private bool m_InMissionWorld;

	private int m_CurrentStageIndex = -1;

	public int StageCount => m_Stages.Length;

	public bool Initialized => m_Initialized;

	public int Id => m_Data.Id;

	public MissionData Data => m_Data;

	public int CurrentStageIndex => m_CurrentStageIndex;

	public bool IsOpening => m_IsOpening;

	public bool IsInBlockedMap => m_IsBlockedMap;

	public bool IsTracing => m_IsTracing;

	public bool InMissionWorld => m_InMissionWorld;

	public MissionStage Failure => m_Failure;

	public MissionStage Extra => m_Extra;

	public Blackboard Blackboard => m_Blackboard;

	public GameObject Env
	{
		get
		{
			if ((bool)m_Env)
			{
				return m_Env;
			}
			if (!m_IsOpening)
			{
				return null;
			}
			m_Env = new GameObject(Id.ToString());
			m_Env.transform.SetParent(Singleton<MissionManager>.instance.MissionManagerRoot);
			return m_Env;
		}
	}

	public CancellationToken Token => m_CTS?.Token ?? CancellationToken.None;

	public MissionFlow(MissionData data)
	{
		m_Data = data;
		m_Stages = ((data.Stages == null || data.Stages.Count == 0) ? Array.Empty<MissionStage>() : new MissionStage[data.Stages.Count]);
		m_ConditionIdMap = new Dictionary<int, MissionCondition>();
		m_Blackboard = new Blackboard();
		m_Failure = new MissionStage(data.Failure);
		m_Failure.Init(this, 0);
		m_Extra = new MissionStage(data.Extra);
		m_Extra.Init(this, 0);
		for (int i = 0; i < m_Stages.Length; i++)
		{
			MissionStage missionStage = new MissionStage(data.Stages[i]);
			m_Stages[i] = missionStage;
			missionStage.Init(this, i);
		}
		for (int j = 0; j < m_Failure.ConditionCount; j++)
		{
			MissionCondition conditionByIndex = m_Failure.GetConditionByIndex(j);
			if (conditionByIndex != null)
			{
				m_ConditionIdMap.TryAdd(conditionByIndex.Id, conditionByIndex);
			}
		}
		for (int k = 0; k < m_Extra.ConditionCount; k++)
		{
			MissionCondition conditionByIndex2 = m_Extra.GetConditionByIndex(k);
			if (conditionByIndex2 != null)
			{
				m_ConditionIdMap.TryAdd(conditionByIndex2.Id, conditionByIndex2);
			}
		}
		for (int l = 0; l < m_Stages.Length; l++)
		{
			MissionStage missionStage2 = m_Stages[l];
			for (int m = 0; m < missionStage2.ConditionCount; m++)
			{
				MissionCondition conditionByIndex3 = missionStage2.GetConditionByIndex(m);
				if (conditionByIndex3 != null)
				{
					m_ConditionIdMap.TryAdd(conditionByIndex3.Id, conditionByIndex3);
				}
			}
		}
		m_FSM = new MissionFSM();
		m_FSM.RegisterState(-1, new MissionFSMState_Normal(() =>
		{
			m_FailureFSM.ChangeState(-1);
			m_ExtraFSM.ChangeState(-1);
		}, null));
		MissionStage acceptStage = m_Stages[0];
		m_FSM.RegisterState(0, new MissionFSMState_Normal(() =>
		{
			m_CurrentStageIndex = 0;
			m_FailureFSM.ChangeState(-1);
			m_ExtraFSM.ChangeState(-1);
			acceptStage.SetActive(active: true);
		}, () =>
		{
			m_CurrentStageIndex = -1;
			acceptStage.SetActive(active: false);
		}));
		MissionStage startStage = m_Stages[1];
		m_FSM.RegisterState(1, new MissionFSMState_Normal(() =>
		{
			m_CurrentStageIndex = 1;
			m_FailureFSM.ChangeState(-1);
			m_ExtraFSM.ChangeState(-1);
			startStage.SetActive(active: true);
		}, () =>
		{
			m_CurrentStageIndex = -1;
			startStage.SetActive(active: false);
		}));
		for (int num = 2; num < m_Stages.Length; num++)
		{
			int stageIndex = num;
			MissionStage stage = m_Stages[stageIndex];
			m_FSM.RegisterState(stageIndex, new MissionFSMState_Normal(() =>
			{
				m_CurrentStageIndex = stageIndex;
				m_FailureFSM.ChangeState(0);
				m_ExtraFSM.ChangeState(0);
				stage.SetActive(active: true);
			}, () =>
			{
				m_CurrentStageIndex = -1;
				stage.SetActive(active: false);
			}));
		}
		m_FailureFSM = new MissionFSM();
		m_FailureFSM.RegisterState(-1, new MissionFSMState_Normal(null, null));
		m_FailureFSM.RegisterState(0, new MissionFSMState_Normal(() =>
		{
			m_Failure.SetActive(active: true);
		}, () =>
		{
			m_Failure.SetActive(active: false);
		}));
		m_ExtraFSM = new MissionFSM();
		m_ExtraFSM.RegisterState(-1, new MissionFSMState_Normal(null, null));
		m_ExtraFSM.RegisterState(0, new MissionFSMState_Normal(() =>
		{
			m_Extra.SetActive(active: true);
		}, () =>
		{
			m_Extra.SetActive(active: false);
		}));
	}

	public void SendSignal(string signal)
	{
		if (m_IsOpening && !string.IsNullOrEmpty(signal))
		{
			m_SignalListeners?.Invoke(signal);
		}
	}

	public void AddSignalListener(Action<string> listener)
	{
		m_SignalListeners = (Action<string>)Delegate.Combine(m_SignalListeners, listener);
	}

	public void RemoveSignalListener(Action<string> listener)
	{
		m_SignalListeners = (Action<string>)Delegate.Remove(m_SignalListeners, listener);
	}

	public void Open()
	{
		if (!m_IsOpening)
		{
			m_IsOpening = true;
			m_CTS = new CancellationTokenSource();
			CancellationToken token = m_CTS.Token;
			Initialize(token).Forget();
			ChangeState(StateEnum.None);
		}
	}

	public void Close()
	{
		if (m_IsOpening)
		{
			m_IsOpening = false;
			ChangeState(StateEnum.None);
			m_CTS?.Cancel();
			m_CTS?.Dispose();
			m_CTS = null;
			Uninitialize();
			m_CurrentStageIndex = -1;
			m_IsOpening = false;
			m_IsTracing = false;
			m_InMissionWorld = false;
			m_Blackboard.Clear();
			m_SignalListeners = null;
		}
	}

	public void Update()
	{
	}

	private async UniTask Initialize(CancellationToken token)
	{
		if (string.IsNullOrEmpty(m_Data.EnvAssetKey))
		{
			m_Initialized = true;
			return;
		}
		m_EnvAssetHandle = default;
		try
		{
			m_EnvAssetHandle = AssetStationManager.BattleStation.Load<GameObject>(m_Data.EnvAssetKey);
		}
		catch (Exception)
		{
		}
		if (m_EnvAssetHandle.IsValid)
		{
			await m_EnvAssetHandle;
			if (token.IsCancellationRequested)
			{
				return;
			}
			GameObject gameObject = m_EnvAssetHandle.AsGameObject();
			if (gameObject != null)
			{
				m_Env = UnityEngine.Object.Instantiate(gameObject, Singleton<MissionManager>.instance.MissionManagerRoot);
			}
		}
		m_Initialized = true;
	}

	private void Uninitialize()
	{
		if (m_EnvAssetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(m_EnvAssetHandle);
			m_EnvAssetHandle = default;
		}
		if ((bool)m_Env)
		{
			UnityEngine.Object.Destroy(m_Env);
			m_Env = null;
		}
		m_Initialized = false;
	}

	public MissionStage GetStage(int stageIndex)
	{
		if (stageIndex < 0 || m_Stages.Length <= stageIndex)
		{
			return null;
		}
		return m_Stages[stageIndex];
	}

	public MissionCondition GetConditionById(int conditionId)
	{
		m_ConditionIdMap.TryGetValue(conditionId, out var value);
		return value;
	}

	public IEnumerable<ConditionDescription> GetDescriptions()
	{
		MissionStage currentStage = GetStage(m_CurrentStageIndex);
		IEnumerable<ConditionDescription> enumerable = GetDescriptionsInner();
		bool haveContent = false;
		bool flag = false;
		foreach (ConditionDescription item in enumerable)
		{
			haveContent |= item.HaveContent;
			flag = true;
		}
		if (!flag)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, m_Data.Config.MissionTitleDescId);
			}
			IReadOnlyMissionState readOnlyMissionState = Singleton<MissionManager>.instance.MissionDatabase.QueryMissionState(Id);
			yield return new ConditionDescription
			{
				MissionId = Id,
				IsFinished = readOnlyMissionState.IsFinished,
				HaveContent = true,
				DescriptionContent = m_Description
			};
			yield break;
		}
		foreach (ConditionDescription item2 in enumerable)
		{
			if (!haveContent)
			{
				haveContent = true;
				if (m_Description == null)
				{
					m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, m_Data.Config.MissionTitleDescId);
				}
				ConditionDescription conditionDescription = item2;
				conditionDescription.HaveContent = true;
				conditionDescription.DescriptionContent = m_Description;
				yield return conditionDescription;
			}
			else
			{
				yield return item2;
			}
		}
		IEnumerable<ConditionDescription> GetDescriptionsInner()
		{
			if (currentStage != null)
			{
				for (int i = 0; i < currentStage.ConditionCount; i++)
				{
					MissionCondition condition = currentStage.GetConditionByIndex(i);
					foreach (ConditionDescription description in condition.GetDescriptions())
					{
						ConditionDescription current2 = description;
						current2.MissionId = Id;
						current2.ConditionId = condition.Id;
						current2.IsFinished = condition.IsFinished;
						yield return current2;
					}
				}
			}
		}
	}

	public IEnumerable<ConditionDescription> GetConditionDescriptions(int conditionId)
	{
		MissionCondition condition = GetConditionById(conditionId);
		if (condition == null)
		{
			yield break;
		}
		foreach (ConditionDescription description in condition.GetDescriptions())
		{
			ConditionDescription current = description;
			current.MissionId = Id;
			current.ConditionId = condition.Id;
			current.IsFinished = condition.IsFinished;
			yield return current;
		}
	}

	public void SyncInBlockedMap(bool blocked)
	{
		if (m_IsBlockedMap != blocked)
		{
			m_IsBlockedMap = blocked;
			MissionStage[] stages = m_Stages;
			for (int i = 0; i < stages.Length; i++)
			{
				stages[i].UpdateInBlockedMap();
			}
			m_Extra.UpdateInBlockedMap();
			m_Failure.UpdateInBlockedMap();
		}
	}

	public void SetInMissionWorld(bool inMissionWorld)
	{
		if (m_InMissionWorld != inMissionWorld)
		{
			m_InMissionWorld = inMissionWorld;
			MissionStage[] stages = m_Stages;
			for (int i = 0; i < stages.Length; i++)
			{
				stages[i]?.UpdateInMissionWorld();
			}
			m_Extra.UpdateInMissionWorld();
			m_Failure.UpdateInMissionWorld();
		}
	}

	public void SetTracing(bool tracing)
	{
		if (m_IsTracing != tracing)
		{
			m_IsTracing = tracing;
			MissionStage[] stages = m_Stages;
			for (int i = 0; i < stages.Length; i++)
			{
				stages[i]?.UpdateTracing();
			}
			m_Extra?.UpdateTracing();
		}
	}

	public void ChangeState(StateEnum state, int stageIndex = 0)
	{
		switch (state)
		{
		case StateEnum.None:
			m_FSM.ChangeState(-1);
			break;
		case StateEnum.Stage:
			m_FSM.ChangeState(stageIndex);
			break;
		}
	}

	public async UniTask<bool> ExecuteStageActions(int stageIndex, int conditionGroupIndex, IReadOnlyConditionGroupState conditionGroupState)
	{
		if (!m_IsOpening)
		{
			return false;
		}
		MissionStage stage = GetStage(stageIndex);
		if (stage == null)
		{
			Debug.LogError($"没有找到任务{Id}的阶段{stageIndex}中的条件组{conditionGroupIndex}");
			return false;
		}
		if (m_Data.Stages[stageIndex].conditionGroups.Length <= conditionGroupIndex)
		{
			Debug.LogError($"给出的条件组{conditionGroupIndex}溢出任务{Id}的阶段{stageIndex}");
			return false;
		}
		await stage.ExecuteActions(conditionGroupIndex, conditionGroupState, m_CTS.Token);
		return !m_CTS.Token.IsCancellationRequested;
	}

	public async UniTask<bool> ExecuteFailureActions(int conditionGroupIndex, IReadOnlyConditionGroupState conditionGroupState)
	{
		if (!m_IsOpening)
		{
			return false;
		}
		if (m_Failure.Data.conditionGroups.Length <= conditionGroupIndex)
		{
			return false;
		}
		CancellationToken token = m_CTS.Token;
		await m_Failure.ExecuteActions(conditionGroupIndex, conditionGroupState, token);
		return !token.IsCancellationRequested;
	}

	public async UniTask<bool> ExecuteExtraActions(int conditionGroupIndex, IReadOnlyConditionGroupState conditionGroupState)
	{
		if (!m_IsOpening)
		{
			return false;
		}
		if (m_Extra.Data.conditionGroups.Length <= conditionGroupIndex)
		{
			return false;
		}
		CancellationToken token = m_CTS.Token;
		await m_Extra.ExecuteActions(conditionGroupIndex, conditionGroupState, token);
		return !token.IsCancellationRequested;
	}

	public static int BuildGroupBit(int groupIndex)
	{
		if (groupIndex < 0 || groupIndex >= 30)
		{
			Debug.LogError($"Condition group index out of range: {groupIndex}");
			return 0;
		}
		return 1 << groupIndex;
	}
}
