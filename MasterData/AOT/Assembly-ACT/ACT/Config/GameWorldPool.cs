using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class GameWorldPool
{
	public readonly int id;

	public readonly List<ItemKv> gameWorldWeightList;

	public GameWorldPool(int id, List<ItemKv> gameWorldWeightList)
	{
		this.id = id;
		this.gameWorldWeightList = gameWorldWeightList;
	}
}
