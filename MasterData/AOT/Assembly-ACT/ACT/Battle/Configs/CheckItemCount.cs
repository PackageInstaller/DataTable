using ACT.Game;
using ACT.Game.Data;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断道具数量", "Predicate", new string[] { "check", "item", "count", "predicate", "condition" })]
public class CheckItemCount : ConfigPredicate
{
	public enum CompareCount
	{
		[InspectorName("大于")]
		GreaterThan,
		[InspectorName("小于")]
		LessThan,
		[InspectorName("等于")]
		Equal,
		[InspectorName("大于等于")]
		GreaterThanOrEqual,
		[InspectorName("小于等于")]
		LessThanOrEqual
	}

	[Header("道具id")]
	public int itemId;

	[Header("目标数量")]
	public int targetItemCount;

	[Header("比较关系")]
	public CompareCount compare;

	public override bool Check(ActionMemory memory)
	{
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(itemId);
		if (itemInfo != null)
		{
			switch (compare)
			{
			case CompareCount.GreaterThan:
				return itemInfo.Count > targetItemCount;
			case CompareCount.LessThan:
				return itemInfo.Count < targetItemCount;
			case CompareCount.Equal:
				return itemInfo.Count == targetItemCount;
			case CompareCount.GreaterThanOrEqual:
				return itemInfo.Count >= targetItemCount;
			case CompareCount.LessThanOrEqual:
				return itemInfo.Count <= targetItemCount;
			}
		}
		return false;
	}
}
