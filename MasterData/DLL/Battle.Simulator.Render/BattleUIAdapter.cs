using System.Collections.Generic;
using UnityEngine;

public class BattleUIAdapter : MonoBehaviour
{
	public List<string> listToChange = new List<string>();

	public List<string> m_alphaList = new List<string>();

	public float m_alphaValue = 1f;

	private BattleUIAdapterData defaultData = new BattleUIAdapterData();

	public BattleUIAdapterData DecodeData(string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return null;
		}
		BattleUIAdapterData battleUIAdapterData = new BattleUIAdapterData();
		battleUIAdapterData.Deserialize(s);
		return battleUIAdapterData;
	}

	public void Set(string s, float alpha)
	{
		if (!string.IsNullOrEmpty(s))
		{
			BattleUIAdapterData battleUIAdapterData = new BattleUIAdapterData();
			battleUIAdapterData.Deserialize(s);
			SetData(battleUIAdapterData, alpha);
		}
	}

	public void SetData(BattleUIAdapterData adapterData, float alpha)
	{
		foreach (BattleUIAdapterData.Data data in adapterData.datas)
		{
			RectTransform rectTransform = base.transform.Find(data.path) as RectTransform;
			if (!(rectTransform == null))
			{
				rectTransform.anchoredPosition = data.offest;
				rectTransform.localScale = new Vector3(data.scale, data.scale, data.scale);
			}
		}
		foreach (string alpha2 in m_alphaList)
		{
			Transform transform = base.transform.Find(alpha2);
			if (!(transform == null))
			{
				transform.GetComponent<CanvasGroup>().alpha = alpha;
			}
		}
	}

	private void Awake()
	{
		defaultData.datas.Clear();
		foreach (string item in listToChange)
		{
			RectTransform rectTransform = base.transform.Find(item) as RectTransform;
			if (!(rectTransform == null))
			{
				BattleUIAdapterData.Data data = new BattleUIAdapterData.Data();
				data.path = item;
				data.offest = rectTransform.anchoredPosition;
				data.scale = rectTransform.localScale.x;
				defaultData.datas.Add(data);
			}
		}
	}

	public string Save()
	{
		BattleUIAdapterData battleUIAdapterData = new BattleUIAdapterData();
		foreach (string item in listToChange)
		{
			RectTransform rectTransform = base.transform.Find(item) as RectTransform;
			if (!(rectTransform == null))
			{
				BattleUIAdapterData.Data data = new BattleUIAdapterData.Data();
				data.path = item;
				data.offest = rectTransform.anchoredPosition;
				data.scale = rectTransform.localScale.x;
				battleUIAdapterData.datas.Add(data);
			}
		}
		return battleUIAdapterData.Serialize();
	}

	public void ResetToDefault()
	{
		SetData(defaultData, m_alphaValue);
	}
}
