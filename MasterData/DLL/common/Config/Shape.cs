using Google.Protobuf.Reflection;

namespace Config;

public enum Shape
{
	[OriginalName("Shape_NONE")]
	None,
	[OriginalName("Shape_CIRCLE")]
	Circle,
	[OriginalName("Shape_SECTOR")]
	Sector
}
