using ACT.Game;

namespace ACT.Config.Condition;

public class CheckItemNumIsEnough : GuideStepCondition
{
	public int ItemId;

	public int ItemNum;

	public override bool CheckCondition()
	{
		return ItemNum <= G.localPlayer.Inventory.GetItemCount(ItemId);
	}
}
