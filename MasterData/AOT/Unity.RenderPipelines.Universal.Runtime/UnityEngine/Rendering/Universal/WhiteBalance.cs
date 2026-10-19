using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Post-processing/White Balance", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class WhiteBalance : VolumeComponent, IPostProcessComponent
{
	[Tooltip("Sets the white balance to a custom color temperature.")]
	public ClampedFloatParameter temperature = new ClampedFloatParameter(0f, -100f, 100f);

	[Tooltip("Sets the white balance to compensate for a green or magenta tint.")]
	public ClampedFloatParameter tint = new ClampedFloatParameter(0f, -100f, 100f);

	public bool IsActive()
	{
		if (temperature.value == 0f)
		{
			return tint.value != 0f;
		}
		return true;
	}

	public bool IsTileCompatible()
	{
		return true;
	}
}
