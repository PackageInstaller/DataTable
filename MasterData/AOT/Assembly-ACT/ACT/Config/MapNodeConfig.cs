using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class MapNodeConfig
{
	public readonly int id;

	public readonly int difficulty;

	public readonly int mapNodeIndex;

	public readonly int seasonId;

	public readonly int gameWorldPoolId;

	public readonly int nodeType;

	public readonly int mapNodeRewardPool;

	public readonly int rogueHealthPotionDrawCount;

	public readonly int rogueAssistCharacterDrawCount;

	public readonly int rogueItemDrawCount;

	public readonly int totalTalentTokenRewardCount;

	public readonly List<ItemKv> totaltalentReward;

	public readonly List<ItemKv> shopTokenReward;

	public readonly List<ItemKv> totalShopTokenGained;

	public readonly int minionLevel;

	public readonly List<PropertiesMulti> minionPropertyFactor;

	public readonly int eliteLevel;

	public readonly List<PropertiesMulti> elitePropertyFactor;

	public readonly int bossLevel;

	public readonly List<PropertiesMulti> bossPropertyFactor;

	public MapNodeConfig(int id, int difficulty, int mapNodeIndex, int seasonId, int gameWorldPoolId, int nodeType, int mapNodeRewardPool, int rogueHealthPotionDrawCount, int rogueAssistCharacterDrawCount, int rogueItemDrawCount, int totalTalentTokenRewardCount, List<ItemKv> totaltalentReward, List<ItemKv> shopTokenReward, List<ItemKv> totalShopTokenGained, int minionLevel, List<PropertiesMulti> minionPropertyFactor, int eliteLevel, List<PropertiesMulti> elitePropertyFactor, int bossLevel, List<PropertiesMulti> bossPropertyFactor)
	{
		this.id = id;
		this.difficulty = difficulty;
		this.mapNodeIndex = mapNodeIndex;
		this.seasonId = seasonId;
		this.gameWorldPoolId = gameWorldPoolId;
		this.nodeType = nodeType;
		this.mapNodeRewardPool = mapNodeRewardPool;
		this.rogueHealthPotionDrawCount = rogueHealthPotionDrawCount;
		this.rogueAssistCharacterDrawCount = rogueAssistCharacterDrawCount;
		this.rogueItemDrawCount = rogueItemDrawCount;
		this.totalTalentTokenRewardCount = totalTalentTokenRewardCount;
		this.totaltalentReward = totaltalentReward;
		this.shopTokenReward = shopTokenReward;
		this.totalShopTokenGained = totalShopTokenGained;
		this.minionLevel = minionLevel;
		this.minionPropertyFactor = minionPropertyFactor;
		this.eliteLevel = eliteLevel;
		this.elitePropertyFactor = elitePropertyFactor;
		this.bossLevel = bossLevel;
		this.bossPropertyFactor = bossPropertyFactor;
	}
}
