using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class AdventureLevelMonsterSpawnConfig : ScriptableObject
{
	[Serializable]
	public class MonsterSpawnConfig
	{
		public HotfixEnum.worldLevelType levelType;

		public string pathInHierarchy;

		public string id;

		public int levelMin;

		public int levelMax;

		public int monsterGroupID;

		public int monsterID;

		public int monsterLevel;

		public bool isRoguelikeMonster;

		public string spawnGroupKey;
	}

	public List<MonsterSpawnConfig> configs;
}
