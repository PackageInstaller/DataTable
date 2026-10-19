using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class PlayerLevelData
{
	public readonly int id;

	public readonly int xpTotal;

	public readonly int xpEachLv;

	public readonly int rewardId;

	public readonly List<ItemKv> preconditionParam;

	public readonly bool worldLevelAdjustable;

	public readonly int worldLevelMax;

	public readonly int worldLevelMin;

	public readonly int characterLevel;

	public readonly int description;

	public readonly int[] systemId = new int[0];

	public PlayerLevelData(int id, int xpTotal, int xpEachLv, int rewardId, List<ItemKv> preconditionParam, bool worldLevelAdjustable, int worldLevelMax, int worldLevelMin, int characterLevel, int description, int[] systemId)
	{
		this.id = id;
		this.xpTotal = xpTotal;
		this.xpEachLv = xpEachLv;
		this.rewardId = rewardId;
		this.preconditionParam = preconditionParam;
		this.worldLevelAdjustable = worldLevelAdjustable;
		this.worldLevelMax = worldLevelMax;
		this.worldLevelMin = worldLevelMin;
		this.characterLevel = characterLevel;
		this.description = description;
		this.systemId = systemId;
	}
}
