using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CommodityData
{
	public readonly int id;

	public readonly int itemId;

	public readonly int itemCount;

	public readonly List<ItemKv> itemNeed;

	public readonly int limitCount;

	public readonly int limitRefreshType;

	public readonly int Precondition;

	public readonly int[] PreconditionParam = new int[0];

	public readonly int missionGroupId;

	public CommodityData(int id, int itemId, int itemCount, List<ItemKv> itemNeed, int limitCount, int limitRefreshType, int Precondition, int[] PreconditionParam, int missionGroupId)
	{
		this.id = id;
		this.itemId = itemId;
		this.itemCount = itemCount;
		this.itemNeed = itemNeed;
		this.limitCount = limitCount;
		this.limitRefreshType = limitRefreshType;
		this.Precondition = Precondition;
		this.PreconditionParam = PreconditionParam;
		this.missionGroupId = missionGroupId;
	}
}
