using System;

namespace ACT.Config;

[Serializable]
public class AppStoreReviewPrompt
{
	public readonly int id;

	public readonly int promptType;

	public readonly int missionGroupId;

	public AppStoreReviewPrompt(int id, int promptType, int missionGroupId)
	{
		this.id = id;
		this.promptType = promptType;
		this.missionGroupId = missionGroupId;
	}
}
