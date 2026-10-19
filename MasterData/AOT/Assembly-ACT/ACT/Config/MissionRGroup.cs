using System;

namespace ACT.Config;

[Serializable]
public class MissionRGroup
{
	public readonly int id;

	public readonly int chapterID;

	public readonly int description;

	public readonly int[] missions = new int[0];

	public readonly int firstMission;

	public readonly int lastMission;

	public readonly int collectionID;

	public readonly bool skipJumpTraverse;

	public readonly int chunkId;

	public MissionRGroup(int id, int chapterID, int description, int[] missions, int firstMission, int lastMission, int collectionID, bool skipJumpTraverse, int chunkId)
	{
		this.id = id;
		this.chapterID = chapterID;
		this.description = description;
		this.missions = missions;
		this.firstMission = firstMission;
		this.lastMission = lastMission;
		this.collectionID = collectionID;
		this.skipJumpTraverse = skipJumpTraverse;
		this.chunkId = chunkId;
	}
}
