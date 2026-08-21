using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[StaticAccessor("GetUncheckedRealGfxDevice().GetFrameTimingManager()", StaticAccessorType.Dot)]
public static class FrameTimingManager
{
	[MethodImpl((MethodImplOptions)4096)]
	public static extern void CaptureFrameTimings();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern uint GetLatestTimings(uint numFrames, [Unmarshalled] FrameTiming[] timings);
}
