using UnityEngine;
using UnityEngine.UI;

[ExecuteAlways]
[RequireComponent(typeof(Image))]
public class MonoWakeEyeMaskMaterialController : MonoBehaviour, IMaterialModifier
{
	private static readonly int EyeSoftnessId = Shader.PropertyToID("_EyeSoftness");

	private static readonly int EyeOpenId = Shader.PropertyToID("_EyeOpen");

	private static readonly int EyeWidthId = Shader.PropertyToID("_EyeWidth");

	[SerializeField]
	[Range(0.001f, 0.25f)]
	private float eyeSoftness = 0.06f;

	[SerializeField]
	[Range(0f, 2f)]
	private float eyeOpen;

	[SerializeField]
	[Range(0f, 1f)]
	private float eyeWidth = 1f;

	private Graphic graphic;

	private Material sourceMaterial;

	private Material materialInstance;

	private float lastEyeSoftness = float.NaN;

	private float lastEyeOpen = float.NaN;

	private float lastEyeWidth = float.NaN;

	public float EyeSoftness
	{
		get
		{
			return eyeSoftness;
		}
		set
		{
			eyeSoftness = value;
			SetDirtyIfValueChanged();
		}
	}

	public float EyeOpen
	{
		get
		{
			return eyeOpen;
		}
		set
		{
			eyeOpen = value;
			SetDirtyIfValueChanged();
		}
	}

	public float EyeWidth
	{
		get
		{
			return eyeWidth;
		}
		set
		{
			eyeWidth = value;
			SetDirtyIfValueChanged();
		}
	}

	public Material GetModifiedMaterial(Material baseMaterial)
	{
		if (baseMaterial == null)
		{
			return baseMaterial;
		}
		if (materialInstance == null || sourceMaterial != baseMaterial)
		{
			ReleaseMaterialInstance();
			sourceMaterial = baseMaterial;
			materialInstance = new Material(baseMaterial)
			{
				name = baseMaterial.name + " (WakeEyeMask Instance)",
				hideFlags = HideFlags.DontSave
			};
			ResetCachedValues();
		}
		ApplyIfChanged(force: true);
		return materialInstance;
	}

	private void Awake()
	{
		CacheGraphic();
		SetDirtyIfValueChanged();
	}

	private void OnEnable()
	{
		CacheGraphic();
		ResetCachedValues();
		SetMaterialDirty();
	}

	private void LateUpdate()
	{
		SetDirtyIfValueChanged();
	}

	private void OnDisable()
	{
		ReleaseMaterialInstance();
	}

	private void OnDestroy()
	{
		ReleaseMaterialInstance();
	}

	private void CacheGraphic()
	{
		if (graphic == null)
		{
			graphic = GetComponent<Graphic>();
		}
	}

	private void SetDirtyIfValueChanged()
	{
		float a = Mathf.Clamp(eyeSoftness, 0.001f, 0.25f);
		float a2 = Mathf.Clamp(eyeOpen, 0f, 2f);
		float a3 = Mathf.Clamp01(eyeWidth);
		if (!Mathf.Approximately(a, lastEyeSoftness) || !Mathf.Approximately(a2, lastEyeOpen) || !Mathf.Approximately(a3, lastEyeWidth))
		{
			SetMaterialDirty();
		}
	}

	private void SetMaterialDirty()
	{
		CacheGraphic();
		if (graphic != null)
		{
			graphic.SetMaterialDirty();
		}
	}

	private void ApplyIfChanged(bool force)
	{
		if (!(materialInstance == null))
		{
			float num = Mathf.Clamp(eyeSoftness, 0.001f, 0.25f);
			float num2 = Mathf.Clamp(eyeOpen, 0f, 2f);
			float num3 = Mathf.Clamp01(eyeWidth);
			if (force || !Mathf.Approximately(num, lastEyeSoftness) || !Mathf.Approximately(num2, lastEyeOpen) || !Mathf.Approximately(num3, lastEyeWidth))
			{
				materialInstance.SetFloat(EyeSoftnessId, num);
				materialInstance.SetFloat(EyeOpenId, num2);
				materialInstance.SetFloat(EyeWidthId, num3);
				lastEyeSoftness = num;
				lastEyeOpen = num2;
				lastEyeWidth = num3;
			}
		}
	}

	private void ResetCachedValues()
	{
		lastEyeSoftness = float.NaN;
		lastEyeOpen = float.NaN;
		lastEyeWidth = float.NaN;
	}

	private void ReleaseMaterialInstance()
	{
		if (materialInstance != null)
		{
			if (Application.isPlaying)
			{
				Object.Destroy(materialInstance);
			}
			else
			{
				Object.DestroyImmediate(materialInstance);
			}
			materialInstance = null;
		}
		sourceMaterial = null;
		ResetCachedValues();
	}
}
