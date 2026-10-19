using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityCharacterLevelData
{
	public readonly int id;

	public readonly int character;

	public readonly int stage;

	public readonly int levelMax;

	public readonly List<ItemKv> breakRequirement;

	public readonly int[] newSkill = new int[0];

	public readonly List<Properties> gainProperty;

	public readonly List<ItemKv> preconditionParam;

	public readonly int rewardId;

	public readonly int chipSpace;

	public EntityCharacterLevelData(int id, int character, int stage, int levelMax, List<ItemKv> breakRequirement, int[] newSkill, List<Properties> gainProperty, List<ItemKv> preconditionParam, int rewardId, int chipSpace)
	{
		this.id = id;
		this.character = character;
		this.stage = stage;
		this.levelMax = levelMax;
		this.breakRequirement = breakRequirement;
		this.newSkill = newSkill;
		this.gainProperty = gainProperty;
		this.preconditionParam = preconditionParam;
		this.rewardId = rewardId;
		this.chipSpace = chipSpace;
	}
}
