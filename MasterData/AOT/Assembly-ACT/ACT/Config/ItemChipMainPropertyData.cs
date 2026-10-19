using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemChipMainPropertyData
{
	public readonly int id;

	public readonly int property;

	public readonly List<Int10000> baseValue;

	public readonly List<Int10000> lvAddValue;

	public ItemChipMainPropertyData(int id, int property, List<Int10000> baseValue, List<Int10000> lvAddValue)
	{
		this.id = id;
		this.property = property;
		this.baseValue = baseValue;
		this.lvAddValue = lvAddValue;
	}
}
