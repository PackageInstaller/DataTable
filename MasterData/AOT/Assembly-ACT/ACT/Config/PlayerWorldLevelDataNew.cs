using System;

namespace ACT.Config;

[Serializable]
public class PlayerWorldLevelDataNew
{
	public readonly int id;

	public readonly int maximumPlayerLevel;

	public readonly int missionId;

	public readonly int rewardId;

	public readonly int description;

	public PlayerWorldLevelDataNew(int id, int maximumPlayerLevel, int missionId, int rewardId, int description)
	{
		this.id = id;
		this.maximumPlayerLevel = maximumPlayerLevel;
		this.missionId = missionId;
		this.rewardId = rewardId;
		this.description = description;
	}
}
