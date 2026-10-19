using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum ActivitEggType
{
	[OriginalName("EGG_NULL")]
	EggNull,
	[OriginalName("EGG_REWARD")]
	EggReward,
	[OriginalName("EGG_BOSS")]
	EggBoss,
	[OriginalName("EGG_DUNGEON")]
	EggDungeon,
	[OriginalName("EGG_TREASURE")]
	EggTreasure
}
