using System.Collections.Generic;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class PublicToggleNonActive : PublicToggle
{
	private Dictionary<GameObject, Vector3> m_OriginPosition;

	protected override void Awake()
	{
		m_OriginPosition = DictionaryPool<GameObject, Vector3>.Get();
		foreach (GameObject item in On)
		{
			m_OriginPosition.TryAdd(item, item.transform.localPosition);
		}
		foreach (GameObject item2 in Off)
		{
			m_OriginPosition.TryAdd(item2, item2.transform.localPosition);
		}
		base.Awake();
	}

	protected override void OnDestroy()
	{
		DictionaryPool<GameObject, Vector3>.Release(m_OriginPosition);
		base.OnDestroy();
	}

	public override void InitToggle()
	{
		if (Application.isPlaying)
		{
			SetValue(isOn);
			onValueChanged.AddListener(SetValue);
		}
	}

	private void SetValue(bool b)
	{
		if (On != null && On.Count != 0)
		{
			foreach (GameObject item in On)
			{
				item.transform.localPosition = (b ? m_OriginPosition[item] : (Vector3.up * 10000f));
			}
		}
		if (b)
		{
			anim.GetSequence("Select").Play();
		}
		else
		{
			anim.GetSequence("SelectedHide").Play();
		}
		if (Off == null || Off.Count == 0)
		{
			return;
		}
		foreach (GameObject item2 in Off)
		{
			item2.transform.localPosition = (b ? (Vector3.up * 10000f) : m_OriginPosition[item2]);
		}
	}
}
