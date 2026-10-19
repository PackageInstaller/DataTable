using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class SkillGroupLevelData
{
	public readonly int id;

	public readonly List<ItemKv> cost;

	public readonly int skillPointCost;

	public readonly List<ItemKv> unlockReward;

	public readonly int stageBreakLevel;

	public readonly int requireCharacterLevel;

	public readonly List<ItemKv> preconditionParam;

	public readonly List<Properties> skillProperty;

	public readonly int[] skillDes = new int[0];

	public SkillGroupLevelData(int id, List<ItemKv> cost, int skillPointCost, List<ItemKv> unlockReward, int stageBreakLevel, int requireCharacterLevel, List<ItemKv> preconditionParam, List<Properties> skillProperty, int[] skillDes)
	{
		this.id = id;
		this.cost = cost;
		this.skillPointCost = skillPointCost;
		this.unlockReward = unlockReward;
		this.stageBreakLevel = stageBreakLevel;
		this.requireCharacterLevel = requireCharacterLevel;
		this.preconditionParam = preconditionParam;
		this.skillProperty = skillProperty;
		this.skillDes = skillDes;
	}
}
