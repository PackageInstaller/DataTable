using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Post-processing/Temporal Depth Of Field", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class TemporalDepthOfField : VolumeComponent, IPostProcessComponent
{
	[Tooltip("Enables the independent temporal depth of field path.")]
	public BoolParameter enabled = new BoolParameter(value: false);

	[Tooltip("Distance where far-field blur begins. The reference capture uses 9 meters.")]
	public MinFloatParameter farStart = new MinFloatParameter(9f, 0f);

	[Tooltip("Distance where far-field blur reaches its full strength. The reference uses 20 meters.")]
	public MinFloatParameter farEnd = new MinFloatParameter(20f, 0f);

	[Tooltip("Multiplier for the fixed complex separable kernel. At 1.0 the runtime scales it by render height / 1200, reproducing the captured 0.7916667 value at 950 pixels high.")]
	public ClampedFloatParameter kernelScale = new ClampedFloatParameter(1f, 0.05f, 16f);

	[Tooltip("Maximum previous-frame contribution used by the half-resolution temporal prefilter.")]
	public ClampedFloatParameter temporalFeedback = new ClampedFloatParameter(0.95f, 0f, 0.98f);

	[Tooltip("CoC difference that reduces temporal history to 1/e. The captured shader uses 0.1.")]
	public ClampedFloatParameter historyCoCThreshold = new ClampedFloatParameter(0.1f, 0.01f, 1f);

	[Tooltip("ReferenceHalf matches the capture. PerformanceQuarter keeps the same full-resolution blur size at one quarter working resolution.")]
	public TemporalDepthOfFieldQualityParameter quality = new TemporalDepthOfFieldQualityParameter(TemporalDepthOfFieldQuality.ReferenceHalf);

	public bool IsActive()
	{
		if (enabled.value && kernelScale.value > 0f)
		{
			return farEnd.value > farStart.value;
		}
		return false;
	}

	public bool IsTileCompatible()
	{
		return false;
	}
}
