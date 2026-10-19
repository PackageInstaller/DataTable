using System;

namespace ACT.Game.Data;

public struct FeatureData
{
	[Flags]
	public enum FeatureSourceType
	{
		Equip = 1,
		Gem = 2
	}

	public FeatureSourceType FeatureSource { get; set; }

	public int Data { get; set; }
}
