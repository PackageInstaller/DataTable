using System;

namespace ACT.Config;

[Serializable]
public class LoungeStory
{
	public readonly int id;

	public readonly int[] characterId = new int[0];

	public readonly int type;

	public readonly int storyType;

	public readonly int areaId;

	public readonly int[] pointId = new int[0];

	public readonly int priority;

	public readonly int missionGroupId;

	public readonly long[] timeLimit = new long[0];

	public readonly string address = "";

	public readonly int storyText;

	public readonly int[] pointList = new int[0];

	public LoungeStory(int id, int[] characterId, int type, int storyType, int areaId, int[] pointId, int priority, int missionGroupId, long[] timeLimit, string address, int storyText, int[] pointList)
	{
		this.id = id;
		this.characterId = characterId;
		this.type = type;
		this.storyType = storyType;
		this.areaId = areaId;
		this.pointId = pointId;
		this.priority = priority;
		this.missionGroupId = missionGroupId;
		this.timeLimit = timeLimit;
		this.address = address;
		this.storyText = storyText;
		this.pointList = pointList;
	}
}
