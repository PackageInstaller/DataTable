using UnityEngine;
using UnityEngine.UI;

[ExecuteAlways]
[DisallowMultipleComponent]
[RequireComponent(typeof(Image))]
[AddComponentMenu("2美术工具/ShaderACTNew Image K动画")]
public class ShaderACTNewImageMaterialAnimation : MonoBehaviour, IMaterialModifier
{
	private const string ShaderName = "ACT/ShaderACTNew";

	private const string DissolveKeyword = "_DISSOLVE_ON";

	private const string DistortionKeyword = "_DISTORTEFFECT";

	private const string DissolveTextureProperty = "_DissolveTexture";

	private static readonly int DissolveRotationId = Shader.PropertyToID("_Dissolve_Rotation");

	private static readonly int DissolveUVSelectId = Shader.PropertyToID("_DissolveUVSelect");

	private static readonly int DissolveSmoothId = Shader.PropertyToID("_DisSmooth");

	private static readonly int DissolveCutId = Shader.PropertyToID("_Cut");

	private const string DistortionTextureProperty = "_DistortionTexture";

	private static readonly int DistortionRotationId = Shader.PropertyToID("_Distortion_Rotation");

	private static readonly int DistortionUVSelectId = Shader.PropertyToID("_DistortionUVSelect");

	private static readonly int DistortionId = Shader.PropertyToID("_Distortion");

	private static readonly int DistortionXId = Shader.PropertyToID("_DistortionX");

	private static readonly int DistortionYId = Shader.PropertyToID("_DistortionY");

	[Header("Dissolve")]
	public bool dissolveEnabled;

	public Vector2 dissolveTiling = Vector2.one;

	public Vector2 dissolveOffset;

	[Range(0f, 1.5f)]
	public float dissolveRotation;

	[Range(0f, 7f)]
	public int dissolveUV;

	[Range(0f, 1f)]
	public float dissolveSmooth;

	[Range(0f, 1f)]
	public float dissolveCut;

	[Header("Distortion")]
	public bool distortionEnabled;

	public Vector2 distortionTiling = Vector2.one;

	public Vector2 distortionOffset;

	[Range(0f, 1.5f)]
	public float distortionRotation;

	[Range(0f, 7f)]
	public int distortionUV;

	public float distortionStrength;

	[Range(0f, 2f)]
	public float distortionX = 1f;

	[Range(0f, 2f)]
	public float distortionY = 1f;

	private Image image;

	private Material sourceMaterial;

	private Material materialInstance;

	private bool hasInitializedValues;

	private bool hasAppliedProperties;

	private bool appliedDissolveEnabled;

	private Vector2 appliedDissolveTiling;

	private Vector2 appliedDissolveOffset;

	private float appliedDissolveRotation;

	private int appliedDissolveUV;

	private float appliedDissolveSmooth;

	private float appliedDissolveCut;

	private bool appliedDistortionEnabled;

	private Vector2 appliedDistortionTiling;

	private Vector2 appliedDistortionOffset;

	private float appliedDistortionRotation;

	private int appliedDistortionUV;

	private float appliedDistortionStrength;

	private float appliedDistortionX;

	private float appliedDistortionY;

	private void OnEnable()
	{
		image = GetComponent<Image>();
		hasAppliedProperties = false;
		image.SetMaterialDirty();
	}

	private void OnDisable()
	{
		ReleaseMaterialInstance();
		image?.SetMaterialDirty();
	}

	private void OnDestroy()
	{
		ReleaseMaterialInstance();
	}

	private void OnValidate()
	{
		hasAppliedProperties = false;
		if (image == null)
		{
			image = GetComponent<Image>();
		}
		image?.SetMaterialDirty();
	}

	private void OnDidApplyAnimationProperties()
	{
		hasAppliedProperties = false;
		image?.SetMaterialDirty();
	}

	private void Update()
	{
		if (HavePropertiesChanged())
		{
			CacheAppliedProperties();
			image?.SetMaterialDirty();
		}
	}

	public Material GetModifiedMaterial(Material baseMaterial)
	{
		if (baseMaterial == null || baseMaterial.shader == null || baseMaterial.shader.name != "ACT/ShaderACTNew")
		{
			return baseMaterial;
		}
		if (materialInstance == null || sourceMaterial != baseMaterial)
		{
			ReleaseMaterialInstance();
			sourceMaterial = baseMaterial;
			materialInstance = new Material(sourceMaterial)
			{
				name = sourceMaterial.name + " (Image Animation Instance)",
				hideFlags = (HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild)
			};
			if (!hasInitializedValues)
			{
				ReadMaterialProperties();
				hasInitializedValues = true;
			}
		}
		ApplyMaterialProperties();
		return materialInstance;
	}

	private void ReadMaterialProperties()
	{
		dissolveEnabled = sourceMaterial.IsKeywordEnabled("_DISSOLVE_ON");
		dissolveTiling = sourceMaterial.GetTextureScale("_DissolveTexture");
		dissolveOffset = sourceMaterial.GetTextureOffset("_DissolveTexture");
		dissolveRotation = sourceMaterial.GetFloat(DissolveRotationId);
		dissolveUV = ToUVSelect(sourceMaterial.GetFloat(DissolveUVSelectId));
		dissolveSmooth = sourceMaterial.GetFloat(DissolveSmoothId);
		dissolveCut = sourceMaterial.GetFloat(DissolveCutId);
		distortionEnabled = sourceMaterial.IsKeywordEnabled("_DISTORTEFFECT");
		distortionTiling = sourceMaterial.GetTextureScale("_DistortionTexture");
		distortionOffset = sourceMaterial.GetTextureOffset("_DistortionTexture");
		distortionRotation = sourceMaterial.GetFloat(DistortionRotationId);
		distortionUV = ToUVSelect(sourceMaterial.GetFloat(DistortionUVSelectId));
		distortionStrength = sourceMaterial.GetFloat(DistortionId);
		distortionX = sourceMaterial.GetFloat(DistortionXId);
		distortionY = sourceMaterial.GetFloat(DistortionYId);
	}

	private void ApplyMaterialProperties()
	{
		if (!(materialInstance == null))
		{
			SetKeyword("_DISSOLVE_ON", dissolveEnabled);
			materialInstance.SetTextureScale("_DissolveTexture", dissolveTiling);
			materialInstance.SetTextureOffset("_DissolveTexture", dissolveOffset);
			materialInstance.SetFloat(DissolveRotationId, dissolveRotation);
			materialInstance.SetFloat(DissolveUVSelectId, Mathf.Clamp(dissolveUV, 0, 7));
			materialInstance.SetFloat(DissolveSmoothId, dissolveSmooth);
			materialInstance.SetFloat(DissolveCutId, dissolveCut);
			SetKeyword("_DISTORTEFFECT", distortionEnabled);
			materialInstance.SetTextureScale("_DistortionTexture", distortionTiling);
			materialInstance.SetTextureOffset("_DistortionTexture", distortionOffset);
			materialInstance.SetFloat(DistortionRotationId, distortionRotation);
			materialInstance.SetFloat(DistortionUVSelectId, Mathf.Clamp(distortionUV, 0, 7));
			materialInstance.SetFloat(DistortionId, distortionStrength);
			materialInstance.SetFloat(DistortionXId, distortionX);
			materialInstance.SetFloat(DistortionYId, distortionY);
			CacheAppliedProperties();
		}
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
		hasAppliedProperties = false;
	}

	private bool HavePropertiesChanged()
	{
		if (hasAppliedProperties && dissolveEnabled == appliedDissolveEnabled && !(dissolveTiling != appliedDissolveTiling) && !(dissolveOffset != appliedDissolveOffset) && Mathf.Approximately(dissolveRotation, appliedDissolveRotation) && dissolveUV == appliedDissolveUV && Mathf.Approximately(dissolveSmooth, appliedDissolveSmooth) && Mathf.Approximately(dissolveCut, appliedDissolveCut) && distortionEnabled == appliedDistortionEnabled && !(distortionTiling != appliedDistortionTiling) && !(distortionOffset != appliedDistortionOffset) && Mathf.Approximately(distortionRotation, appliedDistortionRotation) && distortionUV == appliedDistortionUV && Mathf.Approximately(distortionStrength, appliedDistortionStrength) && Mathf.Approximately(distortionX, appliedDistortionX))
		{
			return !Mathf.Approximately(distortionY, appliedDistortionY);
		}
		return true;
	}

	private void CacheAppliedProperties()
	{
		hasAppliedProperties = true;
		appliedDissolveEnabled = dissolveEnabled;
		appliedDissolveTiling = dissolveTiling;
		appliedDissolveOffset = dissolveOffset;
		appliedDissolveRotation = dissolveRotation;
		appliedDissolveUV = dissolveUV;
		appliedDissolveSmooth = dissolveSmooth;
		appliedDissolveCut = dissolveCut;
		appliedDistortionEnabled = distortionEnabled;
		appliedDistortionTiling = distortionTiling;
		appliedDistortionOffset = distortionOffset;
		appliedDistortionRotation = distortionRotation;
		appliedDistortionUV = distortionUV;
		appliedDistortionStrength = distortionStrength;
		appliedDistortionX = distortionX;
		appliedDistortionY = distortionY;
	}

	private void SetKeyword(string keyword, bool enabled)
	{
		if (enabled)
		{
			materialInstance.EnableKeyword(keyword);
		}
		else
		{
			materialInstance.DisableKeyword(keyword);
		}
	}

	private static int ToUVSelect(float value)
	{
		return Mathf.Clamp(Mathf.RoundToInt(value), 0, 7);
	}
}
