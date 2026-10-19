using System;

namespace ACT.Config;

[Serializable]
public class SubshopData
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly int title;

	public readonly int type;

	public readonly int[] commodityIds = new int[0];

	public readonly int missionGroupId;

	public readonly int[] moneyId = new int[0];

	public readonly int soldoutType;

	public readonly int icon;

	public readonly bool skipJumpTraverse;

	public readonly int gmType;

	public SubshopData(int id, int nameLocal, int title, int type, int[] commodityIds, int missionGroupId, int[] moneyId, int soldoutType, int icon, bool skipJumpTraverse, int gmType)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.title = title;
		this.type = type;
		this.commodityIds = commodityIds;
		this.missionGroupId = missionGroupId;
		this.moneyId = moneyId;
		this.soldoutType = soldoutType;
		this.icon = icon;
		this.skipJumpTraverse = skipJumpTraverse;
		this.gmType = gmType;
	}
}
