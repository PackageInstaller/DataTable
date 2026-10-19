using ACT.Game;

namespace ACT.Battle;

public class MakeEquipCount : PreconditionInfo
{
	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		int key = 12;
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return value;
		}
		return 0;
	}

	public override bool IsComplete(int[] param)
	{
		int key = 12;
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return value >= param[0];
		}
		return false;
	}
}
