using Google.Protobuf.Reflection;

namespace Config;

public enum RaceType
{
	[OriginalName("RaceType_none")]
	None,
	[OriginalName("RaceType_RaceGreece")]
	RaceGreece,
	[OriginalName("RaceType_RaceEgypt")]
	RaceEgypt,
	[OriginalName("RaceType_RaceJapan")]
	RaceJapan,
	[OriginalName("RaceType_RaceNorthernEurope")]
	RaceNorthernEurope,
	[OriginalName("RaceType_Other")]
	Other,
	[OriginalName("RaceType_RaceHuman")]
	RaceHuman,
	[OriginalName("RaceType_RaceBug")]
	RaceBug,
	[OriginalName("RaceType_RaceMachine")]
	RaceMachine,
	[OriginalName("RaceType_RaceChina")]
	RaceChina,
	[OriginalName("RaceType_RaceOtherEnemy")]
	RaceOtherEnemy
}
