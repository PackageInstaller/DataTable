using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

public class PageInputActionMap
{
	private Dictionary<string, InputAction> _inputActions;

	private List<InputBinding> _bindings;

	private bool _enabled;

	internal int __bindingStartedCount;

	public string pageName { get; }

	public Dictionary<string, InputAction> inputActions => _inputActions;

	public List<InputBinding> bindings => _bindings;

	public EInputActiveType activeType { get; }

	public bool canBeTop { get; }

	public bool enabled => _enabled;

	internal PageInputActionMap(string pageName, EInputActiveType activeType, bool canBeTop)
	{
		this.pageName = pageName;
		this.activeType = activeType;
		this.canBeTop = canBeTop;
		_inputActions = new Dictionary<string, InputAction>();
		_bindings = new List<InputBinding>();
	}

	internal PageInputActionMap(PageInputActionRes res, string pageName = null)
	{
		this.pageName = pageName ?? res.pageName;
		activeType = res.activeType;
		_inputActions = new Dictionary<string, InputAction>();
		_bindings = new List<InputBinding>();
		canBeTop = res.canBeTop;
		_enabled = false;
	}

	public InputAction GetInputAction(string name)
	{
		if (!_inputActions.TryGetValue(name, out var value))
		{
			Debug.LogError("PageInputActionMap " + pageName + " could not found action: " + name);
			return null;
		}
		return value;
	}

	public InputAction GetInputAction(En_ButtonType buttonType)
	{
		InputBinding bindingButtonType = GetBindingButtonType(buttonType);
		if (bindingButtonType == null)
		{
			Debug.LogError($"PageInputActionMap {pageName} could not found button type: {buttonType}");
			return null;
		}
		foreach (InputAction value in _inputActions.Values)
		{
			if (value.actionName == bindingButtonType.actionName)
			{
				return value;
			}
		}
		Debug.LogError($"PageInputActionMap {pageName} could not found button type: {buttonType}");
		return null;
	}

	public InputBinding GetInputBinding_(InputAction action)
	{
		return _bindings.Find((InputBinding binding) => binding.actionName == action.actionName);
	}

	public InputBinding GetBindingButtonType(En_ButtonType buttonType)
	{
		return _bindings.Find((InputBinding binding) => binding.buttonType == buttonType);
	}

	public void Enable()
	{
		if (_enabled)
		{
			return;
		}
		_enabled = true;
		foreach (KeyValuePair<string, InputAction> inputAction in _inputActions)
		{
			inputAction.Deconstruct(out var _, out var value);
			value.Enable();
		}
	}

	public void Disable()
	{
		if (!_enabled)
		{
			return;
		}
		_enabled = false;
		foreach (KeyValuePair<string, InputAction> inputAction in _inputActions)
		{
			inputAction.Deconstruct(out var _, out var value);
			value.Disable();
		}
	}

	public void AddInputAction(InputAction action)
	{
		_inputActions.Add(action.actionName, action);
	}

	public void AddInputBinding(InputBinding binding)
	{
		_bindings.Add(binding);
	}

	public void RemoveInputAction(InputAction action)
	{
		_inputActions.Remove(action.actionName);
		_bindings.RemoveAll((InputBinding binding) => binding.actionName == action.actionName);
	}
}
