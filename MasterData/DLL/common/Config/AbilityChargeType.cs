using Google.Protobuf.Reflection;

namespace Config;

public enum AbilityChargeType
{
	[OriginalName("AbilityChargeType_None")]
	None,
	[OriginalName("AbilityChargeType_Serial")]
	Serial,
	[OriginalName("AbilityChargeType_Parallel")]
	Parallel
}
