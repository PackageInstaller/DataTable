using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class TalentNodeLevelData
{
	public readonly int id;

	public readonly int talentNodeId;

	public readonly int level;

	public readonly int name;

	public readonly int description;

	public readonly int[] combatEffectIds = new int[0];

	public readonly int metaEffectId;

	public readonly List<ItemKv> upgradeCost;

	public readonly int materialCost;

	public readonly List<Properties> propertyBonus;

	public TalentNodeLevelData(int id, int talentNodeId, int level, int name, int description, int[] combatEffectIds, int metaEffectId, List<ItemKv> upgradeCost, int materialCost, List<Properties> propertyBonus)
	{
		this.id = id;
		this.talentNodeId = talentNodeId;
		this.level = level;
		this.name = name;
		this.description = description;
		this.combatEffectIds = combatEffectIds;
		this.metaEffectId = metaEffectId;
		this.upgradeCost = upgradeCost;
		this.materialCost = materialCost;
		this.propertyBonus = propertyBonus;
	}
}
