using System;

namespace ACT.Config;

[Serializable]
public class RaidTypeDes
{
	public readonly int id;

	public readonly int typeDes;

	public readonly bool showRecommendLevel;

	public readonly bool powerUpGuide;

	public RaidTypeDes(int id, int typeDes, bool showRecommendLevel, bool powerUpGuide)
	{
		this.id = id;
		this.typeDes = typeDes;
		this.showRecommendLevel = showRecommendLevel;
		this.powerUpGuide = powerUpGuide;
	}
}
