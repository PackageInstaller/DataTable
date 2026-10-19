using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ActIndexGroup : UIBehaviour
{
	[SerializeField]
	private GameObject indexPrefab;

	[SerializeField]
	private RectTransform content;

	protected List<ActIndex> m_Indexes = new List<ActIndex>();

	private int totalCount;

	private int curIndex = -1;

	private const int invalidIndex = -1;

	public void Init(int totalCount)
	{
		this.totalCount = totalCount;
		curIndex = -1;
		int num = totalCount - m_Indexes.Count;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				ActIndex component = Object.Instantiate(indexPrefab, content).GetComponent<ActIndex>();
				m_Indexes.Add(component);
			}
		}
		else if (num < 0)
		{
			for (int j = 0; j < Mathf.Abs(num); j++)
			{
				Object.Destroy(m_Indexes[totalCount + j].gameObject);
			}
			m_Indexes.RemoveRange(totalCount, Mathf.Abs(num));
		}
		foreach (ActIndex index in m_Indexes)
		{
			index.SetStateInstant(value: false);
		}
	}

	public void UnInit()
	{
		foreach (ActIndex index in m_Indexes)
		{
			Object.Destroy(index.gameObject);
		}
		m_Indexes.Clear();
		curIndex = -1;
	}

	public void SetToIndex(int index)
	{
		if (index < 0 || index >= m_Indexes.Count)
		{
			return;
		}
		curIndex = index;
		for (int i = 0; i < m_Indexes.Count; i++)
		{
			if (i == index)
			{
				m_Indexes[i].SetStateWithAnimation(value: true);
			}
			else
			{
				m_Indexes[i].SetStateWithAnimation(value: false);
			}
		}
	}

	public void SetToNextIndex()
	{
		if (curIndex != -1)
		{
			SetToIndex(curIndex + 1);
		}
	}

	public void SetToPreIndex()
	{
		if (curIndex != -1)
		{
			SetToIndex(curIndex - 1);
		}
	}
}
