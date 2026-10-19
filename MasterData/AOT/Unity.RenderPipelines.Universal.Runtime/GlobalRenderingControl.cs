using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

[ExecuteAlways]
public class GlobalRenderingControl : MonoBehaviour
{
	public enum SSGISampleQuality
	{
		High,
		Low
	}

	[Serializable]
	public struct SkyBlend
	{
		public Material m_SkyMaterial;

		[Range(0f, 1f)]
		public float weight;
	}

	public bool AlwaysRefresh;

	public bool m_enableSSR;

	public bool m_SimpleWay;

	public bool m_AllEnable;

	[Range(0f, 10f)]
	public float m_Intensity = 1f;

	[Range(1f, 8f)]
	public int m_downSample = 4;

	[Range(1f, 8f)]
	public int m_rebuildDownSample = 1;

	[Range(1f, 2000f)]
	public int m_loopCount = 150;

	[Range(0.01f, 10f)]
	public float m_thickness = 0.1f;

	[Range(0.01f, 10f)]
	public float m_thicknessBack = 0.01f;

	[Range(1f, 10f)]
	public int m_skipLoop = 4;

	public bool m_enableSSGI;

	public SSGISampleQuality m_SSGISampleQuality;

	[Range(0f, 10f)]
	public float m_IntensitySSGI = 1f;

	[Range(1f, 8f)]
	public int m_downSampleSSGI = 4;

	[Range(1f, 8f)]
	public int m_rebuildDownSampleSSGI = 1;

	[Range(1f, 2000f)]
	public int m_loopCountSSGI = 150;

	[Range(0.01f, 10f)]
	public float m_thicknessSSGI = 0.1f;

	[Range(0.01f, 10f)]
	public float m_thicknessBackSSGI = 0.01f;

	[Range(1f, 10f)]
	public int m_skipLoopSSGI = 4;

	public float m_instanceDistanceNear = 20f;

	public float m_instanceDistanceFar = 100f;

	public int m_instancePriority = 6;

	public bool m_AO_Active;

	[Range(1f, 6f)]
	public int m_AO_DownSample = 1;

	[Range(4f, 64f)]
	public int m_SampleCount = 8;

	[Range(1f, 256f)]
	public int m_SampleStepWidth = 16;

	[Range(1f, 32f)]
	public int m_SliceCount = 2;

	[Range(0f, 2f)]
	public float m_AOAngle = 1f;

	[Range(0f, 4f)]
	public float m_AoIntensity = 1f;

	[Range(0f, 1f)]
	public float m_RoIntensity = 1f;

	public HDCharShadowPass.HDShadowQuality m_HDShadowQuality;

	public bool SunHaolEnable;

	public Texture2D m_SunHaloTex;

	public List<SolarHolaData> m_SunHaloList;

	[Range(0f, 24f)]
	public float m_TimeOfDay;

	public bool SkyMatsEnable;

	public List<SkyBlend> m_SkyBlendMats;

	public static bool enableSSR;

	public static bool SimpleWay;

	public static bool AllEnable;

	public static float Intensity = 1f;

	public static int downSample = 4;

	public static int rebuildDownSample = 1;

	public static int loopCount = 150;

	public static float thickness = 0.1f;

	public static float thicknessBack = 0.01f;

	public static int skipLoop = 4;

	public static bool enableSSGI;

	public static float IntensitySSGI = 1f;

	public static int downSampleSSGI = 4;

	public static int rebuildDownSampleSSGI = 1;

	public static int loopCountSSGI = 150;

	public static float thicknessSSGI = 0.1f;

	public static float thicknessBackSSGI = 0.01f;

	public static int skipLoopSSGI = 4;

	public static SSGISampleQuality s_SSGISampleQuality = SSGISampleQuality.High;

	public static float instanceDistanceNear = 20f;

	public static float instanceDistanceFar = 100f;

	public static int instancePriority = 6;

	public static bool AO_Active;

	public static int AO_DownSample;

	public static int SampleCount = 8;

	public static int SampleStepWidth = 16;

	public static int SliceCount = 2;

	public static float AoAngle = 1f;

	public static float AoIntensity = 1f;

	public static float RoIntensity = 1f;

	public static Texture2D SunHaloTex;

	public static float TimeOfDay;

	public static List<SolarHolaData> SunHaloList;

	public static List<SkyBlend> skyBlendMats;

	public static HDCharShadowPass.HDShadowQuality HDShadowQuality;

	private bool dirt;

	private static readonly int InstanceDistanceDataID = Shader.PropertyToID("_InstanceDistanceData");

	public static void RefreshGPUData()
	{
		Shader.SetGlobalVector(InstanceDistanceDataID, new Vector4(instanceDistanceNear, instanceDistanceFar, instancePriority, 0f));
	}

	public void RefreshScriptData()
	{
		enableSSR = m_enableSSR;
		SimpleWay = m_SimpleWay;
		AllEnable = m_AllEnable;
		Intensity = m_Intensity;
		downSample = m_downSample;
		rebuildDownSample = m_rebuildDownSample;
		loopCount = m_loopCount;
		thickness = m_thickness;
		thicknessBack = m_thicknessBack;
		skipLoop = m_skipLoop;
		enableSSGI = m_enableSSGI;
		IntensitySSGI = m_IntensitySSGI;
		downSampleSSGI = m_downSampleSSGI;
		rebuildDownSampleSSGI = m_rebuildDownSampleSSGI;
		loopCountSSGI = m_loopCountSSGI;
		thicknessSSGI = m_thicknessSSGI;
		thicknessBackSSGI = m_thicknessBackSSGI;
		skipLoopSSGI = m_skipLoopSSGI;
		s_SSGISampleQuality = m_SSGISampleQuality;
		instanceDistanceNear = m_instanceDistanceNear;
		instanceDistanceFar = m_instanceDistanceFar;
		instancePriority = m_instancePriority;
		AO_Active = m_AO_Active;
		AO_DownSample = m_AO_DownSample;
		SampleCount = m_SampleCount;
		SampleStepWidth = m_SampleStepWidth;
		SliceCount = m_SliceCount;
		AoAngle = m_AOAngle;
		AoIntensity = m_AoIntensity;
		RoIntensity = m_RoIntensity;
		TimeOfDay = m_TimeOfDay;
		if (SunHaolEnable)
		{
			SunHaloTex = m_SunHaloTex;
			SunHaloList = m_SunHaloList;
		}
		if (SkyMatsEnable)
		{
			skyBlendMats = m_SkyBlendMats;
		}
		HDShadowQuality = m_HDShadowQuality;
	}

	private void Update()
	{
		if (dirt || AlwaysRefresh)
		{
			RefreshScriptData();
			RefreshGPUData();
			dirt = false;
		}
	}

	private void OnValidate()
	{
		setDirt();
	}

	private void OnEnable()
	{
		setDirt();
	}

	public void setDirt()
	{
		dirt = true;
	}
}
