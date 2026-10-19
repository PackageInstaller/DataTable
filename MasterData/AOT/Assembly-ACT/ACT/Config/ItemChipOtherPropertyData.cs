using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemChipOtherPropertyData
{
	public readonly int id;

	public readonly List<ValueWeight> property;

	public readonly int power;

	public ItemChipOtherPropertyData(int id, List<ValueWeight> property, int power)
	{
		this.id = id;
		this.property = property;
		this.power = power;
	}
}
