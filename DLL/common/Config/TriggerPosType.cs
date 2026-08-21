using Google.Protobuf.Reflection;

namespace Config;

public enum TriggerPosType
{
	[OriginalName("TriggerPosType_none")]
	None,
	[OriginalName("TriggerPosType_oneself")]
	Oneself,
	[OriginalName("TriggerPosType_target")]
	Target
}
