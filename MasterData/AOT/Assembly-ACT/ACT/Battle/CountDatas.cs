using System;
using ACT.Game;

namespace ACT.Battle;

public class CountDatas : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (G.localPlayer.Achievements.Info == null)
		{
			return false;
		}
		int num = param[0];
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(num, out var value))
		{
			if (num == 10)
			{
				double num2 = Math.Truncate((double)param[1] / 3600.0 * 10.0) / 10.0;
				return CalculOnlineTime(value) >= num2;
			}
			return value >= param[1];
		}
		if (num == 10)
		{
			double num3 = Math.Truncate((double)param[1] / 3600.0 * 10.0) / 10.0;
			return CalculOnlineTime(0) >= num3;
		}
		return false;
	}

	public override int GetCompleteCount(int[] param)
	{
		if (G.localPlayer.Achievements.Info == null)
		{
			return 0;
		}
		int key = param[0];
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return value;
		}
		return 0;
	}

	public override double GetDoubleCompleteCount(int[] param)
	{
		if (G.localPlayer.Achievements.Info == null)
		{
			return 0.0;
		}
		int key = param[0];
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return CalculOnlineTime(value);
		}
		if (param[0] == 10)
		{
			return CalculOnlineTime(0);
		}
		return 0.0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[1];
	}

	public override double GetDoubleTypeNeedCount(int[] param)
	{
		return Math.Truncate((double)param[1] / 3600.0 * 10.0) / 10.0;
	}

	private double CalculOnlineTime(int oldTime)
	{
		return Math.Truncate((TimeManager.GetTimeSpan(TimeManager.ServerTime.NowTimestamp - TimeManager.ServerTime.EnterGameTimestamp).TotalHours + (double)oldTime / 3600.0) * 10.0) / 10.0;
	}
}
