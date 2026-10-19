using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityEnemyLevelDataTemplate
{
	public readonly int id;

	public readonly int type;

	public readonly int level;

	public readonly List<Properties> enemyProperty;

	public EntityEnemyLevelDataTemplate(int id, int type, int level, List<Properties> enemyProperty)
	{
		this.id = id;
		this.type = type;
		this.level = level;
		this.enemyProperty = enemyProperty;
	}
}
