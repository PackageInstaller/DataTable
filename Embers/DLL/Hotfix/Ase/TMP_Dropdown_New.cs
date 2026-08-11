using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class TMP_Dropdown_New : TMP_Dropdown
{
	private GameObject m_Dropdown_New;

	private Action<List<GameObject>> onDropdownShow;

	private Action onDropdownHide;

	public override void OnPointerClick(PointerEventData eventData)
	{
		((TMP_Dropdown)this).Show();
		onDropdownShow?.Invoke(GetDropdownItems());
	}

	protected override void DestroyBlocker(GameObject blocker)
	{
		((TMP_Dropdown)this).DestroyBlocker(blocker);
		onDropdownHide?.Invoke();
	}

	public override void OnSubmit(BaseEventData eventData)
	{
		((TMP_Dropdown)this).Show();
		onDropdownShow?.Invoke(GetDropdownItems());
	}

	protected override GameObject CreateDropdownList(GameObject template)
	{
		m_Dropdown_New = UnityEngine.Object.Instantiate(template);
		return m_Dropdown_New;
	}

	public void AddAction(Action<List<GameObject>> action)
	{
		onDropdownShow = action;
	}

	public void AddActionHide(Action action)
	{
		onDropdownHide = action;
	}

	public List<GameObject> GetDropdownItems()
	{
		if (m_Dropdown_New == null)
		{
			return null;
		}
		ScrollRect component = m_Dropdown_New.GetComponent<ScrollRect>();
		if (component == null)
		{
			return null;
		}
		List<GameObject> list = new List<GameObject>();
		int childCount = component.content.childCount;
		for (int i = 0; i < childCount; i++)
		{
			GameObject gameObject = component.content.GetChild(i).gameObject;
			if (gameObject.activeSelf)
			{
				list.Add(gameObject);
			}
		}
		return list;
	}
}
