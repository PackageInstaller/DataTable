using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemWeaponData
{
	public readonly int id;

	public readonly string showModel = "";

	public readonly int weaponType;

	public readonly int weaponStars;

	public readonly int initAtk;

	public readonly int weaponSubProperty;

	public readonly List<Int10000> weaponSubPropertyValue;

	public readonly int PropertyID;

	public readonly int weaponSkill;

	public readonly string[] weaponSkillName = new string[0];

	public readonly int upgradeType;

	public readonly int maxWeaponLevel;

	public readonly int maxWeaponStage;

	public readonly int maxWeaponRefine;

	public readonly int refineRequired;

	public readonly int weaponBreakType;

	public readonly int descriptionLocal;

	public readonly int abilityNameLocal;

	public readonly int abilityDesLocal;

	public readonly int storyLocal;

	public readonly int nameLocal;

	public ItemWeaponData(int id, string showModel, int weaponType, int weaponStars, int initAtk, int weaponSubProperty, List<Int10000> weaponSubPropertyValue, int PropertyID, int weaponSkill, string[] weaponSkillName, int upgradeType, int maxWeaponLevel, int maxWeaponStage, int maxWeaponRefine, int refineRequired, int weaponBreakType, int descriptionLocal, int abilityNameLocal, int abilityDesLocal, int storyLocal, int nameLocal)
	{
		this.id = id;
		this.showModel = showModel;
		this.weaponType = weaponType;
		this.weaponStars = weaponStars;
		this.initAtk = initAtk;
		this.weaponSubProperty = weaponSubProperty;
		this.weaponSubPropertyValue = weaponSubPropertyValue;
		this.PropertyID = PropertyID;
		this.weaponSkill = weaponSkill;
		this.weaponSkillName = weaponSkillName;
		this.upgradeType = upgradeType;
		this.maxWeaponLevel = maxWeaponLevel;
		this.maxWeaponStage = maxWeaponStage;
		this.maxWeaponRefine = maxWeaponRefine;
		this.refineRequired = refineRequired;
		this.weaponBreakType = weaponBreakType;
		this.descriptionLocal = descriptionLocal;
		this.abilityNameLocal = abilityNameLocal;
		this.abilityDesLocal = abilityDesLocal;
		this.storyLocal = storyLocal;
		this.nameLocal = nameLocal;
	}
}
