using System;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal.Internal;

internal class DeferredLights
{
	internal static class ShaderConstants
	{
		public static readonly int _DeferredSceneStencilRef = Shader.PropertyToID("_DeferredSceneStencilRef");

		public static readonly int _DeferredPlantStencilRef = Shader.PropertyToID("_DeferredPlantStencilRef");

		public static readonly int _DeferredMaterialStencilReadMask = Shader.PropertyToID("_DeferredMaterialStencilReadMask");

		public static readonly int _DeferredCharacterStencilRef = Shader.PropertyToID("_DeferredCharacterStencilRef");

		public static readonly int _DeferredCharacterStencilReadMask = Shader.PropertyToID("_DeferredCharacterStencilReadMask");

		public static readonly int _DeferredCharacterRimEnabled = Shader.PropertyToID("_DeferredCharacterRimEnabled");

		public static readonly int _DeferredSSREnabled = Shader.PropertyToID("_DeferredSSREnabled");

		public static readonly int _DeferredFullscreenMediaCompositeEnabled = Shader.PropertyToID("_DeferredFullscreenMediaCompositeEnabled");

		public static readonly int _ScreenToWorld = Shader.PropertyToID("_ScreenToWorld");

		public static readonly int _LightDirection = Shader.PropertyToID("_LightDirection");

		public static readonly int _LightPosition = Shader.PropertyToID("_LightPosition");

		public static readonly int _ShadowBias = Shader.PropertyToID("_ShadowBias");

		public static readonly int _DeferredClusterMasks = Shader.PropertyToID("_DeferredClusterMasks");

		public static readonly int _DeferredClusterLightIndices = Shader.PropertyToID("_DeferredClusterLightIndices");

		public static readonly int _DeferredClusterLightVolumes = Shader.PropertyToID("_DeferredClusterLightVolumes");

		public static readonly int _DeferredClusterInvProjection = Shader.PropertyToID("_DeferredClusterInvProjection");

		public static readonly int _DeferredClusterScreenSize = Shader.PropertyToID("_DeferredClusterScreenSize");

		public static readonly int _DeferredClusterOrthographic = Shader.PropertyToID("_DeferredClusterOrthographic");

		public static readonly int _DeferredClusterTileCountX = Shader.PropertyToID("_DeferredClusterTileCountX");

		public static readonly int _DeferredClusterTileCountY = Shader.PropertyToID("_DeferredClusterTileCountY");

		public static readonly int _DeferredClusterDepthOffset = Shader.PropertyToID("_DeferredClusterDepthOffset");

		public static readonly int _DeferredClusterLightCount = Shader.PropertyToID("_DeferredClusterLightCount");

		public static readonly int _DeferredClusterLightMaskWordCount = Shader.PropertyToID("_DeferredClusterLightMaskWordCount");

		public static readonly int[] _DeferredClusterSceneScatterLightMasks = new int[1] { Shader.PropertyToID("_DeferredClusterSceneScatterLightMask") };

		public static readonly int _DeferredClusterNearClip = Shader.PropertyToID("_DeferredClusterNearClip");

		public static readonly int _DeferredClusterInvViewProjection = Shader.PropertyToID("_DeferredClusterInvViewProjection");

		public static readonly int _DeferredClusterCameraPositionWS = Shader.PropertyToID("_DeferredClusterCameraPositionWS");

		public static readonly int _DeferredClusterCameraForwardWS = Shader.PropertyToID("_DeferredClusterCameraForwardWS");

		public static readonly int _DeferredReflectionProbeData = Shader.PropertyToID("_DeferredReflectionProbeData");

		public static readonly int _DeferredReflectionProbeAtlas = Shader.PropertyToID("_DeferredReflectionProbeAtlas");

		public static readonly int _DeferredReflectionProbeCount = Shader.PropertyToID("_DeferredReflectionProbeCount");

		public static readonly int _DeferredReflectionProbeActiveMask = Shader.PropertyToID("_DeferredReflectionProbeActiveMask");

		public static readonly int _DeferredReflectionProbeScreenOffset = Shader.PropertyToID("_DeferredReflectionProbeScreenOffset");

		public static readonly int _DeferredReflectionProbeDepthOffset = Shader.PropertyToID("_DeferredReflectionProbeDepthOffset");

		public static readonly int _DeferredReflectionProbeMaxSampleMip = Shader.PropertyToID("_DeferredReflectionProbeMaxSampleMip");

		public static readonly int _DeferredReflectionProbeEnabled = Shader.PropertyToID("_DeferredReflectionProbeEnabled");

		public static readonly int _DeferredBakeryVolumeL0 = Shader.PropertyToID("_DeferredBakeryVolumeL0");

		public static readonly int _DeferredBakeryVolumeL1Texture0 = Shader.PropertyToID("_DeferredBakeryVolumeL1Texture0");

		public static readonly int _DeferredBakeryVolumeL1Texture1 = Shader.PropertyToID("_DeferredBakeryVolumeL1Texture1");

		public static readonly int _DeferredBakeryVolumeL1Texture2 = Shader.PropertyToID("_DeferredBakeryVolumeL1Texture2");

		public static readonly int _DeferredBakeryVolumeValid = Shader.PropertyToID("_DeferredBakeryVolumeValid");

		public static readonly int _DeferredBakeryShadowMaskInRed = Shader.PropertyToID("_DeferredBakeryShadowMaskInRed");

		public static readonly int _DeferredBakeryVolumeMin = Shader.PropertyToID("_DeferredBakeryVolumeMin");

		public static readonly int _DeferredBakeryVolumeInvSize = Shader.PropertyToID("_DeferredBakeryVolumeInvSize");

		public static readonly int _ACTSceneBakerySH0 = Shader.PropertyToID("_ACTSceneBakerySH0");

		public static readonly int _ACTSceneBakerySH1 = Shader.PropertyToID("_ACTSceneBakerySH1");

		public static readonly int _ACTSceneBakerySH2 = Shader.PropertyToID("_ACTSceneBakerySH2");

		public static readonly int _ACTSceneBakerySH3 = Shader.PropertyToID("_ACTSceneBakerySH3");

		public static readonly int _ACTSceneSHSource = Shader.PropertyToID("_ACTSceneSHSource");
	}

	internal enum StencilDeferredPasses
	{
		LightmapGIResolve,
		PunctualScene,
		PunctualPlant,
		MainScene,
		MainPlant,
		EnvironmentScene,
		EnvironmentPlant,
		CharacterEnvironment,
		MediaComposite
	}

	internal struct InitParams
	{
		public Material stencilDeferredMaterial;

		public ComputeShader deferredClusterComputeShader;
	}

	private struct DeferredClusterLightVolume
	{
		public Vector4 positionRange;

		public Vector4 directionTanHalfAngle;

		public Vector4 typeData;
	}

	private static readonly string[] k_GBufferNames = new string[7] { "_GBuffer0", "_GBuffer1", "_GBuffer2", "_GBuffer3", "_GBuffer4", "_GBuffer5", "_GBuffer6" };

	private static readonly string[] k_StencilDeferredPassNames = new string[9] { "Deferred Lightmap GI Resolve", "Deferred Punctual Scene", "Deferred Punctual Plant", "Deferred Main Scene", "Deferred Main Plant", "Deferred Environment Scene", "Deferred Environment Plant", "Deferred Character Environment", "Deferred Media Composite" };

	private static readonly string k_DeferredLightsSetup = "Deferred Lights Setup";

	private static readonly string k_DeferredPass = "Deferred Direct Light";

	private static readonly string k_DeferredEnvironment = "Deferred Environment Resolve";

	private const int k_DeferredClusterTileSize = 32;

	private const int k_DeferredClusterDepthSliceCount = 128;

	private const int k_DeferredClusterMaxLightCount = 32;

	private const int k_DeferredClusterMaskBitCount = 32;

	private const int k_DeferredClusterLightMaskWordCount = 1;

	private const int k_DeferredClusterLightVolumeStride = 48;

	private const int k_DeferredReflectionProbeStride = 128;

	internal const int GBufferMaterial1Index = 0;

	internal const int GBufferMaterial0Index = 1;

	internal const int GBufferMotionFeatureIndex = 2;

	internal const int GBufferLightingIndex = 3;

	internal const int GBufferSliceCount = 4;

	private AdditionalLightsShadowCasterPass m_AdditionalLightsShadowCasterPass;

	private Material m_StencilDeferredMaterial;

	private int[] m_StencilDeferredPasses;

	private Matrix4x4 m_ScreenToWorld;

	private ProfilingSampler m_ProfilingDeferredPass = new ProfilingSampler(k_DeferredPass);

	private readonly ProfilingSampler m_ProfilingClusterLights = new ProfilingSampler("Deferred Cluster Lights");

	private readonly ProfilingSampler m_ProfilingClusterReflectionProbes = new ProfilingSampler("Deferred Cluster Reflection Probes");

	private ProfilingSampler m_ProfilingSamplerEnvironmentPass = new ProfilingSampler(k_DeferredEnvironment);

	private readonly RenderPassScheduleMode m_RenderPassScheduleMode;

	private readonly ComputeShader m_DeferredClusterComputeShader;

	private readonly int m_DeferredClusterScreenKernel;

	private readonly int m_DeferredClusterDepthKernel;

	private readonly int m_DeferredReflectionProbeScreenKernel;

	private readonly int m_DeferredReflectionProbeDepthKernel;

	private readonly bool m_DeferredClusterPlatformSupported;

	private readonly bool m_DeferredReflectionProbePlatformSupported;

	private readonly DeferredClusterLightVolume[] m_DeferredClusterLightVolumes = new DeferredClusterLightVolume[32];

	private readonly uint[] m_DeferredClusterLightIndices = new uint[32];

	private readonly uint[] m_DeferredClusterSceneScatterLightMasks = new uint[1];

	private ComputeBuffer m_DeferredClusterLightVolumeBuffer;

	private ComputeBuffer m_DeferredClusterLightIndexBuffer;

	private ComputeBuffer m_DeferredClusterMaskBuffer;

	private int m_DeferredClusterMaskBufferCount;

	private int m_DeferredClusterLightCount;

	private int m_DeferredClusterDepthOffset;

	private int m_DeferredClusterTileCountX;

	private int m_DeferredClusterTileCountY;

	private ComputeBuffer m_DeferredReflectionProbeBuffer;

	private DeferredReflectionProbeSceneData m_DeferredReflectionProbeSceneData;

	private string m_DeferredReflectionProbeContentHash;

	private int m_DeferredReflectionProbeCount;

	private int m_DeferredReflectionProbeScreenOffset;

	private int m_DeferredReflectionProbeDepthOffset;

	private bool m_DeferredReflectionProbeUseThisFrame;

	private uint m_DeferredReflectionProbeActiveMask;

	private bool m_DeferredClusterOverflowWarningIssued;

	private bool m_DeferredClusterUnavailableWarningIssued;

	private bool m_DeferredReflectionProbeUnavailableWarningIssued;

	private bool m_Initialized;

	private bool m_UseBakeryVolumeGIThisCamera;

	internal bool HasDepthPrepass { get; set; }

	internal bool HasNormalPrepass { get; set; }

	internal RenderTargetHandle[] GbufferAttachments { get; set; }

	internal RenderTargetHandle DepthAttachment { get; set; }

	internal RenderTargetIdentifier[] GbufferAttachmentIdentifiers { get; set; }

	internal RenderTargetIdentifier[] GbufferOutputAttachmentIdentifiers { get; private set; }

	internal GraphicsFormat[] GbufferFormats { get; private set; }

	internal RenderTargetIdentifier DepthAttachmentIdentifier { get; set; }

	private void InitializeGBufferFormats()
	{
		GbufferFormats = new GraphicsFormat[4];
		GbufferFormats[0] = GraphicsFormat.R8G8B8A8_SRGB;
		GbufferFormats[1] = GraphicsFormat.R8G8B8A8_UNorm;
		GbufferFormats[2] = GraphicsFormat.A2B10G10R10_UNormPack32;
		GbufferFormats[3] = GraphicsFormat.None;
	}

	internal bool TryGetOfflineReflectionProbeData(out DeferredReflectionProbeSceneData reflectionProbeData)
	{
		bool flag = DeferredSceneLightingRegistry.TryGetActiveData(out reflectionProbeData);
		return m_DeferredReflectionProbePlatformSupported & flag;
	}

	internal DeferredLights(InitParams initParams, RenderPassScheduleMode renderPassScheduleMode)
	{
		DeferredConfig.IsOpenGL = SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLCore || SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES2 || SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES3;
		DeferredConfig.IsDX10 = SystemInfo.graphicsDeviceType == GraphicsDeviceType.Direct3D11 && SystemInfo.graphicsShaderLevel <= 40;
		m_StencilDeferredMaterial = initParams.stencilDeferredMaterial;
		m_DeferredClusterComputeShader = initParams.deferredClusterComputeShader;
		m_DeferredClusterScreenKernel = -1;
		m_DeferredClusterDepthKernel = -1;
		m_DeferredReflectionProbeScreenKernel = -1;
		m_DeferredReflectionProbeDepthKernel = -1;
		bool flag = m_DeferredClusterComputeShader != null && SystemInfo.supportsComputeShaders && SystemInfo.graphicsShaderLevel >= 45;
		if (flag && m_DeferredClusterComputeShader.HasKernel("BuildScreenMasks") && m_DeferredClusterComputeShader.HasKernel("BuildDepthMasks"))
		{
			m_DeferredClusterScreenKernel = m_DeferredClusterComputeShader.FindKernel("BuildScreenMasks");
			m_DeferredClusterDepthKernel = m_DeferredClusterComputeShader.FindKernel("BuildDepthMasks");
			m_DeferredClusterLightVolumeBuffer = new ComputeBuffer(32, 48);
			m_DeferredClusterLightIndexBuffer = new ComputeBuffer(32, 4);
			m_DeferredClusterMaskBuffer = new ComputeBuffer(1, 4);
			m_DeferredClusterMaskBufferCount = 1;
			m_DeferredReflectionProbeBuffer = new ComputeBuffer(1, 128);
		}
		else
		{
			flag = false;
		}
		m_DeferredClusterPlatformSupported = flag;
		bool flag2 = flag && SystemInfo.supports2DArrayTextures && m_DeferredClusterComputeShader.HasKernel("BuildReflectionProbeScreenMasks") && m_DeferredClusterComputeShader.HasKernel("BuildReflectionProbeDepthMasks");
		if (flag2)
		{
			m_DeferredReflectionProbeScreenKernel = m_DeferredClusterComputeShader.FindKernel("BuildReflectionProbeScreenMasks");
			m_DeferredReflectionProbeDepthKernel = m_DeferredClusterComputeShader.FindKernel("BuildReflectionProbeDepthMasks");
		}
		m_DeferredReflectionProbePlatformSupported = flag2;
		m_StencilDeferredPasses = new int[k_StencilDeferredPassNames.Length];
		for (int i = 0; i < m_StencilDeferredPasses.Length; i++)
		{
			m_StencilDeferredPasses[i] = -1;
		}
		InitStencilDeferredMaterial();
		m_RenderPassScheduleMode = renderPassScheduleMode;
		InitializeGBufferFormats();
	}

	private bool SetupBakeryVolume(CommandBuffer cmd)
	{
		bool flag = DeferredSceneLightingRegistry.GetActiveUseBakerySceneSH();
		Vector4 l = Vector4.zero;
		Vector4 l1x = Vector4.zero;
		Vector4 l1y = Vector4.zero;
		Vector4 l1z = Vector4.zero;
		if (flag)
		{
			flag = DeferredSceneLightingRegistry.TryGetActiveSceneBakerySH(out l, out l1x, out l1y, out l1z);
		}
		cmd.SetGlobalInteger(ShaderConstants._ACTSceneSHSource, flag ? 1 : 0);
		if (flag)
		{
			cmd.SetGlobalVector(ShaderConstants._ACTSceneBakerySH0, l);
			cmd.SetGlobalVector(ShaderConstants._ACTSceneBakerySH1, l1x);
			cmd.SetGlobalVector(ShaderConstants._ACTSceneBakerySH2, l1y);
			cmd.SetGlobalVector(ShaderConstants._ACTSceneBakerySH3, l1z);
		}
		cmd.SetGlobalInteger(ShaderConstants._DeferredBakeryVolumeValid, 0);
		bool shadowMaskInRed = DeferredSceneLightingRegistry.GetShadowMaskInRed();
		cmd.SetGlobalInteger(ShaderConstants._DeferredBakeryShadowMaskInRed, shadowMaskInRed ? 1 : 0);
		if (DeferredSceneLightingRegistry.TryGetActiveVolumeGIL1(out var texture, out var texture2, out var texture3, out var bounds))
		{
			BindBakeryVolumeL1(cmd, texture, texture2, texture3, bounds);
			return true;
		}
		return false;
	}

	private static void BindBakeryVolumeL1(CommandBuffer cmd, Texture3D volumeL1Texture0, Texture3D volumeL1Texture1, Texture3D volumeL1Texture2, Bounds volumeBounds)
	{
		cmd.SetGlobalTexture(ShaderConstants._DeferredBakeryVolumeL1Texture0, volumeL1Texture0);
		cmd.SetGlobalTexture(ShaderConstants._DeferredBakeryVolumeL1Texture1, volumeL1Texture1);
		cmd.SetGlobalTexture(ShaderConstants._DeferredBakeryVolumeL1Texture2, volumeL1Texture2);
		SetBakeryVolumeBounds(cmd, volumeBounds);
		cmd.SetGlobalInteger(ShaderConstants._DeferredBakeryVolumeValid, 1);
	}

	private static void SetBakeryVolumeBounds(CommandBuffer cmd, Bounds volumeBounds)
	{
		Vector3 size = volumeBounds.size;
		cmd.SetGlobalVector(ShaderConstants._DeferredBakeryVolumeMin, volumeBounds.min);
		cmd.SetGlobalVector(ShaderConstants._DeferredBakeryVolumeInvSize, new Vector3(1f / size.x, 1f / size.y, 1f / size.z));
	}

	internal void SetupLights(CommandBuffer cmd, ref RenderingData renderingData)
	{
		m_UseBakeryVolumeGIThisCamera = SetupBakeryVolume(cmd);
		CoreUtils.SetKeyword(cmd, "_DEFERRED_BAKERY_VOLUME_GI", m_UseBakeryVolumeGIThisCamera);
		cmd.SetGlobalFloat(ShaderConstants._DeferredFullscreenMediaCompositeEnabled, renderingData.cameraData.isBase ? 1f : 0f);
		if (!m_Initialized)
		{
			CoreUtils.SetKeyword(cmd, "_SHADOWS_SOFT", state: true);
			m_Initialized = true;
		}
	}

	internal void SetupDeferredCluster(CommandBuffer cmd, ref RenderingData renderingData)
	{
		CoreUtils.SetKeyword(cmd, "_CLUSTERED_LIGHTING", state: false);
		SetDeferredClusterSceneScatterLightMasks(cmd, null);
		m_DeferredClusterLightCount = 0;
		m_DeferredReflectionProbeUseThisFrame = false;
		m_DeferredReflectionProbeCount = 0;
		m_DeferredReflectionProbeActiveMask = 0u;
		cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeEnabled, 0);
		cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeCount, 0);
		cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeActiveMask, 0);
		cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeMaxSampleMip, 0);
		if (!m_DeferredClusterPlatformSupported || !AreDeferredLightingPassesAvailable())
		{
			if (m_DeferredReflectionProbeBuffer != null)
			{
				cmd.SetGlobalBuffer(ShaderConstants._DeferredReflectionProbeData, m_DeferredReflectionProbeBuffer);
			}
			WarnDeferredClusterUnavailableOnce();
			return;
		}
		int num = Mathf.Max(1, renderingData.cameraData.cameraTargetDescriptor.width);
		int num2 = Mathf.Max(1, renderingData.cameraData.cameraTargetDescriptor.height);
		m_DeferredClusterTileCountX = (num + 32 - 1) / 32;
		m_DeferredClusterTileCountY = (num2 + 32 - 1) / 32;
		int num3 = (m_DeferredClusterDepthOffset = m_DeferredClusterTileCountX * m_DeferredClusterTileCountY);
		m_DeferredReflectionProbeScreenOffset = m_DeferredClusterDepthOffset + 128;
		m_DeferredReflectionProbeDepthOffset = m_DeferredReflectionProbeScreenOffset + num3;
		bool flag = TryGetOfflineReflectionProbeData(out var reflectionProbeData);
		if (flag)
		{
			SyncDeferredReflectionProbeBuffer(reflectionProbeData);
			m_DeferredReflectionProbeUseThisFrame = m_DeferredReflectionProbeBuffer != null;
			m_DeferredReflectionProbeCount = reflectionProbeData.localProbeCount;
			m_DeferredReflectionProbeActiveMask = ((m_DeferredReflectionProbeCount == 32) ? uint.MaxValue : ((uint)((1 << m_DeferredReflectionProbeCount) - 1)));
		}
		else if (reflectionProbeData != null)
		{
			WarnDeferredReflectionProbeUnavailableOnce();
		}
		cmd.SetGlobalBuffer(ShaderConstants._DeferredReflectionProbeData, m_DeferredReflectionProbeBuffer);
		if (m_DeferredReflectionProbeUseThisFrame)
		{
			cmd.SetGlobalTexture(ShaderConstants._DeferredReflectionProbeAtlas, reflectionProbeData.atlas);
			cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeEnabled, 1);
			cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeCount, m_DeferredReflectionProbeCount);
			cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeScreenOffset, m_DeferredReflectionProbeScreenOffset);
			cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeDepthOffset, m_DeferredReflectionProbeDepthOffset);
			cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeMaxSampleMip, reflectionProbeData.maxSampleMip);
		}
		CoreUtils.SetKeyword(cmd, "_DEFERRED_REFLECTION_PROBE_RUNTIME_ATLAS", SetGlobalParamPass.RuntimeReflectionProbeSupported && !flag);
		int mainLightIndex = renderingData.lightData.mainLightIndex;
		int additionalLightsCount = renderingData.lightData.additionalLightsCount;
		PreparedLightFrameData preparedLights = renderingData.lightData.preparedLights;
		Matrix4x4 viewMatrix = renderingData.cameraData.GetViewMatrix();
		bool flag2 = false;
		Array.Clear(m_DeferredClusterSceneScatterLightMasks, 0, m_DeferredClusterSceneScatterLightMasks.Length);
		if (additionalLightsCount > 0 && preparedLights != null)
		{
			int[] punctualVisibleLightIndices = preparedLights.punctualVisibleLightIndices;
			for (int i = 0; i < preparedLights.punctualLightCount; i++)
			{
				int num4 = punctualVisibleLightIndices[i];
				if (num4 == mainLightIndex)
				{
					continue;
				}
				int num5 = num4;
				if (mainLightIndex >= 0 && num4 > mainLightIndex)
				{
					num5--;
				}
				if (m_DeferredClusterLightCount < 32 && num5 < additionalLightsCount)
				{
					ref PreparedVisibleLight reference = ref preparedLights.visibleLights[num4];
					Vector3 vector = viewMatrix.MultiplyPoint3x4(new Vector3(reference.position.x, reference.position.y, reference.position.z));
					bool flag3 = reference.lightType == LightType.Spot;
					Vector3 vector2 = Vector3.zero;
					float w = 0f;
					if (flag3)
					{
						Vector3 vector3 = new Vector3(0f - reference.spotDirection.x, 0f - reference.spotDirection.y, 0f - reference.spotDirection.z);
						vector2 = viewMatrix.MultiplyVector(vector3).normalized;
						w = Mathf.Tan(Mathf.Min(89.5f, 0.5f * reference.spotAngle) * (MathF.PI / 180f));
					}
					DeferredClusterLightVolume deferredClusterLightVolume = new DeferredClusterLightVolume
					{
						positionRange = new Vector4(vector.x, vector.y, vector.z, reference.range),
						directionTanHalfAngle = new Vector4(vector2.x, vector2.y, vector2.z, w),
						typeData = new Vector4(flag3 ? 1f : 0f, 0f, 0f, 0f)
					};
					m_DeferredClusterLightVolumes[m_DeferredClusterLightCount] = deferredClusterLightVolume;
					m_DeferredClusterLightIndices[m_DeferredClusterLightCount] = (uint)num5;
					if ((reference.layerMask & 0x40) != 0)
					{
						int num6 = m_DeferredClusterLightCount / 32;
						int num7 = m_DeferredClusterLightCount % 32;
						m_DeferredClusterSceneScatterLightMasks[num6] |= (uint)(1 << num7);
					}
					m_DeferredClusterLightCount++;
				}
				else
				{
					flag2 = true;
				}
			}
		}
		if (flag2)
		{
			WarnDeferredClusterOverflowOnce();
		}
		SetDeferredClusterSceneScatterLightMasks(cmd, m_DeferredClusterSceneScatterLightMasks);
		if (m_DeferredClusterLightCount == 0 && !m_DeferredReflectionProbeUseThisFrame)
		{
			SetupEmptyDeferredCluster(cmd);
			return;
		}
		int requiredCount = (m_DeferredReflectionProbeUseThisFrame ? (m_DeferredReflectionProbeDepthOffset + 128) : m_DeferredReflectionProbeScreenOffset);
		EnsureDeferredClusterMaskBuffer(requiredCount);
		Matrix4x4 gPUProjectionMatrix = GL.GetGPUProjectionMatrix(renderingData.cameraData.GetProjectionMatrix(), renderIntoTexture: false);
		Matrix4x4 inverse = gPUProjectionMatrix.inverse;
		Matrix4x4 inverse2 = (gPUProjectionMatrix * viewMatrix).inverse;
		float nearClipPlane = renderingData.cameraData.camera.nearClipPlane;
		cmd.SetComputeMatrixParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterInvProjection, inverse);
		cmd.SetComputeVectorParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterScreenSize, new Vector4(num, num2, 1f / (float)num, 1f / (float)num2));
		cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterOrthographic, renderingData.cameraData.camera.orthographic ? 1 : 0);
		cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterTileCountX, m_DeferredClusterTileCountX);
		cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterTileCountY, m_DeferredClusterTileCountY);
		cmd.SetComputeFloatParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterNearClip, nearClipPlane);
		cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterLightMaskWordCount, 1);
		if (m_DeferredClusterLightCount > 0)
		{
			using (new ProfilingScope(cmd, m_ProfilingClusterLights))
			{
				m_DeferredClusterLightVolumeBuffer.SetData(m_DeferredClusterLightVolumes, 0, 0, m_DeferredClusterLightCount);
				m_DeferredClusterLightIndexBuffer.SetData(m_DeferredClusterLightIndices, 0, 0, m_DeferredClusterLightCount);
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredClusterScreenKernel, ShaderConstants._DeferredClusterLightVolumes, m_DeferredClusterLightVolumeBuffer);
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredClusterScreenKernel, ShaderConstants._DeferredClusterMasks, m_DeferredClusterMaskBuffer);
				cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterLightCount, m_DeferredClusterLightCount);
				cmd.DispatchCompute(m_DeferredClusterComputeShader, m_DeferredClusterScreenKernel, (m_DeferredClusterTileCountX + 7) / 8, (m_DeferredClusterTileCountY + 7) / 8, 1);
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredClusterDepthKernel, ShaderConstants._DeferredClusterLightVolumes, m_DeferredClusterLightVolumeBuffer);
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredClusterDepthKernel, ShaderConstants._DeferredClusterMasks, m_DeferredClusterMaskBuffer);
				cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterDepthOffset, m_DeferredClusterDepthOffset);
				cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterLightCount, m_DeferredClusterLightCount);
				cmd.DispatchCompute(m_DeferredClusterComputeShader, m_DeferredClusterDepthKernel, 2, 1, 1);
			}
		}
		if (m_DeferredReflectionProbeUseThisFrame && m_DeferredReflectionProbeCount > 0)
		{
			using (new ProfilingScope(cmd, m_ProfilingClusterReflectionProbes))
			{
				Camera camera = renderingData.cameraData.camera;
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredReflectionProbeScreenKernel, ShaderConstants._DeferredReflectionProbeData, m_DeferredReflectionProbeBuffer);
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredReflectionProbeScreenKernel, ShaderConstants._DeferredClusterMasks, m_DeferredClusterMaskBuffer);
				cmd.SetComputeMatrixParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterInvViewProjection, inverse2);
				cmd.SetComputeVectorParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterCameraPositionWS, camera.transform.position);
				cmd.SetComputeVectorParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredClusterCameraForwardWS, camera.transform.forward);
				cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredReflectionProbeCount, m_DeferredReflectionProbeCount);
				cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredReflectionProbeScreenOffset, m_DeferredReflectionProbeScreenOffset);
				cmd.DispatchCompute(m_DeferredClusterComputeShader, m_DeferredReflectionProbeScreenKernel, (m_DeferredClusterTileCountX + 7) / 8, (m_DeferredClusterTileCountY + 7) / 8, 1);
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredReflectionProbeDepthKernel, ShaderConstants._DeferredReflectionProbeData, m_DeferredReflectionProbeBuffer);
				cmd.SetComputeBufferParam(m_DeferredClusterComputeShader, m_DeferredReflectionProbeDepthKernel, ShaderConstants._DeferredClusterMasks, m_DeferredClusterMaskBuffer);
				cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredReflectionProbeCount, m_DeferredReflectionProbeCount);
				cmd.SetComputeIntParam(m_DeferredClusterComputeShader, ShaderConstants._DeferredReflectionProbeDepthOffset, m_DeferredReflectionProbeDepthOffset);
				cmd.DispatchCompute(m_DeferredClusterComputeShader, m_DeferredReflectionProbeDepthKernel, 2, 1, 1);
				cmd.SetGlobalInteger(ShaderConstants._DeferredReflectionProbeActiveMask, (int)m_DeferredReflectionProbeActiveMask);
			}
		}
		cmd.SetGlobalBuffer(ShaderConstants._DeferredClusterMasks, m_DeferredClusterMaskBuffer);
		cmd.SetGlobalBuffer(ShaderConstants._DeferredClusterLightIndices, m_DeferredClusterLightIndexBuffer);
		cmd.SetGlobalInteger(ShaderConstants._DeferredClusterTileCountX, m_DeferredClusterTileCountX);
		cmd.SetGlobalInteger(ShaderConstants._DeferredClusterTileCountY, m_DeferredClusterTileCountY);
		cmd.SetGlobalInteger(ShaderConstants._DeferredClusterDepthOffset, m_DeferredClusterDepthOffset);
		cmd.SetGlobalInteger(ShaderConstants._DeferredClusterLightCount, m_DeferredClusterLightCount);
		cmd.SetGlobalInteger(ShaderConstants._DeferredClusterLightMaskWordCount, 1);
		cmd.SetGlobalFloat(ShaderConstants._DeferredClusterNearClip, nearClipPlane);
		CoreUtils.SetKeyword(cmd, "_CLUSTERED_LIGHTING", state: true);
	}

	private void SetupEmptyDeferredCluster(CommandBuffer cmd)
	{
		cmd.SetGlobalBuffer(ShaderConstants._DeferredClusterMasks, m_DeferredClusterMaskBuffer);
		cmd.SetGlobalBuffer(ShaderConstants._DeferredClusterLightIndices, m_DeferredClusterLightIndexBuffer);
		cmd.SetGlobalInteger(ShaderConstants._DeferredClusterLightCount, 0);
		CoreUtils.SetKeyword(cmd, "_CLUSTERED_LIGHTING", state: true);
	}

	private static void SetDeferredClusterSceneScatterLightMasks(CommandBuffer cmd, uint[] masks)
	{
		for (int i = 0; i < ShaderConstants._DeferredClusterSceneScatterLightMasks.Length; i++)
		{
			uint value = ((masks != null && i < masks.Length) ? masks[i] : 0u);
			cmd.SetGlobalInteger(ShaderConstants._DeferredClusterSceneScatterLightMasks[i], (int)value);
		}
	}

	private void SyncDeferredReflectionProbeBuffer(DeferredReflectionProbeSceneData sceneData)
	{
		if (m_DeferredReflectionProbeSceneData != sceneData || m_DeferredReflectionProbeContentHash != sceneData.contentHash || m_DeferredReflectionProbeBuffer == null)
		{
			m_DeferredReflectionProbeBuffer?.Release();
			m_DeferredReflectionProbeBuffer = null;
			m_DeferredReflectionProbeSceneData = sceneData;
			m_DeferredReflectionProbeContentHash = sceneData.contentHash;
			if (sceneData.localProbeCount <= 0)
			{
				m_DeferredReflectionProbeBuffer = new ComputeBuffer(1, 128);
				return;
			}
			m_DeferredReflectionProbeBuffer = new ComputeBuffer(sceneData.localProbeCount, 128, ComputeBufferType.Structured);
			m_DeferredReflectionProbeBuffer.SetData(sceneData.probes);
		}
	}

	private void EnsureDeferredClusterMaskBuffer(int requiredCount)
	{
		if (m_DeferredClusterMaskBuffer == null || m_DeferredClusterMaskBufferCount < requiredCount)
		{
			m_DeferredClusterMaskBuffer?.Release();
			m_DeferredClusterMaskBuffer = new ComputeBuffer(requiredCount, 4);
			m_DeferredClusterMaskBufferCount = requiredCount;
		}
	}

	private void WarnDeferredClusterUnavailableOnce()
	{
	}

	private void WarnDeferredClusterOverflowOnce()
	{
	}

	private void WarnDeferredReflectionProbeUnavailableOnce()
	{
	}

	internal void Dispose()
	{
		m_DeferredClusterMaskBuffer?.Release();
		m_DeferredClusterMaskBuffer = null;
		m_DeferredClusterMaskBufferCount = 0;
		m_DeferredClusterLightVolumeBuffer?.Release();
		m_DeferredClusterLightVolumeBuffer = null;
		m_DeferredClusterLightIndexBuffer?.Release();
		m_DeferredClusterLightIndexBuffer = null;
		m_DeferredReflectionProbeBuffer?.Release();
		m_DeferredReflectionProbeBuffer = null;
		m_DeferredReflectionProbeSceneData = null;
		m_DeferredReflectionProbeContentHash = null;
	}

	internal void CreateGbufferAttachments()
	{
		int num = 4;
		if (GbufferAttachments == null || GbufferAttachments.Length != num)
		{
			GbufferAttachments = new RenderTargetHandle[num];
			for (int i = 0; i < num; i++)
			{
				GbufferAttachments[i].Init(k_GBufferNames[i]);
			}
		}
	}

	internal bool IsRuntimeSupportedThisFrame()
	{
		if (4 <= SystemInfo.supportedRenderTargetCount && !DeferredConfig.IsOpenGL)
		{
			return !DeferredConfig.IsDX10;
		}
		return false;
	}

	public void Setup(AdditionalLightsShadowCasterPass additionalLightsShadowCasterPass, bool hasDepthPrepass, bool hasNormalPrepass, RenderTargetHandle depthAttachment, RTHandle colorAttachment, RTHandle motionFeatureAttachment)
	{
		m_AdditionalLightsShadowCasterPass = additionalLightsShadowCasterPass;
		HasDepthPrepass = hasDepthPrepass;
		HasNormalPrepass = hasNormalPrepass;
		GbufferAttachments[3].Init(colorAttachment.nameID);
		GbufferAttachments[2].Init(motionFeatureAttachment.nameID);
		DepthAttachment = depthAttachment;
		if (GbufferAttachmentIdentifiers == null || GbufferAttachmentIdentifiers.Length != GbufferAttachments.Length)
		{
			GbufferAttachmentIdentifiers = new RenderTargetIdentifier[GbufferAttachments.Length];
		}
		if (GbufferOutputAttachmentIdentifiers == null || GbufferOutputAttachmentIdentifiers.Length != GbufferAttachments.Length)
		{
			GbufferOutputAttachmentIdentifiers = new RenderTargetIdentifier[GbufferAttachments.Length];
		}
		for (int i = 0; i < GbufferAttachments.Length; i++)
		{
			GbufferAttachmentIdentifiers[i] = GbufferAttachments[i].Identifier();
		}
		GbufferOutputAttachmentIdentifiers[0] = GbufferAttachmentIdentifiers[3];
		GbufferOutputAttachmentIdentifiers[1] = GbufferAttachmentIdentifiers[2];
		GbufferOutputAttachmentIdentifiers[2] = GbufferAttachmentIdentifiers[0];
		GbufferOutputAttachmentIdentifiers[3] = GbufferAttachmentIdentifiers[1];
		DepthAttachmentIdentifier = depthAttachment.Identifier();
	}

	internal void ExecuteDeferredPass(NativeRenderPassType nativeRenderPassType, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (m_StencilDeferredMaterial == null)
		{
			return;
		}
		int num = m_StencilDeferredPasses.Length - 1;
		if (m_StencilDeferredPasses[0] < 0 || m_StencilDeferredPasses[num] < 0 || m_StencilDeferredPasses[num] >= m_StencilDeferredMaterial.passCount)
		{
			InitStencilDeferredMaterial();
		}
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, m_ProfilingDeferredPass))
		{
			SetupMatrixConstants(cmd, ref renderingData);
			ConfigureDirectLightRT(nativeRenderPassType, ref context, ref renderingData);
			if (!m_UseBakeryVolumeGIThisCamera)
			{
				DrawFullscreen(cmd, StencilDeferredPasses.LightmapGIResolve);
			}
			if (m_DeferredClusterLightCount > 0)
			{
				RenderDeferredPunctualLights(cmd, ref renderingData);
			}
			RenderDeferredMainLight(cmd);
			if (nativeRenderPassType == NativeRenderPassType.GBuffer)
			{
				cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			}
		}
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
	}

	private void RenderDeferredPunctualLights(CommandBuffer cmd, ref RenderingData renderingData)
	{
		DrawFullscreen(cmd, StencilDeferredPasses.PunctualScene);
		DrawFullscreen(cmd, StencilDeferredPasses.PunctualPlant);
	}

	internal void BeginEnvironmentSubPass(NativeRenderPassType nativeRenderPassType, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		ConfigureDeferredLightingTarget(nativeRenderPassType, ref context, ref renderingData);
	}

	internal void ExecuteDeferredEnvironmentPass(NativeRenderPassType nativeRenderPassType, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (nativeRenderPassType == NativeRenderPassType.None)
		{
			renderingData.cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			ConfigureDeferredLightingTarget(nativeRenderPassType, ref context, ref renderingData);
		}
		bool characterRimEnabled = renderingData.nativeDeferredMode != NativeDeferredMode.FullTile;
		RenderDeferredEnvironment(renderingData.cmd, characterRimEnabled);
		renderingData.cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
	}

	private void SetupMatrixConstants(CommandBuffer cmd, ref RenderingData renderingData)
	{
		ref CameraData cameraData = ref renderingData.cameraData;
		Matrix4x4 viewMatrix = cameraData.GetViewMatrix();
		Matrix4x4 gPUProjectionMatrix = GL.GetGPUProjectionMatrix(cameraData.GetProjectionMatrix(), renderIntoTexture: false);
		int width = renderingData.cameraData.cameraTargetDescriptor.width;
		int height = renderingData.cameraData.cameraTargetDescriptor.height;
		Matrix4x4 matrix4x = new Matrix4x4(new Vector4(0.5f * (float)width, 0f, 0f, 0f), new Vector4(0f, 0.5f * (float)height, 0f, 0f), new Vector4(0f, 0f, 1f, 0f), new Vector4(0.5f * (float)width, 0.5f * (float)height, 0f, 1f));
		Matrix4x4 matrix4x2 = Matrix4x4.identity;
		if (DeferredConfig.IsOpenGL)
		{
			matrix4x2 = new Matrix4x4(new Vector4(1f, 0f, 0f, 0f), new Vector4(0f, 1f, 0f, 0f), new Vector4(0f, 0f, 0.5f, 0f), new Vector4(0f, 0f, 0.5f, 1f));
		}
		m_ScreenToWorld = Matrix4x4.Inverse(matrix4x * matrix4x2 * gPUProjectionMatrix * viewMatrix);
		cmd.SetGlobalMatrix(ShaderConstants._ScreenToWorld, m_ScreenToWorld);
	}

	private void RenderDeferredMainLight(CommandBuffer cmd)
	{
		DrawFullscreen(cmd, StencilDeferredPasses.MainScene);
		DrawFullscreen(cmd, StencilDeferredPasses.MainPlant);
	}

	private void RenderDeferredEnvironment(CommandBuffer cmd, bool characterRimEnabled)
	{
		using (new ProfilingScope(cmd, m_ProfilingSamplerEnvironmentPass))
		{
			DrawFullscreen(cmd, StencilDeferredPasses.EnvironmentScene);
			DrawFullscreen(cmd, StencilDeferredPasses.EnvironmentPlant);
			cmd.SetGlobalFloat(ShaderConstants._DeferredCharacterRimEnabled, characterRimEnabled ? 1f : 0f);
			DrawFullscreen(cmd, StencilDeferredPasses.CharacterEnvironment);
			DrawFullscreen(cmd, StencilDeferredPasses.MediaComposite);
		}
	}

	private void DrawFullscreen(CommandBuffer cmd, StencilDeferredPasses pass)
	{
		int num = m_StencilDeferredPasses[(int)pass];
		if (!(m_StencilDeferredMaterial == null) && num >= 0)
		{
			RenderingUtils.DrawProcedural(cmd, m_StencilDeferredMaterial, num, Vector2.one);
		}
	}

	internal bool UsesMaterialClassDeferredLayout()
	{
		if (m_DeferredClusterPlatformSupported)
		{
			return AreDeferredLightingPassesAvailable();
		}
		return false;
	}

	private bool AreDeferredLightingPassesAvailable()
	{
		if (m_StencilDeferredPasses[0] >= 0 && m_StencilDeferredPasses[1] >= 0 && m_StencilDeferredPasses[2] >= 0 && m_StencilDeferredPasses[3] >= 0 && m_StencilDeferredPasses[4] >= 0 && m_StencilDeferredPasses[5] >= 0 && m_StencilDeferredPasses[6] >= 0 && m_StencilDeferredPasses[7] >= 0)
		{
			return m_StencilDeferredPasses[8] >= 0;
		}
		return false;
	}

	private void ConfigureDirectLightRT(NativeRenderPassType nativeRenderPassType, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		if (nativeRenderPassType == NativeRenderPassType.None)
		{
			cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			UniversalRenderer renderer = renderingData.cameraData.renderer;
			cmd.SetRenderTarget(renderer.cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
			ScriptableRenderer.SetActiveRenderTarget(renderer.cameraColorTarget, renderer.cameraDepthTarget);
			return;
		}
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		if (nativeRenderPassType == NativeRenderPassType.GBuffer)
		{
			cmd.EnableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			nativeRenderPassManager.ConfigureInput(3, 4, 2, nativeRenderPassManager.GBufferDepthInputAttachment);
			nativeRenderPassManager.ConfigureTarget(1);
		}
		else
		{
			cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			nativeRenderPassManager.ConfigureTarget(0);
		}
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	private void ConfigureDeferredLightingTarget(NativeRenderPassType nativeRenderPassType, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		if (nativeRenderPassType != NativeRenderPassType.None)
		{
			NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
			if (nativeRenderPassType == NativeRenderPassType.GBuffer && renderingData.nativeDeferredMode == NativeDeferredMode.FullTile)
			{
				cmd.EnableKeyword(in ShaderKeywords.FetchGBufferKeyword);
				nativeRenderPassManager.ConfigureInput(3, 4, 2, nativeRenderPassManager.GBufferDepthInputAttachment);
			}
			else
			{
				cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			}
			nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment);
			nativeRenderPassManager.BeginSubPass(ref context);
		}
		else
		{
			RenderTargetIdentifier cameraColorTarget = renderer.cameraColorTarget;
			RenderTargetIdentifier cameraDepthTarget = renderer.cameraDepthTarget;
			cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			cmd.SetRenderTarget(cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
			ScriptableRenderer.SetActiveRenderTarget(cameraColorTarget, cameraDepthTarget);
		}
	}

	private void InitStencilDeferredMaterial()
	{
		if (!(m_StencilDeferredMaterial == null))
		{
			for (int i = 0; i < k_StencilDeferredPassNames.Length; i++)
			{
				m_StencilDeferredPasses[i] = m_StencilDeferredMaterial.FindPass(k_StencilDeferredPassNames[i]);
			}
			m_StencilDeferredMaterial.SetFloat(ShaderConstants._DeferredSceneStencilRef, 96f);
			m_StencilDeferredMaterial.SetFloat(ShaderConstants._DeferredPlantStencilRef, 64f);
			m_StencilDeferredMaterial.SetFloat(ShaderConstants._DeferredMaterialStencilReadMask, 96f);
			m_StencilDeferredMaterial.SetFloat(ShaderConstants._DeferredCharacterStencilRef, 32f);
			m_StencilDeferredMaterial.SetFloat(ShaderConstants._DeferredCharacterStencilReadMask, 100f);
		}
	}
}
