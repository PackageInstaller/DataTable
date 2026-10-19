using ACT.Game;

namespace ACT.Battle;

public class GachaCount : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		int key = 11;
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return value >= param[0];
		}
		return false;
	}

	public override int GetCompleteCount(int[] param)
	{
		int key = 11;
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return value;
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
