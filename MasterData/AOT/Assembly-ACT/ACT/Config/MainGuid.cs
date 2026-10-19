using System;

namespace ACT.Config;

[Serializable]
public class MainGuid
{
	public readonly int id;

	public readonly int name;

	public readonly int unlockMissionRequire;

	public readonly int unlockRewardsRequire;

	public readonly int[] missionGroupID = new int[0];

	public readonly int[] missionRewards = new int[0];

	public readonly int chapterRewards;

	public MainGuid(int id, int name, int unlockMissionRequire, int unlockRewardsRequire, int[] missionGroupID, int[] missionRewards, int chapterRewards)
	{
		this.id = id;
		this.name = name;
		this.unlockMissionRequire = unlockMissionRequire;
		this.unlockRewardsRequire = unlockRewardsRequire;
		this.missionGroupID = missionGroupID;
		this.missionRewards = missionRewards;
		this.chapterRewards = chapterRewards;
	}
}
