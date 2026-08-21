using System;
using System.ComponentModel;

namespace Ase;

public static class RankDefinition
{
	public enum RankState
	{
		[Description("无效配置")]
		InvalidConfig,
		[Description("未开始")]
		NotStarted,
		[Description("进行中")]
		InProgress,
		[Description("已结算")]
		AlreadySettled,
		[Description("已下架")]
		Removed
	}

	public struct HeroChallengeData
	{
		public int HeroId;

		public int Rank;

		public int Score;
	}

	public static RankState GetRankState(string startTime, string endTime, string offTime)
	{
		if (string.IsNullOrEmpty(startTime) && string.IsNullOrEmpty(endTime) && string.IsNullOrEmpty(offTime))
		{
			return RankState.InProgress;
		}
		DateTime dateTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerDateTime() ?? DateTime.Now;
		if (TimeService.StringToDateTime(startTime, out var dateTime2) && TimeService.StringToDateTime(endTime, out var dateTime3) && TimeService.StringToDateTime(offTime, out var dateTime4))
		{
			if (DateTime.Compare(dateTime2, dateTime3) >= 0 || DateTime.Compare(dateTime3, dateTime4) > 0)
			{
				return RankState.InvalidConfig;
			}
			if (DateTime.Compare(dateTime2, dateTime) > 0)
			{
				return RankState.NotStarted;
			}
			if (DateTime.Compare(dateTime, dateTime3) >= 0)
			{
				if (DateTime.Compare(DateTime.Now, dateTime4) < 0)
				{
					return RankState.AlreadySettled;
				}
				return RankState.Removed;
			}
			return RankState.InProgress;
		}
		return RankState.InvalidConfig;
	}

	public static bool CheckSuitBoxCopyRank(int type)
	{
		if (type != 1)
		{
			return type == 4;
		}
		return true;
	}

	public static bool CheckRaceCopyRank(int type)
	{
		if (type != 2)
		{
			return type == 5;
		}
		return true;
	}

	public static bool CheckHeroChallengeRank(int type)
	{
		if (type != 3 && type != 6)
		{
			return type == 10;
		}
		return true;
	}

	public static bool CheckGuildSevenDayActiveRank(int type)
	{
		return type == GetGuildActiveRankType();
	}

	public static bool CheckGuildCopyRank(int type)
	{
		return type == GetGuildCopyRankType();
	}

	public static bool CheckChallengeCopyRank(int type)
	{
		return type == GetChallengeCopyRankType();
	}

	public static bool CheckTowerRank(int type)
	{
		return type == GetTowerCopyRankType();
	}

	public static int GetGuildActiveRankType()
	{
		return 7;
	}

	public static int GetGuildActiveRankTypeId()
	{
		return GameEntry.DataTable.GetDataRow((DRRankType p) => p.Type == GetGuildActiveRankType())?.Id ?? 0;
	}

	public static int GetGuildCopyRankType()
	{
		return 8;
	}

	public static int GetGuildCopyRankTypeId()
	{
		return GameEntry.DataTable.GetDataRow((DRRankType p) => p.Type == GetGuildCopyRankType())?.Id ?? 0;
	}

	public static int GetChallengeCopyRankType()
	{
		return 9;
	}

	public static int GetTowerCopyRankType()
	{
		return 11;
	}
}
