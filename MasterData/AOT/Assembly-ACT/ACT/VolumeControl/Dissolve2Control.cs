using System.Collections.Generic;
using RenderProject.Rendering.CustomSkinning;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Rendering.Universal;

namespace ACT.VolumeControl;

[ExecuteAlways]
[ExecuteInEditMode]
[AddComponentMenu("2美术工具/Dissolve2控制")]
public class Dissolve2Control : MonoBehaviour
{
	public List<Renderer> skinnedMeshRenderers = new List<Renderer>();

	private bool shouldBeRebuild;

	private MaterialPropertyBlock block;

	private MaterialPropertyBlock rollbackBlock;

	private readonly Dictionary<Renderer, Material[]> runtimeMaterials = new Dictionary<Renderer, Material[]>();

	[SerializeField]
	private bool _DitherGroup_Active;

	[SerializeField]
	[DisplayName("Dither", null)]
	public bool _DitherGroup;

	[SerializeField]
	private bool _DitherValue_Active;

	[SerializeField]
	[DisplayName("_DitherValue", null)]
	[Range(0f, 1f)]
	public float _DitherValue;

	[SerializeField]
	private bool _DissolveGroup2_Active;

	[SerializeField]
	[DisplayName("Dissolve2", null)]
	public bool _DissolveGroup2;

	[SerializeField]
	private bool _UV2Dissolve2_Active;

	[SerializeField]
	[DisplayName("Dissolve with UV3", null)]
	public bool _UV2Dissolve2;

	[SerializeField]
	private bool _UVXDir_Active;

	[SerializeField]
	[DisplayName("Dissolve by X Dir", null)]
	public bool _UVXDir;

	[SerializeField]
	private bool _InvertUV_Active;

	[SerializeField]
	[DisplayName("_InvertDir", null)]
	public bool _InvertUV;

	[SerializeField]
	private bool _DissolveColor1_Active;

	[SerializeField]
	[DisplayName("Dissolve Emmision 1", null)]
	[ColorUsage(true, true)]
	private Color _DissolveColor1;

	[SerializeField]
	private bool _DissolveColor2_Active;

	[SerializeField]
	[DisplayName("Dissolve Emmision 2", null)]
	[ColorUsage(true, true)]
	private Color _DissolveColor2;

	[SerializeField]
	private bool _NoiseControl1_Active;

	[SerializeField]
	[DisplayName("NoiseControl1", null)]
	public Vector4 _NoiseControl1 = new Vector4(30f, 30f, 0f, 0f);

	[SerializeField]
	private bool _NoiseControl2_Active;

	[SerializeField]
	[DisplayName("NoiseControl2", null)]
	public Vector4 _NoiseControl2 = new Vector4(60f, 60f, 0f, 0f);

	[SerializeField]
	private bool _ReliefScale_Active;

	[SerializeField]
	[DisplayName("_ReliefScale", null)]
	[Range(0f, 1f)]
	private float _ReliefScale;

	[SerializeField]
	private bool _ReliefPower_Active;

	[SerializeField]
	[DisplayName("_ReliefPower", null)]
	[Range(0f, 1f)]
	private float _ReliefPower;

	[SerializeField]
	private bool _ReliefRange_Active;

	[SerializeField]
	[DisplayName("_ReliefRange", null)]
	[Range(0f, 1f)]
	private float _ReliefRange = 1f;

	[SerializeField]
	private bool _ScanLine_Active;

	[SerializeField]
	[DisplayName("_ScanLine", null)]
	public float _ScanLine;

	[SerializeField]
	private bool _ScanRange_Active;

	[SerializeField]
	[DisplayName("_ScanRange", null)]
	[Range(0f, 1f)]
	private float _ScanRange = 0.1f;

	[SerializeField]
	private bool _NoiseSize_Active;

	[SerializeField]
	[DisplayName("ScanNoiseSize", null)]
	public float _NoiseSize;

	[SerializeField]
	private bool _NoiseOffsetScan_Active;

	[SerializeField]
	[DisplayName("Noise Offset With Scan", null)]
	[Range(0f, 1f)]
	private float _NoiseOffsetScan;

	[SerializeField]
	private bool _NoisePower_Active;

	[SerializeField]
	[DisplayName("ScanNoisePower", null)]
	public float _NoisePower;

	[SerializeField]
	private bool _HueShift_Active;

	[SerializeField]
	[DisplayName("HueShift", null)]
	public float _HueShift;

	[SerializeField]
	private bool _ScanNoiseType_Active;

	[SerializeField]
	[DisplayName("ScanNoiseType", null)]
	[Range(0f, 1f)]
	private float _ScanNoiseType;

	[SerializeField]
	private bool _Cut_Active;

	[SerializeField]
	[DisplayName("ShaderACTNew Dissolve _Cut", null)]
	[Range(0f, 1f)]
	private float _Cut;

	public void Init()
	{
		skinnedMeshRenderers.Clear();
		SkinnedMeshRenderer[] componentsInChildren = transform.GetComponentsInChildren<SkinnedMeshRenderer>(includeInactive: true);
		foreach (SkinnedMeshRenderer skinnedMeshRenderer in componentsInChildren)
		{
			if (skinnedMeshRenderer != null)
			{
				skinnedMeshRenderers.Add(skinnedMeshRenderer);
			}
		}
		CustomSkinRenderer[] componentsInChildren2 = transform.GetComponentsInChildren<CustomSkinRenderer>(includeInactive: true);
		foreach (CustomSkinRenderer customSkinRenderer in componentsInChildren2)
		{
			if (!(customSkinRenderer == null))
			{
				MeshRenderer component = customSkinRenderer.GetComponent<MeshRenderer>();
				if (component != null && !skinnedMeshRenderers.Contains(component))
				{
					skinnedMeshRenderers.Add(component);
				}
			}
		}
	}

	private void Awake()
	{
		block = new MaterialPropertyBlock();
		rollbackBlock = new MaterialPropertyBlock();
		InitBlock(rollbackBlock, force: true);
	}

	private void OnValidate()
	{
		shouldBeRebuild = true;
	}

	public void Reset()
	{
		shouldBeRebuild = true;
	}

	private void OnDidApplyAnimationProperties()
	{
		shouldBeRebuild = true;
	}

	private void OnDisable()
	{
		block?.Clear();
	}

	private void OnDestroy()
	{
		if (!Application.isPlaying)
		{
			runtimeMaterials.Clear();
			return;
		}
		foreach (Material[] value in runtimeMaterials.Values)
		{
			foreach (Material material in value)
			{
				if (!(material == null))
				{
					Object.Destroy(material);
				}
			}
		}
		runtimeMaterials.Clear();
	}

	private void LateUpdate()
	{
		if (shouldBeRebuild)
		{
			Rebuild(block);
		}
	}

	private void Rebuild(MaterialPropertyBlock targetBlock, bool force = false)
	{
		shouldBeRebuild = false;
		ApplyBlock(targetBlock, force);
	}

	private void ApplyBlock(MaterialPropertyBlock targetBlock, bool force = false)
	{
		for (int i = 0; i < skinnedMeshRenderers.Count; i++)
		{
			Renderer renderer = skinnedMeshRenderers[i];
			if ((bool)renderer)
			{
				renderer.GetPropertyBlock(targetBlock);
				InitBlock(targetBlock, force);
				if (_DitherGroup_Active | force)
				{
					SetDitherEnabled(renderer, targetBlock, _DitherGroup);
				}
				else
				{
					renderer.SetPropertyBlock(targetBlock);
				}
				if (_DissolveGroup2_Active | force)
				{
					SetDissolve2Enabled(renderer, _DissolveGroup2);
				}
			}
		}
	}

	private void SetDitherEnabled(Renderer renderer, MaterialPropertyBlock targetBlock, bool enabled)
	{
		if (!enabled)
		{
			targetBlock.SetFloat("_DitherValue", 1f);
		}
		renderer.SetPropertyBlock(targetBlock);
		if (!runtimeMaterials.TryGetValue(renderer, out var value))
		{
			value = (Application.isPlaying ? renderer.materials : renderer.sharedMaterials);
			runtimeMaterials.Add(renderer, value);
		}
		foreach (Material material in value)
		{
			if (!(material == null))
			{
				material.SetFloat("_DitherGroup", enabled ? 1f : 0f);
				VisibilityMaterialKeywords.SetDitherKeyword(material, enabled);
			}
		}
	}

	private void SetDissolve2Enabled(Renderer renderer, bool enabled)
	{
		if (!runtimeMaterials.TryGetValue(renderer, out var value))
		{
			value = (Application.isPlaying ? renderer.materials : renderer.sharedMaterials);
			runtimeMaterials.Add(renderer, value);
		}
		foreach (Material material in value)
		{
			if (!(material == null))
			{
				material.SetFloat("_DissolveGroup2", enabled ? 1f : 0f);
				VisibilityMaterialKeywords.SetDissolve2Keyword(material, enabled);
			}
		}
	}

	private void InitBlock(MaterialPropertyBlock targetBlock, bool force = false)
	{
		if (_DitherValue_Active | force)
		{
			targetBlock.SetFloat("_DitherValue", _DitherValue);
		}
		if (_UV2Dissolve2_Active | force)
		{
			targetBlock.SetFloat("_UV2Dissolve2", _UV2Dissolve2 ? 1 : 0);
		}
		if (_UVXDir_Active | force)
		{
			targetBlock.SetFloat("_UVXDir", _UVXDir ? 1 : 0);
		}
		if (_InvertUV_Active | force)
		{
			targetBlock.SetFloat("_InvertUV", _InvertUV ? 1 : 0);
		}
		if (_DissolveColor1_Active | force)
		{
			targetBlock.SetColor("_DissolveColor1", _DissolveColor1);
		}
		if (_DissolveColor2_Active | force)
		{
			targetBlock.SetColor("_DissolveColor2", _DissolveColor2);
		}
		if (_NoiseControl1_Active | force)
		{
			targetBlock.SetVector("_NoiseControl1", _NoiseControl1);
		}
		if (_NoiseControl2_Active | force)
		{
			targetBlock.SetVector("_NoiseControl2", _NoiseControl2);
		}
		if (_ReliefScale_Active | force)
		{
			targetBlock.SetFloat("_ReliefScale", _ReliefScale);
		}
		if (_ReliefPower_Active | force)
		{
			targetBlock.SetFloat("_ReliefPower", _ReliefPower);
		}
		if (_ReliefRange_Active | force)
		{
			targetBlock.SetFloat("_ReliefRange", _ReliefRange);
		}
		if (_ScanLine_Active | force)
		{
			targetBlock.SetFloat("_ScanLine", _ScanLine);
		}
		if (_ScanRange_Active | force)
		{
			targetBlock.SetFloat("_ScanRange", _ScanRange);
		}
		if (_NoiseSize_Active | force)
		{
			targetBlock.SetFloat("_NoiseSize", _NoiseSize);
		}
		if (_NoiseOffsetScan_Active | force)
		{
			targetBlock.SetFloat("_NoiseOffsetScan", _NoiseOffsetScan);
		}
		if (_NoisePower_Active | force)
		{
			targetBlock.SetFloat("_NoisePower", _NoisePower);
		}
		if (_HueShift_Active | force)
		{
			targetBlock.SetFloat("_HueShift", _HueShift);
		}
		if (_ScanNoiseType_Active | force)
		{
			targetBlock.SetFloat("_ScanNoiseType", _ScanNoiseType);
		}
		if (_Cut_Active | force)
		{
			targetBlock.SetFloat("_Cut", _Cut);
		}
	}

	public void ApplyRollBack()
	{
		for (int i = 0; i < skinnedMeshRenderers.Count; i++)
		{
			Renderer renderer = skinnedMeshRenderers[i];
			if ((bool)renderer)
			{
				renderer.GetPropertyBlock(block);
				if (rollbackBlock.HasFloat("_DitherValue"))
				{
					block.SetFloat("_DitherValue", rollbackBlock.GetFloat("_DitherValue"));
				}
				if (rollbackBlock.HasFloat("_UV2Dissolve2"))
				{
					block.SetFloat("_UV2Dissolve2", rollbackBlock.GetFloat("_UV2Dissolve2"));
				}
				if (rollbackBlock.HasFloat("_UVXDir_Active"))
				{
					block.SetFloat("_UVXDir_Active", rollbackBlock.GetFloat("_UVXDir_Active"));
				}
				if (rollbackBlock.HasFloat("_InvertUV_Active"))
				{
					block.SetFloat("_InvertUV_Active", rollbackBlock.GetFloat("_InvertUV_Active"));
				}
				if (rollbackBlock.HasColor("_DissolveColor1_Active"))
				{
					block.SetColor("_DissolveColor1_Active", rollbackBlock.GetColor("_DissolveColor1_Active"));
				}
				if (rollbackBlock.HasColor("_DissolveColor2"))
				{
					block.SetColor("_DissolveColor2", rollbackBlock.GetColor("_DissolveColor2"));
				}
				if (rollbackBlock.HasVector("_NoiseControl1"))
				{
					block.SetVector("_NoiseControl1", rollbackBlock.GetVector("_NoiseControl1"));
				}
				if (rollbackBlock.HasVector("_NoiseControl2"))
				{
					block.SetVector("_NoiseControl2", rollbackBlock.GetVector("_NoiseControl2"));
				}
				if (rollbackBlock.HasFloat("_ReliefScale"))
				{
					block.SetFloat("_ReliefScale", rollbackBlock.GetFloat("_ReliefScale"));
				}
				if (rollbackBlock.HasFloat("_ReliefPower"))
				{
					block.SetFloat("_ReliefPower", rollbackBlock.GetFloat("_ReliefPower"));
				}
				if (rollbackBlock.HasFloat("_ReliefRange"))
				{
					block.SetFloat("_ReliefRange", rollbackBlock.GetFloat("_ReliefRange"));
				}
				if (rollbackBlock.HasFloat("_ScanLine"))
				{
					block.SetFloat("_ScanLine", rollbackBlock.GetFloat("_ScanLine"));
				}
				if (rollbackBlock.HasFloat("_ScanRange"))
				{
					block.SetFloat("_ScanRange", rollbackBlock.GetFloat("_ScanRange"));
				}
				if (rollbackBlock.HasFloat("_NoiseSize"))
				{
					block.SetFloat("_NoiseSize", rollbackBlock.GetFloat("_NoiseSize"));
				}
				if (rollbackBlock.HasFloat("_NoiseOffsetScan"))
				{
					block.SetFloat("_NoiseOffsetScan", rollbackBlock.GetFloat("_NoiseOffsetScan"));
				}
				if (rollbackBlock.HasFloat("_NoisePower"))
				{
					block.SetFloat("_NoisePower", rollbackBlock.GetFloat("_NoisePower"));
				}
				if (rollbackBlock.HasFloat("_HueShift"))
				{
					block.SetFloat("_HueShift", rollbackBlock.GetFloat("_HueShift"));
				}
				if (rollbackBlock.HasFloat("_ScanNoiseType"))
				{
					block.SetFloat("_ScanNoiseType", rollbackBlock.GetFloat("_ScanNoiseType"));
				}
				if (rollbackBlock.HasFloat("_Cut"))
				{
					block.SetFloat("_Cut", rollbackBlock.GetFloat("_Cut"));
				}
				renderer.SetPropertyBlock(block);
			}
		}
	}
}
