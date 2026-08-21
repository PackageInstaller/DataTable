using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Ase;

public class EnvironmentLightCtrl : MonoBehaviour
{
	public bool openBlend;

	public float blendTimeLength = 1f;

	public Light directLight;

	private PostprocessFogRenderPassFeature fogRenderPassFeature;

	public EnvironmentData environmentData = new EnvironmentData();

	private EnvironmentData defaultEnvironmentData;

	private EnvironmentData targetEnvironmentData;

	private List<EnvironmentData> environmentDataList = new List<EnvironmentData>();

	private float blendTime;

	private float process;

	private PostprocessFogRenderPassFeature FogRenderPassFeature
	{
		get
		{
			if ((Object)(object)fogRenderPassFeature == null)
			{
				fogRenderPassFeature = GetFeature<PostprocessFogRenderPassFeature>("PostprocessFog");
			}
			return fogRenderPassFeature;
		}
	}

	public T GetFeature<T>(string featureName) where T : ScriptableRendererFeature
	{
		ScriptableRenderer scriptableRenderer = CameraExtensions.GetUniversalAdditionalCameraData(GameEntry.Camera.MainCamera).scriptableRenderer;
		List<ScriptableRendererFeature> list = typeof(ScriptableRenderer).GetProperty("rendererFeatures", BindingFlags.Instance | BindingFlags.NonPublic).GetValue(scriptableRenderer) as List<ScriptableRendererFeature>;
		for (int i = 0; i < list.Count; i++)
		{
			if (((Object)(object)list[i]).name == featureName && list[i] is T)
			{
				ScriptableRendererFeature obj = list[i];
				return (T)(object)((obj is T) ? obj : null);
			}
		}
		return default(T);
	}

	private void Awake()
	{
		defaultEnvironmentData = new EnvironmentData();
		defaultEnvironmentData.skyMaterial = RenderSettings.skybox;
		defaultEnvironmentData.ambientMode = RenderSettings.ambientMode;
		defaultEnvironmentData.ambientLight = RenderSettings.ambientSkyColor;
		defaultEnvironmentData.ambientSkyColor = RenderSettings.ambientSkyColor;
		defaultEnvironmentData.ambientEquatorColor = RenderSettings.ambientEquatorColor;
		defaultEnvironmentData.ambientGroundColor = RenderSettings.ambientGroundColor;
		defaultEnvironmentData.ambientIntensity = RenderSettings.ambientIntensity;
		if (directLight != null)
		{
			defaultEnvironmentData.rotation = directLight.transform.rotation.eulerAngles;
			defaultEnvironmentData.cullingMask = directLight.cullingMask;
			defaultEnvironmentData.emissionColor = directLight.color;
			defaultEnvironmentData.emissionIntensity = directLight.intensity;
			defaultEnvironmentData.emissionIndirectMultiplier = directLight.bounceIntensity;
		}
		if ((Object)(object)FogRenderPassFeature != null && FogRenderPassFeature.settings.materia != null)
		{
			Material materia = FogRenderPassFeature.settings.materia;
			defaultEnvironmentData.baseColor = materia.GetColor("_BaseColor");
			defaultEnvironmentData.fogColor = materia.GetColor("_FogColor");
			defaultEnvironmentData.fogStrength = materia.GetFloat("_FogStrength");
			defaultEnvironmentData.fogDistance = materia.GetFloat("_FogDistance");
			defaultEnvironmentData.fogStartDistance = materia.GetFloat("_FogStartDistance");
			defaultEnvironmentData.fogFarDistance = materia.GetFloat("_FogFarDistance");
			defaultEnvironmentData.planeHeight = materia.GetFloat("_PlaneHeight");
			defaultEnvironmentData.fogScale = materia.GetFloat("_FogScale");
			defaultEnvironmentData.fogSpeed = materia.GetVector("_FogSpeed");
			defaultEnvironmentData.bumpHeight = materia.GetFloat("_BumpHeight");
		}
		defaultEnvironmentData.enableEnvironment = true;
		defaultEnvironmentData.enableSkybox = true;
		defaultEnvironmentData.enableDirectLight = true;
		defaultEnvironmentData.enableFog = true;
		environmentData.SetData(defaultEnvironmentData);
		environmentDataList.Add(defaultEnvironmentData);
	}

	private void Update()
	{
		if (openBlend)
		{
			targetEnvironmentData = environmentDataList[environmentDataList.Count - 1];
			blendTime = Mathf.Clamp(blendTime + Time.deltaTime, 0f, blendTimeLength);
			process = blendTime / blendTimeLength;
			environmentData.ambientLight = Color.Lerp(environmentData.ambientLight, targetEnvironmentData.ambientLight, process);
			environmentData.ambientSkyColor = Color.Lerp(environmentData.ambientSkyColor, targetEnvironmentData.ambientSkyColor, process);
			environmentData.ambientEquatorColor = Color.Lerp(environmentData.ambientEquatorColor, targetEnvironmentData.ambientEquatorColor, process);
			environmentData.ambientGroundColor = Color.Lerp(environmentData.ambientGroundColor, targetEnvironmentData.ambientGroundColor, process);
			environmentData.ambientIntensity = Mathf.Lerp(environmentData.ambientIntensity, targetEnvironmentData.ambientIntensity, process);
			RenderSettings.ambientSkyColor = environmentData.AmbientColor;
			RenderSettings.ambientEquatorColor = environmentData.ambientEquatorColor;
			RenderSettings.ambientGroundColor = environmentData.ambientGroundColor;
			RenderSettings.ambientIntensity = environmentData.ambientIntensity;
			if (directLight != null)
			{
				environmentData.emissionColor = Color.Lerp(environmentData.emissionColor, targetEnvironmentData.emissionColor, process);
				environmentData.emissionIntensity = Mathf.Lerp(environmentData.emissionIntensity, targetEnvironmentData.emissionIntensity, process);
				environmentData.emissionIndirectMultiplier = Mathf.Lerp(environmentData.emissionIndirectMultiplier, targetEnvironmentData.emissionIndirectMultiplier, process);
				environmentData.rotation = Vector3.Lerp(environmentData.rotation, targetEnvironmentData.rotation, process);
				directLight.transform.rotation = Quaternion.Euler(environmentData.rotation);
				directLight.color = environmentData.emissionColor;
				directLight.intensity = environmentData.emissionIntensity;
				directLight.bounceIntensity = environmentData.emissionIndirectMultiplier;
			}
			if ((Object)(object)FogRenderPassFeature != null)
			{
				environmentData.baseColor = Color.Lerp(environmentData.baseColor, targetEnvironmentData.baseColor, process);
				environmentData.fogColor = Color.Lerp(environmentData.fogColor, targetEnvironmentData.fogColor, process);
				environmentData.fogStrength = Mathf.Lerp(environmentData.fogStrength, targetEnvironmentData.fogStrength, process);
				environmentData.fogDistance = Mathf.Lerp(environmentData.fogDistance, targetEnvironmentData.fogDistance, process);
				environmentData.fogStartDistance = Mathf.Lerp(environmentData.fogStartDistance, targetEnvironmentData.fogStartDistance, process);
				environmentData.fogFarDistance = Mathf.Lerp(environmentData.fogFarDistance, targetEnvironmentData.fogFarDistance, process);
				environmentData.planeHeight = Mathf.Lerp(environmentData.planeHeight, targetEnvironmentData.planeHeight, process);
				environmentData.fogScale = Mathf.Lerp(environmentData.fogScale, targetEnvironmentData.fogScale, process);
				environmentData.fogSpeed = Vector4.Lerp(environmentData.fogSpeed, targetEnvironmentData.fogSpeed, process);
				environmentData.bumpHeight = Mathf.Lerp(environmentData.bumpHeight, targetEnvironmentData.bumpHeight, process);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogScale", environmentData.fogScale);
				FogRenderPassFeature.settings.materialPropertyBlock.SetVector("_FogSpeed", environmentData.fogSpeed);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_BumpHeight", environmentData.bumpHeight);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogDistance", environmentData.fogDistance);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogStartDistance", environmentData.fogStartDistance);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogFarDistance", environmentData.fogFarDistance);
				FogRenderPassFeature.settings.materialPropertyBlock.SetColor("_BaseColor", environmentData.baseColor);
				FogRenderPassFeature.settings.materialPropertyBlock.SetColor("_FogColor", environmentData.fogColor);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogStrength", environmentData.fogStrength);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_PlaneHeight", environmentData.planeHeight);
			}
			if (process >= 1f)
			{
				blendTime = 0f;
				process = 0f;
				openBlend = false;
			}
		}
		if (RenderSettings.defaultReflectionMode != DefaultReflectionMode.Custom)
		{
			RenderSettings.defaultReflectionMode = DefaultReflectionMode.Custom;
		}
	}

	public void ApplyEnvironmentData(EnvironmentData environmentData, bool openBlend = false)
	{
		this.openBlend = openBlend;
		if (environmentDataList.Contains(environmentData))
		{
			environmentDataList.Remove(environmentData);
		}
		environmentDataList.Add(environmentData);
		if (environmentData.enableSkybox)
		{
			this.environmentData.enableSkybox = environmentData.enableSkybox;
			this.environmentData.skyMaterial = environmentData.skyMaterial;
			RenderSettings.skybox = environmentData.skyMaterial;
			if ((bool)environmentData.skyMaterial && environmentData.skyMaterial.HasTexture("_Tex"))
			{
				RenderSettings.customReflection = environmentData.skyMaterial.GetTexture("_Tex");
			}
		}
		if (environmentData.enableEnvironment)
		{
			this.environmentData.ambientMode = environmentData.ambientMode;
			RenderSettings.ambientMode = environmentData.ambientMode;
			if (!this.openBlend)
			{
				this.environmentData.enableEnvironment = environmentData.enableEnvironment;
				this.environmentData.ambientMode = environmentData.ambientMode;
				this.environmentData.ambientLight = environmentData.ambientLight;
				this.environmentData.ambientSkyColor = environmentData.ambientSkyColor;
				this.environmentData.ambientEquatorColor = environmentData.ambientEquatorColor;
				this.environmentData.ambientGroundColor = environmentData.ambientGroundColor;
				this.environmentData.ambientIntensity = environmentData.ambientIntensity;
				RenderSettings.ambientSkyColor = environmentData.AmbientColor;
				RenderSettings.ambientEquatorColor = environmentData.ambientEquatorColor;
				RenderSettings.ambientGroundColor = environmentData.ambientGroundColor;
				RenderSettings.ambientIntensity = environmentData.ambientIntensity;
			}
		}
		if (environmentData.enableDirectLight && directLight != null)
		{
			this.environmentData.enableDirectLight = environmentData.enableDirectLight;
			this.environmentData.cullingMask = environmentData.cullingMask;
			int mask = LayerMask.GetMask("Default");
			LayerMask layerMask = environmentData.cullingMask;
			if (((int)layerMask & mask) > 0)
			{
				layerMask = (int)layerMask | LayerMask.GetMask("Grass");
			}
			directLight.cullingMask = layerMask;
			if (!this.openBlend)
			{
				this.environmentData.emissionColor = environmentData.emissionColor;
				this.environmentData.emissionIntensity = environmentData.emissionIntensity;
				this.environmentData.emissionIndirectMultiplier = environmentData.emissionIndirectMultiplier;
				directLight.color = environmentData.emissionColor;
				directLight.intensity = environmentData.emissionIntensity;
				directLight.bounceIntensity = environmentData.emissionIndirectMultiplier;
			}
		}
		if (environmentData.enableFog && (Object)(object)FogRenderPassFeature != null)
		{
			this.environmentData.enableFog = environmentData.enableFog;
			if (!this.openBlend)
			{
				this.environmentData.fogScale = environmentData.fogScale;
				this.environmentData.fogSpeed = environmentData.fogSpeed;
				this.environmentData.bumpHeight = environmentData.bumpHeight;
				this.environmentData.fogDistance = environmentData.fogDistance;
				this.environmentData.fogStartDistance = environmentData.fogStartDistance;
				this.environmentData.fogFarDistance = environmentData.fogFarDistance;
				this.environmentData.baseColor = environmentData.baseColor;
				this.environmentData.fogColor = environmentData.fogColor;
				this.environmentData.fogStrength = environmentData.fogStrength;
				this.environmentData.planeHeight = environmentData.planeHeight;
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogScale", environmentData.fogScale);
				FogRenderPassFeature.settings.materialPropertyBlock.SetVector("_FogSpeed", environmentData.fogSpeed);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_BumpHeight", environmentData.bumpHeight);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogDistance", environmentData.fogDistance);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogStartDistance", environmentData.fogStartDistance);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogFarDistance", environmentData.fogFarDistance);
				FogRenderPassFeature.settings.materialPropertyBlock.SetColor("_BaseColor", environmentData.baseColor);
				FogRenderPassFeature.settings.materialPropertyBlock.SetColor("_FogColor", environmentData.fogColor);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_FogStrength", environmentData.fogStrength);
				FogRenderPassFeature.settings.materialPropertyBlock.SetFloat("_PlaneHeight", environmentData.planeHeight);
			}
		}
		if (openBlend)
		{
			blendTime = 0f;
			process = 0f;
		}
	}

	public void RemoveEnvironmentData(EnvironmentData environmentData, bool openBlend = false)
	{
		if (environmentDataList[environmentDataList.Count - 1] == environmentData)
		{
			environmentDataList.Remove(environmentData);
			ApplyEnvironmentData(environmentDataList[environmentDataList.Count - 1], environmentDataList[environmentDataList.Count - 1].openBlend);
		}
		else if (environmentDataList.Contains(environmentData))
		{
			environmentDataList.Remove(environmentData);
		}
	}

	private void OnDestroy()
	{
		if ((Object)(object)FogRenderPassFeature != null)
		{
			FogRenderPassFeature.settings.materialPropertyBlock.Clear();
		}
	}
}
