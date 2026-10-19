using ACT.Game;

namespace ACT.Battle;

public class CompleteAbyssInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		if (G.localPlayer.Achievements.Info.CompletedAbyssStages.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.CompletedAbyssStages[param[0]];
		}
		return false;
	}

	public override int GetCompleteCount(int[] param)
	{
		if (param.Length == 0)
		{
			return 0;
		}
		if (G.localPlayer.Achievements.Info.CompletedAbyssStages.ContainsKey(param[0]))
		{
			return 1;
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return 1;
	}
}
