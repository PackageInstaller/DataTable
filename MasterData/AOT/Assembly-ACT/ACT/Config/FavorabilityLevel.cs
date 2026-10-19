using System;

namespace ACT.Config;

[Serializable]
public class FavorabilityLevel
{
	public readonly int id;

	public readonly int characterId;

	public readonly int favorabilityLevel;

	public readonly int favorabilityTotal;

	public readonly int favorabilityEachLv;

	public readonly int favorabilityStage;

	public readonly int reward;

	public readonly int[] dramaId = new int[0];

	public readonly int[] pointId = new int[0];

	public readonly int[] storyId = new int[0];

	public readonly int[] audioId = new int[0];

	public FavorabilityLevel(int id, int characterId, int favorabilityLevel, int favorabilityTotal, int favorabilityEachLv, int favorabilityStage, int reward, int[] dramaId, int[] pointId, int[] storyId, int[] audioId)
	{
		this.id = id;
		this.characterId = characterId;
		this.favorabilityLevel = favorabilityLevel;
		this.favorabilityTotal = favorabilityTotal;
		this.favorabilityEachLv = favorabilityEachLv;
		this.favorabilityStage = favorabilityStage;
		this.reward = reward;
		this.dramaId = dramaId;
		this.pointId = pointId;
		this.storyId = storyId;
		this.audioId = audioId;
	}
}
