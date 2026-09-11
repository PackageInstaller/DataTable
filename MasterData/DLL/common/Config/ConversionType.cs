using Google.Protobuf.Reflection;

namespace Config;

public enum ConversionType
{
	[OriginalName("ConversionType_none")]
	None,
	[OriginalName("ConversionType_fixed")]
	Fixed,
	[OriginalName("ConversionType_percentage")]
	Percentage
}
