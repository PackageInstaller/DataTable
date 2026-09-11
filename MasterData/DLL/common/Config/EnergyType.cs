using Google.Protobuf.Reflection;

namespace Config;

public enum EnergyType
{
	[OriginalName("EnergyType_None")]
	None,
	[OriginalName("EnergyType_Rage")]
	Rage,
	[OriginalName("EnergyType_Power")]
	Power,
	[OriginalName("EnergyType_Mark")]
	Mark,
	[OriginalName("EnergyType_Unique")]
	Unique,
	[OriginalName("EnergyType_Tune")]
	Tune
}
