using System;
using UnityEngine;

namespace P08.Gamepad;

public struct InputActionTriggerContext
{
	public InputActionState state;

	public PageInputActionMap page;

	public InputAction action;

	public InputBinding binding;

	internal void Started()
	{
		page.__bindingStartedCount++;
		state.triggerState._phase = EInputActionPhase.Started;
		CallActionListerners(action._onStarted);
	}

	internal void Performed()
	{
		state.triggerState._phase = EInputActionPhase.Performed;
		CallActionListerners(action._onPerformed);
	}

	internal void Canceled()
	{
		page.__bindingStartedCount--;
		if (page.__bindingStartedCount < 0)
		{
			Debug.LogError($"{page.pageName}.__bindingStartedCount={page.__bindingStartedCount} when cancel {action.actionName}");
		}
		state.triggerState._phase = EInputActionPhase.Canceled;
		CallActionListerners(action._onCanceled);
		state.triggerState._phase = EInputActionPhase.Disabled;
		state.triggerState._consumed = false;
	}

	private void CallActionListerners(CallbackArray<Action<InputActionCallbackContext>> listeners)
	{
		if (listeners.length == 0)
		{
			return;
		}
		InputActionCallbackContext obj = new InputActionCallbackContext
		{
			page = page,
			action = action,
			state = state
		};
		listeners.LockForChanges();
		for (int i = 0; i < listeners.length; i++)
		{
			try
			{
				listeners[i](obj);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
		listeners.UnlockForChanges();
		state.triggerState._consumed = state.triggerState._phase != EInputActionPhase.Disabled;
	}
}
