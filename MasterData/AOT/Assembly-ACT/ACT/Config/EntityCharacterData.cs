using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityCharacterData
{
	public readonly int id;

	public readonly int name;

	public readonly int characterArmorType;

	public readonly int characterDamageType;

	public readonly int mannerType;

	public readonly int ConstellationItem;

	public readonly int eliteElementItem;

	public readonly int eliteCharacterItem;

	public readonly int[][] presentId = new int[0][];

	public readonly int[] characterTagGroup = new int[0];

	public readonly string config = "";

	public readonly string DetaileShowModel = "";

	public readonly string showModel = "";

	public readonly List<Properties> characterPorpertyBase;

	public readonly List<Properties> characterPorpertyAdd;

	public readonly int stars;

	public readonly int wp1Type;

	public readonly int initWeapon;

	public readonly float skillEnergy;

	public readonly float normalEnergy;

	public readonly float specialEnergy;

	public readonly int characterNameEng;

	public readonly int characterNameCh;

	public readonly int characterIcon;

	public readonly int characterType;

	public readonly int difficulty;

	public readonly int characterArt;

	public readonly int[] effectsRGB = new int[0];

	public readonly int ultimateSkillIcon;

	public readonly float switchSkillCD;

	public readonly float assistEnergy;

	public readonly float characterHeight;

	public readonly int[] skillGroupIds = new int[0];

	public readonly string customUiPc = "";

	public readonly string customUiMb = "";

	public readonly float[] viewPosition = new float[0];

	public readonly float[] viewRotation = new float[0];

	public readonly float viewFov;

	public readonly string viewSound = "";

	public readonly int[] comSuit = new int[0];

	public readonly int[] comProperty = new int[0];

	public readonly bool isProtagonist;

	public readonly string timelinePath = "";

	public readonly string tapePath = "";

	public EntityCharacterData(int id, int name, int characterArmorType, int characterDamageType, int mannerType, int ConstellationItem, int eliteElementItem, int eliteCharacterItem, int[][] presentId, int[] characterTagGroup, string config, string DetaileShowModel, string showModel, List<Properties> characterPorpertyBase, List<Properties> characterPorpertyAdd, int stars, int wp1Type, int initWeapon, float skillEnergy, float normalEnergy, float specialEnergy, int characterNameEng, int characterNameCh, int characterIcon, int characterType, int difficulty, int characterArt, int[] effectsRGB, int ultimateSkillIcon, float switchSkillCD, float assistEnergy, float characterHeight, int[] skillGroupIds, string customUiPc, string customUiMb, float[] viewPosition, float[] viewRotation, float viewFov, string viewSound, int[] comSuit, int[] comProperty, bool isProtagonist, string timelinePath, string tapePath)
	{
		this.id = id;
		this.name = name;
		this.characterArmorType = characterArmorType;
		this.characterDamageType = characterDamageType;
		this.mannerType = mannerType;
		this.ConstellationItem = ConstellationItem;
		this.eliteElementItem = eliteElementItem;
		this.eliteCharacterItem = eliteCharacterItem;
		this.presentId = presentId;
		this.characterTagGroup = characterTagGroup;
		this.config = config;
		this.DetaileShowModel = DetaileShowModel;
		this.showModel = showModel;
		this.characterPorpertyBase = characterPorpertyBase;
		this.characterPorpertyAdd = characterPorpertyAdd;
		this.stars = stars;
		this.wp1Type = wp1Type;
		this.initWeapon = initWeapon;
		this.skillEnergy = skillEnergy;
		this.normalEnergy = normalEnergy;
		this.specialEnergy = specialEnergy;
		this.characterNameEng = characterNameEng;
		this.characterNameCh = characterNameCh;
		this.characterIcon = characterIcon;
		this.characterType = characterType;
		this.difficulty = difficulty;
		this.characterArt = characterArt;
		this.effectsRGB = effectsRGB;
		this.ultimateSkillIcon = ultimateSkillIcon;
		this.switchSkillCD = switchSkillCD;
		this.assistEnergy = assistEnergy;
		this.characterHeight = characterHeight;
		this.skillGroupIds = skillGroupIds;
		this.customUiPc = customUiPc;
		this.customUiMb = customUiMb;
		this.viewPosition = viewPosition;
		this.viewRotation = viewRotation;
		this.viewFov = viewFov;
		this.viewSound = viewSound;
		this.comSuit = comSuit;
		this.comProperty = comProperty;
		this.isProtagonist = isProtagonist;
		this.timelinePath = timelinePath;
		this.tapePath = tapePath;
	}
}
