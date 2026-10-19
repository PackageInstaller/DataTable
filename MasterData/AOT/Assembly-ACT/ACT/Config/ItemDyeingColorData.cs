using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemDyeingColorData
{
	public readonly int id;

	public readonly int color;

	public readonly List<ItemKv> itemRequired;

	public ItemDyeingColorData(int id, int color, List<ItemKv> itemRequired)
	{
		this.id = id;
		this.color = color;
		this.itemRequired = itemRequired;
	}
}
