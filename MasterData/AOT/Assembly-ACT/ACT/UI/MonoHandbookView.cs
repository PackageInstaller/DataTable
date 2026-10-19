using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.UI.InputController;
using ACT.UI.Interface;
using ACT.UI.WildBossBattle;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoHandbookView : BaseUIView<HandBookViewInputController>
{
	public PowerBar costPowerBar;

	[Space]
	[SerializeField]
	private CommonTabListComponent _tabListComponent;

	[SerializeField]
	private GameObject _tabTemplate;

	[Header("页签面板")]
	[SerializeField]
	public DailyRewardTabView _dailyMissionContent;

	[SerializeField]
	public RaidTabView _raidContent;

	[SerializeField]
	public TargetGuidView _targetGuidContent;

	[SerializeField]
	public TrainingTabView _trainingTabView;

	[SerializeField]
	public PowerExchangeTabView _powerExchangeTabView;

	[SerializeField]
	public Dictionary<HandBookSubController, ViewControlLayer> ViewControlLayers;

	[SerializeField]
	public Dictionary<HandBookSubController, List<GameObject>> ViewControlPrompt;

	public GamePadTipsComp gamePadTips;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private Dictionary<int, GameObject> _tabs;

	private HandBookViewParam _viewParam => uiViewData as HandBookViewParam;

	public HandBookTab ActiveTab => _tabListComponent.ActiveTab as HandBookTab;

	private void Awake()
	{
		_dailyMissionContent.gameObject.SetActive(value: false);
		_raidContent.gameObject.SetActive(value: false);
		_trainingTabView.gameObject.SetActive(value: false);
		_tabs = DictionaryPool<int, GameObject>.Get();
		foreach (KeyValuePair<int, HandBookMain> handBookMain in RuntimeConfigs.data.handBookMains)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(_tabTemplate, _tabListComponent.TabRoot, worldPositionStays: false);
			gameObject.GetComponent<ITabItem>().TabIdentify = handBookMain.Key;
			_tabs.Add(handBookMain.Key, gameObject);
		}
	}

	protected override void OnUnityDestroy()
	{
		_tabs.Clear();
		DictionaryPool<int, GameObject>.Release(_tabs);
		_tabs = null;
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		InitGameTipsDic();
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("UI/Confirm", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("UI/RSUpDownSelect", new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		});
	}

	protected override void Init()
	{
		base.Init();
		Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(1008);
		_tabListComponent.TabItems.Clear();
		foreach (KeyValuePair<int, GameObject> tab in _tabs)
		{
			GameObject value = tab.Value;
			HandBookTab component = value.GetComponent<HandBookTab>();
			Station.LoadImageAsync(169, tab.Key, component.normalIcon).Forget();
			Station.LoadImageAsync(190, tab.Key, component.selectedIcon).Forget();
			component.normalText.SetTable(LocalizeTable.ShortCommon);
			component.normalText.StringReference.TableEntryReference = component.HandBookData.contentLv1name;
			component.selectedText.SetTable(LocalizeTable.ShortCommon);
			component.selectedText.StringReference.TableEntryReference = component.HandBookData.contentLv1name;
			RedDotItem redDotItem = component.redDotItem;
			value.SetActive(value: true);
			switch (tab.Key)
			{
			case 1:
				component.Content = _dailyMissionContent;
				_dailyMissionContent.SetView(this);
				_dailyMissionContent.mainTitle.SetTable("shortcommon");
				_dailyMissionContent.mainTitle.StringReference.TableEntryReference = component.HandBookData.contentLv1name;
				redDotItem?.InitRedDot(RedDotPathDefine.DailyMission);
				break;
			case 2:
				component.Content = _targetGuidContent;
				_targetGuidContent.SetView(this);
				redDotItem?.InitRedDot(RedDotPathDefine.HasTargetGuideReward);
				break;
			case 3:
				component.Content = _raidContent;
				component.Context = uiViewData;
				_raidContent.SetView(this);
				redDotItem?.InitRedDot(RedDotPathDefine.BossRaid);
				break;
			case 4:
				component.Content = _trainingTabView;
				component.Context = uiViewData;
				_trainingTabView.SetView(this);
				break;
			case 5:
				component.Content = _powerExchangeTabView;
				component.Context = uiViewData;
				_powerExchangeTabView.SetView(this);
				break;
			}
			_tabListComponent.TabItems.Add(component);
		}
		if (_viewParam != null && _tabs.TryGetValue(_viewParam.H1TabIndex, out var value2))
		{
			HandBookTab component2 = value2.GetComponent<HandBookTab>();
			if (IsTabAvailable(component2))
			{
				_tabListComponent.ActiveTab = component2;
			}
			else
			{
				ITabItem firstAvailableTab = GetFirstAvailableTab();
				if (firstAvailableTab != null)
				{
					_tabListComponent.ActiveTab = firstAvailableTab;
				}
			}
		}
		else
		{
			ITabItem firstAvailableTab2 = GetFirstAvailableTab();
			if (firstAvailableTab2 != null)
			{
				_tabListComponent.ActiveTab = firstAvailableTab2;
			}
		}
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (_tabListComponent != null)
		{
			_tabListComponent.ActiveTab = null;
		}
		FinishAllTabContentsImmediately();
	}

	private void FinishAllTabContentsImmediately()
	{
		List<CommonTabListComponent> list = ListPool<CommonTabListComponent>.Get();
		try
		{
			GetComponentsInChildren(includeInactive: true, list);
			for (int i = 0; i < list.Count; i++)
			{
				ObservableCollection<ITabItem> tabItems = list[i].TabItems;
				for (int j = 0; j < tabItems.Count; j++)
				{
					if (tabItems[j]?.Content is BaseTabContent baseTabContent)
					{
						baseTabContent.SetContentVisible(visible: false);
					}
				}
			}
		}
		finally
		{
			ListPool<CommonTabListComponent>.Release(list);
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
	}

	private void OnSystemBlockStatusChanged(BaseEventContent content)
	{
		if (!(content is SystemBlockStatusChangedEvt { status: not null } systemBlockStatusChangedEvt) || systemBlockStatusChangedEvt.status.MainID != 1008 || _tabs == null || _tabListComponent == null || _tabListComponent.TabItems.Count == 0)
		{
			return;
		}
		HandBookTab activeTab = ActiveTab;
		if (activeTab != null && !IsTabAvailable(activeTab))
		{
			ITabItem firstAvailableTab = GetFirstAvailableTab();
			if (firstAvailableTab != null)
			{
				_tabListComponent.ActiveTab = firstAvailableTab;
				activeTab = ActiveTab;
			}
		}
		foreach (KeyValuePair<int, GameObject> tab in _tabs)
		{
			HandBookTab handBookTab = ((tab.Value != null) ? tab.Value.GetComponent<HandBookTab>() : null);
			if (!(handBookTab == null) && (object)handBookTab != activeTab)
			{
				handBookTab.gameObject.SetActive(IsTabAvailable(handBookTab));
			}
		}
	}

	private ITabItem GetFirstAvailableTab()
	{
		foreach (ITabItem tabItem in _tabListComponent.TabItems)
		{
			if (IsTabAvailable(tabItem))
			{
				return tabItem;
			}
		}
		return null;
	}

	private static bool IsTabAvailable(ITabItem tabItem)
	{
		if (tabItem != null)
		{
			return tabItem.CanActive?.Invoke() ?? true;
		}
		return false;
	}

	protected override UniTask PlayPushStackAsync(CancellationToken token)
	{
		(ActiveTab.Content as BaseTabContent)?.OnPushStack();
		return base.PlayPushStackAsync(token);
	}

	protected override UniTask PlayPopStackAsync(CancellationToken token)
	{
		(ActiveTab.Content as BaseTabContent)?.OnPopStack();
		return base.PlayPopStackAsync(token);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void OpenBuyPowerView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
	}

	public void ClickAddPowerBar()
	{
		if (ActiveTab.Content is RaidTabView raidTabView && raidTabView.ActiveTab.Content is WildBossBattleTabView wildBossBattleTabView)
		{
			wildBossBattleTabView.helpBtn.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
		}
		else if (costPowerBar != null && costPowerBar.addPowerBtn != null)
		{
			costPowerBar.addPowerBtn.OnClick.Invoke();
		}
	}

	public void ClickToggle(bool isAdd = false)
	{
		int num = _tabListComponent.TabItems.IndexOf(_tabListComponent.ActiveTab);
		if (num < 0)
		{
			return;
		}
		if (isAdd)
		{
			if (num >= _tabListComponent.TabItems.Count - 1)
			{
				return;
			}
			for (int i = num + 1; i < _tabListComponent.TabItems.Count; i++)
			{
				Func<bool> canActive = _tabListComponent.TabItems[i].CanActive;
				if (canActive == null || canActive())
				{
					_tabListComponent.ActiveTab = _tabListComponent.TabItems[i];
					break;
				}
			}
		}
		else
		{
			if (num <= 0)
			{
				return;
			}
			for (int num2 = num - 1; num2 >= 0; num2--)
			{
				Func<bool> canActive2 = _tabListComponent.TabItems[num2].CanActive;
				if (canActive2 == null || canActive2())
				{
					_tabListComponent.ActiveTab = _tabListComponent.TabItems[num2];
					break;
				}
			}
		}
	}

	public override void Close()
	{
		if (_viewParam != null)
		{
			_viewParam.OnClose?.Invoke();
			_viewParam.OnClose = null;
		}
		base.Close();
		if (MonoECS.instance.sceneStatus == SceneStatus.Raid)
		{
			Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode mode)
	{
		base.OnInputDeviceChange(mode);
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public HandBookSubController GetCurSubControllerType()
	{
		return GetController()?.ControllerType ?? HandBookSubController.dairyMain;
	}

	public void SetGamePadTipsActive(bool active)
	{
		HandBookViewInputController controller = GetController();
		if (controller != null && active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && ViewControlLayers.TryGetValue(controller.ControllerType, out var value))
		{
			value.ReFocus();
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(controller.ControllerType);
			}
		}
	}

	public void ChangeToGamePadInputState(HandBookSubController type, bool needReFocusLayer = false)
	{
		HandBookViewInputController controller = GetController();
		if (controller == null)
		{
			return;
		}
		controller.ControllerType = type;
		if (ViewControlLayers.TryGetValue(type, out var value))
		{
			if (needReFocusLayer)
			{
				value?.ReFocus();
			}
			else
			{
				value?.Focus();
			}
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(controller.ControllerType);
			}
		}
	}

	public void GamePadTipsStatusChange(HandBookSubController subController)
	{
		foreach (KeyValuePair<HandBookSubController, List<GameObject>> item in ViewControlPrompt)
		{
			foreach (GameObject item2 in item.Value)
			{
				item2.SetActive(value: false);
			}
		}
		if (ViewControlPrompt.TryGetValue(subController, out var value))
		{
			foreach (GameObject item3 in value)
			{
				item3.SetActive(value: true);
			}
		}
		gamePadTips.ClearAllPrompts();
		_tipsActions.Clear();
		switch (subController)
		{
		case HandBookSubController.targetGuideMain:
		{
			_tipsActions.Add(actionDic["UI/Back"]);
			LoopVerticalScrollRect guideScrollRect = _targetGuidContent.guideScrollRect;
			if (guideScrollRect.content.sizeDelta.y > guideScrollRect.viewport.rect.height)
			{
				_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		}
		case HandBookSubController.dairyMain:
			_tipsActions.Add(actionDic["UI/Back"]);
			_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case HandBookSubController.dairySelectItem:
		case HandBookSubController.commonSelectItem:
		case HandBookSubController.targetGuideRewardItem:
		case HandBookSubController.targetGuideSelectItem:
		case HandBookSubController.raidMain:
		case HandBookSubController.raidSelectItem:
		case HandBookSubController.characterTutorialMain:
		case HandBookSubController.characterTeamTutorialSelectItem:
		case HandBookSubController.powerExchangeItem:
			_tipsActions.Add(actionDic["UI/Confirm"]);
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case HandBookSubController.raidContent:
		case HandBookSubController.raidNoFocusContent:
		case HandBookSubController.rewardWindow:
		case HandBookSubController.characterTeamTutorialContent:
		case HandBookSubController.powerExchangeContent:
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		}
	}

	public void HandleGamePadItemInput(HandBookSubController type)
	{
		switch (type)
		{
		case HandBookSubController.dairyMain:
			ChangeToGamePadInputState(HandBookSubController.dairySelectItem);
			break;
		case HandBookSubController.targetGuideMain:
			if (_targetGuidContent.chapterRewardBtn.gameObject.activeSelf)
			{
				_targetGuidContent.chapterRewardBtn.OnClick?.Invoke();
			}
			break;
		}
	}

	public void HandleGamePadReturnButtonInput(HandBookSubController type)
	{
		switch (type)
		{
		case HandBookSubController.dairyMain:
		case HandBookSubController.targetGuideMain:
		case HandBookSubController.raidMain:
		case HandBookSubController.raidNoFocusContent:
		case HandBookSubController.characterTutorialMain:
		case HandBookSubController.powerExchangeContent:
			Close();
			break;
		case HandBookSubController.dairySelectItem:
			ChangeToGamePadInputState(HandBookSubController.dairyMain, needReFocusLayer: true);
			break;
		case HandBookSubController.rewardWindow:
			ChangeToGamePadInputState(HandBookSubController.dairySelectItem, needReFocusLayer: true);
			_dailyMissionContent.rewardPanel.ClosePanel();
			ViewControlLayers[HandBookSubController.rewardWindow].SetDefaultSelect(null);
			break;
		case HandBookSubController.commonSelectItem:
			ChangeToGamePadInputState(HandBookSubController.rewardWindow, needReFocusLayer: true);
			break;
		case HandBookSubController.targetGuideRewardItem:
			ChangeToGamePadInputState(HandBookSubController.targetGuideMain, needReFocusLayer: true);
			break;
		case HandBookSubController.targetGuideSelectItem:
			ChangeToGamePadInputState(HandBookSubController.targetGuideMain, needReFocusLayer: true);
			break;
		case HandBookSubController.raidSelectItem:
			if (ViewControlLayers[HandBookSubController.raidNoFocusContent].DefaultSelect != null)
			{
				ChangeToGamePadInputState(HandBookSubController.raidNoFocusContent, needReFocusLayer: true);
			}
			else
			{
				ChangeToGamePadInputState(HandBookSubController.raidContent, needReFocusLayer: true);
			}
			break;
		case HandBookSubController.raidContent:
			ChangeToGamePadInputState(HandBookSubController.raidMain, needReFocusLayer: true);
			break;
		case HandBookSubController.characterTeamTutorialContent:
			ChangeToGamePadInputState(HandBookSubController.characterTutorialMain, needReFocusLayer: true);
			break;
		case HandBookSubController.characterTeamTutorialSelectItem:
			ChangeToGamePadInputState(HandBookSubController.characterTeamTutorialContent, needReFocusLayer: true);
			break;
		case HandBookSubController.powerExchangeItem:
			ChangeToGamePadInputState(HandBookSubController.powerExchangeContent);
			break;
		}
	}

	public void HandleGamePadSelectButtonInput(HandBookSubController type)
	{
		switch (type)
		{
		case HandBookSubController.dairyMain:
			if (GetController() != null && EventSystemHelper.CurrentSelected != null)
			{
				DailyTaskItem component2 = EventSystemHelper.CurrentSelected.GetComponent<DailyTaskItem>();
				if (component2 != null && component2.GetActiveButton() != null)
				{
					component2.GetActiveButton().OnClick?.Invoke();
				}
			}
			break;
		case HandBookSubController.targetGuideMain:
			if (EventSystemHelper.CurrentSelected != null)
			{
				TargetGuideCell component = EventSystemHelper.CurrentSelected.GetComponent<TargetGuideCell>();
				if (component != null && component.GetActiveButton() != null)
				{
					component.GetActiveButton().OnClick?.Invoke();
				}
			}
			break;
		case HandBookSubController.dairySelectItem:
		case HandBookSubController.commonSelectItem:
		case HandBookSubController.targetGuideRewardItem:
		case HandBookSubController.targetGuideSelectItem:
		case HandBookSubController.raidSelectItem:
			HandleCurrentSelectGameObjByGamePad();
			break;
		case HandBookSubController.powerExchangeContent:
			_powerExchangeTabView.confirmButton?.OnClick?.Invoke();
			break;
		case HandBookSubController.raidMain:
			ChangeToGamePadInputState(HandBookSubController.raidContent);
			break;
		case HandBookSubController.characterTutorialMain:
			ChangeToGamePadInputState(HandBookSubController.characterTeamTutorialContent);
			break;
		case HandBookSubController.raidContent:
		case HandBookSubController.raidNoFocusContent:
			if (_raidContent.ActiveTab.Content is RaidTabViewInterface raidTabViewInterface)
			{
				raidTabViewInterface.GetActiveSelectButton().OnClick?.Invoke();
			}
			break;
		case HandBookSubController.characterTeamTutorialContent:
			GetCurrentSelectedCharacterTutorialEntrance()?.EnterRaidByGamepad();
			break;
		case HandBookSubController.characterTeamTutorialSelectItem:
			HandleCurrentSelectGameObjByGamePad();
			break;
		case HandBookSubController.rewardWindow:
			break;
		}
	}

	public void ChangeToCharacterTutorialSelectItem()
	{
		CharacterTutorialRaidEntrance currentSelectedCharacterTutorialEntrance = GetCurrentSelectedCharacterTutorialEntrance();
		if (!(currentSelectedCharacterTutorialEntrance == null) && ViewControlLayers != null && currentSelectedCharacterTutorialEntrance.TryGetRewardLayer(out var rewardLayer))
		{
			ViewControlLayers[HandBookSubController.characterTeamTutorialSelectItem] = rewardLayer;
			ChangeToGamePadInputState(HandBookSubController.characterTeamTutorialSelectItem);
		}
	}

	private CharacterTutorialRaidEntrance GetCurrentSelectedCharacterTutorialEntrance()
	{
		GameObject gameObject = (EventSystemHelper.Available ? EventSystemHelper.CurrentSelected : null);
		if (!(gameObject != null))
		{
			return null;
		}
		return gameObject.GetComponentInParent<CharacterTutorialRaidEntrance>();
	}

	private void HandleCurrentSelectGameObjByGamePad()
	{
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}
}
