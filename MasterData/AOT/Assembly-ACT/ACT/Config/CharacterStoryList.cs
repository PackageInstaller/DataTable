using System;

namespace ACT.Config;

[Serializable]
public class CharacterStoryList
{
	public readonly int id;

	public readonly int[] storyId = new int[0];

	public readonly int[] pointId = new int[0];

	public CharacterStoryList(int id, int[] storyId, int[] pointId)
	{
		this.id = id;
		this.storyId = storyId;
		this.pointId = pointId;
	}
}
