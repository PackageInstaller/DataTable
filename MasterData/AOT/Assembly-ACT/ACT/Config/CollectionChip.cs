using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CollectionChip
{
	public readonly int id;

	public readonly int[] chipSuits = new int[0];

	public readonly List<ItemKv> rdmRule;

	public CollectionChip(int id, int[] chipSuits, List<ItemKv> rdmRule)
	{
		this.id = id;
		this.chipSuits = chipSuits;
		this.rdmRule = rdmRule;
	}
}
