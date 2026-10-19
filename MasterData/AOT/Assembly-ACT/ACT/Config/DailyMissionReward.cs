using System;

namespace ACT.Config;

[Serializable]
public class DailyMissionReward
{
	public readonly int id;

	public readonly int creditRequire;

	public readonly int rewards;

	public readonly bool skipJumpTraverse;

	public DailyMissionReward(int id, int creditRequire, int rewards, bool skipJumpTraverse)
	{
		this.id = id;
		this.creditRequire = creditRequire;
		this.rewards = rewards;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
