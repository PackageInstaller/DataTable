using System;
using UnityEngine;
using UnityEngine.UI;

public class QTEButtonEffect : MonoBehaviour
{
	public GameObject QteEffect;

	public Image m_UniqueFlag;

	public Image m_UniqueBar;

	public double m_StartAmount = 0.25;

	private void Awake()
	{
		AbilityButtonsUI componentInParent = GetComponentInParent<AbilityButtonsUI>();
		componentInParent.OnValidQTE = (Action<bool>)Delegate.Combine(componentInParent.OnValidQTE, new Action<bool>(OnValidQTE));
		componentInParent.OnUniqueValueChanged = (Action<int, int>)Delegate.Combine(componentInParent.OnUniqueValueChanged, new Action<int, int>(OnUniqueValueChanged));
	}

	private void OnValidQTE(bool haveQTE)
	{
		if (QteEffect.gameObject.activeSelf != haveQTE)
		{
			QteEffect.gameObject.SetActive(haveQTE);
		}
		if (haveQTE)
		{
			m_UniqueFlag.enabled = true;
			m_UniqueBar.fillAmount = 1f;
		}
	}

	private void OnUniqueValueChanged(int value, int maxValue)
	{
		if (m_UniqueBar != null)
		{
			maxValue = ((maxValue <= 0) ? 1 : maxValue);
			m_UniqueFlag.enabled = value >= maxValue;
			m_UniqueBar.fillAmount = (float)(m_StartAmount + (double)value * 1.0 / (double)maxValue * (1.0 - m_StartAmount));
		}
	}
}
