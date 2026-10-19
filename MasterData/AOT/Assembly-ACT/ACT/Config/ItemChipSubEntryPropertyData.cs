using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemChipSubEntryPropertyData
{
	public readonly int id;

	public readonly List<Int10000> propertyMaybeValue;

	public ItemChipSubEntryPropertyData(int id, List<Int10000> propertyMaybeValue)
	{
		this.id = id;
		this.propertyMaybeValue = propertyMaybeValue;
	}
}
