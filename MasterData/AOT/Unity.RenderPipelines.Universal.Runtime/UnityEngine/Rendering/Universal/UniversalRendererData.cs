using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
[ExcludeFromPreset]
[ReloadGroup]
public class UniversalRendererData : ScriptableRendererData, ISerializationCallbackReceiver
{
	[Serializable]
	[ReloadGroup]
	public sealed class ShaderResources
	{
		[Reload("Shaders/Utils/Blit.shader", ReloadAttribute.Package.Root)]
		public Shader blitPS;

		[Reload("Runtime/Overrides/Volume/Effect/Blur/GaussianBlur/Shader/GaussianBlur.shader", ReloadAttribute.Package.Root)]
		[SerializeField]
		public Shader uiBlurPS;

		[SerializeField]
		[Reload("Runtime/Overrides/Volume/Effect/Blur/GaussianBlur/Shader/UIBlur.compute", ReloadAttribute.Package.Root)]
		public ComputeShader uiBlurCS;

		[Reload("Shaders/Utils/CopyDepth.shader", ReloadAttribute.Package.Root)]
		public Shader copyDepthPS;

		[Reload("Shaders/Utils/StencilDeferred.shader", ReloadAttribute.Package.Root)]
		public Shader stencilDeferredPS;

		[SerializeField]
		[Reload("Shaders/Utils/CoreBlit.shader", ReloadAttribute.Package.Root)]
		internal Shader coreBlitPS;

		[Reload("Shaders/Utils/CoreBlitColorAndDepth.shader", ReloadAttribute.Package.Root)]
		[SerializeField]
		internal Shader coreBlitColorAndDepthPS;

		[SerializeField]
		[Reload("Shaders/ACT/ComputeShader/DeferredLightCluster.compute", ReloadAttribute.Package.Root)]
		public ComputeShader DeferredLightClusterCompute;

		[Reload("Shaders/ACT/ComputeShader/Fluid2D.compute", ReloadAttribute.Package.Root)]
		[SerializeField]
		public ComputeShader Fluid2DCompute;

		[SerializeField]
		[Reload("Shaders/ACT/ShaderTexture/PerlinNoise.png", ReloadAttribute.Package.Root)]
		public Texture2D PerlinNoiseTex;

		[SerializeField]
		[Reload("Shaders/ACT/ShaderTexture/PreIntegral_LDR.png", ReloadAttribute.Package.Root)]
		public Texture2D PreIntegralDataTex;

		[SerializeField]
		[Reload("Shaders/ACT/SkySphere/PreIntegralAtmosphere.compute", ReloadAttribute.Package.Root)]
		public ComputeShader AtmosphereCS;

		[Reload("Shaders/ACT/ShaderTexture/Atmosphere.exr", ReloadAttribute.Package.Root)]
		[SerializeField]
		public Texture2D AtmospherePreIntegralTex;

		[SerializeField]
		[Reload("Shaders/ACT/ShaderTexture/multiscatter.exr", ReloadAttribute.Package.Root)]
		public Texture2D AtmosphereMultiScatterTex;

		[Tooltip("Optional precomputed Scene Scatter depth LUT. RGBA stores scattering RGB and transmittance A; X is sqrt(distance/max distance), Y is view/main-light cosine.")]
		public Texture2D AtmosphereSceneScatterDepthTex;

		[Reload("Shaders/ACT/ComputeShader/GTAOPS.shader", ReloadAttribute.Package.Root)]
		[SerializeField]
		public Shader GTAOPS;

		[SerializeField]
		[Reload("Shaders/ACT/ComputeShader/DistortionOffset.shader", ReloadAttribute.Package.Root)]
		public Shader DistortionOffsetShader;

		[SerializeField]
		[Reload("Shaders/ACT/ComputeShader/CullingCS.compute", ReloadAttribute.Package.Root)]
		public ComputeShader CullingCS;

		[Reload("Shaders/ACT/ComputeShader/CurveRendererCS.compute", ReloadAttribute.Package.Root)]
		[SerializeField]
		public ComputeShader CurveRendererCS;
	}

	public PostProcessData postProcessData;

	public ShaderResources shaders;

	private const int k_LatestAssetVersion = 2;

	[SerializeField]
	private int m_AssetVersion;

	[SerializeField]
	private LayerMask m_OpaqueLayerMask = -1;

	[SerializeField]
	private LayerMask m_TransparentLayerMask = -1;

	[SerializeField]
	private LayerMask m_SpecialCharacterLayerMask;

	[SerializeField]
	private bool m_ShadowTransparentReceive = true;

	[SerializeField]
	private bool m_CharacterMainLightShadowReceive;

	[SerializeField]
	private bool m_DisableAdvancedFaceHair;

	[SerializeField]
	private bool m_DrawCharacterOutline = true;

	[SerializeField]
	private bool m_CharacterPureOuterOutline;

	[SerializeField]
	private RenderingMode m_RenderingMode;

	public LayerMask opaqueLayerMask
	{
		get
		{
			return m_OpaqueLayerMask;
		}
		set
		{
			SetDirty();
			m_OpaqueLayerMask = value;
		}
	}

	public bool isUI => (int)m_OpaqueLayerMask == 0;

	public LayerMask transparentLayerMask
	{
		get
		{
			return m_TransparentLayerMask;
		}
		set
		{
			SetDirty();
			m_TransparentLayerMask = value;
		}
	}

	public LayerMask specialCharacterLayerMask
	{
		get
		{
			return m_SpecialCharacterLayerMask;
		}
		set
		{
			SetDirty();
			m_SpecialCharacterLayerMask = value;
		}
	}

	public bool shadowTransparentReceive
	{
		get
		{
			return m_ShadowTransparentReceive;
		}
		set
		{
			SetDirty();
			m_ShadowTransparentReceive = value;
		}
	}

	public bool characterMainLightShadowReceive
	{
		get
		{
			return m_CharacterMainLightShadowReceive;
		}
		set
		{
			SetDirty();
			m_CharacterMainLightShadowReceive = value;
		}
	}

	public bool disableAdvancedFaceHair
	{
		get
		{
			return m_DisableAdvancedFaceHair;
		}
		set
		{
			m_DisableAdvancedFaceHair = value;
		}
	}

	public bool drawCharacterOutline
	{
		get
		{
			return m_DrawCharacterOutline;
		}
		set
		{
			m_DrawCharacterOutline = value;
		}
	}

	public bool characterPureOuterOutline
	{
		get
		{
			return m_CharacterPureOuterOutline;
		}
		set
		{
			m_CharacterPureOuterOutline = value;
		}
	}

	public RenderingMode renderingMode
	{
		get
		{
			return m_RenderingMode;
		}
		set
		{
			SetDirty();
			m_RenderingMode = value;
		}
	}

	protected override ScriptableRenderer Create()
	{
		return Create(RenderPassScheduleMode.PC);
	}

	protected override ScriptableRenderer Create(RenderPassScheduleMode renderPassScheduleMode)
	{
		if (!Application.isPlaying)
		{
			ReloadAllNullProperties();
		}
		return new UniversalRenderer(this, renderPassScheduleMode);
	}

	protected override void OnValidate()
	{
		base.OnValidate();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (shaders != null)
		{
			ReloadAllNullProperties();
		}
	}

	private void ReloadAllNullProperties()
	{
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		m_AssetVersion = 2;
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		m_AssetVersion = 2;
	}
}
