#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace Ase;

public class KeySettingItem : GameSettingItem
{
	[SerializeField]
	private TextMeshProUGUI keyCode;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Button rebindBtn;

	[SerializeField]
	private TextMeshProUGUI keyCodeInPanel;

	public InputActionReference m_Action;

	[SerializeField]
	private string m_BindingId;

	[SerializeField]
	private InputBinding.DisplayStringOptions m_DisplayStringOptions;

	private InputActionAsset asset;

	private InputActionRebindingExtensions.RebindingOperation m_RebindOperation;

	protected new KeySettingItemData _viewModel;

	private static List<string> InValidInputPath = new List<string> { "/Mouse/leftButton", "/Mouse/rightButton", "/Mouse/middleButton", "/Mouse/forwardButton", "/Mouse/backButton" };

	private static List<string> CancelingPath = new List<string>
	{
		"/Keyboard/tab", "/Keyboard/capsLock", "/Keyboard/escape", "/Keyboard/printScreen", "/Keyboard/scrollLock", "/Keyboard/pause", "/Keyboard/insert", "/Keyboard/home", "/Keyboard/pageUp", "/Keyboard/delete",
		"/Keyboard/end", "/Keyboard/pageDown", "/Keyboard/leftMeta", "/Keyboard/rightMeta", "/Keyboard/contextMenu", "/Keyboard/backspace", "/Keyboard/enter", "/Keyboard/backquote", "/Keyboard/numLock", "/Keyboard/numpadDivide",
		"/Keyboard/numpadMultiply", "/Keyboard/numpadMinus", "/Keyboard/numpadPlus", "/Keyboard/numpadEnter", "/Keyboard/numpadPeriod", "/Keyboard/numpad0", "/Keyboard/numpad1", "/Keyboard/numpad2", "/Keyboard/numpad3", "/Keyboard/numpad4",
		"/Keyboard/numpad5", "/Keyboard/numpad6", "/Keyboard/numpad7", "/Keyboard/numpad8", "/Keyboard/numpad9"
	};

	public InputBinding.DisplayStringOptions displayStringOptions
	{
		get
		{
			return m_DisplayStringOptions;
		}
		set
		{
			m_DisplayStringOptions = value;
			UpdateBindingDisplay();
		}
	}

	public void Init(KeySettingItemData viewModel)
	{
		_viewModel = viewModel;
		BindingSet<KeySettingItem, KeySettingItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((KeySettingItemData vm) => vm.Selected);
		}
		rebindBtn.onClick.AddListener(StartInteractiveRebind);
		bindingSet.Build();
		UpdateBindingDisplay();
	}

	private void StartInteractiveRebind()
	{
		if (!ResolveActionAndBinding(out var action, out var bindingIndex))
		{
			return;
		}
		action.Disable();
		_viewModel.EnterInputMode();
		if (action.bindings[bindingIndex].isComposite)
		{
			int num = bindingIndex + 1;
			if (num < action.bindings.Count && action.bindings[num].isPartOfComposite)
			{
				PerformInteractiveRebind(action, num, allCompositeParts: true);
			}
		}
		else
		{
			PerformInteractiveRebind(action, bindingIndex);
		}
	}

	private void PerformInteractiveRebind(InputAction action, int bindingIndex, bool allCompositeParts = false)
	{
		m_RebindOperation?.Cancel();
		m_RebindOperation = action.PerformInteractiveRebinding(bindingIndex).OnPotentialMatch(delegate(InputActionRebindingExtensions.RebindingOperation op)
		{
			if (InValidInputPath.Contains(op.selectedControl.path))
			{
				Toast.ShowInfo("该键位不可设置");
				op.Cancel();
			}
			else if (CancelingPath.Contains(op.selectedControl.path))
			{
				Toast.ShowInfo("该键位不可设置");
				op.Cancel();
			}
			else
			{
				string text = action.bindings[bindingIndex].effectivePath.Replace(">/", "/").Replace('<', '/');
				InputAction targetAction;
				int targetBindingIndex;
				if (op.selectedControl.path == text)
				{
					Toast.ShowInfo("设置成功");
					op.Cancel();
				}
				else if (CheckDuplicate(out targetAction, out targetBindingIndex, op.selectedControl.path))
				{
					string inputPath = op.selectedControl.path;
					IAsyncResult<int> result = AlertDialog.Show("提示", "该键位已被占用，继续设置将替换键位", "确定", "取消");
					result.Callbackable().OnCallback(delegate
					{
						if (result.Result == -1)
						{
							ModifyActionBinding(targetAction, targetBindingIndex, action.bindings[bindingIndex].effectivePath, updateDisplay: true);
							ModifyActionBinding(action, bindingIndex, inputPath, updateDisplay: false);
							_viewModel.OnRebindingFinished();
							UpdateBindingDisplay();
							Toast.ShowInfo("设置成功");
						}
					});
					op.Cancel();
				}
				else if (op.selectedControl.path.Equals("/Keyboard/space"))
				{
					op.Complete();
				}
			}
		}).OnCancel(delegate
		{
			UpdateBindingDisplay();
			CleanUp();
			_viewModel.ExitInputMode();
		})
			.OnComplete(delegate
			{
				Toast.ShowInfo("设置成功");
				_viewModel.OnRebindingFinished();
				UpdateBindingDisplay();
				CleanUp();
				_viewModel.ExitInputMode();
			});
		if (action.bindings[bindingIndex].isPartOfComposite)
		{
			_ = "Binding '" + action.bindings[bindingIndex].name + "'. ";
		}
		m_RebindOperation.Start();
		void CleanUp()
		{
			m_RebindOperation?.Dispose();
			m_RebindOperation = null;
		}
	}

	public void UpdateBindingDisplay()
	{
		string text = string.Empty;
		string deviceLayoutName = null;
		string controlPath = null;
		InputAction inputAction = m_Action?.action;
		if (inputAction != null)
		{
			int num = inputAction.bindings.IndexOf((InputBinding x) => x.id.ToString() == m_BindingId);
			if (num != -1)
			{
				text = inputAction.GetBindingDisplayString(num, out deviceLayoutName, out controlPath, displayStringOptions);
			}
		}
		((TMP_Text)keyCode).text = text;
		if ((UnityEngine.Object)(object)keyCodeInPanel != null)
		{
			((TMP_Text)keyCodeInPanel).text = text;
		}
	}

	public bool ResolveActionAndBinding(out InputAction action, out int bindingIndex)
	{
		bindingIndex = -1;
		action = m_Action?.action;
		if (action == null)
		{
			return false;
		}
		if (string.IsNullOrEmpty(m_BindingId))
		{
			return false;
		}
		Guid bindingId = new Guid(m_BindingId);
		bindingIndex = action.bindings.IndexOf((InputBinding x) => x.id == bindingId);
		if (bindingIndex == -1)
		{
			Log.Error($"Cannot find binding with ID '{bindingId}' on '{action}'", this);
			return false;
		}
		return true;
	}

	public bool GetInputBinding(out InputBinding binding)
	{
		binding = default(InputBinding);
		int num = -1;
		InputAction inputAction = m_Action?.action;
		if (inputAction == null)
		{
			return false;
		}
		if (string.IsNullOrEmpty(m_BindingId))
		{
			return false;
		}
		Guid bindingId = new Guid(m_BindingId);
		num = inputAction.bindings.IndexOf((InputBinding x) => x.id == bindingId);
		if (num == -1)
		{
			Log.Error($"Cannot find binding with ID '{bindingId}' on '{inputAction}'", this);
			return false;
		}
		binding = inputAction.bindings[num];
		return true;
	}

	public void ResetToDefault()
	{
		if (!ResolveActionAndBinding(out var action, out var bindingIndex))
		{
			return;
		}
		if (action.bindings[bindingIndex].isComposite)
		{
			for (int i = bindingIndex + 1; i < action.bindings.Count && action.bindings[i].isPartOfComposite; i++)
			{
				action.RemoveBindingOverride(i);
			}
		}
		else
		{
			action.RemoveBindingOverride(bindingIndex);
		}
		UpdateBindingDisplay();
	}

	private bool CheckDuplicate(out InputAction action, out int bindingIndex, string inputPath)
	{
		action = null;
		bindingIndex = 0;
		Dictionary<string, KeyValuePair<InputAction, int>> inputSystemData = _viewModel.GetInputSystemData();
		if (!inputSystemData.ContainsKey(inputPath))
		{
			return false;
		}
		action = inputSystemData[inputPath].Key;
		bindingIndex = inputSystemData[inputPath].Value;
		return true;
	}

	private void ModifyActionBinding(InputAction action, int bindingIndex, string newBinding, bool updateDisplay)
	{
		action.Disable();
		action.ApplyBindingOverride(bindingIndex, newBinding);
		action.Enable();
		if (updateDisplay)
		{
			_viewModel.UpdateTargetItemDisplay(action.bindings[bindingIndex]);
		}
	}
}
