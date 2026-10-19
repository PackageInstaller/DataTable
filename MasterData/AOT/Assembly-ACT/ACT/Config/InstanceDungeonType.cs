using System;

namespace ACT.Config;

[Serializable]
public class InstanceDungeonType
{
	public readonly int id;

	public readonly int instanceDungeonTypeName;

	public readonly int instanceDungeonTipsTitile;

	public readonly int instanceDungeonTips;

	public readonly bool showRecommendLevel;

	public readonly bool powerUpGuide;

	public InstanceDungeonType(int id, int instanceDungeonTypeName, int instanceDungeonTipsTitile, int instanceDungeonTips, bool showRecommendLevel, bool powerUpGuide)
	{
		this.id = id;
		this.instanceDungeonTypeName = instanceDungeonTypeName;
		this.instanceDungeonTipsTitile = instanceDungeonTipsTitile;
		this.instanceDungeonTips = instanceDungeonTips;
		this.showRecommendLevel = showRecommendLevel;
		this.powerUpGuide = powerUpGuide;
	}
}
