using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoErrorEffect : MonoBehaviour
{
	public Material material;

	public AnimationCurve curve;

	public float length;

	private float m_Timer;

	private Image m_Image;

	private Material m_LastMaterial;

	private bool m_Run;

	private static Material m_InstanceMat;

	private static readonly int OffSet = Shader.PropertyToID("_OffSet");

	private static readonly int RGBSplit = Shader.PropertyToID("_RGBSplit");

	private static readonly int Alpha = Shader.PropertyToID("_Alpha");

	private void Awake()
	{
		m_Image = GetComponent<Image>();
		if (!m_InstanceMat)
		{
			m_InstanceMat = Object.Instantiate(material);
		}
		length = curve.keys[curve.length - 1].time;
	}

	private void OnEnable()
	{
		m_LastMaterial = m_Image.material;
		m_Image.material = m_InstanceMat;
		m_Timer = GameManager.timeSystem.time;
		m_Run = true;
	}

	private void Update()
	{
		if (m_Run)
		{
			float num = GameManager.timeSystem.time - m_Timer;
			float num2 = curve.Evaluate(num);
			m_InstanceMat.SetVector(OffSet, new Vector4(num2, 1f));
			m_InstanceMat.SetFloat(RGBSplit, num2);
			m_InstanceMat.SetFloat(Alpha, num);
			if (num > length)
			{
				m_Run = false;
				m_Image.material = m_LastMaterial;
			}
		}
	}
}
