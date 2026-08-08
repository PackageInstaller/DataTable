using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EffectLevel : MonoBehaviour
{
	public List<GameObject> EffectSources;

	public int EnableCount = -1;

	public bool Reverse;

	public List<Image> Effects;

	public int Level;

	public List<int> m_controlOnLevel = new List<int>();

	private void OnEnable()
	{
	}

	public void InitEffectSourcesCount(int enableCount)
	{
		if (enableCount <= -1 || EffectSources == null || EffectSources.Count <= 0)
		{
			return;
		}
		int enableCount2 = Mathf.Min(enableCount, EffectSources.Count);
		EnableCount = enableCount2;
		for (int i = 0; i < EffectSources.Count; i++)
		{
			if (EffectSources[i] != null)
			{
				EffectSources[i].SetActive(i < enableCount);
			}
		}
	}

	public void PlayLevel(int level)
	{
	}

	public void UpdateChargingCD(int chargeCount, float current, float max)
	{
		float num = 0.333f;
		float num2 = 0f;
		float num3 = (num - num2) / 3f;
		int count = Effects.Count;
		for (int i = 0; i < count; i++)
		{
			if (i < chargeCount)
			{
				Effects[i].fillAmount = num;
			}
			else if (i == chargeCount)
			{
				Effects[i].fillAmount = num2 + num3 * (float)i + num3 * (1f - current / max);
			}
			else
			{
				Effects[i].fillAmount = num2;
			}
		}
	}
}
