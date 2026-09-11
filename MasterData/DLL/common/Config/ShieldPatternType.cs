using Google.Protobuf.Reflection;

namespace Config;

public enum ShieldPatternType
{
	[OriginalName("ShieldPatternType_NONE")]
	None,
	[OriginalName("ShieldPatternType_BY_VALUE")]
	ByValue,
	[OriginalName("ShieldPatternType_BY_TIME")]
	ByTime
}
