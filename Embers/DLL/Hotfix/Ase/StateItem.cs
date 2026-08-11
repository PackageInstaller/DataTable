#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Serialization;

namespace Ase;

public class StateItem : MonoBehaviour, IPointerUpHandler, IEventSystemHandler
{
	public class ButtonClickedEvent : UnityEvent
	{
	}

	public bool activeAtLast;

	public List<StateItemConfig> stateConfigs;

	private int curState;

	[FormerlySerializedAs("onClick")]
	[SerializeField]
	private ButtonClickedEvent m_OnClick = new ButtonClickedEvent();

	public int CurState
	{
		get
		{
			return curState;
		}
		set
		{
			curState = value;
			UpdateStateItem();
		}
	}

	public ButtonClickedEvent onClick
	{
		get
		{
			return m_OnClick;
		}
		set
		{
			m_OnClick = value;
		}
	}

	private void UpdateStateItem()
	{
		if (activeAtLast)
		{
			ActiveAtLast();
			return;
		}
		foreach (StateItemConfig stateConfig in stateConfigs)
		{
			if (stateConfig == null)
			{
				Log.Error("StateItem引用丢失，请检查！");
			}
			else if (stateConfig.stateId == curState)
			{
				stateConfig.gameObject.SetActive(value: true);
			}
			else
			{
				stateConfig.gameObject.SetActive(value: false);
			}
		}
	}

	private void ActiveAtLast()
	{
		List<int> list = new List<int>();
		for (int i = 0; i < stateConfigs.Count; i++)
		{
			if (!(stateConfigs[i] == null))
			{
				if (stateConfigs[i].stateId == curState)
				{
					list.Add(i);
				}
				else
				{
					stateConfigs[i].gameObject.SetActive(value: false);
				}
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			stateConfigs[list[j]].gameObject.SetActive(value: true);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		m_OnClick.Invoke();
	}
}
