using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum UniversalItemTag
{
	[OriginalName("UNIVERSAL_ITEM_TAG_DEFAULT")]
	Default,
	[OriginalName("UNIVERSAL_ITEM_TAG_EXTRA")]
	Extra,
	[OriginalName("UNIVERSAL_ITEM_TAG_TARGET_ONE")]
	TargetOne,
	[OriginalName("UNIVERSAL_ITEM_TAG_TARGET_TWO")]
	TargetTwo,
	[OriginalName("UNIVERSAL_ITEM_TAG_TARGET_THREE")]
	TargetThree
}
