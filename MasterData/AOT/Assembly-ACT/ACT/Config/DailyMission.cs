using System;

namespace ACT.Config;

[Serializable]
public class DailyMission
{
	public readonly int id;

	public readonly int groupID;

	public readonly int missionRewards;

	public readonly int jumpID;

	public DailyMission(int id, int groupID, int missionRewards, int jumpID)
	{
		this.id = id;
		this.groupID = groupID;
		this.missionRewards = missionRewards;
		this.jumpID = jumpID;
	}
}
