using ACT.Game;

namespace ACT.Battle;

public class GemEquippedNum : PreconditionInfo
{
	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		return G.localPlayer.Inventory.GetEquippedGemCount();
	}

	public override bool IsComplete(int[] param)
	{
		return G.localPlayer.Inventory.GetEquippedGemCount() >= param[0];
	}
}
