using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT.SceneLightVolume;

public class SceneLightManager : MonoBehaviour
{
	private class ACTVolumeParam<T>
	{
		private T m_Value;

		private float m_FloatValue;

		public ACTVolumeParam(T input)
		{
			m_Value = input;
		}

		public ACTVolumeParam(float input)
		{
			m_FloatValue = input;
		}

		public void SetValue(T input)
		{
			if (anyValueChanged)
			{
				m_Value = input;
			}
			else if (!EqualityComparer<T>.Default.Equals(m_Value, input))
			{
				anyValueChanged = true;
				m_Value = input;
			}
		}

		public void SetValue(float input)
		{
			if (anyValueChanged)
			{
				m_FloatValue = input;
			}
			else if (!((double)Mathf.Abs(input - m_FloatValue) < 1E-05))
			{
				anyValueChanged = true;
				m_FloatValue = input;
			}
		}

		public T GetValue()
		{
			return m_Value;
		}

		public float GetFloat()
		{
			return m_FloatValue;
		}
	}

	private const int PlayerPointLightCount = 2;

	private Light m_MainLight;

	private UniversalAdditionalLightData m_LightData;

	private SceneLight m_SceneLight;

	private static readonly Light[] s_PlayerPointLights = new Light[2];

	private static readonly bool[] s_PlayerPointLightHasTargets = new bool[2];

	private int m_VolumeCacheVersion = -1;

	private bool m_TriedFallbackSceneLight;

	private ColorAdjustments m_SrcColorAdjustments;

	private ACTVolumeParam<float> m_Intensity = new ACTVolumeParam<float>(0f);

	private ACTVolumeParam<Color> m_MainLightColor = new ACTVolumeParam<Color>(Color.white);

	private ACTVolumeParam<float> m_MainLightDensity = new ACTVolumeParam<float>(0f);

	private ACTVolumeParam<bool> m_MainLightShadowsEnabled = new ACTVolumeParam<bool>(input: false);

	private ACTVolumeParam<LightLayerEnum> m_Shadows_Layer = new ACTVolumeParam<LightLayerEnum>(LightLayerEnum.LightLayer1);

	private ACTVolumeParam<bool> m_RenderDefaultShadowLayerOnMobile = new ACTVolumeParam<bool>(input: false);

	private ACTVolumeParam<float> m_ShadowStrength = new ACTVolumeParam<float>(0f);

	private ACTVolumeParam<Quaternion> m_MainLightDir = new ACTVolumeParam<Quaternion>(Quaternion.identity);

	private ACTVolumeParam<Color> m_shadowColorGround = new ACTVolumeParam<Color>(Color.black);

	private ACTVolumeParam<Color> m_shadowColorHorizon = new ACTVolumeParam<Color>(Color.black);

	private ACTVolumeParam<Color> m_shadowColorSky = new ACTVolumeParam<Color>(Color.black);

	private ACTVolumeParam<Vector3> m_HalfShadowScatter = new ACTVolumeParam<Vector3>(new Vector3(1f, 1.4f, 1.5f));

	private ACTVolumeParam<Material> m_SkyMaterial = new ACTVolumeParam<Material>(null);

	private ACTVolumeParam<bool> m_FogOpen = new ACTVolumeParam<bool>(input: false);

	private ACTVolumeParam<Color> m_FogColor = new ACTVolumeParam<Color>(Color.white);

	private ACTVolumeParam<FogMode> m_FogMode = new ACTVolumeParam<FogMode>(FogMode.Linear);

	private ACTVolumeParam<float> m_FogDensity = new ACTVolumeParam<float>(0f);

	private ACTVolumeParam<float> m_FogStartDistance = new ACTVolumeParam<float>(0f);

	private ACTVolumeParam<float> m_FogEndDistance = new ACTVolumeParam<float>(0f);

	private ACTVolumeParam<LightLayerEnum> m_lightLayer = new ACTVolumeParam<LightLayerEnum>(LightLayerEnum.LightLayerDefault);

	private ACTVolumeParam<AmbientMode> m_Lighting_Environment_AmbientMode = new ACTVolumeParam<AmbientMode>(AmbientMode.Skybox);

	private ACTVolumeParam<Color> m_AmbientColor = new ACTVolumeParam<Color>(Color.white);

	private ACTVolumeParam<Color> m_Lighting_Environment_EquatorColor = new ACTVolumeParam<Color>(Color.white);

	private ACTVolumeParam<Color> m_Lighting_Environment_GroundColor = new ACTVolumeParam<Color>(Color.white);

	private bool m_UseLight;

	private static bool anyValueChanged;

	public static void RegisterPlayerPointLight(Light pointLight)
	{
		if (pointLight == null || pointLight.type != LightType.Point)
		{
			return;
		}
		pointLight.enabled = false;
		for (int i = 0; i < 2; i++)
		{
			if (s_PlayerPointLights[i] == pointLight)
			{
				s_PlayerPointLightHasTargets[i] = false;
				return;
			}
		}
		for (int j = 0; j < 2; j++)
		{
			if (s_PlayerPointLights[j] == null)
			{
				s_PlayerPointLights[j] = pointLight;
				s_PlayerPointLightHasTargets[j] = false;
				return;
			}
		}
		Debug.LogWarning("Only two PlayerPointLightFollower lights can be registered at the same time.");
	}

	public static void SetPlayerPointLightTargetAvailable(Light pointLight, bool hasTarget)
	{
		for (int i = 0; i < 2; i++)
		{
			if (s_PlayerPointLights[i] == pointLight)
			{
				s_PlayerPointLightHasTargets[i] = hasTarget;
				break;
			}
		}
	}

	public static void UnregisterPlayerPointLight(Light pointLight)
	{
		if (pointLight == null)
		{
			return;
		}
		for (int i = 0; i < 2; i++)
		{
			if (s_PlayerPointLights[i] == pointLight)
			{
				pointLight.enabled = false;
				s_PlayerPointLights[i] = null;
				s_PlayerPointLightHasTargets[i] = false;
				break;
			}
		}
	}

	private void OnEnable()
	{
		Light[] componentsInChildren = gameObject.GetComponentsInChildren<Light>();
		foreach (Light light in componentsInChildren)
		{
			if (light.type == LightType.Directional)
			{
				m_MainLight = light;
				break;
			}
		}
		m_LightData = m_MainLight.GetUniversalAdditionalLightData();
		Volume componentInChildren = gameObject.GetComponentInChildren<Volume>();
		if (componentInChildren != null)
		{
			componentInChildren.profile.TryGet<ColorAdjustments>(out m_SrcColorAdjustments);
		}
		RenderPipelineManager.beginCameraRendering += RenderPipelineManager_beginCameraRendering;
	}

	private void RenderPipelineManager_beginCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		if (camera.TryGetComponent<UniversalAdditionalCameraData>(out var component))
		{
			VolumeComponentCache volumeComponentCache = component.ur?.volumeComponents;
			if (volumeComponentCache != null)
			{
				volumeComponentCache.EnsureCurrent();
				if (m_SceneLight == null || m_VolumeCacheVersion != volumeComponentCache.version)
				{
					m_SceneLight = volumeComponentCache.SceneLight;
					m_VolumeCacheVersion = volumeComponentCache.version;
				}
			}
		}
		if (m_SceneLight == null && !m_TriedFallbackSceneLight)
		{
			m_TriedFallbackSceneLight = true;
			m_SceneLight = VolumeManager.instance.stack.GetComponent<SceneLight>();
		}
		UpdatePlayerPointLight();
		if (m_SceneLight == null)
		{
			return;
		}
		if (m_SceneLight.IsActive())
		{
			OverrideData();
			if (anyValueChanged)
			{
				SetData();
				anyValueChanged = false;
			}
		}
		else if (m_FogOpen.GetValue())
		{
			m_FogOpen.SetValue(input: false);
			RenderSettings.fog = false;
		}
	}

	private void UpdatePlayerPointLight()
	{
		bool flag = m_SceneLight != null && m_SceneLight.IsActive() && m_SceneLight.playerPointLightEnabled.overrideState && m_SceneLight.playerPointLightEnabled.value;
		Color color = (flag ? m_SceneLight.playerPointLightColor.value : Color.white);
		float num = (flag ? m_SceneLight.playerPointLightIntensity.value : 0f);
		for (int i = 0; i < 2; i++)
		{
			Light light = s_PlayerPointLights[i];
			if (light == null)
			{
				s_PlayerPointLightHasTargets[i] = false;
				continue;
			}
			bool flag2 = flag && s_PlayerPointLightHasTargets[i];
			if (light.enabled != flag2)
			{
				light.enabled = flag2;
			}
			if (flag2)
			{
				if (light.color != color)
				{
					light.color = color;
				}
				if (Mathf.Abs(light.intensity - num) > 1E-05f)
				{
					light.intensity = num;
				}
			}
		}
	}

	private void OverrideData()
	{
		m_UseLight = m_SceneLight.lightIsExist.value;
		m_Intensity.SetValue(m_SceneLight.intensity.value);
		if (m_UseLight)
		{
			m_MainLightColor.SetValue(m_SceneLight.mainLightColor.value);
			m_MainLightDensity.SetValue(m_SceneLight.mainLightIntensity.value * m_Intensity.GetFloat());
			m_ShadowStrength.SetValue(m_SceneLight.mainLightshadowStrength.value * m_Intensity.GetFloat());
			m_MainLightDir.SetValue(Quaternion.Euler(m_SceneLight.mainLightDir.value));
			m_lightLayer.SetValue(m_SceneLight.lightLayer.value);
			m_shadowColorGround.SetValue(m_SceneLight.ShadowColorGround.value * m_Intensity.GetFloat());
			m_shadowColorHorizon.SetValue(m_SceneLight.ShadowColorHorzion.value * m_Intensity.GetFloat());
			m_shadowColorSky.SetValue(m_SceneLight.ShadowColorSky.value * m_Intensity.GetFloat());
			m_HalfShadowScatter.SetValue(m_SceneLight.HalfShadowScatter.value * m_Intensity.GetFloat());
		}
		else
		{
			m_MainLightDensity.SetValue(0f);
		}
		m_SkyMaterial.SetValue(m_SceneLight.skyMaterial.value);
		m_FogOpen.SetValue(m_SceneLight.isFogOn.value);
		m_FogMode.SetValue(m_SceneLight.fogMode.value);
		m_FogColor.SetValue(m_SceneLight.fogColor.value * m_Intensity.GetFloat());
		m_FogDensity.SetValue(m_SceneLight.fogDensity.value * m_Intensity.GetFloat());
		m_FogStartDistance.SetValue(m_SceneLight.fogStartDistance.value);
		m_FogEndDistance.SetValue(m_SceneLight.fogEndDistance.value);
		m_MainLightShadowsEnabled.SetValue(m_MainLight.shadows != LightShadows.None);
		m_Shadows_Layer.SetValue(m_SceneLight.m_Shadows_Layer.value);
		m_RenderDefaultShadowLayerOnMobile.SetValue(m_SceneLight.renderDefaultShadowLayerOnMobile.value);
		m_Lighting_Environment_AmbientMode.SetValue(m_SceneLight.m_Lighting_Environment_AmbientMode.value);
		m_AmbientColor.SetValue(m_SceneLight.ambientColor.value * m_Intensity.GetFloat());
		m_Lighting_Environment_EquatorColor.SetValue(m_SceneLight.m_Lighting_Environment_EquatorColor.value);
		m_Lighting_Environment_GroundColor.SetValue(m_SceneLight.m_Lighting_Environment_GroundColor.value);
	}

	private void SetData()
	{
		if (m_UseLight)
		{
			m_MainLight.color = m_MainLightColor.GetValue();
			m_MainLight.intensity = m_MainLightDensity.GetFloat();
			m_MainLight.shadowStrength = m_ShadowStrength.GetFloat();
			m_MainLight.transform.rotation = m_MainLightDir.GetValue();
			LightLayerEnum value = m_lightLayer.GetValue();
			m_LightData.lightLayerMask = value;
			bool value2 = m_MainLightShadowsEnabled.GetValue();
			LightLayerEnum lightLayerEnum = (value2 ? m_Shadows_Layer.GetValue() : value);
			if (Application.isMobilePlatform && !m_RenderDefaultShadowLayerOnMobile.GetValue())
			{
				lightLayerEnum &= ~LightLayerEnum.LightLayerDefault;
			}
			m_LightData.customShadowLayers = value2;
			m_LightData.shadowLayerMask = lightLayerEnum;
			DirectLightControl.VolumeReplaceShadowColor(m_shadowColorGround.GetValue(), m_shadowColorHorizon.GetValue(), m_shadowColorSky.GetValue());
		}
		RenderSettings.skybox = m_SkyMaterial.GetValue();
		RenderSettings.ambientLight = m_AmbientColor.GetValue();
		RenderSettings.ambientMode = m_Lighting_Environment_AmbientMode.GetValue();
		RenderSettings.ambientEquatorColor = m_Lighting_Environment_EquatorColor.GetValue();
		RenderSettings.ambientGroundColor = m_Lighting_Environment_GroundColor.GetValue();
		if (RenderSettings.fog = m_FogOpen.GetValue())
		{
			RenderSettings.fogMode = m_FogMode.GetValue();
			RenderSettings.fogColor = m_FogColor.GetValue();
			RenderSettings.fogDensity = m_FogDensity.GetFloat();
			RenderSettings.fogStartDistance = m_FogStartDistance.GetFloat();
			RenderSettings.fogEndDistance = m_FogEndDistance.GetFloat();
		}
	}

	private void OnDisable()
	{
		RenderPipelineManager.beginCameraRendering -= RenderPipelineManager_beginCameraRendering;
		for (int i = 0; i < 2; i++)
		{
			if (s_PlayerPointLights[i] != null)
			{
				s_PlayerPointLights[i].enabled = false;
			}
		}
	}
}
