using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace P08.Gamepad;

public class GamepadUIButton : MonoBehaviour
{
	public Button m_button;

	public En_ButtonType m_buttonType;

	private bool _init;

	private bool _block = true;

	private List<CanvasGroup> _parentCanvasGroups = new List<CanvasGroup>(3);

	private void Awake()
	{
		_init = m_buttonType != En_ButtonType.None;
		_block = true;
		_parentCanvasGroups.Clear();
		Transform parent = base.transform;
		while (parent != null)
		{
			CanvasGroup component = parent.GetComponent<CanvasGroup>();
			if (component != null)
			{
				_parentCanvasGroups.Add(component);
				if (component.ignoreParentGroups)
				{
					break;
				}
			}
			parent = parent.parent;
		}
	}

	private void OnCanvasGroupChanged()
	{
		if (!_init)
		{
			return;
		}
		_block = true;
		foreach (CanvasGroup parentCanvasGroup in _parentCanvasGroups)
		{
			if (!parentCanvasGroup.blocksRaycasts)
			{
				_block = false;
				break;
			}
		}
	}

	private void Update()
	{
		if (_init && _block && Gamepad.GetKeyUp(m_buttonType))
		{
			onKeyUp();
		}
	}

	private void onKeyUp()
	{
		if (m_button != null)
		{
			m_button.onClick.Invoke();
		}
	}
}
