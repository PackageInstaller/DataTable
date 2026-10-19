using System;

namespace ACT.Config;

[Serializable]
public class ExpirableItem
{
	public readonly int id;

	public readonly int itemId;

	public readonly int ItemDateType;

	public readonly long ItemDatePara;

	public ExpirableItem(int id, int itemId, int ItemDateType, long ItemDatePara)
	{
		this.id = id;
		this.itemId = itemId;
		this.ItemDateType = ItemDateType;
		this.ItemDatePara = ItemDatePara;
	}
}
