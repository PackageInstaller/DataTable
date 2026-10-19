using System.Collections.Generic;
using System.Linq;
using ACT.Game;
using ACT.Game.Data;

namespace ACT.Battle;

public class PotionLevelNum : PreconditionInfo
{
	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		if (param.Length == 0)
		{
			return 0;
		}
		return G.localPlayer.bloodBottle.PotionItems.Where((KeyValuePair<int, PotionItem> item) => item.Value.Level > param[1]).Count();
	}

	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		return G.localPlayer.bloodBottle.PotionItems.Where((KeyValuePair<int, PotionItem> item) => item.Value.Level >= param[1]).Count() >= param[0];
	}
}
