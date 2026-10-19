using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemChipUpdateData
{
	public readonly int id;

	public readonly int space;

	public readonly int level;

	public readonly List<ItemKv> xpEachLv;

	public readonly int totalEXPRequired;

	public readonly int coinEachLv;

	public readonly int totalCoinRequired;

	public readonly bool isUpdata;

	public ItemChipUpdateData(int id, int space, int level, List<ItemKv> xpEachLv, int totalEXPRequired, int coinEachLv, int totalCoinRequired, bool isUpdata)
	{
		this.id = id;
		this.space = space;
		this.level = level;
		this.xpEachLv = xpEachLv;
		this.totalEXPRequired = totalEXPRequired;
		this.coinEachLv = coinEachLv;
		this.totalCoinRequired = totalCoinRequired;
		this.isUpdata = isUpdata;
	}
}
