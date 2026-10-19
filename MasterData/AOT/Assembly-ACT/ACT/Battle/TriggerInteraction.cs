using ACT.Game;

namespace ACT.Battle;

public class TriggerInteraction : PreconditionInfo
{
	public override int GetNeedCount(int[] param)
	{
		if (param.Length == 0)
		{
			return 0;
		}
		return param[1];
	}

	public override int GetCompleteCount(int[] param)
	{
		if (param.Length == 0)
		{
			return 0;
		}
		if (!G.localPlayer.Achievements.Info.TiggerInteraction.ContainsKey(param[0]))
		{
			return 0;
		}
		return G.localPlayer.Achievements.Info.TiggerInteraction[param[0]];
	}

	public override bool IsComplete(int[] param)
	{
		if (param.Length == 1)
		{
			return false;
		}
		if (G.localPlayer.Achievements.Info.TiggerInteraction.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.TiggerInteraction[param[0]] >= param[1];
		}
		return false;
	}
}
