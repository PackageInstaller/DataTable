using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class InstanceDungeonStarReward
{
	public readonly int id;

	public readonly int area;

	public readonly int stars;

	public readonly List<ItemKv> reward;

	public readonly bool skipJumpTraverse;

	public InstanceDungeonStarReward(int id, int area, int stars, List<ItemKv> reward, bool skipJumpTraverse)
	{
		this.id = id;
		this.area = area;
		this.stars = stars;
		this.reward = reward;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
