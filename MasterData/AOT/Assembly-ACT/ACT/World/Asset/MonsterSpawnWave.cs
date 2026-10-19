using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MonsterSpawnWave
{
	public SpawnMonsterType nextType;

	public int nextSpawnCount;

	public int nextTimeLeft;

	[HideInInspector]
	public Bounds triggerFieldBounds;

	public List<MonsterSpawnGroup> groups = new List<MonsterSpawnGroup>();
}
