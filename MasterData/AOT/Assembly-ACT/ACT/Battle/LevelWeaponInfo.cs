using ACT.Game;
using UnityEngine;

namespace ACT.Battle;

public class LevelWeaponInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (G.localPlayer.Achievements.Info.LevelWeapons.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.LevelWeapons[param[0]] >= param[1];
		}
		return false;
	}

	public override float GetCompletePercent(int[] param)
	{
		float a = 0f;
		if (G.localPlayer.Achievements.Info.LevelWeapons.ContainsKey(param[0]))
		{
			a = (float)G.localPlayer.Achievements.Info.LevelWeapons[param[0]] * 1f / (float)param[1];
		}
		return Mathf.Min(a, 1f);
	}

	public override int GetCompleteCount(int[] param)
	{
		if (G.localPlayer.Achievements.Info.LevelWeapons.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.LevelWeapons[param[0]];
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[1];
	}
}
