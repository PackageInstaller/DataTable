using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Post-processing/Tonemapping", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class Tonemapping : VolumeComponent, IPostProcessComponent
{
	[Tooltip("Select a tonemapping algorithm to use for the color grading process.")]
	public TonemappingModeParameter mode = new TonemappingModeParameter(TonemappingMode.None);

	public ClampedFloatParameter ACESType = new ClampedFloatParameter(0f, 0f, 1f);

	public bool IsActive()
	{
		return mode.value != TonemappingMode.None;
	}

	public bool IsTileCompatible()
	{
		return true;
	}
}
