using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class LoungeCharacterInteractionSubView : SubUIView<LoungeCharacterInteractionSubInputController>
{
	private readonly List<ActButton> _gamepadChoiceButtons = new List<ActButton>();

	private ActButton _closeUiButton;

	private int _gamepadSelectedIndex = -1;

	public LoungeMainView Owner { get; private set; }

	public bool HasGamepadChoices => _gamepadChoiceButtons.Count > 0;

	public void BindOwner(LoungeMainView owner)
	{
		Owner = owner;
	}

	protected override void OnFocusIn()
	{
		CacheCloseUiButton();
		WireCloseUiButton();
	}

	protected override void OnFocusOut()
	{
		UnwireCloseUiButton();
		ClearGamepadChoiceSelection();
	}

	public void OnInteractionChoicesReady()
	{
		RefreshGamepadChoiceButtons();
		RefreshGamepadChoicePrompts();
	}

	public void RefreshGamepadChoiceButtons()
	{
		_gamepadChoiceButtons.Clear();
		if (Owner?.ChoiceBtns == null)
		{
			_gamepadSelectedIndex = -1;
			return;
		}
		foreach (var choiceBtn in Owner.ChoiceBtns)
		{
			ActButton item = choiceBtn.Item1;
			if (item != null && item.gameObject.activeInHierarchy)
			{
				_gamepadChoiceButtons.Add(item);
			}
		}
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SelectFirstGamepadChoice();
		}
		else
		{
			ClearCurrentChoiceSelection();
		}
	}

	public void SelectFirstGamepadChoice()
	{
		if (_gamepadChoiceButtons.Count == 0)
		{
			_gamepadSelectedIndex = -1;
			EventSystemHelper.SetSelectedGameObject(null);
			RefreshGamepadChoicePrompts();
		}
		else
		{
			_gamepadSelectedIndex = 0;
			ApplyGamepadChoiceSelection();
		}
	}

	public bool EnsureFirstChoiceSelected()
	{
		if (_gamepadChoiceButtons.Count == 0)
		{
			_gamepadSelectedIndex = -1;
			RefreshGamepadChoicePrompts();
			return false;
		}
		if (_gamepadSelectedIndex >= 0 && _gamepadSelectedIndex < _gamepadChoiceButtons.Count)
		{
			return false;
		}
		_gamepadSelectedIndex = 0;
		ApplyGamepadChoiceSelection();
		return true;
	}

	public void MoveGamepadChoiceSelection(int direction)
	{
		if (_gamepadChoiceButtons.Count == 0 || direction == 0)
		{
			return;
		}
		if (_gamepadSelectedIndex < 0)
		{
			_gamepadSelectedIndex = 0;
		}
		else
		{
			_gamepadSelectedIndex += ((direction > 0) ? 1 : (-1));
			if (_gamepadSelectedIndex >= _gamepadChoiceButtons.Count)
			{
				_gamepadSelectedIndex = 0;
			}
			else if (_gamepadSelectedIndex < 0)
			{
				_gamepadSelectedIndex = _gamepadChoiceButtons.Count - 1;
			}
		}
		ApplyGamepadChoiceSelection();
	}

	public void ExecuteSelectedGamepadChoice()
	{
		if (_gamepadSelectedIndex < 0 || _gamepadSelectedIndex >= _gamepadChoiceButtons.Count)
		{
			return;
		}
		ActButton actButton = _gamepadChoiceButtons[_gamepadSelectedIndex];
		if (!(actButton == null) && actButton.gameObject.activeInHierarchy && actButton.interactable)
		{
			if (EventSystemHelper.Available)
			{
				ExecuteEvents.Execute(actButton.gameObject, new BaseEventData(EventSystemHelper.Shared), ExecuteEvents.submitHandler);
			}
			Owner?.ConsumeGamepadConfirmUntilRelease();
		}
	}

	private void ApplyGamepadChoiceSelection()
	{
		if (_gamepadSelectedIndex < 0 || _gamepadSelectedIndex >= _gamepadChoiceButtons.Count)
		{
			EventSystemHelper.SetSelectedGameObject(null);
			return;
		}
		GameObject gameObject = _gamepadChoiceButtons[_gamepadSelectedIndex].gameObject;
		if (EventSystemHelper.Available && EventSystemHelper.CurrentSelected != gameObject)
		{
			EventSystemHelper.SetSelectedGameObject(gameObject);
		}
		RefreshGamepadChoicePrompts();
	}

	public void RefreshGamepadChoicePrompts()
	{
		if (Owner?.ChoiceBtns == null)
		{
			return;
		}
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad && Owner.IsInteractionChoicePanelVisible && _gamepadChoiceButtons.Count > 0 && _gamepadSelectedIndex >= 0;
		ActButton actButton = null;
		if (flag)
		{
			actButton = _gamepadChoiceButtons[_gamepadSelectedIndex];
		}
		foreach (var choiceBtn in Owner.ChoiceBtns)
		{
			bool visible = flag && choiceBtn.Item1 == actButton;
			choiceBtn.Item2?.RefreshGamepadPromptA(visible);
		}
	}

	private void ClearGamepadChoiceSelection()
	{
		ClearCurrentChoiceSelection();
		_gamepadChoiceButtons.Clear();
	}

	private void ClearCurrentChoiceSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			foreach (ActButton gamepadChoiceButton in _gamepadChoiceButtons)
			{
				if (gamepadChoiceButton != null && gamepadChoiceButton.gameObject == currentSelected)
				{
					EventSystemHelper.SetSelectedGameObject(null);
					break;
				}
			}
		}
		_gamepadSelectedIndex = -1;
		RefreshGamepadChoicePrompts();
	}

	private void CacheCloseUiButton()
	{
		if (_closeUiButton != null)
		{
			return;
		}
		Transform[] componentsInChildren = GetComponentsInChildren<Transform>(includeInactive: true);
		foreach (Transform transform in componentsInChildren)
		{
			if (!(transform.name != "CloseUI"))
			{
				_closeUiButton = transform.GetComponent<ActButton>();
				if (_closeUiButton != null)
				{
					break;
				}
			}
		}
	}

	private void WireCloseUiButton()
	{
		if (!(_closeUiButton == null))
		{
			_closeUiButton.OnClick.RemoveListener(OnCloseUiClicked);
			_closeUiButton.OnClick.AddListener(OnCloseUiClicked);
		}
	}

	private void UnwireCloseUiButton()
	{
		if (!(_closeUiButton == null))
		{
			_closeUiButton.OnClick.RemoveListener(OnCloseUiClicked);
		}
	}

	private void OnCloseUiClicked()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			Owner?.ToggleInteractionChoicePanel();
		}
	}
}
