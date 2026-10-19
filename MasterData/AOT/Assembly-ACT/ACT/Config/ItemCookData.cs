using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemCookData
{
	public readonly int id;

	public readonly int cookname;

	public readonly int itemType;

	public readonly int capacityCost;

	public readonly int randomImageGroup;

	public readonly List<ItemKv> effectSkill;

	public readonly List<Maybe> skill;

	public readonly List<ItemKv> effectPr;

	public readonly int dishesImage;

	public readonly int cookSkillType;

	public ItemCookData(int id, int cookname, int itemType, int capacityCost, int randomImageGroup, List<ItemKv> effectSkill, List<Maybe> skill, List<ItemKv> effectPr, int dishesImage, int cookSkillType)
	{
		this.id = id;
		this.cookname = cookname;
		this.itemType = itemType;
		this.capacityCost = capacityCost;
		this.randomImageGroup = randomImageGroup;
		this.effectSkill = effectSkill;
		this.skill = skill;
		this.effectPr = effectPr;
		this.dishesImage = dishesImage;
		this.cookSkillType = cookSkillType;
	}
}
