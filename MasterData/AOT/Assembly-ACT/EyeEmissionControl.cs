using UnityEngine;

[ExecuteAlways]
public class EyeEmissionControl : MonoBehaviour
{
	private static readonly int EyeEmissionId = Shader.PropertyToID("_EyeEmission");

	private Renderer m_Renderer;

	private MaterialPropertyBlock m_PropertyBlock;

	public Material material;

	public int MaterialIndex;

	[ColorUsage(true, true)]
	public Color EyeEmissionColor = Color.black;

	private void Start()
	{
		CacheRuntimeData();
	}

	private void Update()
	{
		CacheRuntimeData();
		if (m_Renderer != null)
		{
			m_PropertyBlock.Clear();
			m_Renderer.GetPropertyBlock(m_PropertyBlock, MaterialIndex);
			m_PropertyBlock.SetColor(EyeEmissionId, EyeEmissionColor);
			m_Renderer.SetPropertyBlock(m_PropertyBlock, MaterialIndex);
		}
		if (material != null)
		{
			material.SetColor(EyeEmissionId, EyeEmissionColor);
		}
	}

	private void OnDisable()
	{
		CacheRuntimeData();
		if (m_Renderer != null)
		{
			m_PropertyBlock.Clear();
			m_Renderer.GetPropertyBlock(m_PropertyBlock, MaterialIndex);
			m_PropertyBlock.SetColor(EyeEmissionId, Color.black);
			m_Renderer.SetPropertyBlock(m_PropertyBlock, MaterialIndex);
		}
		if (material != null)
		{
			material.SetColor(EyeEmissionId, Color.black);
		}
	}

	private void CacheRuntimeData()
	{
		if (m_Renderer == null)
		{
			m_Renderer = GetComponent<Renderer>();
		}
		if (m_PropertyBlock == null)
		{
			m_PropertyBlock = new MaterialPropertyBlock();
		}
	}
}
