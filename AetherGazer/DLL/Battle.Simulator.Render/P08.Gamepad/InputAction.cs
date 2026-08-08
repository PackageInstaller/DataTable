using System;

namespace P08.Gamepad;

public class InputAction
{
	private bool _enabled;

	internal CallbackArray<Action<InputActionCallbackContext>> _onStarted;

	internal CallbackArray<Action<InputActionCallbackContext>> _onPerformed;

	internal CallbackArray<Action<InputActionCallbackContext>> _onCanceled;

	public string actionName { get; }

	public EInputConsumeType consumeType { get; }

	public bool showInBottomBar { get; }

	public bool enabled => _enabled;

	internal InputActionState state { get; }

	public bool hasCallback
	{
		get
		{
			if (_onStarted.length <= 0 && _onPerformed.length <= 0)
			{
				return _onCanceled.length > 0;
			}
			return true;
		}
	}

	public event Action<InputActionCallbackContext> started
	{
		add
		{
			_onStarted.AddCallback(value);
		}
		remove
		{
			_onStarted.RemoveCallback(value);
		}
	}

	public event Action<InputActionCallbackContext> performed
	{
		add
		{
			_onPerformed.AddCallback(value);
		}
		remove
		{
			_onPerformed.RemoveCallback(value);
		}
	}

	public event Action<InputActionCallbackContext> canceled
	{
		add
		{
			_onCanceled.AddCallback(value);
		}
		remove
		{
			_onCanceled.RemoveCallback(value);
		}
	}

	internal InputAction(InputActionRes res)
	{
		actionName = res.actionName;
		consumeType = res.consumeType;
		showInBottomBar = res.ShowInBottomBar;
		state = new InputActionState();
		_onStarted = new CallbackArray<Action<InputActionCallbackContext>>();
		_onPerformed = new CallbackArray<Action<InputActionCallbackContext>>();
		_onCanceled = new CallbackArray<Action<InputActionCallbackContext>>();
	}

	public void Enable()
	{
		if (!_enabled)
		{
			_enabled = true;
		}
	}

	public void Disable()
	{
		if (_enabled)
		{
			_enabled = false;
		}
	}

	public void EnableIfNeed()
	{
		if (!_enabled && (_onStarted.length > 0 || _onPerformed.length > 0 || _onCanceled.length > 0))
		{
			Enable();
		}
	}

	public void DisableIfNeed()
	{
		if (_enabled && _onStarted.length == 0 && _onPerformed.length == 0 && _onCanceled.length == 0)
		{
			Disable();
		}
	}
}
