using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[VolumeComponentMenuForRenderPipeline("Custom/Inner World Filter Test", new Type[] { typeof(UniversalRenderPipeline) })]
public sealed class InnerWorldFilter : VolumeComponent, IPostProcessComponent
{
	public ClampedFloatParameter intensity = new ClampedFloatParameter(0f, 0f, 1f, overrideState: true);

	public ColorParameter tintColor = new ColorParameter(new Color(0.45f, 0.7f, 1f, 1f), hdr: true, showAlpha: false, showEyeDropper: false, overrideState: true);

	public ClampedFloatParameter tintStrength = new ClampedFloatParameter(0.5f, 0f, 1f, overrideState: true);

	public ClampedFloatParameter saturation = new ClampedFloatParameter(0.65f, 0f, 2f, overrideState: true);

	public ClampedFloatParameter contrast = new ClampedFloatParameter(1.15f, 0f, 2f, overrideState: true);

	public ClampedFloatParameter brightness = new ClampedFloatParameter(0f, -1f, 1f, overrideState: true);

	public BoolParameter invertMask = new BoolParameter(value: false, overrideState: true);

	public MinFloatParameter edgeFeather = new MinFloatParameter(1f, 0.001f, overrideState: true);

	public ClampedFloatParameter darkness = new ClampedFloatParameter(0.18f, 0f, 1f, overrideState: true);

	public ColorParameter edgeColor = new ColorParameter(new Color(0.1f, 0.85f, 1f, 1f), hdr: true, showAlpha: false, showEyeDropper: false, overrideState: true);

	public ClampedFloatParameter edgeIntensity = new ClampedFloatParameter(0.35f, 0f, 3f, overrideState: true);

	public ClampedFloatParameter grainIntensity = new ClampedFloatParameter(0.08f, 0f, 1f, overrideState: true);

	public ColorParameter rippleColor = new ColorParameter(new Color(0.35f, 0.35f, 1f, 1f), hdr: true, showAlpha: false, showEyeDropper: false, overrideState: true);

	public ClampedFloatParameter rippleIntensity = new ClampedFloatParameter(0.2f, 0f, 2f, overrideState: true);

	public MinFloatParameter rippleFrequency = new MinFloatParameter(9f, 0.001f, overrideState: true);

	public FloatParameter rippleSpeed = new FloatParameter(0.8f, overrideState: true);

	public ClampedFloatParameter causticsContrast = new ClampedFloatParameter(1f, 0f, 4f, overrideState: true);

	public ClampedFloatParameter edgeGlowSoftness = new ClampedFloatParameter(0.5f, 0f, 1f, overrideState: true);

	public ClampedFloatParameter edgeBreakup = new ClampedFloatParameter(0.35f, 0f, 1f, overrideState: true);

	public ClampedFloatParameter edgeChromatic = new ClampedFloatParameter(0.15f, 0f, 1f, overrideState: true);

	public ColorParameter innerShadowColorGround = new ColorParameter(new Color(0.08f, 0.12f, 0.18f, 1f), hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public ColorParameter innerShadowColorHorizon = new ColorParameter(new Color(0.12f, 0.18f, 0.28f, 1f), hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public ColorParameter innerShadowColorSky = new ColorParameter(new Color(0.18f, 0.28f, 0.4f, 1f), hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public ClampedFloatParameter innerShadowColorBlend = new ClampedFloatParameter(0f, 0f, 1f, overrideState: true);

	public ColorParameter innerLinearFogColor = new ColorParameter(new Color(0.12f, 0.28f, 0.42f, 1f), hdr: true, showAlpha: true, showEyeDropper: false, overrideState: true);

	public FloatParameter innerLinearFogStart = new FloatParameter(10f, overrideState: true);

	public FloatParameter innerLinearFogEnd = new FloatParameter(80f, overrideState: true);

	public ClampedFloatParameter innerLinearFogBlend = new ClampedFloatParameter(0f, 0f, 1f, overrideState: true);

	public ClampedFloatParameter distortionIntensity = new ClampedFloatParameter(0.2f, 0f, 1f, overrideState: true);

	public ClampedFloatParameter distortionStrength = new ClampedFloatParameter(6f, 0f, 32f, overrideState: true);

	public MinFloatParameter distortionFrequency = new MinFloatParameter(9f, 0.001f, overrideState: true);

	public ClampedFloatParameter edgeLensIntensity = new ClampedFloatParameter(0f, 0f, 1f, overrideState: true);

	public ClampedFloatParameter edgeLensWidth = new ClampedFloatParameter(0.35f, 0.01f, 1f, overrideState: true);

	public bool IsActive()
	{
		if (active)
		{
			return intensity.value > 0f;
		}
		return false;
	}

	internal bool RequiresGlobalShaderParams()
	{
		return active;
	}

	public bool IsTileCompatible()
	{
		return false;
	}
}
