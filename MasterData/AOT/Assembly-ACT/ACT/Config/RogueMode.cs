using System;

namespace ACT.Config;

[Serializable]
public class RogueMode
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int difficulty;

	public readonly int seasonId;

	public readonly int unlockRequiredRogueModeId;

	public readonly int unlockRequiredPlayerLevel;

	public readonly int[] mapNodeList = new int[0];

	public readonly int rogueRecommendedLevel;

	public readonly int[] entityCharacterProbationIds = new int[0];

	public RogueMode(int id, int name, int description, int difficulty, int seasonId, int unlockRequiredRogueModeId, int unlockRequiredPlayerLevel, int[] mapNodeList, int rogueRecommendedLevel, int[] entityCharacterProbationIds)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.difficulty = difficulty;
		this.seasonId = seasonId;
		this.unlockRequiredRogueModeId = unlockRequiredRogueModeId;
		this.unlockRequiredPlayerLevel = unlockRequiredPlayerLevel;
		this.mapNodeList = mapNodeList;
		this.rogueRecommendedLevel = rogueRecommendedLevel;
		this.entityCharacterProbationIds = entityCharacterProbationIds;
	}
}
