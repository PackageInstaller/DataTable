using System.Collections;
using UnityEngine;

namespace Ase;

public class Cullable : MonoBehaviour
{
	public string m_shaderVariableName = "_Alpha";

	public float m_alphaChangeSpeed = 1f;

	public float m_fadeTo;

	public float m_fadeFrom = 1f;

	private float m_currentAlpha = 1f;

	private Material m_mat;

	private bool m_occluding;

	private bool m_inCoroutine;

	public bool InCoroutine => m_inCoroutine;

	public bool Occluding
	{
		get
		{
			return m_occluding;
		}
		set
		{
			m_occluding = value;
			OnOccludingChanged();
		}
	}

	private void OnOccludingChanged()
	{
		if (!m_inCoroutine)
		{
			m_inCoroutine = true;
			StartCoroutine("FadeAlphaRoutine");
		}
	}

	private void Start()
	{
		m_mat = GetComponent<Renderer>().material;
		m_currentAlpha = m_fadeFrom;
		base.gameObject.layer = LayerMask.NameToLayer("CullingObject");
	}

	public void SetOccludingValue(float value)
	{
		m_currentAlpha = value;
		m_mat.SetFloat(m_shaderVariableName, value);
	}

	private float GetTargetAlpha()
	{
		if (m_occluding)
		{
			return m_fadeTo;
		}
		return m_fadeFrom;
	}

	private IEnumerator FadeAlphaRoutine()
	{
		while (m_currentAlpha != GetTargetAlpha())
		{
			float num = m_alphaChangeSpeed * Time.deltaTime;
			float targetAlpha = GetTargetAlpha();
			if (m_currentAlpha < targetAlpha)
			{
				m_currentAlpha += num;
				if (m_currentAlpha > targetAlpha)
				{
					m_currentAlpha = targetAlpha;
				}
			}
			else
			{
				m_currentAlpha -= num;
				if (m_currentAlpha < targetAlpha)
				{
					m_currentAlpha = targetAlpha;
				}
			}
			m_mat.SetFloat(m_shaderVariableName, m_currentAlpha);
			yield return null;
		}
		m_inCoroutine = false;
	}
}
