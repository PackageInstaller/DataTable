using System;

namespace ACT.World;

public enum MapArea
{
	None = 0,
	[Obsolete("目标世界id为0, 暂时不用")]
	Arsenal = 1001,
	Aurum = 1002,
	[Obsolete("目标世界id为0, 暂时不用")]
	Sewer = 1003,
	TEPC = 1004,
	Void = 1005,
	Crater = 1006,
	Walkure = 1007,
	CraterBottom = 1008,
	MirrorCave = 1009,
	Raid = 9999
}
