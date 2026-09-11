using System;
using UnityEngine;

namespace P08.Gamepad;

internal class PressTrigger : IInputActionTrigger
{
	public enum ETriggerBehavior
	{
		PressOnly,
		ReleaseOnly,
		PressAndRelease
	}

	public ETriggerBehavior behavior = ETriggerBehavior.ReleaseOnly;

	private bool _waitingForRelease;

	private bool _isStarted;

	private float _lastAxisValue;

	public void Process(ref InputActionTriggerContext context)
	{
		En_ButtonType buttonType = context.binding.buttonType;
		GetKeyState(buttonType, out var isPressed, out var isRelease);
		if (!_isStarted & isPressed)
		{
			context.Started();
			_isStarted = true;
		}
		if (!_isStarted)
		{
			return;
		}
		switch (behavior)
		{
		case ETriggerBehavior.PressOnly:
			if (isPressed)
			{
				context.Performed();
				_waitingForRelease = true;
			}
			else if (isRelease)
			{
				_waitingForRelease = false;
			}
			break;
		case ETriggerBehavior.ReleaseOnly:
			if (isRelease)
			{
				context.Performed();
				_waitingForRelease = false;
			}
			break;
		case ETriggerBehavior.PressAndRelease:
			if (isPressed)
			{
				context.Performed();
				_waitingForRelease = true;
			}
			else if (isRelease)
			{
				context.Performed();
				_waitingForRelease = false;
			}
			break;
		}
		if (isRelease && _isStarted)
		{
			context.Canceled();
			_isStarted = false;
			_lastAxisValue = 0f;
		}
	}

	public void Reset(ref InputActionTriggerContext context)
	{
		if (_isStarted)
		{
			context.Canceled();
			_waitingForRelease = false;
			_isStarted = false;
			_lastAxisValue = 0f;
		}
	}

	private void GetKeyState(En_ButtonType buttonType, out bool isPressed, out bool isRelease)
	{
		if (GamepadManager.Instance.IsRuntime())
		{
			isPressed = Gamepad.GetKeyDown(buttonType);
			isRelease = Gamepad.GetKeyUp(buttonType);
			return;
		}
		string mappedKey = HIDInputRemap.GetMappedKey(buttonType);
		if (string.IsNullOrEmpty(mappedKey))
		{
			isPressed = false;
			isRelease = false;
			return;
		}
		if (Enum.TryParse<KeyCode>(mappedKey, out var result))
		{
			isPressed = GamepadManager.GetKeyCodeDown(result);
			isRelease = GamepadManager.GetKeyCodeUp(result);
			return;
		}
		try
		{
			float axisValue = GamepadManager.GetAxisValue(mappedKey.GetHashCode());
			axisValue = Mathf.Abs(axisValue);
			isPressed = (double)_lastAxisValue < 0.5 && (double)axisValue > 0.5;
			isRelease = (double)_lastAxisValue > 0.5 && (double)axisValue < 0.5;
			_lastAxisValue = axisValue;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			isPressed = false;
			isRelease = false;
		}
	}
}
