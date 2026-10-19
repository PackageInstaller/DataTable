using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum ActivitType
{
	[OriginalName("ACTICITY_BASE")]
	ActicityBase,
	[OriginalName("ACTICITY_LEVEL_REWARD")]
	ActicityLevelReward,
	[OriginalName("ACTICITY_DOUBLE_DUNGEON")]
	ActicityDoubleDungeon
}
