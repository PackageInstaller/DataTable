using ACT.Game;
using ACT.Game.Data;

namespace ACT.World.Condition;

public class CheckInventoryItemCondition : BaseCondition
{
	public int itemId;

	public ComparisonOperator op;

	public int count;

	public override string Description => "检查物品数量";

	protected override bool Check()
	{
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(itemId);
		switch (op)
		{
		case ComparisonOperator.GreaterThan:
			if (count == 0 && itemInfo == null)
			{
				return 0 > count;
			}
			if (itemInfo == null)
			{
				return 0 > count;
			}
			return itemInfo.Count > count;
		case ComparisonOperator.LessThan:
			if (count == 0 && itemInfo == null)
			{
				return 0 < count;
			}
			if (itemInfo == null)
			{
				return 0 < count;
			}
			return itemInfo.Count < count;
		case ComparisonOperator.Equal:
			if (count == 0 && itemInfo == null)
			{
				return count == 0;
			}
			if (itemInfo == null)
			{
				return count == 0;
			}
			return itemInfo.Count == count;
		case ComparisonOperator.GreaterThanOrEqual:
			if (count == 0 && itemInfo == null)
			{
				return 0 >= count;
			}
			if (itemInfo == null)
			{
				return 0 >= count;
			}
			return itemInfo.Count >= count;
		case ComparisonOperator.LessThanOrEqual:
			if (count == 0 && itemInfo == null)
			{
				return 0 <= count;
			}
			if (itemInfo == null)
			{
				return 0 <= count;
			}
			return itemInfo.Count <= count;
		default:
			return false;
		}
	}
}
