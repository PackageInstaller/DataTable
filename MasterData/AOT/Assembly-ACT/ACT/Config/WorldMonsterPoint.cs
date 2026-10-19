using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class WorldMonsterPoint
{
	public readonly int id;

	public readonly List<ItemKv> spawnPoint;

	public WorldMonsterPoint(int id, List<ItemKv> spawnPoint)
	{
		this.id = id;
		this.spawnPoint = spawnPoint;
	}
}
