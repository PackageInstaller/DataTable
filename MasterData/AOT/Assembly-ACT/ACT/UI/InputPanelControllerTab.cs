using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.UI.InputController;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.UI;

namespace ACT.UI;

public class InputPanelControllerTab : MonoBehaviour
{
	[Serializable]
	public class ControllerImage
	{
		public Image image;

		public Image image_ps;

		public string path;
	}

	public ActButton BtnResetToDefault;

	private InputLine_ControllerKeyRebinding[] m_InputLines;

	private RebindingContext m_RebindingContext;

	public GameObject xbox;

	public GameObject ps;

	public List<ControllerImage> controllerImages = new List<ControllerImage>();

	public InputPanel InputPanel;

	public GameObject RebindingTip;

	public GameObject ModiferRebindingTip;

	private HashSet<string> _highlightPaths;

	public InputLine_ControllerKeyRebinding[] InputLines => m_InputLines;

	public void Init(RebindingContext rebindingContext)
	{
		m_RebindingContext = rebindingContext;
		m_InputLines = gameObject.GetComponentsInChildren<InputLine_ControllerKeyRebinding>(includeInactive: true);
		InputLine_ControllerKeyRebinding[] inputLines = m_InputLines;
		foreach (InputLine_ControllerKeyRebinding inputLine in inputLines)
		{
			ButtonBindingPathConfig.ButtonBindingPath inputBindingPath = MonoECS.instance.GetInputBindingPath(inputLine.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Gamepad);
			if (inputBindingPath != null)
			{
				int num = ResolveRebindingBindingIndex(MonoECS.instance.inputActionAsset.FindAction(inputBindingPath.InputActionPath), inputBindingPath.InputBindingIndex);
				inputLine.ActionPath = inputBindingPath.InputActionPath;
				inputLine.BindingIndex = num;
				inputLine.InputPrompt.InputActionPath = inputBindingPath.InputActionPath;
				inputLine.InputPrompt.InputBindingIndex = num;
				inputLine.BtnRebinding.onClick.AddListener(() =>
				{
					if (inputLine.Editable)
					{
						StartCoroutine(StartRebinding(inputLine, inputLine.Text, inputLine.InputPrompt, inputLine.ButtonBindingKey, inputLine.ActionPath, inputLine.BindingIndex));
					}
					else
					{
						InputPanel.ShowTip();
					}
				});
				inputLine.gameObject.AddComponent<SubmitHandlerComponent>().OnSubmit.AddListener((BaseEventData eventData) =>
				{
					inputLine.BtnRebinding.OnSubmit(eventData);
				});
			}
			else
			{
				inputLine.ActionPath = string.Empty;
				inputLine.BindingIndex = -1;
				inputLine.InputPrompt.InputActionPath = string.Empty;
				inputLine.InputPrompt.InputBindingIndex = -1;
				inputLine.gameObject.SetActive(value: false);
				inputLine.InputPrompt.gameObject.SetActive(value: false);
			}
		}
		m_InputLines = gameObject.GetComponentsInChildren<InputLine_ControllerKeyRebinding>();
		Refresh();
	}

	private void LateUpdate()
	{
		if (MonoECS.instance.activeInputDevice is DualShockGamepad)
		{
			xbox?.SetActive(value: false);
			ps?.SetActive(value: true);
		}
		else
		{
			xbox?.SetActive(value: true);
			ps?.SetActive(value: false);
		}
		if (_highlightPaths == null)
		{
			_highlightPaths = new HashSet<string>();
		}
		_highlightPaths.Clear();
		if (EventSystemHelper.CurrentSelected != null)
		{
			InputLine_ControllerKeyRebinding[] inputLines = m_InputLines;
			foreach (InputLine_ControllerKeyRebinding inputLine_ControllerKeyRebinding in inputLines)
			{
				if (EventSystemHelper.CurrentSelected == inputLine_ControllerKeyRebinding.gameObject && MonoECS.instance.TryGetInputActionKeyBindingInfo(MonoECS.PromptIconDeviceType.Gamepad, inputLine_ControllerKeyRebinding.ActionPath, out var bindingInfo))
				{
					if (bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier)
					{
						_highlightPaths.Add(bindingInfo.GetKeyBinding(0));
					}
					_highlightPaths.Add(bindingInfo.GetKeyBinding(-1));
					break;
				}
			}
		}
		foreach (ControllerImage controllerImage in controllerImages)
		{
			bool active = _highlightPaths.Contains(controllerImage.path);
			controllerImage.image?.gameObject.SetActive(active);
			controllerImage.image_ps?.gameObject.SetActive(active);
		}
	}

	private IEnumerator StartRebinding(InputLine_ControllerKeyRebinding line, TextMeshProUGUI text, InputPromptByBindingPath prompt, string buttonBindingKey, string actionPath, int bindingIndex)
	{
		bool modifierMode = MonoECS.instance.TryGetInputActionKeyBindingInfo(MonoECS.PromptIconDeviceType.Gamepad, actionPath, out var bindingInfo) && bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier;
		ModiferRebindingTip?.SetActive(modifierMode);
		RebindingTip?.SetActive(value: true);
		yield return new WaitForSeconds(0.1f);
		Rebind();
		void Rebind()
		{
			RebindingTip?.SetActive(value: true);
			m_RebindingContext.CancelAndCleanUp();
			InputActionMap uiActionMap = MonoECS.instance.inputActionAsset.FindActionMap("UI");
			InputActionMap settingActionMap = MonoECS.instance.inputActionAsset.FindActionMap("Settings");
			InputAction inputAction = MonoECS.instance.inputActionAsset.FindAction(actionPath);
			bindingIndex = ResolveRebindingBindingIndex(inputAction, bindingIndex);
			inputAction.actionMap.Disable();
			uiActionMap.Disable();
			settingActionMap.Disable();
			InputBinding oldBinding = default;
			string oldBindingEffectPath = string.Empty;
			if (TryGetBinding(inputAction, bindingIndex, out oldBinding))
			{
				oldBindingEffectPath = oldBinding.effectivePath;
			}
			m_RebindingContext.RebindingOperation = InputActionKeyCodeChangeSupport.GetGampepadRebindOperation(modifierMode, inputAction, bindingIndex).OnComplete((InputActionRebindingExtensions.RebindingOperation operation) =>
			{
				OnRebindOperation(operation, modifierMode, inputAction, buttonBindingKey, bindingIndex, oldBinding, oldBindingEffectPath, uiActionMap, settingActionMap, line, prompt, Rebind);
			});
			m_RebindingContext.RebindingOperation.Start();
			text.text = "|";
			prompt.gameObject.SetActive(value: false);
		}
	}

	private void OnRebindOperation(InputActionRebindingExtensions.RebindingOperation operation, bool modifierMode, InputAction inputAction, string buttonBindingKey, int bindingIndex, InputBinding oldBinding, string oldBindingEffectPath, InputActionMap uiActionMap, InputActionMap settingActionMap, InputLine_ControllerKeyRebinding line, InputPromptByBindingPath prompt, Action Rebind)
	{
		string newBindingEffectPath = inputAction.bindings[bindingIndex].effectivePath;
		if (oldBinding.hasOverrides)
		{
			inputAction.ApplyBindingOverride(bindingIndex, oldBindingEffectPath);
		}
		else
		{
			inputAction.RemoveBindingOverride(bindingIndex);
		}
		UniTask.WaitForSeconds(1f).ContinueWith(() =>
		{
			inputAction.actionMap.Enable();
			uiActionMap.Enable();
			settingActionMap.Enable();
		}).Forget();
		string text = newBindingEffectPath;
		if (text == "<Keyboard>/escape" || text == "<Gamepad>/start")
		{
			RebindingTip?.SetActive(value: false);
			ModiferRebindingTip?.SetActive(value: false);
			prompt.gameObject.SetActive(value: true);
			RebindingComplete();
			return;
		}
		if (!line.Editable || !InputActionKeyCodeChangeSupport.IsValidKeyCode(modifierMode, newBindingEffectPath))
		{
			InputPanel.ShowTip();
			operation.Cancel();
			Rebind();
			return;
		}
		RebindingTip?.SetActive(value: false);
		ModiferRebindingTip?.SetActive(value: false);
		InputBindingPanel.InputBindingPanelData inputBindingPanelData = new InputBindingPanel.InputBindingPanelData();
		inputBindingPanelData.Changes.Add((line.Label.text, oldBindingEffectPath, newBindingEffectPath));
		inputBindingPanelData.ModifierMode = modifierMode;
		bool same = false;
		InputAction sameAction = null;
		int sameBindingIndex = 0;
		InputLine_ControllerKeyRebinding sameInputLine = null;
		InputLine_ControllerKeyRebinding[] inputLines = m_InputLines;
		foreach (InputLine_ControllerKeyRebinding inputLine_ControllerKeyRebinding in inputLines)
		{
			if (!(inputLine_ControllerKeyRebinding.InputPrompt == prompt) && inputLine_ControllerKeyRebinding.InputPrompt.TryGetAction(out var inputAction2))
			{
				int num2 = ResolveRebindingBindingIndex(inputAction2, inputLine_ControllerKeyRebinding.InputPrompt.InputBindingIndex);
				if (TryGetBinding(inputAction2, num2, out var binding) && MonoECS.instance.CheckInputActionIsModifierMode(MonoECS.PromptIconDeviceType.Gamepad, inputLine_ControllerKeyRebinding.ActionPath) == modifierMode && binding.effectivePath == newBindingEffectPath)
				{
					same = true;
					inputBindingPanelData.Changes.Add((inputLine_ControllerKeyRebinding.Label.text, binding.effectivePath, oldBindingEffectPath));
					sameAction = inputAction2;
					sameBindingIndex = num2;
					sameInputLine = inputLine_ControllerKeyRebinding;
					break;
				}
			}
		}
		inputBindingPanelData.OnConfirm = () =>
		{
			inputAction.ApplyBindingOverride(bindingIndex, newBindingEffectPath);
			InputPanel.Record(buttonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Gamepad, oldBindingEffectPath, newBindingEffectPath);
			if (same)
			{
				sameAction.ApplyBindingOverride(sameBindingIndex, oldBindingEffectPath);
				InputPanel.Record(sameInputLine.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Gamepad, newBindingEffectPath, oldBindingEffectPath);
			}
			prompt.gameObject.SetActive(value: true);
			RebindingComplete();
			EventSystemHelper.SetSelectedGameObject(line.gameObject);
			MonoECS.instance.RefreshInputActionBindings(inputAction, sameAction);
		};
		inputBindingPanelData.OnCancel = () =>
		{
			prompt.gameObject.SetActive(value: true);
			RebindingComplete();
			EventSystemHelper.SetSelectedGameObject(line.gameObject);
		};
		if (oldBindingEffectPath != newBindingEffectPath)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_INPUTBINDINGPANEL, inputBindingPanelData);
		}
		else
		{
			inputBindingPanelData.OnCancel();
		}
	}

	private static int ResolveRebindingBindingIndex(InputAction inputAction, int bindingIndex)
	{
		if (inputAction == null)
		{
			return bindingIndex;
		}
		ReadOnlyArray<InputBinding> bindings = inputAction.bindings;
		if (bindingIndex < 0 || bindingIndex >= bindings.Count)
		{
			return bindingIndex;
		}
		if (!bindings[bindingIndex].isComposite)
		{
			return bindingIndex;
		}
		for (int i = bindingIndex + 1; i < bindings.Count; i++)
		{
			InputBinding inputBinding = bindings[i];
			if (!inputBinding.isPartOfComposite)
			{
				break;
			}
			if (string.Equals(inputBinding.name, "binding", StringComparison.Ordinal))
			{
				return i;
			}
		}
		return bindingIndex;
	}

	private static bool TryGetBinding(InputAction inputAction, int bindingIndex, out InputBinding binding)
	{
		binding = default;
		if (inputAction == null)
		{
			return false;
		}
		ReadOnlyArray<InputBinding> bindings = inputAction.bindings;
		if (bindingIndex < 0 || bindingIndex >= bindings.Count)
		{
			return false;
		}
		binding = bindings[bindingIndex];
		return true;
	}

	private void RebindingComplete()
	{
		m_RebindingContext.CleanUp();
		Refresh();
	}

	public void Refresh()
	{
		InputLine_ControllerKeyRebinding[] inputLines = m_InputLines;
		foreach (InputLine_ControllerKeyRebinding obj in inputLines)
		{
			obj.Text.text = string.Empty;
			obj.InputPrompt.Refresh();
		}
	}
}
