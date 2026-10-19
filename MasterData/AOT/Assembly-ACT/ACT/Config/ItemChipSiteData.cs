using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemChipSiteData
{
	public readonly int id;

	public readonly List<ItemKv> mainPropertyPool;

	public ItemChipSiteData(int id, List<ItemKv> mainPropertyPool)
	{
		this.id = id;
		this.mainPropertyPool = mainPropertyPool;
	}
}
