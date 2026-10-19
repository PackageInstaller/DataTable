using System;
using System.Collections.Generic;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.InputSystem;

namespace ACT.LocalLoader;

public class GameStartMessageBtnSelector : MonoBehaviour
{
	[SerializeField]
	private List<GameStartMessageBtnSelectMark> _selectItems = new List<GameStartMessageBtnSelectMark>();

	private List<GameStartMessageBtnSelectMark> _activeSelectorItems;

	public GameStartMessageBtnSelectMark CurrentSelect { get; private set; }

	public static bool GamepadInteractable { get; private set; } = true;

	public static void SetGamepadInteractable(bool interactable)
	{
		GamepadInteractable = interactable;
	}

	public void ClickCurrentByGamepad()
	{
		if (GamepadInteractable)
		{
			CurrentSelect?.Click();
		}
	}

	public void SelectPrev()
	{
		ChangeSelection(-1);
	}

	public void SelectNext()
	{
		ChangeSelection(1);
	}

	public void UpdateSelectionMode()
	{
		if (_activeSelectorItems == null)
		{
			_activeSelectorItems = new List<GameStartMessageBtnSelectMark>();
		}
		_activeSelectorItems.Clear();
		foreach (GameStartMessageBtnSelectMark selectItem in _selectItems)
		{
			if (selectItem.ButtonIsActive())
			{
				_activeSelectorItems.Add(selectItem);
			}
		}
		ClearAll();
		if (GamepadInteractable)
		{
			ChangeSelection(0);
		}
	}

	private void ChangeSelection(int offset)
	{
		if (GamepadInteractable && enabled && _activeSelectorItems != null && _activeSelectorItems.Count != 0)
		{
			int num = ((!(CurrentSelect == null)) ? _activeSelectorItems.IndexOf(CurrentSelect) : 0);
			int index = Math.Max(0, Math.Min(_activeSelectorItems.Count - 1, num + offset));
			GameStartMessageBtnSelectMark gameStartMessageBtnSelectMark = _activeSelectorItems[index];
			if (gameStartMessageBtnSelectMark != CurrentSelect)
			{
				CurrentSelect?.Hide();
				CurrentSelect = gameStartMessageBtnSelectMark;
			}
			CurrentSelect.Show();
		}
	}

	private void OnDisable()
	{
		ClearAll();
	}

	private void ClearAll()
	{
		foreach (GameStartMessageBtnSelectMark selectItem in _selectItems)
		{
			selectItem.Hide();
		}
		CurrentSelect = null;
	}

	public void UpdateDevice(InputDevice device)
	{
		if (this.SafeIsUnityNull())
		{
			return;
		}
		bool markVisible = device is Gamepad;
		foreach (GameStartMessageBtnSelectMark selectItem in _selectItems)
		{
			selectItem.SetMarkVisible(markVisible);
		}
	}
}
