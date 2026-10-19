using System;

namespace ACT.Config;

[Serializable]
public class RogueHealthPotion
{
	public readonly int id;

	public readonly int rarity;

	public readonly int maxUseCount;

	public readonly int potionDataId;

	public RogueHealthPotion(int id, int rarity, int maxUseCount, int potionDataId)
	{
		this.id = id;
		this.rarity = rarity;
		this.maxUseCount = maxUseCount;
		this.potionDataId = potionDataId;
	}
}
