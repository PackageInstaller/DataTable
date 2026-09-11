using Google.Protobuf.Reflection;

namespace Config;

public enum RoleCategory
{
	[OriginalName("RoleCategory_None")]
	None,
	[OriginalName("RoleCategory_Human")]
	Human,
	[OriginalName("RoleCategory_Virtual")]
	Virtual,
	[OriginalName("RoleCategory_Metal")]
	Metal
}
