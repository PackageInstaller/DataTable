using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemCustomizeData
{
	public readonly int id;

	public readonly bool canLevelUp;

	public readonly int chipLevel;

	public readonly int mainProperty;

	public readonly List<ItemKv> subProperty;

	public ItemCustomizeData(int id, bool canLevelUp, int chipLevel, int mainProperty, List<ItemKv> subProperty)
	{
		this.id = id;
		this.canLevelUp = canLevelUp;
		this.chipLevel = chipLevel;
		this.mainProperty = mainProperty;
		this.subProperty = subProperty;
	}
}
