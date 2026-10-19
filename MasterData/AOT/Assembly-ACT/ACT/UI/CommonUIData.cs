using System.Collections.Generic;

namespace ACT.UI;

public class CommonUIData
{
	public static readonly Dictionary<UI_TYPE, UIData> DICT_UI_DATA = new Dictionary<UI_TYPE, UIData>(new UITypeComparer())
	{
		{
			UI_TYPE.UI_ABYSSLIST,
			new UIData
			{
				mobilePath = "UI/AbyssListView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(AbyssListUIController)
			}
		},
		{
			UI_TYPE.UI_ABYSSREWARD,
			new UIData
			{
				mobilePath = "UI/AbyssRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AbyssRewardUIController)
			}
		},
		{
			UI_TYPE.UI_ADDPOWER,
			new UIData
			{
				mobilePath = "UI/AddPower",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AddPowerUIController)
			}
		},
		{
			UI_TYPE.UI_BAGPANEL,
			new UIData
			{
				mobilePath = "UI/BagPanel",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(BagPanelUIController)
			}
		},
		{
			UI_TYPE.UI_BATTLEMAIN,
			new UIData
			{
				mobilePath = "UI/BattleMain",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(BattleMainUIController)
			}
		},
		{
			UI_TYPE.UI_BLACKLOAD,
			new UIData
			{
				mobilePath = "UI/BlackLoadView",
				layer = UI_LAYER.MASK,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(BlackLoadUIController)
			}
		},
		{
			UI_TYPE.UI_BLACKSCREEN,
			new UIData
			{
				mobilePath = "UI/BlackScreenView",
				layer = UI_LAYER.MASK,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(BlackScreenUIController)
			}
		},
		{
			UI_TYPE.UI_BREAKSUCCESS,
			new UIData
			{
				mobilePath = "UI/BreakSuccess",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(BreakSuccessUIController)
			}
		},
		{
			UI_TYPE.UI_BUYITEM,
			new UIData
			{
				mobilePath = "UI/BuyItem",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(BuyItemUIController)
			}
		},
		{
			UI_TYPE.UI_CARDPOOLDETAIL,
			new UIData
			{
				mobilePath = "UI/CardPoolDetail",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(CardPoolDetailUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERATTRIBUTEPANEL,
			new UIData
			{
				mobilePath = "UI/CharacterAttributePanel",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(CharacterAttributePanelUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERGET,
			new UIData
			{
				mobilePath = "UI/CharacterGet",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CharacterGetUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTER,
			new UIData
			{
				mobilePath = "UI/CharacterViewV3",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CharacterViewV3UIController)
			}
		},
		{
			UI_TYPE.UI_CONVERSATION,
			new UIData
			{
				mobilePath = "UI/ConversationView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ConversationUIController)
			}
		},
		{
			UI_TYPE.UI_CONVERSATION_WITHOUTHEAD,
			new UIData
			{
				mobilePath = "UI/ConversationView_withoutHead",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ConversationView_withoutHeadUIController)
			}
		},
		{
			UI_TYPE.UI_DRAMAASIDE,
			new UIData
			{
				mobilePath = "UI/DramaAside",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(DramaAsideUIController)
			}
		},
		{
			UI_TYPE.UI_ESC,
			new UIData
			{
				mobilePath = "UI/Esc",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(EscUIController)
			}
		},
		{
			UI_TYPE.UI_GAMEMODESELECTION,
			new UIData
			{
				mobilePath = "UI/GameModeSelectionView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(GameModeSelectionUIController)
			}
		},
		{
			UI_TYPE.UI_GM,
			new UIData
			{
				mobilePath = "UI/GMView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(GMUIController)
			}
		},
		{
			UI_TYPE.UI_HORIZONTALREAD,
			new UIData
			{
				mobilePath = "UI/HorizontalRead",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(HorizontalReadUIController)
			}
		},
		{
			UI_TYPE.UI_HOTUPDATEPANEL_LOCAL,
			new UIData
			{
				mobilePath = "UI/HotUpdatePanel_LOCAL",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(HotUpdatePanel_LOCALUIController)
			}
		},
		{
			UI_TYPE.UI_LETTERBOXINGPANEL,
			new UIData
			{
				mobilePath = "UI/LetterBoxingPanel",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(LetterBoxingPanelUIController)
			}
		},
		{
			UI_TYPE.UI_LEVELUPPROPERTYINFO,
			new UIData
			{
				mobilePath = "UI/LevelUpPropertyInfo",
				layer = UI_LAYER.MASK,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(LevelUpPropertyInfoUIController)
			}
		},
		{
			UI_TYPE.UI_LEVELUPSUCCESS,
			new UIData
			{
				mobilePath = "UI/LevelUpSuccess",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(LevelUpSuccessUIController)
			}
		},
		{
			UI_TYPE.UI_LOGINWAITCLICK,
			new UIData
			{
				mobilePath = "UI/LoginWaitClickView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(LoginWaitClickUIController)
			}
		},
		{
			UI_TYPE.UI_MAILBOXPANEL,
			new UIData
			{
				mobilePath = "UI/MailboxPanel",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MailboxPanelUIController)
			}
		},
		{
			UI_TYPE.UI_MAILBOXPOPUPINFOPANEL,
			new UIData
			{
				mobilePath = "UI/MailboxPopUpInfoPanel",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(MailboxPopUpInfoPanelUIController)
			}
		},
		{
			UI_TYPE.UI_NETWORKFLUCTUATION,
			new UIData
			{
				mobilePath = "UI/NetworkFluctuationView",
				layer = UI_LAYER.MASK,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(NetworkFluctuationUIController)
			}
		},
		{
			UI_TYPE.UI_NETWORKTRANSMISSIONSTATUS,
			new UIData
			{
				mobilePath = "UI/NetworkTransmissionStatus",
				layer = UI_LAYER.MASK,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(NetworkTransmissionStatusUIController)
			}
		},
		{
			UI_TYPE.UI_ONCECOLLECTIONCELL,
			new UIData
			{
				mobilePath = "UI/OnceCollectionCell",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(OnceCollectionCellUIController)
			}
		},
		{
			UI_TYPE.UI_PHAROSPANEL,
			new UIData
			{
				mobilePath = "UI/PharosPanel",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(PharosPanelUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPADJUSTWORLDLEVEL,
			new UIData
			{
				mobilePath = "UI/PopUpAdjustWorldLevel",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpAdjustWorldLevelUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPASSISTCHOOSE,
			new UIData
			{
				mobilePath = "UI/PopupAssistChooseView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupAssistChooseUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPCHANGENAME,
			new UIData
			{
				mobilePath = "UI/PopUpChangeName",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpChangeNameUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPACCOUNTDEACORATION,
			new UIData
			{
				mobilePath = "UI/PopUpAccountDecoration_v4",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpAccountDecorationUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPDETAIL,
			new UIData
			{
				mobilePath = "UI/PopUpDetailView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpDetailUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPITEMCRAFTING,
			new UIData
			{
				mobilePath = "UI/PopupItemCrafting",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupItemCraftingUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPITEMDETAIL,
			new UIData
			{
				mobilePath = "UI/PopUpItemDetailView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpItemDetailUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPPLAYERADVENTURETIP,
			new UIData
			{
				mobilePath = "UI/PopUpPlayerAdventureTip",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(PopUpPlayerAdventureTipUIController)
			}
		},
		{
			UI_TYPE.UI_HANDBOOK,
			new UIData
			{
				mobilePath = "UI/HandbooktView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(HandbooktUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPREGIONTIP,
			new UIData
			{
				mobilePath = "UI/PopUpRegionTip",
				layer = UI_LAYER.MASK,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(PopUpRegionTipUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPREWARDONE,
			new UIData
			{
				mobilePath = "UI/PopUpRewardOneView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpRewardOneUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSUBMITMISSIONPANEL,
			new UIData
			{
				mobilePath = "UI/PopUpSubmitMissionPanel",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(PopUpSubmitMissionPanelUIController)
			}
		},
		{
			UI_TYPE.UI_RAIDFAIL,
			new UIData
			{
				mobilePath = "UI/RaidFailView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RaidFailUIController)
			}
		},
		{
			UI_TYPE.UI_TEMPLEFAIL,
			new UIData
			{
				mobilePath = "UI/TempleFailView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TempleFailUIController)
			}
		},
		{
			UI_TYPE.UI_RAID,
			new UIData
			{
				mobilePath = "UI/RaidView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RaidUIController)
			}
		},
		{
			UI_TYPE.UI_RAREPROPPICKINGPANEL,
			new UIData
			{
				mobilePath = "UI/RarePropPickingPanel",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(RarePropPickingPanelUIController)
			}
		},
		{
			UI_TYPE.UI_RAREPROPPICKINGPANELNEW,
			new UIData
			{
				mobilePath = "UI/RarePropPickingPanelNew",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(RarePropPickingPanelNewUIController)
			}
		},
		{
			UI_TYPE.UI_RESPAWN,
			new UIData
			{
				mobilePath = "UI/Respawn",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RespawnUIController)
			}
		},
		{
			UI_TYPE.UI_SETTINGS,
			new UIData
			{
				mobilePath = "UI/SettingsView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(SettingsUIController)
			}
		},
		{
			UI_TYPE.UI_SKILLLEVELUP,
			new UIData
			{
				mobilePath = "UI/SkillLevelUp",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SkillLevelUpUIController)
			}
		},
		{
			UI_TYPE.UI_STAGESECRET,
			new UIData
			{
				mobilePath = "UI/StageSecret",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(StageSecretUIController)
			}
		},
		{
			UI_TYPE.UI_TASKPOP,
			new UIData
			{
				mobilePath = "UI/TaskPop",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TaskPopUIController)
			}
		},
		{
			UI_TYPE.UI_TEAMPANEL,
			new UIData
			{
				mobilePath = "UI/TeamPanel",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TeamPanelUIController)
			}
		},
		{
			UI_TYPE.UI_TEAMRENAMEWIN,
			new UIData
			{
				mobilePath = "UI/TeamRenameWin",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TeamRenameWinUIController)
			}
		},
		{
			UI_TYPE.UI_TEXTPANEL,
			new UIData
			{
				mobilePath = "UI/TextPanel",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TextPanelUIController)
			}
		},
		{
			UI_TYPE.UI_TEXTPANELWITHPOWER,
			new UIData
			{
				mobilePath = "UI/TextPanelWithPower",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TextPanelWithPowerUIController)
			}
		},
		{
			UI_TYPE.UI_VERTICALREAD,
			new UIData
			{
				mobilePath = "UI/VerticalRead",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(VerticalReadUIController)
			}
		},
		{
			UI_TYPE.UI_WEBFORANDROIDIOSMAC,
			new UIData
			{
				mobilePath = "UI/WebViewForAndroidIosMac",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(WebViewForAndroidIosMacUIController)
			}
		},
		{
			UI_TYPE.UI_WEBFORWINDOWS,
			new UIData
			{
				mobilePath = "UI/WebViewForWindows",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(WebViewForWindowsUIController)
			}
		},
		{
			UI_TYPE.UI_LARGEMAP,
			new UIData
			{
				mobilePath = "UI/LargeMapView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(LargeMapUIController)
			}
		},
		{
			UI_TYPE.UI_GRAPHICGUIDE,
			new UIData
			{
				mobilePath = "UI/GraphicGuideView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(GraphicGuideUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUESELECTCARD,
			new UIData
			{
				mobilePath = "UI/RogueSelectCardView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueSelectCardUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUESELECTARTIFACT,
			new UIData
			{
				mobilePath = "UI/RogueSelectArtifactView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueSelectArtifactUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUECARDSYNTHESIZE,
			new UIData
			{
				mobilePath = "UI/RogueCardSynthesizeView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueCardSynthesizeUIController)
			}
		},
		{
			UI_TYPE.UI_ELEMENTALRESONANCE,
			new UIData
			{
				mobilePath = "UI/ElementalResonanceView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(ElementalResonanceUIController)
			}
		},
		{
			UI_TYPE.UI_PROPSSUBMISSON,
			new UIData
			{
				mobilePath = "UI/PropsSubmissonView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(PropsSubmissonUIController)
			}
		},
		{
			UI_TYPE.UI_CHALLENGEPROMPTS,
			new UIData
			{
				mobilePath = "UI/ChallengePromptsView",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(ChallengePromptsUIController)
			}
		},
		{
			UI_TYPE.UI_TRIGGERTUTORIALTIP,
			new UIData
			{
				mobilePath = "UI/TriggerTutorialTipView",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(TriggerTutorialTipUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPCHARACTERHITTYPE,
			new UIData
			{
				mobilePath = "UI/PopupCharacterHitTypeView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupCharacterHitTypeUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPABYSSINSTRUCTION,
			new UIData
			{
				mobilePath = "UI/PopupAbyssInstructionView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupAbyssInstructionUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPENEMYDETAIL,
			new UIData
			{
				mobilePath = "UI/PopupEnemyDetailView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupEnemyDetailUIController)
			}
		},
		{
			UI_TYPE.UI_TRAININGGROUND,
			new UIData
			{
				mobilePath = "UI/TrainingGroundView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TrainingGroundUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPMONSTERCOUNT,
			new UIData
			{
				mobilePath = "UI/PopupMonsterCountView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupMonsterCountUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPGETNEWBLOOD,
			new UIData
			{
				mobilePath = "UI/PopupGetNewBloodView",
				layer = UI_LAYER.TOAST,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(PopupGetNewBloodUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERTUTORIALENTRANCE,
			new UIData
			{
				mobilePath = "UI/CharacterTutorialEntranceMobileView",
				layer = UI_LAYER.NORMAL,
				pcPath = "UI/CharacterTutorialEntrancePCView",
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CharacterTutorialEntranceMobileUIController)
			}
		},
		{
			UI_TYPE.UI_SUBTITLE,
			new UIData
			{
				mobilePath = "UI/SubtitleView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(SubtitleUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSYSTEMUNLOCK,
			new UIData
			{
				mobilePath = "UI/PopupSystemUnlockView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupSystemUnlockUIController)
			}
		},
		{
			UI_TYPE.UI_QUESTIONNAIRE,
			new UIData
			{
				mobilePath = "UI/QuestionnaireView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(QuestionnaireUIController)
			}
		},
		{
			UI_TYPE.UI_CREATECHARACTER,
			new UIData
			{
				mobilePath = "UI/CreateCharacterView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CreateCharacterUIController)
			}
		},
		{
			UI_TYPE.UI_MINETRAINOPERATE,
			new UIData
			{
				mobilePath = "UI/MineTrainOperateMobileView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MineTrainOperateMobileUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUECARDTABLE,
			new UIData
			{
				mobilePath = "UI/RogueCardTableView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueCardTableUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEDESKTOP,
			new UIData
			{
				mobilePath = "UI/RogueDesktopView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(RogueDesktopUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEOPTIONALCARD,
			new UIData
			{
				mobilePath = "UI/RogueOptionalCardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(RogueOptionalCardUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUECHOOSEARTIFACT,
			new UIData
			{
				mobilePath = "UI/RogueChooseArtifactView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(RogueChooseArtifactUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUECHECKPOINTENTRANCE,
			new UIData
			{
				mobilePath = "UI/RogueCheckpointEntranceView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueCheckpointEntranceUIController)
			}
		},
		{
			UI_TYPE.UI_ROUGEROUTEMAP,
			new UIData
			{
				mobilePath = "UI/RougeRouteMapView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RougeRouteMapUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUETEAM,
			new UIData
			{
				mobilePath = "UI/RogueTeamView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueTeamUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEBAG,
			new UIData
			{
				mobilePath = "UI/RogueBagView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueBagUIController)
			}
		},
		{
			UI_TYPE.UI_TEXTPANELROGUE,
			new UIData
			{
				mobilePath = "UI/TextpanelRogueView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TextpanelRogueUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUESHOP,
			new UIData
			{
				mobilePath = "UI/RogueShopView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueShopUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUESETTLEMENT,
			new UIData
			{
				mobilePath = "UI/RogueSettlementView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueSettlementUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPROGUECARDDETAIL,
			new UIData
			{
				mobilePath = "UI/PopupRogueCardDetailView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupRogueCardDetailUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUECARDBAG,
			new UIData
			{
				mobilePath = "UI/RogueCardBagView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueCardBagUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEEVENT,
			new UIData
			{
				mobilePath = "UI/RogueEventView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueEventUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPROGUECARDSYNTHESIS,
			new UIData
			{
				mobilePath = "UI/PopupRogueCardSynthesisView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupRogueCardSynthesisUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPITEMDELETE,
			new UIData
			{
				mobilePath = "UI/PopupItemDeleteView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupItemDeleteUIController)
			}
		},
		{
			UI_TYPE.UI_CONNECTIONMINIGAME,
			new UIData
			{
				mobilePath = "UI/ConnectionMiniGameView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ConnectionMiniGameUIController)
			}
		},
		{
			UI_TYPE.UI_TEMPLEREWARD,
			new UIData
			{
				mobilePath = "UI/TempleRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TempleRewardUIController)
			}
		},
		{
			UI_TYPE.UI_TEMPLEENTRANCE,
			new UIData
			{
				mobilePath = "UI/TempleEntranceView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TempleEntranceUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPBUFF,
			new UIData
			{
				mobilePath = "UI/EquipBuffView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(EquipBuffUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPNPC,
			new UIData
			{
				mobilePath = "UI/EquipNpcView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(EquipNpcUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPLEVELUP,
			new UIData
			{
				mobilePath = "UI/EquipLevelUpView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(EquipLevelUpUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPBUILD,
			new UIData
			{
				mobilePath = "UI/EquipBuildView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(EquipBuildUIController)
			}
		},
		{
			UI_TYPE.UI_SNS,
			new UIData
			{
				mobilePath = "UI/SNSMobileView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(SNSMobileUIController)
			}
		},
		{
			UI_TYPE.UI_SCENICSPOT,
			new UIData
			{
				mobilePath = "UI/ScenicSpotView",
				layer = UI_LAYER.POPUP,
				pcPath = "UI/ScenicSpotView",
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(ScenicSpotUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSKILLLEVELUP,
			new UIData
			{
				mobilePath = "UI/PopupSkillLevelupView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(PopupSkillLevelupUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSKILLPREVIEW,
			new UIData
			{
				mobilePath = "UI/PopupSkillPreviewView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(PopupSkillPreviewUIController)
			}
		},
		{
			UI_TYPE.UI_NPCRAID,
			new UIData
			{
				mobilePath = "UI/NPCRaidView",
				layer = UI_LAYER.NORMAL,
				pcPath = "UI/NPCRaidView",
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(NPCRaidUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPRAIDMULTIREWARD,
			new UIData
			{
				mobilePath = "UI/PopupRaidMultiRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupRaidMultiRewardUIController)
			}
		},
		{
			UI_TYPE.UI_CARDDRAW,
			new UIData
			{
				mobilePath = "UI/CardDrawView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CardDrawUIController)
			}
		},
		{
			UI_TYPE.UI_SYSTEMGUIDE,
			new UIData
			{
				mobilePath = "UI/SystemGuideView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(SystemGuideUIController)
			}
		},
		{
			UI_TYPE.UI_SYSTEMGUIDEREWARD,
			new UIData
			{
				mobilePath = "UI/SystemGuideRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SystemGuideRewardUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPCARDDRAWRECORD,
			new UIData
			{
				mobilePath = "UI/PopupCardDrawRecordView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupCardDrawRecordUIController)
			}
		},
		{
			UI_TYPE.UI_CARDDRAWSHOP,
			new UIData
			{
				mobilePath = "UI/CardDrawShopView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CardDrawShopUIController)
			}
		},
		{
			UI_TYPE.UI_CARDDRAWSETTLE,
			new UIData
			{
				mobilePath = "UI/CardDrawSettleView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CardDrawSettleUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPTEMPLECOMPLETE,
			new UIData
			{
				mobilePath = "UI/PopupTempleCompleteView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupTempleCompleteUIController)
			}
		},
		{
			UI_TYPE.UI_RAIDSETTLE,
			new UIData
			{
				mobilePath = "UI/RaidSettleView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RaidSettleUIController)
			}
		},
		{
			UI_TYPE.UI_BLOODBOTTLE,
			new UIData
			{
				mobilePath = "UI/BloodBottleView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 1026,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(BloodBottleUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPPREVIEWSKILLGROUP,
			new UIData
			{
				mobilePath = "UI/PopupPreviewSkillGroupView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupPreviewSkillGroupUIController)
			}
		},
		{
			UI_TYPE.UI_LOGINTIPS,
			new UIData
			{
				mobilePath = "UI/LoginTipsView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(LoginTipsUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPMENTLEVELUPVIEW,
			new UIData
			{
				mobilePath = "UI/EquipmentLevelUpViewView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(EquipmentLevelUpViewUIController)
			}
		},
		{
			UI_TYPE.UI_ANNOUNCEMENT,
			new UIData
			{
				mobilePath = "UI/AnnouncementView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AnnouncementUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPIMAGEVIEW,
			new UIData
			{
				mobilePath = "UI/PopUpImageViewMobileView",
				layer = UI_LAYER.POPUP,
				pcPath = "UI/PopUpImageViewPCView",
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpImageViewMobileUIController)
			}
		},
		{
			UI_TYPE.UI_INTEGRATEDEXPLORING,
			new UIData
			{
				mobilePath = "UI/IntegratedExploringView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(IntegratedExploringUIController)
			}
		},
		{
			UI_TYPE.UI_INTEGRATEDEXPLORINGCHALLENGEVIEW,
			new UIData
			{
				mobilePath = "UI/IntegratedExploringChallengeView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(IntegratedExploringChallengeUIController)
			}
		},
		{
			UI_TYPE.UI_ACTIVITYDESC,
			new UIData
			{
				mobilePath = "UI/ActivityDescView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(ActivityDescUIController)
			}
		},
		{
			UI_TYPE.UI_ACTIVITYCENTER,
			new UIData
			{
				mobilePath = "UI/ActivityCenterView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ActivityCenterUIController)
			}
		},
		{
			UI_TYPE.UI_SEVENDAYSIGNINFIXED,
			new UIData
			{
				mobilePath = "UI/SevenDaySignInFixed",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SevenDaySignInFixedUIController)
			}
		},
		{
			UI_TYPE.UI_ATTRIBUTEINTRO,
			new UIData
			{
				mobilePath = "UI/AttributeIntroView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AttributeIntroUIController)
			}
		},
		{
			UI_TYPE.UI_CARDDRAWSELFSELECTEDREWARD,
			new UIData
			{
				mobilePath = "UI/CardDrawSelfSelectedRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(CardDrawSelfSelectedRewardUIController)
			}
		},
		{
			UI_TYPE.UI_ELITEOVERVIEW,
			new UIData
			{
				mobilePath = "UI/EliteOverviewView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(EliteOverviewUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERTRIALTIPS,
			new UIData
			{
				mobilePath = "UI/CharacterTrialTipsView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CharacterTrialTipsUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPBUILDSUCCESS,
			new UIData
			{
				mobilePath = "UI/PopupEquipBuildSuccessView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupEquipBuildSuccessUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPDISSOLVEVIEW,
			new UIData
			{
				mobilePath = "UI/EquipDissolveView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(EquipDissolveUIController)
			}
		},
		{
			UI_TYPE.UI_COMMONINFO,
			new UIData
			{
				mobilePath = "UI/CommonInfoView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(CommonInfoUIController)
			}
		},
		{
			UI_TYPE.UI_TEAM,
			new UIData
			{
				mobilePath = "UI/TeamView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TeamUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPTEAMQUICKSELECT,
			new UIData
			{
				mobilePath = "UI/PopUpTeamQuickSelectView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpTeamQuickSelectUIController)
			}
		},
		{
			UI_TYPE.UI_READABLE,
			new UIData
			{
				mobilePath = "UI/ReadableView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ReadableUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERBATTLEATTRIBUTE,
			new UIData
			{
				mobilePath = "UI/CharacterBattleAttributeView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(CharacterBattleAttributeUIController)
			}
		},
		{
			UI_TYPE.UI_ITEMTREASURE,
			new UIData
			{
				mobilePath = "UI/ItemTreasureView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ItemTreasureUIController)
			}
		},
		{
			UI_TYPE.UI_ITEMTREASURECENTER,
			new UIData
			{
				mobilePath = "UI/ItemTreasureCenterView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ItemTreasureCenterUIController)
			}
		},
		{
			UI_TYPE.UI_VIEWPORT,
			new UIData
			{
				mobilePath = "UI/ViewportView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(ViewportUIController)
			}
		},
		{
			UI_TYPE.UI_ABYSSBLOODBOTTLE,
			new UIData
			{
				mobilePath = "UI/AbyssBloodBottleView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AbyssBloodBottleUIController)
			}
		},
		{
			UI_TYPE.UI_ACQUIRECHARACTERSHOW,
			new UIData
			{
				mobilePath = "UI/AcquireCharacterShowView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(AcquireCharacterShowUIController)
			}
		},
		{
			UI_TYPE.UI_ABYSSEXIT,
			new UIData
			{
				mobilePath = "UI/AbyssExitView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AbyssExitUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERTAGDETAILS,
			new UIData
			{
				mobilePath = "UI/CharacterTagDetailsView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(CharacterTagDetailsUIController)
			}
		},
		{
			UI_TYPE.UI_MONOGETACTIVEPOINTVIEW,
			new UIData
			{
				mobilePath = "UI/MonoGetActivePointViewView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MonoGetActivePointViewUIController)
			}
		},
		{
			UI_TYPE.UI_NOMALREWARDONE,
			new UIData
			{
				mobilePath = "UI/NomalRewardOneView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(NomalRewardOneUIController)
			}
		},
		{
			UI_TYPE.UI_COMMONACQUIRECHARACTERSHOW,
			new UIData
			{
				mobilePath = "UI/CommonAcquireCharacterShowView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CommonAcquireCharacterShowUIController)
			}
		},
		{
			UI_TYPE.UI_USEITEM,
			new UIData
			{
				mobilePath = "UI/UseItem",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(UseItemUIController)
			}
		},
		{
			UI_TYPE.UI_GETACTIVEPOINT,
			new UIData
			{
				mobilePath = "UI/MonoGetActivePointView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MonoGetActivePointUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPSUITFILTER,
			new UIData
			{
				mobilePath = "UI/EquipSuitFIlterView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(EquipSuitFIlterUIController)
			}
		},
		{
			UI_TYPE.UI_TEXTPANELRAID,
			new UIData
			{
				mobilePath = "UI/TextPanelRaidView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TextPanelRaidUIController)
			}
		},
		{
			UI_TYPE.UI_BOTTLEMATCHANGEWINDOW,
			new UIData
			{
				mobilePath = "UI/BottleMatChangeWindowView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(BottleMatChangeWindowUIController)
			}
		},
		{
			UI_TYPE.UI_GUIDEIMAGEVIDEO,
			new UIData
			{
				mobilePath = "UI/GuideImageVideoView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(GuideImageVideoUIController)
			}
		},
		{
			UI_TYPE.UI_MONOJOURNEYTRACESVIEW,
			new UIData
			{
				mobilePath = "UI/MonoJourneyTracesView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MonoJourneyTracesUIController)
			}
		},
		{
			UI_TYPE.UI_LOUNGEMAIN,
			new UIData
			{
				mobilePath = "UI/LoungeMainView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(LoungeMainUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPPLAYERLVANDWORLDLVVIEW,
			new UIData
			{
				mobilePath = "UI/PopUpPlayerLvAndWorldLvView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpPlayerLvAndWorldLvUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPWORLDLEVELINTRODUCTION,
			new UIData
			{
				mobilePath = "UI/PopUpWorldLevelIntroductionView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpWorldLevelIntroductionUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPWORLDLEVELUPGRADE,
			new UIData
			{
				mobilePath = "UI/PopUpWorldLevelUpgradeView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpWorldLevelUpgradeUIController)
			}
		},
		{
			UI_TYPE.UI_DIVINEEYE,
			new UIData
			{
				mobilePath = "UI/DivineEyeView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(DivineEyeUIController)
			}
		},
		{
			UI_TYPE.UI_RAIDOPENINGPERFORMANCE,
			new UIData
			{
				mobilePath = "UI/RaidOpeningPerformanceView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = false,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Toast,
				UIController = typeof(RaidOpeningPerformanceUIController)
			}
		},
		{
			UI_TYPE.UI_GiveGiftView,
			new UIData
			{
				mobilePath = "UI/UI_GiveGiftView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(UI_GiveGiftUIController)
			}
		},
		{
			UI_TYPE.UI_RAIDBOSSEXIT,
			new UIData
			{
				mobilePath = "UI/RaidBossExitView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RaidBossExitUIController)
			}
		},
		{
			UI_TYPE.UI_INVITECHARACTER,
			new UIData
			{
				mobilePath = "UI/UI_InviteCharacterView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(UI_InviteCharacterUIController)
			}
		},
		{
			UI_TYPE.UI_INVITECHARACTERCONFIRM,
			new UIData
			{
				mobilePath = "UI/UI_InviteCharacterConfirmView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(UI_InviteCharacterConfirmUIController)
			}
		},
		{
			UI_TYPE.UI_INVITECHARACTERWITHMAP,
			new UIData
			{
				mobilePath = "UI/UI_InviteCharacterWithMapView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(UI_InviteCharacterWithMapUIController)
			}
		},
		{
			UI_TYPE.UI_SORTSETTING,
			new UIData
			{
				mobilePath = "UI/SortSettingView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SortSettingUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPELITERESET,
			new UIData
			{
				mobilePath = "UI/PopupEliteResetView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupEliteResetUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPELITELEVELUP,
			new UIData
			{
				mobilePath = "UI/PopupEliteLevelUpView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupEliteLevelUpUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPELITELEVELUPNEW,
			new UIData
			{
				mobilePath = "UI/PopupEliteLevelUpNewView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupEliteLevelUpNewUIController)
			}
		},
		{
			UI_TYPE.UI_SKILLUNLOCK,
			new UIData
			{
				mobilePath = "UI/SkillUnlockView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SkillUnlockUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPELITEBACKPOINT,
			new UIData
			{
				mobilePath = "UI/PopupEliteBackPointView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupEliteBackPointUIController)
			}
		},
		{
			UI_TYPE.UI_MONOABYSSTEAMMONSTER,
			new UIData
			{
				mobilePath = "UI/MonoAbyssTeamMonsterView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(MonoAbyssTeamMonsterUIController)
			}
		},
		{
			UI_TYPE.UI_COMMONWORLDSUCCESS,
			new UIData
			{
				mobilePath = "UI/CommonWorldSuccessView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CommonWorldSuccessUIController)
			}
		},
		{
			UI_TYPE.UI_COMMONWORLDFAIL,
			new UIData
			{
				mobilePath = "UI/CommonWorldFailView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CommonWorldFailUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPELITEBREAK,
			new UIData
			{
				mobilePath = "UI/PopupEliteBreakView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupEliteBreakUIController)
			}
		},
		{
			UI_TYPE.UI_BATTLEPASS,
			new UIData
			{
				mobilePath = "UI/BattlePassView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(BattlePassUIController)
			}
		},
		{
			UI_TYPE.UI_TREASUREADDITIONS,
			new UIData
			{
				mobilePath = "UI/TreasureAdditionsView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TreasureAdditionsUIController)
			}
		},
		{
			UI_TYPE.UI_TEXTLIBRARY,
			new UIData
			{
				mobilePath = "UI/TextLibraryView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TextLibraryUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPBATTLEPASSBUYLEVEL,
			new UIData
			{
				mobilePath = "UI/PopUpBattlePassBuyLevelView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpBattlePassBuyLevelUIController)
			}
		},
		{
			UI_TYPE.UI_INVENTORYEQUIPSUITFILTER,
			new UIData
			{
				mobilePath = "UI/InventoryEquipSuitFilterView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(InventoryEquipSuitFilterUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPDECOMPOSE,
			new UIData
			{
				mobilePath = "UI/EquipDecomposeView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(EquipDecomposeUIController)
			}
		},
		{
			UI_TYPE.UI_RECOVERYITEM,
			new UIData
			{
				mobilePath = "UI/RecoveryItemView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(RecoveryItemUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEENTRANCE,
			new UIData
			{
				mobilePath = "UI/RogueEntranceView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueEntranceUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEEXIT,
			new UIData
			{
				mobilePath = "UI/RogueExitView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(RogueExitUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEFAIL,
			new UIData
			{
				mobilePath = "UI/RogueFailView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueFailUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPMULTIBOX,
			new UIData
			{
				mobilePath = "UI/PopupMultiBoxView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupMultiBoxUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUEREPLACEMENTITEM,
			new UIData
			{
				mobilePath = "UI/RogueReplacementItemView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(RogueReplacementItemUIController)
			}
		},
		{
			UI_TYPE.UI_EQUIPGEM,
			new UIData
			{
				mobilePath = "UI/EquipGemView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(EquipGemUIController)
			}
		},
		{
			UI_TYPE.UI_ACQUIRECHARACTERSHOWPURPLE,
			new UIData
			{
				mobilePath = "UI/AcquireCharacterShowViewPurple",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(AcquireCharacterShowPurpleUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPEXCHANGECODE,
			new UIData
			{
				mobilePath = "UI/PopUpExchangeCodeView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpExchangeCodeUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSWITCHROLES,
			new UIData
			{
				mobilePath = "UI/PopupSwitchRolesView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupSwitchRolesUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPWILDBOSSGETREWARD,
			new UIData
			{
				mobilePath = "UI/PopUpWildBossGetRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpWildBossGetRewardUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPWILDBOSSBUYREWARD,
			new UIData
			{
				mobilePath = "UI/PopUpWildBossBuyRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpWildBossBuyRewardUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPWILDBOSSCOUNTDOWN,
			new UIData
			{
				mobilePath = "UI/PopUpWildBossCountdownView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpWildBossCountdownUIController)
			}
		},
		{
			UI_TYPE.UI_SHOP,
			new UIData
			{
				mobilePath = "UI/ShopView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(ShopUIController)
			}
		},
		{
			UI_TYPE.UI_LARGEMAPBOSSREWARD,
			new UIData
			{
				mobilePath = "UI/LargeMapBossRewardView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(LargeMapBossRewardUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUETALENTTREE,
			new UIData
			{
				mobilePath = "UI/RogueTalentTreeView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(RogueTalentTreeUIController)
			}
		},
		{
			UI_TYPE.UI_ROGUETALENTUNLOCK,
			new UIData
			{
				mobilePath = "UI/RogueTalentUnLockView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(RogueTalentUnLockUIController)
			}
		},
		{
			UI_TYPE.UI_BUNDLEPURCHASE,
			new UIData
			{
				mobilePath = "UI/BundlePurchaseView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(BundlePurchaseUIController)
			}
		},
		{
			UI_TYPE.UI_SELFSELECTBUNDLEPURCHASE,
			new UIData
			{
				mobilePath = "UI/SelfSelectBundlePurchaseView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SelfSelectBundlePurchaseUIController)
			}
		},
		{
			UI_TYPE.UI_MONOACCOMPLISHMENT,
			new UIData
			{
				mobilePath = "UI/MonoAccomplishmentView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MonoAccomplishmentUIController)
			}
		},
		{
			UI_TYPE.UI_MONOACCOMPLISHMENTDETAILS,
			new UIData
			{
				mobilePath = "UI/MonoAccomplishmentDetailsView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MonoAccomplishmentDetailsUIController)
			}
		},
		{
			UI_TYPE.UI_ACHIEVEMENTTOASTTIPS,
			new UIData
			{
				mobilePath = "UI/AchievementToastTipsView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AchievementToastTipsUIController)
			}
		},
		{
			UI_TYPE.UI_SKINPURCHASE,
			new UIData
			{
				mobilePath = "UI/SkinPurchaseView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(SkinPurchaseUIController)
			}
		},
		{
			UI_TYPE.UI_FREEDIAMONDEXCHANGE,
			new UIData
			{
				mobilePath = "UI/FreeDiamondExchangeView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(FreeDiamondExchangeUIController)
			}
		},
		{
			UI_TYPE.UI_SKINREWARD,
			new UIData
			{
				mobilePath = "UI/SkinRewardView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SkinRewardUIController)
			}
		},
		{
			UI_TYPE.UI_JUMPTOCOSTDIAMOND,
			new UIData
			{
				mobilePath = "UI/JumpToCostDiamondView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(JumpToCostDiamondUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPPROTAGONISTEXITVIEW,
			new UIData
			{
				mobilePath = "UI/PopUpProtagonistExitViewView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(PopUpProtagonistExitViewUIController)
			}
		},
		{
			UI_TYPE.UI_INPUTBINDINGPANEL,
			new UIData
			{
				mobilePath = "UI/InputBindingPanel",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(InputBindingPanelController)
			}
		},
		{
			UI_TYPE.UI_BATTLEPASSBUYPREMIUM,
			new UIData
			{
				mobilePath = "UI/BattlePassBuyPremiumView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(BattlePassBuyPremiumUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERSKIN,
			new UIData
			{
				mobilePath = "UI/CharacterSkinView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CharacterSkinUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPCHARACTERSKINBUY,
			new UIData
			{
				mobilePath = "UI/PopupCharacterSkinBuyView",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupCharacterSkinBuyUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPCHARACTERSKINACQUIRE,
			new UIData
			{
				mobilePath = "UI/PopupCharacterSkinAcquireView",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(PopupCharacterSkinAcquireUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPTEXTPANEL_LITE_,
			new UIData
			{
				mobilePath = "UI/PopUpTextPanel_Lite_View",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpTextPanel_Lite_UIController)
			}
		},
		{
			UI_TYPE.UI_MONTHCARDREWARD,
			new UIData
			{
				mobilePath = "UI/MonthCardRewardView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(MonthCardRewardUIController)
			}
		},
		{
			UI_TYPE.UI_VOICEPACKAGE,
			new UIData
			{
				mobilePath = "UI/VoicePackageView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(VoicePackageUIController)
			}
		},
		{
			UI_TYPE.UI_JUMPTOFREEDIAMONDVIEW,
			new UIData
			{
				mobilePath = "UI/JumpToFreeDiamondView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(JumpToFreeDiamondViewUIController)
			}
		},
		{
			UI_TYPE.UI_GACHAINSUFFICIENTPROPS,
			new UIData
			{
				mobilePath = "UI/GachaInsufficientPropsView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(GachaInsufficientPropsUIController)
			}
		},
		{
			UI_TYPE.UI_SLAPTENDAYSIGNIN,
			new UIData
			{
				mobilePath = "UI/SlapTenDaySignIn",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(SlapTendaySigninUIController)
			}
		},
		{
			UI_TYPE.UI_DEPARTUREPACKAGE,
			new UIData
			{
				mobilePath = "UI/DeparturePackage",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(DeparturePackageUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERSKINPACKAGE,
			new UIData
			{
				mobilePath = "UI/CharacterSkinPackageView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(CharacterSkinPackageUIController)
			}
		},
		{
			UI_TYPE.UI_NEWBIELOGIN,
			new UIData
			{
				mobilePath = "UI/NewbieLoginView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(NewbieLoginUIController)
			}
		},
		{
			UI_TYPE.UI_ONETREATMAIN,
			new UIData
			{
				mobilePath = "UI/OneTreatMainView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(OneTreatMainUIController)
			}
		},
		{
			UI_TYPE.UI_ONETREATTASK,
			new UIData
			{
				mobilePath = "UI/OneTreatTaskView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(OneTreatTaskUIController)
			}
		},
		{
			UI_TYPE.UI_ONETREATSCRAPINGPRIZE,
			new UIData
			{
				mobilePath = "UI/OneTreatScrapingPrizeView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(OneTreatScrapingPrizeUIController)
			}
		},
		{
			UI_TYPE.UI_TEAMTEACHING,
			new UIData
			{
				mobilePath = "UI/TeamTeachingView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TeamTeachingUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSTATEOBJECTINTRO,
			new UIData
			{
				mobilePath = "UI/PopupStateObjectIntroView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupStateObjectIntroUIController)
			}
		},
		{
			UI_TYPE.UI_SHARE,
			new UIData
			{
				mobilePath = "UI/ShareView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(ShareUIController)
			}
		},
		{
			UI_TYPE.UI_SNSPREOPEN,
			new UIData
			{
				mobilePath = "UI/SNSPreOpenView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(SNSPreOpenUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPCHANGENAMESIGNATURE,
			new UIData
			{
				mobilePath = "UI/PopUpChangeNameSignatureView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpChangeNameSignatureUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPACCOUNTDECORATIONCHANGENAMEVIEW,
			new UIData
			{
				mobilePath = "UI/PopUpAccountDecorationChangeNameView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopUpAccountDecorationChangeNameViewUIController)
			}
		},
		{
			UI_TYPE.UI_CHARACTERPRESENTATION,
			new UIData
			{
				mobilePath = "UI/CharacterPresentationView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(CharacterPresentationUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPCHARACTERQUICKSELECT,
			new UIData
			{
				mobilePath = "UI/PopupCharacterQuickSelectView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupCharacterQuickSelectUIController)
			}
		},
		{
			UI_TYPE.UI_QUICKPOWEREXCHANGEITEM,
			new UIData
			{
				mobilePath = "UI/QuickPowerExchangeItemView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(QuickPowerExchangeItemUIController)
			}
		},
		{
			UI_TYPE.UI_TENTICKETGIFT,
			new UIData
			{
				mobilePath = "UI/TenTicketGiftView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(TenTicketGiftUIController)
			}
		},
		{
			UI_TYPE.UI_TEMPLEBUFFSELECT,
			new UIData
			{
				mobilePath = "UI/TempleBuffSelectView",
				pcPath = "",
				UIController = typeof(TempleBuffSelectUIController),
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp
			}
		},
		{
			UI_TYPE.UI_TEMPLEBUFFRECORD,
			new UIData
			{
				mobilePath = "UI/TempleBuffRecordView",
				pcPath = "",
				UIController = typeof(TempleBuffRecordUIController),
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp
			}
		},
		{
			UI_TYPE.UI_EQUIPBUFFFILTER,
			new UIData
			{
				mobilePath = "UI/EquipBuffFilterView",
				pcPath = "",
				UIController = typeof(EquipBuffFilterUIController),
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp
			}
		},
		{
			UI_TYPE.UI_ITEMCONVERTOVERFLOW,
			new UIData
			{
				mobilePath = "UI/ItemConvertOverflowView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(ItemConvertOverflowUIController)
			}
		},
		{
			UI_TYPE.UI_ABYSSHISTORYRECORD,
			new UIData
			{
				mobilePath = "UI/AbyssHistoryRecordView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(AbyssHistoryRecordUIController)
			}
		},
		{
			UI_TYPE.UI_ABYSSPOPUPREWARDONEROW,
			new UIData
			{
				mobilePath = "UI/AbyssPopUpRewardOneView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(AbyssPopUpRewardOneRowUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPTARGETGACHA,
			new UIData
			{
				mobilePath = "UI/PopupTargetGachaView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupTargetGachaUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPTARGETGACHAREMINDER,
			new UIData
			{
				mobilePath = "UI/PopupTargetGachaReminderView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupTargetGachaReminderUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPTARGETGACHACANCELCONFIRM,
			new UIData
			{
				mobilePath = "UI/PopupTargetGachaCancelConfirmView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupTargetGachaCancelConfirmUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSWITCHSWITCHVOICE,
			new UIData
			{
				mobilePath = "UI/PopupSwitchSwitchVoiceView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupSwitchSwitchVoiceUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPDOWNLOADINSTRUCTIONS,
			new UIData
			{
				mobilePath = "UI/PopupDownloadInstructionsView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupDownloadInstructionsUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPDOWNLOADPROCESS,
			new UIData
			{
				mobilePath = "UI/PopupDownloadProcessView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupDownloadProcessUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPSWITCHVOICEPROMPTS,
			new UIData
			{
				mobilePath = "UI/PopupSwitchVoicePromptsView",
				pcPath = "",
				UIController = typeof(PopupSwitchVoicePromptsUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPPREDOWNLOADPROMPT,
			new UIData
			{
				mobilePath = "UI/PopupPreDownloadPromptView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.Sequence,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupPreDownloadPromptUIController)
			}
		},
		{
			UI_TYPE.UI_MISSIONPERMISSIONLEVEL,
			new UIData
			{
				mobilePath = "UI/MissionPermissionLevelView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(MissionPermissionLevelUIController)
			}
		},
		{
			UI_TYPE.UI_TASK,
			new UIData
			{
				mobilePath = "UI/TaskView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(TaskUIController)
			}
		},
		{
			UI_TYPE.UI_POPUPRAIDDOUBLE,
			new UIData
			{
				mobilePath = "UI/PopupRaidDoubleView",
				pcPath = "",
				layer = UI_LAYER.POPUP,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = false,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.PopUp,
				UIController = typeof(PopupRaidDoubleUIController)
			}
		},
		{
			UI_TYPE.UI_FULLSCREENVIDEO,
			new UIData
			{
				mobilePath = "UI/FullScreenVideoView",
				pcPath = "",
				layer = UI_LAYER.NORMAL,
				InstanceStrategy = UIInstanceStrategy.SingleInstance,
				TransitionStrategy = UITransitionStrategy.CrossFade,
				RequireBlackScreenTransition = true,
				DisableInputOnTransition = true,
				SystemId = 0,
				IsConnectSystem = false,
				PanelType = UIPanelType.Panel,
				UIController = typeof(FullScreenVideoUIController)
			}
		},
		{
			UI_TYPE.UI_MAX,
			null
		}
	};
}
