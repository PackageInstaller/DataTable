using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EquipMaterialData
{
	public readonly int id;

	public readonly int space;

	public readonly int level;

	public readonly List<ItemKv> xpEachitemLv;

	public readonly List<ItemKv> itemAllLv;

	public readonly ItemKv xpItemEachLv;

	public readonly ItemKv xpItem;

	public readonly int coinEachLv;

	public readonly int totalCoinRequired;

	public readonly List<ItemKv> RecyclingLv;

	public readonly int worldLevel;

	public EquipMaterialData(int id, int space, int level, List<ItemKv> xpEachitemLv, List<ItemKv> itemAllLv, ItemKv xpItemEachLv, ItemKv xpItem, int coinEachLv, int totalCoinRequired, List<ItemKv> RecyclingLv, int worldLevel)
	{
		this.id = id;
		this.space = space;
		this.level = level;
		this.xpEachitemLv = xpEachitemLv;
		this.itemAllLv = itemAllLv;
		this.xpItemEachLv = xpItemEachLv;
		this.xpItem = xpItem;
		this.coinEachLv = coinEachLv;
		this.totalCoinRequired = totalCoinRequired;
		this.RecyclingLv = RecyclingLv;
		this.worldLevel = worldLevel;
	}
}
