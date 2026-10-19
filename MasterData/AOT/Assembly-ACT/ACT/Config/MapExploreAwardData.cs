using System;

namespace ACT.Config;

[Serializable]
public class MapExploreAwardData
{
	public readonly int id;

	public readonly int exploreType;

	public readonly int level;

	public readonly int number;

	public readonly int numberTotal;

	public readonly int award;

	public MapExploreAwardData(int id, int exploreType, int level, int number, int numberTotal, int award)
	{
		this.id = id;
		this.exploreType = exploreType;
		this.level = level;
		this.number = number;
		this.numberTotal = numberTotal;
		this.award = award;
	}
}
