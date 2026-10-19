using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Post-processing/Shadows, Midtones, Highlights", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class ShadowsMidtonesHighlights : VolumeComponent, IPostProcessComponent
{
	[Tooltip("Use this to control and apply a hue to the shadows.")]
	public Vector4Parameter shadows = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Use this to control and apply a hue to the midtones.")]
	public Vector4Parameter midtones = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Use this to control and apply a hue to the highlights.")]
	public Vector4Parameter highlights = new Vector4Parameter(new Vector4(1f, 1f, 1f, 0f));

	[Tooltip("Start point of the transition between shadows and midtones.")]
	[Header("Shadow Limits")]
	public MinFloatParameter shadowsStart = new MinFloatParameter(0f, 0f);

	[Tooltip("End point of the transition between shadows and midtones.")]
	public MinFloatParameter shadowsEnd = new MinFloatParameter(0.3f, 0f);

	[Header("Highlight Limits")]
	[Tooltip("Start point of the transition between midtones and highlights.")]
	public MinFloatParameter highlightsStart = new MinFloatParameter(0.55f, 0f);

	[Tooltip("End point of the transition between midtones and highlights.")]
	public MinFloatParameter highlightsEnd = new MinFloatParameter(1f, 0f);

	public bool IsActive()
	{
		Vector4 vector = new Vector4(1f, 1f, 1f, 0f);
		if (!(shadows != vector) && !(midtones != vector))
		{
			return highlights != vector;
		}
		return true;
	}

	public bool IsTileCompatible()
	{
		return true;
	}
}
