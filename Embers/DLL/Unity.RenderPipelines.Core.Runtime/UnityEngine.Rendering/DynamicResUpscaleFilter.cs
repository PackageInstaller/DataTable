using System;

namespace UnityEngine.Rendering;

public enum DynamicResUpscaleFilter : byte
{
	[Obsolete("Bilinear upscale filter is considered obsolete and is not supported anymore, please use CatmullRom for a very cheap, but blurry filter.", false)]
	Bilinear,
	CatmullRom,
	[Obsolete("Lanczos upscale filter is considered obsolete and is not supported anymore, please use Contrast Adaptive Sharpening for very sharp filter or FidelityFX Super Resolution 1.0.", false)]
	Lanczos,
	ContrastAdaptiveSharpen,
	[InspectorName("FidelityFX Super Resolution 1.0")]
	EdgeAdaptiveScalingUpres,
	[InspectorName("TAA Upscale")]
	TAAU
}
