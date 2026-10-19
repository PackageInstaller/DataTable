namespace UnityEngine.Rendering.Universal;

[DisallowMultipleComponent]
[RequireComponent(typeof(Light))]
public class UniversalAdditionalLightData : MonoBehaviour, IAdditionalData
{
	[SerializeField]
	private int m_Version = 1;

	[SerializeField]
	[Tooltip("Use the pipeline default raster depth and receiver normal bias instead of the Light overrides.")]
	private bool m_UsePipelineSettings = true;

	public static readonly int AdditionalLightsShadowResolutionTierCustom = -1;

	public static readonly int AdditionalLightsShadowResolutionTierLow = 0;

	public static readonly int AdditionalLightsShadowResolutionTierMedium = 1;

	public static readonly int AdditionalLightsShadowResolutionTierHigh = 2;

	public static readonly int AdditionalLightsShadowDefaultResolutionTier = AdditionalLightsShadowResolutionTierHigh;

	public static readonly int AdditionalLightsShadowDefaultCustomResolution = 128;

	public static readonly int AdditionalLightsShadowMinimumResolution = 128;

	[HideInInspector]
	[SerializeField]
	private int m_AdditionalLightsShadowResolutionTier = AdditionalLightsShadowDefaultResolutionTier;

	[SerializeField]
	[Tooltip("Cached Static renders the configured shadow layers once. Budgeted continuously refreshes point and spot lights at the rate allowed by the pipeline tile budget.")]
	private AdditionalShadowUpdateMode m_AdditionalShadowUpdateMode;

	[HideInInspector]
	[SerializeField]
	private int m_AdditionalShadowUpdatePriority;

	[SerializeField]
	private LightLayerEnum m_LightLayerMask = LightLayerEnum.LightLayerDefault | LightLayerEnum.LightLayer1 | LightLayerEnum.LightLayer2;

	[Range(0f, 3f)]
	[SerializeField]
	public float ACT_RimIntensity = 1f;

	[SerializeField]
	public Vector2 ACT_LightRimRange = new Vector2(-0f, 0.5f);

	[Range(0f, 1f)]
	[SerializeField]
	public float ACT_LightHardness;

	[SerializeField]
	public float ACT_LightRadius;

	[Range(-1f, 1f)]
	[SerializeField]
	public float ACT_Offset;

	[SerializeField]
	public bool ACT_Revert;

	[SerializeField]
	public bool ACT_IgnoreFace;

	[SerializeField]
	[Range(0f, 5f)]
	public float ACT_DepthHighLight;

	[SerializeField]
	public LightHalo ACT_LightHalos = new LightHalo();

	[SerializeField]
	private bool m_CustomShadowLayers;

	[SerializeField]
	private LightLayerEnum m_ShadowLayerMask = LightLayerEnum.LightLayerDefault;

	[Tooltip("Controls the size of the cookie mask currently assigned to the light.")]
	[SerializeField]
	private Vector2 m_LightCookieSize = Vector2.one;

	[SerializeField]
	[Tooltip("Controls the offset of the cookie mask currently assigned to the light.")]
	private Vector2 m_LightCookieOffset = Vector2.zero;

	internal int version => m_Version;

	public bool usePipelineSettings
	{
		get
		{
			return m_UsePipelineSettings;
		}
		set
		{
			m_UsePipelineSettings = value;
		}
	}

	public AdditionalShadowUpdateMode additionalShadowUpdateMode
	{
		get
		{
			return m_AdditionalShadowUpdateMode;
		}
		set
		{
			m_AdditionalShadowUpdateMode = value;
		}
	}

	public LightLayerEnum lightLayerMask
	{
		get
		{
			return m_LightLayerMask;
		}
		set
		{
			m_LightLayerMask = value;
		}
	}

	public bool customShadowLayers
	{
		get
		{
			return m_CustomShadowLayers;
		}
		set
		{
			m_CustomShadowLayers = value;
		}
	}

	public LightLayerEnum shadowLayerMask
	{
		get
		{
			return m_ShadowLayerMask;
		}
		set
		{
			m_ShadowLayerMask = value;
			Light component = GetComponent<Light>();
			if (component != null)
			{
				component.renderingLayerMask = (int)value;
			}
		}
	}
}
