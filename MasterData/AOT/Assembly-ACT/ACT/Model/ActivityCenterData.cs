using System;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;

namespace ACT.Model;

public class ActivityCenterData
{
	public int ActivityId;

	public OperationalActivityData ServerActivityData;

	public ActivityData StaticActivityData;

	public Action OnUpdateData;

	public ActivityCenterData(OperationalActivityData operationalActivityData)
	{
		if (operationalActivityData != null)
		{
			ActivityId = operationalActivityData.ActivityId;
			ServerActivityData = operationalActivityData;
			StaticActivityData = CoreUtils.GetData(operationalActivityData.ActivityId, RuntimeConfigs.data.activityDatas);
		}
	}

	public void UpdateData(OperationalActivityData operationalActivityData)
	{
		if (operationalActivityData != null)
		{
			ServerActivityData = operationalActivityData;
			OnUpdateData?.Invoke();
		}
	}

	public bool IsVaild()
	{
		if (ServerActivityData == null || StaticActivityData == null)
		{
			return false;
		}
		if (!Model<ActivityCenterModel>.Interface.GetActivityIsOpening(ServerActivityData))
		{
			return false;
		}
		return true;
	}

	public long GetRemainingTime()
	{
		if (!IsVaild())
		{
			return -1L;
		}
		return ServerActivityData.EndTime - TimeManager.ServerTime.NowTimestamp;
	}

	public bool GetActivityChallengeGroupIsOpening(int activityChallengeGroupId)
	{
		if (!IsVaild())
		{
			return false;
		}
		if (ServerActivityData.Groups.TryGetValue(activityChallengeGroupId, out var value) && TimeManager.IsInTimeRange(value.StartTime, value.EndTime))
		{
			return true;
		}
		return false;
	}

	public long GetActivityChallengeGroupRemainingTime(int activityChallengeGroupId)
	{
		if (!GetActivityChallengeGroupIsOpening(activityChallengeGroupId))
		{
			return -1L;
		}
		if (ServerActivityData.Groups.TryGetValue(activityChallengeGroupId, out var value))
		{
			return value.EndTime - TimeManager.ServerTime.NowTimestamp;
		}
		return -1L;
	}

	public ActivityGroupData GetActivityGroupData(int activityChallengeGroupId)
	{
		if (ServerActivityData.Groups.TryGetValue(activityChallengeGroupId, out var value))
		{
			return value;
		}
		return null;
	}
}
