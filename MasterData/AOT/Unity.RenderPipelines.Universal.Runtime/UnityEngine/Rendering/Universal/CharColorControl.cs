using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Post-processing/Character Color Control", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class CharColorControl : VolumeComponent, IPostProcessComponent
{
	[Tooltip("Use this to control and apply a hue to the dark tones. This has a more exaggerated effect on shadows.")]
	public Vector4Parameter lift = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Use this to control and apply a hue to the mid-range tones with a power function.")]
	public Vector4Parameter gamma = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Use this to increase and apply a hue to the signal and make highlights brighter.")]
	public Vector4Parameter gain = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Use this to control and apply a hue to the shadows.")]
	public Vector4Parameter shadows = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Use this to control and apply a hue to the midtones.")]
	public Vector4Parameter midtones = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Use this to control and apply a hue to the highlights.")]
	public Vector4Parameter highlights = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Adjusts the overall exposure of the scene in EV100. This is applied after HDR effect and right before tonemapping so it won't affect previous effects in the chain.")]
	public FloatParameter postExposure = new FloatParameter(0f);

	[Tooltip("Expands or shrinks the overall range of tonal values.")]
	public ClampedFloatParameter contrast = new ClampedFloatParameter(0f, -100f, 100f);

	[Tooltip("Shift the hue of all colors.")]
	public ClampedFloatParameter hueShift = new ClampedFloatParameter(0f, -180f, 180f);

	[Tooltip("Pushes the intensity of all colors.")]
	public ClampedFloatParameter saturation = new ClampedFloatParameter(0f, -100f, 100f);

	public bool IsActive()
	{
		if (IsDefaultColorControl(lift.value) && IsDefaultColorControl(gamma.value) && IsDefaultColorControl(gain.value) && IsDefaultColorControl(shadows.value) && IsDefaultColorControl(midtones.value) && IsDefaultColorControl(highlights.value) && Mathf.Approximately(postExposure.value, 0f) && Mathf.Approximately(contrast.value, 0f) && Mathf.Approximately(hueShift.value, 0f))
		{
			return !Mathf.Approximately(saturation.value, 0f);
		}
		return true;
	}

	public bool IsTileCompatible()
	{
		return true;
	}

	private static bool IsDefaultColorControl(Vector4 value)
	{
		return value == new Vector4(1f, 1f, 1f, 0f);
	}
}
