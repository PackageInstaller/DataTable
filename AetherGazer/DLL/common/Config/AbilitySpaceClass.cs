using Google.Protobuf.Reflection;

namespace Config;

public enum AbilitySpaceClass
{
	[OriginalName("AbilitySpaceClass_None")]
	None,
	[OriginalName("AbilitySpaceClass_Ground")]
	Ground,
	[OriginalName("AbilitySpaceClass_Air")]
	Air
}
