using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MultiPostureBar : UIBehaviour
{
	public MultiPostureBarPart prefab;

	private float[] m_partValues;

	private List<MultiPostureBarPart> m_parts = new List<MultiPostureBarPart>();

	private float m_value;

	private bool m_locked;

	public void InitValues(float[] partValues, int characterDamageType)
	{
		m_partValues = partValues;
		while (m_parts.Count < m_partValues.Length)
		{
			MultiPostureBarPart component = Object.Instantiate(prefab.gameObject, transform).GetComponent<MultiPostureBarPart>();
			component.gameObject.SetActive(value: true);
			component.lockedIcon.SetActive(m_locked);
			m_parts.Add(component);
		}
		for (int i = 0; i < m_parts.Count; i++)
		{
			m_parts[i].bar.CharacterDamageType = characterDamageType;
			if (i < m_partValues.Length)
			{
				m_parts[i].GetComponent<LayoutElement>().flexibleWidth = ((i == 0) ? m_partValues[i] : (m_partValues[i] - m_partValues[i - 1]));
			}
			else
			{
				m_parts[i].gameObject.SetActive(value: false);
			}
		}
	}

	public void SetCharacterDamageType(int characterDamageType)
	{
		for (int i = 0; i < m_parts.Count; i++)
		{
			m_parts[i].bar.CharacterDamageType = characterDamageType;
		}
	}

	public void SetValue(float value)
	{
		value = Mathf.Clamp01(value);
		if (Mathf.Approximately(m_value, value))
		{
			return;
		}
		m_value = value;
		int partIndex = GetPartIndex(m_value);
		for (int i = 0; i < m_parts.Count; i++)
		{
			if (i >= m_partValues.Length)
			{
				m_parts[i].gameObject.SetActive(value: false);
			}
			else if (i > partIndex)
			{
				m_parts[i].bar.OnPostureChange(0f, inWeak: false);
			}
			else if (i < partIndex)
			{
				m_parts[i].bar.OnPostureChange(1f, inWeak: false);
			}
			else if (i == partIndex)
			{
				float num = m_value - ((i == 0) ? 0f : m_partValues[i - 1]);
				float num2 = m_partValues[i] - ((i == 0) ? 0f : m_partValues[i - 1]);
				m_parts[i].bar.OnPostureChange(num / num2, inWeak: false);
			}
		}
	}

	public void SetLock(bool locked)
	{
		if (m_locked == locked)
		{
			return;
		}
		m_locked = locked;
		int partIndex = GetPartIndex(m_value);
		for (int i = 0; i < m_parts.Count; i++)
		{
			if (i > partIndex)
			{
				continue;
			}
			int tmpIndex = i;
			if (m_locked)
			{
				m_parts[i].animation.GetSequence("ShieldLock").OnComplete((AnimationBuilder _) =>
				{
					m_parts[tmpIndex].animation.GetSequence("ShieldBreath").SetLoops(-1).Play();
				}).Play();
			}
			else
			{
				m_parts[i].animation.GetSequence("ShieldUnlock").Play();
			}
		}
	}

	private int GetPartIndex(float value)
	{
		if (Mathf.Approximately(value, 1f))
		{
			return m_parts.Count - 1;
		}
		for (int i = 0; i < m_partValues.Length; i++)
		{
			if (value > ((i == 0) ? 0f : m_partValues[i - 1]) && value < m_partValues[i])
			{
				return i;
			}
		}
		return -1;
	}
}
