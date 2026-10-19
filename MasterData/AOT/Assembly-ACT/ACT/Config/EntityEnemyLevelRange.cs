using System;

namespace ACT.Config;

[Serializable]
public class EntityEnemyLevelRange
{
	public readonly int id;

	public readonly int enemyLevelMin;

	public readonly int enemyLevelMax;

	public EntityEnemyLevelRange(int id, int enemyLevelMin, int enemyLevelMax)
	{
		this.id = id;
		this.enemyLevelMin = enemyLevelMin;
		this.enemyLevelMax = enemyLevelMax;
	}
}
