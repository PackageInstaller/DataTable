using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityEnemyLevelData
{
	public readonly int id;

	public readonly int character;

	public readonly int part;

	public readonly int levelMin;

	public readonly int levelMax;

	public readonly List<Properties> characterPorpertyAdd;

	public EntityEnemyLevelData(int id, int character, int part, int levelMin, int levelMax, List<Properties> characterPorpertyAdd)
	{
		this.id = id;
		this.character = character;
		this.part = part;
		this.levelMin = levelMin;
		this.levelMax = levelMax;
		this.characterPorpertyAdd = characterPorpertyAdd;
	}
}
