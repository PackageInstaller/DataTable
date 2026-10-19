using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemChipEntryData
{
	public readonly int id;

	public readonly int maxChipLevel;

	public readonly List<ItemKv> mainPropertyRandom;

	public readonly List<ItemKv> subPropertyRandom;

	public readonly int subPropertyCount;

	public readonly int subPropertyMaxMaybe;

	public readonly int typeName;

	public ItemChipEntryData(int id, int maxChipLevel, List<ItemKv> mainPropertyRandom, List<ItemKv> subPropertyRandom, int subPropertyCount, int subPropertyMaxMaybe, int typeName)
	{
		this.id = id;
		this.maxChipLevel = maxChipLevel;
		this.mainPropertyRandom = mainPropertyRandom;
		this.subPropertyRandom = subPropertyRandom;
		this.subPropertyCount = subPropertyCount;
		this.subPropertyMaxMaybe = subPropertyMaxMaybe;
		this.typeName = typeName;
	}
}
