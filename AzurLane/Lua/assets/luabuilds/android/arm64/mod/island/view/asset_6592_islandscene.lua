class = var_0_10000

local var_0_0 = "IslandScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.IslandBaseScene"))

var_0_1.ON_INVENTORY_FILTER = "IslandScene:ON_INVENTORY_FILTER"
var_0_1.ON_CHECK_ORDER_EXP_AWARD = "IslandScene:ON_CHECK_ORDER_EXP_AWARD"

function var_0_1.getUIName(arg_1_0)
	return "IslandUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_3_0)
			var_0_1.super.preload(arg_2_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			IslandTaskActhelper = var_2_10001

			var_2_10001.TriggerActTasks(arg_4_0)

			return
		end,
		function(arg_5_0)
			IslandTaskHelper = var_2_10001

			var_2_10001.FixTaskLinksStory(arg_5_0)

			return
		end
	}, function()
		arg_2_1()

		return
	end)

	return
end

function var_0_1.loadingQueue(arg_7_0)
	return function(arg_8_0)
		pg = var_2_10001

		local var_8_0 = var_2_10001.SceneAnimMgr.GetInstance()

		var_1.CommonSceneChange(var_8_0, "Dorm3DLoading", function(arg_9_0)
			return arg_8_0(arg_9_0)
		end)

		return
	end
end

function var_0_1.GetIsland(arg_10_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)

	return var_1.GetIsland(var_10_0)
end

function var_0_1.init(arg_11_0)
	local var_11_0 = arg_11_0._tf

	arg_11_0.visitorBtn = var_1.Find(var_11_0, "top/visitor")
	IslandLevelPanel = var_1
	arg_11_0.levelPanel = var_1.New(arg_11_0._tf, arg_11_0.event)
	Island3dTaskTrackPanel = var_1

	local var_11_1 = var_1.New
	local var_11_2 = arg_11_0._tf

	arg_11_0.taskTrackPanel = var_11_1(var_3.Find(var_11_2, "track_container"), arg_11_0.event)
	IslandAwardDisplayInMainPanel = var_1

	local var_11_3 = var_1.New
	local var_11_4 = arg_11_0._tf
	local var_11_5 = arg_11_0.event

	setmetatable = var_11_2
	arg_11_0.awardDisplayPanel = var_11_3(var_11_4, var_11_5, var_11_2({
		needAdapt = true
	}, {
		__index = arg_11_0.contextData
	}))
	IslandMainBtnContainer = var_1

	local var_11_6 = var_1.New
	local var_11_7 = arg_11_0._tf

	arg_11_0.btnContainer = var_11_6(var_3.Find(var_11_7, "top/btn_container"), arg_11_0.event)

	return
end

function var_0_1.didEnter(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.visitorBtn

	local function var_12_2()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.OpenPage

		IslandVisitorPage = var_2_10003

		var_13_1(var_13_0, var_2_10003)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_12_0, var_12_1, var_12_2, var_1_10006)
	arg_12_0:SetUp()

	local var_12_3 = arg_12_0.contextData.resumeCallback
	local var_12_4 = arg_12_0.contextData

	var_12_4.resumeCallback = nil
	existCall = var_12_4

	var_12_4(var_12_3)

	return
end

function var_0_1.SetUp(arg_14_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_15_0)
			local var_15_0 = arg_14_0

			var_1.SetDressUpIsEmpty(var_15_0, arg_15_0)

			return
		end
	}, function()
		local var_16_0 = arg_14_0

		var_0.StartCore(var_16_0)

		return
	end)

	return
end

function var_0_1.SetNameIfIsEmpty(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetIsland()

	if not var_2.IsNew(var_17_0) then
		arg_17_1()

		return
	end

	IslandSetNamePage = var_2

	local var_17_1 = var_2.New(arg_17_0)

	var_2.ExecuteAction(var_17_1, "Show", function()
		local var_18_0 = var_0

		var_0.Destroy(var_18_0)
		arg_17_1()

		return
	end)

	return
end

function var_0_1.SetDressUpIsEmpty(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetIsland()
	local var_19_1 = var_2.GetDressUpAgency(var_19_0)

	if not var_2.IsNew(var_19_1) then
		arg_19_1()

		return
	end

	local var_19_2 = arg_19_0
	local var_19_3 = arg_19_0.OpenPage

	IslandShipFirstDressupPage = var_1_10005

	var_19_3(var_19_2, var_1_10005, arg_19_1)

	return
end

function var_0_1.AddListeners(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.AddListener

	GAME = var_1_10004

	var_20_1(var_20_0, var_1_10004.ISLAND_UPGRADE_DONE, arg_20_0.OnUpgrade)

	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.AddListener

	Island = var_4

	var_20_3(var_20_2, var_4.EXP_ADD, arg_20_0.OnExpChange)

	local var_20_4 = arg_20_0
	local var_20_5 = arg_20_0.AddListener

	GAME = var_4

	var_20_5(var_20_4, var_4.ISLAND_SET_NAME_DONE, arg_20_0.OnModifyName)

	local var_20_6 = arg_20_0
	local var_20_7 = arg_20_0.AddListener

	GAME = var_4

	var_20_7(var_20_6, var_4.ISLAND_PROSPERITY_AWARD_DONE, arg_20_0.OnGetProsperityAward)

	local var_20_8 = arg_20_0
	local var_20_9 = arg_20_0.AddListener

	IslandTaskAgency = var_4

	var_20_9(var_20_8, var_4.TASK_ADDED, arg_20_0.OnAddedTask)

	local var_20_10 = arg_20_0
	local var_20_11 = arg_20_0.AddListener

	IslandTaskAgency = var_4

	var_20_11(var_20_10, var_4.TASK_UPDATED, arg_20_0.OnUpdateTask)

	local var_20_12 = arg_20_0
	local var_20_13 = arg_20_0.AddListener

	IslandTaskAgency = var_4

	var_20_13(var_20_12, var_4.TASK_REMOVED, arg_20_0.OnRemoveTask)

	local var_20_14 = arg_20_0
	local var_20_15 = arg_20_0.AddListener

	IslandAchievementAgency = var_4

	var_20_15(var_20_14, var_4.NEW_CAN_GET, arg_20_0.OnNewAchievementCanGet)

	local var_20_16 = arg_20_0
	local var_20_17 = arg_20_0.AddListener

	GAME = var_4

	var_20_17(var_20_16, var_4.ISLAND_FINISH_DELEGATION_DONE, arg_20_0.OnFinishDelegation)

	local var_20_18 = arg_20_0
	local var_20_19 = arg_20_0.AddListener

	GAME = var_4

	var_20_19(var_20_18, var_4.ISLAND_UNLOCK_TECH_DONE, arg_20_0.OnUnlockTechnology)

	local var_20_20 = arg_20_0
	local var_20_21 = arg_20_0.AddListener

	IslandCharacterAgency = var_4

	var_20_21(var_20_20, var_4.ADD_SHIP, arg_20_0.OnAddShip)

	local var_20_22 = arg_20_0
	local var_20_23 = arg_20_0.AddListener

	IslandCharacterAgency = var_4

	var_20_23(var_20_22, var_4.SHIP_LEVEL_UP, arg_20_0.OnShipLevelUp)

	local var_20_24 = arg_20_0
	local var_20_25 = arg_20_0.AddListener

	IslandCharacterAgency = var_4

	var_20_25(var_20_24, var_4.SHIP_GET_STATE, arg_20_0.OnShipGetState)

	local var_20_26 = arg_20_0
	local var_20_27 = arg_20_0.AddListener

	IslandAblityAgency = var_4

	var_20_27(var_20_26, var_4.UNLOCK_SYSTEM, arg_20_0.OnUnlockSystem)

	local var_20_28 = arg_20_0
	local var_20_29 = arg_20_0.AddListener

	IslandVisitorAgency = var_4

	var_20_29(var_20_28, var_4.PLAYER_ADD, arg_20_0.OnVisitorNumChange)

	local var_20_30 = arg_20_0
	local var_20_31 = arg_20_0.AddListener

	IslandVisitorAgency = var_4

	var_20_31(var_20_30, var_4.PLAYER_EXIT, arg_20_0.OnVisitorNumChange)

	local var_20_32 = arg_20_0
	local var_20_33 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_33(var_20_32, var_4.ENTER_EDIT_AGORA, arg_20_0.OnAgoraEnterEditMode)

	local var_20_34 = arg_20_0
	local var_20_35 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_35(var_20_34, var_4.EXIT_EDIT_AGORA, arg_20_0.OnAgoraExitEditMode)

	local var_20_36 = arg_20_0
	local var_20_37 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_37(var_20_36, var_4.TRIGGER_TASK, arg_20_0.OnTriggerTask)

	local var_20_38 = arg_20_0
	local var_20_39 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_39(var_20_38, var_4.SUBMIT_TASK, arg_20_0.OnSubmitTask)

	local var_20_40 = arg_20_0
	local var_20_41 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_41(var_20_40, var_4.ADD_TASK_PROGRESS, arg_20_0.OnAddTaskProgress)

	local var_20_42 = arg_20_0
	local var_20_43 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_43(var_20_42, var_4.PLAY_STORY, arg_20_0.OnPlayStory)

	local var_20_44 = arg_20_0
	local var_20_45 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_45(var_20_44, var_4.SWITCH_MAP, arg_20_0.OnSwitchMap)

	local var_20_46 = arg_20_0
	local var_20_47 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_47(var_20_46, var_4.SEEK_GAME_START, arg_20_0.OnSeekGameStart)

	local var_20_48 = arg_20_0
	local var_20_49 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_49(var_20_48, var_4.SEEK_GAME_END, arg_20_0.OnSeekGameEnd)

	local var_20_50 = arg_20_0
	local var_20_51 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_51(var_20_50, var_4.ENTER_FISH_POINT, arg_20_0.OnEnterFishPoint)

	local var_20_52 = arg_20_0
	local var_20_53 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_53(var_20_52, var_4.EXIT_FISH_POINT, arg_20_0.OnExitFishPoint)

	local var_20_54 = arg_20_0
	local var_20_55 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_55(var_20_54, var_4.APPROACH_OBJECT, arg_20_0.OnApproachObject)

	local var_20_56 = arg_20_0
	local var_20_57 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_57(var_20_56, var_4.PLAY_PERFORMANCE, arg_20_0.OnPlayPerformance)

	local var_20_58 = arg_20_0
	local var_20_59 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_59(var_20_58, var_4.SHOW_INTERACTION, arg_20_0.OnShowInteraction)

	local var_20_60 = arg_20_0
	local var_20_61 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_61(var_20_60, var_4.SWITCH_MAP_BY_POINT, arg_20_0.OnSwitchMapByPoint)

	local var_20_62 = arg_20_0
	local var_20_63 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_63(var_20_62, var_4.NAV_PATH, arg_20_0.OnStartNavPath)

	local var_20_64 = arg_20_0
	local var_20_65 = arg_20_0.AddListener

	ISLAND_EX_EVT = var_4

	var_20_65(var_20_64, var_4.NAV_PATH_DONE, arg_20_0.OnNavPathDone)

	return
end

function var_0_1.RemoveListeners(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.RemoveListener

	GAME = var_1_10004

	var_21_1(var_21_0, var_1_10004.ISLAND_UPGRADE_DONE, arg_21_0.OnUpgrade)

	local var_21_2 = arg_21_0
	local var_21_3 = arg_21_0.RemoveListener

	Island = var_4

	var_21_3(var_21_2, var_4.EXP_ADD, arg_21_0.OnExpChange)

	local var_21_4 = arg_21_0
	local var_21_5 = arg_21_0.RemoveListener

	GAME = var_4

	var_21_5(var_21_4, var_4.ISLAND_SET_NAME_DONE, arg_21_0.OnModifyName)

	local var_21_6 = arg_21_0
	local var_21_7 = arg_21_0.RemoveListener

	GAME = var_4

	var_21_7(var_21_6, var_4.ISLAND_PROSPERITY_AWARD_DONE, arg_21_0.OnGetProsperityAward)

	local var_21_8 = arg_21_0
	local var_21_9 = arg_21_0.RemoveListener

	IslandTaskAgency = var_4

	var_21_9(var_21_8, var_4.TASK_ADDED, arg_21_0.OnAddedTask)

	local var_21_10 = arg_21_0
	local var_21_11 = arg_21_0.RemoveListener

	IslandTaskAgency = var_4

	var_21_11(var_21_10, var_4.TASK_UPDATED, arg_21_0.OnUpdateTask)

	local var_21_12 = arg_21_0
	local var_21_13 = arg_21_0.RemoveListener

	IslandTaskAgency = var_4

	var_21_13(var_21_12, var_4.TASK_REMOVED, arg_21_0.OnRemoveTask)

	local var_21_14 = arg_21_0
	local var_21_15 = arg_21_0.RemoveListener

	IslandAchievementAgency = var_4

	var_21_15(var_21_14, var_4.NEW_CAN_GET, arg_21_0.OnNewAchievementCanGet)

	local var_21_16 = arg_21_0
	local var_21_17 = arg_21_0.RemoveListener

	GAME = var_4

	var_21_17(var_21_16, var_4.ISLAND_FINISH_DELEGATION_DONE, arg_21_0.OnFinishDelegation)

	local var_21_18 = arg_21_0
	local var_21_19 = arg_21_0.RemoveListener

	GAME = var_4

	var_21_19(var_21_18, var_4.ISLAND_UNLOCK_TECH_DONE, arg_21_0.OnUnlockTechnology)

	local var_21_20 = arg_21_0
	local var_21_21 = arg_21_0.RemoveListener

	IslandCharacterAgency = var_4

	var_21_21(var_21_20, var_4.ADD_SHIP, arg_21_0.OnAddShip)

	local var_21_22 = arg_21_0
	local var_21_23 = arg_21_0.RemoveListener

	IslandCharacterAgency = var_4

	var_21_23(var_21_22, var_4.SHIP_LEVEL_UP, arg_21_0.OnShipLevelUp)

	local var_21_24 = arg_21_0
	local var_21_25 = arg_21_0.RemoveListener

	IslandCharacterAgency = var_4

	var_21_25(var_21_24, var_4.SHIP_GET_STATE, arg_21_0.OnShipGetState)

	local var_21_26 = arg_21_0
	local var_21_27 = arg_21_0.RemoveListener

	IslandAblityAgency = var_4

	var_21_27(var_21_26, var_4.UNLOCK_SYSTEM, arg_21_0.OnUnlockSystem)

	local var_21_28 = arg_21_0
	local var_21_29 = arg_21_0.RemoveListener

	IslandVisitorAgency = var_4

	var_21_29(var_21_28, var_4.PLAYER_ADD, arg_21_0.OnVisitorNumChange)

	local var_21_30 = arg_21_0
	local var_21_31 = arg_21_0.RemoveListener

	IslandVisitorAgency = var_4

	var_21_31(var_21_30, var_4.PLAYER_EXIT, arg_21_0.OnVisitorNumChange)

	local var_21_32 = arg_21_0
	local var_21_33 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_33(var_21_32, var_4.ENTER_EDIT_AGORA, arg_21_0.OnAgoraEnterEditMode)

	local var_21_34 = arg_21_0
	local var_21_35 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_35(var_21_34, var_4.EXIT_EDIT_AGORA, arg_21_0.OnAgoraExitEditMode)

	local var_21_36 = arg_21_0
	local var_21_37 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_37(var_21_36, var_4.TRIGGER_TASK, arg_21_0.OnTriggerTask)

	local var_21_38 = arg_21_0
	local var_21_39 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_39(var_21_38, var_4.SUBMIT_TASK, arg_21_0.OnSubmitTask)

	local var_21_40 = arg_21_0
	local var_21_41 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_41(var_21_40, var_4.ADD_TASK_PROGRESS, arg_21_0.OnAddTaskProgress)

	local var_21_42 = arg_21_0
	local var_21_43 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_43(var_21_42, var_4.PLAY_STORY, arg_21_0.OnPlayStory)

	local var_21_44 = arg_21_0
	local var_21_45 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_45(var_21_44, var_4.SWITCH_MAP, arg_21_0.OnSwitchMap)

	local var_21_46 = arg_21_0
	local var_21_47 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_47(var_21_46, var_4.SEEK_GAME_START, arg_21_0.OnSeekGameStart)

	local var_21_48 = arg_21_0
	local var_21_49 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_49(var_21_48, var_4.SEEK_GAME_END, arg_21_0.OnSeekGameEnd)

	local var_21_50 = arg_21_0
	local var_21_51 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_51(var_21_50, var_4.ENTER_FISH_POINT, arg_21_0.OnEnterFishPoint)

	local var_21_52 = arg_21_0
	local var_21_53 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_53(var_21_52, var_4.EXIT_FISH_POINT, arg_21_0.OnExitFishPoint)

	local var_21_54 = arg_21_0
	local var_21_55 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_55(var_21_54, var_4.APPROACH_OBJECT, arg_21_0.OnApproachObject)

	local var_21_56 = arg_21_0
	local var_21_57 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_57(var_21_56, var_4.PLAY_PERFORMANCE, arg_21_0.OnPlayPerformance)

	local var_21_58 = arg_21_0
	local var_21_59 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_59(var_21_58, var_4.SHOW_INTERACTION, arg_21_0.OnShowInteraction)

	local var_21_60 = arg_21_0
	local var_21_61 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_61(var_21_60, var_4.SWITCH_MAP_BY_POINT, arg_21_0.OnSwitchMapByPoint)

	local var_21_62 = arg_21_0
	local var_21_63 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_63(var_21_62, var_4.NAV_PATH, arg_21_0.OnStartNavPath)

	local var_21_64 = arg_21_0
	local var_21_65 = arg_21_0.RemoveListener

	ISLAND_EX_EVT = var_4

	var_21_65(var_21_64, var_4.NAV_PATH_DONE, arg_21_0.OnNavPathDone)

	return
end

function var_0_1.OnEnterFishPoint(arg_22_0)
	arg_22_0:TryDisVisible()

	return
end

function var_0_1.OnExitFishPoint(arg_23_0)
	arg_23_0:TryVisible()

	return
end

function var_0_1.OnOpenAnimatonOpPage(arg_24_0)
	local var_24_0 = arg_24_0.btnContainer

	var_1.ActiveOrDisactive(var_24_0, false)

	return
end

function var_0_1.OnCloseAnimatonOpPage(arg_25_0)
	local var_25_0 = arg_25_0.btnContainer

	var_1.ActiveOrDisactive(var_25_0, true)

	return
end

function var_0_1.OnStartNavPath(arg_26_0, arg_26_1)
	if arg_26_1 then
		pg = var_1_10002

		local var_26_0 = var_1_10002.m02
		local var_26_1 = var_2.sendNotification

		GAME = var_1_10005

		var_26_1(var_26_0, var_1_10005.STORY_UPDATE, {
			storyId = arg_26_1
		})
	end

	return
end

function var_0_1.OnNavPathDone(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetIsland()
	local var_27_1 = var_2.DispatchEvent

	IslandProxy = var_1_10005

	var_27_1(var_27_0, var_1_10005.END_PATHFINDER)

	return
end

function var_0_1.OnExpChange(arg_28_0)
	local var_28_0 = arg_28_0.levelPanel

	var_1.ExecuteAction(var_28_0, "UpdateIslandInfo")

	return
end

function var_0_1.ShowExpAdd(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.levelPanel

	var_3.ExecuteAction(var_29_0, "ShowExpAdd", arg_29_1, arg_29_2)

	return
end

function var_0_1.OnSwitchMapByPoint(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.mapId
	local var_30_1 = arg_30_0:GetIsland()

	var_3.SetLastExitPosition(var_30_1, arg_30_1.mapId, arg_30_1.position, arg_30_1.rotation)

	local var_30_2 = arg_30_0
	local var_30_3 = arg_30_0.emit

	IslandBaseMediator = var_6

	var_30_3(var_30_2, var_6.SWITCH_MAP, var_30_0)

	return
end

function var_0_1.OnShowInteraction(arg_31_0, arg_31_1)
	IslandGuideChecker = var_1_10002

	var_1_10002.CheckOnShowInteraction(arg_31_1)

	return
end

function var_0_1.OnPlayPerformance(arg_32_0, arg_32_1)
	arg_32_0:PlayPerformance(arg_32_1)

	return
end

function var_0_1.OnSeekGameStart(arg_33_0)
	arg_33_0:TryDisVisible()

	return
end

function var_0_1.OnSeekGameEnd(arg_34_0)
	arg_34_0:TryVisible()

	return
end

function var_0_1.OnSwitchMap(arg_35_0, arg_35_1)
	pg = var_1_10002

	local var_35_0 = var_1_10002.island_world_objects[arg_35_1].mapId
	local var_35_1 = arg_35_0
	local var_35_2 = arg_35_0.emit

	IslandBaseMediator = var_1_10006

	var_35_2(var_35_1, var_1_10006.SWITCH_MAP, var_35_0, arg_35_1)

	return
end

function var_0_1.OnPlayStory(arg_36_0, arg_36_1)
	arg_36_0:PlayStory(arg_36_1)

	return
end

function var_0_1.OnTriggerTask(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetIsland()
	local var_37_1 = var_2.GetTaskAgency(var_37_0)

	if var_2.GetFutureTask(var_37_1, arg_37_1) and var_2:IsUnlock() then
		local var_37_2 = arg_37_0
		local var_37_3 = arg_37_0.emit

		IslandMediator = var_1_10006

		var_37_3(var_37_2, var_1_10006.ON_ACCEPT_TASK, {
			arg_37_1
		})
	end

	return
end

function var_0_1.OnSubmitTask(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:GetIsland()
	local var_38_1 = var_2.GetTaskAgency(var_38_0)

	if var_2.GetTask(var_38_1, arg_38_1) and var_2:IsFinish() then
		local var_38_2 = arg_38_0
		local var_38_3 = arg_38_0.emit

		IslandMediator = var_1_10006

		var_38_3(var_38_2, var_1_10006.ON_SUBMIT_TASK, arg_38_1)
	end

	return
end

function var_0_1.OnAddTaskProgress(arg_39_0, arg_39_1, arg_39_2)
	IslandTaskHelper = var_1_10003

	var_1_10003.UpdateClientTaskProgress(arg_39_1, arg_39_2)

	return
end

function var_0_1.OnApproachObject(arg_40_0, arg_40_1)
	IslandTaskHelper = var_1_10002

	var_1_10002.OnApproach(arg_40_1)

	return
end

function var_0_1.OnUpdateTrackTask(arg_41_0, arg_41_1, arg_41_2)
	IslandTaskTrackCard = var_1_10003

	if arg_41_2 == var_1_10003.TYPES.MAIN then
		arg_41_0.mainTraceTaskId = arg_41_1
	else
		IslandTaskTrackCard = var_3

		if arg_41_2 == var_3.TYPES.OTHER then
			arg_41_0.otherTraceTaskId = arg_41_1
		end
	end

	if arg_41_0.mainTraceTaskId and arg_41_0.mainTraceTaskId ~= 0 or arg_41_0.otherTraceTaskId and arg_41_0.otherTraceTaskId ~= 0 then
		local var_41_0 = arg_41_0.taskTrackPanel

		var_3.ExecuteAction(var_41_0, "Show")
	end

	local var_41_1 = arg_41_0.btnContainer

	var_3.OnTrackTaskChange(var_41_1)

	return
end

function var_0_1.OnAddedTask(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.btnContainer

	var_2.OnTaskUpdate(var_42_0)

	return
end

function var_0_1.OnUpdateTask(arg_43_0, arg_43_1)
	if arg_43_0.mainTraceTaskId and arg_43_0.mainTraceTaskId == arg_43_1.id then
		local var_43_0 = arg_43_0.taskTrackPanel
		local var_43_1 = var_2.ExecuteAction
		local var_43_2 = "UpdateProgress"

		IslandTaskTrackCard = var_1_10006

		var_43_1(var_43_0, var_43_2, var_1_10006.TYPES.MAIN)

		local var_43_3 = arg_43_0.btnContainer

		var_2.OnTrackTaskChange(var_43_3)
	elseif arg_43_0.otherTraceTaskId and arg_43_0.otherTraceTaskId == arg_43_1.id then
		local var_43_4 = arg_43_0.taskTrackPanel
		local var_43_5 = var_2.ExecuteAction
		local var_43_6 = "UpdateProgress"

		IslandTaskTrackCard = var_1_10006

		var_43_5(var_43_4, var_43_6, var_1_10006.TYPES.OTHER)

		local var_43_7 = arg_43_0.btnContainer

		var_2.OnTrackTaskChange(var_43_7)
	end

	local var_43_8 = arg_43_0.btnContainer

	var_2.OnTaskUpdate(var_43_8)

	return
end

function var_0_1.OnRemoveTask(arg_44_0, arg_44_1)
	if arg_44_0.mainTraceTaskId and arg_44_0.mainTraceTaskId == arg_44_1.id then
		local var_44_0 = arg_44_0.taskTrackPanel
		local var_44_1 = var_2.ExecuteAction
		local var_44_2 = "RemoveTask"

		IslandTaskTrackCard = var_1_10006

		var_44_1(var_44_0, var_44_2, var_1_10006.TYPES.MAIN)

		local var_44_3 = arg_44_0.btnContainer

		var_2.OnTrackTaskChange(var_44_3)
	elseif arg_44_0.otherTraceTaskId and arg_44_0.otherTraceTaskId == arg_44_1.id then
		local var_44_4 = arg_44_0.taskTrackPanel
		local var_44_5 = var_2.ExecuteAction
		local var_44_6 = "RemoveTask"

		IslandTaskTrackCard = var_1_10006

		var_44_5(var_44_4, var_44_6, var_1_10006.TYPES.OTHER)

		local var_44_7 = arg_44_0.btnContainer

		var_2.OnTrackTaskChange(var_44_7)
	end

	local var_44_8 = arg_44_0.btnContainer

	var_2.OnTaskUpdate(var_44_8)

	return
end

function var_0_1.UpdateTaskInfo(arg_45_0)
	local var_45_0 = arg_45_0:GetIsland()
	local var_45_1 = var_1.GetTaskAgency(var_45_0)
	local var_45_2 = var_1.GetMainTraceTask(var_45_1)
	local var_45_3 = arg_45_0:GetIsland()
	local var_45_4 = var_2.GetTaskAgency(var_45_3)
	local var_45_5 = var_2.GetTraceTask(var_45_4)

	if var_45_2 then
		arg_45_0.mainTraceTaskId = var_45_2.id
	end

	if var_45_5 then
		arg_45_0.otherTraceTaskId = var_45_5.id
	end

	if arg_45_0.otherTraceTaskId and arg_45_0.otherTraceTaskId ~= 0 or arg_45_0.mainTraceTaskId and arg_45_0.mainTraceTaskId ~= 0 then
		local var_45_6 = arg_45_0.taskTrackPanel

		var_3.ExecuteAction(var_45_6, "Show")
	else
		local var_45_7 = arg_45_0.taskTrackPanel

		var_3.ExecuteAction(var_45_7, "Hide")
	end

	local var_45_8 = arg_45_0.btnContainer

	var_3.OnTrackTaskChange(var_45_8)

	local var_45_9 = arg_45_0.btnContainer

	var_3.OnTaskUpdate(var_45_9)

	return
end

function var_0_1.OnSetUpCore(arg_46_0, arg_46_1, arg_46_2)
	arg_46_0.approachSpawnPointId = arg_46_2

	return
end

function var_0_1.OnAgoraEnterEditMode(arg_47_0)
	setActive = var_1_10001

	var_1_10001(arg_47_0._tf, false)

	return
end

function var_0_1.OnAgoraExitEditMode(arg_48_0)
	setActive = var_1_10001

	var_1_10001(arg_48_0._tf, true)

	return
end

function var_0_1.OnShipGetState(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_1.ship
	local var_49_1 = arg_49_1.status
	local var_49_2 = var_49_0:GetName()
	local var_49_3 = arg_49_0
	local var_49_4 = arg_49_0.ShowToast
	local var_49_5 = {}

	IslandToast = var_1_10009
	var_49_5.type = var_1_10009.TYPE_STATE
	i18n = var_9
	var_49_5.content = var_9("island_toast_status", var_49_1:GetName(), var_49_2)

	var_49_4(var_49_3, var_49_5)

	return
end

function var_0_1.OnShipLevelUp(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1:GetName()
	local var_50_1 = arg_50_1:GetLevel()
	local var_50_2 = arg_50_0
	local var_50_3 = arg_50_0.ShowToast
	local var_50_4 = {}

	i18n = var_1_10008
	var_50_4.content = var_1_10008("island_toast_level", var_50_1, var_50_0)

	var_50_3(var_50_2, var_50_4)

	return
end

function var_0_1.OnAddShip(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1:GetName()
	local var_51_1 = arg_51_0:GetIsland()
	local var_51_2 = var_3.GetName(var_51_1)
	local var_51_3 = arg_51_0
	local var_51_4 = arg_51_0.ShowToast
	local var_51_5 = {}

	i18n = var_1_10008
	var_51_5.content = var_1_10008("island_toast_ship", var_51_2, var_51_0)

	var_51_4(var_51_3, var_51_5)

	return
end

function var_0_1.OnNewAchievementCanGet(arg_52_0, arg_52_1)
	IslandMainBtnTipHelper = var_1_10002

	if not var_1_10002.IsUnlock("achievement") then
		return
	end

	local var_52_0 = arg_52_0
	local var_52_1 = arg_52_0.ShowToast
	local var_52_2 = {}

	i18n = var_1_10006
	var_52_2.content = var_1_10006("island_achv_finish_tip", arg_52_1:getConfig("name"))

	var_52_1(var_52_0, var_52_2)

	return
end

function var_0_1.OnFinishDelegation(arg_53_0)
	local var_53_0 = arg_53_0.btnContainer

	var_1.OnFinishDelegation(var_53_0)

	return
end

function var_0_1.OnUnlockTechnology(arg_54_0)
	local var_54_0 = arg_54_0.btnContainer

	var_1.OnUnlockTechnology(var_54_0)

	return
end

function var_0_1.OnUpgrade(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0.levelPanel

	var_2.ExecuteAction(var_55_0, "UpdateTip")

	local var_55_1 = arg_55_0.levelPanel

	var_2.ExecuteAction(var_55_1, "UpdateIslandInfo")

	local var_55_2 = {}

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_56_0)
			local var_56_0 = arg_55_0
			local var_56_1 = var_1.OpenPage

			IslandUpgradeDisplayPage = var_2_10004

			var_56_1(var_56_0, var_2_10004, arg_55_1.dropData.abilitys, arg_56_0)

			return
		end,
		function(arg_57_0)
			local var_57_0 = arg_55_0

			var_1.DisplaySystemUnlock(var_57_0, arg_55_1.dropData.abilitys, arg_57_0)

			return
		end
	}, arg_55_1.callback)

	return
end

function var_0_1.OnModifyName(arg_58_0)
	local var_58_0 = arg_58_0.levelPanel

	var_1.ExecuteAction(var_58_0, "UpdateIslandInfo")

	return
end

function var_0_1.OnGetProsperityAward(arg_59_0)
	local var_59_0 = arg_59_0.levelPanel

	var_1.ExecuteAction(var_59_0, "UpdateTip")

	return
end

function var_0_1.OnUnlockSystem(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.btnContainer

	var_2.OnUnlockSystem(var_60_0, arg_60_1)

	switch = var_2

	local var_60_1 = arg_60_1
	local var_60_2 = {}

	pg = var_1_10006
	var_60_2[var_1_10006.island_set.main_page_function_unlock.key_value_varchar[1]] = function()
		local var_61_0 = arg_60_0.levelPanel

		var_0.ExecuteAction(var_61_0, "Show")

		return
	end
	pg = var_6
	var_60_2[var_6.island_set.main_page_function_unlock.key_value_varchar[2]] = function()
		arg_60_0.unlockTask = true

		local var_62_0 = arg_60_0.taskTrackPanel

		var_0.ExecuteAction(var_62_0, "SetUnlock")

		local var_62_1 = arg_60_0

		var_0.UpdateTaskInfo(var_62_1)

		return
	end
	pg = var_6
	var_60_2[var_6.island_set.main_page_function_unlock.key_value_varchar[3]] = function()
		setActive = var_2_10000

		var_2_10000(arg_60_0.visitorBtn, true)

		local var_63_0 = arg_60_0

		var_0.UpdateVisitorBtn(var_63_0)

		return
	end

	var_2(var_60_1, var_60_2, function()
		return
	end)

	return
end

function var_0_1.OnVisitorNumChange(arg_65_0)
	arg_65_0:UpdateVisitorBtn()

	return
end

function var_0_1.OnSceneLoaded(arg_66_0)
	arg_66_0:HandleAwardDisplay({})
	var_0_1.super.OnSceneLoaded(arg_66_0)

	local var_66_0 = arg_66_0:GetIsland()
	local var_66_1 = var_1.GetAblityAgency(var_66_0)
	local var_66_2 = var_1.HasAbility

	pg = var_1_10005

	if var_66_2(var_66_1, var_1_10005.island_set.main_page_function_unlock.key_value_varchar[1]) then
		local var_66_3 = arg_66_0.levelPanel

		var_3.ExecuteAction(var_66_3, "Show")
	end

	local var_66_4 = var_1
	local var_66_5 = var_1.HasAbility

	pg = var_1_10006
	arg_66_0.unlockTask = var_66_5(var_66_4, var_1_10006.island_set.main_page_function_unlock.key_value_varchar[2])

	if arg_66_0.unlockTask then
		arg_66_0:UpdateTaskInfo()
	end

	local var_66_6 = var_1
	local var_66_7 = var_1.HasAbility

	pg = var_6

	local var_66_8 = var_66_7(var_66_6, var_6.island_set.main_page_function_unlock.key_value_varchar[3])

	setActive = var_66_1

	var_66_1(arg_66_0.visitorBtn, var_66_8)

	if var_66_8 then
		arg_66_0:UpdateVisitorBtn()
	end

	if arg_66_0.approachSpawnPointId then
		arg_66_0:OnApproachObject(arg_66_0.approachSpawnPointId)

		arg_66_0.approachSpawnPointId = nil
	end

	arg_66_0:SequenceCheck()

	return
end

function var_0_1.SequenceCheck(arg_67_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_68_0)
			pg = var_2_10001

			local var_68_0 = var_2_10001.NewStoryMgr.GetInstance()

			if var_1.IsPlayed(var_68_0, "ISLAND1001001_1") then
				arg_68_0()
			else
				local var_68_1 = arg_67_0

				var_1.PlayPerformance(var_68_1, {
					name = "ISLANDPERFORMANCE1",
					callback = arg_68_0
				})
			end

			return
		end,
		function(arg_69_0)
			local var_69_0 = arg_67_0

			var_1.SeasonResetCheck(var_69_0, arg_69_0)

			return
		end,
		function(arg_70_0)
			local var_70_0 = arg_67_0
			local var_70_1 = var_1.GetIsland(var_70_0)
			local var_70_2 = var_1.GetSeasonAgency(var_70_1)
			local var_70_3, var_70_4, var_70_5 = var_1.IsShowResetTip(var_70_2)

			if var_70_3 then
				if 0 < var_70_4 then
					i18n = var_70_6

					local var_70_6

					if not var_70_6("island_season_window_end2", var_70_4) then
						i18n = var_70_6
						var_70_6 = var_70_6("island_season_window_end")
					end

					local var_70_7 = arg_67_0
					local var_70_8 = var_5.ShowMsgbox
					local var_70_9 = {
						hideNo = true
					}

					IslandMsgBox = var_2_10009
					var_70_9.type = var_2_10009.TYPE_SEASON_TIP
					var_70_9.tipTitle = var_70_6
					i18n = var_9
					var_70_9.content = var_9("island_season_window_rule")

					function var_70_9.onHide()
						local var_71_0 = arg_67_0
						local var_71_1 = var_0.GetIsland(var_71_0)
						local var_71_2 = var_0.GetSeasonAgency(var_71_1)

						var_0.SetResetTipFlag(var_71_2, var_70_4)
						arg_70_0()

						return
					end

					var_70_8(var_70_7, var_70_9)

					if false then
						arg_70_0()
					end

					return
				end
			end
		end,
		function(arg_72_0)
			local var_72_0 = arg_67_0
			local var_72_1 = var_1.GetIsland(var_72_0)
			local var_72_2 = var_1.GetTicketAgency(var_72_1)

			if #var_1.GetExpiredTickets(var_72_2) > 0 then
				local var_72_3 = arg_67_0
				local var_72_4 = var_2.emit

				IslandMediator = var_2_10005

				var_72_4(var_72_3, var_2_10005.REMOVE_EXPIRED_TICKETS, var_1, arg_72_0)
			else
				arg_72_0()
			end

			return
		end,
		function(arg_73_0)
			local var_73_0 = arg_67_0
			local var_73_1 = var_1.GetIsland(var_73_0)
			local var_73_2 = var_1.GetTicketAgency(var_73_1)

			if #var_1.GetExpireRemindTickets(var_73_2) > 0 then
				local var_73_3 = arg_67_0
				local var_73_4 = var_2.ShowMsgbox
				local var_73_5 = {
					hideNo = true
				}

				IslandMsgBox = var_2_10006
				var_73_5.type = var_2_10006.TYPE_TICKET_EXPIRED

				local var_73_6 = {}

				IslandTicketExpiredMsgBoxWindow = var_2_10007
				var_73_6.type = var_2_10007.TYPES.REMIND
				var_73_6.tickets = var_1
				var_73_5.body = var_73_6

				function var_73_5.onHide()
					local var_74_0 = arg_67_0
					local var_74_1 = var_0.GetIsland(var_74_0)
					local var_74_2 = var_0.GetTicketAgency(var_74_1)

					var_0.SetRemindFlag(var_74_2)
					arg_73_0()

					return
				end

				var_73_4(var_73_3, var_73_5)
			else
				arg_73_0()
			end

			return
		end,
		function(arg_75_0)
			local var_75_0 = arg_67_0
			local var_75_1 = var_1.GetIsland(var_75_0)
			local var_75_2 = var_1.GetTaskAgency(var_75_1)

			var_1.TrySubmitAutoTasks(var_75_2, arg_75_0)

			return
		end,
		function(arg_76_0)
			local var_76_0 = arg_67_0
			local var_76_1 = var_1.GetIsland(var_76_0)
			local var_76_2 = var_1.GetTaskAgency(var_76_1)

			var_1.TryAcceptAutoTasks(var_76_2, arg_76_0)

			return
		end
	}, function()
		IslandGuideChecker = var_2_10000

		local var_77_0 = var_2_10000.CheckOnLoaded
		local var_77_1 = arg_67_0
		local var_77_2 = var_2.GetIsland(var_77_1)

		var_77_0(var_2.GetMapId(var_77_2))

		return
	end)

	return
end

function var_0_1.SeasonResetCheck(arg_78_0, arg_78_1)
	IslandSeasonAgency = var_1_10002

	local var_78_0, var_78_1 = var_1_10002.CheckReset()

	if var_78_0 then
		seriesAsync = var_1_10004

		var_1_10004({
			function(arg_79_0)
				local var_79_0 = arg_78_0
				local var_79_1 = var_1.ShowMsgbox
				local var_79_2 = {
					hideNo = true
				}

				IslandMsgBox = var_2_10005
				var_79_2.type = var_2_10005.TYPE_COMMON
				i18n = var_5
				var_79_2.content = var_5("island_season_reset")
				var_79_2.onHide = arg_79_0

				var_79_1(var_79_0, var_79_2)

				return
			end
		}, function()
			local var_80_0 = arg_78_0
			local var_80_1 = var_0.ShowMsgbox
			local var_80_2 = {}

			IslandMsgBox = var_2_10004
			var_80_2.type = var_2_10004.TYPE_SEASON_RESET
			var_80_2.body = var_78_1
			var_80_2.onHide = arg_78_1

			var_80_1(var_80_0, var_80_2)

			return
		end)
	else
		arg_78_1()
	end

	return
end

function var_0_1.UpdateVisitorBtn(arg_81_0)
	setText = var_1_10001

	local var_81_0 = arg_81_0.visitorBtn
	local var_81_1 = var_3.Find(var_81_0, "num")
	local var_81_2 = arg_81_0:GetIsland()
	local var_81_3 = var_4.GetVisitorAgency(var_81_2)

	var_1_10001(var_81_1, var_4.GetVisitorCnt(var_81_3))

	setText = var_1_10001

	local var_81_4 = arg_81_0.visitorBtn
	local var_81_5 = var_3.Find(var_81_4, "Text")

	i18n = var_4

	var_1_10001(var_81_5, var_4("island_visitor_button"))

	return
end

function var_0_1.UpdateMainAwardReward(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_0.awardDisplayPanel

	var_2.ExecuteAction(var_82_0, "ShowAwards", arg_82_1)

	return
end

function var_0_1.OnUnloadScene(arg_83_0)
	return
end

function var_0_1.OnVisible(arg_84_0)
	arg_84_0:UpdateTaskInfo()

	local var_84_0 = arg_84_0.btnContainer

	var_1.Flush(var_84_0)

	local var_84_1 = arg_84_0
	local var_84_2 = arg_84_0.GetSubView

	IslandStoryMgr = var_1_10004

	local var_84_3 = var_84_2(var_84_1, var_1_10004)

	if not var_1.IsRunning(var_84_3) then
		local var_84_4 = arg_84_0.poppingQueue

		if not var_1.AnyPlayerIsRunning(var_84_4) then
			IslandGuideChecker = var_1

			local var_84_5 = var_1.CheckOnLoaded
			local var_84_6 = arg_84_0:GetIsland()

			var_84_5(var_3.GetMapId(var_84_6))
		end
	end

	return
end

function var_0_1.willExit(arg_85_0)
	if arg_85_0.btnContainer then
		local var_85_0 = arg_85_0.btnContainer

		var_1.Dispose(var_85_0)

		arg_85_0.btnContainer = nil
	end

	if arg_85_0.levelPanel then
		local var_85_1 = arg_85_0.levelPanel

		var_1.Destroy(var_85_1)

		arg_85_0.levelPanel = nil
	end

	if arg_85_0.taskTrackPanel then
		local var_85_2 = arg_85_0.taskTrackPanel

		var_1.Destroy(var_85_2)

		arg_85_0.taskTrackPanel = nil
	end

	if arg_85_0.awardDisplayPanel then
		local var_85_3 = arg_85_0.awardDisplayPanel

		var_1.Destroy(var_85_3)

		arg_85_0.awardDisplayPanel = nil
	end

	return
end

function var_0_1.onBackPressed(arg_86_0)
	local var_86_0 = arg_86_0.sceneMgr
	local var_86_1 = var_1.GetPage

	IslandCheaterTavernMainPage = var_1_10004

	if var_86_1(var_86_0, var_1_10004) then
		pg = var_1

		local var_86_2 = var_1.m02
		local var_86_3 = var_1.sendNotification

		IslandProxy = var_1_10004

		var_86_3(var_86_2, var_1_10004.PRESS_BACK)

		return
	end

	var_0_1.super.onBackPressed(arg_86_0)

	return
end

return var_0_1
