using System;

namespace ACT.Config;

[Serializable]
public class MissionFocusModeData
{
	public readonly int id;

	public readonly int groupId;

	public readonly int chunkId;

	public readonly int npcId;

	public MissionFocusModeData(int id, int groupId, int chunkId, int npcId)
	{
		this.id = id;
		this.groupId = groupId;
		this.chunkId = chunkId;
		this.npcId = npcId;
	}
}
