using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ACT.BluePrint;

[DisallowMultipleComponent]
public class SpawnMonsterPointGroup : MonsterPointGroup
{
	private List<SpawnMonsterPoint> spawnMonsterPoints;

	public List<SpawnMonsterPoint> GetSpawnMonsterPoints()
	{
		if (spawnMonsterPoints == null)
		{
			spawnMonsterPoints = transform.GetComponentsInChildren<SpawnMonsterPoint>().ToList();
		}
		return spawnMonsterPoints;
	}
}
