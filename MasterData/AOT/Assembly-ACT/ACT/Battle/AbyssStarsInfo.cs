using ACT.Game;

namespace ACT.Battle;

public class AbyssStarsInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		if (G.localPlayer.Achievements.Info != null)
		{
			if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(2, out var value))
			{
				return value >= param[0];
			}
			return false;
		}
		return false;
	}

	public override int GetCompleteCount(int[] param)
	{
		if (G.localPlayer.Achievements.Info != null)
		{
			if (!G.localPlayer.Achievements.Info.CountDatas.TryGetValue(2, out var value))
			{
				return 0;
			}
			return value;
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
