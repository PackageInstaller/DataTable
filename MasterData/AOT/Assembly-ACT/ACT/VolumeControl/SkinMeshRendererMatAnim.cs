using UnityEngine;

namespace ACT.VolumeControl;

[ExecuteInEditMode]
[AddComponentMenu("2美术工具/ToonCharacter的SkinMeshRenderer/K溶解渐隐动画")]
public class SkinMeshRendererMatAnim : MonoBehaviour
{
	public bool KAnim;

	public bool DissolveGroup;

	[ColorUsage(true, true)]
	public Color DissolveEmmision;

	[Range(0f, 1f)]
	public float DissolveThreshold;

	[ColorUsage(true, true)]
	public Color FresnelColor;

	[Range(0f, 1f)]
	public float FresnelRange;

	[Range(0f, 1f)]
	public float FresnelSmooth;

	private Renderer m_Renderer;

	private MaterialPropertyBlock m_Block;

	private Material m_Material;

	public void Start()
	{
		m_Renderer = GetComponent<Renderer>();
		if (m_Renderer != null && m_Renderer.sharedMaterial != null)
		{
			if (m_Block == null)
			{
				m_Block = new MaterialPropertyBlock();
			}
			m_Material = m_Renderer.sharedMaterial;
			DissolveGroup = m_Material.GetFloat("_DissolveGroup") > 0f;
			DissolveEmmision = m_Material.GetColor("_DissolveColor");
			DissolveThreshold = m_Material.GetFloat("_DissolveThreshold");
			FresnelColor = m_Material.GetColor("_FresnelColor");
			FresnelRange = m_Material.GetFloat("_FresnelRange");
			FresnelSmooth = m_Material.GetFloat("_FresnelSmooth");
		}
	}

	public void Update()
	{
		if (m_Renderer == null)
		{
			Start();
		}
		if (KAnim && m_Renderer != null)
		{
			m_Block.Clear();
			m_Renderer.GetPropertyBlock(m_Block);
			if (DissolveGroup)
			{
				m_Block.SetFloat("_DissolveGroup", 1f);
				m_Block.SetColor("_DissolveColor", DissolveEmmision);
				m_Block.SetFloat("_DissolveThreshold", DissolveThreshold);
			}
			else
			{
				m_Block.SetFloat("_DissolveGroup", 0f);
			}
			m_Block.SetColor("_FresnelColor", FresnelColor);
			m_Block.SetFloat("_FresnelRange", FresnelRange);
			m_Block.SetFloat("_FresnelSmooth", FresnelSmooth);
			m_Renderer.SetPropertyBlock(m_Block);
		}
	}
}
