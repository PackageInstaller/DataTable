using System;

namespace UnityEngine;

[Flags]
public enum TerrainQualityOverrides
{
	None = 0,
	PixelError = 1,
	BasemapDistance = 2,
	DetailDensity = 4,
	DetailDistance = 8,
	TreeDistance = 0x10,
	BillboardStart = 0x20,
	FadeLength = 0x40,
	MaxTrees = 0x80
}
