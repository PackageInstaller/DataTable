using UnityEngine;
using UnityEngine.Rendering.Universal;

[DefaultExecutionOrder(500)]
public class DissolveControl : MonoBehaviour
{
	public bool UseUV3;

	public bool UseXDir;

	public bool InvertDir;

	public float ScanLineControl = -0.3f;

	public Vector4 NoiseControl1 = new Vector4(100f, 20f, 0f, 0f);

	public Vector4 NoiseControl2 = new Vector4(60f, 40f, 0f, 0f);

	[Range(0f, 1f)]
	public float LineScale = 0.1f;

	[Range(0f, 1f)]
	public float LinePower;

	[Range(0f, 1f)]
	public float ScanRange = 0.04f;

	public float ScanNoiseSize = 7.2f;

	public float ScanNoisePower = 0.08f;

	[ColorUsage(true, true)]
	public Color DissloveEmmision1 = new Color(0.423f, 4f, 0f, 1f);

	[ColorUsage(true, true)]
	public Color DissloveEmmision2 = new Color(5.278f, 0f, 0f, 1f);

	[Range(0f, 1f)]
	public float HueShift;

	[Range(0f, 1f)]
	public float NoiseOffsetWithScan;

	[Range(0f, 1f)]
	public float ScanNoiseType = 0.6f;

	private Renderer[] m_Renderers;

	private MaterialPropertyBlock m_Block;

	private void OnEnable()
	{
		m_Renderers = GetComponentsInChildren<Renderer>();
		Renderer[] renderers = m_Renderers;
		foreach (Renderer renderer in renderers)
		{
			Material[] materials = renderer.materials;
			for (int j = 0; j < materials.Length; j++)
			{
				VisibilityMaterialKeywords.SetDissolve2Keyword(materials[j], enabled: true);
			}
			renderer.enabled = false;
		}
		if (m_Block == null)
		{
			m_Block = new MaterialPropertyBlock();
		}
	}

	private void Update()
	{
		Renderer[] renderers = m_Renderers;
		foreach (Renderer obj in renderers)
		{
			obj.enabled = true;
			m_Block.Clear();
			obj.GetPropertyBlock(m_Block);
			if (UseUV3)
			{
				m_Block.SetFloat("_UV2Dissolve2", 1f);
			}
			else
			{
				m_Block.SetFloat("_UV2Dissolve2", 0f);
			}
			m_Block.SetFloat("_ScanLine", ScanLineControl);
			obj.SetPropertyBlock(m_Block);
		}
	}

	private void OnDisable()
	{
		Renderer[] renderers = m_Renderers;
		for (int i = 0; i < renderers.Length; i++)
		{
			Material[] materials = renderers[i].materials;
			for (int j = 0; j < materials.Length; j++)
			{
				VisibilityMaterialKeywords.SetDissolve2Keyword(materials[j], enabled: false);
			}
		}
	}

	public void CharacterInitSet()
	{
		UseUV3 = true;
		UseXDir = false;
		InvertDir = false;
		ScanLineControl = 40f;
		NoiseControl1 = new Vector4(29.5f, 60.7f, 0f, 0f);
		NoiseControl2 = new Vector4(19f, 22.9f, 0f, 0f);
		LineScale = 0.088f;
		LinePower = 0.645f;
		ScanRange = 0.254f;
		ScanNoiseSize = 0.7f;
		ScanNoisePower = 0.3f;
		DissloveEmmision1 = new Color(0f, 192f / 255f, 2.996078f, 1f);
		DissloveEmmision2 = new Color(4.867144f, 0.6370607f, 0f, 1f);
		HueShift = 0.074f;
		NoiseOffsetWithScan = 0f;
		ScanNoiseType = 0.968f;
	}
}
