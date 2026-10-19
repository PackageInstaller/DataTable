using System;

namespace ACT.Config;

[Serializable]
public class ExplorationReward
{
	public readonly int id;

	public readonly int areaTab;

	public readonly int areaId;

	public readonly int name;

	public readonly int rewardProgress;

	public readonly int collectionId;

	public ExplorationReward(int id, int areaTab, int areaId, int name, int rewardProgress, int collectionId)
	{
		this.id = id;
		this.areaTab = areaTab;
		this.areaId = areaId;
		this.name = name;
		this.rewardProgress = rewardProgress;
		this.collectionId = collectionId;
	}
}
