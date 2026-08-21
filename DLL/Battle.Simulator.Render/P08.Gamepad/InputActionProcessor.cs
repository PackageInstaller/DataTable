using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

internal class InputActionProcessor
{
	private InputActionSystem _system;

	private List<string> _keyNameList = new List<string>();

	private Dictionary<string, InputBinding> _consumed => _system._transient.consumed;

	private PageInputActionMap _topPage => _system._transient.topPage;

	public InputActionProcessor(InputActionSystem system)
	{
		_system = system;
	}

	public void ClearKeyNameList()
	{
		_keyNameList.Clear();
	}

	public void ProcessPage(PageInputActionMap page)
	{
		bool flag = page.__bindingStartedCount > 0;
		if (!page.enabled && !flag)
		{
			return;
		}
		bool needReset = false;
		if (page.activeType == EInputActiveType.TopPage && page != _topPage)
		{
			needReset = true;
			if (!flag)
			{
				return;
			}
		}
		foreach (var (_, action) in page.inputActions)
		{
			ProcessInputAction(page, action);
		}
		foreach (InputBinding binding in page.bindings)
		{
			ProcessInputBinding(page, binding, needReset);
		}
	}

	public void ProcessInputEvents()
	{
	}

	private void ProcessInputAction(PageInputActionMap page, InputAction action)
	{
	}

	private void CollectInputBinding(PageInputActionMap page, InputBinding binding)
	{
	}

	private void ProcessInputBinding(PageInputActionMap page, InputBinding binding, bool needReset)
	{
		InputAction action = binding.action;
		InputActionState state = action.state;
		string mappedKey = HIDInputRemap.GetMappedKey(binding.buttonType);
		bool flag = _consumed.TryGetValue(mappedKey, out var _);
		if ((!state.consumed & flag) || _keyNameList.Contains(mappedKey))
		{
			return;
		}
		if (action.enabled && action.hasCallback)
		{
			_keyNameList.Add(mappedKey);
		}
		if (!action.enabled)
		{
			if (state.phase == EInputActionPhase.Disabled)
			{
				return;
			}
			needReset = true;
		}
		InputActionTriggerContext context = new InputActionTriggerContext
		{
			state = state,
			action = action,
			binding = binding,
			page = page
		};
		foreach (IInputActionTrigger trigger in binding.triggers)
		{
			if (needReset)
			{
				trigger.Reset(ref context);
			}
			else
			{
				trigger.Process(ref context);
			}
		}
		if (context.state.consumed && action.consumeType == EInputConsumeType.Block && !_consumed.TryAdd(mappedKey, binding))
		{
			InputBinding inputBinding = _consumed[mappedKey];
			Debug.LogError($"{page.pageName}:{action.actionName} try add consumed tag to op-{binding.buttonType} consumed by {inputBinding.actionName}");
		}
	}
}
