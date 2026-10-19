using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.UI;

namespace ACT.LocalLoader;

internal class GameStartInputController
{
	private InputSystemUIInputModule _inputModule;

	private List<InputAction> _watchedInputActions;

	private GameStart _gameStart;

	private MonoHotUpdate _hotUpdateView;

	private MonoMessageBox _messageBox;

	private GameStartMessageBtnSelector _messageBtnSelector;

	private GameStartMessageBtnSelector _downloadBtnSelector;

	private List<GameStartPressButtonPrompt> _buttonPrompts;

	private InputDevice _activeDevice;

	private bool _isReleased;

	private readonly List<InputAction> _inputActions = new List<InputAction>();

	private readonly Dictionary<InputAction, bool> _inputActionValueCache = new Dictionary<InputAction, bool>();

	private readonly Dictionary<InputAction, Action<bool>> _inputActionCallbackCache = new Dictionary<InputAction, Action<bool>>();

	public void Init(GameStart gs)
	{
		GameObject gameObject = gs.gameObject;
		_gameStart = gs;
		_hotUpdateView = gs.hotUpdateView;
		_downloadBtnSelector = _hotUpdateView.downloadBtnSelector;
		_messageBox = gs.messageBox;
		_messageBtnSelector = _messageBox.btnSelector;
		_buttonPrompts = new List<GameStartPressButtonPrompt>();
		_buttonPrompts.AddRange(gameObject.GetComponentsInChildren<GameStartPressButtonPrompt>(includeInactive: true));
		if (!(gameObject.GetComponentInChildren<BaseInputModule>() is InputSystemUIInputModule inputModule))
		{
			return;
		}
		_inputModule = inputModule;
		InputActionAsset actionsAsset = _inputModule.actionsAsset;
		BindingAction(actionsAsset.FindAction("UI/Back"), HandleBack);
		BindingAction(actionsAsset.FindAction("UI/Confirm"), HandleQuitConfirm);
		BindingAction(actionsAsset.FindAction("UI/Next"), HandleNext);
		BindingAction(actionsAsset.FindAction("UI/Prev"), HandlePrev);
		BindingAction(actionsAsset.FindAction("Login/Account"), HandleAccount);
		BindingAction(actionsAsset.FindAction("Login/Billboard"), HandleAnnouncement);
		BindingAction(actionsAsset.FindAction("Login/AgeNotice"), HandleAgeNotice);
		_activeDevice = InputSystem.devices.FirstOrDefault((InputDevice d) => d.enabled && d.added);
		UpdatePromptIcons(_activeDevice);
		_watchedInputActions = new List<InputAction>();
		foreach (InputActionMap actionMap in actionsAsset.actionMaps)
		{
			actionMap.Enable();
			foreach (InputAction action in actionMap.actions)
			{
				_watchedInputActions.Add(action);
				action.performed += OnActionPerformed;
			}
		}
	}

	public void Release()
	{
		if (_isReleased)
		{
			return;
		}
		_isReleased = true;
		foreach (InputAction watchedInputAction in _watchedInputActions)
		{
			watchedInputAction.performed -= OnActionPerformed;
		}
		_watchedInputActions.Clear();
		_inputActionValueCache.Clear();
		_inputActionCallbackCache.Clear();
		_inputModule.actionsAsset.Disable();
		PlayerInput component = _inputModule.GetComponent<PlayerInput>();
		if ((object)component != null)
		{
			component.DeactivateInput();
			component.enabled = false;
		}
		_buttonPrompts.Clear();
		_buttonPrompts = null;
		_messageBox = null;
		_gameStart = null;
		_hotUpdateView = null;
	}

	private void OnActionPerformed(InputAction.CallbackContext context)
	{
		InputDevice device = context.control.device;
		if (_activeDevice != device)
		{
			_activeDevice = device;
			UpdatePromptIcons(device);
		}
		InputAction action = context.action;
		if (_inputActions.Contains(action))
		{
			bool flag = context.ReadValueAsButton();
			if (_inputActionValueCache[action] != flag)
			{
				_inputActionValueCache[action] = flag;
				_inputActionCallbackCache[action](flag);
			}
		}
	}

	private void UpdatePromptIcons(InputDevice device)
	{
		List<GameStartPressButtonPrompt> buttonPrompts = _buttonPrompts;
		if (buttonPrompts != null && buttonPrompts.Count > 0)
		{
			foreach (GameStartPressButtonPrompt buttonPrompt in _buttonPrompts)
			{
				buttonPrompt.UpdateDevice(device);
			}
		}
		_messageBtnSelector?.UpdateDevice(device);
	}

	private void BindingAction(InputAction action, Action<bool> callback)
	{
		_inputActions.Add(action);
		_inputActionValueCache[action] = false;
		_inputActionCallbackCache[action] = callback;
	}

	private bool CanOpenNext()
	{
		if (_gameStart.inLoginView || _messageBtnSelector.gameObject.activeInHierarchy || _downloadBtnSelector.gameObject.activeInHierarchy || _hotUpdateView.announcement.gameObject.activeInHierarchy || _hotUpdateView.ageNotice.activeInHierarchy)
		{
			return false;
		}
		return true;
	}

	private void HandleNext(bool pressed)
	{
		if (!_isReleased)
		{
			Debug.Log($"HandleNext: {pressed}");
			if (!pressed && _messageBtnSelector.gameObject.activeInHierarchy)
			{
				_messageBtnSelector.SelectNext();
			}
		}
	}

	private void HandlePrev(bool pressed)
	{
		if (!_isReleased)
		{
			Debug.Log($"HandlePrev: {pressed}");
			if (!pressed && _messageBtnSelector.gameObject.activeInHierarchy)
			{
				_messageBtnSelector.SelectPrev();
			}
		}
	}

	private void HandleBack(bool pressed)
	{
		if (_isReleased)
		{
			return;
		}
		Debug.Log($"HandleBack: {pressed}");
		if (!pressed)
		{
			if (_hotUpdateView.announcement.gameObject.activeInHierarchy)
			{
				_hotUpdateView.CloseNotice();
			}
			else if (_hotUpdateView.ageNotice.activeInHierarchy)
			{
				_hotUpdateView.CloseAgeNotice();
			}
			else if (_messageBtnSelector.gameObject.activeInHierarchy)
			{
				_messageBox.OnClick2();
			}
			else if (CanOpenNext())
			{
				_hotUpdateView.QuitGameBtn();
			}
		}
	}

	private void HandleQuitConfirm(bool pressed)
	{
		if (!_isReleased)
		{
			Debug.Log($"HandleQuitConfirm: {pressed}");
			if (!pressed && _messageBox.isActiveAndEnabled)
			{
				_messageBox.btnSelector.ClickCurrentByGamepad();
			}
		}
	}

	private void HandleAccount(bool pressed)
	{
		if (!_isReleased)
		{
			Debug.Log($"HandleAccount: {pressed}");
			if (!pressed && CanOpenNext())
			{
				_hotUpdateView.SDKLoginOrOutBtn();
			}
		}
	}

	private void HandleAnnouncement(bool pressed)
	{
		if (!_isReleased)
		{
			Debug.Log($"HandleAnnouncement: {pressed}");
			if (!pressed && CanOpenNext())
			{
				_hotUpdateView.NoticeBtn();
			}
		}
	}

	private void HandleAgeNotice(bool pressed)
	{
		if (!_isReleased)
		{
			Debug.Log($"HandleAgeNotice: {pressed}");
			if (!pressed && CanOpenNext())
			{
				_hotUpdateView.AgeNoticeBtn();
			}
		}
	}
}
