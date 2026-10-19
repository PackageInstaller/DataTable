using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;

namespace ACT.Model;

public class ActivityExploreChallengeModel : Model<ActivityExploreChallengeModel>
{
	public class ChallengePhaseInfo
	{
		public int Id;

		public ActivityChallengeGroup ActivityChallengeGroupData;

		public bool UnLocked;

		public bool AllRewardReceived;
	}

	public class ChallengeInfo
	{
		public enum ChallengeInfoState
		{
			UnCompleted,
			Completed,
			Received
		}

		public int Id;

		public int GroupId;

		public ActivityChallengeData Data;

		public ChallengeInfoState State;
	}

	public struct DialogInfo
	{
		public string actionName;

		public string emotion;

		public int text;

		public int loopTime;
	}

	private string[] _tabTxtList = new string[7] { "I", "II", "III", "IV", "V", "VI", "VII" };

	public const int ActivityId = 1005;

	public const int ShopId = 6;

	public const int SubShopId = 306;

	public List<ChallengePhaseInfo> ChallengePhaseInfos = new List<ChallengePhaseInfo>();

	public Dictionary<int, List<ChallengeInfo>> ChallengeDataMap = new Dictionary<int, List<ChallengeInfo>>();

	public Dictionary<int, List<int>> ServerData = new Dictionary<int, List<int>>();

	public List<string> NpcActions = new List<string>();

	public Dictionary<string, DialogInfo> NpcActionDialogMap = new Dictionary<string, DialogInfo>();

	public Dictionary<string, List<int>> NpcActionDialogStrMap = new Dictionary<string, List<int>>();

	public long EndTimeStamp;

	public long StartTimeStamp;

	private OperationalActivityData _activityData;

	public override ContextType ContextType => ContextType.NET;

	public string GetPhaseTxt(int index)
	{
		return _tabTxtList[index];
	}

	protected override void Init()
	{
		InitData();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TaskGroupFinsh, OnTaskGroupFinsh);
	}

	private void InitData()
	{
		NpcActions.Clear();
		NpcActionDialogStrMap.Clear();
		foreach (KeyValuePair<int, ActivityNpc> activityNpc in RuntimeConfigs.data.activityNpcs)
		{
			if (activityNpc.Value.activityId == 1005)
			{
				NpcActions.Add(activityNpc.Value.activityNpcState);
				if (!NpcActionDialogMap.ContainsKey(activityNpc.Value.activityNpcState))
				{
					DialogInfo value = new DialogInfo
					{
						emotion = activityNpc.Value.activityNpcFace,
						loopTime = activityNpc.Value.loopTime,
						actionName = activityNpc.Value.activityNpcState
					};
					NpcActionDialogMap.Add(activityNpc.Value.activityNpcState, value);
				}
				if (!NpcActionDialogStrMap.ContainsKey(activityNpc.Value.activityNpcState))
				{
					NpcActionDialogStrMap.Add(activityNpc.Value.activityNpcState, new List<int>());
				}
				for (int i = 0; i < activityNpc.Value.activityNpcString.Length; i++)
				{
					NpcActionDialogStrMap[activityNpc.Value.activityNpcState].Add(activityNpc.Value.activityNpcString[i]);
				}
			}
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayerEnterAck, OnPlayerEnterAck);
	}

	private void OnPlayerEnterAck(BaseEventContent obj)
	{
		InitTaskData();
	}

	public void InitTaskData()
	{
		ChallengePhaseInfos.Clear();
		if (!RuntimeConfigs.data.activityDatas.TryGetValue(1005, out var value))
		{
			return;
		}
		int[] activityChallengGroup = value.activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityChallengGroup[i], out var value2))
			{
				ChallengePhaseInfo challengePhaseInfo = new ChallengePhaseInfo();
				challengePhaseInfo.Id = activityChallengGroup[i];
				challengePhaseInfo.ActivityChallengeGroupData = value2;
				if (_activityData != null && _activityData.Groups.TryGetValue(challengePhaseInfo.Id, out var value3))
				{
					challengePhaseInfo.UnLocked = TimeManager.IsInTimeRange(value3.StartTime, value3.EndTime);
				}
				else
				{
					challengePhaseInfo.UnLocked = TimeManager.IsInTimeRange(challengePhaseInfo.ActivityChallengeGroupData.startTimeStamp, challengePhaseInfo.ActivityChallengeGroupData.endTimeStamp);
				}
				challengePhaseInfo.AllRewardReceived = IsPhaseAllReceived(challengePhaseInfo.Id);
				ChallengePhaseInfos.Add(challengePhaseInfo);
			}
			GetTaskList(activityChallengGroup[i], refresh: true);
		}
	}

	public void RefreshTaskData()
	{
		for (int i = 0; i < ChallengePhaseInfos.Count; i++)
		{
			ChallengePhaseInfo challengePhaseInfo = ChallengePhaseInfos[i];
			if (_activityData == null || !_activityData.Groups.TryGetValue(challengePhaseInfo.Id, out var value))
			{
				continue;
			}
			challengePhaseInfo.UnLocked = TimeManager.IsInTimeRange(value.StartTime, value.EndTime);
			if (!challengePhaseInfo.UnLocked)
			{
				continue;
			}
			List<ChallengeInfo> taskList = GetTaskList(challengePhaseInfo.Id);
			for (int j = 0; j < taskList.Count; j++)
			{
				ChallengeInfo challengeInfo = taskList[j];
				if (challengeInfo.State != ChallengeInfo.ChallengeInfoState.Received)
				{
					if (Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(challengeInfo.Data.id))
					{
						challengeInfo.State = ChallengeInfo.ChallengeInfoState.Completed;
					}
					else
					{
						challengeInfo.State = ChallengeInfo.ChallengeInfoState.UnCompleted;
					}
				}
			}
		}
	}

	public bool HasChallengePhaseRewardToReceive(int index)
	{
		ChallengePhaseInfo challengePhaseInfo = ChallengePhaseInfos[index];
		if (!challengePhaseInfo.UnLocked)
		{
			return false;
		}
		foreach (ChallengeInfo task in GetTaskList(challengePhaseInfo.Id))
		{
			if (task.State == ChallengeInfo.ChallengeInfoState.Completed)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsPhaseAllTaskFinished(int groupId)
	{
		List<ChallengeInfo> taskList = GetTaskList(groupId);
		if (taskList == null || taskList.Count == 0)
		{
			return false;
		}
		foreach (ChallengeInfo item in taskList)
		{
			if (item.State == ChallengeInfo.ChallengeInfoState.UnCompleted)
			{
				return false;
			}
		}
		return true;
	}

	public static int GetIntroduction()
	{
		if (RuntimeConfigs.data.activityDatas.TryGetValue(1005, out var value))
		{
			return value.activityIntroduction;
		}
		return 0;
	}

	public static int GetDesc()
	{
		if (RuntimeConfigs.data.activityDatas.TryGetValue(1005, out var value))
		{
			return value.activityDesc;
		}
		return 0;
	}

	public long GetStartTimeStamp()
	{
		return StartTimeStamp;
	}

	public long GetEndTime()
	{
		return EndTimeStamp;
	}

	public DialogInfo GetDialogInfo()
	{
		Random random = new Random();
		int index = random.Next(NpcActions.Count);
		DialogInfo result = NpcActionDialogMap[NpcActions[index]];
		index = random.Next(NpcActionDialogStrMap[result.actionName].Count);
		result.text = NpcActionDialogStrMap[result.actionName][index];
		return result;
	}

	public void HandleServerData(ActivityCombinationNtf ntf)
	{
		if (ntf.ActivitCombinationInfo.ActivityId != 1005)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < ntf.ActivitCombinationInfo.GainedActivityGroup.Count; i++)
		{
			ActivityGroup activityGroup = ntf.ActivitCombinationInfo.GainedActivityGroup[i];
			if (!ServerData.ContainsKey(activityGroup.ActivityGroupId))
			{
				ServerData.Add(activityGroup.ActivityGroupId, new List<int>());
			}
			foreach (int activityChallengeId in activityGroup.ActivityChallengeIds)
			{
				if (!ServerData[activityGroup.ActivityGroupId].Contains(activityChallengeId))
				{
					ServerData[activityGroup.ActivityGroupId].Add(activityChallengeId);
				}
				ChallengeInfo taskInfo = GetTaskInfo(activityGroup.ActivityGroupId, activityChallengeId);
				if (taskInfo != null)
				{
					taskInfo.State = ChallengeInfo.ChallengeInfoState.Received;
					flag = true;
				}
			}
		}
		if (flag)
		{
			GameUtility.RefreshExploreChallengeRedDot();
		}
	}

	public void HandleServerData(OperationalActivityDataNtf ntf)
	{
		if (!ntf.Activitys.ContainsKey(1005))
		{
			return;
		}
		_activityData = ntf.Activitys[1005];
		EndTimeStamp = ntf.Activitys[1005].EndTime;
		StartTimeStamp = ntf.Activitys[1005].StartTime;
		foreach (KeyValuePair<int, ActivityGroupData> kv in ntf.Activitys[1005].Groups)
		{
			ChallengePhaseInfo challengePhaseInfo = ChallengePhaseInfos.Find((ChallengePhaseInfo info) => info.Id == kv.Key);
			if (challengePhaseInfo != null)
			{
				challengePhaseInfo.UnLocked = TimeManager.IsInTimeRange(kv.Value.StartTime, kv.Value.EndTime);
			}
		}
	}

	public bool IsPhaseAllReceived(int groupId)
	{
		if (ServerData == null)
		{
			return false;
		}
		if (!ServerData.ContainsKey(groupId))
		{
			return false;
		}
		if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(groupId, out var value))
		{
			for (int i = 0; i < value.challengeId.Length; i++)
			{
				if (!ServerData[groupId].Contains(value.challengeId[i]))
				{
					return false;
				}
			}
		}
		return true;
	}

	public int GetCompleteCount(int challengeId)
	{
		if (RuntimeConfigs.data.activityChallengeDatas.TryGetValue(challengeId, out var value))
		{
			MissionGroup missionGroup = RuntimeConfigs.data.missionGroups[value.missionGroupId];
			if (Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(missionGroup.missionId.FirstOrDefault(), out var value2))
			{
				return value2.progress;
			}
		}
		return 0;
	}

	public int GetNeedCount(int challengeId)
	{
		if (RuntimeConfigs.data.activityChallengeDatas.TryGetValue(challengeId, out var value))
		{
			MissionGroup missionGroup = RuntimeConfigs.data.missionGroups[value.missionGroupId];
			return RuntimeConfigs.data.missions[missionGroup.missionId.FirstOrDefault()].number;
		}
		return 0;
	}

	public List<ItemUnifierProxy> GetChallengeRewardList(ChallengeInfo info)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		for (int i = 0; i < info.Data.challengeReward.Length; i++)
		{
			if (RuntimeConfigs.data.collections.TryGetValue(info.Data.challengeReward[i], out var value))
			{
				for (int j = 0; j < value.certain.Count; j++)
				{
					ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(value.certain[j].id, value.certain[j].count);
					list.Add(item);
				}
			}
		}
		return list;
	}

	public List<ItemUnifierProxy> GetPhaseRewardList(int groupId)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (ChallengeInfo task in GetTaskList(groupId))
		{
			if (task.State == ChallengeInfo.ChallengeInfoState.Completed)
			{
				List<ItemUnifierProxy> challengeRewardList = GetChallengeRewardList(task);
				list.AddRange(challengeRewardList);
			}
		}
		return list;
	}

	public string GetPhaseUnlockLeftTime(int groupId)
	{
		if (_activityData.Groups.TryGetValue(groupId, out var value))
		{
			return TimeManager.GetTimeSpanString(value.StartTime - TimeManager.ServerTime.NowTimestamp, ETimeSpanFormatType.Type_DHM);
		}
		return "";
	}

	public List<ChallengeInfo> GetTaskList(int groupId, bool refresh = false)
	{
		if (ChallengeDataMap.ContainsKey(groupId))
		{
			if (!refresh)
			{
				return ChallengeDataMap[groupId];
			}
			ChallengeDataMap[groupId].Clear();
			ChallengeDataMap.Remove(groupId);
		}
		if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(groupId, out var value))
		{
			ChallengeDataMap.Add(groupId, new List<ChallengeInfo>());
			for (int i = 0; i < value.challengeId.Length; i++)
			{
				int num = value.challengeId[i];
				ChallengeInfo challengeInfo = new ChallengeInfo();
				challengeInfo.Id = num;
				challengeInfo.GroupId = groupId;
				if (RuntimeConfigs.data.activityChallengeDatas.TryGetValue(num, out var value2))
				{
					challengeInfo.Data = value2;
				}
				if (ServerData.ContainsKey(groupId) && ServerData[groupId].Contains(num))
				{
					challengeInfo.State = ChallengeInfo.ChallengeInfoState.Received;
				}
				else if (Model<ActivityCenterModel>.Interface.GetActivityChallengeIsComplete(challengeInfo.Data.id))
				{
					challengeInfo.State = ChallengeInfo.ChallengeInfoState.Completed;
				}
				else
				{
					challengeInfo.State = ChallengeInfo.ChallengeInfoState.UnCompleted;
				}
				ChallengeDataMap[groupId].Add(challengeInfo);
			}
		}
		return ChallengeDataMap[groupId];
	}

	public ChallengeInfo GetTaskInfo(int groupId, int taskId)
	{
		if (ChallengeDataMap.ContainsKey(groupId))
		{
			return ChallengeDataMap[groupId].Find((ChallengeInfo t) => t.Id == taskId);
		}
		return null;
	}

	public int GetShopCoinId()
	{
		if (RuntimeConfigs.data.activityDatas.TryGetValue(1005, out var value))
		{
			return value.activitySpecialParam[0];
		}
		return 0;
	}

	protected override void UnInit()
	{
		_activityData = null;
		ChallengePhaseInfos?.Clear();
		ChallengeDataMap?.Clear();
		ServerData?.Clear();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PlayerEnterAck, OnPlayerEnterAck);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TaskGroupFinsh, OnTaskGroupFinsh);
	}

	public void JumpToIntegratedExploringViewByActivityId()
	{
		if (IsInActivityOpenTimeRange())
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_INTEGRATEDEXPLORING).Forget();
		}
	}

	public async UniTask JumpToIntegratedExploringChallengeViewByActivityId(int activityId, int pageIndex)
	{
		if (activityId == 1005 && IsInActivityOpenTimeRange())
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_INTEGRATEDEXPLORINGCHALLENGEVIEW, new IntegratedExploringChallengeViewData
			{
				PageIndex = pageIndex
			}).Forget();
		}
	}

	public bool IsInActivityOpenTimeRange()
	{
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(1005);
		if (activityCenterData == null || !activityCenterData.IsVaild())
		{
			return false;
		}
		return true;
	}

	private void OnTaskGroupFinsh(BaseEventContent baseEventContent)
	{
		if (Model<ActivityCenterModel>.HasInstance() && Model<ActivityCenterModel>.Interface.GetActivityIsOpening(1005))
		{
			RefreshTaskData();
			GameUtility.RefreshExploreChallengeRedDot();
		}
	}
}
