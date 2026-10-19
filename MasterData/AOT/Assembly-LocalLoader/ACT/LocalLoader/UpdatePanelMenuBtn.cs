using System;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.LocalLoader;

public class UpdatePanelMenuBtn : MonoBehaviour
{
	public Button btn;

	public GameObject on;

	public GameObject off;

	private bool m_IsOpen = true;

	public bool isOpen
	{
		get
		{
			return m_IsOpen;
		}
		set
		{
			m_IsOpen = value;
			if ((bool)on)
			{
				on.SetActive(isOpen);
			}
			if ((bool)off)
			{
				off.SetActive(!isOpen);
			}
		}
	}

	public void Init(Action callBack, bool openState = true)
	{
		if (!(btn == null))
		{
			isOpen = openState;
			btn.onClick.RemoveAllListeners();
			btn.onClick.AddListener(() =>
			{
				callBack?.Invoke();
			});
		}
	}

	public void RemoveListeners()
	{
		btn.onClick.RemoveAllListeners();
		btn.interactable = false;
	}
}
