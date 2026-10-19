using System;
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

namespace ACT.UI;

public class InputPanelPCTab : MonoBehaviour
{
	public ActButton BtnResetToDefault;

	private InputLine_KeyboardRebinding[] m_InputLines;

	private RebindingContext m_RebindingContext;

	public InputPanel InputPanel;

	public GameObject RebindingTip;

	private static readonly HashSet<string> SupportRebindKeyboardKeys = new HashSet<string>
	{
		"<mouse>/leftbutton", "<mouse>/rightbutton", "<mouse>/middlebutton", "<mouse>/forwardbutton", "<mouse>/backbutton", "<keyboard>/space", "<keyboard>/backquote", "<keyboard>/quote", "<keyboard>/semicolon", "<keyboard>/comma",
		"<keyboard>/period", "<keyboard>/slash", "<keyboard>/backslash", "<keyboard>/leftbracket", "<keyboard>/rightbracket", "<keyboard>/minus", "<keyboard>/equals", "<keyboard>/a", "<keyboard>/b", "<keyboard>/c",
		"<keyboard>/d", "<keyboard>/e", "<keyboard>/f", "<keyboard>/g", "<keyboard>/h", "<keyboard>/i", "<keyboard>/j", "<keyboard>/k", "<keyboard>/l", "<keyboard>/m",
		"<keyboard>/n", "<keyboard>/o", "<keyboard>/p", "<keyboard>/q", "<keyboard>/r", "<keyboard>/s", "<keyboard>/t", "<keyboard>/u", "<keyboard>/v", "<keyboard>/w",
		"<keyboard>/x", "<keyboard>/y", "<keyboard>/z", "<keyboard>/0", "<keyboard>/1", "<keyboard>/2", "<keyboard>/3", "<keyboard>/4", "<keyboard>/5", "<keyboard>/6",
		"<keyboard>/7", "<keyboard>/8", "<keyboard>/9", "<keyboard>/leftshift", "<keyboard>/rightshift", "<keyboard>/rightalt", "<keyboard>/rightmeta", "<keyboard>/leftctrl", "<keyboard>/rightctrl", "<keyboard>/leftarrow",
		"<keyboard>/rightarrow", "<keyboard>/uparrow", "<keyboard>/downarrow", "<keyboard>/pageup", "<keyboard>/pagedown", "<keyboard>/home", "<keyboard>/end", "<keyboard>/insert", "<keyboard>/delete", "<keyboard>/backspace",
		"<keyboard>/capslock", "<keyboard>/f1", "<keyboard>/f2", "<keyboard>/f3", "<keyboard>/f4", "<keyboard>/f5", "<keyboard>/f6", "<keyboard>/f7", "<keyboard>/f8", "<keyboard>/f9",
		"<keyboard>/f10", "<keyboard>/f11", "<keyboard>/f12"
	};

	public InputLine_KeyboardRebinding[] InputLines => m_InputLines;

	public void Init(RebindingContext rebindingContext)
	{
		m_RebindingContext = rebindingContext;
		m_InputLines = gameObject.GetComponentsInChildren<InputLine_KeyboardRebinding>(includeInactive: true);
		InputLine_KeyboardRebinding[] inputLines = m_InputLines;
		foreach (InputLine_KeyboardRebinding inputLine in inputLines)
		{
			ButtonBindingPathConfig.ButtonBindingPath inputBindingPath = MonoECS.instance.GetInputBindingPath(inputLine.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard1);
			if (inputBindingPath != null)
			{
				inputLine.ActionPath = inputBindingPath.InputActionPath;
				inputLine.BindingIndex0 = inputBindingPath.InputBindingIndex;
				inputLine.InputPrompt0.InputActionPath = inputBindingPath.InputActionPath;
				inputLine.InputPrompt0.InputBindingIndex = inputBindingPath.InputBindingIndex;
				inputLine.BtnRebinding0.onClick.AddListener(() =>
				{
					if (inputLine.Editable)
					{
						StartRebinding(inputLine, inputLine.BtnRebinding0.gameObject, inputLine.Text0, inputLine.InputPrompt0, inputLine.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard1, inputLine.ActionPath, inputLine.BindingIndex0);
					}
					else
					{
						InputPanel.ShowTip();
					}
				});
				inputLine.BtnRebinding0.gameObject.AddComponent<CancelHandlerComponent>().OnCancel.AddListener((BaseEventData eventData) =>
				{
					eventData.selectedObject = inputLine.gameObject;
				});
			}
			else
			{
				inputLine.BtnRebinding0.gameObject.SetActive(value: false);
				inputLine.BindingIndex0 = -1;
				inputLine.InputPrompt0.gameObject.SetActive(value: false);
				inputLine.InputPrompt0.InputBindingIndex = -1;
			}
			ButtonBindingPathConfig.ButtonBindingPath inputBindingPath2 = MonoECS.instance.GetInputBindingPath(inputLine.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard2);
			if (inputBindingPath2 != null)
			{
				inputLine.ActionPath = inputBindingPath2.InputActionPath;
				inputLine.BindingIndex1 = inputBindingPath2.InputBindingIndex;
				inputLine.InputPrompt1.InputActionPath = inputBindingPath2.InputActionPath;
				inputLine.InputPrompt1.InputBindingIndex = inputBindingPath2.InputBindingIndex;
				inputLine.BtnRebinding1.onClick.AddListener(() =>
				{
					if (inputLine.Editable1)
					{
						StartRebinding(inputLine, inputLine.BtnRebinding1.gameObject, inputLine.Text1, inputLine.InputPrompt1, inputLine.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard2, inputLine.ActionPath, inputLine.BindingIndex1);
					}
					else
					{
						InputPanel.ShowTip();
					}
				});
				inputLine.BtnRebinding1.gameObject.AddComponent<CancelHandlerComponent>().OnCancel.AddListener((BaseEventData eventData) =>
				{
					eventData.selectedObject = inputLine.gameObject;
				});
			}
			else
			{
				inputLine.BtnRebinding1.gameObject.SetActive(value: false);
				inputLine.BindingIndex1 = -1;
				inputLine.InputPrompt1.gameObject.SetActive(value: false);
				inputLine.InputPrompt1.InputBindingIndex = -1;
			}
			inputLine.gameObject.AddComponent<SubmitHandlerComponent>().OnSubmit.AddListener((BaseEventData eventData) =>
			{
				if (inputLine.BtnRebinding0.IsActive() && inputLine.BtnRebinding0.IsInteractable())
				{
					EventSystemHelper.SetSelectedGameObject(inputLine.BtnRebinding0.gameObject);
				}
				else if (inputLine.BtnRebinding1.IsActive() && inputLine.BtnRebinding1.IsInteractable())
				{
					EventSystemHelper.SetSelectedGameObject(inputLine.BtnRebinding1.gameObject);
				}
			});
		}
		m_InputLines = gameObject.GetComponentsInChildren<InputLine_KeyboardRebinding>();
		Refresh();
	}

	private void StartRebinding(InputLine_KeyboardRebinding line, GameObject selection, TextMeshProUGUI text, InputPromptByBindingPath prompt, string buttonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution solution, string actionPath, int bindingIndex)
	{
		Rebind();
		void Rebind()
		{
			RebindingTip?.gameObject.SetActive(value: true);
			m_RebindingContext.CancelAndCleanUp();
			InputActionMap uiActionMap = MonoECS.instance.inputActionAsset.FindActionMap("UI");
			InputActionMap settingActionMap = MonoECS.instance.inputActionAsset.FindActionMap("Settings");
			InputAction inputAction = MonoECS.instance.inputActionAsset.FindAction(actionPath);
			uiActionMap.Disable();
			settingActionMap.Disable();
			inputAction.actionMap.Disable();
			prompt.TryGetBinding(out var oldBinding);
			string oldBindingEffectPath = oldBinding.effectivePath;
			InputActionKeyCodeChangeSupport.GetKeyboardRebindOperation(inputAction, bindingIndex);
			m_RebindingContext.RebindingOperation = InputActionKeyCodeChangeSupport.GetKeyboardRebindOperation(inputAction, bindingIndex).OnComplete((InputActionRebindingExtensions.RebindingOperation operation) =>
			{
				OnRebindOperation(operation, selection, inputAction, buttonBindingKey, solution, bindingIndex, oldBinding, oldBindingEffectPath, uiActionMap, settingActionMap, line, prompt, Rebind);
			});
			m_RebindingContext.RebindingOperation.Start();
			text.text = "|";
			prompt.gameObject.SetActive(value: false);
		}
	}

	private void OnRebindOperation(InputActionRebindingExtensions.RebindingOperation operation, GameObject selection, InputAction inputAction, string buttonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution solution, int bindingIndex, InputBinding oldBinding, string oldBindingEffectPath, InputActionMap uiActionMap, InputActionMap settingActionMap, InputLine_KeyboardRebinding line, InputPromptByBindingPath prompt, Action Rebind)
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
			prompt.gameObject.SetActive(value: true);
			RebindingComplete();
			return;
		}
		string item = newBindingEffectPath.ToLower();
		if (!SupportRebindKeyboardKeys.Contains(item) || (!line.Editable && selection == line.BtnRebinding0.gameObject) || (!line.Editable1 && selection == line.BtnRebinding1.gameObject))
		{
			InputPanel.ShowTip();
			operation.Cancel();
			Rebind();
			return;
		}
		RebindingTip?.SetActive(value: false);
		InputBindingPanel.InputBindingPanelData inputBindingPanelData = new InputBindingPanel.InputBindingPanelData();
		inputBindingPanelData.Changes.Add((line.Label.text, oldBindingEffectPath, newBindingEffectPath));
		bool same = false;
		InputAction sameAction = null;
		int sameBindingIndex = 0;
		InputLine_KeyboardRebinding sameInputLine = null;
		ButtonBindingPathConfig.ButtonBindingSolution sameSolution = ButtonBindingPathConfig.ButtonBindingSolution.Keyboard1;
		InputLine_KeyboardRebinding[] inputLines = m_InputLines;
		foreach (InputLine_KeyboardRebinding inputLine_KeyboardRebinding in inputLines)
		{
			if (inputLine_KeyboardRebinding.Editable && inputLine_KeyboardRebinding.InputPrompt0 != prompt && inputLine_KeyboardRebinding.InputPrompt0.TryGetBinding(out var binding) && binding.effectivePath == newBindingEffectPath)
			{
				same = true;
				inputBindingPanelData.Changes.Add((inputLine_KeyboardRebinding.Label.text, binding.effectivePath, oldBindingEffectPath));
				inputLine_KeyboardRebinding.InputPrompt0.TryGetAction(out sameAction);
				sameBindingIndex = inputLine_KeyboardRebinding.InputPrompt0.InputBindingIndex;
				sameInputLine = inputLine_KeyboardRebinding;
				sameSolution = ButtonBindingPathConfig.ButtonBindingSolution.Keyboard1;
				break;
			}
			if (inputLine_KeyboardRebinding.Editable1 && inputLine_KeyboardRebinding.InputPrompt1 != prompt && inputLine_KeyboardRebinding.InputPrompt1.TryGetBinding(out var binding2) && binding2.effectivePath == newBindingEffectPath)
			{
				same = true;
				inputBindingPanelData.Changes.Add((inputLine_KeyboardRebinding.Label.text, binding2.effectivePath, oldBindingEffectPath));
				inputLine_KeyboardRebinding.InputPrompt1.TryGetAction(out sameAction);
				sameBindingIndex = inputLine_KeyboardRebinding.InputPrompt1.InputBindingIndex;
				sameInputLine = inputLine_KeyboardRebinding;
				sameSolution = ButtonBindingPathConfig.ButtonBindingSolution.Keyboard2;
				break;
			}
		}
		inputBindingPanelData.OnConfirm = () =>
		{
			inputAction.ApplyBindingOverride(bindingIndex, newBindingEffectPath);
			InputPanel.Record(buttonBindingKey, solution, oldBindingEffectPath, newBindingEffectPath);
			if (same)
			{
				sameAction.ApplyBindingOverride(sameBindingIndex, oldBindingEffectPath);
				InputPanel.Record(sameInputLine.ButtonBindingKey, sameSolution, newBindingEffectPath, oldBindingEffectPath);
			}
			prompt.gameObject.SetActive(value: true);
			RebindingComplete();
			EventSystemHelper.SetSelectedGameObject(selection);
			MonoECS.instance.RefreshInputActionBindings(inputAction, sameAction);
		};
		inputBindingPanelData.OnCancel = () =>
		{
			prompt.gameObject.SetActive(value: true);
			RebindingComplete();
			EventSystemHelper.SetSelectedGameObject(selection);
		};
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_INPUTBINDINGPANEL, inputBindingPanelData);
	}

	private void RebindingComplete()
	{
		m_RebindingContext.CleanUp();
		Refresh();
	}

	public void Refresh()
	{
		InputLine_KeyboardRebinding[] inputLines = m_InputLines;
		foreach (InputLine_KeyboardRebinding inputLine_KeyboardRebinding in inputLines)
		{
			if (inputLine_KeyboardRebinding.BtnRebinding0.gameObject.activeSelf)
			{
				inputLine_KeyboardRebinding.Text0.text = string.Empty;
				inputLine_KeyboardRebinding.InputPrompt0.Refresh();
			}
			if (inputLine_KeyboardRebinding.BtnRebinding1.gameObject.activeSelf)
			{
				inputLine_KeyboardRebinding.Text1.text = string.Empty;
				inputLine_KeyboardRebinding.InputPrompt1.Refresh();
			}
		}
	}
}
