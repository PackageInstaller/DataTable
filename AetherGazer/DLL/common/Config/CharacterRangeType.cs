using Google.Protobuf.Reflection;

namespace Config;

public enum CharacterRangeType
{
	[OriginalName("CharacterRangeType_NONE")]
	None,
	[OriginalName("CharacterRangeType_Melee")]
	Melee,
	[OriginalName("CharacterRangeType_Ranged")]
	Ranged
}
