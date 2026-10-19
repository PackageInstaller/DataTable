using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemFishData
{
	public readonly int id;

	public readonly int type;

	public readonly int weight;

	public readonly List<Range> sizeRange;

	public readonly int race;

	public readonly int raceLocal;

	public readonly List<Range> sink;

	public ItemFishData(int id, int type, int weight, List<Range> sizeRange, int race, int raceLocal, List<Range> sink)
	{
		this.id = id;
		this.type = type;
		this.weight = weight;
		this.sizeRange = sizeRange;
		this.race = race;
		this.raceLocal = raceLocal;
		this.sink = sink;
	}
}
