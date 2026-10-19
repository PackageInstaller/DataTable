using ACT.Game;

namespace ACT.Battle;

public class EquipLevel : PreconditionInfo
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
		return G.localPlayer.Inventory.GetEquipCountLevel(param[1]);
	}

	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		return G.localPlayer.Inventory.GetEquipCountLevel(param[1]) >= param[0];
	}
}
