using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ExchangeShop
{
	public readonly int id;

	public readonly int itemId;

	public readonly int itemCount;

	public readonly List<ItemKv> itemNeed;

	public readonly int limitCount;

	public readonly int limitRefreshType;

	public readonly int priority;

	public readonly int Precondition;

	public readonly int[] PreconditionParam = new int[0];

	public readonly int missionGroupId;

	public readonly bool permanentLimit;

	public ExchangeShop(int id, int itemId, int itemCount, List<ItemKv> itemNeed, int limitCount, int limitRefreshType, int priority, int Precondition, int[] PreconditionParam, int missionGroupId, bool permanentLimit)
	{
		this.id = id;
		this.itemId = itemId;
		this.itemCount = itemCount;
		this.itemNeed = itemNeed;
		this.limitCount = limitCount;
		this.limitRefreshType = limitRefreshType;
		this.priority = priority;
		this.Precondition = Precondition;
		this.PreconditionParam = PreconditionParam;
		this.missionGroupId = missionGroupId;
		this.permanentLimit = permanentLimit;
	}
}
