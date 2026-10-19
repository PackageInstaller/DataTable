using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EnemySpawn
{
	public readonly int id;

	public readonly int rule;

	public readonly List<Maybe> enemy;

	public readonly bool dontUseWorldLevel;

	public readonly int enemyLevelType;

	public readonly int enemyLevelOffset;

	public readonly int[] worldEnemyLevel = new int[0];

	public readonly int[] worldEnemyAi = new int[0];

	public readonly bool skipJumpTraverse;

	public readonly bool useEnemyAi;

	public readonly int enemyAi;

	public EnemySpawn(int id, int rule, List<Maybe> enemy, bool dontUseWorldLevel, int enemyLevelType, int enemyLevelOffset, int[] worldEnemyLevel, int[] worldEnemyAi, bool skipJumpTraverse, bool useEnemyAi, int enemyAi)
	{
		this.id = id;
		this.rule = rule;
		this.enemy = enemy;
		this.dontUseWorldLevel = dontUseWorldLevel;
		this.enemyLevelType = enemyLevelType;
		this.enemyLevelOffset = enemyLevelOffset;
		this.worldEnemyLevel = worldEnemyLevel;
		this.worldEnemyAi = worldEnemyAi;
		this.skipJumpTraverse = skipJumpTraverse;
		this.useEnemyAi = useEnemyAi;
		this.enemyAi = enemyAi;
	}
}
