using Google.Protobuf.Reflection;

namespace Config;

public enum AttributeCalcType
{
	[OriginalName("AttributeCalcType_None")]
	None,
	[OriginalName("AttributeCalcType_Add")]
	Add,
	[OriginalName("AttributeCalcType_AddMul")]
	AddMul,
	[OriginalName("AttributeCalcType_SubMul")]
	SubMul
}
