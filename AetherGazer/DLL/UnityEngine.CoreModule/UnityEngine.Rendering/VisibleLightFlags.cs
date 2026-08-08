using System;

namespace UnityEngine.Rendering;

[Flags]
internal enum VisibleLightFlags
{
	IntersectsNearPlane = 1,
	IntersectsFarPlane = 2
}
