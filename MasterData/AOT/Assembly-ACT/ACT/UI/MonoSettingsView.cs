using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.LocalizationExtension;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;
using bamboosdk;

namespace ACT.UI;

public class MonoSettingsView : BaseUIView<SettingsInputViewInputController>
{
	[Serializable]
	public class TabInfo
	{
		[SerializeField]
		[FormerlySerializedAs("toggle")]
		private ActToggle _toggle;

		[SerializeField]
		[FormerlySerializedAs("panel")]
		private SettingPanel _panel;

		[SerializeField]
		[FormerlySerializedAs("controlLayer")]
		private ViewControlLayer _controlLayer;

		[SerializeField]
		[Tooltip("系统解锁表Id")]
		private int _systemId = -1;

		public int SystemId => _systemId;

		public ViewControlLayer ControlLayer => _controlLayer;

		public SettingPanel Panel => _panel;

		public ActToggle Toggle => _toggle;
	}

	[Serializable]
	public class SettingSystemUnlockItem
	{
		public GameObject target;

		public int systemId;
	}

	public GamePadTipsComp gamePadGroup;

	public UIPanelMove UIOffSet;

	private CanvasGroup controlCg;

	public RectTransform HideUI;

	[Header("例外")]
	public SettingCell CameraNoiseSet;

	public SettingCell GamepadRumbleSet;

	[Header("根据平台不同表现的组件")]
	public GameObject mobileInputRoot;

	public GameObject pcInputRoot;

	public AnimateToggle SwitchDetail;

	public GameObject uiOffsetCell;

	[Header("游戏")]
	public SettingSwitch silenceTipToggle;

	public GameObject mobileFovRoot;

	public GameObject CustomUISchemeRoot;

	public PublicToggle defaultSchemeToggle;

	public PublicToggle gamepadLikeSchemeToggle;

	public PublicToggle traditionSchemeToggle;

	public LocalizeStringEvent curSelectSchemeText;

	public PublicToggle customSchemeToggle;

	public ModifyCustomSchemePanel modifyCustomSchemePanel;

	public List<SettingCell> allCells;

	public int SelectTab;

	public List<TabInfo> tabInfos;

	[Header("功能解锁配置")]
	public List<SettingSystemUnlockItem> systemUnlockItems;

	public InputPanel InputPanel;

	public GameObject UIPanelOffsetTip;

	private SettingInfo evtTrack;

	private LocalQualitySettings m_quality;

	private SettingCell m_ResolutionCell;

	private CanvasGroup m_ResolutionCellCanvasGroup;

	private Selectable m_ResolutionCellSelectable;

	public LocalizeStringEvent _accountTitle;

	public LocalizeStringEvent _privateInfoCollectionText;

	public LocalizeStringEvent _recordNumberText;

	public GameObject exchangeCodeRoot;

	private static readonly HashSet<int> NormalDisableTabIndex = new HashSet<int> { 6 };

	private static readonly HashSet<int> LoginDisableTabIndex = new HashSet<int> { 1, 2, 3, 4, 5 };

	private const int _changeSchemeComplate = 2783;

	private const int _curSchemeIsDefault = 2779;

	private const int _curSchemeIsGamepadLike = 2780;

	private const int _curSchemeIsTradition = 2781;

	private const int _curSchemeIsCustom = 2782;

	private bool isSwitchUIOffset;

	public static string url_private = "https://pages.zhuziplay.com/privacyAgreement/1038/cn/";

	public static string url_child_private = "https://pages.zhuziplay.com/customPage/63";

	public static string url_licensing_service__private = "https://pages.zhuziplay.com/userAgreement/1038/cn";

	public static string url_share_private = "https://pages.zhuziplay.com/customPage/5";

	public static string url_record_private = "http://beian.miit.gov.cn/";

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public CanvasGroup ControlCg
	{
		get
		{
			return controlCg;
		}
		set
		{
			controlCg = value;
		}
	}

	private SettingPanel CurrentSettingPanel { get; set; }

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		try
		{
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				tabInfos[SelectTab].ControlLayer?.Focus();
				(GetInputBindingController() as SettingsInputViewInputController)?.FindCurrentCell();
			}
			CustomUISchemeRoot.SetActive(!MonoECS.instance.ispc && MonoECS.instance.InputMode == DeviceInputMode.TouchScreen);
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		base.OnInputDeviceChange(type);
	}

	private void Awake()
	{
		controlCg = HideUI.GetComponent<CanvasGroup>();
		for (int i = 0; i < tabInfos.Count; i++)
		{
			int index = i;
			TabInfo tabInfo = tabInfos[index];
			tabInfos[index].Toggle.onValueChanged.AddListener((bool v) =>
			{
				SettingPanel panel = tabInfos[index].Panel;
				if (v)
				{
					CurrentSettingPanel = panel;
					SelectTab = index;
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/Left_Click");
					panel.gameObject.SetActive(value: true);
					panel.ResetScrollToTop();
					panel.PlayOpenAnim(() =>
					{
						if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
						{
							tabInfos[index].ControlLayer?.Focus();
							(GetInputBindingController() as SettingsInputViewInputController)?.FindCurrentCell();
						}
					});
				}
				else
				{
					panel.PlayCloseAnim(() =>
					{
						panel.gameObject.SetActive(value: false);
					});
				}
			});
			tabInfo.Panel.gameObject.SetActive(value: false);
		}
	}

	protected override void Init()
	{
		base.Init();
		SetComponentWhenPC(MonoECS.instance.ispc);
		SelectTab = 0;
		tabInfos[SelectTab].Toggle.SetIsOn(val: true);
		tabInfos[SelectTab].Panel.gameObject.SetActive(value: true);
		tabInfos[SelectTab].Panel.ResetScrollToTop();
		tabInfos[SelectTab].ControlLayer.Focus();
		tabInfos[SelectTab].Panel.ResetScrollToTop();
		CorrectTabView();
		m_quality = LocalQualitySettings.ReadFromLocal();
		evtTrack = EventTrackSolver.Instance.GetEvt<SettingInfo>();
		evtTrack.RecordBefore();
		IsShowExchangeBtn();
		CustomUIScheme customUIScheme = Model<CustomUIModel>.Interface?.GetCurScheme();
		if (customUIScheme != null)
		{
			SetToggleBySchemeId(customUIScheme.Id);
		}
		SettingInt settingInt = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.CameraNoise");
		CameraNoiseSet.slider.minValue = 0f;
		CameraNoiseSet.slider.maxValue = 20f;
		CameraNoiseSet.slider.value = settingInt.GetValue();
		CameraNoiseSet.num.SetText(settingInt.GetValue().FastToString());
		SettingInt settingInt2 = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.GamepadRumble");
		GamepadRumbleSet.slider.minValue = 0f;
		GamepadRumbleSet.slider.maxValue = 20f;
		GamepadRumbleSet.slider.value = settingInt2.GetValue();
		GamepadRumbleSet.num.SetText(settingInt2.GetValue().FastToString());
		if (silenceTipToggle != null)
		{
			silenceTipToggle.CurrentIndex = ((m_quality.silenceTip != 1) ? 1 : 0);
		}
		InitializeThisSoundSettings();
		CheckSystemUnlock();
		OnGamePadInit();
		BindEvent();
	}

	protected override void ReInit()
	{
		base.ReInit();
		CorrectTabView();
	}

	private void CorrectTabView()
	{
		HashSet<int> disableHashSet = ((uiViewData is SettingsViewData { IsFromLogin: not false }) ? LoginDisableTabIndex : NormalDisableTabIndex);
		int num = -1;
		for (int i = 0; i < tabInfos.Count; i++)
		{
			TabInfo tabInfo = tabInfos[i];
			bool flag = TabIsAvailable(tabInfo, i, disableHashSet);
			tabInfo.Toggle.gameObject.SetActive(flag);
			if (!flag)
			{
				tabInfo.Panel.gameObject.SetActive(value: false);
			}
			if (flag && num < 0)
			{
				num = i;
			}
		}
		if (num >= 0 && TabIsAvailable(tabInfos[SelectTab], SelectTab, disableHashSet))
		{
			tabInfos[num].Toggle.SetIsOn(val: true);
		}
	}

	private static bool TabIsAvailable(TabInfo info, int index, HashSet<int> disableHashSet)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(info.SystemId))
		{
			return !disableHashSet.Contains(index);
		}
		return false;
	}

	private bool IsAssociatedTabToggleVisible(Component component)
	{
		if (component == null || tabInfos == null)
		{
			return false;
		}
		Transform transform = component.transform;
		for (int i = 0; i < tabInfos.Count; i++)
		{
			TabInfo tabInfo = tabInfos[i];
			if (!(tabInfo?.Panel == null) && !(tabInfo.Toggle == null))
			{
				Transform transform2 = tabInfo.Panel.transform;
				if (!(transform != transform2) || transform.IsChildOf(transform2))
				{
					return tabInfo.Toggle.gameObject.activeSelf;
				}
			}
		}
		return false;
	}

	protected void BindEvent()
	{
		SettingOptions settingOptions = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.WindowStyle");
		settingOptions?.AddChangedListener(OnWindowStyleChanged);
		if (settingOptions != null)
		{
			OnWindowStyleChanged(settingOptions.GetValue());
			RefreshWindowStyleStateNextFrame(settingOptions).Forget();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
	}

	private async UniTaskVoid RefreshWindowStyleStateNextFrame(SettingOptions windowStyle)
	{
		await UniTask.NextFrame();
		if (isActiveAndEnabled)
		{
			if (windowStyle.GetValue() == 0)
			{
				SetResolutionInteractable(interactable: false);
			}
			else
			{
				SetResolutionInteractable(interactable: true);
			}
		}
	}

	protected void UnbindEvent()
	{
		SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.WindowStyle")?.RemoveChangedListener(OnWindowStyleChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
	}

	private void OnSystemBlockStatusChanged(BaseEventContent obj)
	{
		CheckSystemUnlock();
	}

	protected void OnWindowStyleChanged(int arg)
	{
		SettingOptions settingOptions = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Resolution");
		if (settingOptions == null)
		{
			return;
		}
		bool flag = arg == 1;
		if (flag)
		{
			int value = PlayerPrefs.GetInt("Graphic.ResolutionCache", 0);
			if (settingOptions.GetConnection() is ResolutionConnectionSO.Connection connection && !connection.TryGetResolutionValue(value, out var _))
			{
				value = 0;
			}
			settingOptions.SetValue(value);
		}
		else
		{
			settingOptions.SetValue(0);
		}
		SetResolutionInteractable(flag);
	}

	private void SetResolutionInteractable(bool interactable)
	{
		SettingCell resolutionCell = GetResolutionCell();
		if (!(resolutionCell == null) && resolutionCell.dropdown != null)
		{
			resolutionCell.dropdown.interactable = interactable;
			resolutionCell.SetInteract(interactable);
		}
	}

	private SettingCell GetResolutionCell()
	{
		if (m_ResolutionCell != null)
		{
			return m_ResolutionCell;
		}
		if (allCells == null)
		{
			return null;
		}
		for (int i = 0; i < allCells.Count; i++)
		{
			SettingCell settingCell = allCells[i];
			if (settingCell == null)
			{
				continue;
			}
			List<SettingCellBindings> bindings = settingCell.bindings;
			for (int j = 0; j < bindings.Count; j++)
			{
				SettingCellBindings settingCellBindings = bindings[j];
				if (settingCellBindings.enabled && settingCellBindings.settingsKey == "Graphic.Resolution")
				{
					m_ResolutionCell = settingCell;
					return m_ResolutionCell;
				}
			}
		}
		return null;
	}

	protected override void UnInit()
	{
		base.UnInit();
		SettingsManager.Instance.Apply();
		SettingsManager.Instance.Save();
		bool flag = Model<ServerPlayerPrefs>.HasInstance();
		if (flag)
		{
			m_quality.SaveLocal();
		}
		EventTrackSolver.Instance.Dispatch(evtTrack);
		if (flag && IsAssociatedTabToggleVisible(InputPanel))
		{
			InputPanel.SaveInputRebindingOverride();
		}
		if (TextLanguageChangeTracker.ConsumePendingCloseAllOnSettingsClose())
		{
			Singleton<NewUIManager>.instance.CloseAllUIPreservePendingOpenQueue();
		}
		UnbindEvent();
	}

	protected override void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void SetComponentWhenPC(bool ispc)
	{
		mobileInputRoot.SetActive(!ispc);
		pcInputRoot.SetActive(ispc);
		uiOffsetCell.SetActive(!ispc);
		CustomUISchemeRoot.SetActive(!ispc && MonoECS.instance.InputMode == DeviceInputMode.TouchScreen);
	}

	protected override void OnInputControllerCreate()
	{
		GetController().SetupInputPanel(InputPanel);
	}

	public void LimitFrameRateInPhone(LocalizeTMP_Dropdown frameUI, LocalizeTMP_Dropdown qualityUltra, LocalizeTMP_Dropdown shadowUltra)
	{
		if (frameUI.options.Count > 2)
		{
			frameUI.options = new List<LocalizeTMP_Dropdown.OptionData>(frameUI.options.GetRange(0, 2));
			frameUI.RefreshShownValue();
		}
		if (qualityUltra.options.Count > 4)
		{
			qualityUltra.options.RemoveAt(3);
			qualityUltra.RefreshShownValue();
		}
		shadowUltra.options = new List<LocalizeTMP_Dropdown.OptionData>(shadowUltra.options.GetRange(0, 5));
		shadowUltra.RefreshShownValue();
	}

	private void InitializeThisSoundSettings()
	{
	}

	public void SetJoyStickMode(int select)
	{
	}

	public void SetMobileFixedCustomUIScheme(int select)
	{
		int mobileFixedIdByIndex = DeviceCustomUISchemeId.GetMobileFixedIdByIndex(select);
		Model<CustomUIModel>.Interface.SetMobileCurScheme(mobileFixedIdByIndex);
		SetToggleBySchemeId(mobileFixedIdByIndex);
		if (DeviceCustomUISchemeId.IsValidMobileFixedId(mobileFixedIdByIndex))
		{
			int id = mobileFixedIdByIndex switch
			{
				111 => 2779, 
				112 => 2780, 
				113 => 2781, 
			};
			curSelectSchemeText.SetReference(LocalizeTable.Common, id);
			GameUtility.OpenToolTip(2783, "Common", null, ignoreToolTipWaitQueue: true);
		}
	}

	public void UseMobileCustomCustomUIScheme()
	{
		int value = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.BtnScheme").GetValue();
		Model<CustomUIModel>.Interface.SetMobileCurScheme(value);
	}

	public void SetCameraNoiseForce(float scale)
	{
		CameraNoiseSet.num.SetText(((int)scale).FastToString());
	}

	private void SetToggleBySchemeId(int schemeId)
	{
		if (DeviceCustomUISchemeId.IsValidMobileCustomId(schemeId))
		{
			curSelectSchemeText.SetReference(LocalizeTable.Common, 2782);
			SetSchemeToggleState(customSchemeToggle, isSelected: true);
		}
		else
		{
			SetSchemeToggleState(customSchemeToggle, isSelected: false);
		}
		SetSchemeToggleState(defaultSchemeToggle, schemeId == 111);
		SetSchemeToggleState(gamepadLikeSchemeToggle, schemeId == 112);
		SetSchemeToggleState(traditionSchemeToggle, schemeId == 113);
		if (DeviceCustomUISchemeId.IsValidMobileFixedId(schemeId))
		{
			int id = schemeId switch
			{
				111 => 2779, 
				112 => 2780, 
				113 => 2781, 
			};
			curSelectSchemeText.SetReference(LocalizeTable.Common, id);
		}
	}

	private void SetSchemeToggleState(PublicToggle toggle, bool isSelected)
	{
		toggle?.SetIsOnWithoutNotifyAndRefreshVisual(isSelected);
	}

	public void SetGamepadRumbleForce(float scale)
	{
		GamepadRumbleSet.num.SetText(((int)scale).FastToString());
	}

	public void SetSilenceTip(int value)
	{
		m_quality.silenceTip = ((value != 1) ? 1 : 0);
	}

	public void OpenGMView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GM);
	}

	public void HideSettingView()
	{
		if (!isSwitchUIOffset)
		{
			isSwitchUIOffset = true;
			betterAnimation.GetSequence("Temphide").OnComplete((AnimationBuilder _) =>
			{
				UIOffSet.gameObject.SetActive(value: true);
				UIOffSet.ViewControlLayer.Focus();
				UIOffSet.betterAnimation.GetSequence("Show").Play();
				isSwitchUIOffset = false;
			}).Play();
		}
	}

	public void ShowModifyCustomSchemePanel()
	{
		int value = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.BtnScheme").GetValue();
		if (DeviceCustomUISchemeId.IsValidMobileFixedId(value))
		{
			Model<CustomUIModel>.Interface.SetMobileCurScheme(value);
		}
		betterAnimation.GetSequence("Temphide").OnComplete((AnimationBuilder _) =>
		{
			modifyCustomSchemePanel.Show(OnModifyCustomSchemePanelHide);
		}).Play();
	}

	public void HideModifyCustomSchemePanel()
	{
		modifyCustomSchemePanel.Hide();
	}

	private void OnModifyCustomSchemePanelHide()
	{
		ControlCg.alpha = 1f;
		betterAnimation.GetSequence("Show").Play();
		SetToggleBySchemeId(Model<CustomUIModel>.Interface.Scheme.CurScheme.Id);
	}

	public void OpenPrivate()
	{
		Application.OpenURL(url_private);
	}

	public void OpenChildPrivate()
	{
		Application.OpenURL(url_child_private);
	}

	public void OpenThirdPrivate()
	{
		Application.OpenURL(url_share_private);
	}

	public void OpenRecordNumberPrivate()
	{
		Application.OpenURL(url_record_private);
	}

	public void OpenLicensingServicePrivate()
	{
		Application.OpenURL(url_licensing_service__private);
	}

	public void OpenExchangeCodePopUpView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPEXCHANGECODE);
	}

	public void OpenUserCenter()
	{
		LuminBambooBridgeListener.Default.OpenUserCenter(UrlUtility.UserCenterBaseUrl);
	}

	private void Update()
	{
		if (UIController.State == UIState.Opened)
		{
			GetController()?.Tick();
		}
	}

	private void CheckSystemUnlock()
	{
		if (systemUnlockItems == null)
		{
			return;
		}
		bool flag = Singleton<SystemUnlockManager>.HasInstance() && G.localPlayer != null;
		foreach (SettingSystemUnlockItem systemUnlockItem in systemUnlockItems)
		{
			if (!(systemUnlockItem.target == null))
			{
				bool active = systemUnlockItem.systemId == 0 || (flag && Singleton<SystemUnlockManager>.instance.IsUnlock(systemUnlockItem.systemId));
				systemUnlockItem.target.SetActive(active);
			}
		}
	}

	private bool IsTabVisible(int index)
	{
		if (tabInfos == null || index < 0 || index >= tabInfos.Count)
		{
			return false;
		}
		TabInfo tabInfo = tabInfos[index];
		if (tabInfo?.Toggle != null)
		{
			return tabInfo.Toggle.gameObject.activeSelf;
		}
		return false;
	}

	private void SwitchTab(int direction)
	{
		if (tabInfos == null || tabInfos.Count == 0 || direction == 0)
		{
			return;
		}
		int num = -1;
		for (int i = 0; i < tabInfos.Count; i++)
		{
			if (IsTabVisible(i) && tabInfos[i].Toggle.IsOn)
			{
				num = i;
				break;
			}
		}
		int count = tabInfos.Count;
		if (num < 0)
		{
			num = ((direction > 0) ? (-1) : count);
		}
		for (int j = 1; j <= count; j++)
		{
			int index = ((num + direction * j) % count + count) % count;
			if (IsTabVisible(index))
			{
				tabInfos[index].Toggle.SetIsOn(val: true);
				break;
			}
		}
	}

	public void PreTab()
	{
		SwitchTab(-1);
	}

	public void NextTab()
	{
		SwitchTab(1);
	}

	private void IsShowExchangeBtn()
	{
		if (!(exchangeCodeRoot == null))
		{
			bool active = Singleton<SystemUnlockManager>.HasInstance() && G.localPlayer != null && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.ExchangeCode);
			exchangeCodeRoot.SetActive(active);
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["Settings/SettingsSliderLeft"] = new GamePadTipsAction
			{
				inputAction = "Settings/SettingsSliderLeft",
				localizeTable = "Common"
			},
			["Settings/SettingsSliderRight"] = new GamePadTipsAction
			{
				inputAction = "Settings/SettingsSliderRight",
				localizeKey = 2675,
				localizeTable = "Common"
			},
			["UI/RSLeftRightSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSLeftRightSelect",
				localizeKey = 2676,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			},
			["UI/UISpecial1"] = new GamePadTipsAction
			{
				inputAction = "UI/UISpecial1",
				localizeKey = 115,
				localizeTable = "Common"
			}
		};
	}

	public void ReBindBtnPrompt(bool detail, bool detailOpen, params string[] exceptActions)
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		foreach (string key in exceptActions)
		{
			_tipsActions.Add(_allInputPrompt[key]);
		}
		if (detail)
		{
			GamePadTipsAction item = _allInputPrompt["UI/UISpecial1"];
			if (detailOpen)
			{
				item.localizeKey = 115;
			}
			else
			{
				item.localizeKey = 2595;
			}
			_tipsActions.Add(item);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
