namespace UnityEngine.Rendering.Universal;

[ExecuteAlways]
[AddComponentMenu("Rendering/URP Decal Projector")]
public class DecalProjector : MonoBehaviour
{
	internal delegate void DecalProjectorAction(DecalProjector decalProjector);

	[SerializeField]
	private Material m_Material;

	[SerializeField]
	private float m_DrawDistance = 1000f;

	[SerializeField]
	[Range(0f, 1f)]
	private float m_FadeScale = 0.9f;

	[SerializeField]
	[Range(0f, 180f)]
	private float m_StartAngleFade = 180f;

	[SerializeField]
	[Range(0f, 180f)]
	private float m_EndAngleFade = 180f;

	[SerializeField]
	private Vector2 m_UVScale = new Vector2(1f, 1f);

	[SerializeField]
	private Vector2 m_UVBias = new Vector2(0f, 0f);

	[SerializeField]
	private DecalScaleMode m_ScaleMode;

	[SerializeField]
	internal Vector3 m_Offset = new Vector3(0f, 0f, 0.5f);

	[SerializeField]
	internal Vector3 m_Size = new Vector3(1f, 1f, 1f);

	[SerializeField]
	[Range(0f, 1f)]
	private float m_FadeFactor = 1f;

	private Material m_OldMaterial;

	internal static Material defaultMaterial { get; set; }

	internal static bool isSupported => onDecalAdd != null;

	internal DecalEntity decalEntity { get; set; }

	public Material material
	{
		get
		{
			return m_Material;
		}
		set
		{
			m_Material = value;
			OnValidate();
		}
	}

	public float drawDistance
	{
		get
		{
			return m_DrawDistance;
		}
		set
		{
			m_DrawDistance = Mathf.Max(0f, value);
			OnValidate();
		}
	}

	public float fadeScale
	{
		get
		{
			return m_FadeScale;
		}
		set
		{
			m_FadeScale = Mathf.Clamp01(value);
			OnValidate();
		}
	}

	public float startAngleFade
	{
		get
		{
			return m_StartAngleFade;
		}
		set
		{
			m_StartAngleFade = Mathf.Clamp(value, 0f, 180f);
			OnValidate();
		}
	}

	public float endAngleFade
	{
		get
		{
			return m_EndAngleFade;
		}
		set
		{
			m_EndAngleFade = Mathf.Clamp(value, m_StartAngleFade, 180f);
			OnValidate();
		}
	}

	public Vector2 uvScale
	{
		get
		{
			return m_UVScale;
		}
		set
		{
			m_UVScale = value;
			OnValidate();
		}
	}

	public Vector2 uvBias
	{
		get
		{
			return m_UVBias;
		}
		set
		{
			m_UVBias = value;
			OnValidate();
		}
	}

	public DecalScaleMode scaleMode
	{
		get
		{
			return m_ScaleMode;
		}
		set
		{
			m_ScaleMode = value;
			OnValidate();
		}
	}

	public Vector3 pivot
	{
		get
		{
			return m_Offset;
		}
		set
		{
			m_Offset = value;
			OnValidate();
		}
	}

	public Vector3 size
	{
		get
		{
			return m_Size;
		}
		set
		{
			m_Size = value;
			OnValidate();
		}
	}

	public float fadeFactor
	{
		get
		{
			return m_FadeFactor;
		}
		set
		{
			m_FadeFactor = Mathf.Clamp01(value);
			OnValidate();
		}
	}

	internal Vector3 effectiveScale
	{
		get
		{
			if (m_ScaleMode != DecalScaleMode.InheritFromHierarchy)
			{
				return Vector3.one;
			}
			return transform.lossyScale;
		}
	}

	internal Vector3 decalSize => new Vector3(m_Size.x, m_Size.z, m_Size.y);

	internal Vector3 decalOffset => new Vector3(m_Offset.x, 0f - m_Offset.z, m_Offset.y);

	internal Vector4 uvScaleBias => new Vector4(m_UVScale.x, m_UVScale.y, m_UVBias.x, m_UVBias.y);

	internal static event DecalProjectorAction onDecalAdd;

	internal static event DecalProjectorAction onDecalRemove;

	internal static event DecalProjectorAction onDecalPropertyChange;

	internal static event DecalProjectorAction onDecalMaterialChange;

	private void InitMaterial()
	{
		_ = m_Material == null;
	}

	private void OnEnable()
	{
		InitMaterial();
		m_OldMaterial = m_Material;
		onDecalAdd?.Invoke(this);
	}

	private void OnDisable()
	{
		onDecalRemove?.Invoke(this);
	}

	internal void OnValidate()
	{
		if (isActiveAndEnabled)
		{
			if (m_Material != m_OldMaterial)
			{
				onDecalMaterialChange?.Invoke(this);
				m_OldMaterial = m_Material;
			}
			else
			{
				onDecalPropertyChange?.Invoke(this);
			}
		}
	}

	public bool IsValid()
	{
		if (material == null)
		{
			return false;
		}
		if (material.FindPass("DecalGBufferProjector") != -1)
		{
			return true;
		}
		return false;
	}
}
