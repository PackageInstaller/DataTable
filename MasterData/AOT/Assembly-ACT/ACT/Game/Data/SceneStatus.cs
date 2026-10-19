using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum SceneStatus
{
	[OriginalName("MAIN")]
	Main,
	[OriginalName("RAID")]
	Raid,
	[OriginalName("ABYSS")]
	Abyss,
	[OriginalName("ROGUE")]
	Rogue,
	[OriginalName("TRAININGGROUND")]
	Trainingground,
	[OriginalName("TEMPLE")]
	Temple,
	[OriginalName("LOUNGE")]
	Lounge
}
