using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/GfxDevice/FrameTiming.h")]
public struct FrameTiming
{
	[NativeName("totalFrameTime")]
	public double cpuFrameTime;

	[NativeName("mainThreadActiveTime")]
	public double cpuMainThreadFrameTime;

	[NativeName("mainThreadPresentWaitTime")]
	public double cpuMainThreadPresentWaitTime;

	[NativeName("renderThreadActiveTime")]
	public double cpuRenderThreadFrameTime;

	[NativeName("gpuFrameTime")]
	public double gpuFrameTime;

	[NativeName("frameStartTimestamp")]
	public ulong frameStartTimestamp;

	[NativeName("firstSubmitTimestamp")]
	public ulong firstSubmitTimestamp;

	[NativeName("presentFrameTimestamp")]
	public ulong cpuTimePresentCalled;

	[NativeName("frameCompleteTimestamp")]
	public ulong cpuTimeFrameComplete;

	[NativeName("heightScale")]
	public float heightScale;

	[NativeName("widthScale")]
	public float widthScale;

	[NativeName("syncInterval")]
	public uint syncInterval;
}
