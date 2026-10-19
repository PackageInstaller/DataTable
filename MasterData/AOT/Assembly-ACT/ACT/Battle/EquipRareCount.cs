using ACT.Game;

namespace ACT.Battle;

public class EquipRareCount : PreconditionInfo
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
		return G.localPlayer.Inventory.GetEquippedCountRare(param[0]);
	}

	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		return G.localPlayer.Inventory.GetEquippedCountRare(param[0]) >= param[1];
	}
}
