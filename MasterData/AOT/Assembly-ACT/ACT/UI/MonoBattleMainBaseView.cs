using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.Drama;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.UI;

public class MonoBattleMainBaseView : BaseUIView<BattleMainInputController>
{
	private MonoBattleMainBaseViewData m_PrivateData;

	public AnimationCurve displayCurve;

	public TouchUIMaskBloodBar BloodBar;

	public TouchUIMaskShieldBar ShieldBar;

	public JoyStick OnMove;

	public MiniMap miniMapNew;

	[Header("各个UI节点的canvasGroup")]
	public CanvasGroup customUIRoot;

	[FormerlySerializedAs("BattleState")]
	public CanvasGroup BattleStateRoot;

	public CanvasGroup leftTopUIRoot;

	public CanvasGroup menuRoot;

	public CanvasGroup subWorldRoot;

	public InteractBtnList interactBtnList;

	public InteractElevatorBtnList interactElevatorBtnList;

	[SerializeField]
	private MonoInteractChangeHint monoInteractChangeHint;

	[FormerlySerializedAs("taskRoot")]
	[Header("任务相关")]
	public TaskTipManager taskManager;

	[Range(0f, 1f)]
	public float semiMajorAxis = 1f;

	[Range(0f, 1f)]
	public float semiMinorAxis = 1f;

	public Transform monsterUIRoot;

	public BossInfoComp bossInfoComp;

	public WheelDiscComponent WheelDisc;

	public TriggerGuideTutorialComponent tutorialComponent;

	public MonoAsideView asideUIComp;

	public MonoSideMissionView sideMissionView;

	public PropPickComponent normalPickingView;

	public MonoMiddlePropPickingView middlePickingView;

	public MonoPopUpPlayerAdventureTip PlayerAdventureTip;

	public RegionNameTip regionNameTip;

	public TextLibraryPropPickComponent textLibraryPropPick;

	public RaidOpeningPerformance raidOpeningPerformance;

	[SerializeField]
	private ChallengeTipComponent _challengeTipComponent;

	public AchievementHudTips achievementHudTips;

	public TreasureGetHudTips treasureGetHudTips;

	public WorldLevelBreakTaskTips worldLevelBreakTaskTips;

	public CanvasGroup handleMode_MenuList;

	public CanvasGroup normal_MenuList;

	public GamePadMenuList _gamePadMenuList;

	[Header("世界场景切换时改变状态的UI，子世界隐藏，大世界显示")]
	[FormerlySerializedAs("LeaveState")]
	public GameObject LeaveSubWorldBtn;

	public GameObject raidSceneUI;

	public GameObject trainingGroundUI;

	public BattleMainTempleComponent templeUI;

	public GameObject abyssUI;

	public GameObject characterTutrialUI;

	public GameObject characterTrialUI;

	public GameObject rogueUIRoot;

	public ActButton BtnRogueBag;

	public GameObject characterTeamTutorial;

	public GameObject teamTeachingTarget;

	[Header("Esc")]
	public GameObject EscButton;

	public OperateBtnComp operateBtnComp;

	public List<GameObject> battleMainComponentList = new List<GameObject>();

	public GameObject missionInstruction;

	private bool isneedroguetips;

	private int currentRogueInteractId;

	public Dictionary<int, EscItem> AllEscItem = new Dictionary<int, EscItem>();

	private bool hasAddEventListener;

	public MonoBattleMainBaseViewData m_Data
	{
		get
		{
			return m_PrivateData ?? (m_PrivateData = new MonoBattleMainBaseViewData());
		}
		set
		{
			m_PrivateData = value;
		}
	}

	public MonoInteractChangeHint MonoInteractChangeHint => monoInteractChangeHint;

	public bool InteractTab => Model<InteractModel>.Interface.IsTabLongPress;

	public override UniTask PreInit()
	{
		Singleton<EntityUIManager>.instance.SetEntityUIRoot(monsterUIRoot);
		InitializeBattleMainComponentList();
		RefreshMenuListActive(MonoECS.instance.InputMode);
		return base.PreInit();
	}

	protected override void Init()
	{
		if (Singleton<CameraManager>.instance.GetSetMainCameraSkipBaseEnableState())
		{
			Singleton<CameraManager>.instance.SetMainCameraSkipBaseEnable(isEnabled: false);
		}
		if (uiViewData != null)
		{
			m_Data = uiViewData as MonoBattleMainBaseViewData;
		}
		base.Init();
		BtnRogueBag.SetBtnClick(OpenRogueBagView);
		operateBtnComp.Init();
		OnMove.Init();
		OpenBattleMainComponentList();
		Model<BattleMainModel>.Interface.InitUIModuleState();
		UpdateRedDotDisplayOnViewOpen();
	}

	protected override UniTask WaitShowCompleteAsync(CancellationToken token)
	{
		if (Model<BattleMainModel>.Interface.NeedReDisplay && MonoECS.instance.sceneStatus == SceneStatus.Main)
		{
			GameUtility.OpenAdventureTip();
			Model<BattleMainModel>.Interface.RestExpReDisplayState();
		}
		return UniTask.CompletedTask;
	}

	protected override void OnPushStack()
	{
		BattleMainComponentListPushStack();
	}

	protected override void OnPopStack()
	{
		BattleMainComponentListPopStack();
	}

	public void OpenRogueBagView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEBAG);
	}

	private void InitializeBattleMainComponentList()
	{
		foreach (GameObject battleMainComponent in battleMainComponentList)
		{
			if (battleMainComponent != null)
			{
				battleMainComponent.GetComponent<IBattleMainComponent>()?.Initialize(this);
			}
		}
	}

	protected override void AddEventListener()
	{
		if (!hasAddEventListener)
		{
			base.AddEventListener();
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
			hasAddEventListener = true;
		}
	}

	private void OnSystemBlockStatusChanged(BaseEventContent obj)
	{
		if (obj is SystemBlockStatusChangedEvt systemBlockStatusChangedEvt && systemBlockStatusChangedEvt.status.MainID == 1028)
		{
			Model<BattleMainModel>.Interface.RefreshUIModuleState(UIMode.MiniMapMode);
		}
	}

	private void OnRogueExit(BaseEventContent obj)
	{
		if (isneedroguetips)
		{
			isneedroguetips = false;
		}
	}

	private void CloseRogueLittleBag()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueExitInteract, null);
	}

	private void SendRoguePropReplace(int index, int swuid, int newItemId, bool isCompleted = true)
	{
		RoguePropReplace roguePropReplace = new RoguePropReplace();
		roguePropReplace.isCompleted = isCompleted;
		roguePropReplace.index = index;
		roguePropReplace.swuid = swuid;
		roguePropReplace.newItemId = newItemId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueReplace, roguePropReplace);
		Singleton<EventManager>.instance.ReleaseEvt(roguePropReplace);
	}

	protected override void OpenEffectCallback()
	{
	}

	private void OpenBattleMainComponentList()
	{
		foreach (GameObject battleMainComponent in battleMainComponentList)
		{
			if (battleMainComponent != null)
			{
				battleMainComponent.GetComponent<IBattleMainComponent>().OpenComponent();
			}
		}
	}

	private void BattleMainComponentListPushStack()
	{
		foreach (GameObject battleMainComponent in battleMainComponentList)
		{
			if (battleMainComponent != null)
			{
				battleMainComponent.GetComponent<IBattleMainComponent>().PushStack();
			}
		}
	}

	private void BattleMainComponentListPopStack()
	{
		foreach (GameObject battleMainComponent in battleMainComponentList)
		{
			if (battleMainComponent != null)
			{
				battleMainComponent.GetComponent<IBattleMainComponent>().PopStack();
			}
		}
	}

	public void ShowHudComponentUIFromQueue()
	{
		if (!CanShowHudComponentUIFromQueue() || !Model<BattleMainModel>.HasInstance() || Model<BattleMainModel>.Interface.HudCpQueueManager == null)
		{
			return;
		}
		foreach (KeyValuePair<UIPosition, UIPositionQueue> queue in Model<BattleMainModel>.Interface.HudCpQueueManager.queues)
		{
			UIPositionQueue value = queue.Value;
			if (value == null || value.PendingCount <= 0 || !value.HudCpCanOpen(Model<BattleMainModel>.Interface.HudCpQueueManager.CanStart))
			{
				continue;
			}
			HudCpQueueItem queueHead = value.GetQueueHead();
			if (queueHead == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"没拿到分区;{value.Position}的队头UI");
				}
				continue;
			}
			value.OnQueueHeadShow();
			switch (queueHead.HudComponentType)
			{
			case HudComponentType.MiddlePropPick:
			{
				MonoMiddlePropPickingData data4 = queueHead.HudComponentUIData as MonoMiddlePropPickingData;
				middlePickingView?.Init(data4, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.NormalPropPick:
			{
				PropPickingData data7 = queueHead.HudComponentUIData as PropPickingData;
				normalPickingView?.Show(data7, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.AdventureLevel:
			{
				MonoPopUpPlayerAdventureTip.ExpChangeData data9 = queueHead.HudComponentUIData as MonoPopUpPlayerAdventureTip.ExpChangeData;
				PlayerAdventureTip?.Init(data9, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.Aside:
				if (queueHead.HudComponentUIData is MonoAsideView.AsideData asideData)
				{
					asideUIComp?.Init(asideData, value.OnQueueHeadShowFail);
				}
				break;
			case HudComponentType.SideMissionSuccessTip:
				if (queueHead.HudComponentUIData is MonoSideMissionView.SideMissionData data6)
				{
					sideMissionView?.Show(data6, value.OnQueueHeadShowFail);
				}
				break;
			case HudComponentType.TutorialTimerTip:
			{
				TutorialComponentData data2 = queueHead.HudComponentUIData as TutorialComponentData;
				tutorialComponent?.Show(data2, Station, value.OnQueueHeadShowFail, queueHead.ComponentPositionOffset);
				break;
			}
			case HudComponentType.AchievementTip:
			{
				AchievementHudTipsData data10 = queueHead.HudComponentUIData as AchievementHudTipsData;
				achievementHudTips?.Show(data10, Station, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.RegionNameTip:
			{
				RegionNameTipData data8 = queueHead.HudComponentUIData as RegionNameTipData;
				regionNameTip?.Init(data8, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.TextLibraryPropPick:
			{
				TextLibraryPropPickData curNeedShowData = queueHead.HudComponentUIData as TextLibraryPropPickData;
				textLibraryPropPick?.Init(curNeedShowData, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.RaidOpeningPerformance:
			{
				RaidOpeningPerformanceComponentData data5 = queueHead.HudComponentUIData as RaidOpeningPerformanceComponentData;
				raidOpeningPerformance?.Init(data5, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.ChallengeTip:
			{
				ChallengeTipComponentData data3 = queueHead.HudComponentUIData as ChallengeTipComponentData;
				_challengeTipComponent?.Show(data3, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.TreasureGetTip:
			{
				TreasureGetHudTipsData data = queueHead.HudComponentUIData as TreasureGetHudTipsData;
				treasureGetHudTips?.Show(data, Station, value.OnQueueHeadShowFail);
				break;
			}
			case HudComponentType.WorldLevelBreakTaskTips:
				worldLevelBreakTaskTips?.Show(value.OnQueueHeadShowFail);
				break;
			default:
				value.OnQueueHeadShowFail();
				throw new ArgumentOutOfRangeException("HudComponentType");
			}
		}
	}

	public bool CanShowHudComponentUIFromQueue()
	{
		if (Singleton<NewUIManager>.instance.BlackScreen.isActiveAndEnabled || !GetCanvasGroupState())
		{
			return false;
		}
		NewUIManager instance = Singleton<NewUIManager>.instance;
		if (instance == null || instance.IsUIManagerBusy())
		{
			return false;
		}
		IBaseUIController topActiveUI = instance.GetTopActiveUI();
		if (topActiveUI == null || topActiveUI.UIType != UI_TYPE.UI_BATTLEMAIN || topActiveUI.State != UIState.Opened || topActiveUI.ExpectedState != UIExpectedState.Open)
		{
			return false;
		}
		if (Model<FacePushModel>.HasInstance())
		{
			FacePushScheduler scheduler = Model<FacePushModel>.Interface.Scheduler;
			if (scheduler != null && scheduler.IsHudQueueBlocked)
			{
				scheduler.RefreshHudQueueBlockState();
				if (scheduler.IsHudQueueBlocked)
				{
					return false;
				}
			}
		}
		return true;
	}

	public void UpdateRedDotDisplayOnViewOpen()
	{
		foreach (EscItem value3 in AllEscItem.Values)
		{
			int systemId = value3.systemId;
			if (systemId == 0)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("有系统入口没配置系统Id，检查一下一预制体");
				}
			}
			else
			{
				bool systemOpenDotActive = (G.localPlayer.redPoints.Systems.TryGetValue(systemId, out var value) & value) && RuntimeConfigs.data.systemOpens.TryGetValue(systemId, out var value2) && value2.systemUnlockPrompts;
				RefreshSystemEntryRedDot(systemId, systemOpenDotActive);
			}
		}
	}

	public void RefreshSystemEntryRedDot(int systemId, bool systemOpenDotActive)
	{
		if (systemId == 1017 && (Model<BattleMainModel>.Interface.hudType == HudType.TeamTeaching || Model<BattleMainModel>.Interface.hudType == HudType.characterTutorial))
		{
			RefreshCharacterEntryRedDotVisibility();
			return;
		}
		if (AllEscItem.TryGetValue(systemId, out var value))
		{
			value.RefreshRedDot(systemId, systemOpenDotActive);
		}
		WheelDisc?.RefreshRedDot(systemId, systemOpenDotActive);
		_gamePadMenuList?.RefreshRedDot(systemId, systemOpenDotActive);
	}

	public void RefreshCharacterEntryRedDotVisibility()
	{
		HudType hudType = Model<BattleMainModel>.Interface.hudType;
		bool flag = hudType != HudType.TeamTeaching && hudType != HudType.characterTutorial;
		if (AllEscItem.TryGetValue(1017, out var value) && value.redDotItem != null)
		{
			value.redDotItem.ForbidDotShow = !flag;
			value.redDotItem.UpdateDisplay();
		}
		WheelDisc?.RefreshCharacterRedDotVisibility(flag);
		List<EscItem> list = _gamePadMenuList?.gamePadSystemEntries;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (EscItem gamePadSystemEntry in _gamePadMenuList.gamePadSystemEntries)
		{
			if ((object)gamePadSystemEntry != null && gamePadSystemEntry.systemId == 1017 && !(gamePadSystemEntry.redDotItem == null))
			{
				gamePadSystemEntry.redDotItem.ForbidDotShow = !flag;
				gamePadSystemEntry.redDotItem.UpdateDisplay();
			}
		}
	}

	private void UpdateHUDEscDot()
	{
		if (!AllEscItem.TryGetValue(10351, out var value) || (object)value.redDotItem == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		foreach (KeyValuePair<int, bool> system in G.localPlayer.redPoints.Systems)
		{
			if (system.Value && CoreUtils.GetData(system.Key, RuntimeConfigs.data.systemOpens).systemUnlockPrompts)
			{
				AllEscItem[10351].redDotItem.redDotType = RedDotType.SystemNew;
				AllEscItem[10351].redDotItem.UpdateDisplay();
				return;
			}
		}
		AllEscItem[10351].redDotItem.redDotType = RedDotType.Dot;
		AllEscItem[10351].redDotItem.UpdateDisplay();
	}

	protected override void OnCanvasLayerChanged(int layer)
	{
		PublishContentCanvasLayerChanged(layer);
	}

	public void PublishContentCanvasLayerChanged(int layer)
	{
		BattleMainCanvasLayerEvt evt = Singleton<EventManager>.instance.GetEvt<BattleMainCanvasLayerEvt>();
		evt.Layer = layer;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BattleMainCanvasLayerChanged, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void PublishContentCanvasReleased()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BattleMainCanvasReleased, null);
	}

	protected override void UnInit()
	{
		base.UnInit();
		OnMove.UnInit();
		UnInitializeBattleMainComponentList();
		operateBtnComp.UnInit();
		AllEscItem.Clear();
	}

	private void UnInitializeBattleMainComponentList()
	{
		foreach (GameObject battleMainComponent in battleMainComponentList)
		{
			if (battleMainComponent != null)
			{
				battleMainComponent.GetComponent<IBattleMainComponent>().UnInitialize();
			}
		}
	}

	protected override void CloseEffectCallback()
	{
		CloseBattleMainComponentList();
	}

	private void CloseBattleMainComponentList()
	{
		foreach (GameObject battleMainComponent in battleMainComponentList)
		{
			if (battleMainComponent != null)
			{
				battleMainComponent.GetComponent<IBattleMainComponent>().CloseComponent();
			}
		}
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
		hasAddEventListener = false;
	}

	private void Update()
	{
		if (UIController.State == UIState.Opened && !Singleton<LoadManager>.instance.InLoading)
		{
			ShowHudComponentUIFromQueue();
			CheckIsNeedFlushPayReward();
			CheckIsShowWorldLevelTaskTips();
		}
	}

	private void LateUpdate()
	{
		if (ActiveInShowRoot)
		{
			RefreshMonsterUI();
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("BattleMainShow").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BattleMainOpened, null);
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("BattleMainHide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public void RefreshMonsterUI()
	{
		Singleton<EntityUIManager>.instance.RefreshEntityUIPos();
	}

	public bool GetEscItemIsActive(int systemId)
	{
		if (AllEscItem.TryGetValue(systemId, out var value))
		{
			return value.gameObject.activeSelf;
		}
		return false;
	}

	public void RefreshMenuListActive(DeviceInputMode type)
	{
		normal_MenuList.alpha = ((type != DeviceInputMode.Gamepad) ? 1 : 0);
		normal_MenuList.interactable = type != DeviceInputMode.Gamepad;
		HudType hudType = Model<BattleMainModel>.Interface.hudType;
		bool flag = type == DeviceInputMode.Gamepad && ((hudType == HudType.MainWorldType) ? WheelDisc.HasUnLockSystemEntries() : WheelDisc.HasUnLockSystemEntries(Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems));
		handleMode_MenuList.alpha = (flag ? 1 : 0);
		if (flag)
		{
			_gamePadMenuList.RefreshDisplay();
		}
	}

	private void CheckIsNeedFlushPayReward()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null && worldManager.GetCurrentWorld()?.SceneStatus == SceneStatus.Main && Singleton<NewUIManager>.instance.GetTopActiveUI().UIType == UI_TYPE.UI_BATTLEMAIN && !Singleton<GameState>.instance.InGuiding && !Singleton<ConversationManager>.instance.IsPlaying && Model<PayModel>.HasInstance())
		{
			Model<PayModel>.Interface.TryFlushPendingOrderShipRewards();
		}
	}

	private void CheckIsShowWorldLevelTaskTips()
	{
		if (Model<WorldLevelModel>.HasInstance())
		{
			Model<WorldLevelModel>.Interface.TryEnqueuePendingWorldLevelBreakTaskHudTip();
		}
	}
}
