using Google.Protobuf.Reflection;

namespace Config;

public enum CDReturn
{
	[OriginalName("CDReturn_None")]
	None = 0,
	[OriginalName("CDReturn_LongReady")]
	LongReady = 20,
	[OriginalName("CDReturn_ShoRtReady")]
	ShoRtReady = 40,
	[OriginalName("CDReturn_Looping")]
	Looping = 30,
	[OriginalName("CDReturn_All")]
	All = 100
}
