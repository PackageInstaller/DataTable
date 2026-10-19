using ACT.Game;
using ACT.Game.Data;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断道具", "Predicate", new string[] { "check", "item", "predicate", "condition" })]
public class CheckItemPredicate : ConfigPredicate
{
	public int itemId;

	public int itemNum;

	public override bool Check(ActionMemory memory)
	{
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(itemId);
		if (itemInfo != null && itemInfo.Count >= itemNum)
		{
			return true;
		}
		return false;
	}
}
