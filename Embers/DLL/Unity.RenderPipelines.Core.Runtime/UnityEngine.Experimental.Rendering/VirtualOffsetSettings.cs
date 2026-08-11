using System;

namespace UnityEngine.Experimental.Rendering;

[Serializable]
internal struct VirtualOffsetSettings
{
	public bool useVirtualOffset;

	public float outOfGeoOffset;

	public float searchMultiplier;
}
