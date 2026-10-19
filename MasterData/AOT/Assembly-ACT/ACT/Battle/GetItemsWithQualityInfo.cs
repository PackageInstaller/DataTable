using ACT.Game;
using UnityEngine;

namespace ACT.Battle;

public class GetItemsWithQualityInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (G.localPlayer.Achievements.Info.GotItemsWithQuality.ContainsKey(param[0]))
		{
			if (G.localPlayer.Achievements.Info.GotItemsWithQuality[param[0]].QualityCount.ContainsKey(param[1]))
			{
				return G.localPlayer.Achievements.Info.GotItemsWithQuality[param[0]].QualityCount[param[1]] >= param[2];
			}
			return false;
		}
		return false;
	}

	public override float GetCompletePercent(int[] param)
	{
		float a = 0f;
		if (G.localPlayer.Achievements.Info.GotItemsWithQuality.ContainsKey(param[0]) && G.localPlayer.Achievements.Info.GotItemsWithQuality[param[0]].QualityCount.ContainsKey(param[1]))
		{
			a = (float)G.localPlayer.Achievements.Info.GotItemsWithQuality[param[0]].QualityCount[param[1]] * 1f / (float)param[2];
		}
		return Mathf.Min(a, 1f);
	}

	public override int GetCompleteCount(int[] param)
	{
		if (G.localPlayer.Achievements.Info.GotItemsWithQuality.ContainsKey(param[0]) && G.localPlayer.Achievements.Info.GotItemsWithQuality[param[0]].QualityCount.ContainsKey(param[1]))
		{
			return G.localPlayer.Achievements.Info.GotItemsWithQuality[param[0]].QualityCount[param[1]];
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[2];
	}
}
