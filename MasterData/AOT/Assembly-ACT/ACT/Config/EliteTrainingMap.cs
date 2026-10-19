using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EliteTrainingMap
{
	public readonly int id;

	public readonly int characterId;

	public readonly int[] pointList = new int[0];

	public readonly int[] characterSkill = new int[0];

	public readonly List<ItemKv> characterProperty1;

	public readonly List<ItemKv> characterProperty2;

	public readonly List<ItemKv> characterProperty3;

	public EliteTrainingMap(int id, int characterId, int[] pointList, int[] characterSkill, List<ItemKv> characterProperty1, List<ItemKv> characterProperty2, List<ItemKv> characterProperty3)
	{
		this.id = id;
		this.characterId = characterId;
		this.pointList = pointList;
		this.characterSkill = characterSkill;
		this.characterProperty1 = characterProperty1;
		this.characterProperty2 = characterProperty2;
		this.characterProperty3 = characterProperty3;
	}
}
