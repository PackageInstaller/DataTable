using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Post-processing/Split Toning", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class SplitToning : VolumeComponent, IPostProcessComponent
{
	[Tooltip("The color to use for shadows.")]
	public ColorParameter shadows = new ColorParameter(Color.grey, hdr: false, showAlpha: false, showEyeDropper: true);

	[Tooltip("The color to use for highlights.")]
	public ColorParameter highlights = new ColorParameter(Color.grey, hdr: false, showAlpha: false, showEyeDropper: true);

	[Tooltip("Balance between the colors in the highlights and shadows.")]
	public ClampedFloatParameter balance = new ClampedFloatParameter(0f, -100f, 100f);

	public bool IsActive()
	{
		if (!(shadows != Color.grey))
		{
			return highlights != Color.grey;
		}
		return true;
	}

	public bool IsTileCompatible()
	{
		return true;
	}
}
