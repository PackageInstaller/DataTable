using Google.Protobuf.Reflection;

namespace Config;

public enum TargetCampType
{
	[OriginalName("TargetCampType_none")]
	None,
	[OriginalName("TargetCampType_we")]
	We,
	[OriginalName("TargetCampType_enemy")]
	Enemy,
	[OriginalName("TargetCampType_oneself")]
	Oneself,
	[OriginalName("TargetCampType_all")]
	All
}
