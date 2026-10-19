using System;
using System.Collections.Generic;
using ACT.BluePrint;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MonsterSpawnGroup
{
	public SpawnMonsterType groupType;

	public int nextSpawnCount;

	public int nextTimeLeft;

	[HideInInspector]
	public Bounds triggerFieldBounds;

	public List<SpawnMonsterParams> spawnMonsterList = new List<SpawnMonsterParams>();
}
