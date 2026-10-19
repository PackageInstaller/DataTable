using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using Pb;
using UnityEngine;

namespace ACT.Model;

public class ActivityCenterModel : Model<ActivityCenterModel>, IJumpable
{
	public enum ActivityRewardState
	{
		Lock,
		Normal,
		Receive,
		Received
	}

	public int OpenActivityID = -1;

	public int SelectActivityId = -1;

	private Dictionary<int, ActivityCenterData> _activityCenterDataDic;

	private Dictionary<int, ActivitSignInInfo> _activitySignInInfoDic;

	private ActivitTempleChallengeInfo _activityTempleChallengeInfo;

	private ActivitAbyssInfo _activitAbyssInfo;

	private Dictionary<int, ActivitRoleTrialInfo> _activityRoleTrialInfoDic;

	private ActivityDailyLotteryInfo _activityLotteryInfo;

	private ActivityKujiInfo _activityKujiInfo;

	private Dictionary<int, ActivitSkinTrialInfo> _activitySkinTrialInfoDic;

	private ActivityTotalRechargeInfo _activityTotalRechargeInfo;

	private ActivityMainStoryInfo _activityMainStoryInfo;

	private ActivityMapExploreInfo _activityMapExploreInfo;

	private ActivityMultiDeviceInfo _activityMultiDeviceInfo;

	private List<int> _currentActivityIds = new List<int>(16);

	private int _oneTreatObservedTicketCount = -1;

	private int _oneTreatUnacknowledgedTicketCount;

	private bool _oneTreatMainRedDotDirty;

	public const int SYSTEM_ID = 3001;

	public float LastRefreshTime;

	public override ContextType ContextType => ContextType.NET;

	public bool HasReceivedOperationalActivityList { get; private set; }

	private ActivityCenterData _playerLevelActivityInfo => GetPlayerLevelActivityInfo();

	public ActivityCenterData PlayerLevelActivityInfo => _playerLevelActivityInfo;

	public LuminModelType JumpSourceType => LuminModelType.Activities;

	protected override void Init()
	{
		TimeManager.OnServerTimeChange += OnServerTimeChange;
		if (_activityCenterDataDic == null)
		{
			_activityCenterDataDic = new Dictionary<int, ActivityCenterData>();
		}
		if (_activityRoleTrialInfoDic == null)
		{
			_activityRoleTrialInfoDic = new Dictionary<int, ActivitRoleTrialInfo>();
		}
		if (_activitySignInInfoDic == null)
		{
			_activitySignInInfoDic = new Dictionary<int, ActivitSignInInfo>();
		}
		if (_activitySkinTrialInfoDic == null)
		{
			_activitySkinTrialInfoDic = new Dictionary<int, ActivitSkinTrialInfo>();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayerExp_Change, OnPlayerLevelChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TaskGroupFinsh, OnTaskGroupFinish);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnOneTreatTicketCountChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnOneTreatTicketCountChanged);
	}

	protected override void UnInit()
	{
		TimeManager.OnServerTimeChange -= OnServerTimeChange;
		_activityCenterDataDic.Clear();
		HasReceivedOperationalActivityList = false;
		_activitySignInInfoDic.Clear();
		_activitySignInInfoDic = null;
		_activityTempleChallengeInfo = null;
		_activitAbyssInfo = null;
		_activityLotteryInfo = null;
		_activityKujiInfo = null;
		_activityRoleTrialInfoDic.Clear();
		_activityRoleTrialInfoDic = null;
		_oneTreatObservedTicketCount = -1;
		_oneTreatUnacknowledgedTicketCount = 0;
		_oneTreatMainRedDotDirty = false;
		_activitySkinTrialInfoDic.Clear();
		_activitySkinTrialInfoDic = null;
		_activityTotalRechargeInfo = null;
		_activityMainStoryInfo = null;
		_activityMapExploreInfo = null;
		_activityMultiDeviceInfo = null;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PlayerExp_Change, OnPlayerLevelChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TaskGroupFinsh, OnTaskGroupFinish);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnOneTreatTicketCountChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnOneTreatTicketCountChanged);
	}

	private void OnServerTimeChange()
	{
		if (!CheckIsHasOpeningActivity())
		{
			return;
		}
		bool flag = false;
		_currentActivityIds.Clear();
		_currentActivityIds.AddRange(_activityCenterDataDic.Keys);
		for (int i = 0; i < _currentActivityIds.Count; i++)
		{
			int key = _currentActivityIds[i];
			if (!_activityCenterDataDic[key].IsVaild())
			{
				_activityCenterDataDic.Remove(key);
				flag = true;
			}
		}
		if (flag)
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshActivityCenter, null);
			Model<ActivityCenterModel>.Interface.RefreshRedDot();
		}
	}

	public void ReqRefreshActivity()
	{
		LastRefreshTime = Time.unscaledTime;
		G.service.RequestActivityRefresh((ActivityRefreshAck ack) =>
		{
		});
	}

	public void UpdateOperationalActivityInfo(OperationalActivityDataNtf operationalActivityDataNtf)
	{
		if (operationalActivityDataNtf == null)
		{
			return;
		}
		HasReceivedOperationalActivityList = true;
		foreach (OperationalActivityData value2 in operationalActivityDataNtf.Activitys.Values)
		{
			if (_activityCenterDataDic.TryGetValue(value2.ActivityId, out var value))
			{
				value.UpdateData(value2);
				continue;
			}
			value = new ActivityCenterData(value2);
			if (value.IsVaild())
			{
				_activityCenterDataDic.Add(value.ActivityId, value);
			}
		}
		_currentActivityIds.Clear();
		_currentActivityIds.AddRange(_activityCenterDataDic.Keys);
		for (int i = 0; i < _currentActivityIds.Count; i++)
		{
			int key = _currentActivityIds[i];
			if (!operationalActivityDataNtf.Activitys.ContainsKey(key))
			{
				_activityCenterDataDic.Remove(key);
			}
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshActivityCenter, null);
		Model<ActivityCenterModel>.Interface.RefreshRedDot();
	}

	public bool GetActivityIsOpening(int activityID)
	{
		if (!_activityCenterDataDic.TryGetValue(activityID, out var value))
		{
			return false;
		}
		return GetActivityIsOpening(value.ServerActivityData);
	}

	public bool GetActivityIsOpening(OperationalActivityData operationalActivityData)
	{
		if (operationalActivityData == null)
		{
			return false;
		}
		if (operationalActivityData.IsHide)
		{
			return false;
		}
		if (!TimeManager.IsInTimeRange(operationalActivityData.StartTime, operationalActivityData.EndTime))
		{
			return false;
		}
		int activityId = operationalActivityData.ActivityId;
		RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value);
		if (value == null || value.activityEntryPosition != 1)
		{
			return false;
		}
		return true;
	}

	public List<ActivityCenterData> GetOpeningActivitys()
	{
		List<ActivityCenterData> list = new List<ActivityCenterData>();
		foreach (ActivityCenterData value in _activityCenterDataDic.Values)
		{
			if (value.IsVaild())
			{
				list.Add(value);
			}
		}
		list.Sort(SortActivity);
		return list;
	}

	public bool CheckIsHasOpeningActivity()
	{
		if (_activityCenterDataDic == null)
		{
			return false;
		}
		return _activityCenterDataDic.Count > 0;
	}

	private int SortActivity(ActivityCenterData left, ActivityCenterData right)
	{
		return left.ServerActivityData.Priority - right.ServerActivityData.Priority;
	}

	public bool GetActivityTabRedpointState()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
		{
			return false;
		}
		foreach (KeyValuePair<int, ActivityCenterData> item in _activityCenterDataDic)
		{
			if (GetActivityTabRedpointState(item.Value.ActivityId))
			{
				return true;
			}
		}
		return false;
	}

	public bool GetActivityTabRedpointState(int activityId)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
		{
			return false;
		}
		if (G.localPlayer.redPoints.Activitys.TryGetValue(activityId, out var value))
		{
			return value;
		}
		return false;
	}

	public string GetPrefabPathByActivityType(int activityType, int prefabType)
	{
		return (ActivityType)activityType switch
		{
			ActivityType.PlayerLevel => "UI/Activity_Playerlevel", 
			ActivityType.SignIn => prefabType switch
			{
				1 => "UI/SevenDaySignIn", 
				2 => "UI/TenDaySignIn", 
				3 => "UI/ThirtyFiveDaySignIn", 
				_ => string.Empty, 
			}, 
			ActivityType.ActivityAbyss => "UI/ActivityAbyss", 
			ActivityType.ExploringChallenge => "UI/IntegratedExploringChallengeView", 
			ActivityType.TempleChallenge => "UI/ActivityTempleChallenge", 
			ActivityType.CharacterTrial => "UI/ActivityCharacterTrial", 
			ActivityType.DailyLottery => "UI/ActivitySweep", 
			ActivityType.RaidDoubleReward => "UI/RaidDoubleReward", 
			ActivityType.SkinTrial => "UI/ActivitySkinTrial", 
			ActivityType.TotalRecharge => "UI/TotalRechargeReward", 
			ActivityType.OneTreat => "UI/OneTreatPanel", 
			ActivityType.MainlineMotivation => "UI/MainlineMotivationView", 
			ActivityType.LimitedTimeMapExploration => "UI/LimitedTimeMapExplorationView", 
			ActivityType.MultiDevice => "UI/ActivityMultiDevice", 
			ActivityType.CompanionMission => "UI/ActivityCompanionMission", 
			_ => string.Empty, 
		};
	}

	public ActivityCenterData GetActivityCenterData(int activityId)
	{
		if (_activityCenterDataDic.TryGetValue(activityId, out var value))
		{
			return value;
		}
		return null;
	}

	public bool GetActivityChallengeIsComplete(int activityChallengeId)
	{
		if (!RuntimeConfigs.data.activityChallengeDatas.TryGetValue(activityChallengeId, out var value))
		{
			return false;
		}
		if (value.missionGroupId <= 0)
		{
			return true;
		}
		return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value.missionGroupId);
	}

	public void UpdateActivityMainStoryInfo(ActivityMainStoryNtf activityMainStoryNtf)
	{
		ActivityMainStoryInfo activityMainStoryInfo = activityMainStoryNtf?.ActivityMainStoryInfo;
		if (activityMainStoryInfo != null && activityMainStoryInfo.ActivityId > 0)
		{
			_activityMainStoryInfo = activityMainStoryInfo;
			RefreshActivityMainStoryRedDotState();
		}
	}

	public bool IsActivityMainStoryChallengeReceived(int activityId, int activityGroupId, int challengeId)
	{
		if (_activityMainStoryInfo == null || _activityMainStoryInfo.ActivityId != activityId)
		{
			return false;
		}
		foreach (ActivityGroup item in _activityMainStoryInfo.GainedActivityGroup)
		{
			if (item.ActivityGroupId == activityGroupId)
			{
				return item.ActivityChallengeIds.Count == 0 || item.ActivityChallengeIds.Contains(challengeId);
			}
		}
		return false;
	}

	public void UpdateActivityMapExploreInfo(ActivityMapExploreNtf activityMapExploreNtf)
	{
		ActivityMapExploreInfo activityMapExploreInfo = activityMapExploreNtf?.ActivityMapExploreInfo;
		if (activityMapExploreInfo != null && activityMapExploreInfo.ActivityId > 0)
		{
			_activityMapExploreInfo = activityMapExploreInfo;
			RefreshLimitedTimeMapExplorationRedDotState();
		}
	}

	public bool IsActivityMapExploreChallengeReceived(int activityId, int activityGroupId, int challengeId)
	{
		if (_activityMapExploreInfo == null || _activityMapExploreInfo.ActivityId != activityId)
		{
			return false;
		}
		foreach (ActivityGroup item in _activityMapExploreInfo.GainedActivityGroup)
		{
			if (item.ActivityGroupId == activityGroupId)
			{
				return item.ActivityChallengeIds.Count == 0 || item.ActivityChallengeIds.Contains(challengeId);
			}
		}
		return false;
	}

	public void UpdateActivityMultiDeviceInfo(ActivityMultiDeviceNtf activityMultiDeviceNtf)
	{
		ActivityMultiDeviceInfo activityMultiDeviceInfo = activityMultiDeviceNtf?.ActivityMultiDeviceInfo;
		if (activityMultiDeviceInfo != null && activityMultiDeviceInfo.ActivityId > 0)
		{
			_activityMultiDeviceInfo = activityMultiDeviceInfo;
		}
	}

	public bool IsActivityMultiDeviceChallengeReceived(int activityId, int activityGroupId, int challengeId)
	{
		if (_activityMultiDeviceInfo == null || _activityMultiDeviceInfo.ActivityId != activityId)
		{
			return false;
		}
		foreach (ActivityGroup item in _activityMultiDeviceInfo.GainedActivityGroup)
		{
			if (item.ActivityGroupId == activityGroupId)
			{
				return item.ActivityChallengeIds.Contains(challengeId);
			}
		}
		return false;
	}

	public void MarkCompletedActivityMapExploreChallengesReceived(int activityId, int activityGroupId)
	{
		if (!RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityGroupId, out var value))
		{
			return;
		}
		if (_activityMapExploreInfo == null || _activityMapExploreInfo.ActivityId != activityId)
		{
			_activityMapExploreInfo = new ActivityMapExploreInfo
			{
				ActivityId = activityId
			};
		}
		ActivityGroup activityGroup = _activityMapExploreInfo.GainedActivityGroup.Find((ActivityGroup item) => item.ActivityGroupId == activityGroupId);
		if (activityGroup == null)
		{
			activityGroup = new ActivityGroup
			{
				ActivityGroupId = activityGroupId
			};
			_activityMapExploreInfo.GainedActivityGroup.Add(activityGroup);
		}
		int[] challengeId = value.challengeId;
		foreach (int num2 in challengeId)
		{
			if (GetActivityChallengeIsComplete(num2) && !activityGroup.ActivityChallengeIds.Contains(num2))
			{
				activityGroup.ActivityChallengeIds.Add(num2);
			}
		}
		RefreshLimitedTimeMapExplorationRedDotState();
	}

	public void MarkCompletedActivityMainStoryChallengesReceived(int activityId, int activityGroupId)
	{
		if (!RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityGroupId, out var value))
		{
			return;
		}
		if (_activityMainStoryInfo == null || _activityMainStoryInfo.ActivityId != activityId)
		{
			_activityMainStoryInfo = new ActivityMainStoryInfo
			{
				ActivityId = activityId
			};
		}
		ActivityGroup activityGroup = _activityMainStoryInfo.GainedActivityGroup.Find((ActivityGroup x) => x.ActivityGroupId == activityGroupId);
		if (activityGroup == null)
		{
			activityGroup = new ActivityGroup
			{
				ActivityGroupId = activityGroupId
			};
			_activityMainStoryInfo.GainedActivityGroup.Add(activityGroup);
		}
		int[] challengeId = value.challengeId;
		foreach (int num2 in challengeId)
		{
			if (GetActivityChallengeIsComplete(num2) && !activityGroup.ActivityChallengeIds.Contains(num2))
			{
				activityGroup.ActivityChallengeIds.Add(num2);
			}
		}
		RefreshActivityMainStoryRedDotState();
	}

	private void OnTaskGroupFinish(BaseEventContent baseEventContent)
	{
		if (baseEventContent is TaskGroupFinshEvt taskGroupFinshEvt)
		{
			if (TryGetMainlineMotivationChallengeGroup(out var activityId, out var challengeGroup) && IsActivityChallengeTaskGroup(challengeGroup, taskGroupFinshEvt.taskGroupId))
			{
				RefreshActivityMainStoryRedDotState();
			}
			if (TryGetLimitedTimeMapExplorationChallengeGroup(out activityId, out var challengeGroup2) && IsActivityChallengeTaskGroup(challengeGroup2, taskGroupFinshEvt.taskGroupId))
			{
				RefreshLimitedTimeMapExplorationRedDotState();
			}
		}
	}

	public void RefreshActivityMainStoryRedDotState()
	{
		if (!TryGetMainlineMotivationChallengeGroup(out var activityId, out var challengeGroup))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_MainlineMotivation, active: false);
			return;
		}
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity) && GetActivityIsOpening(activityId);
		bool active = false;
		int[] challengeId = challengeGroup.challengeId;
		foreach (int num in challengeId)
		{
			if (flag && GetActivityChallengeIsComplete(num) && !IsActivityMainStoryChallengeReceived(activityId, challengeGroup.id, num))
			{
				active = true;
				break;
			}
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_MainlineMotivation, active);
	}

	public void RefreshLimitedTimeMapExplorationRedDotState()
	{
		if (!TryGetLimitedTimeMapExplorationChallengeGroup(out var activityId, out var challengeGroup))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_LimitedTimeMapExploration, active: false);
			return;
		}
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity) && GetActivityIsOpening(activityId);
		bool active = false;
		int[] challengeId = challengeGroup.challengeId;
		foreach (int num in challengeId)
		{
			if (flag && GetActivityChallengeIsComplete(num) && !IsActivityMapExploreChallengeReceived(activityId, challengeGroup.id, num))
			{
				active = true;
				break;
			}
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_LimitedTimeMapExploration, active);
	}

	private bool TryGetMainlineMotivationChallengeGroup(out int activityId, out ActivityChallengeGroup challengeGroup)
	{
		activityId = _activityMainStoryInfo?.ActivityId ?? 0;
		return TryGetActivityChallengeGroup(activityId, ActivityType.MainlineMotivation, out challengeGroup);
	}

	private bool TryGetLimitedTimeMapExplorationChallengeGroup(out int activityId, out ActivityChallengeGroup challengeGroup)
	{
		activityId = _activityMapExploreInfo?.ActivityId ?? 0;
		return TryGetActivityChallengeGroup(activityId, ActivityType.LimitedTimeMapExploration, out challengeGroup);
	}

	private bool TryGetActivityChallengeGroup(int activityId, ActivityType activityType, out ActivityChallengeGroup challengeGroup)
	{
		challengeGroup = null;
		if (activityId <= 0 || !RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value) || value.activityType != (int)activityType || value.activityChallengGroup == null || value.activityChallengGroup.Length != 1)
		{
			return false;
		}
		if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(value.activityChallengGroup[0], out challengeGroup) && challengeGroup.challengeId != null)
		{
			return challengeGroup.challengeId.Length == 4;
		}
		return false;
	}

	private bool IsActivityChallengeTaskGroup(ActivityChallengeGroup challengeGroup, int taskGroupId)
	{
		int[] challengeId = challengeGroup.challengeId;
		foreach (int key in challengeId)
		{
			if (RuntimeConfigs.data.activityChallengeDatas.TryGetValue(key, out var value) && value.missionGroupId == taskGroupId)
			{
				return true;
			}
		}
		return false;
	}

	public string GetActivityChallengeDescription(int activityChallengeId, int index = 0)
	{
		if (!RuntimeConfigs.data.activityChallengeDatas.TryGetValue(activityChallengeId, out var value))
		{
			return string.Empty;
		}
		if (!RuntimeConfigs.data.missionGroups.TryGetValue(value.missionGroupId, out var value2))
		{
			return string.Empty;
		}
		if (index >= value2.missionId.Length)
		{
			return string.Empty;
		}
		ACT.Config.Mission mission = RuntimeConfigs.data.missions[value2.missionId[index]];
		return CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
	}

	private void OnSystemOpen(BaseEventContent baseEventContent)
	{
		if (baseEventContent is SystemOpenEvt { unLock: not false, systemId: 3001 })
		{
			RefreshRedDot();
		}
	}

	public long GetLoopActivityEndTime(long starTime, int loopType)
	{
		switch ((ActivityLoopType)loopType)
		{
		case ActivityLoopType.Month:
		{
			System.DateTime now = TimeManager.ServerTime.Now;
			return new DateTimeOffset(new System.DateTime(now.Year, now.Year, now.Month + 1, 4, 0, 0, now.Kind), TimeSpan.Zero).ToUnixTimeMilliseconds();
		}
		case ActivityLoopType.FortyTwo:
			return starTime + 3628800000u;
		case ActivityLoopType.ThirtyFive:
			return starTime + 3024000000u;
		default:
			return starTime;
		}
	}

	public void RefreshRedDot()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
		{
			return;
		}
		foreach (KeyValuePair<int, ActivityCenterData> item in _activityCenterDataDic)
		{
			string nodeFullPath = RedDotPathDefine.ActivityCenter + $"|{item.Value.ActivityId}";
			Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, GetActivityTabRedpointState(item.Value.ActivityId));
		}
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_SevenDaySignIn, GetSevenDayRedDotState(GetSignInActivityId(SigninType.SevenDay)));
		RefreshActivityAbyssRedDotState();
		if (Model<ActivityTempleChallengeModel>.HasInstance() && Model<ActivityTempleChallengeModel>.Interface.DailyTempleChallengePhaseInfos != null)
		{
			Model<ActivityTempleChallengeModel>.Interface.RefreshRedDot();
		}
		if (_playerLevelActivityInfo != null && _playerLevelActivityInfo.ActivityId > 0 && RuntimeConfigs.data.activityDatas.TryGetValue(_playerLevelActivityInfo.ActivityId, out var value))
		{
			for (int i = 0; i < value.activityChallengGroup.Length; i++)
			{
				ActivityChallengeData data = CoreUtils.GetData(CoreUtils.GetData(value.activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups).challengeId[0], RuntimeConfigs.data.activityChallengeDatas);
				string nodeFullPath2 = RedDotPathDefine.Activity_PlayerLevel + $"|{data.id}";
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath2, CheckLevelChallengeHasReward(data.id));
			}
		}
		RefreshActivityCharacterTrialRedDotState();
		GameUtility.RefreshExploreChallengeRedDot();
		if (_activityLotteryInfo != null)
		{
			bool flag = false;
			foreach (KeyValuePair<int, ActivityLotteryInfo> lotteryInfo in _activityLotteryInfo.LotteryInfos)
			{
				flag |= lotteryInfo.Value.LeftGachaConut > 0;
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_DailyLottery, flag);
		}
		UpdateTenDaySignInRedDotState();
		Update35DaySignInRedDotState();
		RefreshActivitySkinTrialRedDotState();
		RefreshTotalRechargeRedDotState();
		RefreshOneTreatRedDotState();
		RefreshActivityMainStoryRedDotState();
		RefreshLimitedTimeMapExplorationRedDotState();
	}

	private void OnPlayerLevelChange(BaseEventContent obj)
	{
		int beforeLevel = G.localPlayer.playerExpData.beforeLevel;
		int curLevel = G.localPlayer.playerExpData.curLevel;
		if (beforeLevel != curLevel || curLevel > 30)
		{
			RefreshRedDot();
		}
	}

	public void UpdateActivitySignInInfo(ActivitSignInInfo activitySignInInfo)
	{
		if (activitySignInInfo != null)
		{
			if (_activitySignInInfoDic.TryGetValue(activitySignInInfo.ActivityId, out var _))
			{
				_activitySignInInfoDic[activitySignInInfo.ActivityId] = activitySignInInfo;
			}
			else
			{
				_activitySignInInfoDic.Add(activitySignInInfo.ActivityId, activitySignInInfo);
			}
			RefreshRedDot();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateActivitySignInInfo, new ActivitySignInInfo());
		}
	}

	public ActivitSignInInfo GetActivitySignInInfo(int activityId)
	{
		if (_activitySignInInfoDic.TryGetValue(activityId, out var value))
		{
			return value;
		}
		return null;
	}

	public int GetFixedCharacterId(int activityId)
	{
		ActivitSignInInfo activitySignInInfo = GetActivitySignInInfo(activityId);
		if (activitySignInInfo == null)
		{
			return -1;
		}
		ActivityData activityData = RuntimeConfigs.data.activityDatas[activityId];
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityData.activityChallengGroup[1]];
		ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
		if (activitySignInInfo.SignInGroups.TryGetValue(activityChallengeGroup.id, out var value))
		{
			if (value == null)
			{
				return -1;
			}
			int key = activityChallengeGroup.challengeId[0];
			if (value.ChallengeInfos[key].Rewards.Count <= 0)
			{
				return -1;
			}
			int num = value.ChallengeInfos[key].Rewards[0];
			for (int i = 0; i < activityChallengeData.challengeReward.Length; i++)
			{
				if (activityChallengeData.challengeReward[i] == num)
				{
					return activityChallengeData.extraParm[i];
				}
			}
		}
		return -1;
	}

	public bool GetFixedRewardIsReceive(int activityId)
	{
		ActivitSignInInfo activitySignInInfo = GetActivitySignInInfo(activityId);
		if (activitySignInInfo == null)
		{
			return false;
		}
		ActivityData activityData = RuntimeConfigs.data.activityDatas[activityId];
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityData.activityChallengGroup[1]];
		if (activitySignInInfo.SignInGroups.TryGetValue(activityChallengeGroup.id, out var value))
		{
			return value?.ChallengeInfos[activityChallengeGroup.challengeId[0]].IsGained ?? false;
		}
		return false;
	}

	public bool GetSevenDayRedDotState(int activityId)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
		{
			return false;
		}
		ActivitSignInInfo activitySignInInfo = GetActivitySignInInfo(activityId);
		if (activitySignInInfo == null)
		{
			return false;
		}
		if (!GetActivityIsOpening(activityId))
		{
			return false;
		}
		ActivityData activityData = RuntimeConfigs.data.activityDatas[activityId];
		for (int i = 0; i < activityData.activityChallengGroup.Length; i++)
		{
			ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityData.activityChallengGroup[i]];
			if (GetActivityChallengeIsComplete(activityChallengeGroup.challengeId[0]))
			{
				if (!activitySignInInfo.SignInGroups.TryGetValue(activityChallengeGroup.id, out var value))
				{
					return true;
				}
				if (!value.ChallengeInfos[activityChallengeGroup.challengeId[0]].IsGained)
				{
					return true;
				}
			}
		}
		return false;
	}

	public int GetSignInActivityId(SigninType signinType)
	{
		foreach (KeyValuePair<int, ActivitSignInInfo> item in _activitySignInInfoDic)
		{
			ActivityCenterData activityCenterData = GetActivityCenterData(item.Key);
			if (activityCenterData != null && activityCenterData.StaticActivityData.prefabType == (int)signinType)
			{
				return item.Key;
			}
		}
		return -1;
	}

	private ActivityCenterData GetPlayerLevelActivityInfo()
	{
		foreach (ActivityCenterData value in _activityCenterDataDic.Values)
		{
			if (value.StaticActivityData.activityType == 1)
			{
				return value;
			}
		}
		return null;
	}

	public void SendRewardGained(int activityId, int activityGroupId, int activityChallengeId, Action<ActivityGetLevelRewardAck> callBack)
	{
		G.service.SendActivityGainReward(activityId, activityGroupId, activityChallengeId, (ActivityGetLevelRewardAck b) =>
		{
			if (b != null)
			{
				if (_playerLevelActivityInfo != null && _playerLevelActivityInfo.ActivityId > 0 && RuntimeConfigs.data.activityDatas.TryGetValue(_playerLevelActivityInfo.ActivityId, out var value))
				{
					for (int i = 0; i < value.activityChallengGroup.Length; i++)
					{
						ActivityChallengeData data = CoreUtils.GetData(CoreUtils.GetData(value.activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups).challengeId[0], RuntimeConfigs.data.activityChallengeDatas);
						string nodeFullPath = RedDotPathDefine.Activity_PlayerLevel + $"|{data.id}";
						Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, CheckLevelChallengeHasReward(data.id));
					}
				}
				callBack?.Invoke(b);
			}
		});
	}

	public bool PlayerLevelHasReward()
	{
		if (_playerLevelActivityInfo == null)
		{
			return false;
		}
		int[] activityChallengGroup = CoreUtils.GetData(_playerLevelActivityInfo.ActivityId, RuntimeConfigs.data.activityDatas).activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			int[] challengeId = CoreUtils.GetData(activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups).challengeId;
			for (int j = 0; j < challengeId.Length; j++)
			{
				ActivityChallengeData data = CoreUtils.GetData(challengeId[j], RuntimeConfigs.data.activityChallengeDatas);
				if (CheckLevelChallengeHasReward(data.id))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool CheckPlayerLevel(ActivityChallengeData detailData)
	{
		return GetActivityChallengeIsComplete(detailData.id);
	}

	public bool CheckGotReward(int activityChallengeId)
	{
		if (_playerLevelActivityInfo == null)
		{
			return false;
		}
		if (G.localPlayer.playerLevelActivity.TryGetValue(_playerLevelActivityInfo.ActivityId, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i].ActivityChallengeIds.Contains(activityChallengeId))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool CheckLevelChallengeHasReward(int activityChallengeId)
	{
		ActivityChallengeData data = CoreUtils.GetData(activityChallengeId, RuntimeConfigs.data.activityChallengeDatas);
		if (CheckPlayerLevel(data))
		{
			return !CheckGotReward(activityChallengeId);
		}
		return false;
	}

	public void UpdateActivityTempleChallengeInInfo(ActivitTempleChallengeInfo activitTempleChallengeInfo)
	{
		if (activitTempleChallengeInfo != null)
		{
			_activityTempleChallengeInfo = activitTempleChallengeInfo;
		}
	}

	public ActivitTempleChallengeInfo GetActivitTempleChallengeInfo()
	{
		return _activityTempleChallengeInfo;
	}

	public void UpdateActivityAbyssInfo(ActivityAbyssNtf activityAbyssNtf)
	{
		if (activityAbyssNtf != null)
		{
			_activitAbyssInfo = activityAbyssNtf.ActivitAbyssInfo;
			ActivityCenterInfo activityCenterInfo = new ActivityCenterInfo();
			activityCenterInfo.activityId = _activitAbyssInfo.ActivityId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateActivity, activityCenterInfo);
			RefreshRedDot();
		}
	}

	public ActivitAbyssInfo GetActivitAbyssInfo()
	{
		return _activitAbyssInfo;
	}

	public ActivityRewardState GetActivityAbyssRewardState(int activityChallengeGroupId)
	{
		ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[activityChallengeGroupId];
		ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
		if (GetActivityChallengeIsComplete(activityChallengeData.id))
		{
			bool flag = false;
			for (int i = 0; i < _activitAbyssInfo.GainedActivityGroup.Count; i++)
			{
				if (_activitAbyssInfo.GainedActivityGroup[i].ActivityGroupId == activityChallengeGroupId)
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				return ActivityRewardState.Received;
			}
			return ActivityRewardState.Receive;
		}
		return ActivityRewardState.Lock;
	}

	public bool GetActivityAbyssRedDotState()
	{
		if (_activitAbyssInfo == null)
		{
			return false;
		}
		ActivityData activityData = RuntimeConfigs.data.activityDatas[_activitAbyssInfo.ActivityId];
		for (int i = 0; i < activityData.activityChallengGroup.Length; i++)
		{
			if (GetActivityAbyssRewardState(activityData.activityChallengGroup[i]) == ActivityRewardState.Receive)
			{
				return true;
			}
		}
		return false;
	}

	public void RefreshActivityAbyssRedDotState()
	{
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_Abyss, GetActivityAbyssRedDotState());
	}

	public void UpdateActivityRoleTrialInfo(ActivityRoleTrialNtf activityRoleTrialNtf)
	{
		if (activityRoleTrialNtf != null)
		{
			int activityId = activityRoleTrialNtf.ActivitRoleTrialInfo.ActivityId;
			if (_activityRoleTrialInfoDic.ContainsKey(activityId))
			{
				_activityRoleTrialInfoDic[activityId] = activityRoleTrialNtf.ActivitRoleTrialInfo;
			}
			else
			{
				_activityRoleTrialInfoDic.Add(activityId, activityRoleTrialNtf.ActivitRoleTrialInfo);
			}
			ActivityCenterInfo activityCenterInfo = new ActivityCenterInfo();
			activityCenterInfo.activityId = activityId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateActivity, activityCenterInfo);
			RefreshRedDot();
		}
	}

	public ActivitRoleTrialInfo GetActivityRoleTrialInfo(int activityId)
	{
		if (_activityRoleTrialInfoDic.TryGetValue(activityId, out var value))
		{
			return value;
		}
		return null;
	}

	public ActivityRewardState GetActivityCharacterTrialRewardState(int activityChallengeGroupId)
	{
		if (!RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityChallengeGroupId, out var value))
		{
			return ActivityRewardState.Lock;
		}
		if (!RuntimeConfigs.data.activityChallengeDatas.TryGetValue(value.challengeId[0], out var value2))
		{
			return ActivityRewardState.Lock;
		}
		if (!_activityRoleTrialInfoDic.TryGetValue(value2.activityId, out var value3))
		{
			return ActivityRewardState.Lock;
		}
		for (int i = 0; i < value3.GainedActivityGroup.Count; i++)
		{
			if (value3.GainedActivityGroup[i].ActivityGroupId == activityChallengeGroupId)
			{
				return ActivityRewardState.Received;
			}
		}
		if (GetActivityChallengeIsComplete(value2.id))
		{
			return ActivityRewardState.Receive;
		}
		return ActivityRewardState.Normal;
	}

	public bool GetCharacterTrialRedDotState(int activityId)
	{
		if (!_activityRoleTrialInfoDic.TryGetValue(activityId, out var value))
		{
			return false;
		}
		ActivityData activityData = RuntimeConfigs.data.activityDatas[value.ActivityId];
		for (int i = 0; i < activityData.activityChallengGroup.Length; i++)
		{
			if (GetActivityCharacterTrialRewardState(activityData.activityChallengGroup[i]) == ActivityRewardState.Receive)
			{
				return true;
			}
		}
		return false;
	}

	public void RefreshActivityCharacterTrialRedDotState()
	{
		foreach (KeyValuePair<int, ActivitRoleTrialInfo> item in _activityRoleTrialInfoDic)
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(string.Format(RedDotPathDefine.Activity_CharacterTrial, item.Key), GetCharacterTrialRedDotState(item.Key));
		}
	}

	public void UpdateActivityLotteryInfo(ActivityDailyLotteryNtf activityDailyLotteryNtf)
	{
		if (activityDailyLotteryNtf != null)
		{
			_activityLotteryInfo = activityDailyLotteryNtf.ActivityDailyLotteryInfo;
			ActivityCenterInfo activityCenterInfo = new ActivityCenterInfo();
			activityCenterInfo.activityId = _activityLotteryInfo.ActivityId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateActivity, activityCenterInfo);
			RefreshRedDot();
		}
	}

	public ActivityDailyLotteryInfo GetLotteryInfo()
	{
		return _activityLotteryInfo;
	}

	public void UpdateActivityKujiInfo(ActivityKujiNtf activityKujiNtf)
	{
		UpdateActivityKujiInfo(activityKujiNtf?.ActivityKujiInfo);
	}

	public void UpdateActivityKujiInfo(ActivityKujiInfo activityKujiInfo)
	{
		if (activityKujiInfo != null)
		{
			_activityKujiInfo = activityKujiInfo;
			ActivityCenterInfo activityCenterInfo = new ActivityCenterInfo();
			activityCenterInfo.activityId = _activityKujiInfo.ActivityId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateActivity, activityCenterInfo);
			RefreshOneTreatRedDotState();
		}
	}

	public ActivityKujiInfo GetOneTreatInfo()
	{
		return _activityKujiInfo;
	}

	public bool IsFinalDraw()
	{
		ActivityKujiInfo activityKujiInfo = _activityKujiInfo;
		if (activityKujiInfo == null)
		{
			return false;
		}
		ActivityData activityData = GetActivityCenterData(activityKujiInfo.ActivityId)?.StaticActivityData;
		int normalLotteryClaimedCount = OneTreatConfigUtility.GetNormalLotteryClaimedCount(activityData, activityKujiInfo);
		int normalLotteryPrizeCount = OneTreatConfigUtility.GetNormalLotteryPrizeCount(activityData);
		if (normalLotteryPrizeCount > 0)
		{
			return normalLotteryClaimedCount >= normalLotteryPrizeCount;
		}
		return false;
	}

	public bool CheckDailyLotteryHasReward()
	{
		if (_activityLotteryInfo == null)
		{
			return false;
		}
		foreach (KeyValuePair<int, ActivityLotteryInfo> lotteryInfo in _activityLotteryInfo.LotteryInfos)
		{
			if (lotteryInfo.Value.LeftGachaConut > 0)
			{
				return true;
			}
		}
		return false;
	}

	public void UpdateTenDaySignInRedDotState()
	{
		foreach (KeyValuePair<int, ActivitSignInInfo> item in _activitySignInInfoDic)
		{
			int key = item.Key;
			if (RuntimeConfigs.data.activityDatas[key].prefabType == 2)
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(string.Format(RedDotPathDefine.Activity_TenDaySignIn, key), GetTenDaySignInRedDotstate(key));
			}
		}
	}

	public bool GetTenDaySignInRedDotstate(int activityId)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity) || activityId <= 0)
		{
			return false;
		}
		RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value);
		for (int i = 0; i < value.activityChallengGroup.Length; i++)
		{
			RuntimeConfigs.data.activityChallengeGroups.TryGetValue(value.activityChallengGroup[i], out var value2);
			if (GetSignInGroupRewardState(activityId, value2) == ActivityRewardState.Receive)
			{
				return true;
			}
		}
		return false;
	}

	public ActivityRewardState GetSignInGroupRewardState(int activityId, ActivityChallengeGroup activityChallengeGroup)
	{
		if (activityChallengeGroup == null || activityChallengeGroup.challengeId.Length == 0)
		{
			return ActivityRewardState.Normal;
		}
		ActivitSignInInfo activitySignInInfo = GetActivitySignInInfo(activityId);
		if (activitySignInInfo == null)
		{
			return ActivityRewardState.Normal;
		}
		if (activitySignInInfo.SignInGroups.TryGetValue(activityChallengeGroup.id, out var value) && value.ChallengeInfos.Count > 0 && value.ChallengeInfos[activityChallengeGroup.challengeId[0]].IsGained)
		{
			return ActivityRewardState.Received;
		}
		if (GetActivityChallengeIsComplete(activityChallengeGroup.challengeId[0]))
		{
			return ActivityRewardState.Receive;
		}
		return ActivityRewardState.Normal;
	}

	public int GetDoubleDungeonActivityId()
	{
		if (G.localPlayer == null)
		{
			return 0;
		}
		foreach (KeyValuePair<int, ActivitDoubleDungeonInfo> activitDoubleDungeonInfo in G.localPlayer.activitDoubleDungeonInfos)
		{
			if (GetActivityIsOpening(activitDoubleDungeonInfo.Key))
			{
				return activitDoubleDungeonInfo.Key;
			}
		}
		return 0;
	}

	public ActivitDoubleDungeonInfo GetDoubleDungeonInfo(int activityId)
	{
		if (G.localPlayer == null || activityId == 0)
		{
			return null;
		}
		G.localPlayer.activitDoubleDungeonInfos.TryGetValue(activityId, out var value);
		return value;
	}

	public (int, int) GetTodayLeftDoubleRewardCount(int activityId)
	{
		ActivitDoubleDungeonInfo doubleDungeonInfo = GetDoubleDungeonInfo(activityId);
		if (doubleDungeonInfo != null)
		{
			int key = 0;
			if (RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value))
			{
				int[] activityChallengGroup = value.activityChallengGroup;
				for (int i = 0; i < activityChallengGroup.Length; i++)
				{
					key = activityChallengGroup[i];
				}
			}
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(key, out var value2))
			{
				int limitTimes = value2.limitTimes;
				if (doubleDungeonInfo.DungeonInfo.TryGetValue(key, out var value3))
				{
					int finishCount = value3.FinishCount;
					return (limitTimes - finishCount, limitTimes);
				}
				return (limitTimes, limitTimes);
			}
		}
		return (0, 0);
	}

	public List<int> GetChallengeList(int activityId)
	{
		if (GetDoubleDungeonInfo(activityId) != null)
		{
			int key = 0;
			if (RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value))
			{
				int[] activityChallengGroup = value.activityChallengGroup;
				for (int i = 0; i < activityChallengGroup.Length; i++)
				{
					key = activityChallengGroup[i];
				}
			}
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(key, out var value2))
			{
				return value2.challengeId.ToList();
			}
		}
		return null;
	}

	public int GetDoubleDungeonChallengeGroup(int activityId)
	{
		if (GetDoubleDungeonInfo(activityId) != null && RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value))
		{
			int[] activityChallengGroup = value.activityChallengGroup;
			int num = 0;
			if (num < activityChallengGroup.Length)
			{
				return activityChallengGroup[num];
			}
		}
		return 0;
	}

	public List<int> GetRaidTypeList(int activityId)
	{
		List<int> challengeList = GetChallengeList(activityId);
		if (challengeList == null)
		{
			return null;
		}
		List<int> list = new List<int>(challengeList.Count);
		foreach (int item in challengeList)
		{
			if (RuntimeConfigs.data.activityChallengeDatas.TryGetValue(item, out var value) && value.extraParm != null && value.extraParm.Length != 0)
			{
				list.Add(value.extraParm[0]);
			}
		}
		return list;
	}

	public void Update35DaySignInRedDotState()
	{
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_ThirtyFiveDaySignIn, Get35DaySignInRedDotstate(GetSignInActivityId(SigninType.ThirtyFiveDay)));
	}

	public bool Get35DaySignInRedDotstate(int activityId)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity) || activityId <= 0 || !RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value))
		{
			return false;
		}
		for (int i = 0; i < value.activityChallengGroup.Length; i++)
		{
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(value.activityChallengGroup[i], out var value2) && GetSignInGroupRewardState(activityId, value2) == ActivityRewardState.Receive)
			{
				return true;
			}
		}
		return false;
	}

	public void UpdateActivitySkinTrialInfo(ActivitSkinTrialInfo activitSkinTrialInfo)
	{
		if (activitSkinTrialInfo != null)
		{
			if (_activitySkinTrialInfoDic.TryGetValue(activitSkinTrialInfo.ActivityId, out var _))
			{
				_activitySkinTrialInfoDic[activitSkinTrialInfo.ActivityId] = activitSkinTrialInfo;
			}
			else
			{
				_activitySkinTrialInfoDic.Add(activitSkinTrialInfo.ActivityId, activitSkinTrialInfo);
			}
		}
	}

	public ActivitSkinTrialInfo GetActivitySkinTrialInfo(int activityId)
	{
		if (_activitySkinTrialInfoDic.TryGetValue(activityId, out var value))
		{
			return value;
		}
		return null;
	}

	public void RefreshActivitySkinTrialRedDotState()
	{
		foreach (KeyValuePair<int, ActivitSkinTrialInfo> item in _activitySkinTrialInfoDic)
		{
			int key = item.Key;
			Singleton<RedDotManager>.instance.SetLeafNodeActive(string.Format(RedDotPathDefine.Activity_SkinTrial, key), GetSkinTrialRedDotState(key));
		}
	}

	public bool GetSkinTrialRedDotState(int activityId)
	{
		if (!_activitySkinTrialInfoDic.TryGetValue(activityId, out var value))
		{
			return false;
		}
		ActivityCenterData activityCenterData = GetActivityCenterData(value.ActivityId);
		if (activityCenterData == null)
		{
			return false;
		}
		for (int i = 0; i < activityCenterData.StaticActivityData.activityChallengGroup.Length; i++)
		{
			int challengeGroupId = activityCenterData.StaticActivityData.activityChallengGroup[i];
			ActivityChallengeGroup activityChallengeGroup = RuntimeConfigs.data.activityChallengeGroups[challengeGroupId];
			ActivityChallengeData activityChallengeData = RuntimeConfigs.data.activityChallengeDatas[activityChallengeGroup.challengeId[0]];
			if (value.GainedActivityGroup.Find((ActivityGroup x) => x.ActivityGroupId == challengeGroupId) == null && Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(activityChallengeData.missionGroupId))
			{
				return true;
			}
		}
		return false;
	}

	public void UpdateActivityTotalRechargeInfo(ActivityTotalRechargeInfo activityTotalRechargeInfo)
	{
		if (activityTotalRechargeInfo != null && activityTotalRechargeInfo.ActivityId > 0)
		{
			_activityTotalRechargeInfo = activityTotalRechargeInfo;
			RefreshTotalRechargeRedDotState();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateActivity, new ActivityCenterInfo
			{
				activityId = _activityTotalRechargeInfo.ActivityId
			});
		}
	}

	public ActivityTotalRechargeInfo GetActivityTotalRechargeInfo(int activityId)
	{
		if (_activityTotalRechargeInfo == null || _activityTotalRechargeInfo.ActivityId != activityId)
		{
			return null;
		}
		return _activityTotalRechargeInfo;
	}

	public void RefreshTotalRechargeRedDotState()
	{
		if (_activityTotalRechargeInfo == null)
		{
			return;
		}
		ActivityData data = CoreUtils.GetData(_activityTotalRechargeInfo.ActivityId, RuntimeConfigs.data.activityDatas);
		if (data?.activityChallengGroup == null)
		{
			return;
		}
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity) && GetActivityIsOpening(_activityTotalRechargeInfo.ActivityId);
		int[] activityChallengGroup = data.activityChallengGroup;
		foreach (int key in activityChallengGroup)
		{
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(key, out var value) && value.challengeId != null)
			{
				int[] challengeId = value.challengeId;
				foreach (int num in challengeId)
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(string.Format(RedDotPathDefine.Activity_TotalRechargeItem, num), flag && IsTotalRechargeChallengeClaimable(value.id, num));
				}
			}
		}
	}

	private bool IsTotalRechargeChallengeClaimable(int groupId, int challengeId)
	{
		if (_activityTotalRechargeInfo == null || !RuntimeConfigs.data.activityChallengeDatas.TryGetValue(challengeId, out var value) || value.extraParm == null || value.extraParm.Length == 0)
		{
			return false;
		}
		if (_activityTotalRechargeInfo.TotalRecharge >= value.extraParm[0])
		{
			return !IsTotalRechargeChallengeReceived(groupId, challengeId);
		}
		return false;
	}

	private bool IsTotalRechargeChallengeReceived(int groupId, int challengeId)
	{
		foreach (ActivityGroup item in _activityTotalRechargeInfo.GainedActivityGroup)
		{
			if (item.ActivityGroupId == groupId && item.ActivityChallengeIds.Contains(challengeId))
			{
				return true;
			}
		}
		return false;
	}

	public void RefreshOneTreatRedDotState()
	{
		bool oneTreatTaskRewardRedDotState = GetOneTreatTaskRewardRedDotState();
		bool oneTreatMainRedDotState = GetOneTreatMainRedDotState();
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_OneTreatTask, oneTreatTaskRewardRedDotState);
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Activity_OneTreatMain, oneTreatMainRedDotState);
	}

	public bool GetOneTreatRedDotState()
	{
		if (!GetOneTreatTaskRewardRedDotState())
		{
			return GetOneTreatMainRedDotState();
		}
		return true;
	}

	public bool GetOneTreatTaskRewardRedDotState()
	{
		if (!GetActivityIsOpening((_activityKujiInfo != null) ? _activityKujiInfo.ActivityId : 0) || IsFinalDraw())
		{
			return false;
		}
		ActivityData oneTreatActivityData = GetOneTreatActivityData();
		if (oneTreatActivityData?.activityChallengGroup == null)
		{
			return false;
		}
		int[] activityChallengGroup = oneTreatActivityData.activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			ActivityChallengeGroup data = CoreUtils.GetData(activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups);
			if (data?.challengeId == null)
			{
				continue;
			}
			int[] challengeId = data.challengeId;
			foreach (int challengeId2 in challengeId)
			{
				if (GetOneTreatTaskRewardCanReceive(challengeId2))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool GetOneTreatTaskRewardCanReceive(int challengeId)
	{
		if (challengeId <= 0 || GetOneTreatTaskRewardReceivedState(challengeId))
		{
			return false;
		}
		return GetActivityChallengeIsComplete(challengeId);
	}

	public bool GetOneTreatTaskRewardReceivedState(int challengeId)
	{
		if (challengeId <= 0)
		{
			return false;
		}
		if (_activityKujiInfo == null)
		{
			return false;
		}
		for (int i = 0; i < _activityKujiInfo.GainedActivityGroup.Count; i++)
		{
			ActivityGroup activityGroup = _activityKujiInfo.GainedActivityGroup[i];
			if (activityGroup != null && activityGroup.ActivityChallengeIds.Contains(challengeId))
			{
				return true;
			}
		}
		return false;
	}

	public void MarkOneTreatTaskRewardReceived(int challengeId)
	{
		if (challengeId > 0)
		{
			int oneTreatChallengeGroupId = GetOneTreatChallengeGroupId(challengeId);
			MarkOneTreatTaskGroupRewardReceived(oneTreatChallengeGroupId, new List<int> { challengeId });
		}
	}

	public void MarkOneTreatTaskGroupRewardReceived(int groupId, IList<int> challengeIds)
	{
		if (groupId <= 0)
		{
			return;
		}
		ActivityKujiInfo activityKujiInfo = _activityKujiInfo;
		if (activityKujiInfo == null)
		{
			return;
		}
		ActivityGroup activityGroup = null;
		for (int i = 0; i < activityKujiInfo.GainedActivityGroup.Count; i++)
		{
			ActivityGroup activityGroup2 = activityKujiInfo.GainedActivityGroup[i];
			if (activityGroup2 != null && activityGroup2.ActivityGroupId == groupId)
			{
				activityGroup = activityGroup2;
				break;
			}
		}
		if (activityGroup == null)
		{
			activityGroup = new ActivityGroup
			{
				ActivityGroupId = groupId
			};
			activityKujiInfo.GainedActivityGroup.Add(activityGroup);
		}
		if (challengeIds != null)
		{
			for (int j = 0; j < challengeIds.Count; j++)
			{
				int num = challengeIds[j];
				if (num > 0 && !activityGroup.ActivityChallengeIds.Contains(num))
				{
					activityGroup.ActivityChallengeIds.Add(num);
				}
			}
		}
		DispatchOneTreatActivityUpdate();
		RefreshOneTreatRedDotState();
	}

	public int GetOneTreatPrizeDrawnCount(int lotteryConfigId)
	{
		if (lotteryConfigId <= 0 || _activityKujiInfo == null)
		{
			return 0;
		}
		if (!_activityKujiInfo.PrizeInfo.TryGetValue(lotteryConfigId, out var value))
		{
			return 0;
		}
		return Math.Max(0, value);
	}

	public void MarkOneTreatPrizeDrawn(int lotteryConfigId)
	{
		if (lotteryConfigId > 0)
		{
			ActivityKujiInfo activityKujiInfo = _activityKujiInfo;
			if (activityKujiInfo != null)
			{
				activityKujiInfo.PrizeInfo[lotteryConfigId] = GetOneTreatPrizeDrawnCount(lotteryConfigId) + 1;
				DispatchOneTreatActivityUpdate();
				MarkOneTreatMainRedDotRead();
			}
		}
	}

	public int GetOneTreatReceivedTaskRewardCount()
	{
		ActivityData oneTreatActivityData = GetOneTreatActivityData();
		if (oneTreatActivityData?.activityChallengGroup == null)
		{
			return 0;
		}
		int num = 0;
		int[] activityChallengGroup = oneTreatActivityData.activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			ActivityChallengeGroup data = CoreUtils.GetData(activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups);
			if (data?.challengeId == null)
			{
				continue;
			}
			int[] challengeId = data.challengeId;
			foreach (int challengeId2 in challengeId)
			{
				if (GetOneTreatTaskRewardReceivedState(challengeId2))
				{
					num++;
				}
			}
		}
		return num;
	}

	public void MarkOneTreatMainRedDotRead()
	{
		_oneTreatObservedTicketCount = GetOneTreatTicketCount();
		_oneTreatUnacknowledgedTicketCount = 0;
		_oneTreatMainRedDotDirty = false;
		RefreshOneTreatRedDotState();
	}

	public void MarkOneTreatMainRedDotDirty()
	{
		if (GetActivityIsOpening((_activityKujiInfo != null) ? _activityKujiInfo.ActivityId : 0))
		{
			if (_oneTreatUnacknowledgedTicketCount <= 0)
			{
				_oneTreatUnacknowledgedTicketCount = 1;
			}
			_oneTreatMainRedDotDirty = true;
			RefreshOneTreatRedDotState();
		}
	}

	private bool GetOneTreatMainRedDotState()
	{
		if (!GetActivityIsOpening((_activityKujiInfo != null) ? _activityKujiInfo.ActivityId : 0))
		{
			return false;
		}
		if (IsFinalDraw())
		{
			_oneTreatUnacknowledgedTicketCount = 0;
			_oneTreatMainRedDotDirty = false;
			if (GetOneTreatTicketItemId() > 0)
			{
				_oneTreatObservedTicketCount = GetOneTreatTicketCount();
			}
			return false;
		}
		RefreshOneTreatTicketCountState();
		return _oneTreatMainRedDotDirty;
	}

	private void RefreshOneTreatTicketCountState()
	{
		if (GetOneTreatTicketItemId() <= 0)
		{
			return;
		}
		int oneTreatTicketCount = GetOneTreatTicketCount();
		if (_oneTreatObservedTicketCount < 0)
		{
			_oneTreatObservedTicketCount = oneTreatTicketCount;
			return;
		}
		int num = oneTreatTicketCount - _oneTreatObservedTicketCount;
		if (num > 0)
		{
			_oneTreatUnacknowledgedTicketCount += num;
		}
		else if (num < 0)
		{
			_oneTreatUnacknowledgedTicketCount = Math.Max(0, _oneTreatUnacknowledgedTicketCount + num);
		}
		_oneTreatObservedTicketCount = oneTreatTicketCount;
		_oneTreatMainRedDotDirty = _oneTreatUnacknowledgedTicketCount > 0;
	}

	private void OnOneTreatTicketCountChanged(BaseEventContent content)
	{
		if (_oneTreatObservedTicketCount >= 0 && _activityKujiInfo != null && IsOneTreatTicketCountChange(content) && GetOneTreatTicketCount() < _oneTreatObservedTicketCount)
		{
			RefreshOneTreatRedDotState();
		}
	}

	private bool IsOneTreatTicketCountChange(BaseEventContent content)
	{
		int oneTreatTicketItemId = GetOneTreatTicketItemId();
		if (oneTreatTicketItemId <= 0)
		{
			return false;
		}
		if (content == null)
		{
			return true;
		}
		if (content is PlayerAttributeChangeEvt playerAttributeChangeEvt)
		{
			return playerAttributeChangeEvt.id == oneTreatTicketItemId;
		}
		if (content is ItemChangeEvt { ItemProxies: var itemProxies })
		{
			if (itemProxies == null)
			{
				return false;
			}
			for (int i = 0; i < itemProxies.Count; i++)
			{
				ItemUnifierProxy itemUnifierProxy = itemProxies[i];
				if (itemUnifierProxy != null && itemUnifierProxy.Id == oneTreatTicketItemId)
				{
					return true;
				}
			}
			return false;
		}
		return false;
	}

	private int GetOneTreatTicketItemId()
	{
		return OneTreatConfigUtility.GetTicketItemId(GetOneTreatActivityData());
	}

	private int GetOneTreatTicketCount()
	{
		int oneTreatTicketItemId = GetOneTreatTicketItemId();
		if (oneTreatTicketItemId <= 0 || G.localPlayer == null)
		{
			return 0;
		}
		try
		{
			return G.localPlayer.GetCountById(oneTreatTicketItemId);
		}
		catch (Exception)
		{
			return 0;
		}
	}

	private void DispatchOneTreatActivityUpdate()
	{
		if (_activityKujiInfo != null)
		{
			ActivityCenterInfo activityCenterInfo = new ActivityCenterInfo();
			activityCenterInfo.activityId = _activityKujiInfo.ActivityId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateActivity, activityCenterInfo);
		}
	}

	private int GetOneTreatChallengeGroupId(int challengeId)
	{
		ActivityData oneTreatActivityData = GetOneTreatActivityData();
		if (oneTreatActivityData?.activityChallengGroup == null)
		{
			return 0;
		}
		int[] activityChallengGroup = oneTreatActivityData.activityChallengGroup;
		foreach (int num in activityChallengGroup)
		{
			if (IsOneTreatChallengeInGroup(challengeId, num))
			{
				return num;
			}
		}
		return 0;
	}

	private bool IsOneTreatChallengeInGroup(int challengeId, int groupId)
	{
		if (challengeId <= 0 || groupId <= 0)
		{
			return false;
		}
		ActivityChallengeGroup data = CoreUtils.GetData(groupId, RuntimeConfigs.data.activityChallengeGroups);
		if (data?.challengeId == null)
		{
			return false;
		}
		for (int i = 0; i < data.challengeId.Length; i++)
		{
			if (data.challengeId[i] == challengeId)
			{
				return true;
			}
		}
		return false;
	}

	private ActivityData GetOneTreatActivityData()
	{
		int num = ((_activityKujiInfo != null) ? _activityKujiInfo.ActivityId : 0);
		if (num <= 0)
		{
			return null;
		}
		ActivityCenterData activityCenterData = GetActivityCenterData(num);
		if (activityCenterData?.StaticActivityData != null)
		{
			return activityCenterData.StaticActivityData;
		}
		return CoreUtils.GetData(num, RuntimeConfigs.data.activityDatas);
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (JumpModel.IsCurrentWorldChallangeNormal())
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Hide
			};
		}
		JumpResult result = new JumpResult
		{
			ShowType = JumpResult.JumpShowType.Hide
		};
		if (!JumpModel.UIJumpIdToUITypeMap.TryGetValue(jumpData.Params[0], out var value))
		{
			return result;
		}
		if (value.Item1 != 189)
		{
			return result;
		}
		int num = jumpData.Params[1];
		if (num <= 0)
		{
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
			{
				result.ShowType = JumpResult.JumpShowType.Forbidden;
				result.Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Activity);
				return result;
			}
			result.ShowType = JumpResult.JumpShowType.CanJump;
			return result;
		}
		if (RuntimeConfigs.data.activityDatas.TryGetValue(num, out var _))
		{
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
			{
				result.ShowType = JumpResult.JumpShowType.Forbidden;
				result.Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Activity);
				return result;
			}
			if (CheckIsCanJump(num) && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
			{
				result.ShowType = JumpResult.JumpShowType.CanJump;
			}
			else
			{
				result.ShowType = JumpResult.JumpShowType.Hide;
			}
			return result;
		}
		return result;
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		if (JumpModel.UIJumpIdToUITypeMap.TryGetValue(jumpData.Params[0], out var value) && value.Item1 == 189)
		{
			int num = jumpData.Params[1];
			ActivityData value2;
			if (num <= 0)
			{
				OpenActivityID = -1;
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYCENTER);
			}
			else if (RuntimeConfigs.data.activityDatas.TryGetValue(num, out value2))
			{
				ActivityCenterViewData activityCenterViewData = new ActivityCenterViewData();
				activityCenterViewData.ActivityId = num;
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYCENTER, activityCenterViewData);
			}
		}
	}

	private bool CheckIsCanJump(int activityId)
	{
		if (!_activityCenterDataDic.TryGetValue(activityId, out var value) || !value.IsVaild())
		{
			return false;
		}
		return true;
	}
}
