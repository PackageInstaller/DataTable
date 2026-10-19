using ACT.Game;

namespace ACT.Battle;

public class ActivityLoginDays : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		int key = param[0];
		_ = param[1];
		if (G.localPlayer.Achievements.Info.ActivityLoginDay.TryGetValue(key, out var value))
		{
			return value >= param[1];
		}
		return false;
	}

	public override int GetCompleteCount(int[] param)
	{
		int key = param[0];
		_ = param[1];
		if (G.localPlayer.Achievements.Info.ActivityLoginDay.TryGetValue(key, out var value))
		{
			return value;
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		if (param.Length == 0)
		{
			return 0;
		}
		return param[1];
	}
}
