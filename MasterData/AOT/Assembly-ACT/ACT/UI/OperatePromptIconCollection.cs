using System;
using System.Collections.Generic;
using ACT.Battle;
using Fundamental;

namespace ACT.UI;

public class OperatePromptIconCollection : IOperatePromptIconCollection
{
	private Dictionary<string, HashSet<OperateBtnPrompt>> _actionToPrompts = new Dictionary<string, HashSet<OperateBtnPrompt>>();

	private List<OperateBtnPrompt> _operateBtnPromptList = new List<OperateBtnPrompt>();

	private Action<DeviceInputMode> _onInputDeviceChangeCallback;

	private IGameInputBindingHandle _bindingHandle;

	private bool _promptIsActive;

	public OperatePromptIconCollection(Action<DeviceInputMode> deviceChangeCallback, Func<IGameInputBindingHandle> getBindingHandle)
	{
		_onInputDeviceChangeCallback = deviceChangeCallback;
		_bindingHandle = getBindingHandle?.Invoke();
	}

	public void InitPromptCollectionBy(BaseUIComponent view)
	{
		RemoveInvalidPrompts();
		IReadOnlyList<OperateBtnPrompt> readOnlyList = view?.CachedOperateBtnPrompts;
		if (readOnlyList != null)
		{
			for (int i = 0; i < readOnlyList.Count; i++)
			{
				OperateBtnPrompt operateBtnPrompt = readOnlyList[i];
				if (!(operateBtnPrompt == null) && !operateBtnPrompt.IsDestoried)
				{
					((IOperatePromptIconCollection)this).Register(operateBtnPrompt);
				}
			}
		}
		foreach (OperateBtnPrompt operateBtnPrompt2 in _operateBtnPromptList)
		{
			operateBtnPrompt2.InitCollectionProvider(view);
		}
		UpdatePromptBtnIconActiveState();
	}

	private void UpdatePromptBtnIconActiveState()
	{
		RemoveInvalidPrompts();
		bool promptIsActive = ((MonoECS.instance.DeviceScreenType == ScreenSizeMode.LargeScreen) ? (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen) : (MonoECS.instance.InputMode == DeviceInputMode.Gamepad));
		_promptIsActive = promptIsActive;
		foreach (OperateBtnPrompt operateBtnPrompt in _operateBtnPromptList)
		{
			((IOperatePromptIconCollectionItem)operateBtnPrompt).SetActive(_promptIsActive);
		}
	}

	public void Init()
	{
		MonoECS.instance.onInputModeChange.AddListener(internal_OnInputDeviceChange);
	}

	public void UnInit()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(internal_OnInputDeviceChange);
	}

	private void HandleInputBindingStateChange(IGameInputBindingHandle fromHandle, string action, bool active)
	{
		if (fromHandle != _bindingHandle || !_actionToPrompts.TryGetValue(action, out var value))
		{
			return;
		}
		foreach (OperateBtnPrompt item in value)
		{
			item.RefreshIcon();
		}
	}

	private void RefreshIcons()
	{
		for (int num = _operateBtnPromptList.Count - 1; num >= 0; num--)
		{
			OperateBtnPrompt operateBtnPrompt = _operateBtnPromptList[num];
			if (operateBtnPrompt == null || operateBtnPrompt.IsDestoried)
			{
				UnRegister(operateBtnPrompt, num);
			}
			else
			{
				operateBtnPrompt.RefreshIcon();
			}
		}
	}

	private void internal_OnInputDeviceChange(DeviceInputMode type)
	{
		UpdatePromptBtnIconActiveState();
		RefreshIcons();
		if (Singleton<GameInputActionManager>.instance.CheckHandleIsActive(_bindingHandle))
		{
			_onInputDeviceChangeCallback?.Invoke(type);
		}
	}

	IGameInputBindingHandle IOperatePromptIconCollection.GetInputBindingHandle()
	{
		return _bindingHandle;
	}

	void IOperatePromptIconCollection.Register(OperateBtnPrompt prompt)
	{
		if (!_operateBtnPromptList.Contains(prompt))
		{
			_operateBtnPromptList.Add(prompt);
			if (!_actionToPrompts.TryGetValue(prompt.GetBindingAction(), out var value))
			{
				value = new HashSet<OperateBtnPrompt>();
			}
			value.Add(prompt);
			((IOperatePromptIconCollectionItem)prompt).SetActive(_promptIsActive);
		}
	}

	void IOperatePromptIconCollection.UnRegister(OperateBtnPrompt prompt)
	{
		UnRegister(prompt, _operateBtnPromptList.IndexOf(prompt));
	}

	private void UnRegister(OperateBtnPrompt prompt, int index = -1)
	{
		index = ((index < 0) ? _operateBtnPromptList.IndexOf(prompt) : index);
		if (index >= 0)
		{
			_operateBtnPromptList.RemoveAt(index);
			if ((object)prompt != null && _actionToPrompts.TryGetValue(prompt.GetBindingAction(), out var value))
			{
				value.Remove(prompt);
			}
		}
	}

	private void RemoveInvalidPrompts()
	{
		for (int num = _operateBtnPromptList.Count - 1; num >= 0; num--)
		{
			OperateBtnPrompt operateBtnPrompt = _operateBtnPromptList[num];
			if (operateBtnPrompt == null || operateBtnPrompt.IsDestoried)
			{
				UnRegister(operateBtnPrompt, num);
			}
		}
	}

	public void Refresh()
	{
		RefreshIcons();
	}
}
