using ACT.Game;
using UnityEngine;

namespace ACT.Battle;

public class GetItemInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		int num = ((param.Length < 2) ? 1 : param[1]);
		if (G.localPlayer.Achievements.Info.GotItems != null && G.localPlayer.Achievements.Info.GotItems.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.GotItems[param[0]] >= num;
		}
		return false;
	}

	public override float GetCompletePercent(int[] param)
	{
		int num = ((param.Length < 2) ? 1 : param[1]);
		float a = 0f;
		if (G.localPlayer.Achievements.Info.GotItems.ContainsKey(param[0]))
		{
			a = (float)G.localPlayer.Achievements.Info.GotItems[param[0]] * 1f / (float)num;
		}
		return Mathf.Min(a, 1f);
	}

	public override int GetCompleteCount(int[] param)
	{
		if (G.localPlayer.Achievements.Info.GotItems.ContainsKey(param[0]))
		{
			return G.localPlayer.Achievements.Info.GotItems[param[0]];
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		if (param.Length < 2)
		{
			return 1;
		}
		return param[1];
	}
}
