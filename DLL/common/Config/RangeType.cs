using Google.Protobuf.Reflection;

namespace Config;

public enum RangeType
{
	[OriginalName("RangeType_none")]
	None,
	[OriginalName("RangeType_straightline")]
	Straightline,
	[OriginalName("RangeType_sector")]
	Sector,
	[OriginalName("RangeType_roundness")]
	Roundness,
	[OriginalName("RangeType_rectangle")]
	Rectangle,
	[OriginalName("RangeType_multi_direction")]
	MultiDirection,
	[OriginalName("RangeType_annulus")]
	Annulus,
	[OriginalName("RangeType_annular_sector")]
	AnnularSector
}
