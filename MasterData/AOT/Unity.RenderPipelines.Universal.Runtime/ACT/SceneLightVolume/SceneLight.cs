using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT.SceneLightVolume;

[Serializable]
[VolumeComponentMenu("Custom/SceneLight")]
public sealed class SceneLight : VolumeComponent, IPostProcessComponent
{
	[Serializable]
	public sealed class MaterialParameter : VolumeParameter<Material>
	{
		public MaterialParameter(Material value, bool overrideState = false)
			: base(value, overrideState)
		{
		}
	}

	[Serializable]
	public sealed class SceneLightLayerParameter : VolumeParameter<LightLayerEnum>
	{
		public SceneLightLayerParameter(LightLayerEnum value, bool overrideState = false)
			: base(value, overrideState)
		{
		}
	}

	[Serializable]
	public sealed class FogModeParameter : VolumeParameter<FogMode>
	{
		public FogModeParameter(FogMode value, bool overrideState = false)
			: base(value, overrideState)
		{
		}
	}

	[Serializable]
	public sealed class AmbientModeParameter : VolumeParameter<AmbientMode>
	{
		public AmbientModeParameter(AmbientMode value, bool overrideState = false)
			: base(value, overrideState)
		{
		}
	}

	public ClampedFloatParameter intensity = new ClampedFloatParameter(0f, 0f, 1f, overrideState: true);

	public BoolParameter lightIsExist = new BoolParameter(value: true, overrideState: true);

	public ColorParameter mainLightColor = new ColorParameter(Color.white, hdr: false, showAlpha: false, showEyeDropper: false, overrideState: true);

	public FloatParameter mainLightIntensity = new FloatParameter(1f, overrideState: true);

	public Vector3Parameter mainLightDir = new Vector3Parameter(Vector3.forward, overrideState: true);

	public FloatParameter mainLightshadowStrength = new FloatParameter(1f, overrideState: true);

	public SceneLightLayerParameter lightLayer = new SceneLightLayerParameter(LightLayerEnum.LightLayer1, overrideState: true);

	public BoolParameter playerPointLightEnabled = new BoolParameter(value: false);

	public ColorParameter playerPointLightColor = new ColorParameter(Color.white, hdr: false, showAlpha: false, showEyeDropper: false);

	public MinFloatParameter playerPointLightIntensity = new MinFloatParameter(1f, 0f);

	public MaterialParameter skyMaterial = new MaterialParameter(null);

	public BoolParameter isFogOn = new BoolParameter(value: false, overrideState: true);

	public ColorParameter fogColor = new ColorParameter(Color.white, overrideState: true);

	public FogModeParameter fogMode = new FogModeParameter(FogMode.Linear, overrideState: true);

	public FloatParameter fogStartDistance = new FloatParameter(0f, overrideState: true);

	public FloatParameter fogEndDistance = new FloatParameter(50f, overrideState: true);

	public MinFloatParameter fogDensity = new MinFloatParameter(0f, 0f, overrideState: true);

	public ColorParameter ShadowColorGround = new ColorParameter(new Color(0f, 0f, 0f, 0f), hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public ColorParameter ShadowColorHorzion = new ColorParameter(new Color(0f, 0f, 0f, 0f), hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public ColorParameter ShadowColorSky = new ColorParameter(new Color(0f, 0f, 0f, 0f), hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public Vector3Parameter HalfShadowScatter = new Vector3Parameter(new Vector3(0.9f, 1.2f, 1.5f), overrideState: true);

	public SceneLightLayerParameter m_Shadows_Layer = new SceneLightLayerParameter(LightLayerEnum.LightLayer1, overrideState: true);

	public BoolParameter renderDefaultShadowLayerOnMobile = new BoolParameter(value: false, overrideState: true);

	public AmbientModeParameter m_Lighting_Environment_AmbientMode = new AmbientModeParameter(AmbientMode.Skybox, overrideState: true);

	public ColorParameter ambientColor = new ColorParameter(Color.gray, hdr: true, showAlpha: false, showEyeDropper: false, overrideState: true);

	public ColorParameter m_Lighting_Environment_EquatorColor = new ColorParameter(Color.white, hdr: true, showAlpha: false, showEyeDropper: false, overrideState: true);

	public ColorParameter m_Lighting_Environment_GroundColor = new ColorParameter(Color.white, hdr: true, showAlpha: false, showEyeDropper: false, overrideState: true);

	public bool IsActive()
	{
		return intensity.value > 0f;
	}

	public bool IsTileCompatible()
	{
		return false;
	}
}
