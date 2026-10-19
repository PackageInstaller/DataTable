using System;

namespace ACT.Config;

[Serializable]
public class MissionGroup
{
	public readonly int id;

	public readonly int[] missionId = new int[0];

	public readonly int conditional;

	public readonly int groupDes;

	public MissionGroup(int id, int[] missionId, int conditional, int groupDes)
	{
		this.id = id;
		this.missionId = missionId;
		this.conditional = conditional;
		this.groupDes = groupDes;
	}
}
