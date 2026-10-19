using ACT.Game;

namespace ACT.Battle;

public class GetWeaponTypeCount : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return G.localPlayer.Achievements.Info.GotWeapons.Count >= param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		return G.localPlayer.Achievements.Info.GotWeapons.Count;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
