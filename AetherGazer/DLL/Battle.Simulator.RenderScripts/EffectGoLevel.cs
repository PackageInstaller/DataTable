using System.Collections.Generic;
using UnityEngine;

public class EffectGoLevel : MonoBehaviour
{
	public List<GameObject> EffectSources;

	public int EnableCount = -1;

	public bool Reverse;

	public List<GameObject> Effects;

	public int Level;

	public List<int> m_controlOnLevel = new List<int>();

	private void OnEnable()
	{
		InitEffectSourcesCount(EnableCount);
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
		if (m_controlOnLevel.Count == 0)
		{
			return;
		}
		if (level == 0)
		{
			for (int i = 0; i < Effects.Count; i++)
			{
				Effects[i].SetActive(Reverse ? true : false);
			}
			return;
		}
		level--;
		level = Mathf.Clamp(level, 0, m_controlOnLevel.Count - 1);
		int num = m_controlOnLevel[level];
		for (int j = 0; j < Effects.Count; j++)
		{
			if (((num >> j) & 1) == 1)
			{
				Effects[j].SetActive(!Reverse);
			}
			else
			{
				Effects[j].SetActive(Reverse ? true : false);
			}
		}
	}
}
