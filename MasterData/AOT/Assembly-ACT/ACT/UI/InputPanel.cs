using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.EventTrack;
using ACT.Sound;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using FMODUnity;
using Fundamental;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace ACT.UI;

public class InputPanel : MonoBehaviour
{
	private class KeyRebindingRecord
	{
		public string oldBinding;

		public string[] newSolutionBindings = new string[3];
	}

	public Button BtnPreTab;

	public Button BtnNextTab;

	public GameObject BtnPreTabPrompt;

	public GameObject BtnNextTabPrompt;

	public GameObject PCTitle;

	public GameObject ControllerTitle;

	public InputPanelPCTab PCTab;

	public InputPanelControllerTab ControllerTab;

	public GameObject RebindingTip;

	public GameObject RebindingTip_Keyboard;

	public GameObject RebindingTip_Controller;

	public ViewControlLayer pcLayer;

	public ViewControlLayer controllerLayer;

	private int m_SelectedTabIndex;

	private RebindingContext m_RebindingContext;

	[Header("音效")]
	public EventReference OnSelectedSound;

	public AudioEventReference audioOnSelectedSound;

	public EventReference OnChangedSound;

	public AudioEventReference audioOnChangedSound;

	public EventReference OnResetSound;

	public AudioEventReference audioOnResetSound;

	private Dictionary<string, KeyRebindingRecord> m_KeyRebindings = new Dictionary<string, KeyRebindingRecord>();

	public int SelectedTabIndex
	{
		get
		{
			return m_SelectedTabIndex;
		}
		set
		{
			if (m_SelectedTabIndex != value)
			{
				m_SelectedTabIndex = value;
				RefreshTabVisible();
			}
		}
	}

	public bool IsRebinding
	{
		get
		{
			if (m_RebindingContext != null)
			{
				return m_RebindingContext.Started;
			}
			return false;
		}
	}

	private void Awake()
	{
		BtnPreTab.onClick.AddListener(OnBtnPreTabClicked);
		BtnNextTab.onClick.AddListener(OnBtnNextTabClicked);
		m_RebindingContext = new RebindingContext();
		PCTab.gameObject.SetActive(value: true);
		ControllerTab.gameObject.SetActive(value: true);
		PCTab.Init(m_RebindingContext);
		ControllerTab.Init(m_RebindingContext);
		PCTab.BtnResetToDefault.OnClick.AddListener(() =>
		{
			ResetToDefault(resetController: false);
		});
		ControllerTab.BtnResetToDefault.OnClick.AddListener(() =>
		{
			ResetToDefault(resetController: true);
		});
		pcLayer.Focus();
	}

	private void Update()
	{
		if (RebindingTip.activeInHierarchy)
		{
			switch (MonoECS.instance.InputMode)
			{
			case DeviceInputMode.Gamepad:
				RebindingTip_Controller.SetActive(value: true);
				RebindingTip_Keyboard.SetActive(value: false);
				break;
			case DeviceInputMode.KeyboardAndMouse:
				RebindingTip_Controller.SetActive(value: false);
				RebindingTip_Keyboard.SetActive(value: true);
				break;
			}
		}
	}

	public void ShowTip()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Error", new AudioPlayOptions
		{
			attachTarget = Camera.main.transform
		});
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
		{
			tableName = LocalizationUtility.localizeTableName_Common,
			localizeId = 2599,
			variableList = new List<string>()
		});
	}

	public void OnBtnPreTabClicked()
	{
		if (SelectedTabIndex != 0)
		{
			SelectedTabIndex = (m_SelectedTabIndex - 1 + 2) % 2;
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Change", new AudioPlayOptions
			{
				attachTarget = Camera.main.transform
			});
			PlaySwitchAnim();
		}
	}

	public void OnBtnNextTabClicked()
	{
		if (SelectedTabIndex != 1)
		{
			SelectedTabIndex = (m_SelectedTabIndex + 1) % 2;
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Change", new AudioPlayOptions
			{
				attachTarget = Camera.main.transform
			});
			PlaySwitchAnim();
		}
	}

	private void OnEnable()
	{
		RefreshTabVisible();
	}

	private void OnDisable()
	{
		m_SelectedTabIndex = 0;
		PCTab.GetComponent<CanvasGroup>().alpha = 1f;
	}

	private void RefreshTabVisible()
	{
		BtnPreTab.interactable = m_SelectedTabIndex == 1;
		BtnNextTab.interactable = m_SelectedTabIndex == 0;
		BtnPreTabPrompt.SetActive(m_SelectedTabIndex == 1);
		BtnNextTabPrompt.SetActive(m_SelectedTabIndex == 0);
		PCTitle.SetActive(m_SelectedTabIndex == 0);
		PCTab.gameObject.SetActive(m_SelectedTabIndex == 0);
		ControllerTitle.SetActive(m_SelectedTabIndex == 1);
		ControllerTab.gameObject.SetActive(m_SelectedTabIndex == 1);
	}

	public void PlaySwitchAnim()
	{
		GetComponent<BetterAnimation>().StopAnimation();
		switch (m_SelectedTabIndex)
		{
		case 0:
			GetComponent<BetterAnimation>().GetSequence("TabControllerToPC").Play().OnComplete((AnimationBuilder o) =>
			{
				controllerLayer.UnFocus();
				pcLayer.ReFocus();
			});
			break;
		case 1:
			GetComponent<BetterAnimation>().GetSequence("TabPCToController").Play().OnComplete((AnimationBuilder o) =>
			{
				pcLayer.UnFocus();
				controllerLayer.ReFocus();
			});
			break;
		}
	}

	public void ResetToDefault()
	{
		ResetToDefault(m_SelectedTabIndex == 1);
	}

	private void ResetToDefault(bool resetController)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/Key/Restore", new AudioPlayOptions
		{
			attachTarget = Camera.main.transform
		});
		GameObject currentSelection = EventSystemHelper.CurrentSelected;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			texts = new string[1] { resetController ? "是否将手柄界面的按键配置恢复为默认?" : "是否将PC界面的按键配置恢复为默认?" },
			OnConfirm = () =>
			{
				m_RebindingContext.CancelAndCleanUp();
				List<InputAction> list = new List<InputAction>();
				if (resetController)
				{
					InputLine_ControllerKeyRebinding[] inputLines = ControllerTab.InputLines;
					foreach (InputLine_ControllerKeyRebinding inputLine_ControllerKeyRebinding in inputLines)
					{
						ResetBindingToDefault(inputLine_ControllerKeyRebinding.InputPrompt, inputLine_ControllerKeyRebinding.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Gamepad, list);
					}
					ControllerTab.Refresh();
				}
				else
				{
					InputLine_KeyboardRebinding[] inputLines2 = PCTab.InputLines;
					foreach (InputLine_KeyboardRebinding inputLine_KeyboardRebinding in inputLines2)
					{
						ResetBindingToDefault(inputLine_KeyboardRebinding.InputPrompt0, inputLine_KeyboardRebinding.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard1, list);
						ResetBindingToDefault(inputLine_KeyboardRebinding.InputPrompt1, inputLine_KeyboardRebinding.ButtonBindingKey, ButtonBindingPathConfig.ButtonBindingSolution.Keyboard2, list);
					}
					PCTab.Refresh();
				}
				if (list.Count > 0)
				{
					MonoECS.instance.RefreshInputActionBindings(list.ToArray());
				}
				EventSystemHelper.SetSelectedGameObject(currentSelection);
				MonoECS.instance.SaveInputBindingOverride();
				TrackInputRebindingEvt evt = EventTrackSolver.Instance.GetEvt<TrackInputRebindingEvt>();
				evt.records.Clear();
				evt.isResetToDefault = true;
				EventTrackSolver.Instance.Dispatch(evt);
			},
			needPause = true
		});
	}

	private void ResetBindingToDefault(InputPromptByBindingPath prompt, string key, ButtonBindingPathConfig.ButtonBindingSolution solution, List<InputAction> changedActions)
	{
		if (prompt.InputBindingIndex >= 0 && !string.IsNullOrEmpty(prompt.InputActionPath) && prompt.TryGetAction(out var inputAction) && prompt.InputBindingIndex < inputAction.bindings.Count)
		{
			inputAction.RemoveBindingOverride(prompt.InputBindingIndex);
			if (!changedActions.Contains(inputAction))
			{
				changedActions.Add(inputAction);
			}
			if (m_KeyRebindings.TryGetValue(key, out var value))
			{
				value.newSolutionBindings[(int)(solution - 1)] = string.Empty;
			}
		}
	}

	public void Record(string key, ButtonBindingPathConfig.ButtonBindingSolution solution, string oldBinding, string newBinding)
	{
		if (!m_KeyRebindings.TryGetValue(key, out var value))
		{
			Dictionary<string, KeyRebindingRecord> keyRebindings = m_KeyRebindings;
			KeyRebindingRecord keyRebindingRecord = new KeyRebindingRecord
			{
				oldBinding = oldBinding
			};
			value = keyRebindingRecord;
			keyRebindings[key] = keyRebindingRecord;
		}
		if (string.Equals(value.oldBinding, newBinding))
		{
			value.newSolutionBindings[(int)(solution - 1)] = string.Empty;
		}
		else
		{
			value.newSolutionBindings[(int)(solution - 1)] = newBinding;
		}
	}

	public void SaveInputRebindingOverride()
	{
		MonoECS.instance.SaveInputBindingOverride();
		TrackInputRebindingEvt evt = EventTrackSolver.Instance.GetEvt<TrackInputRebindingEvt>();
		evt.isResetToDefault = false;
		evt.records.Clear();
		foreach (KeyValuePair<string, KeyRebindingRecord> keyRebinding in m_KeyRebindings)
		{
			for (int i = 0; i < keyRebinding.Value.newSolutionBindings.Length; i++)
			{
				if (!string.IsNullOrEmpty(keyRebinding.Value.newSolutionBindings[i]))
				{
					evt.records.Add((keyRebinding.Key.ToLower(), i, keyRebinding.Value.oldBinding, keyRebinding.Value.newSolutionBindings[i].ToLower()));
				}
			}
		}
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
