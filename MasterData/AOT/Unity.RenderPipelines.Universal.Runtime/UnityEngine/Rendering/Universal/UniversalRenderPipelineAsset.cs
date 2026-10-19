using System;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering.Universal;

[ExcludeFromPreset]
public class UniversalRenderPipelineAsset : RenderPipelineAsset, ISerializationCallbackReceiver
{
	private const string k_DefaultShaderName = "ACT/toon generic";

	private Shader m_DefaultShader;

	private ScriptableRenderer[] m_Renderers = new ScriptableRenderer[2];

	[SerializeField]
	private int k_AssetVersion = 9;

	[SerializeField]
	private int k_AssetPreviousVersion = 9;

	private const int k_DefaultHeightPixels = 8640;

	[SerializeField]
	internal ScriptableRendererData[] m_RendererDataList = new ScriptableRendererData[1];

	[SerializeField]
	internal int m_DefaultRendererIndex;

	[SerializeField]
	private RenderPassScheduleMode m_RenderPassScheduleMode;

	[SerializeField]
	private bool m_NativeRenderPass;

	[SerializeField]
	[FormerlySerializedAs("m_SampleDepth")]
	private bool m_SplitNativeDeferredForDepth;

	[SerializeField]
	private bool m_NativeDeferredUseDepthStencilInput;

	[SerializeField]
	private Material m_ProximaTestMaterial;

	[SerializeField]
	private StoreActionsOptimization m_StoreActionsOptimization;

	[SerializeField]
	private bool m_SupportsHDR = true;

	[SerializeField]
	private float m_RenderScale = 1f;

	[SerializeField]
	[Range(0f, 2f)]
	private float m_TemporalJitterScale = 1f;

	[SerializeField]
	[Range(0f, 1f)]
	private float m_UberPostSharpening = 0.5f;

	public const float minMobilePerformanceRenderScaleMultiplier = 0.7f;

	public const float maxMobilePerformanceRenderScaleMultiplier = 1f;

	[NonSerialized]
	private float m_MobilePerformanceRenderScaleMultiplier = 1f;

	[SerializeField]
	private int m_HeightPixels = 8640;

	[SerializeField]
	private LightRenderingMode m_MainLightRenderingMode = LightRenderingMode.PerPixel;

	[SerializeField]
	private bool m_MainLightShadowsSupported = true;

	[SerializeField]
	private ShadowResolution m_MainLightShadowmapResolution = ShadowResolution._2048;

	[SerializeField]
	private LightRenderingMode m_AdditionalLightsRenderingMode = LightRenderingMode.PerPixel;

	[SerializeField]
	private int m_AdditionalLightsPerObjectLimit = 4;

	[SerializeField]
	private bool m_AdditionalLightShadowsSupported;

	[SerializeField]
	private ShadowResolution m_AdditionalLightsShadowmapResolution = ShadowResolution._2048;

	[SerializeField]
	private int m_AdditionalLightsShadowSliceResolution = 256;

	[SerializeField]
	private bool m_AdditionalShadowTimeSlicingEnabled;

	[SerializeField]
	private int m_MaxAdditionalShadowTilesPerFrame = 2;

	[SerializeField]
	private float m_ShadowDistance = 50f;

	[Range(0.01f, 0.2f)]
	[SerializeField]
	private float m_CharacterMainLightShadowNormalBias = 0.01f;

	[SerializeField]
	private int m_ShadowCascadeCount = 1;

	[SerializeField]
	private float m_Cascade2Split = 0.25f;

	[SerializeField]
	private Vector2 m_Cascade3Split = new Vector2(0.1f, 0.3f);

	[SerializeField]
	private Vector3 m_Cascade4Split = new Vector3(0.067f, 0.2f, 0.467f);

	[SerializeField]
	private float m_CascadeBorder = 0.2f;

	[SerializeField]
	private Vector4 m_MainLightCascadeDepthBias = new Vector4(3f, 7.5f, 10f, 10f);

	[SerializeField]
	private Vector4 m_MainLightCascadeSlopeBias = new Vector4(3f, 7.5f, 10f, 10f);

	[SerializeField]
	private float m_ShadowDepthBias = 0.1f;

	[SerializeField]
	private float m_ShadowNormalBias = 1f;

	[FormerlySerializedAs("m_ShadowSlopeBias")]
	[SerializeField]
	private float m_AdditionalLightShadowSlopeBias = 1f;

	[SerializeField]
	private LightCookieResolution m_AdditionalLightsCookieResolution = LightCookieResolution._2048;

	[SerializeField]
	private LightCookieFormat m_AdditionalLightsCookieFormat = LightCookieFormat.ColorHigh;

	[SerializeField]
	private bool m_UseSRPBatcher = true;

	[SerializeField]
	private bool m_SupportsDynamicBatching;

	[SerializeField]
	private bool m_SupportsLightLayers;

	[SerializeField]
	private bool m_UseAdaptivePerformance = true;

	[SerializeField]
	private int m_ColorGradingLutSize = 32;

	public const int k_MinLutSize = 16;

	public const int k_MaxLutSize = 65;

	internal const int k_ShadowCascadeMinCount = 1;

	internal const int k_ShadowCascadeMaxCount = 4;

	public override string renderPipelineShaderTag => "UniversalPipeline";

	public ScriptableRenderer scriptableRenderer => m_Renderers[m_DefaultRendererIndex];

	public ScriptableRendererData scriptableRendererData
	{
		get
		{
			if (m_RendererDataList[m_DefaultRendererIndex] == null)
			{
				CreatePipeline();
			}
			return m_RendererDataList[m_DefaultRendererIndex];
		}
	}

	internal int[] rendererIndexList
	{
		get
		{
			int[] array = new int[m_RendererDataList.Length + 1];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = i - 1;
			}
			return array;
		}
	}

	public bool nativeRP
	{
		get
		{
			return m_NativeRenderPass;
		}
		set
		{
			m_NativeRenderPass = value;
		}
	}

	public RenderPassScheduleMode renderPassScheduleMode
	{
		get
		{
			return m_RenderPassScheduleMode;
		}
		set
		{
			m_RenderPassScheduleMode = value;
		}
	}

	internal RenderPassScheduleMode actualRenderPassScheduleMode => RenderPassScheduleMode.Mobile;

	public bool splitNativeDeferredForDepth
	{
		get
		{
			return m_SplitNativeDeferredForDepth;
		}
		set
		{
			m_SplitNativeDeferredForDepth = value;
		}
	}

	public bool nativeDeferredUseDepthStencilInput
	{
		get
		{
			return true;
		}
		set
		{
		}
	}

	[Obsolete("Use splitNativeDeferredForDepth instead.")]
	public bool sampleDepth
	{
		get
		{
			return splitNativeDeferredForDepth;
		}
		set
		{
			splitNativeDeferredForDepth = value;
		}
	}

	public Material proximaTestMaterial
	{
		get
		{
			return m_ProximaTestMaterial;
		}
		set
		{
			m_ProximaTestMaterial = value;
		}
	}

	public StoreActionsOptimization storeActionsOptimization
	{
		get
		{
			return m_StoreActionsOptimization;
		}
		set
		{
			m_StoreActionsOptimization = value;
		}
	}

	public bool supportsHDR
	{
		get
		{
			return m_SupportsHDR;
		}
		set
		{
			m_SupportsHDR = value;
		}
	}

	public float renderScale
	{
		get
		{
			return m_RenderScale;
		}
		set
		{
			m_RenderScale = ValidateRenderScale(value);
		}
	}

	public float temporalJitterScale
	{
		get
		{
			return m_TemporalJitterScale;
		}
		set
		{
			m_TemporalJitterScale = Mathf.Clamp(value, 0f, 2f);
		}
	}

	public float uberPostSharpening
	{
		get
		{
			return m_UberPostSharpening;
		}
		set
		{
			m_UberPostSharpening = Mathf.Clamp01(value);
		}
	}

	public float mobilePerformanceRenderScaleMultiplier
	{
		get
		{
			return m_MobilePerformanceRenderScaleMultiplier;
		}
		set
		{
			m_MobilePerformanceRenderScaleMultiplier = ValidateMobilePerformanceRenderScaleMultiplier(value);
		}
	}

	public int heightPixels
	{
		get
		{
			return m_HeightPixels;
		}
		set
		{
			m_HeightPixels = Mathf.Max(1, value);
		}
	}

	public LightRenderingMode mainLightRenderingMode
	{
		get
		{
			return m_MainLightRenderingMode;
		}
		internal set
		{
			m_MainLightRenderingMode = value;
		}
	}

	public bool supportsMainLightShadows
	{
		get
		{
			return m_MainLightShadowsSupported;
		}
		set
		{
			m_MainLightShadowsSupported = value;
		}
	}

	public int mainLightShadowmapResolution
	{
		get
		{
			return (int)m_MainLightShadowmapResolution;
		}
		set
		{
			m_MainLightShadowmapResolution = (ShadowResolution)value;
		}
	}

	public LightRenderingMode additionalLightsRenderingMode
	{
		get
		{
			return m_AdditionalLightsRenderingMode;
		}
		internal set
		{
			m_AdditionalLightsRenderingMode = value;
		}
	}

	public int maxAdditionalLightsCount
	{
		get
		{
			return m_AdditionalLightsPerObjectLimit;
		}
		set
		{
			m_AdditionalLightsPerObjectLimit = ValidatePerObjectLights(value);
		}
	}

	public bool supportsAdditionalLightShadows
	{
		get
		{
			return m_AdditionalLightShadowsSupported;
		}
		set
		{
			m_AdditionalLightShadowsSupported = value;
		}
	}

	public int additionalLightsShadowmapResolution
	{
		get
		{
			return (int)m_AdditionalLightsShadowmapResolution;
		}
		set
		{
			m_AdditionalLightsShadowmapResolution = (ShadowResolution)value;
		}
	}

	public int additionalLightsShadowSliceResolution
	{
		get
		{
			return m_AdditionalLightsShadowSliceResolution;
		}
		set
		{
			m_AdditionalLightsShadowSliceResolution = Mathf.Max(128, Mathf.NextPowerOfTwo(value));
		}
	}

	public bool additionalShadowTimeSlicingEnabled
	{
		get
		{
			return m_AdditionalShadowTimeSlicingEnabled;
		}
		set
		{
			m_AdditionalShadowTimeSlicingEnabled = value;
		}
	}

	public int maxAdditionalShadowTilesPerFrame
	{
		get
		{
			return m_MaxAdditionalShadowTilesPerFrame;
		}
		set
		{
			m_MaxAdditionalShadowTilesPerFrame = Mathf.Max(0, value);
		}
	}

	public float shadowDistance
	{
		get
		{
			return m_ShadowDistance;
		}
		set
		{
			m_ShadowDistance = Mathf.Max(0f, value);
		}
	}

	public float characterMainLightShadowNormalBias
	{
		get
		{
			return m_CharacterMainLightShadowNormalBias;
		}
		set
		{
			m_CharacterMainLightShadowNormalBias = Mathf.Clamp(value, 0.005f, 0.2f);
		}
	}

	public int shadowCascadeCount
	{
		get
		{
			return m_ShadowCascadeCount;
		}
		set
		{
			if (value < 1 || value > 4)
			{
				throw new ArgumentException($"Value ({value}) needs to be between {1} and {4}.");
			}
			m_ShadowCascadeCount = value;
		}
	}

	public float cascade2Split
	{
		get
		{
			return m_Cascade2Split;
		}
		internal set
		{
			m_Cascade2Split = value;
		}
	}

	public Vector2 cascade3Split
	{
		get
		{
			return m_Cascade3Split;
		}
		internal set
		{
			m_Cascade3Split = value;
		}
	}

	public Vector3 cascade4Split
	{
		get
		{
			return m_Cascade4Split;
		}
		internal set
		{
			m_Cascade4Split = value;
		}
	}

	public float cascadeBorder
	{
		get
		{
			return m_CascadeBorder;
		}
		set
		{
			m_CascadeBorder = value;
		}
	}

	public Vector4 mainLightCascadeDepthBias
	{
		get
		{
			return m_MainLightCascadeDepthBias;
		}
		set
		{
			m_MainLightCascadeDepthBias = ValidateShadowBias(value);
		}
	}

	public Vector4 mainLightCascadeSlopeBias
	{
		get
		{
			return m_MainLightCascadeSlopeBias;
		}
		set
		{
			m_MainLightCascadeSlopeBias = ValidateShadowBias(value);
		}
	}

	public float shadowDepthBias
	{
		get
		{
			return m_ShadowDepthBias;
		}
		set
		{
			m_ShadowDepthBias = ValidateShadowBias(value);
		}
	}

	public float shadowNormalBias
	{
		get
		{
			return m_ShadowNormalBias;
		}
		set
		{
			m_ShadowNormalBias = ValidateShadowBias(value);
		}
	}

	public float additionalLightShadowSlopeBias
	{
		get
		{
			return m_AdditionalLightShadowSlopeBias;
		}
		set
		{
			m_AdditionalLightShadowSlopeBias = ValidateShadowBias(value);
		}
	}

	[Obsolete("Realtime shadows are always filtered in this pipeline.")]
	public bool supportsSoftShadows
	{
		get
		{
			return true;
		}
		set
		{
		}
	}

	public bool supportsDynamicBatching
	{
		get
		{
			return m_SupportsDynamicBatching;
		}
		set
		{
			m_SupportsDynamicBatching = value;
		}
	}

	public bool supportsLightLayers => m_SupportsLightLayers;

	public bool useSRPBatcher
	{
		get
		{
			return m_UseSRPBatcher;
		}
		set
		{
			m_UseSRPBatcher = value;
		}
	}

	public int colorGradingLutSize
	{
		get
		{
			return m_ColorGradingLutSize;
		}
		set
		{
			m_ColorGradingLutSize = Mathf.Clamp(value, 16, 65);
		}
	}

	public bool useAdaptivePerformance
	{
		get
		{
			return m_UseAdaptivePerformance;
		}
		set
		{
			m_UseAdaptivePerformance = value;
		}
	}

	public override Material defaultMaterial => GetMaterial(DefaultMaterialType.Standard);

	public override Material defaultParticleMaterial => GetMaterial(DefaultMaterialType.Particle);

	public override Material defaultLineMaterial => GetMaterial(DefaultMaterialType.Particle);

	public override Material defaultTerrainMaterial => GetMaterial(DefaultMaterialType.Terrain);

	public override Material defaultUIMaterial => GetMaterial(DefaultMaterialType.UnityBuiltinDefault);

	public override Material defaultUIOverdrawMaterial => GetMaterial(DefaultMaterialType.UnityBuiltinDefault);

	public override Material defaultUIETC1SupportedMaterial => GetMaterial(DefaultMaterialType.UnityBuiltinDefault);

	public override Material default2DMaterial => GetMaterial(DefaultMaterialType.Sprite);

	public override Material default2DMaskMaterial => GetMaterial(DefaultMaterialType.SpriteMask);

	public Material decalMaterial => GetMaterial(DefaultMaterialType.Decal);

	public override Shader defaultShader
	{
		get
		{
			m_DefaultShader = Shader.Find("ACT/toon generic");
			if (m_DefaultShader != null)
			{
				return m_DefaultShader;
			}
			if (m_DefaultShader == null)
			{
				m_DefaultShader = Shader.Find("ACT/toon generic");
			}
			return m_DefaultShader;
		}
	}

	public ScriptableRendererData LoadBuiltinRendererData(RendererType type = RendererType.UniversalRenderer)
	{
		m_RendererDataList[0] = null;
		return m_RendererDataList[0];
	}

	protected override RenderPipeline CreatePipeline()
	{
		if (m_RendererDataList == null)
		{
			m_RendererDataList = new ScriptableRendererData[1];
		}
		if (m_RendererDataList[m_DefaultRendererIndex] == null)
		{
			if (k_AssetPreviousVersion != k_AssetVersion)
			{
				return null;
			}
			if (m_RendererDataList[m_DefaultRendererIndex].GetType().ToString().Contains("Universal.ForwardRendererData"))
			{
				return null;
			}
			Debug.LogError("Default Renderer is missing, make sure there is a Renderer assigned as the default on the current Universal RP asset:" + UniversalRenderPipeline.asset.name, this);
			return null;
		}
		CreateRenderers();
		ScriptableRendererData[] rendererDataList = m_RendererDataList;
		for (int i = 0; i < rendererDataList.Length; i++)
		{
			if (rendererDataList[i] is UniversalRendererData universalRendererData)
			{
				Blitter.Initialize(universalRendererData.shaders.coreBlitPS, universalRendererData.shaders.coreBlitColorAndDepthPS);
				break;
			}
		}
		return new UniversalRenderPipeline(this);
	}

	internal void DestroyRenderers()
	{
		if (m_Renderers != null)
		{
			for (int i = 0; i < m_Renderers.Length; i++)
			{
				DestroyRenderer(ref m_Renderers[i]);
			}
		}
	}

	private void DestroyRenderer(ref ScriptableRenderer renderer)
	{
		if (renderer != null)
		{
			renderer.Dispose();
			renderer = null;
		}
	}

	protected override void OnValidate()
	{
		DestroyRenderers();
		base.OnValidate();
	}

	protected override void OnDisable()
	{
		DestroyRenderers();
		base.OnDisable();
	}

	private void CreateRenderers()
	{
		DestroyRenderers();
		if (m_Renderers == null || m_Renderers.Length != m_RendererDataList.Length)
		{
			m_Renderers = new ScriptableRenderer[m_RendererDataList.Length];
		}
		for (int i = 0; i < m_RendererDataList.Length; i++)
		{
			if (m_RendererDataList[i] != null)
			{
				m_Renderers[i] = m_RendererDataList[i].InternalCreateRenderer(actualRenderPassScheduleMode);
			}
		}
	}

	private Material GetMaterial(DefaultMaterialType materialType)
	{
		return null;
	}

	public ScriptableRenderer GetRenderer(int index)
	{
		if (index == -1)
		{
			index = m_DefaultRendererIndex;
		}
		return m_Renderers[index];
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
		m_MobilePerformanceRenderScaleMultiplier = 1f;
		if (k_AssetVersion < 3)
		{
			k_AssetPreviousVersion = k_AssetVersion;
			k_AssetVersion = 3;
		}
		if (k_AssetVersion < 7)
		{
			k_AssetPreviousVersion = k_AssetVersion;
			k_AssetVersion = 7;
		}
		if (k_AssetVersion < 8)
		{
			k_AssetPreviousVersion = k_AssetVersion;
			m_CascadeBorder = 0.1f;
			k_AssetVersion = 8;
		}
		if (k_AssetVersion < 9)
		{
			k_AssetPreviousVersion = k_AssetVersion;
			k_AssetVersion = 9;
		}
	}

	private float ValidateShadowBias(float value)
	{
		return Mathf.Max(0f, Mathf.Min(value, UniversalRenderPipeline.maxShadowBias));
	}

	private Vector4 ValidateShadowBias(Vector4 value)
	{
		value.x = ValidateShadowBias(value.x);
		value.y = ValidateShadowBias(value.y);
		value.z = ValidateShadowBias(value.z);
		value.w = ValidateShadowBias(value.w);
		return value;
	}

	private int ValidatePerObjectLights(int value)
	{
		return Math.Max(0, Math.Min(value, UniversalRenderPipeline.maxPerObjectLights));
	}

	private float ValidateRenderScale(float value)
	{
		return Mathf.Max(UniversalRenderPipeline.minRenderScale, Mathf.Min(value, UniversalRenderPipeline.maxRenderScale));
	}

	private static float ValidateMobilePerformanceRenderScaleMultiplier(float value)
	{
		return Mathf.Clamp(value, 0.7f, 1f);
	}

	internal bool ValidateRendererDataList(bool partial = false)
	{
		int num = 0;
		for (int i = 0; i < m_RendererDataList.Length; i++)
		{
			num += ((!ValidateRendererData(i)) ? 1 : 0);
		}
		if (partial)
		{
			return num == 0;
		}
		return num != m_RendererDataList.Length;
	}

	internal bool ValidateRendererData(int index)
	{
		if (index == -1)
		{
			index = m_DefaultRendererIndex;
		}
		if (index >= m_RendererDataList.Length)
		{
			return false;
		}
		return m_RendererDataList[index] != null;
	}
}
