using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

[ExecuteAlways]
[DisallowMultipleComponent]
[AddComponentMenu("Rendering/Inner World Material Clip Setter")]
public sealed class InnerWorldMaterialStencilSetter : MonoBehaviour
{
	public enum ClipWorld
	{
		InnerWorld,
		OuterWorld
	}

	private struct RendererMaterialState
	{
		public Renderer renderer;

		public Material[] originalMaterials;

		public Material[] createdMaterials;
	}

	private struct MaterialOverrideMaterialState
	{
		public List<Material> materialList;

		public Material originalMaterial;

		public Material createdMaterial;
	}

	private static readonly int InnerWorldMaterialClipParamsID = Shader.PropertyToID("_InnerWorldMaterialClipParams");

	private const string ToonGenericShaderName = "ACT/toon generic";

	private const string InnerWorldClipKeyword = "_INNER_WORLD_CLIP";

	[SerializeField]
	private ClipWorld clipWorld = ClipWorld.OuterWorld;

	[SerializeField]
	private bool includeInactiveChildren;

	private readonly List<RendererMaterialState> m_MaterialStates = new List<RendererMaterialState>(8);

	private readonly List<MaterialOverrideMaterialState> m_MaterialOverrideStates = new List<MaterialOverrideMaterialState>(4);

	private void OnEnable()
	{
		Apply();
	}

	private void OnDisable()
	{
		Release();
	}

	private void OnDestroy()
	{
		Release();
	}

	[ContextMenu("Apply Inner World Material Clip")]
	public void Apply()
	{
		Release();
		Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>(includeInactiveChildren);
		Vector4 clipParams = GetClipParams(clipWorld);
		Vector4 clipParams2 = GetClipParams(GetOppositeClipWorld(clipWorld));
		foreach (Renderer renderer in componentsInChildren)
		{
			if (renderer == null)
			{
				continue;
			}
			Material[] sharedMaterials = renderer.sharedMaterials;
			if (sharedMaterials == null || sharedMaterials.Length == 0)
			{
				continue;
			}
			Material[] array = null;
			Material[] array2 = null;
			bool flag = false;
			for (int j = 0; j < sharedMaterials.Length; j++)
			{
				Material material = sharedMaterials[j];
				if (material == null || !material.HasProperty(InnerWorldMaterialClipParamsID))
				{
					continue;
				}
				if (array == null)
				{
					array = new Material[sharedMaterials.Length];
					for (int k = 0; k < sharedMaterials.Length; k++)
					{
						array[k] = sharedMaterials[k];
					}
					array2 = new Material[sharedMaterials.Length];
				}
				array2[j] = (array[j] = CreateClipMaterialInstance(material, clipParams));
				flag = true;
			}
			if (flag)
			{
				renderer.sharedMaterials = array;
				m_MaterialStates.Add(new RendererMaterialState
				{
					renderer = renderer,
					originalMaterials = sharedMaterials,
					createdMaterials = array2
				});
			}
		}
		ApplyMaterialOverride(clipParams2);
	}

	public void SetClipWorld(ClipWorld clipWorld)
	{
		this.clipWorld = clipWorld;
		if (isActiveAndEnabled)
		{
			Apply();
		}
	}

	[ContextMenu("Release Inner World Material Clip")]
	public void Release()
	{
		for (int i = 0; i < m_MaterialStates.Count; i++)
		{
			RendererMaterialState rendererMaterialState = m_MaterialStates[i];
			if (rendererMaterialState.renderer != null && rendererMaterialState.originalMaterials != null)
			{
				rendererMaterialState.renderer.sharedMaterials = rendererMaterialState.originalMaterials;
			}
			DestroyInstanceMaterials(rendererMaterialState.createdMaterials);
		}
		m_MaterialStates.Clear();
		for (int j = 0; j < m_MaterialOverrideStates.Count; j++)
		{
			MaterialOverrideMaterialState materialOverrideMaterialState = m_MaterialOverrideStates[j];
			if (materialOverrideMaterialState.materialList != null && materialOverrideMaterialState.createdMaterial != null)
			{
				for (int k = 0; k < materialOverrideMaterialState.materialList.Count; k++)
				{
					if ((object)materialOverrideMaterialState.materialList[k] == materialOverrideMaterialState.createdMaterial)
					{
						materialOverrideMaterialState.materialList[k] = materialOverrideMaterialState.originalMaterial;
						break;
					}
				}
			}
			DestroyOwnedMaterial(materialOverrideMaterialState.createdMaterial);
		}
		m_MaterialOverrideStates.Clear();
	}

	private void ApplyMaterialOverride(Vector4 clipParams)
	{
		MaterialOverride component = GetComponent<MaterialOverride>();
		if (component == null)
		{
			return;
		}
		List<Material> matList = component._MatList;
		if (matList == null || matList.Count == 0)
		{
			return;
		}
		int count = matList.Count;
		for (int i = 0; i < count; i++)
		{
			Material material = matList[i];
			if (!(material == null) && material.HasProperty(InnerWorldMaterialClipParamsID))
			{
				Material createdMaterial = (matList[i] = CreateClipMaterialInstance(material, clipParams));
				m_MaterialOverrideStates.Add(new MaterialOverrideMaterialState
				{
					materialList = matList,
					originalMaterial = material,
					createdMaterial = createdMaterial
				});
			}
		}
	}

	private static ClipWorld GetOppositeClipWorld(ClipWorld world)
	{
		if (world != ClipWorld.InnerWorld)
		{
			return ClipWorld.InnerWorld;
		}
		return ClipWorld.OuterWorld;
	}

	private static Vector4 GetClipParams(ClipWorld world)
	{
		return new Vector4(1f, (world == ClipWorld.InnerWorld) ? 1f : 0f, 0f, 0f);
	}

	private static Material CreateClipMaterialInstance(Material sourceMaterial, Vector4 clipParams)
	{
		Material material = new Material(sourceMaterial)
		{
			name = sourceMaterial.name + " (InnerWorld Clip Instance)"
		};
		material.SetVector(InnerWorldMaterialClipParamsID, clipParams);
		if (material.shader != null && material.shader.name == "ACT/toon generic")
		{
			material.EnableKeyword("_INNER_WORLD_CLIP");
		}
		return material;
	}

	private static void DestroyInstanceMaterials(Material[] materials)
	{
		if (materials == null)
		{
			return;
		}
		for (int i = 0; i < materials.Length; i++)
		{
			Material material = materials[i];
			if (!(material == null))
			{
				DestroyOwnedMaterial(material);
				materials[i] = null;
			}
		}
	}

	private static void DestroyOwnedMaterial(Material material)
	{
		if (!(material == null))
		{
			if (Application.isPlaying)
			{
				Object.Destroy(material);
			}
			else
			{
				Object.DestroyImmediate(material);
			}
		}
	}
}
