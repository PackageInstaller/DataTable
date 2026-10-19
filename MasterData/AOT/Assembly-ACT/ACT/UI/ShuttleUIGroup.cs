using System.Collections.Generic;
using ACT.Event;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ShuttleUIGroup : MonoBehaviour, IBattleMainComponent
{
	private ShuttleUIGroup _shuttleGroup;

	public GameObject cellPrefab;

	public Transform content;

	private List<ShuttleUICell> m_Cells = new List<ShuttleUICell>();

	public void Initialize(MonoBattleMainBaseView view)
	{
		_shuttleGroup = gameObject.GetComponent<ShuttleUIGroup>();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ShuttleUpdate, OnShuttleUpdate);
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_ShuttleUpdate, OnShuttleUpdate);
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void OnShuttleUpdate(BaseEventContent evt)
	{
		UIShuttleUpdateEvent uIShuttleUpdateEvent = evt as UIShuttleUpdateEvent;
		_shuttleGroup.Refresh(uIShuttleUpdateEvent.count, uIShuttleUpdateEvent.maxCount, uIShuttleUpdateEvent.breakLimit);
	}

	public void Refresh(int count, int maxCount, bool breakLimit)
	{
		int num = maxCount - m_Cells.Count;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				ShuttleUICell item = UIUtility.AddWidget<ShuttleUICell>(content, cellPrefab);
				m_Cells.Add(item);
			}
		}
		int num2 = (breakLimit ? (count - maxCount) : 0);
		for (int j = 0; j < m_Cells.Count; j++)
		{
			m_Cells[j].gameObject.SetActive(j < maxCount);
			m_Cells[j].fillImage.gameObject.SetActive(j < count);
			m_Cells[j].burstImage.gameObject.SetActive(j < num2);
		}
	}
}
