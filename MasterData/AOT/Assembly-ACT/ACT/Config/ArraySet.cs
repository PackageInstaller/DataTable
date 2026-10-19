using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ArraySet
{
	public readonly int id;

	public readonly int[] array = new int[0];

	public readonly List<ItemKv> chipexp;

	public ArraySet(int id, int[] array, List<ItemKv> chipexp)
	{
		this.id = id;
		this.array = array;
		this.chipexp = chipexp;
	}
}
