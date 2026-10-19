using UnityEngine;

namespace ACT.VolumeControl;

[ExecuteInEditMode]
[AddComponentMenu("2美术工具/ToonGeneric 的 SkinMeshRenderer K动画")]
public class SkinMeshRendererMatAnim2ToonGeneric : MonoBehaviour
{
	public bool KAnim;

	public bool NewEmmisionLogic;

	[ColorUsage(true, true)]
	public Color EmissionColor;

	private SkinnedMeshRenderer m_meshRenderer;

	private MaterialPropertyBlock m_Block;

	private Material m_Material;

	private void Start()
	{
		m_meshRenderer = GetComponent<SkinnedMeshRenderer>();
		if (m_meshRenderer != null && m_meshRenderer.sharedMaterial != null)
		{
			m_Block = new MaterialPropertyBlock();
			m_Material = m_meshRenderer.sharedMaterial;
			NewEmmisionLogic = m_Material.GetFloat("_NewEmmisionLogic") > 0f;
			EmissionColor = m_Material.GetColor("_EmissionColor");
		}
	}

	private void Update()
	{
		if (m_meshRenderer == null)
		{
			Start();
		}
		if (KAnim)
		{
			m_Block = new MaterialPropertyBlock();
			if (NewEmmisionLogic)
			{
				m_Block.SetFloat("_NewEmmisionLogic", 1f);
				m_Block.SetColor("_EmissionColor", EmissionColor);
			}
			else
			{
				m_Block.SetFloat("_NewEmmisionLogic", 0f);
			}
			m_meshRenderer.SetPropertyBlock(m_Block);
		}
	}
}
