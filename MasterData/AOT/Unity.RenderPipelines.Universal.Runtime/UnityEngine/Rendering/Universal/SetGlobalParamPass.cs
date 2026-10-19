using System;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine.Rendering.Universal.Internal;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal;

public class SetGlobalParamPass : ScriptableRenderPass
{
	private static int m_DeSaturateID = Shader.PropertyToID("_DeSaturate");

	private static int m_CameraUpID = Shader.PropertyToID("_CameraUpDir");

	private static int m_CameraForwardID = Shader.PropertyToID("_CameraFrontDir");

	private static int m_CameraFOVID = Shader.PropertyToID("_CameraFOV");

	private static int m_SkyBoxID = Shader.PropertyToID("_CurrentSkyBox");

	private static int m_SkyBoxHDRID = Shader.PropertyToID("_CurrentSkyBox_HDRParam");

	private static int m_DarkenID = Shader.PropertyToID("_Darken");

	private static int m_PerlinNoiseID = Shader.PropertyToID("_PerlinNoiseTex");

	private static int m_VPMatrixID = Shader.PropertyToID("_GPUVP");

	private static int m_VMatrixID = Shader.PropertyToID("_GPUV");

	private static int m_PreIntegralDataID = Shader.PropertyToID("_PreIntegralTex");

	private static int m_FrameID = Shader.PropertyToID("_CurrentFrame");

	private static readonly int HDCharShadowCount = Shader.PropertyToID("_HDCharShadowCount");

	private static readonly int HDCharShadowValidMask = Shader.PropertyToID("_HDCharShadowValidMask");

	private static readonly int CharacterMainLightShadowReceiveEnabled = Shader.PropertyToID("_CharacterMainLightShadowReceiveEnabled");

	private static readonly int CharacterMainLightShadowNormalBias = Shader.PropertyToID("_CharacterMainLightShadowNormalBias");

	private static readonly int ToonGenericTransparentShadowReceiveEnabled = Shader.PropertyToID("_ToonGenericTransparentShadowReceiveEnabled");

	private static int AutoExposureEnable = Shader.PropertyToID("_AutoExposureEnable");

	private static readonly int DeferredSceneAutoExposureEnable = Shader.PropertyToID("_DeferredSceneAutoExposureEnable");

	private static readonly int GenericAmbientLightIntensity = Shader.PropertyToID("_GenericAmbientLightIntensity");

	private static readonly int GenericDirectLightIntensity = Shader.PropertyToID("_GenericDirectLightIntensity");

	private static readonly int GenericReflectionProbeIntensity = Shader.PropertyToID("_GenericReflectionProbeIntensity");

	private static readonly int SceneScatterMode = Shader.PropertyToID("_SceneScatterMode");

	private static readonly int SHArID = Shader.PropertyToID("_ACTSceneSHAr");

	private static readonly int SHAgID = Shader.PropertyToID("_ACTSceneSHAg");

	private static readonly int SHAbID = Shader.PropertyToID("_ACTSceneSHAb");

	private static readonly int SHBrID = Shader.PropertyToID("_ACTSceneSHBr");

	private static readonly int SHBgID = Shader.PropertyToID("_ACTSceneSHBg");

	private static readonly int SHBbID = Shader.PropertyToID("_ACTSceneSHBb");

	private static readonly int SHCID = Shader.PropertyToID("_ACTSceneSHC");

	private static int TimeTag = Shader.PropertyToID("_UnifyTime");

	private static int CameraPlaneTag0 = Shader.PropertyToID("_CameraPlane0");

	private static int CameraPlaneTag1 = Shader.PropertyToID("_CameraPlane1");

	private static int CameraPlaneTag2 = Shader.PropertyToID("_CameraPlane2");

	private static int CameraPlaneTag3 = Shader.PropertyToID("_CameraPlane3");

	private static int CameraPlaneTag4 = Shader.PropertyToID("_CameraPlane4");

	private static int CameraPlaneTag5 = Shader.PropertyToID("_CameraPlane5");

	private static int GlobalWindListTag = Shader.PropertyToID("_GlobalWindListData1");

	private static int GlobalWindListTag2 = Shader.PropertyToID("_GlobalWindListData2");

	private static int GlobalWindCountTag = Shader.PropertyToID("_GlobalWindCount");

	private static int CharQualityTag = Shader.PropertyToID("_CharacterQuality");

	private static int HeightFogFactorTag = Shader.PropertyToID("_act_heightFogFactor");

	private static int HeightFogFactorTag2 = Shader.PropertyToID("_act_heightFogFactor2");

	private static int HeightFogColorTag = Shader.PropertyToID("_act_heightFogColor");

	private static int HasVector = Shader.PropertyToID("_HasVector");

	private static readonly int GenericBloomWeight = Shader.PropertyToID("_GenericBloomWeight");

	private static readonly int PrevViewProjMatrix = Shader.PropertyToID("_PrevViewProjMatrix");

	private static readonly int PrevOutlineViewMatrix = Shader.PropertyToID("_PrevOutlineViewMatrix");

	private static readonly int ViewProjMatrixNoJitter = Shader.PropertyToID("_ViewProjMatrixNoJitter");

	private static readonly int SkyMotionReprojectionMatrix = Shader.PropertyToID("_SkyMotionReprojectionMatrix");

	private static readonly int Jitter = Shader.PropertyToID("_Jitter");

	private static int CurrentProbTag = Shader.PropertyToID("_CurrentProb");

	private static int CurrentProbCountTag = Shader.PropertyToID("_CurrentProbCount");

	private static int RuntimeDeferredReflectionProbeDataTag = Shader.PropertyToID("_RuntimeDeferredReflectionProbeData");

	private static int CurrentTexTag = Shader.PropertyToID("_CurrentTex");

	private static int CurrentFlowTag = Shader.PropertyToID("_CurrentFlow");

	private static int CurrentDissolveTag = Shader.PropertyToID("_CurrentDissolve");

	private static int ColorTag = Shader.PropertyToID("_Color");

	private static int CurrentFlowSTTag = Shader.PropertyToID("_CurrentFlow_ST");

	private static int CurrentDissolveSTTag = Shader.PropertyToID("_CurrentDissolve_ST");

	private static int FlowIntensityTag = Shader.PropertyToID("_FlowIntensity");

	private static int FlowTimeScaleTag = Shader.PropertyToID("_FlowTimeScale");

	private static int DissolveIntensityTag = Shader.PropertyToID("_DissolveIntensity");

	private static int DissolveRangeTag = Shader.PropertyToID("_DissolveRange");

	private static int NextTexTag = Shader.PropertyToID("_NextTex");

	private static int NextFlowTag = Shader.PropertyToID("_NextFlow");

	private static int NextDissolveTag = Shader.PropertyToID("_NextDissolve");

	private static int CurrentColorTag = Shader.PropertyToID("_currentColor");

	private static int CurrentDataTag = Shader.PropertyToID("_currentData");

	private static int CurrentData2Tag = Shader.PropertyToID("_currentData2");

	private static int CurrentData3Tag = Shader.PropertyToID("_currentData3");

	private static int CurrentWeightTag = Shader.PropertyToID("_currentWeight");

	private static int NextColorTag = Shader.PropertyToID("_nextColor");

	private static int NextDataTag = Shader.PropertyToID("_nextData");

	private static int NextData2Tag = Shader.PropertyToID("_nextData2");

	private static int NextData3Tag = Shader.PropertyToID("_nextData3");

	private static int NextWeightTag = Shader.PropertyToID("_nextWeight");

	internal static readonly int ArtLine = Shader.PropertyToID("_ACT_ArtLine");

	internal static readonly int LineColor = Shader.PropertyToID("_LineColor");

	internal static readonly int Threshold = Shader.PropertyToID("_NormalData");

	internal static readonly int Fade = Shader.PropertyToID("_FadeData");

	private static readonly int InnerWorldFilterParams = Shader.PropertyToID("_InnerWorldFilterParams");

	private static readonly int InnerWorldFilterColor = Shader.PropertyToID("_InnerWorldFilterColor");

	private static readonly int InnerWorldFilterStyle = Shader.PropertyToID("_InnerWorldFilterStyle");

	private static readonly int InnerWorldFilterEdgeColor = Shader.PropertyToID("_InnerWorldFilterEdgeColor");

	private static readonly int InnerWorldFilterRipple = Shader.PropertyToID("_InnerWorldFilterRipple");

	private static readonly int InnerWorldFilterRippleColor = Shader.PropertyToID("_InnerWorldFilterRippleColor");

	private static readonly int InnerWorldFilterCausticsStyle = Shader.PropertyToID("_InnerWorldFilterCausticsStyle");

	private static readonly int InnerWorldShadowColorGround = Shader.PropertyToID("_InnerWorldShadowColorGround");

	private static readonly int InnerWorldShadowColorHorizon = Shader.PropertyToID("_InnerWorldShadowColorHorizon");

	private static readonly int InnerWorldShadowColorSky = Shader.PropertyToID("_InnerWorldShadowColorSky");

	private static readonly int InnerWorldShadowColorParams = Shader.PropertyToID("_InnerWorldShadowColorParams");

	private static readonly int InnerWorldLinearFogColor = Shader.PropertyToID("_InnerWorldLinearFogColor");

	private static readonly int InnerWorldLinearFogParams = Shader.PropertyToID("_InnerWorldLinearFogParams");

	private static readonly int InnerWorldFilterMaskCount = Shader.PropertyToID("_InnerWorldFilterMaskCount");

	private static readonly int InnerWorldFilterMasks = Shader.PropertyToID("_InnerWorldFilterMasks");

	private static readonly int InnerWorldFilterEdgeFeather = Shader.PropertyToID("_InnerWorldFilterEdgeFeather");

	private Vector4[] GlobalWindListData;

	private Vector4[] GlobalWindListData2;

	private readonly Vector4[] m_InnerWorldFilterMasks;

	private Plane[] m_cameraPlanes;

	private RenderTargetIdentifier preIntegralTex;

	private RenderTargetIdentifier perlinNoiseTex;

	private readonly VolumeComponentCache m_VolumeComponents;

	private readonly UniversalRenderer m_Renderer;

	private bool m_InnerWorldGlobalsCleared;

	private bool m_ReflectionProbeSlotStateCleared;

	private static int[] planeTagList = new int[6] { CameraPlaneTag0, CameraPlaneTag1, CameraPlaneTag2, CameraPlaneTag3, CameraPlaneTag4, CameraPlaneTag5 };

	private bool notFristFrame;

	public static GlobalKeyword ArtLineKeyword = GlobalKeyword.Create("_ACT_ARTLINE");

	public static GlobalKeyword TemporalHistoryKeyword = GlobalKeyword.Create("_TEMPORAL_HISTORY_AVAILABLE");

	public static GlobalKeyword MotionVectorKeyword = GlobalKeyword.Create("_MOTION_VECTOR");

	private CubemapArray m_ReflectionProb;

	private readonly List<VisibleReflectionProbe> m_TempProbList;

	private readonly Dictionary<Object, int> m_ReflectionProbeSlots;

	private readonly HashSet<Object> m_CurrentReflectionProbeKeys;

	private readonly HashSet<Object> m_CopiedReflectionProbeKeys;

	private readonly List<Object> m_ReflectionProbeKeysToRemove;

	private readonly List<int> m_FreeReflectionProbeSlots;

	private readonly Object[] m_ReflectionProbeSlotKeys;

	private readonly Texture[] m_ReflectionProbeSlotTextures;

	private readonly uint[] m_ReflectionProbeSlotTextureUpdateCounts;

	private readonly bool[] m_ReflectionProbeSlotUsed;

	private readonly DeferredReflectionProbeGpuData[] m_RuntimeReflectionProbeData;

	private ComputeBuffer m_RuntimeReflectionProbeBuffer;

	private int m_CubeMapArrayWidth;

	private TextureFormat m_CubeMapArrayFormat;

	private int m_CubeMapArrayLength;

	private const int k_MaxReflectionProbeCount = 32;

	internal static bool RuntimeReflectionProbeSupported { get; private set; }

	internal SetGlobalParamPass(Texture2D m_PerlinNoiseTex, Texture2D m_PreIntegralTex, VolumeComponentCache volumeComponents, UniversalRenderer renderer)
	{
		m_VolumeComponents = volumeComponents;
		m_Renderer = renderer;
		profilingSampler = new ProfilingSampler("SetGlobalParamPass");
		renderPassEvent = RenderPassEvent.SetGlobalParamPass;
		perlinNoiseTex = m_PerlinNoiseTex;
		preIntegralTex = m_PreIntegralTex;
		targetCount = 0u;
		GlobalWindListData = new Vector4[32];
		GlobalWindListData2 = new Vector4[32];
		m_InnerWorldFilterMasks = new Vector4[16];
		m_cameraPlanes = new Plane[6];
		m_TempProbList = new List<VisibleReflectionProbe>(32);
		m_ReflectionProbeSlots = new Dictionary<Object, int>(32);
		m_CurrentReflectionProbeKeys = new HashSet<Object>();
		m_CopiedReflectionProbeKeys = new HashSet<Object>();
		m_ReflectionProbeKeysToRemove = new List<Object>(32);
		m_FreeReflectionProbeSlots = new List<int>(32);
		m_ReflectionProbeSlotKeys = new Object[32];
		m_ReflectionProbeSlotTextures = new Texture[32];
		m_ReflectionProbeSlotTextureUpdateCounts = new uint[32];
		m_ReflectionProbeSlotUsed = new bool[32];
		m_RuntimeReflectionProbeData = new DeferredReflectionProbeGpuData[32];
		RuntimeReflectionProbeSupported = SystemInfo.supportsCubemapArrayTextures && (SystemInfo.copyTextureSupport & CopyTextureSupport.DifferentTypes) != 0;
		if (RuntimeReflectionProbeSupported)
		{
			m_RuntimeReflectionProbeBuffer = new ComputeBuffer(32, 128, ComputeBufferType.Structured);
		}
		ClearReflectionProbeSlotData();
	}

	private bool CheckProb(float depth, float radius)
	{
		if ((depth > 0f && depth - radius < 100f) || (depth < 0f && depth + radius > 0f))
		{
			return true;
		}
		return false;
	}

	private bool CreateReflectionProbesTexture(int width, TextureFormat format, int count)
	{
		if (m_ReflectionProb == null || count > m_CubeMapArrayLength || width != m_CubeMapArrayWidth || format != m_CubeMapArrayFormat)
		{
			CoreUtils.Destroy(m_ReflectionProb);
			m_ReflectionProb = null;
			m_CubeMapArrayLength = Mathf.CeilToInt((float)count / 4f) * 4;
			m_ReflectionProb = new CubemapArray(width, m_CubeMapArrayLength, format, mipChain: true);
			m_ReflectionProb.name = "_ReflectionProbArray";
			m_ReflectionProb.filterMode = FilterMode.Trilinear;
			m_CubeMapArrayWidth = width;
			m_CubeMapArrayFormat = format;
			ClearReflectionProbeSlotTextures();
			return true;
		}
		return false;
	}

	private void SetReflectionEmpty()
	{
		m_CubeMapArrayLength = 0;
		m_CubeMapArrayWidth = 0;
		m_CubeMapArrayFormat = (TextureFormat)0;
		CoreUtils.Destroy(m_ReflectionProb);
		m_ReflectionProb = null;
		m_RuntimeReflectionProbeBuffer?.Release();
		m_RuntimeReflectionProbeBuffer = null;
		ClearReflectionProbeSlotState();
	}

	private void SetReflectionInactive(CommandBuffer cmd)
	{
		m_TempProbList.Clear();
		ClearReflectionProbeSlotState();
		if (m_RuntimeReflectionProbeBuffer != null)
		{
			cmd.SetGlobalBuffer(RuntimeDeferredReflectionProbeDataTag, m_RuntimeReflectionProbeBuffer);
		}
		cmd.SetGlobalInteger(CurrentProbCountTag, 0);
	}

	private void UploadRuntimeReflectionProbeData(CommandBuffer cmd, int probeCount)
	{
		if (m_RuntimeReflectionProbeBuffer != null)
		{
			if (probeCount > 0)
			{
				cmd.SetBufferData(m_RuntimeReflectionProbeBuffer, m_RuntimeReflectionProbeData, 0, 0, probeCount);
			}
			cmd.SetGlobalBuffer(RuntimeDeferredReflectionProbeDataTag, m_RuntimeReflectionProbeBuffer);
		}
	}

	private Texture GetProbTexture(VisibleReflectionProbe probe)
	{
		ReflectionProbe reflectionProbe = probe.reflectionProbe;
		if (reflectionProbe != null && reflectionProbe.customBakedTexture != null)
		{
			return reflectionProbe.customBakedTexture;
		}
		if (probe.texture != null)
		{
			return probe.texture;
		}
		return null;
	}

	private bool CheckProbTexture(VisibleReflectionProbe probe)
	{
		return GetProbTexture(probe) != null;
	}

	private bool TryGetValidReferenceCubemap(out Cubemap referenceCubemap)
	{
		referenceCubemap = null;
		int num;
		for (num = 0; num < m_TempProbList.Count; num++)
		{
			Texture probTexture = GetProbTexture(m_TempProbList[num]);
			referenceCubemap = probTexture as Cubemap;
			if (referenceCubemap != null)
			{
				return true;
			}
			m_TempProbList.RemoveAt(num);
			num--;
		}
		return false;
	}

	private void FilterInvalidReflectionProbes(Cubemap referenceCubemap)
	{
		for (int i = 0; i < m_TempProbList.Count; i++)
		{
			Cubemap cubemap = GetProbTexture(m_TempProbList[i]) as Cubemap;
			if (cubemap == null)
			{
				m_TempProbList.RemoveAt(i);
				i--;
			}
			else if (cubemap.width != referenceCubemap.width || cubemap.format != referenceCubemap.format)
			{
				m_TempProbList.RemoveAt(i);
				i--;
			}
		}
	}

	private Object GetReflectionProbeKey(VisibleReflectionProbe probe)
	{
		if (!(probe.reflectionProbe != null))
		{
			return GetProbTexture(probe);
		}
		return probe.reflectionProbe;
	}

	private void ClearReflectionProbeSlotData()
	{
		for (int i = 0; i < 32; i++)
		{
			m_RuntimeReflectionProbeData[i] = default;
		}
	}

	private void ClearReflectionProbeSlotTextures()
	{
		for (int i = 0; i < 32; i++)
		{
			m_ReflectionProbeSlotTextures[i] = null;
			m_ReflectionProbeSlotTextureUpdateCounts[i] = 0u;
		}
	}

	private void ClearReflectionProbeSlotState()
	{
		if (!m_ReflectionProbeSlotStateCleared)
		{
			m_ReflectionProbeSlots.Clear();
			m_CurrentReflectionProbeKeys.Clear();
			m_CopiedReflectionProbeKeys.Clear();
			m_ReflectionProbeKeysToRemove.Clear();
			m_FreeReflectionProbeSlots.Clear();
			for (int i = 0; i < 32; i++)
			{
				m_ReflectionProbeSlotKeys[i] = null;
				m_ReflectionProbeSlotTextures[i] = null;
				m_ReflectionProbeSlotTextureUpdateCounts[i] = 0u;
				m_ReflectionProbeSlotUsed[i] = false;
			}
			ClearReflectionProbeSlotData();
			m_ReflectionProbeSlotStateCleared = true;
		}
	}

	private int AllocateReflectionProbeSlot()
	{
		if (m_FreeReflectionProbeSlots.Count > 0)
		{
			int index = 0;
			int num = m_FreeReflectionProbeSlots[0];
			for (int i = 1; i < m_FreeReflectionProbeSlots.Count; i++)
			{
				if (m_FreeReflectionProbeSlots[i] < num)
				{
					num = m_FreeReflectionProbeSlots[i];
					index = i;
				}
			}
			m_FreeReflectionProbeSlots.RemoveAt(index);
			return num;
		}
		for (int j = 0; j < 32; j++)
		{
			if (!m_ReflectionProbeSlotUsed[j])
			{
				return j;
			}
		}
		return -1;
	}

	private void ReleaseReflectionProbeSlot(Object key, int slot)
	{
		m_ReflectionProbeSlots.Remove(key);
		m_ReflectionProbeSlotKeys[slot] = null;
		m_ReflectionProbeSlotTextures[slot] = null;
		m_ReflectionProbeSlotTextureUpdateCounts[slot] = 0u;
		m_ReflectionProbeSlotUsed[slot] = false;
		if (!m_FreeReflectionProbeSlots.Contains(slot))
		{
			m_FreeReflectionProbeSlots.Add(slot);
		}
	}

	private void PackRuntimeReflectionProbeData(VisibleReflectionProbe probe, int atlasLayer, int logicalIndex)
	{
		Bounds bounds = probe.bounds;
		Matrix4x4 localToWorldMatrix = probe.localToWorldMatrix;
		Vector4 column = localToWorldMatrix.GetColumn(3);
		ReflectionProbe reflectionProbe = probe.reflectionProbe;
		Vector3 vector;
		Vector3 vector2;
		Matrix4x4 matrix4x;
		if (reflectionProbe != null)
		{
			vector = localToWorldMatrix.MultiplyPoint3x4(probe.center);
			vector2 = reflectionProbe.size * 0.5f;
			matrix4x = Matrix4x4.Translate(-probe.center) * localToWorldMatrix.inverse;
		}
		else
		{
			vector = bounds.center;
			vector2 = bounds.extents;
			matrix4x = Matrix4x4.Translate(-vector);
		}
		float w = ((reflectionProbe != null) ? reflectionProbe.intensity : 1f);
		float num = Mathf.Max(0f, probe.blendDistance);
		float num2 = ((num > 0.0001f) ? (1f / num) : 0f);
		m_RuntimeReflectionProbeData[logicalIndex] = new DeferredReflectionProbeGpuData
		{
			capturePositionWSAtlasLayer = new Vector4(column.x, column.y, column.z, atlasLayer),
			volumeCenterWSIntensity = new Vector4(vector.x, vector.y, vector.z, w),
			worldToProbeLocalRow0 = matrix4x.GetRow(0),
			worldToProbeLocalRow1 = matrix4x.GetRow(1),
			worldToProbeLocalRow2 = matrix4x.GetRow(2),
			halfExtentsBlendDistance = new Vector4(vector2.x, vector2.y, vector2.z, num),
			reciprocalBlendBoxProjection = new Vector4(num2, num2, num2, probe.isBoxProjection ? 1f : 0f),
			hdrDecodeInstructions = probe.hdrData
		};
	}

	private int PrepareReflectionProbeSlots(out int logicalProbeCount)
	{
		m_ReflectionProbeSlotStateCleared = false;
		m_CurrentReflectionProbeKeys.Clear();
		for (int i = 0; i < m_TempProbList.Count; i++)
		{
			Object reflectionProbeKey = GetReflectionProbeKey(m_TempProbList[i]);
			if (reflectionProbeKey != null)
			{
				m_CurrentReflectionProbeKeys.Add(reflectionProbeKey);
			}
		}
		m_ReflectionProbeKeysToRemove.Clear();
		foreach (KeyValuePair<Object, int> reflectionProbeSlot in m_ReflectionProbeSlots)
		{
			if (!m_CurrentReflectionProbeKeys.Contains(reflectionProbeSlot.Key))
			{
				m_ReflectionProbeKeysToRemove.Add(reflectionProbeSlot.Key);
			}
		}
		for (int j = 0; j < m_ReflectionProbeKeysToRemove.Count; j++)
		{
			Object key = m_ReflectionProbeKeysToRemove[j];
			ReleaseReflectionProbeSlot(key, m_ReflectionProbeSlots[key]);
		}
		m_CopiedReflectionProbeKeys.Clear();
		logicalProbeCount = 0;
		for (int k = 0; k < m_TempProbList.Count; k++)
		{
			VisibleReflectionProbe probe = m_TempProbList[k];
			Object reflectionProbeKey2 = GetReflectionProbeKey(probe);
			if (reflectionProbeKey2 == null || !m_CurrentReflectionProbeKeys.Contains(reflectionProbeKey2) || !m_CopiedReflectionProbeKeys.Add(reflectionProbeKey2))
			{
				continue;
			}
			if (!m_ReflectionProbeSlots.TryGetValue(reflectionProbeKey2, out var value))
			{
				value = AllocateReflectionProbeSlot();
				if (value < 0)
				{
					m_CurrentReflectionProbeKeys.Remove(reflectionProbeKey2);
					continue;
				}
				m_ReflectionProbeSlots.Add(reflectionProbeKey2, value);
				m_ReflectionProbeSlotKeys[value] = reflectionProbeKey2;
				m_ReflectionProbeSlotTextures[value] = null;
				m_ReflectionProbeSlotTextureUpdateCounts[value] = 0u;
				m_ReflectionProbeSlotUsed[value] = true;
			}
			PackRuntimeReflectionProbeData(probe, value, logicalProbeCount);
			logicalProbeCount++;
		}
		int num = 0;
		foreach (Object currentReflectionProbeKey in m_CurrentReflectionProbeKeys)
		{
			if (m_ReflectionProbeSlots.TryGetValue(currentReflectionProbeKey, out var value2))
			{
				num = Mathf.Max(num, value2 + 1);
			}
		}
		return num;
	}

	private void CopyDirtyReflectionProbeSlots(CommandBuffer cmd, bool forceCopy)
	{
		m_CopiedReflectionProbeKeys.Clear();
		for (int i = 0; i < m_TempProbList.Count; i++)
		{
			VisibleReflectionProbe probe = m_TempProbList[i];
			Object reflectionProbeKey = GetReflectionProbeKey(probe);
			if (reflectionProbeKey == null || !m_CurrentReflectionProbeKeys.Contains(reflectionProbeKey) || !m_CopiedReflectionProbeKeys.Add(reflectionProbeKey) || !m_ReflectionProbeSlots.TryGetValue(reflectionProbeKey, out var value))
			{
				continue;
			}
			Cubemap cubemap = GetProbTexture(probe) as Cubemap;
			if (cubemap == null)
			{
				continue;
			}
			uint updateCount = cubemap.updateCount;
			if (forceCopy || !(m_ReflectionProbeSlotTextures[value] == cubemap) || m_ReflectionProbeSlotTextureUpdateCounts[value] != updateCount)
			{
				for (int j = 0; j < 6; j++)
				{
					cmd.CopyTexture(cubemap, j, m_ReflectionProb, value * 6 + j);
				}
				m_ReflectionProbeSlotTextures[value] = cubemap;
				m_ReflectionProbeSlotTextureUpdateCounts[value] = updateCount;
			}
		}
	}

	internal void Dispose()
	{
		SetReflectionEmpty();
		m_TempProbList.Clear();
	}

	private static void SetGlobalSHData(CommandBuffer cmd)
	{
		SphericalHarmonicsL2 ambientProbe = RenderSettings.ambientProbe;
		cmd.SetGlobalVector(SHArID, new Vector4(ambientProbe[0, 3], ambientProbe[0, 1], ambientProbe[0, 2], ambientProbe[0, 0] - ambientProbe[0, 6]));
		cmd.SetGlobalVector(SHAgID, new Vector4(ambientProbe[1, 3], ambientProbe[1, 1], ambientProbe[1, 2], ambientProbe[1, 0] - ambientProbe[1, 6]));
		cmd.SetGlobalVector(SHAbID, new Vector4(ambientProbe[2, 3], ambientProbe[2, 1], ambientProbe[2, 2], ambientProbe[2, 0] - ambientProbe[2, 6]));
		cmd.SetGlobalVector(SHBrID, new Vector4(ambientProbe[0, 4], ambientProbe[0, 5], ambientProbe[0, 6] * 3f, ambientProbe[0, 7]));
		cmd.SetGlobalVector(SHBgID, new Vector4(ambientProbe[1, 4], ambientProbe[1, 5], ambientProbe[1, 6] * 3f, ambientProbe[1, 7]));
		cmd.SetGlobalVector(SHBbID, new Vector4(ambientProbe[2, 4], ambientProbe[2, 5], ambientProbe[2, 6] * 3f, ambientProbe[2, 7]));
		cmd.SetGlobalVector(SHCID, new Vector4(ambientProbe[0, 8], ambientProbe[1, 8], ambientProbe[2, 8], 0f));
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		Camera camera = renderingData.cameraData.camera;
		Transform transform = camera.transform;
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredReflectionProbeEnabled, 0);
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredReflectionProbeCount, 0);
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredReflectionProbeActiveMask, 0);
		CoreUtils.SetKeyword(cmd, "_DEFERRED_REFLECTION_PROBE_RUNTIME_ATLAS", state: false);
		CoreUtils.SetKeyword(cmd, "_DEFERRED_BAKERY_VOLUME_GI", state: false);
		bool requiresMotionVectorOutput = renderingData.postProcessingData.requiresMotionVectorOutput;
		bool flag = renderer != null && renderer.actualRenderingMode == RenderingMode.Deferred && renderingData.cameraData.isGameCamera && renderingData.cameraData.isBase;
		UniversalRenderPipelineAsset asset = UniversalRenderPipeline.asset;
		bool value = ((asset != null) ? (asset.actualRenderPassScheduleMode == RenderPassScheduleMode.Mobile) : (renderer != null && renderer.renderPassScheduleMode == RenderPassScheduleMode.Mobile));
		cmd.SetKeyword(in ShaderKeywords.MobileRenderPassScheduleKeyword, value);
		cmd.SetGlobalFloat(GenericBloomWeight, m_VolumeComponents.Bloom.GenericBloomWeight.value);
		if ((renderingData.postProcessingData.motionFeature | flag) && renderer != null && !renderer.CurrentFrameNeedTemporalJitter)
		{
			FrameData motionDataForCamera = MotionVectorRendering.instance.GetMotionDataForCamera(camera, renderingData.cameraData.GetProjectionMatrix());
			cmd.SetGlobalMatrix(PrevViewProjMatrix, motionDataForCamera.previousViewProjectionMatrix);
			cmd.SetGlobalMatrix(PrevOutlineViewMatrix, motionDataForCamera.previousViewMatrix);
			cmd.SetGlobalMatrix(ViewProjMatrixNoJitter, motionDataForCamera.viewProjectionMatrix);
			if (flag)
			{
				cmd.SetGlobalMatrix(SkyMotionReprojectionMatrix, motionDataForCamera.GetSkyMotionReprojectionMatrix());
			}
			cmd.SetGlobalVector(Jitter, Vector4.zero);
		}
		int num;
		int num2;
		if (renderer != null)
		{
			num = ((renderer.actualRenderingMode == RenderingMode.Deferred) ? 1 : 0);
			if (num != 0 && renderer.deferredLights != null)
			{
				num2 = (renderer.deferredLights.TryGetOfflineReflectionProbeData(out var _) ? 1 : 0);
				goto IL_01c2;
			}
		}
		else
		{
			num = 0;
		}
		num2 = 0;
		goto IL_01c2;
		IL_01c2:
		bool flag2 = (byte)num2 != 0;
		if (num != 0 && RuntimeReflectionProbeSupported && !flag2 && (renderingData.cameraData.isGameCamera || renderingData.cameraData.isSceneViewCamera))
		{
			NativeArray<VisibleReflectionProbe> visibleReflectionProbes = renderingData.cullResults.visibleReflectionProbes;
			m_TempProbList.Clear();
			Vector3 position = transform.position;
			Vector3 forward = transform.forward;
			for (int i = 0; i < visibleReflectionProbes.Length; i++)
			{
				VisibleReflectionProbe visibleReflectionProbe = visibleReflectionProbes[i];
				Bounds bounds = visibleReflectionProbe.bounds;
				Vector3 center = bounds.center;
				float magnitude = bounds.extents.magnitude;
				float depth = Vector3.Dot(center - position, forward);
				if (CheckProb(depth, magnitude) && CheckProbTexture(visibleReflectionProbe))
				{
					m_TempProbList.Add(visibleReflectionProbe);
					if (m_TempProbList.Count == 32)
					{
						break;
					}
				}
			}
			Cubemap referenceCubemap;
			if (m_TempProbList.Count == 0)
			{
				SetReflectionInactive(cmd);
			}
			else if (!TryGetValidReferenceCubemap(out referenceCubemap))
			{
				SetReflectionInactive(cmd);
			}
			else
			{
				FilterInvalidReflectionProbes(referenceCubemap);
				if (m_TempProbList.Count == 0)
				{
					SetReflectionInactive(cmd);
				}
				else
				{
					int num3 = PrepareReflectionProbeSlots(out var logicalProbeCount);
					if (num3 == 0 || logicalProbeCount == 0)
					{
						SetReflectionInactive(cmd);
					}
					else
					{
						bool forceCopy = CreateReflectionProbesTexture(referenceCubemap.width, referenceCubemap.format, num3);
						CopyDirtyReflectionProbeSlots(cmd, forceCopy);
						cmd.SetGlobalTexture(CurrentProbTag, m_ReflectionProb);
						UploadRuntimeReflectionProbeData(cmd, logicalProbeCount);
						cmd.SetGlobalInteger(CurrentProbCountTag, logicalProbeCount);
					}
				}
			}
			CoreUtils.SetKeyword(cmd, "_DEFERRED_REFLECTION_PROBE_RUNTIME_ATLAS", state: true);
		}
		else
		{
			SetReflectionInactive(cmd);
		}
		cmd.DisableKeyword(in ShaderKeywords.FilmBlackKeyword);
		cmd.DisableKeyword(in TemporalHistoryKeyword);
		ExpHeightFog expHeightFog = m_VolumeComponents.ExpHeightFog;
		cmd.SetGlobalVector(HeightFogFactorTag, new Vector4(expHeightFog.fogDensity.value / 100f, expHeightFog.heightFactor.value / 100f, expHeightFog.seaLevel.value, expHeightFog.distanceFactor.value));
		cmd.SetGlobalVector(HeightFogFactorTag2, new Vector4(expHeightFog.SunFactor.value, expHeightFog.SunIntensity.value, expHeightFog.distanceClamp.value));
		cmd.SetGlobalColor(HeightFogColorTag, expHeightFog.heightFogColor.value);
		bool flag3 = renderingData.cameraData.isBase && (renderingData.cameraData.isGameCamera || renderingData.cameraData.isSceneViewCamera) && nativeRenderPassManager.autoExposureEnabledForCamera;
		cmd.SetGlobalFloat(AutoExposureEnable, 0f);
		cmd.SetGlobalFloat(DeferredSceneAutoExposureEnable, flag3 ? 1f : 0f);
		GenericColorControl genericColorControl = m_VolumeComponents.GenericColorControl;
		float value2 = genericColorControl.intensity.value;
		cmd.SetGlobalFloat(GenericAmbientLightIntensity, Mathf.Pow(2f, genericColorControl.ambientLightEV.value * value2));
		cmd.SetGlobalFloat(GenericDirectLightIntensity, Mathf.Pow(2f, genericColorControl.directLightEV.value * value2));
		cmd.SetGlobalFloat(GenericReflectionProbeIntensity, Mathf.Pow(2f, genericColorControl.reflectionProbeEV.value * value2));
		SetGlobalSHData(cmd);
		cmd.DisableKeyword(in ShaderKeywords.SceneScatterKeyword);
		cmd.SetGlobalFloat(SceneScatterMode, 0f);
		DeSaturate deSaturate = m_VolumeComponents.DeSaturate;
		float value3 = deSaturate.deSaturate.value;
		float value4 = deSaturate.darken.value;
		bool sceneToneInGrabPass = renderingData.sceneToneInGrabPass;
		cmd.SetGlobalFloat(m_DeSaturateID, sceneToneInGrabPass ? 0f : value3);
		cmd.SetGlobalFloat(m_DarkenID, sceneToneInGrabPass ? 0f : value4);
		InnerWorldFilter innerWorldFilter = m_VolumeComponents.InnerWorldFilter;
		int num4;
		int num5;
		if (innerWorldFilter != null)
		{
			num4 = (innerWorldFilter.RequiresGlobalShaderParams() ? 1 : 0);
			if (num4 != 0)
			{
				num5 = InnerWorldFilterMask.WriteActiveMasks(m_InnerWorldFilterMasks);
				goto IL_05b8;
			}
		}
		else
		{
			num4 = 0;
		}
		num5 = 0;
		goto IL_05b8;
		IL_05b8:
		int num6 = num5;
		if (num4 != 0 && num6 > 0)
		{
			cmd.SetGlobalVector(InnerWorldFilterParams, new Vector4(innerWorldFilter.intensity.value, innerWorldFilter.saturation.value, innerWorldFilter.brightness.value, innerWorldFilter.contrast.value));
			cmd.SetGlobalVector(InnerWorldFilterColor, new Vector4(innerWorldFilter.tintColor.value.r, innerWorldFilter.tintColor.value.g, innerWorldFilter.tintColor.value.b, innerWorldFilter.tintStrength.value));
			cmd.SetGlobalVector(InnerWorldFilterStyle, new Vector4(innerWorldFilter.darkness.value, innerWorldFilter.edgeIntensity.value, innerWorldFilter.grainIntensity.value, innerWorldFilter.invertMask.value ? 1f : 0f));
			cmd.SetGlobalVector(InnerWorldFilterEdgeColor, new Vector4(innerWorldFilter.edgeColor.value.r, innerWorldFilter.edgeColor.value.g, innerWorldFilter.edgeColor.value.b, innerWorldFilter.edgeColor.value.a));
			cmd.SetGlobalVector(InnerWorldFilterRipple, new Vector4(innerWorldFilter.rippleIntensity.value, innerWorldFilter.rippleFrequency.value, innerWorldFilter.rippleSpeed.value, 0f));
			cmd.SetGlobalVector(InnerWorldFilterRippleColor, new Vector4(innerWorldFilter.rippleColor.value.r, innerWorldFilter.rippleColor.value.g, innerWorldFilter.rippleColor.value.b, innerWorldFilter.rippleColor.value.a));
			cmd.SetGlobalVector(InnerWorldFilterCausticsStyle, new Vector4(innerWorldFilter.causticsContrast.value, innerWorldFilter.edgeGlowSoftness.value, innerWorldFilter.edgeBreakup.value, innerWorldFilter.edgeChromatic.value));
			cmd.SetGlobalVector(InnerWorldShadowColorGround, new Vector4(innerWorldFilter.innerShadowColorGround.value.r, innerWorldFilter.innerShadowColorGround.value.g, innerWorldFilter.innerShadowColorGround.value.b, innerWorldFilter.innerShadowColorGround.value.a));
			cmd.SetGlobalVector(InnerWorldShadowColorHorizon, new Vector4(innerWorldFilter.innerShadowColorHorizon.value.r, innerWorldFilter.innerShadowColorHorizon.value.g, innerWorldFilter.innerShadowColorHorizon.value.b, innerWorldFilter.innerShadowColorHorizon.value.a));
			cmd.SetGlobalVector(InnerWorldShadowColorSky, new Vector4(innerWorldFilter.innerShadowColorSky.value.r, innerWorldFilter.innerShadowColorSky.value.g, innerWorldFilter.innerShadowColorSky.value.b, innerWorldFilter.innerShadowColorSky.value.a));
			cmd.SetGlobalVector(InnerWorldShadowColorParams, new Vector4(innerWorldFilter.innerShadowColorBlend.value, 0f, 0f, 0f));
			cmd.SetGlobalVector(InnerWorldLinearFogColor, new Vector4(innerWorldFilter.innerLinearFogColor.value.r, innerWorldFilter.innerLinearFogColor.value.g, innerWorldFilter.innerLinearFogColor.value.b, innerWorldFilter.innerLinearFogColor.value.a));
			cmd.SetGlobalVector(InnerWorldLinearFogParams, new Vector4(innerWorldFilter.innerLinearFogStart.value, innerWorldFilter.innerLinearFogEnd.value, innerWorldFilter.innerLinearFogBlend.value, 0f));
			cmd.SetGlobalVectorArray(InnerWorldFilterMasks, m_InnerWorldFilterMasks);
			cmd.SetGlobalInteger(InnerWorldFilterMaskCount, num6);
			cmd.SetGlobalFloat(InnerWorldFilterEdgeFeather, innerWorldFilter.edgeFeather.value);
			m_InnerWorldGlobalsCleared = false;
		}
		else if (!m_InnerWorldGlobalsCleared)
		{
			cmd.SetGlobalVector(InnerWorldFilterParams, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldFilterColor, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldFilterStyle, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldFilterEdgeColor, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldFilterRipple, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldFilterRippleColor, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldFilterCausticsStyle, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldShadowColorGround, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldShadowColorHorizon, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldShadowColorSky, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldShadowColorParams, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldLinearFogColor, Vector4.zero);
			cmd.SetGlobalVector(InnerWorldLinearFogParams, Vector4.zero);
			cmd.SetGlobalInteger(InnerWorldFilterMaskCount, 0);
			cmd.SetGlobalFloat(InnerWorldFilterEdgeFeather, 1f);
			m_InnerWorldGlobalsCleared = true;
		}
		ArtLine artLine = m_VolumeComponents.ArtLine;
		if (artLine.IsActive())
		{
			cmd.SetGlobalFloat(ArtLine, 1f);
			cmd.SetGlobalVector(LineColor, artLine.lineColor.value);
			cmd.SetGlobalVector(Threshold, new Vector4(artLine.NormalThreshold.value, artLine.NormalRange.value, artLine.DepthThreshold.value, artLine.DepthRange.value));
			cmd.SetGlobalVector(Fade, new Vector4(artLine.FadeStart.value, artLine.FadeFactor.value, 0f, 0f));
		}
		else
		{
			cmd.SetGlobalFloat(ArtLine, 0f);
		}
		cmd.SetGlobalFloat(HasVector, requiresMotionVectorOutput ? 1 : 0);
		cmd.SetKeyword(in MotionVectorKeyword, requiresMotionVectorOutput);
		Vector3 up = transform.up;
		Vector3 forward2 = transform.forward;
		LightData lightData = renderingData.lightData;
		int mainLightIndex = lightData.mainLightIndex;
		Light light = null;
		if (mainLightIndex >= 0 && mainLightIndex < lightData.visibleLights.Length)
		{
			light = lightData.visibleLights[mainLightIndex].light;
			if (DirectLightControl.m_MainLight != light)
			{
				DirectLightControl.m_MainLight = light;
			}
		}
		else if (DirectLightControl.m_MainLight != null)
		{
			DirectLightControl.m_MainLight = null;
		}
		DirectLightControl.UpdateCharMainlightIntensity(light);
		DirectLightControl.RefreshGPUData(cmd);
		float time = Time.time;
		int frameCount = Time.frameCount;
		cmd.SetGlobalVector(TimeTag, new Vector4(time / 10f, time, frameCount, 0f));
		cmd.SetGlobalInteger(HDCharShadowCount, 0);
		cmd.SetGlobalInteger(HDCharShadowValidMask, 0);
		cmd.SetGlobalInteger(ToonGenericTransparentShadowReceiveEnabled, m_Renderer.shadowTransparentReceive ? 1 : 0);
		cmd.SetGlobalInteger(CharacterMainLightShadowReceiveEnabled, m_Renderer.characterMainLightShadowReceive ? 1 : 0);
		cmd.SetGlobalFloat(CharacterMainLightShadowNormalBias, (asset != null) ? asset.characterMainLightShadowNormalBias : 0.01f);
		cmd.SetGlobalFloat(m_FrameID, frameCount);
		cmd.SetGlobalVector(m_CameraUpID, up);
		cmd.SetGlobalVector(m_CameraForwardID, forward2);
		cmd.SetGlobalFloat(m_CameraFOVID, camera.fieldOfView * (MathF.PI / 180f));
		Matrix4x4 viewMatrix = renderingData.cameraData.GetViewMatrix();
		cmd.SetGlobalMatrix(m_VMatrixID, viewMatrix);
		Matrix4x4 value5 = renderingData.cameraData.GetGPUProjectionMatrix() * viewMatrix;
		cmd.SetGlobalMatrix(m_VPMatrixID, value5);
		cmd.SetGlobalTexture(m_SkyBoxID, ReflectionProbe.defaultTexture);
		cmd.SetGlobalVector(m_SkyBoxHDRID, ReflectionProbe.defaultTextureHDRDecodeValues);
		if (!notFristFrame)
		{
			cmd.SetGlobalTexture(m_PerlinNoiseID, perlinNoiseTex);
			cmd.SetGlobalTexture(m_PreIntegralDataID, preIntegralTex);
			cmd.SetGlobalFloat(CharQualityTag, 3f);
			notFristFrame = true;
		}
		if (!renderingData.cameraData.isSceneViewCamera)
		{
			List<WindField.Wind> globalWindList = WindField.GlobalWindList;
			if (globalWindList != null)
			{
				int num7 = Mathf.Min(32, globalWindList.Count);
				cmd.SetGlobalInteger(GlobalWindCountTag, num7);
				if (num7 > 0)
				{
					for (int j = 0; j < num7; j++)
					{
						WindField.Wind wind = WindField.GlobalWindList[j];
						Vector3 normalized = wind.WaveForward.normalized;
						GlobalWindListData[j] = new Vector4(1f / Mathf.Max(wind.WaveLength, 0.001f) * WindField.windGlobalSize, wind.WaveHeight, wind.WaveIntensity * WindField.windGlobalIntensity, Mathf.Min(wind.smoothness, 0.99f));
						GlobalWindListData2[j] = new Vector4(normalized.x, normalized.y, normalized.z, wind.timeScale * WindField.windGlobalTimeScale);
					}
					cmd.SetGlobalVectorArray(GlobalWindListTag, GlobalWindListData);
					cmd.SetGlobalVectorArray(GlobalWindListTag2, GlobalWindListData2);
				}
			}
			else
			{
				cmd.SetGlobalInteger(GlobalWindCountTag, 0);
			}
		}
		if (renderingData.cameraData.isSceneViewCamera || renderingData.cameraData.isGameCamera)
		{
			GeometryUtility.CalculateFrustumPlanes(camera, m_cameraPlanes);
			for (int k = 0; k < planeTagList.Length; k++)
			{
				Vector3 normal = m_cameraPlanes[k].normal;
				cmd.SetGlobalVector(planeTagList[k], new Vector4(normal.x, normal.y, normal.z, m_cameraPlanes[k].distance));
			}
		}
		if (GlobalRenderingControl.skyBlendMats != null)
		{
			if (GlobalRenderingControl.skyBlendMats.Count > 0 && GlobalRenderingControl.skyBlendMats[0].m_SkyMaterial != null)
			{
				Material skyMaterial = GlobalRenderingControl.skyBlendMats[0].m_SkyMaterial;
				float weight = GlobalRenderingControl.skyBlendMats[0].weight;
				Texture texture = skyMaterial.GetTexture(CurrentTexTag);
				Texture texture2 = skyMaterial.GetTexture(CurrentFlowTag);
				Texture texture3 = skyMaterial.GetTexture(CurrentDissolveTag);
				Vector4 vector = skyMaterial.GetVector(ColorTag);
				Vector4 vector2 = skyMaterial.GetVector(CurrentFlowSTTag);
				Vector4 vector3 = skyMaterial.GetVector(CurrentDissolveSTTag);
				float x = skyMaterial.GetFloat(FlowIntensityTag);
				float y = skyMaterial.GetFloat(FlowTimeScaleTag);
				float z = skyMaterial.GetFloat(DissolveIntensityTag);
				float w = skyMaterial.GetFloat(DissolveRangeTag);
				cmd.SetGlobalTexture(CurrentTexTag, texture);
				cmd.SetGlobalTexture(CurrentFlowTag, texture2);
				cmd.SetGlobalTexture(CurrentDissolveTag, texture3);
				cmd.SetGlobalVector(CurrentColorTag, vector);
				cmd.SetGlobalVector(CurrentDataTag, vector2);
				cmd.SetGlobalVector(CurrentData2Tag, vector3);
				cmd.SetGlobalVector(CurrentData3Tag, new Vector4(x, y, z, w));
				cmd.SetGlobalFloat(CurrentWeightTag, weight);
			}
			else
			{
				cmd.SetGlobalFloat(CurrentWeightTag, 0f);
				cmd.SetGlobalFloat(NextWeightTag, 0f);
			}
			if (GlobalRenderingControl.skyBlendMats.Count > 1 && GlobalRenderingControl.skyBlendMats[1].m_SkyMaterial != null)
			{
				Material skyMaterial2 = GlobalRenderingControl.skyBlendMats[1].m_SkyMaterial;
				float weight2 = GlobalRenderingControl.skyBlendMats[1].weight;
				Texture texture4 = skyMaterial2.GetTexture(CurrentTexTag);
				Texture texture5 = skyMaterial2.GetTexture(CurrentFlowTag);
				Texture texture6 = skyMaterial2.GetTexture(CurrentDissolveTag);
				Vector4 vector4 = skyMaterial2.GetVector(ColorTag);
				Vector4 vector5 = skyMaterial2.GetVector(CurrentFlowSTTag);
				Vector4 vector6 = skyMaterial2.GetVector(CurrentDissolveSTTag);
				float x2 = skyMaterial2.GetFloat(FlowIntensityTag);
				float y2 = skyMaterial2.GetFloat(FlowTimeScaleTag);
				float z2 = skyMaterial2.GetFloat(DissolveIntensityTag);
				float w2 = skyMaterial2.GetFloat(DissolveRangeTag);
				cmd.SetGlobalTexture(NextTexTag, texture4);
				cmd.SetGlobalTexture(NextFlowTag, texture5);
				cmd.SetGlobalTexture(NextDissolveTag, texture6);
				cmd.SetGlobalVector(NextColorTag, vector4);
				cmd.SetGlobalVector(NextDataTag, vector5);
				cmd.SetGlobalVector(NextData2Tag, vector6);
				cmd.SetGlobalVector(NextData3Tag, new Vector4(x2, y2, z2, w2));
				cmd.SetGlobalFloat(NextWeightTag, weight2);
			}
			else
			{
				cmd.SetGlobalFloat(NextWeightTag, 0f);
			}
		}
	}
}
