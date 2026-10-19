using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;

namespace ACT.Model;

public class ActivityTempleChallengeModel : Model<ActivityTempleChallengeModel>
{
	public class ActivitTempleChallengeModelPhaseInfo
	{
		public int Id;

		public ActivityChallengeGroup ActivityChallengeGroupData;

		public bool UnLocked;

		public int DaysLeft;

		public bool IsClear;
	}

	public static int ActivityId = 1006;

	public long activityendTimeStamp;

	private string _timerFormat;

	private string _Lefttime;

	private ActivitTempleChallengeInfo _activityTempleChallengeInfo;

	public Dictionary<int, ActivitTempleChallengeModelPhaseInfo> DailyTempleChallengePhaseInfos;

	public ActivityData _activityData { get; set; }

	protected override void Init()
	{
		DailyTempleChallengePhaseInfos = new Dictionary<int, ActivitTempleChallengeModelPhaseInfo>();
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 609);
		string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 610);
		string localizeString3 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 623);
		_timerFormat = "{0}" + localizeString + "{1}" + localizeString2 + "{2}" + localizeString3;
		RefreshActivityData();
		RefreshDailyTempleChallengePhaseInfos();
		RefreshTimeLimit();
	}

	protected override void UnInit()
	{
	}

	public void RefreshActivityData()
	{
		_activityTempleChallengeInfo = Model<ActivityCenterModel>.Interface.GetActivitTempleChallengeInfo();
		_activityData = RuntimeConfigs.data.activityDatas[_activityTempleChallengeInfo.ActivityId];
		if (RuntimeConfigs.data.activityDatas.TryGetValue(ActivityId, out var value))
		{
			activityendTimeStamp = value.endTimeStamp;
		}
	}

	public void RefreshDailyTempleChallengePhaseInfos()
	{
		DailyTempleChallengePhaseInfos.Clear();
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(ActivityId);
		if (activityCenterData == null || !activityCenterData.IsVaild())
		{
			return;
		}
		int[] activityChallengGroup = activityCenterData.StaticActivityData.activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityChallengGroup[i], out var value))
			{
				ActivitTempleChallengeModelPhaseInfo activitTempleChallengeModelPhaseInfo = new ActivitTempleChallengeModelPhaseInfo();
				activitTempleChallengeModelPhaseInfo.Id = activityChallengGroup[i];
				activitTempleChallengeModelPhaseInfo.ActivityChallengeGroupData = value;
				activitTempleChallengeModelPhaseInfo.UnLocked = activityCenterData.GetActivityChallengeGroupIsOpening(activitTempleChallengeModelPhaseInfo.Id);
				if (!activitTempleChallengeModelPhaseInfo.UnLocked)
				{
					ActivityGroupData activityGroupData = activityCenterData.GetActivityGroupData(activitTempleChallengeModelPhaseInfo.Id);
					long nowTimestamp = TimeManager.ServerTime.NowTimestamp;
					long startTime = activityGroupData.StartTime;
					double a = (double)(Math.Abs(nowTimestamp - startTime) / 1000) / 86400.0;
					activitTempleChallengeModelPhaseInfo.DaysLeft = (int)Math.Ceiling(a);
				}
				RuntimeConfigs.data.raidEntranceDatas.TryGetValue(activitTempleChallengeModelPhaseInfo.ActivityChallengeGroupData.id, out var value2);
				if (value2 == null)
				{
					break;
				}
				activitTempleChallengeModelPhaseInfo.IsClear = IsClear(value2.raidId[0]);
				DailyTempleChallengePhaseInfos.Add(i, activitTempleChallengeModelPhaseInfo);
			}
		}
	}

	public void RefreshTimeLimit()
	{
		int num = (int)((activityendTimeStamp - TimeManager.ServerTime.NowTimestamp) / 1000);
		if (num >= 0)
		{
			int num2 = num / 86400;
			int num3 = (num - num2 * 86400) / 3600;
			int num4 = (num - num2 * 86400 - num3 * 3600) / 60;
			_Lefttime = string.Format(_timerFormat, num2, num3, num4);
		}
		else
		{
			_Lefttime = "";
		}
	}

	public string GetTimeLeft()
	{
		RefreshTimeLimit();
		return _Lefttime;
	}

	public bool IsClear(int challengeId)
	{
		if (!Model<RaidModel>.HasInstance())
		{
			Model<RaidModel>.CreateModel();
		}
		return Model<RaidModel>.Interface.GetRaidCleanNum(challengeId) > 0;
	}

	public ActivitTempleChallengeModelPhaseInfo GetActivitTempleChallengeInfo(int index)
	{
		ActivitTempleChallengeModelPhaseInfo activitTempleChallengeModelPhaseInfo = DailyTempleChallengePhaseInfos[index];
		if (activitTempleChallengeModelPhaseInfo != null)
		{
			return activitTempleChallengeModelPhaseInfo;
		}
		return null;
	}

	public bool GetActivityChallengeRedpointState(int challengeId)
	{
		if (G.localPlayer.redPoints.ActivityChallenges.TryGetValue(challengeId, out var value))
		{
			return value;
		}
		return false;
	}

	public bool GetActivityRedpointState()
	{
		foreach (KeyValuePair<int, ActivitTempleChallengeModelPhaseInfo> dailyTempleChallengePhaseInfo in DailyTempleChallengePhaseInfos)
		{
			ActivitTempleChallengeModelPhaseInfo value = dailyTempleChallengePhaseInfo.Value;
			if (value.ActivityChallengeGroupData.challengeId.Length != 0)
			{
				int challengeId = value.ActivityChallengeGroupData.challengeId[0];
				if (GetActivityChallengeRedpointState(challengeId))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void RefreshRedDot()
	{
		if (!Model<ActivityCenterModel>.Interface.GetActivityIsOpening(ActivityId))
		{
			return;
		}
		foreach (KeyValuePair<int, ActivitTempleChallengeModelPhaseInfo> dailyTempleChallengePhaseInfo in DailyTempleChallengePhaseInfos)
		{
			ActivitTempleChallengeModelPhaseInfo value = dailyTempleChallengePhaseInfo.Value;
			if (value.ActivityChallengeGroupData.challengeId.Length != 0)
			{
				int num = value.ActivityChallengeGroupData.challengeId[0];
				string nodeFullPath = RedDotPathDefine.Activity_Temple + $"|{num}";
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, GetActivityChallengeRedpointState(num));
			}
		}
	}
}
