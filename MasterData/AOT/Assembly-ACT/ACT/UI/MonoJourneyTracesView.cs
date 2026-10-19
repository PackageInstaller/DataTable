using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class MonoJourneyTracesView : BaseUIView<MonoJourneyTracesViewInputController>
{
	private MonoJourneyTracesViewData m_data;

	public int defaultSelectIndex;

	public ActToggleGroup toggleGroup;

	[OdinSerialize]
	public Dictionary<JourneyTraceSubController, List<GameObject>> ViewControlPrompt;

	[OdinSerialize]
	public Dictionary<JourneyTraceSubController, ViewControlLayer> ViewControlLayers;

	public GamePadTipsComp gamePadTips;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private const int LocalizeSelect = 774;

	private const int LocalizePlace = 2628;

	public WorldLevelPage worldLevelPage;

	public SystemGuideTabView systemGuideTabView;

	private bool m_refresh;

	private int m_curTabID;

	[OdinSerialize]
	private Dictionary<int, List<RedDotItem>> _redDotItems;

	public int CurTabID => m_curTabID;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_WorldLevelPageRefresh, SetRedDotStatus);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ClickWorldLevelBreakBtn, PlayAnimationWhenClickBreakBtn);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PopRewardClose, PlayAnimationAfterBreakViewClose);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_WorldLevelPageRefresh, SetRedDotStatus);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_ClickWorldLevelBreakBtn, PlayAnimationWhenClickBreakBtn);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PopRewardClose, PlayAnimationAfterBreakViewClose);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as MonoJourneyTracesViewData;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		InitGameTipsDic();
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("LargeMapView/Select", new GamePadTipsAction
		{
			inputAction = "LargeMapView/Select",
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
		m_refresh = true;
		worldLevelPage.gameObject.SetActive(value: true);
		systemGuideTabView.gameObject.SetActive(value: false);
		SetRedDotStatus();
		if (m_data != null && m_data.tabIndex != 0)
		{
			toggleGroup.SetAllToggleOff();
			toggleGroup.SetToggleOn(m_data.tabIndex);
			m_curTabID = m_data.tabIndex;
		}
		else
		{
			toggleGroup.Init();
			toggleGroup.SetToggleOn(0);
			m_curTabID = 0;
		}
	}

	private void SetRedDotStatus(BaseEventContent obj)
	{
		SetRedDotStatus();
	}

	private void SetRedDotStatus()
	{
		for (int i = 0; i < toggleGroup.ToggleCount; i++)
		{
			string text = "";
			switch (i)
			{
			case 0:
				text = RedDotPathDefine.SystemGuideTab;
				break;
			case 1:
				text = RedDotPathDefine.WorldLevelTab;
				break;
			}
			RedDotDisplayAction redDotDisplayAction = GetRedDotDisplayAction(i);
			if (!(text != "") || !_redDotItems.TryGetValue(i, out var value))
			{
				continue;
			}
			foreach (RedDotItem item in value)
			{
				item.redDotType = RedDotType.Dot;
				item.fullPath = text.Split("|").ToList();
				item.displayAction = redDotDisplayAction;
				item.BindTrieNode();
				item.UpdateDisplay();
			}
		}
	}

	private RedDotDisplayAction GetRedDotDisplayAction(int tab)
	{
		return tab switch
		{
			0 => (RedDotDisplayAction)new WorldLevelRewardOnTab(), 
			1 => new SystemGuideRewardOnTab(), 
			_ => null, 
		};
	}

	public void OnInventoryPageChange(int tabID)
	{
		if (m_curTabID != 0 && tabID == 0)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GrowthPath/Left_Click");
		}
		if (m_curTabID == 0 && tabID != 0)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GrowthPath/Left_Click");
		}
		switch (tabID)
		{
		case 0:
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.WorldLevelTab);
			worldLevelPage.gameObject.SetActive(value: true);
			worldLevelPage.Refresh(this);
			systemGuideTabView.PlayAnimation(0, this);
			if (!TryFocusWorldLevelTaskGroupForGamepad())
			{
				ChangeToGamePadInputState(JourneyTraceSubController.main);
			}
			break;
		case 1:
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.JourneyTracesTab);
			worldLevelPage.gameObject.SetActive(value: false);
			systemGuideTabView.gameObject.SetActive(value: true);
			systemGuideTabView.PlayAnimation(1, this);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GrowthPath/Path_Animation");
			ChangeToGamePadInputState(JourneyTraceSubController.SystemGuide);
			break;
		}
		m_curTabID = tabID;
		m_refresh = false;
	}

	public bool TryFocusWorldLevelTaskGroupForGamepad(bool needReFocusLayer = false)
	{
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad || worldLevelPage == null || !worldLevelPage.gameObject.activeInHierarchy || !worldLevelPage.TryEnterWorldLevelTaskGroupSelection())
		{
			return false;
		}
		ChangeToGamePadInputState(JourneyTraceSubController.SelectWorldLevelTaskGroup, needReFocusLayer);
		worldLevelPage.TryEnterWorldLevelTaskGroupSelection();
		return true;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (m_curTabID == 0)
		{
			betterAnimation.GetSequence("Show").Play();
		}
		OpenEffectFinishNew();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		toggleGroup.SetAllToggleOff();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (m_curTabID == 0)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void PlayAnimationWhenClickBreakBtn(BaseEventContent obj)
	{
		betterAnimation.GetSequence("LevelUpHide")?.OnComplete(async (AnimationBuilder _) =>
		{
			await UniTask.WaitUntil(() => Model<WorldLevelModel>.Interface.BeforeBreakWorldLevel != Model<WorldLevelModel>.Interface.GetCurWorldLevel());
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPWORLDLEVELUPGRADE);
		}).Play();
	}

	private void PlayAnimationAfterBreakViewClose(BaseEventContent obj)
	{
		betterAnimation.GetSequence("LevelUpShow")?.OnComplete(async (AnimationBuilder _) =>
		{
		}).Play();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadTipsActive(bool active)
	{
		MonoJourneyTracesViewInputController controller = GetController();
		if (controller == null)
		{
			return;
		}
		if (!active || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			worldLevelPage?.RefreshWorldLevelGamepadPromptState(active: false);
			worldLevelPage?.RefreshWorldLevelTaskGamepadStates();
		}
		else if (controller.ControllerType != JourneyTraceSubController.main || m_curTabID != 0 || !TryFocusWorldLevelTaskGroupForGamepad(needReFocusLayer: true))
		{
			GamePadTipsStatusChange(controller.ControllerType);
			worldLevelPage?.RefreshWorldLevelGamepadPromptState(IsWorldLevelGamepadState(controller.ControllerType));
			if (ViewControlLayers.TryGetValue(controller.ControllerType, out var value) && value != null)
			{
				value.ReFocus();
			}
		}
	}

	public void GamePadTipsStatusChange(JourneyTraceSubController subController)
	{
		foreach (KeyValuePair<JourneyTraceSubController, List<GameObject>> item in ViewControlPrompt)
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
		case JourneyTraceSubController.main:
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case JourneyTraceSubController.SystemGuideSideBar:
			_tipsActions.Add(actionDic["UI/Back"]);
			if (systemGuideTabView.bookViewMultiplePrefabsOSA.GetRightScrollPromptActive())
			{
				_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case JourneyTraceSubController.SelectItem:
		case JourneyTraceSubController.SystemGuide:
			_tipsActions.Add(actionDic["LargeMapView/Select"]);
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case JourneyTraceSubController.SelectWorldLevelTaskGroup:
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		}
	}

	public JourneyTraceSubController GetCurSubControllerType()
	{
		return GetController()?.ControllerType ?? JourneyTraceSubController.main;
	}

	public void ChangeToGamePadInputState(JourneyTraceSubController type, bool needReFocusLayer = false)
	{
		MonoJourneyTracesViewInputController controller = GetController();
		if (controller == null)
		{
			return;
		}
		controller.ControllerType = type;
		if (ViewControlLayers.TryGetValue(type, out var value) && value != null)
		{
			if (needReFocusLayer)
			{
				value.ReFocus();
			}
			else
			{
				value.Focus();
			}
		}
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			GamePadTipsStatusChange(controller.ControllerType);
		}
		worldLevelPage?.RefreshWorldLevelGamepadPromptState(IsWorldLevelGamepadState(controller.ControllerType));
		worldLevelPage?.RefreshWorldLevelTaskGamepadStates();
	}

	private static bool IsWorldLevelGamepadState(JourneyTraceSubController type)
	{
		if (type != JourneyTraceSubController.main)
		{
			return type == JourneyTraceSubController.SelectWorldLevelTaskGroup;
		}
		return true;
	}

	public void HandleGamePadSelectButtonInput(JourneyTraceSubController type)
	{
		if ((uint)(type - 1) <= 1u)
		{
			HandleCurrentSelectGameObjByGamePad(1);
		}
	}

	public void HandleGamePadReturnButtonInput(JourneyTraceSubController type)
	{
		switch (type)
		{
		case JourneyTraceSubController.main:
		case JourneyTraceSubController.SystemGuide:
		case JourneyTraceSubController.SelectWorldLevelTaskGroup:
			Close();
			break;
		case JourneyTraceSubController.SelectItem:
			if (m_curTabID != 0 || !TryFocusWorldLevelTaskGroupForGamepad(needReFocusLayer: true))
			{
				ChangeToGamePadInputState(JourneyTraceSubController.main, needReFocusLayer: true);
			}
			break;
		case JourneyTraceSubController.SystemGuideSideBar:
			systemGuideTabView.bookViewMultiplePrefabsOSA.OnCloseRightPanel();
			break;
		}
	}

	private void HandleCurrentSelectGameObjByGamePad(int indexType, int direction = -1)
	{
		if (!EventSystemHelper.CurrentSelected)
		{
			return;
		}
		if ((uint)(indexType - 1) > 2u)
		{
			_ = 4;
			return;
		}
		ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler.OnSubmit(data);
		});
	}
}
