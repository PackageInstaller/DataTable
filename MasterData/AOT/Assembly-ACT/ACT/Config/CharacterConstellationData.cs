using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CharacterConstellationData
{
	public readonly int id;

	public readonly int characterId;

	public readonly int constellationLevel;

	public readonly int[] upgradeProperty = new int[0];

	public readonly int unlockSkill;

	public readonly List<ItemKv> upgradeSkillGroup;

	public readonly int constellationType;

	public readonly List<ItemKv> upgradeParam;

	public readonly int name;

	public readonly int describe;

	public readonly int costItemId;

	public readonly string[] constellationSkillName = new string[0];

	public CharacterConstellationData(int id, int characterId, int constellationLevel, int[] upgradeProperty, int unlockSkill, List<ItemKv> upgradeSkillGroup, int constellationType, List<ItemKv> upgradeParam, int name, int describe, int costItemId, string[] constellationSkillName)
	{
		this.id = id;
		this.characterId = characterId;
		this.constellationLevel = constellationLevel;
		this.upgradeProperty = upgradeProperty;
		this.unlockSkill = unlockSkill;
		this.upgradeSkillGroup = upgradeSkillGroup;
		this.constellationType = constellationType;
		this.upgradeParam = upgradeParam;
		this.name = name;
		this.describe = describe;
		this.costItemId = costItemId;
		this.constellationSkillName = constellationSkillName;
	}
}
