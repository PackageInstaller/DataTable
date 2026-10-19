using System;

namespace UnityEngine.Rendering;

[Flags]
public enum BatchDrawCommandFlags
{
	None = 0,
	FlipWinding = 1,
	HasMotion = 2,
	IsLightMapped = 4,
	HasSortingPosition = 8,
	LODCrossFade = 0x10
}
