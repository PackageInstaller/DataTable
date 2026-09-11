using System;

namespace UnityEngine.Rendering;

[Flags]
public enum CustomMarkerCallbackFlags
{
	CustomMarkerCallbackDefault = 0,
	CustomMarkerCallbackForceInvalidateStateTracking = 4
}
