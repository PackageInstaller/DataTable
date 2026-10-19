using ACT.Config;

namespace ACT.World.Asset;

public interface IMiniGameData
{
	SeparateSegmentConfigs.Difficulty Difficulty { get; }

	bool UseMiniGame { get; }
}
