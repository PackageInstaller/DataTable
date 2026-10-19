using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class RogueElement
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int elementType;

	public readonly int elementQuality;

	public readonly int iconAddress;

	public readonly int shopPrice;

	public readonly int recyclePrice;

	public readonly List<ItemKv> coreElementWeightAddRatio;

	public readonly List<ItemKv> influencingElementWeightAddRatio;

	public readonly int[] combatEffectIds = new int[0];

	public readonly int metaEffectId;

	public readonly int requiredSynergyId;

	public readonly int enhancedMetaEffectId;

	public RogueElement(int id, int name, int description, int elementType, int elementQuality, int iconAddress, int shopPrice, int recyclePrice, List<ItemKv> coreElementWeightAddRatio, List<ItemKv> influencingElementWeightAddRatio, int[] combatEffectIds, int metaEffectId, int requiredSynergyId, int enhancedMetaEffectId)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.elementType = elementType;
		this.elementQuality = elementQuality;
		this.iconAddress = iconAddress;
		this.shopPrice = shopPrice;
		this.recyclePrice = recyclePrice;
		this.coreElementWeightAddRatio = coreElementWeightAddRatio;
		this.influencingElementWeightAddRatio = influencingElementWeightAddRatio;
		this.combatEffectIds = combatEffectIds;
		this.metaEffectId = metaEffectId;
		this.requiredSynergyId = requiredSynergyId;
		this.enhancedMetaEffectId = enhancedMetaEffectId;
	}
}
