using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class SolarHaloRenderer : VolumeRenderer<SolarHalo>
{
	private const string PROFILER_TAG = "SolarHalo";

	private VolumeComponentCache m_VolumeComponents;

	private ComputeShader cs;

	private static int ComputeShaderTag = Shader.PropertyToID("_SunVisibilityData");

	private static int ComputeShaderTexTag = Shader.PropertyToID("_SunVisibilityTex");

	private static int PosTag = Shader.PropertyToID("_SolarHaloPos");

	private static int DataTag = Shader.PropertyToID("_SolarHaloData");

	private static int DataListTag = Shader.PropertyToID("_SolarHaloDataList");

	private static int ColorListTag = Shader.PropertyToID("_SolarHaloColorList");

	private static int SolarTexTag = Shader.PropertyToID("_SolarHaloTex");

	private static int SkyLightTag = Shader.PropertyToID("_SolarSkyLightTex");

	private static int SkyLightTag2 = Shader.PropertyToID("_SolarSkyLightTex2");

	private static int HaloDataTag = Shader.PropertyToID("_HaloData");

	private static int HaloData2Tag = Shader.PropertyToID("_HaloData2");

	private static int HaloSunLightTexTag = Shader.PropertyToID("_HaloSunLightTex");

	private static int DisableSkyOnlyTag = Shader.PropertyToID("_SolarHaloDisableSkyOnly");

	private GlobalKeyword Keyword;

	private ComputeBuffer billboardBuffer;

	internal override void SetVolumeComponentCache(VolumeComponentCache volumeComponents)
	{
		base.SetVolumeComponentCache(volumeComponents);
		m_VolumeComponents = volumeComponents;
	}

	private Vector3 GetSolarHaloDirection(ref RenderingData renderingData)
	{
		Atmosphere atmosphere = m_VolumeComponents?.Atmosphere;
		if (atmosphere != null && atmosphere.IsActive())
		{
			return -AtmosphereBuild.AtmosphereSunDir;
		}
		LightData lightData = renderingData.lightData;
		int mainLightIndex = lightData.mainLightIndex;
		if (mainLightIndex >= 0 && mainLightIndex < lightData.visibleLights.Length)
		{
			Light light = lightData.visibleLights[mainLightIndex].light;
			if (light != null)
			{
				return light.transform.forward;
			}
		}
		return -AtmosphereBuild.AtmosphereSunDir;
	}

	private Vector2 GetSolarHaloCenter(ref RenderingData renderingData, Vector3 sunPos)
	{
		if (m_Settings.UseCustomBlurCenter.value)
		{
			return m_Settings.CustomBlurCenter.value;
		}
		CameraData cameraData = renderingData.cameraData;
		Vector4 vector = GL.GetGPUProjectionMatrix(cameraData.camera.projectionMatrix, renderIntoTexture: true) * cameraData.GetViewMatrix() * new Vector4(sunPos.x, sunPos.y, sunPos.z, 1f);
		vector /= vector.w;
		Vector2 result = new Vector2(vector.x, vector.y) * 0.5f + new Vector2(0.5f, 0.5f);
		result.y = 1f - result.y;
		return result;
	}

	public override bool Render(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp, ref RenderingData renderingData)
	{
		if (m_BlitMaterial == null)
		{
			return false;
		}
		CommandBuffer cmd = renderingData.cmd;
		Vector3 solarHaloDirection = GetSolarHaloDirection(ref renderingData);
		Vector3 sunPos = renderingData.cameraData.camera.transform.position + solarHaloDirection * 10000f;
		CameraData cameraData = renderingData.cameraData;
		float x = Mathf.Max(0f, Vector3.Dot(-solarHaloDirection, cameraData.camera.transform.forward));
		cmd.BeginSample("SolarHalo");
		Vector2 solarHaloCenter = GetSolarHaloCenter(ref renderingData, sunPos);
		int num = Mathf.Max(1, m_Settings.Step.value);
		int num2 = Mathf.Max(1, m_Settings.Interate.value);
		float value = m_Settings.radius.value;
		cmd.SetGlobalVector(HaloDataTag, new Vector4(x, solarHaloCenter.x, solarHaloCenter.y, m_Settings.SkyLightThreshold.value));
		cmd.SetGlobalVector(HaloData2Tag, new Vector4(m_Settings.SkyLightIntensity.value, num, value, m_Settings.SkyLightClamp.value));
		cmd.SetGlobalFloat(DisableSkyOnlyTag, m_Settings.DisableSkyOnly.value ? 1f : 0f);
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		int num3 = Mathf.Max(1, m_Settings.downSample.value);
		cameraTargetDescriptor.width = Mathf.Max(1, cameraTargetDescriptor.width / num3);
		cameraTargetDescriptor.height = Mathf.Max(1, cameraTargetDescriptor.height / num3);
		cameraTargetDescriptor.depthBufferBits = 0;
		cmd.GetTemporaryRT(SkyLightTag, cameraTargetDescriptor);
		cmd.GetTemporaryRT(SkyLightTag2, cameraTargetDescriptor);
		ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, SkyLightTag, m_BlitMaterial, 1);
		int num4 = SkyLightTag;
		int num5 = SkyLightTag2;
		for (int i = 0; i < num2; i++)
		{
			ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, num4, num5, m_BlitMaterial, 2);
			int num6 = num4;
			num4 = num5;
			num5 = num6;
		}
		cmd.SetGlobalTexture(HaloSunLightTexTag, num4);
		ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, source, target, m_BlitMaterial, 3);
		cmd.ReleaseTemporaryRT(SkyLightTag);
		cmd.ReleaseTemporaryRT(SkyLightTag2);
		cmd.EndSample("SolarHalo");
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		return true;
	}
}
