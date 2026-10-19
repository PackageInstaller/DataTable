using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityCharacterProbation
{
	public readonly int id;

	public readonly int characterId;

	public readonly int skinId;

	public readonly int characterLv;

	public readonly int stageLevel;

	public readonly int[] weaponId = new int[0];

	public readonly int equipId;

	public readonly int weaponStageLevel;

	public readonly int constellationLv;

	public readonly List<ItemKv> chipGroup;

	public readonly List<ItemKv> skillLevel;

	public readonly List<ItemKv> eliteCharacter;

	public readonly int[] equip = new int[0];

	public readonly string[] extraAbility = new string[0];

	public readonly int showIcon;

	public readonly int showText;

	public readonly int isShow;

	public EntityCharacterProbation(int id, int characterId, int skinId, int characterLv, int stageLevel, int[] weaponId, int equipId, int weaponStageLevel, int constellationLv, List<ItemKv> chipGroup, List<ItemKv> skillLevel, List<ItemKv> eliteCharacter, int[] equip, string[] extraAbility, int showIcon, int showText, int isShow)
	{
		this.id = id;
		this.characterId = characterId;
		this.skinId = skinId;
		this.characterLv = characterLv;
		this.stageLevel = stageLevel;
		this.weaponId = weaponId;
		this.equipId = equipId;
		this.weaponStageLevel = weaponStageLevel;
		this.constellationLv = constellationLv;
		this.chipGroup = chipGroup;
		this.skillLevel = skillLevel;
		this.eliteCharacter = eliteCharacter;
		this.equip = equip;
		this.extraAbility = extraAbility;
		this.showIcon = showIcon;
		this.showText = showText;
		this.isShow = isShow;
	}
}
