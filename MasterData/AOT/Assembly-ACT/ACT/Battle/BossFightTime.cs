using ACT.Game;

namespace ACT.Battle;

public class BossFightTime : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (G.localPlayer.Achievements.Info.BossKillTime.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.BossKillTime[param[0]] < param[1];
		}
		return false;
	}

	public override int GetCompleteCount(int[] param)
	{
		if (G.localPlayer.Achievements.Info.BossKillTime.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.BossKillTime[param[0]];
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[1];
	}
}
