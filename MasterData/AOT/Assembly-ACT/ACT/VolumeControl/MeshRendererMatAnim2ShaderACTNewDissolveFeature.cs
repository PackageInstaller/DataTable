using UnityEngine;

namespace ACT.VolumeControl;

[ExecuteInEditMode]
[AddComponentMenu("2美术工具/ShaderACTNewDissolveFeature 的 MeshRenderer K动画")]
public class MeshRendererMatAnim2ShaderACTNewDissolveFeature : MonoBehaviour
{
	public bool KAnim;

	[ColorUsage(true, true)]
	public Color color;

	private MeshRenderer m_meshRenderer;

	private MaterialPropertyBlock m_Block;

	private Material m_Material;

	private void Start()
	{
		m_meshRenderer = GetComponent<MeshRenderer>();
		if (m_meshRenderer != null && m_meshRenderer.sharedMaterial != null)
		{
			m_Block = new MaterialPropertyBlock();
			m_Material = m_meshRenderer.sharedMaterial;
			color = m_Material.GetColor("_Color");
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
			m_Block.SetColor("_Color", color);
			m_meshRenderer.SetPropertyBlock(m_Block);
		}
	}
}
