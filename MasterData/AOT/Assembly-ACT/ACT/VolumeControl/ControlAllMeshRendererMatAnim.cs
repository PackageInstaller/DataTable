using UnityEngine;

namespace ACT.VolumeControl;

[ExecuteInEditMode]
[AddComponentMenu("2美术工具/批量给一批obj的MeshRendererK动画")]
public class ControlAllMeshRendererMatAnim : MonoBehaviour
{
	public MeshRenderer[] meshRenderers;

	public bool KAnim;

	public float DitherValue;

	private MaterialPropertyBlock[] m_Blocks;

	private Material[] m_Materials;

	private MaterialPropertyBlock m_Block;

	private Material m_Material;

	private void Start()
	{
		meshRenderers = GetComponentsInChildren<MeshRenderer>();
		for (int i = 0; i < meshRenderers.Length; i++)
		{
			if (meshRenderers[i] != null && meshRenderers[i].sharedMaterial != null)
			{
				m_Block = new MaterialPropertyBlock();
				m_Material = meshRenderers[i].sharedMaterial;
			}
		}
	}

	private void Update()
	{
		if (KAnim)
		{
			for (int i = 0; i < meshRenderers.Length; i++)
			{
				m_Block = new MaterialPropertyBlock();
				m_Block.SetFloat("_DitherValue", DitherValue);
				meshRenderers[i].SetPropertyBlock(m_Block);
			}
		}
	}
}
