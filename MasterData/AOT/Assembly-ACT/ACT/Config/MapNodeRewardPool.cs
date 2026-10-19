using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class MapNodeRewardPool
{
	public readonly int id;

	public readonly List<ItemKv> rogueHealthPotionRewardPool;

	public readonly List<ItemKv> rogueAssistCharacterRewardPool;

	public readonly List<ItemKv> rogueItemRewardPool;

	public readonly int rogueGold;

	public MapNodeRewardPool(int id, List<ItemKv> rogueHealthPotionRewardPool, List<ItemKv> rogueAssistCharacterRewardPool, List<ItemKv> rogueItemRewardPool, int rogueGold)
	{
		this.id = id;
		this.rogueHealthPotionRewardPool = rogueHealthPotionRewardPool;
		this.rogueAssistCharacterRewardPool = rogueAssistCharacterRewardPool;
		this.rogueItemRewardPool = rogueItemRewardPool;
		this.rogueGold = rogueGold;
	}
}
