using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

public class GamepadButton : MonoBehaviour
{
	public En_ButtonType m_buttonType;

	public P08AttackButton m_attackButton;

	public LockButton m_lockButton;

	public P08EXButton m_ExButton;

	private bool _init;

	private bool _block = true;

	private List<CanvasGroup> _parentCanvasGroups = new List<CanvasGroup>(3);

	private bool _press;

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
		if (!_init)
		{
			return;
		}
		if (_press && Gamepad.GetKeyUp(m_buttonType))
		{
			_press = false;
			if (m_attackButton != null)
			{
				m_attackButton.OnPointerUp(null);
			}
			if (m_lockButton != null)
			{
				m_lockButton.OnPointerUp(null);
			}
			if (m_ExButton != null)
			{
				m_ExButton.OnPointerUp(null);
			}
		}
		if (_block && !BattleScene.isPause && Gamepad.GetKeyDown(m_buttonType))
		{
			_press = true;
			if (m_attackButton != null)
			{
				m_attackButton.OnPointerDown(null);
			}
			if (m_lockButton != null)
			{
				m_lockButton.OnPointerDown(null);
			}
			if (m_ExButton != null)
			{
				m_ExButton.OnPointerDown(null);
			}
		}
	}
}
