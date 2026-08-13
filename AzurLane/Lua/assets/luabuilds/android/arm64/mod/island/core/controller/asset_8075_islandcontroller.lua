class = var_0_10000

local var_0_0 = "IslandController"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseController"))

function var_0_1.Init(arg_1_0)
	IslandDataConvertor = var_1_10001
	arg_1_0.sceneData = var_1_10001.Island2SceneData(arg_1_0.island)
	arg_1_0.mapId = arg_1_0.sceneData.mapId

	return
end

function var_0_1.SystemCtor(arg_2_0)
	IslandStrollAllocator = var_1_10001
	arg_2_0.strollAllocator = var_1_10001.New(arg_2_0)
	IslandVisibilityAllocator = var_1
	arg_2_0.visibilityAllocator = var_1.New(arg_2_0)
	IslandGiftAllocator = var_1
	arg_2_0.giftAllocator = var_1.New(arg_2_0)
	IslandActivityNpcAllocator = var_1
	arg_2_0.activityNpcAllocator = var_1.New(arg_2_0)
	IslandDelayCreationSystem = var_1
	arg_2_0.timeDelayCreate = var_1.New(arg_2_0)
	PlayerInputManager = var_1
	arg_2_0.playerInputManager = var_1.New(arg_2_0)
	IslandSyncMgr = var_1
	arg_2_0.islandSyncMgr = var_1.New(arg_2_0)

	return
end

function var_0_1.SetUp(arg_3_0)
	arg_3_0:SystemCtor()

	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.sceneData.unitList) do
		local var_3_0 = arg_3_0.visibilityAllocator

		if var_6.IsVisible(var_3_0, iter_3_1.id) then
			local var_3_1 = arg_3_0
			local var_3_2 = arg_3_0.NotifiyCore

			ISLAND_EVT = var_1_10009

			var_3_2(var_3_1, var_1_10009.GEN_UNIT, iter_3_1)
		end
	end

	ipairs = var_1

	for iter_3_2, iter_3_3 in var_1(arg_3_0.sceneData.activityUnits) do
		local var_3_3 = arg_3_0.activityNpcAllocator

		if var_6.IsVisible(var_3_3, iter_3_3.id) then
			local var_3_4 = arg_3_0
			local var_3_5 = arg_3_0.NotifiyCore

			ISLAND_EVT = var_1_10009

			var_3_5(var_3_4, var_1_10009.GEN_UNIT, iter_3_3)
		end
	end

	ipairs = var_1

	for iter_3_4, iter_3_5 in var_1(arg_3_0.sceneData.giftUnits) do
		local var_3_6 = arg_3_0.giftAllocator

		if var_6.IsVisible(var_3_6, iter_3_4) then
			local var_3_7 = arg_3_0
			local var_3_8 = arg_3_0.NotifiyCore

			ISLAND_EVT = var_1_10009

			var_3_8(var_3_7, var_1_10009.GEN_UNIT, iter_3_5)
		end
	end

	ipairs = var_1

	for iter_3_6, iter_3_7 in var_1(arg_3_0.sceneData.systemList) do
		local var_3_9 = arg_3_0
		local var_3_10 = arg_3_0.NotifiyCore

		ISLAND_EVT = var_1_10009

		var_3_10(var_3_9, var_1_10009.GEN_SYSTEM, iter_3_7)
	end

	ipairs = var_1

	for iter_3_8, iter_3_9 in var_1(arg_3_0.sceneData.systemUnits) do
		local var_3_11 = arg_3_0
		local var_3_12 = arg_3_0.NotifiyCore

		ISLAND_EVT = var_1_10009

		var_3_12(var_3_11, var_1_10009.GEN_UNIT, iter_3_9)
	end

	ipairs = var_1

	for iter_3_10, iter_3_11 in var_1(arg_3_0.sceneData.strollUnits) do
		local var_3_13 = arg_3_0.strollAllocator
		local var_3_14, var_3_15 = var_6.Allocator(var_3_13, iter_3_11:GetDefaultPathId(arg_3_0.mapId))

		iter_3_11:SetPath(var_3_14, var_3_15)

		local var_3_16 = arg_3_0
		local var_3_17 = arg_3_0.NotifiyCore

		ISLAND_EVT = var_11

		var_3_17(var_3_16, var_11.GEN_UNIT, iter_3_11)
	end

	ipairs = var_1

	for iter_3_12, iter_3_13 in var_1(arg_3_0.sceneData.followUnits) do
		local var_3_18 = arg_3_0
		local var_3_19 = arg_3_0.NotifiyCore

		ISLAND_EVT = var_1_10009

		var_3_19(var_3_18, var_1_10009.GEN_UNIT, iter_3_13)
	end

	local var_3_20 = arg_3_0.timeDelayCreate

	var_1.InitUnit(var_3_20)

	return
end

function var_0_1.ResetPlayerPosition(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.sceneData.unitList) do
		if iter_4_1:IsPlayer() then
			local var_4_0 = arg_4_0
			local var_4_1 = arg_4_0.NotifiyCore

			ISLAND_EVT = var_1_10010
			var_1_10010 = var_1_10010.RESET_UNIT_POS

			local var_4_2 = iter_4_1.id

			IslandConst = var_1_10012

			var_4_1(var_4_0, var_1_10010, var_4_2, var_1_10012.UNIT_LIST_PLAYER, iter_4_1.position)
		end
	end

	return
end

function var_0_1.OnCoreInitFinish(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.NotifiyCore

	ISLAND_EVT = var_1_10004

	var_5_1(var_5_0, var_1_10004.INIT_FINISH, arg_5_0.sceneData.camreaZoomData)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.NotifiyIsland

	ISLAND_EX_EVT = var_4

	var_5_3(var_5_2, var_4.INIT_FINISH)

	local var_5_4 = arg_5_0.playerInputManager

	var_1.Init(var_5_4)
	arg_5_0:InitStrollUnitsAwards()
	arg_5_0:InitSyncMgr()
	arg_5_0:InitVisitor()

	return
end

function var_0_1.InitVisitor(arg_6_0)
	local var_6_0 = arg_6_0.island
	local var_6_1 = var_1.GetVisitorAgency(var_6_0)
	local var_6_2 = var_1.GetMapVisitorList(var_6_1)

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(var_6_2) do
		if not iter_6_1:IsSelf() then
			arg_6_0:OnPlayerAdd({
				player = iter_6_1
			})
		else
			local var_6_3 = arg_6_0.islandSyncMgr

			var_7.OnVisitorEnter(var_6_3, iter_6_1.id, nil)
		end
	end

	return
end

function var_0_1.InitStrollUnitsAwards(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.sceneData.strollUnits) do
		if iter_7_1:ExistGreetingActionFeedback() then
			local var_7_0 = arg_7_0
			local var_7_1 = arg_7_0.NotifiyCore

			ISLAND_EVT = var_1_10009

			var_7_1(var_7_0, var_1_10009.SHOW_NPC_ANIMATION_BUBBLE, iter_7_1)
		end
	end

	return
end

function var_0_1.GetMapID(arg_8_0)
	return arg_8_0.mapId
end

function var_0_1.AddListeners(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.AddIslandListener

	IslandVisitorAgency = var_1_10004

	var_9_1(var_9_0, var_1_10004.VISITOR_ADD, arg_9_0.OnPlayerAdd)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.AddIslandListener

	IslandVisitorAgency = var_4

	var_9_3(var_9_2, var_4.VISITOR_EXIT, arg_9_0.OnPlayerExit)

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.AddIslandListener

	IslandDressUpAgency = var_4

	var_9_5(var_9_4, var_4.MORPH_PLAYER_DRESS, arg_9_0.OnPlayerMorphDress)

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.AddIslandListener

	IslandDressUpAgency = var_4

	var_9_7(var_9_6, var_4.CHANGE_PLAYER_DRESS, arg_9_0.OnPlayerChangeDress)

	local var_9_8 = arg_9_0
	local var_9_9 = arg_9_0.AddIslandListener

	IslandCharacterAgency = var_4

	var_9_9(var_9_8, var_4.CHANGE_CHARACTER_DRESS, arg_9_0.OnShipChangeDress)

	local var_9_10 = arg_9_0
	local var_9_11 = arg_9_0.AddIslandListener

	IslandCharacterAgency = var_4

	var_9_11(var_9_10, var_4.SHIP_SKILL_STATE_CHANGE, arg_9_0.OnShipSkillStateChange)

	local var_9_12 = arg_9_0
	local var_9_13 = arg_9_0.AddIslandListener

	IslandSyncMgr = var_4

	var_9_13(var_9_12, var_4.ISLAND_SYNC_DATA_UPDATE, arg_9_0.OnSyncDataUpdate)

	local var_9_14 = arg_9_0
	local var_9_15 = arg_9_0.AddIslandListener

	IslandSyncMgr = var_4

	var_9_15(var_9_14, var_4.ISLAND_SYNC_OBJ_UPDATE, arg_9_0.OnSyncObjUpdate)

	local var_9_16 = arg_9_0
	local var_9_17 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_17(var_9_16, var_4.COLLECT_SlOT_UNIT_INIT, arg_9_0.OnCollectSlotUnitInit)

	local var_9_18 = arg_9_0
	local var_9_19 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_19(var_9_18, var_4.COLLECT_SlOT_UNIT_UPDATE, arg_9_0.OnCollectSlotUnitUpdate)

	local var_9_20 = arg_9_0
	local var_9_21 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_21(var_9_20, var_4.COLLECT_SLOT_UNIT_REMOVE, arg_9_0.OnCollectSloSlotUnitRemove)

	local var_9_22 = arg_9_0
	local var_9_23 = arg_9_0.AddIslandListener

	IslandStartDelegationCommand = var_4

	var_9_23(var_9_22, var_4.START_DELEGATION, arg_9_0.OnStartDelegation)

	local var_9_24 = arg_9_0
	local var_9_25 = arg_9_0.AddIslandListener

	IslandFinishDelegationCommand = var_4

	var_9_25(var_9_24, var_4.END_DELEGATION, arg_9_0.OnEndDelegation)

	local var_9_26 = arg_9_0
	local var_9_27 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_27(var_9_26, var_4.SLOT_RESET_DELEGATION_STATE_DONE, arg_9_0.OnGetAllDelegationAward)

	local var_9_28 = arg_9_0
	local var_9_29 = arg_9_0.AddIslandListener

	IslandTaskAgency = var_4

	var_9_29(var_9_28, var_4.TASK_ADDED, arg_9_0.OnTaskAdd)

	local var_9_30 = arg_9_0
	local var_9_31 = arg_9_0.AddIslandListener

	IslandTaskAgency = var_4

	var_9_31(var_9_30, var_4.TASK_FINISH, arg_9_0.OnFinishTask)

	local var_9_32 = arg_9_0
	local var_9_33 = arg_9_0.AddIslandListener

	IslandTaskAgency = var_4

	var_9_33(var_9_32, var_4.TASK_UPDATED, arg_9_0.OnUpdateTask)

	local var_9_34 = arg_9_0
	local var_9_35 = arg_9_0.AddIslandListener

	IslandSlotHandPlantCommand = var_4

	var_9_35(var_9_34, var_4.START_HANDPLANT_DONE, arg_9_0.OnStartPlant)

	local var_9_36 = arg_9_0
	local var_9_37 = arg_9_0.AddIslandListener

	IslandSlotHandPlantAwardCommand = var_4

	var_9_37(var_9_36, var_4.START_HANDPLANT_AWARD_DONE, arg_9_0.OnEndPlant)

	local var_9_38 = arg_9_0
	local var_9_39 = arg_9_0.AddIslandListener

	IslandSlotCollectCommand = var_4

	var_9_39(var_9_38, var_4.START_HAND_COLLECT_DONE, arg_9_0.OnStartHandCollect)

	local var_9_40 = arg_9_0
	local var_9_41 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_41(var_9_40, var_4.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, arg_9_0.OnHandPlantSlotChangeUnit)

	local var_9_42 = arg_9_0
	local var_9_43 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_43(var_9_42, var_4.CHANGE_PRODUCT_MODEL, arg_9_0.OnProductPlaceChangeUnit)

	local var_9_44 = arg_9_0
	local var_9_45 = arg_9_0.AddIslandListener

	IslandGatherCollectAgency = var_4

	var_9_45(var_9_44, var_4.RemoveGatherUnit, arg_9_0.OnRemoveWildGatherDone)

	local var_9_46 = arg_9_0
	local var_9_47 = arg_9_0.AddIslandListener

	IslandGatherCollectAgency = var_4

	var_9_47(var_9_46, var_4.AddGatherUnit, arg_9_0.OnAddWildGatherDone)

	local var_9_48 = arg_9_0
	local var_9_49 = arg_9_0.AddIslandListener

	ISLAND_EVT = var_4

	var_9_49(var_9_48, var_4.CHANGE_SLOT_MODEL, arg_9_0.OnChangeSlotModel)

	local var_9_50 = arg_9_0
	local var_9_51 = arg_9_0.AddIslandListener

	IslandOpenRestaurantCommand = var_4

	var_9_51(var_9_50, var_4.OPEN_RESTAURANT, arg_9_0.OnOpenRestaurant)

	local var_9_52 = arg_9_0
	local var_9_53 = arg_9_0.AddIslandListener

	IslandCloseRestaurantCommand = var_4

	var_9_53(var_9_52, var_4.CLOSE_RESTAURANT, arg_9_0.OnCloseRestaurant)

	local var_9_54 = arg_9_0
	local var_9_55 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_55(var_9_54, var_4.STORY_START, arg_9_0.OnStartStory)

	local var_9_56 = arg_9_0
	local var_9_57 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_57(var_9_56, var_4.STORY_END, arg_9_0.OnEndStory)

	local var_9_58 = arg_9_0
	local var_9_59 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_59(var_9_58, var_4.PERFORMANCE_START, arg_9_0.OnStartPerformance)

	local var_9_60 = arg_9_0
	local var_9_61 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_61(var_9_60, var_4.PERFORMANCE_END, arg_9_0.OnEndPerformance)

	local var_9_62 = arg_9_0
	local var_9_63 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_63(var_9_62, var_4.START_PATHFINDER, arg_9_0.OnStartPathFinder)

	local var_9_64 = arg_9_0
	local var_9_65 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_65(var_9_64, var_4.END_PATHFINDER, arg_9_0.OnEndPathFinder)

	local var_9_66 = arg_9_0
	local var_9_67 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_67(var_9_66, var_4.ACTIVE_OR_DISABLE_UNIT, arg_9_0.OnActiveOrDisableUnit)

	local var_9_68 = arg_9_0
	local var_9_69 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_69(var_9_68, var_4.LINK_CORE, arg_9_0.OnLinkCore)

	local var_9_70 = arg_9_0
	local var_9_71 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_71(var_9_70, var_4.GEN_ANIMAL_INT, arg_9_0.OnAnimalInit)

	local var_9_72 = arg_9_0
	local var_9_73 = arg_9_0.AddIslandListener

	IslandBuildingAgency = var_4

	var_9_73(var_9_72, var_4.SLOT_DELEGATE_INIT, arg_9_0.OnSlotDelegateInit)

	local var_9_74 = arg_9_0
	local var_9_75 = arg_9_0.AddIslandListener

	IslandNpcFeedbackAgency = var_4

	var_9_75(var_9_74, var_4.NPC_ACTION_CHANGE, arg_9_0.OnNpcActionFeedBackChange)

	local var_9_76 = arg_9_0
	local var_9_77 = arg_9_0.AddIslandListener

	IslandNpcFeedbackAgency = var_4

	var_9_77(var_9_76, var_4.RESET_NPC_ACTIONS, arg_9_0.OnResetNpcActionFeedback)

	local var_9_78 = arg_9_0
	local var_9_79 = arg_9_0.AddIslandListener

	IslandFollowerAgency = var_4

	var_9_79(var_9_78, var_4.ADD_FOLLOWER, arg_9_0.OnAddFollower)

	local var_9_80 = arg_9_0
	local var_9_81 = arg_9_0.AddIslandListener

	IslandFollowerAgency = var_4

	var_9_81(var_9_80, var_4.DEL_FOLLOWER, arg_9_0.OnDelFollower)

	local var_9_82 = arg_9_0
	local var_9_83 = arg_9_0.AddIslandListener

	ActivityProxy = var_4

	var_9_83(var_9_82, var_4.ACTIVITY_UPDATED, arg_9_0.OnActivityUpdate)

	local var_9_84 = arg_9_0
	local var_9_85 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_85(var_9_84, var_4.GEN_RECYCLEITEM, arg_9_0.OnGenRecycleItem)

	local var_9_86 = arg_9_0
	local var_9_87 = arg_9_0.AddIslandListener

	IslandActivityNpcAgency = var_4

	var_9_87(var_9_86, var_4.ACTIVITY_NPC_ADD, arg_9_0.OnActivityNpcAdd)

	local var_9_88 = arg_9_0
	local var_9_89 = arg_9_0.AddIslandListener

	IslandActivityNpcAgency = var_4

	var_9_89(var_9_88, var_4.ACTIVITY_NPC_UPDATE, arg_9_0.OnActivityNpcUpdate)

	local var_9_90 = arg_9_0
	local var_9_91 = arg_9_0.AddIslandListener

	IslandActivityNpcAgency = var_4

	var_9_91(var_9_90, var_4.ACTIVITY_NPC_DEL, arg_9_0.OnActivityNpcDel)

	local var_9_92 = arg_9_0
	local var_9_93 = arg_9_0.AddIslandListener

	IslandAblityAgency = var_4

	var_9_93(var_9_92, var_4.UNLOCK_SYSTEM, arg_9_0.OnSystemUnlock)

	local var_9_94 = arg_9_0
	local var_9_95 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_95(var_9_94, var_4.LOCK_NPC_REFRESH, arg_9_0.OnLockNpcRefresh)

	local var_9_96 = arg_9_0
	local var_9_97 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_97(var_9_96, var_4.RELEASE_NPC_REFRESH, arg_9_0.OnReleaseNpcRefresh)

	local var_9_98 = arg_9_0
	local var_9_99 = arg_9_0.AddIslandListener

	IslandProxy = var_4

	var_9_99(var_9_98, var_4.RESET_SP, arg_9_0.OnResetSp)

	local var_9_100 = arg_9_0
	local var_9_101 = arg_9_0.AddIslandListener

	IslandFishingAgency = var_4

	var_9_101(var_9_100, var_4.BAIT_UPDATE, arg_9_0.OnBaitUpdate)

	local var_9_102 = arg_9_0
	local var_9_103 = arg_9_0.AddIslandListener

	ISLAND_EVT = var_4

	var_9_103(var_9_102, var_4.SWITCH_MAP, arg_9_0.OnSwitchMap)

	return
end

function var_0_1.RemoveListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.RemoveIslandListener

	IslandVisitorAgency = var_1_10004

	var_10_1(var_10_0, var_1_10004.VISITOR_ADD, arg_10_0.OnPlayerAdd)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.RemoveIslandListener

	IslandVisitorAgency = var_4

	var_10_3(var_10_2, var_4.VISITOR_EXIT, arg_10_0.OnPlayerExit)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.RemoveIslandListener

	IslandDressUpAgency = var_4

	var_10_5(var_10_4, var_4.MORPH_PLAYER_DRESS, arg_10_0.OnPlayerMorphDress)

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.RemoveIslandListener

	IslandDressUpAgency = var_4

	var_10_7(var_10_6, var_4.CHANGE_PLAYER_DRESS, arg_10_0.OnPlayerChangeDress)

	local var_10_8 = arg_10_0
	local var_10_9 = arg_10_0.RemoveIslandListener

	IslandCharacterAgency = var_4

	var_10_9(var_10_8, var_4.CHANGE_CHARACTER_DRESS, arg_10_0.OnShipChangeDress)

	local var_10_10 = arg_10_0
	local var_10_11 = arg_10_0.RemoveIslandListener

	IslandCharacterAgency = var_4

	var_10_11(var_10_10, var_4.SHIP_SKILL_STATE_CHANGE, arg_10_0.OnShipSkillStateChange)

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.RemoveIslandListener

	IslandSyncMgr = var_4

	var_10_13(var_10_12, var_4.ISLAND_SYNC_DATA_UPDATE, arg_10_0.OnSyncDataUpdate)

	local var_10_14 = arg_10_0
	local var_10_15 = arg_10_0.RemoveIslandListener

	IslandSyncMgr = var_4

	var_10_15(var_10_14, var_4.ISLAND_SYNC_OBJ_UPDATE, arg_10_0.OnSyncObjUpdate)

	local var_10_16 = arg_10_0
	local var_10_17 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_17(var_10_16, var_4.COLLECT_SlOT_UNIT_INIT, arg_10_0.OnCollectSlotUnitInit)

	local var_10_18 = arg_10_0
	local var_10_19 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_19(var_10_18, var_4.COLLECT_SlOT_UNIT_UPDATE, arg_10_0.OnCollectSlotUnitUpdate)

	local var_10_20 = arg_10_0
	local var_10_21 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_21(var_10_20, var_4.COLLECT_SLOT_UNIT_REMOVE, arg_10_0.OnCollectSloSlotUnitRemove)

	local var_10_22 = arg_10_0
	local var_10_23 = arg_10_0.RemoveIslandListener

	IslandStartDelegationCommand = var_4

	var_10_23(var_10_22, var_4.START_DELEGATION, arg_10_0.OnStartDelegation)

	local var_10_24 = arg_10_0
	local var_10_25 = arg_10_0.RemoveIslandListener

	IslandFinishDelegationCommand = var_4

	var_10_25(var_10_24, var_4.END_DELEGATION, arg_10_0.OnEndDelegation)

	local var_10_26 = arg_10_0
	local var_10_27 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_27(var_10_26, var_4.SLOT_RESET_DELEGATION_STATE_DONE, arg_10_0.OnGetAllDelegationAward)

	local var_10_28 = arg_10_0
	local var_10_29 = arg_10_0.RemoveIslandListener

	IslandTaskAgency = var_4

	var_10_29(var_10_28, var_4.TASK_ADDED, arg_10_0.OnTaskAdd)

	local var_10_30 = arg_10_0
	local var_10_31 = arg_10_0.RemoveIslandListener

	IslandTaskAgency = var_4

	var_10_31(var_10_30, var_4.TASK_FINISH, arg_10_0.OnFinishTask)

	local var_10_32 = arg_10_0
	local var_10_33 = arg_10_0.RemoveIslandListener

	IslandTaskAgency = var_4

	var_10_33(var_10_32, var_4.TASK_UPDATED, arg_10_0.OnUpdateTask)

	local var_10_34 = arg_10_0
	local var_10_35 = arg_10_0.RemoveIslandListener

	IslandSlotHandPlantCommand = var_4

	var_10_35(var_10_34, var_4.START_HANDPLANT_DONE, arg_10_0.OnStartPlant)

	local var_10_36 = arg_10_0
	local var_10_37 = arg_10_0.RemoveIslandListener

	IslandSlotHandPlantAwardCommand = var_4

	var_10_37(var_10_36, var_4.START_HANDPLANT_AWARD_DONE, arg_10_0.OnEndPlant)

	local var_10_38 = arg_10_0
	local var_10_39 = arg_10_0.RemoveIslandListener

	IslandSlotCollectCommand = var_4

	var_10_39(var_10_38, var_4.START_HAND_COLLECT_DONE, arg_10_0.OnStartHandCollect)

	local var_10_40 = arg_10_0
	local var_10_41 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_41(var_10_40, var_4.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, arg_10_0.OnHandPlantSlotChangeUnit)

	local var_10_42 = arg_10_0
	local var_10_43 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_43(var_10_42, var_4.CHANGE_PRODUCT_MODEL, arg_10_0.OnProductPlaceChangeUnit)

	local var_10_44 = arg_10_0
	local var_10_45 = arg_10_0.RemoveIslandListener

	IslandGatherCollectAgency = var_4

	var_10_45(var_10_44, var_4.RemoveGatherUnit, arg_10_0.OnRemoveWildGatherDone)

	local var_10_46 = arg_10_0
	local var_10_47 = arg_10_0.RemoveIslandListener

	IslandGatherCollectAgency = var_4

	var_10_47(var_10_46, var_4.AddGatherUnit, arg_10_0.OnAddWildGatherDone)

	local var_10_48 = arg_10_0
	local var_10_49 = arg_10_0.RemoveIslandListener

	ISLAND_EVT = var_4

	var_10_49(var_10_48, var_4.CHANGE_SLOT_MODEL, arg_10_0.OnChangeSlotModel)

	local var_10_50 = arg_10_0
	local var_10_51 = arg_10_0.RemoveIslandListener

	IslandOpenRestaurantCommand = var_4

	var_10_51(var_10_50, var_4.OPEN_RESTAURANT, arg_10_0.OnOpenRestaurant)

	local var_10_52 = arg_10_0
	local var_10_53 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_53(var_10_52, var_4.STORY_START, arg_10_0.OnStartStory)

	local var_10_54 = arg_10_0
	local var_10_55 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_55(var_10_54, var_4.STORY_END, arg_10_0.OnEndStory)

	local var_10_56 = arg_10_0
	local var_10_57 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_57(var_10_56, var_4.PERFORMANCE_START, arg_10_0.OnStartPerformance)

	local var_10_58 = arg_10_0
	local var_10_59 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_59(var_10_58, var_4.PERFORMANCE_END, arg_10_0.OnEndPerformance)

	local var_10_60 = arg_10_0
	local var_10_61 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_61(var_10_60, var_4.START_PATHFINDER, arg_10_0.OnStartPathFinder)

	local var_10_62 = arg_10_0
	local var_10_63 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_63(var_10_62, var_4.END_PATHFINDER, arg_10_0.OnEndPathFinder)

	local var_10_64 = arg_10_0
	local var_10_65 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_65(var_10_64, var_4.ACTIVE_OR_DISABLE_UNIT, arg_10_0.OnActiveOrDisableUnit)

	local var_10_66 = arg_10_0
	local var_10_67 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_67(var_10_66, var_4.LINK_CORE, arg_10_0.OnLinkCore)

	local var_10_68 = arg_10_0
	local var_10_69 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_69(var_10_68, var_4.GEN_ANIMAL_INT, arg_10_0.OnAnimalInit)

	local var_10_70 = arg_10_0
	local var_10_71 = arg_10_0.RemoveIslandListener

	IslandBuildingAgency = var_4

	var_10_71(var_10_70, var_4.SLOT_DELEGATE_INIT, arg_10_0.OnSlotDelegateInit)

	local var_10_72 = arg_10_0
	local var_10_73 = arg_10_0.RemoveIslandListener

	IslandNpcFeedbackAgency = var_4

	var_10_73(var_10_72, var_4.NPC_ACTION_CHANGE, arg_10_0.OnNpcActionFeedBackChange)

	local var_10_74 = arg_10_0
	local var_10_75 = arg_10_0.RemoveIslandListener

	IslandNpcFeedbackAgency = var_4

	var_10_75(var_10_74, var_4.RESET_NPC_ACTIONS, arg_10_0.OnResetNpcActionFeedback)

	local var_10_76 = arg_10_0
	local var_10_77 = arg_10_0.RemoveIslandListener

	IslandFollowerAgency = var_4

	var_10_77(var_10_76, var_4.ADD_FOLLOWER, arg_10_0.OnAddFollower)

	local var_10_78 = arg_10_0
	local var_10_79 = arg_10_0.RemoveIslandListener

	IslandFollowerAgency = var_4

	var_10_79(var_10_78, var_4.DEL_FOLLOWER, arg_10_0.OnDelFollower)

	local var_10_80 = arg_10_0
	local var_10_81 = arg_10_0.RemoveIslandListener

	ActivityProxy = var_4

	var_10_81(var_10_80, var_4.ACTIVITY_UPDATED, arg_10_0.OnActivityUpdate)

	local var_10_82 = arg_10_0
	local var_10_83 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_83(var_10_82, var_4.GEN_RECYCLEITEM, arg_10_0.OnGenRecycleItem)

	local var_10_84 = arg_10_0
	local var_10_85 = arg_10_0.RemoveIslandListener

	IslandActivityNpcAgency = var_4

	var_10_85(var_10_84, var_4.ACTIVITY_NPC_ADD, arg_10_0.OnActivityNpcAdd)

	local var_10_86 = arg_10_0
	local var_10_87 = arg_10_0.RemoveIslandListener

	IslandActivityNpcAgency = var_4

	var_10_87(var_10_86, var_4.ACTIVITY_NPC_UPDATE, arg_10_0.OnActivityNpcUpdate)

	local var_10_88 = arg_10_0
	local var_10_89 = arg_10_0.RemoveIslandListener

	IslandActivityNpcAgency = var_4

	var_10_89(var_10_88, var_4.ACTIVITY_NPC_DEL, arg_10_0.OnActivityNpcDel)

	local var_10_90 = arg_10_0
	local var_10_91 = arg_10_0.RemoveIslandListener

	IslandAblityAgency = var_4

	var_10_91(var_10_90, var_4.UNLOCK_SYSTEM, arg_10_0.OnSystemUnlock)

	local var_10_92 = arg_10_0
	local var_10_93 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_93(var_10_92, var_4.LOCK_NPC_REFRESH, arg_10_0.OnLockNpcRefresh)

	local var_10_94 = arg_10_0
	local var_10_95 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_95(var_10_94, var_4.RELEASE_NPC_REFRESH, arg_10_0.OnReleaseNpcRefresh)

	local var_10_96 = arg_10_0
	local var_10_97 = arg_10_0.RemoveIslandListener

	IslandProxy = var_4

	var_10_97(var_10_96, var_4.RESET_SP, arg_10_0.OnResetSp)

	local var_10_98 = arg_10_0
	local var_10_99 = arg_10_0.RemoveIslandListener

	IslandFishingAgency = var_4

	var_10_99(var_10_98, var_4.BAIT_UPDATE, arg_10_0.OnBaitUpdate)

	local var_10_100 = arg_10_0
	local var_10_101 = arg_10_0.RemoveIslandListener

	ISLAND_EVT = var_4

	var_10_101(var_10_100, var_4.SWITCH_MAP, arg_10_0.OnSwitchMap)

	return
end

function var_0_1.OnBaitUpdate(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_11_1(var_11_0, var_1_10005.BAIT_UPDATE, arg_11_1)

	return
end

function var_0_1.OnResetSp(arg_12_0)
	local var_12_0 = arg_12_0.mapId

	pg = var_1_10002

	local var_12_1

	if not var_1_10002.island_world_objects.get_id_list_by_mapId[var_12_0] then
		var_12_1 = {}
	end

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(var_12_1) do
		pg = var_1_10008

		if var_1_10008.island_world_objects[iter_12_1].unitId == 0 then
			var_1_10008 = spConfig

			break
		end
	end

	spConfig = var_3

	if not var_3 then
		return
	end

	BuildVector3 = var_3
	spConfig = var_5

	local var_12_2 = var_3(var_5.param.position)

	BuildVector3 = var_4
	spConfig = iter_12_0

	local var_12_3 = var_4(iter_12_0.param.rotation)

	getProxy = var_5
	PlayerProxy = iter_12_1

	local var_12_4 = var_5(iter_12_1)
	local var_12_5 = var_5.getRawData(var_12_4).id
	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.NotifiyCore

	ISLAND_EVT = var_1_10009

	local var_12_8 = var_1_10009.RESET_UNIT_POS
	local var_12_9 = var_12_5

	IslandConst = var_1_10011

	var_12_7(var_12_6, var_12_8, var_12_9, var_1_10011.UNIT_LIST_PLAYER, var_12_2)

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0.NotifiyCore

	ISLAND_EVT = var_12_8

	local var_12_12 = var_12_8.RESET_UNIT_ROT
	local var_12_13 = var_12_5

	IslandConst = var_11

	var_12_11(var_12_10, var_12_12, var_12_13, var_11.UNIT_LIST_PLAYER, var_12_3)

	return
end

function var_0_1.OnLockNpcRefresh(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.visibilityAllocator

	var_3.LockNpc(var_13_0, arg_13_1, arg_13_2)

	return
end

function var_0_1.OnReleaseNpcRefresh(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.visibilityAllocator

	var_3.ReleaseNpc(var_14_0, arg_14_1, arg_14_2)

	return
end

function var_0_1.OnSystemUnlock(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_15_1(var_15_0, var_1_10005.SYSTEM_UNLOCK, arg_15_1)

	return
end

function var_0_1.OnActivityNpcAdd(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.activityNpcAllocator

	var_2.AddNpc(var_16_0, arg_16_1)

	local var_16_1 = arg_16_0.activityNpcAllocator

	var_2.Flush(var_16_1)

	return
end

function var_0_1.OnActivityNpcUpdate(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.activityNpcAllocator

	var_3.DelNpc(var_17_0, arg_17_1)

	local var_17_1 = arg_17_0.activityNpcAllocator

	var_3.AddNpc(var_17_1, arg_17_2)

	local var_17_2 = arg_17_0.activityNpcAllocator

	var_3.Flush(var_17_2)

	return
end

function var_0_1.OnActivityNpcDel(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.activityNpcAllocator

	var_2.DelNpc(var_18_0, arg_18_1)

	local var_18_1 = arg_18_0.activityNpcAllocator

	var_2.Flush(var_18_1)

	return
end

function var_0_1.OnActivityUpdate(arg_19_0)
	local var_19_0 = arg_19_0.activityNpcAllocator

	var_1.Flush(var_19_0)

	return
end

function var_0_1.OnGenRecycleItem(arg_20_0, arg_20_1)
	IslandDataConvertor = var_1_10002

	local var_20_0 = var_1_10002.GenDelayRecycleIslandUnit(arg_20_1)
	local var_20_1 = arg_20_0
	local var_20_2 = arg_20_0.NotifiyCore

	ISLAND_EVT = var_1_10006

	var_20_2(var_20_1, var_1_10006.GEN_UNIT, var_20_0)

	return
end

function var_0_1.OnAddFollower(arg_21_0, arg_21_1)
	local var_21_0 = #arg_21_0.sceneData.followUnits > 0
	local var_21_1 = arg_21_0:GetIsland()
	local var_21_2 = var_3.GetCharacterAgency(var_21_1)
	local var_21_3 = var_3.GetShipById(var_21_2, arg_21_1)
	local var_21_4 = var_4.GetModelUnit(var_21_3)
	local var_21_5 = arg_21_0:GetView()
	local var_21_6 = var_6.GetPlayerLastGroundedPosition(var_21_5)

	IslandFollowerUnitVO = var_21_3

	local var_21_7 = var_21_3.New
	local var_21_8 = var_4.id
	local var_21_9 = arg_21_1
	local var_21_10 = var_21_4
	local var_21_11 = var_21_6

	Vector3 = var_1_10013

	local var_21_12 = var_21_7(var_21_8, var_21_9, var_21_10, var_21_11, var_1_10013(0, 0, 0), not var_21_0)

	table = var_21_5

	var_21_5.insert(arg_21_0.sceneData.followUnits, var_21_12)

	local var_21_13 = arg_21_0
	local var_21_14 = arg_21_0.NotifiyCore

	ISLAND_EVT = var_11

	var_21_14(var_21_13, var_11.GEN_UNIT, var_21_12)

	ipairs = var_21_14

	for iter_21_0, iter_21_1 in var_21_14(arg_21_0.sceneData.strollUnits) do
		if var_4:getConfig("unit_id") == iter_21_1.config.unit_id then
			local var_21_15 = arg_21_0
			local var_21_16 = arg_21_0.NotifiyCore

			ISLAND_EVT = var_16

			local var_21_17 = var_16.RMOVE_UNIT

			IslandConst = var_17

			var_21_16(var_21_15, var_21_17, var_17.UNIT_LIST_STROLL, iter_21_1.id)
		end
	end

	local var_21_18 = arg_21_0
	local var_21_19 = arg_21_0.NotifiyCore

	ISLAND_EVT = iter_21_0

	var_21_19(var_21_18, iter_21_0.ADD_FOLLOWER, var_21_12.id)

	return
end

function var_0_1.OnDelFollower(arg_22_0, arg_22_1)
	local var_22_0 = 0

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(arg_22_0.sceneData.followUnits) do
		if iter_22_1.id == arg_22_1 then
			var_22_0 = iter_22_0

			break
		end
	end

	if var_22_0 <= 0 then
		return
	end

	table = var_3

	local var_22_1 = var_3.remove(arg_22_0.sceneData.followUnits, var_22_0)
	local var_22_2 = arg_22_0
	local var_22_3 = arg_22_0.NotifiyCore

	ISLAND_EVT = iter_22_1

	local var_22_4 = iter_22_1.RMOVE_UNIT

	IslandConst = var_1_10008

	var_22_3(var_22_2, var_22_4, var_1_10008.UNIT_LIST_FOLLOW, var_22_1.id)

	if var_22_1:IsRandomizer() and #arg_22_0.sceneData.followUnits > 0 then
		local var_22_5 = arg_22_0.sceneData.followUnits[1]

		var_4.ActiveRandomizer(var_22_5)

		local var_22_6 = arg_22_0
		local var_22_7 = arg_22_0.NotifiyCore

		ISLAND_EVT = var_8

		var_22_7(var_22_6, var_8.RESET_FOLLOW_RANDOMIZER, var_4.id)
	end

	local var_22_8 = arg_22_0:GetIsland()
	local var_22_9 = var_4.GetCharacterAgency(var_22_8)
	local var_22_10 = var_4.GetShipById(var_22_9, arg_22_1)

	ipairs = var_22_8

	for iter_22_2, iter_22_3 in var_22_8(arg_22_0.sceneData.strollUnits) do
		if var_22_10:getConfig("unit_id") == iter_22_3.config.unit_id then
			local var_22_11 = arg_22_0
			local var_22_12 = arg_22_0.NotifiyCore

			ISLAND_EVT = var_14

			var_22_12(var_22_11, var_14.GEN_UNIT, iter_22_3)
		end
	end

	local var_22_13 = arg_22_0
	local var_22_14 = arg_22_0.NotifiyCore

	ISLAND_EVT = iter_22_2

	var_22_14(var_22_13, iter_22_2.DEL_FOLLOWER, var_22_1.id)

	return
end

function var_0_1.OnResetNpcActionFeedback(arg_23_0)
	ipairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0.sceneData.strollUnits) do
		if iter_23_1:ExistGreetingActionFeedback() then
			iter_23_1:ClearGreetingActionFeedback()

			local var_23_0 = arg_23_0
			local var_23_1 = arg_23_0.NotifiyCore

			ISLAND_EVT = var_1_10009

			var_23_1(var_23_0, var_1_10009.HIDE_NPC_ANIMATION_BUBBLE, iter_23_1)
		end
	end

	IslandDataConvertor = var_1

	var_1.DistributeAward4StrollUnits(arg_23_0.sceneData.strollUnits, arg_23_0:GetIsland())
	arg_23_0:InitStrollUnitsAwards()

	return
end

function var_0_1.OnNpcActionFeedBackChange(arg_24_0, arg_24_1)
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.sceneData.strollUnits) do
		if iter_24_1.id == arg_24_1 and iter_24_1:ExistActionFeedback() then
			iter_24_1:ClearActionFeedback()

			local var_24_0 = arg_24_0
			local var_24_1 = arg_24_0.NotifiyCore

			ISLAND_EVT = var_1_10010

			var_24_1(var_24_0, var_1_10010.HIDE_NPC_ANIMATION_BUBBLE, iter_24_1)
		end
	end

	return
end

function var_0_1.OnShipSkillStateChange(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0

	ipairs = var_1_10004

	for iter_25_0, iter_25_1 in var_1_10004(arg_25_0.sceneData.strollUnits) do
		if iter_25_1:IsSameShip(arg_25_1) then
			var_25_0 = iter_25_1

			break
		end
	end

	if var_25_0 then
		if not arg_25_2 then
			var_25_0:ClearSkillActionFeedback()

			local var_25_1 = arg_25_0
			local var_25_2 = arg_25_0.NotifiyCore

			ISLAND_EVT = iter_25_0

			var_25_2(var_25_1, iter_25_0.HIDE_NPC_ANIMATION_BUBBLE, var_25_0)
		else
			local var_25_3 = arg_25_0
			local var_25_4 = arg_25_0.GetIsland(var_25_3)

			IslandDataConvertor = var_5

			local var_25_5 = var_5.GetOwnActions(var_25_4)

			IslandDataConvertor = var_25_3

			var_25_3.DistributeShipSkillAward4StrollUnits(arg_25_0.sceneData.strollUnits, var_25_4, var_25_5)
			arg_25_0:InitStrollUnitsAwards()
		end
	end

	return
end

function var_0_1.OnLinkCore(arg_26_0, arg_26_1, ...)
	arg_26_0:NotifiyCore(arg_26_1, ...)

	return
end

function var_0_1.OnActiveOrDisableUnit(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.NotifiyCore

	ISLAND_EVT = var_1_10007

	var_27_1(var_27_0, var_1_10007.ACTIVE_OR_DISACTIVE_UNIT, arg_27_1, arg_27_2, arg_27_3)

	return
end

function var_0_1.OnStartPathFinder(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_28_1(var_28_0, var_1_10005.GEN_PATH_FINDER, arg_28_1)

	return
end

function var_0_1.OnEndPathFinder(arg_29_0)
	local var_29_0 = arg_29_0.visibilityAllocator

	var_1.Flush(var_29_0)

	return
end

function var_0_1.OnStartPerformance(arg_30_0)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.NotifiyCore

	ISLAND_EVT = var_1_10004

	var_30_1(var_30_0, var_1_10004.START_STORY)

	local var_30_2 = arg_30_0
	local var_30_3 = arg_30_0.NotifiyCore

	ISLAND_EVT = var_4

	var_30_3(var_30_2, var_4.START_PERFORMANCE)

	return
end

function var_0_1.OnEndPerformance(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_31_1(var_31_0, var_1_10005.END_STORY)

	local var_31_2 = arg_31_0
	local var_31_3 = arg_31_0.NotifiyCore

	ISLAND_EVT = var_5

	var_31_3(var_31_2, var_5.END_PERFORMANCE)

	if arg_31_1 then
		arg_31_0:OnUpdateTask()
	end

	return
end

function var_0_1.OnStartStory(arg_32_0)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.NotifiyCore

	ISLAND_EVT = var_1_10004

	var_32_1(var_32_0, var_1_10004.START_STORY)

	return
end

function var_0_1.OnEndStory(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_33_1(var_33_0, var_1_10005.END_STORY)

	if arg_33_1 then
		local var_33_2 = arg_33_0.visibilityAllocator

		var_2.Flush(var_33_2)
	end

	return
end

function var_0_1.OnTaskAdd(arg_34_0)
	local var_34_0 = arg_34_0.visibilityAllocator

	var_1.Flush(var_34_0)

	local var_34_1 = arg_34_0
	local var_34_2 = arg_34_0.NotifiyCore

	ISLAND_EVT = var_1_10004

	var_34_2(var_34_1, var_1_10004.REFRESH_INTERACTION)

	local var_34_3 = arg_34_0
	local var_34_4 = arg_34_0.NotifiyCore

	ISLAND_EVT = var_4

	var_34_4(var_34_3, var_4.REFRESH_TASK_HUD_INFO)

	return
end

function var_0_1.OnFinishTask(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.visibilityAllocator

	var_2.Flush(var_35_0)

	local var_35_1 = arg_35_0
	local var_35_2 = arg_35_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_35_2(var_35_1, var_1_10005.REFRESH_INTERACTION)

	local var_35_3 = arg_35_0
	local var_35_4 = arg_35_0.NotifiyCore

	ISLAND_EVT = var_5

	var_35_4(var_35_3, var_5.REFRESH_TASK_HUD_INFO)

	local var_35_5 = arg_35_0
	local var_35_6 = arg_35_0.CheckFinishTask
	local var_35_7 = arg_35_1

	IslandTaskType = var_1_10006

	var_35_6(var_35_5, var_35_7, var_1_10006.DAILY, "daily_task_follow_action")

	local var_35_8 = arg_35_0
	local var_35_9 = arg_35_0.CheckFinishTask
	local var_35_10 = arg_35_1

	IslandTaskType = var_6

	var_35_9(var_35_8, var_35_10, var_6.WEEKLY, "weekly_task_follow_action")

	return
end

local function var_0_2(arg_36_0)
	if #arg_36_0 == 0 then
		return nil
	end

	math = var_1

	return arg_36_0[var_1.random(1, #arg_36_0)]
end

function var_0_1.CheckFinishTask(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	IslandTask = var_1_10004

	local var_37_0 = var_1_10004.New({
		id = arg_37_1,
		process_list = {}
	})

	if var_4.GetType(var_37_0) ~= arg_37_2 then
		return
	end

	pg = var_5

	if not var_5.island_set[arg_37_3] then
		return
	end

	local var_37_1

	if not var_5 or not var_5.key_value_varchar and not {} then
		var_37_1 = {}
	end

	local var_37_2 = arg_37_0:GetSelfIsland()
	local var_37_3 = var_7.GetTaskAgency(var_37_2)
	local var_37_4 = var_7.GetTasks(var_37_3)

	ipairs = var_37_2

	for iter_37_0, iter_37_1 in var_37_2(var_37_4) do
		var_1_10016 = iter_37_1

		if iter_37_1.GetType(var_1_10016) == arg_37_2 then
			return
		end
	end

	local var_37_5 = false
	local var_37_6 = var_7:GetFinishedIds()

	ipairs = var_11

	for iter_37_2, iter_37_3 in var_11(var_37_6) do
		IslandTask = var_1_10016

		local var_37_7 = var_1_10016.New({
			id = iter_37_3,
			process_list = {}
		})

		if var_1_10016.GetType(var_37_7) == arg_37_2 then
			var_37_5 = true

			break
		end
	end

	if var_37_5 then
		local var_37_8 = arg_37_0
		local var_37_9 = arg_37_0.NotifiyCore

		ISLAND_EVT = iter_37_2

		var_37_9(var_37_8, iter_37_2.ALL_DAILY_OR_WEEKLY_FINISH, var_0_2(var_37_1))
	end

	return
end

function var_0_1.OnUpdateTask(arg_38_0)
	arg_38_0:Debounce("RefreshTask", function()
		if not arg_38_0.visibilityAllocator then
			return
		end

		local var_39_0 = arg_38_0.visibilityAllocator

		var_0.Flush(var_39_0)

		local var_39_1 = arg_38_0
		local var_39_2 = var_0.NotifiyCore

		ISLAND_EVT = var_2_10003

		var_39_2(var_39_1, var_2_10003.REFRESH_INTERACTION)

		local var_39_3 = arg_38_0
		local var_39_4 = var_0.NotifiyCore

		ISLAND_EVT = var_3

		var_39_4(var_39_3, var_3.REFRESH_TASK_HUD_INFO)

		return
	end, 0.5, false)()

	return
end

function var_0_1.Debounce(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	if not arg_40_0.__debouncers then
		arg_40_0.__debouncers = {}
	end

	if not arg_40_0.__debouncers[arg_40_1] then
		local var_40_0 = arg_40_0.__debouncers

		debounce = var_1_10006
		var_40_0[arg_40_1] = var_1_10006(arg_40_2, arg_40_3, arg_40_4)
	end

	return arg_40_0.__debouncers[arg_40_1]
end

function var_0_1.OnPlayerAdd(arg_41_0, arg_41_1)
	IslandDataConvertor = var_1_10002

	local var_41_0 = var_1_10002.PlayerData2IslandUnit(arg_41_1.player, arg_41_0.mapId, arg_41_0:GetIsland().id)
	local var_41_1 = arg_41_0
	local var_41_2 = arg_41_0.NotifiyCore

	ISLAND_EVT = var_6

	var_41_2(var_41_1, var_6.GEN_UNIT, var_41_0, function(arg_42_0)
		local var_42_0 = arg_41_0.islandSyncMgr

		var_1.OnVisitorEnter(var_42_0, arg_41_1.player.id, arg_42_0)

		return
	end)

	return
end

function var_0_1.OnPlayerExit(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0
	local var_43_1 = arg_43_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	local var_43_2 = var_1_10005.RMOVE_UNIT

	IslandConst = var_1_10006

	var_43_1(var_43_0, var_43_2, var_1_10006.UNIT_LIST_PLAYER, arg_43_1.id)

	local var_43_3 = arg_43_0.islandSyncMgr

	var_2.OnVisitorExit(var_43_3, arg_43_1.id)

	return
end

function var_0_1.OnPlayerMorphDress(arg_44_0, ...)
	local var_44_0 = arg_44_0
	local var_44_1 = arg_44_0.NotifiyCore

	ISLAND_EVT = var_1_10004

	var_44_1(var_44_0, var_1_10004.MORPH_FORM_CHANGE, ...)

	return
end

function var_0_1.OnPlayerChangeDress(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0
	local var_45_1 = arg_45_0.NotifiyCore

	ISLAND_EVT = var_1_10006

	var_45_1(var_45_0, var_1_10006.CHANGE_DRESS, arg_45_1, arg_45_2)

	return
end

function var_0_1.OnShipChangeDress(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = arg_46_0
	local var_46_1 = arg_46_0.NotifiyCore

	ISLAND_EVT = var_1_10008

	var_46_1(var_46_0, var_1_10008.CHANGE_CHARACTER_DRESS, arg_46_1, arg_46_2, arg_46_3, arg_46_4)

	return
end

function var_0_1.OnStartPlant(arg_47_0, arg_47_1)
	local var_47_0

	ipairs = var_1_10003

	for iter_47_0, iter_47_1 in var_1_10003(arg_47_0.sceneData.productSystems) do
		if iter_47_1.id == arg_47_1.build_id then
			var_47_0 = iter_47_1

			break
		end
	end

	if not var_47_0 then
		return
	end

	local var_47_1 = var_47_0:GetUnitIdBySlotId(arg_47_1.area_id)
	local var_47_2 = arg_47_0
	local var_47_3 = arg_47_0.NotifiyCore

	ISLAND_EVT = iter_47_1

	local var_47_4 = iter_47_1.RMOVE_UNIT

	IslandConst = var_1_10008

	var_47_3(var_47_2, var_47_4, var_1_10008.UNIT_LIST_OBJ, var_47_1)

	local var_47_5 = var_47_0:GenHandPlantUnitBySlotData(arg_47_1.area_id, arg_47_1.formula_id)
	local var_47_6 = arg_47_0
	local var_47_7 = arg_47_0.NotifiyCore

	ISLAND_EVT = var_8

	var_47_7(var_47_6, var_8.GEN_UNIT, var_47_5)

	local var_47_8 = arg_47_0
	local var_47_9 = arg_47_0.NotifiyCore

	ISLAND_EVT = var_8

	var_47_9(var_47_8, var_8.UPDATE_HUD, var_47_1)

	return
end

function var_0_1.OnEndPlant(arg_48_0, arg_48_1)
	local var_48_0

	ipairs = var_1_10003

	for iter_48_0, iter_48_1 in var_1_10003(arg_48_0.sceneData.productSystems) do
		if iter_48_1.id == arg_48_1.build_id then
			var_48_0 = iter_48_1

			break
		end
	end

	if not var_48_0 then
		return
	end

	local var_48_1 = var_48_0:GetUnitIdBySlotId(arg_48_1.area_id)
	local var_48_2 = arg_48_0
	local var_48_3 = arg_48_0.NotifiyCore

	ISLAND_EVT = iter_48_1

	local var_48_4 = iter_48_1.RMOVE_UNIT

	IslandConst = var_1_10008

	var_48_3(var_48_2, var_48_4, var_1_10008.UNIT_LIST_OBJ, var_48_1)

	local var_48_5 = var_48_0:GenHandPlantUnitBySlotData(arg_48_1.area_id)
	local var_48_6 = arg_48_0
	local var_48_7 = arg_48_0.NotifiyCore

	ISLAND_EVT = var_8

	var_48_7(var_48_6, var_8.GEN_UNIT, var_48_5)

	local var_48_8 = arg_48_0
	local var_48_9 = arg_48_0.NotifiyCore

	ISLAND_EVT = var_8

	var_48_9(var_48_8, var_8.UPDATE_HUD, var_48_1)

	return
end

function var_0_1.OnStartDelegation(arg_49_0, arg_49_1)
	local var_49_0

	ipairs = var_1_10003

	for iter_49_0, iter_49_1 in var_1_10003(arg_49_0.sceneData.systemList) do
		isa = var_1_10008
		iter_49_9 = iter_49_1
		IslandCharacterSystemVO = var_1_10011

		if var_1_10008(iter_49_9, var_1_10011) and iter_49_1.id == arg_49_1.build_id then
			var_49_0 = iter_49_1

			break
		end
	end

	if not var_49_0 then
		return
	end

	local var_49_1

	ipairs = var_4

	for iter_49_2, iter_49_3 in var_4(arg_49_0.sceneData.productSystems) do
		if iter_49_3.id == arg_49_1.build_id then
			var_49_1 = iter_49_3

			break
		end
	end

	table = var_4

	local var_49_2 = var_4.contains

	IslandProductConst = var_6

	if var_49_2(var_6.PlantPlaceIdLists, arg_49_1.build_id) then
		pg = var_4

		local var_49_3 = var_4.island_production_slot[arg_49_1.area_id]

		ipairs = var_5

		for iter_49_4, iter_49_5 in var_5(var_49_3.exclusion_slot) do
			iter_49_9 = var_49_1:GetUnitIdBySlotId(iter_49_5)

			if var_49_1:GetUnitVOByUnitId(iter_49_9) then
				var_1_10014 = var_1_10011

				local var_49_4 = var_1_10011.ChangeSlotType

				IslandProductConst = var_1_10015

				var_49_4(var_1_10014, var_1_10015.ProductSlotType.RoleDelegation)
			end
		end
	end

	local var_49_5 = {}

	table = var_5

	local var_49_6 = var_5.contains

	IslandProductConst = var_7

	if var_49_6(var_7.havePerformPlace, arg_49_1.build_id) then
		local var_49_7 = var_49_1:GetDelegateUnitsByBuildIdAndSlotId(arg_49_1.build_id, arg_49_1.area_id, arg_49_1.formula_id)

		var_49_5.commissionSlotId = var_49_1:GetCommissionSlotId(arg_49_1.area_id)
		var_49_5.unitIds = {}
		ipairs = var_6

		for iter_49_6, iter_49_9 in var_6(var_49_7) do
			table = var_1_10011

			var_1_10011.insert(var_49_5.unitIds, iter_49_9.id)
		end

		ipairs = var_6

		for iter_49_8, iter_49_9 in var_6(var_49_7) do
			local var_49_8 = arg_49_0
			local var_49_9 = arg_49_0.NotifiyCore

			ISLAND_EVT = var_1_10014

			var_49_9(var_49_8, var_1_10014.GEN_UNIT, iter_49_9)
		end
	end

	if var_49_1:GetDelegateEffectsByCommissonId(arg_49_1.area_id) and var_49_1:GenUnitByDelegateEffectId(var_5) then
		local var_49_10 = arg_49_0
		local var_49_11 = arg_49_0.NotifiyCore

		ISLAND_EVT = iter_49_9

		var_49_11(var_49_10, iter_49_9.GEN_UNIT, var_6)
	end

	if var_49_0:GetUnit(arg_49_1.ship_id, arg_49_1.area_id, true) then
		local var_49_12 = arg_49_0
		local var_49_13 = arg_49_0.NotifiyCore

		ISLAND_EVT = var_10

		var_49_13(var_49_12, var_10.GEN_UNIT, var_6)
	end

	local var_49_14 = arg_49_0
	local var_49_15 = arg_49_0.NotifiyCore

	ISLAND_EVT = var_10

	var_49_15(var_49_14, var_10.START_DEGATION, arg_49_1, var_49_5)

	return
end

function var_0_1.OnEndDelegation(arg_50_0, arg_50_1)
	local var_50_0

	ipairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003(arg_50_0.sceneData.systemList) do
		isa = var_1_10008
		iter_50_5 = iter_50_1
		IslandCharacterSystemVO = var_1_10011

		if var_1_10008(iter_50_5, var_1_10011) and iter_50_1.id == arg_50_1.build_id then
			var_50_0 = iter_50_1

			break
		end
	end

	if not var_50_0 then
		return
	end

	local var_50_1 = arg_50_0
	local var_50_2 = arg_50_0.NotifiyCore

	ISLAND_EVT = iter_50_0

	var_50_2(var_50_1, iter_50_0.END_DEGATION, arg_50_1)

	local var_50_3 = var_50_0

	if var_50_0.GetUnitShipIdBySlotId(var_50_3, arg_50_1.ship_id, arg_50_1.area_id) then
		local var_50_4 = arg_50_0
		local var_50_5 = arg_50_0.NotifiyCore

		ISLAND_EVT = var_7

		local var_50_6 = var_7.RMOVE_UNIT

		IslandConst = var_1_10008

		var_50_5(var_50_4, var_50_6, var_1_10008.UNIT_LIST_DELEGATION, var_3)
	end

	local var_50_7

	ipairs = var_50_3

	for iter_50_2, iter_50_4 in var_50_3(arg_50_0.sceneData.productSystems) do
		if iter_50_4.id == arg_50_1.build_id then
			var_50_7 = iter_50_4

			break
		end
	end

	table = var_5

	local var_50_8 = var_5.contains

	IslandProductConst = var_7

	if var_50_8(var_7.havePerformPlace, arg_50_1.build_id) then
		local var_50_9 = var_50_7:GetDelegatUnitsBySlotId(arg_50_1.area_id)

		ipairs = var_6

		for iter_50_4, iter_50_5 in var_6(var_50_9) do
			local var_50_10 = arg_50_0
			local var_50_11 = arg_50_0.NotifiyCore

			ISLAND_EVT = var_1_10014
			var_1_10014 = var_1_10014.RMOVE_UNIT
			IslandConst = var_1_10015

			var_50_11(var_50_10, var_1_10014, var_1_10015.UNIT_LIST_DELEGATE_UNIT, iter_50_5)
		end
	end

	local var_50_12

	if var_50_7:GetDelegateEffectsByCommissonId(arg_50_1.area_id) then
		var_50_12 = arg_50_0

		local var_50_13 = arg_50_0.NotifiyCore

		ISLAND_EVT = iter_50_4

		local var_50_14 = iter_50_4.RMOVE_UNIT

		IslandConst = iter_50_5

		var_50_13(var_50_12, var_50_14, iter_50_5.UNIT_LIST_OBJ, var_5)
	end

	if arg_50_1.remainReward then
		return
	end

	table = var_6

	local var_50_15 = var_6.contains

	IslandProductConst = var_50_12

	if var_50_15(var_50_12.PlantPlaceIdLists, arg_50_1.build_id) then
		pg = var_6

		local var_50_16 = var_6.island_production_slot[arg_50_1.area_id]

		ipairs = var_7

		for iter_50_6, iter_50_7 in var_7(var_50_16.exclusion_slot) do
			local var_50_17 = var_50_7:GetUnitIdBySlotId(iter_50_7)
			local var_50_18 = arg_50_0
			local var_50_19 = arg_50_0.NotifiyCore

			ISLAND_EVT = var_1_10016
			var_1_10016 = var_1_10016.RMOVE_UNIT
			IslandConst = var_1_10017

			var_50_19(var_50_18, var_1_10016, var_1_10017.UNIT_LIST_OBJ, var_50_17)

			local var_50_20 = var_50_7:GenHandPlantUnitBySlotData(iter_50_7)

			var_1_10016 = arg_50_0

			local var_50_21 = arg_50_0.NotifiyCore

			ISLAND_EVT = var_1_10017

			var_50_21(var_1_10016, var_1_10017.GEN_UNIT, var_50_20)
		end
	end

	return
end

function var_0_1.OnGetAllDelegationAward(arg_51_0, arg_51_1)
	local var_51_0

	ipairs = var_1_10003

	for iter_51_0, iter_51_1 in var_1_10003(arg_51_0.sceneData.systemList) do
		isa = var_1_10008

		local var_51_1 = iter_51_1

		IslandCharacterSystemVO = var_1_10011

		if var_1_10008(var_51_1, var_1_10011) and iter_51_1.id == arg_51_1.build_id then
			var_51_0 = iter_51_1

			break
		end
	end

	if not var_51_0 then
		return
	end

	local var_51_2

	ipairs = var_4

	for iter_51_2, iter_51_3 in var_4(arg_51_0.sceneData.productSystems) do
		if iter_51_3.id == arg_51_1.build_id then
			var_51_2 = iter_51_3

			break
		end
	end

	local var_51_3 = arg_51_1.build_id

	IslandProductConst = var_5

	if var_51_3 ~= var_5.FarmlandPlaceId then
		var_51_3 = arg_51_1.build_id
		IslandProductConst = var_5

		if var_51_3 ~= var_5.OrchardPlaceId then
			var_51_3 = arg_51_1.build_id
			IslandProductConst = var_5

			if var_51_3 == var_5.GardenPlaceId then
				pg = var_51_3

				local var_51_4 = var_51_3.island_production_slot[arg_51_1.area_id]

				ipairs = var_5

				for iter_51_4, iter_51_5 in var_5(var_51_4.exclusion_slot) do
					local var_51_5 = var_51_2:GetUnitIdBySlotId(iter_51_5)
					local var_51_6 = arg_51_0
					local var_51_7 = arg_51_0.NotifiyCore

					ISLAND_EVT = var_1_10014
					var_1_10014 = var_1_10014.RMOVE_UNIT
					IslandConst = var_1_10015

					var_51_7(var_51_6, var_1_10014, var_1_10015.UNIT_LIST_OBJ, var_51_5)

					local var_51_8 = var_51_2:GenHandPlantUnitBySlotData(iter_51_5)

					var_1_10014 = arg_51_0

					local var_51_9 = arg_51_0.NotifiyCore

					ISLAND_EVT = var_1_10015

					var_51_9(var_1_10014, var_1_10015.GEN_UNIT, var_51_8)
				end
			end

			return
		end
	end
end

function var_0_1.OnChangeSlotModel(arg_52_0, arg_52_1)
	local var_52_0

	ipairs = var_1_10003

	for iter_52_0, iter_52_1 in var_1_10003(arg_52_0.sceneData.productSystems) do
		local var_52_1 = iter_52_1.id

		IslandProductConst = var_1_10009

		if var_52_1 == var_1_10009.FarmlandPlaceId then
			var_52_0 = iter_52_1

			break
		end
	end

	if not var_52_0 then
		return
	end

	local var_52_2 = arg_52_0
	local var_52_3 = arg_52_0.NotifiyCore

	ISLAND_EVT = iter_52_0

	local var_52_4 = iter_52_0.RMOVE_UNIT

	IslandConst = iter_52_1

	var_52_3(var_52_2, var_52_4, iter_52_1.UNIT_LIST_OBJ, arg_52_1.id)

	local var_52_5 = var_52_0:GetUnitVOByUnitId(arg_52_1.id)

	var_52_5.modelId = arg_52_1.modelId

	local var_52_6 = arg_52_0
	local var_52_7 = arg_52_0.NotifiyCore

	ISLAND_EVT = var_7

	var_52_7(var_52_6, var_7.GEN_UNIT, var_52_5)

	return
end

function var_0_1.OnStartHandCollect(arg_53_0, arg_53_1)
	local var_53_0

	ipairs = var_1_10003

	for iter_53_0, iter_53_1 in var_1_10003(arg_53_0.sceneData.productSystems) do
		if iter_53_1.id == arg_53_1.build_id then
			var_53_0 = iter_53_1

			break
		end
	end

	if not var_53_0 then
		return
	end

	local var_53_1 = var_53_0:GetUnitIdBySlotId(arg_53_1.area_id)
	local var_53_2 = arg_53_0
	local var_53_3 = arg_53_0.NotifiyCore

	ISLAND_EVT = iter_53_1

	var_53_3(var_53_2, iter_53_1.UPDATE_UNIT_HAND_COLLECT, var_53_1)

	local var_53_4 = arg_53_0
	local var_53_5 = arg_53_0.NotifiyCore

	ISLAND_EVT = var_7

	var_53_5(var_53_4, var_7.UPDATE_HUD, var_53_1)

	return
end

function var_0_1.OnHandPlantSlotChangeUnit(arg_54_0, arg_54_1)
	local var_54_0

	ipairs = var_1_10003

	for iter_54_0, iter_54_1 in var_1_10003(arg_54_0.sceneData.productSystems) do
		if iter_54_1.id == arg_54_1.build_id then
			var_54_0 = iter_54_1

			break
		end
	end

	if not var_54_0 then
		return
	end

	local var_54_1 = var_54_0:GetUnitIdBySlotId(arg_54_1.slotId)
	local var_54_2 = arg_54_0
	local var_54_3 = arg_54_0.NotifiyCore

	ISLAND_EVT = iter_54_1

	local var_54_4 = iter_54_1.RMOVE_UNIT

	IslandConst = var_1_10008

	var_54_3(var_54_2, var_54_4, var_1_10008.UNIT_LIST_OBJ, var_54_1)

	local var_54_5 = var_54_0:GenHandPlantUnitBySlotData(arg_54_1.slotId)
	local var_54_6 = arg_54_0
	local var_54_7 = arg_54_0.NotifiyCore

	ISLAND_EVT = var_8

	var_54_7(var_54_6, var_8.GEN_UNIT, var_54_5)

	return
end

function var_0_1.OnProductPlaceChangeUnit(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_1.build_id
	local var_55_1

	ipairs = var_1_10004

	for iter_55_0, iter_55_1 in var_1_10004(arg_55_0.sceneData.productSystems) do
		if iter_55_1.id == var_55_0 then
			var_55_1 = iter_55_1

			break
		end
	end

	if not var_55_1 then
		return
	end

	local var_55_2 = var_55_1:GetPlaceModelId(false)
	local var_55_3 = arg_55_0
	local var_55_4 = arg_55_0.NotifiyCore

	ISLAND_EVT = iter_55_1

	local var_55_5 = iter_55_1.RMOVE_UNIT

	IslandConst = var_1_10009

	var_55_4(var_55_3, var_55_5, var_1_10009.UNIT_LIST_OBJ, var_55_2)

	local var_55_6 = var_55_1:GetPlaceModelUnit(true)
	local var_55_7 = arg_55_0
	local var_55_8 = arg_55_0.NotifiyCore

	ISLAND_EVT = var_9

	var_55_8(var_55_7, var_9.GEN_UNIT, var_55_6)

	return
end

function var_0_1.OnRemoveWildGatherDone(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0
	local var_56_1 = arg_56_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	local var_56_2 = var_1_10005.RMOVE_UNIT

	IslandConst = var_1_10006

	var_56_1(var_56_0, var_56_2, var_1_10006.UNIT_LIST_OBJ, arg_56_1.unitId)

	local var_56_3 = arg_56_0
	local var_56_4 = arg_56_0.NotifiyCore

	ISLAND_EVT = var_56_2

	var_56_4(var_56_3, var_56_2.LEAVE_UNIT, {
		id = arg_56_1.unitId
	})

	return
end

function var_0_1.OnAddWildGatherDone(arg_57_0, arg_57_1)
	IslandDataConvertor = var_1_10002

	local var_57_0 = var_1_10002.GenWildGatherUnit(arg_57_1)
	local var_57_1 = arg_57_0
	local var_57_2 = arg_57_0.NotifiyCore

	ISLAND_EVT = var_1_10006

	var_57_2(var_57_1, var_1_10006.GEN_UNIT, var_57_0)

	return
end

function var_0_1.OnCollectSlotUnitInit(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1.slotId

	pg = var_1_10003

	local var_58_1 = var_1_10003.island_production_slot[var_58_0].place
	local var_58_2

	ipairs = var_1_10005

	for iter_58_0, iter_58_1 in var_1_10005(arg_58_0.sceneData.productSystems) do
		if iter_58_1.id == var_58_1 then
			var_58_2 = iter_58_1

			break
		end
	end

	if not var_58_2 then
		return
	end

	if var_58_2:InitHandCollectSlotBySlotId(var_58_0) then
		local var_58_3 = arg_58_0
		local var_58_4 = arg_58_0.NotifiyCore

		ISLAND_EVT = iter_58_1

		var_58_4(var_58_3, iter_58_1.GEN_UNIT, var_5)
	end

	return
end

function var_0_1.OnCollectSlotUnitUpdate(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1.slotId

	pg = var_1_10003

	local var_59_1 = var_1_10003.island_production_slot[var_59_0].place
	local var_59_2

	ipairs = var_1_10005

	for iter_59_0, iter_59_1 in var_1_10005(arg_59_0.sceneData.productSystems) do
		if iter_59_1.id == var_59_1 then
			var_59_2 = iter_59_1

			break
		end
	end

	if not var_59_2 then
		return
	end

	if var_59_2:GetUnitIdBySlotId(arg_59_1.slotId) then
		local var_59_3 = arg_59_0
		local var_59_4 = arg_59_0.NotifiyCore

		ISLAND_EVT = iter_59_1

		var_59_4(var_59_3, iter_59_1.UPDATE_UNIT_HAND_COLLECT, var_5)

		local var_59_5 = arg_59_0
		local var_59_6 = arg_59_0.NotifiyCore

		ISLAND_EVT = var_9

		var_59_6(var_59_5, var_9.UPDATE_HUD, var_5)
	end

	return
end

function var_0_1.OnCollectSloSlotUnitRemove(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1.slotId

	pg = var_1_10003

	local var_60_1 = var_1_10003.island_production_slot[var_60_0].place
	local var_60_2

	ipairs = var_1_10005

	for iter_60_0, iter_60_1 in var_1_10005(arg_60_0.sceneData.productSystems) do
		if iter_60_1.id == var_60_1 then
			var_60_2 = iter_60_1

			break
		end
	end

	if not var_60_2 then
		return
	end

	local var_60_3 = var_60_2:GetHandCollectSlotBySlotId(var_60_0)
	local var_60_4 = arg_60_0
	local var_60_5 = arg_60_0.NotifiyCore

	ISLAND_EVT = iter_60_1

	local var_60_6 = iter_60_1.RMOVE_UNIT

	IslandConst = var_1_10010

	var_60_5(var_60_4, var_60_6, var_1_10010.UNIT_LIST_OBJ, var_60_3)

	return
end

function var_0_1.OnSyncDataUpdate(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.islandSyncMgr

	var_2.HandleSyncData(var_61_0, arg_61_1)

	return
end

function var_0_1.OnSyncObjUpdate(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0.islandSyncMgr

	var_2.HandleSyncObj(var_62_0, arg_62_1)

	return
end

function var_0_1.Update(arg_63_0)
	local var_63_0 = arg_63_0.playerInputManager

	var_1.Update(var_63_0)

	local var_63_1 = arg_63_0.islandSyncMgr

	var_1.Update(var_63_1)

	return
end

function var_0_1.OnDispose(arg_64_0)
	if arg_64_0.playerInputManager then
		local var_64_0 = arg_64_0.playerInputManager

		var_1.Dispose(var_64_0)

		arg_64_0.playerInputManager = nil
	end

	if arg_64_0.islandSyncMgr then
		local var_64_1 = arg_64_0.islandSyncMgr

		var_1.Dispose(var_64_1)

		arg_64_0.islandSyncMgr = nil
	end

	if arg_64_0.strollAllocator then
		local var_64_2 = arg_64_0.strollAllocator

		var_1.Dispose(var_64_2)

		arg_64_0.strollAllocator = nil
	end

	if arg_64_0.visibilityAllocator then
		local var_64_3 = arg_64_0.visibilityAllocator

		var_1.Dispose(var_64_3)

		arg_64_0.visibilityAllocator = nil
	end

	if arg_64_0.giftAllocator then
		local var_64_4 = arg_64_0.giftAllocator

		var_1.Dispose(var_64_4)

		arg_64_0.giftAllocator = nil
	end

	if arg_64_0.timeDelayCreate then
		local var_64_5 = arg_64_0.timeDelayCreate

		var_1.Dispose(var_64_5)

		arg_64_0.timeDelayCreate = nil
	end

	if arg_64_0.activityNpcAllocator then
		local var_64_6 = arg_64_0.activityNpcAllocator

		var_1.Dispose(var_64_6)

		arg_64_0.activityNpcAllocator = nil
	end

	arg_64_0.__debouncers = nil

	return
end

function var_0_1.OnAnimalInit(arg_65_0, arg_65_1)
	local var_65_0

	ipairs = var_1_10003

	for iter_65_0, iter_65_1 in var_1_10003(arg_65_0.sceneData.productSystems) do
		local var_65_1 = iter_65_1.id

		IslandProductConst = var_1_10009

		if var_65_1 == var_1_10009.PasturePlaceId then
			var_65_0 = iter_65_1

			break
		end
	end

	if not var_65_0 then
		return
	end

	local var_65_2 = arg_65_1.slotId

	ipairs = var_4

	for iter_65_2, iter_65_3 in var_4(arg_65_1.aniList) do
		local var_65_3 = var_65_0:GenAnimalByAnialConfig(iter_65_3, var_65_2)
		local var_65_4 = arg_65_0
		local var_65_5 = arg_65_0.NotifiyCore

		ISLAND_EVT = var_13

		var_65_5(var_65_4, var_13.GEN_UNIT, var_65_3)
	end

	return
end

function var_0_1.OnSlotDelegateInit(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_1.slotId

	pg = var_1_10003

	local var_66_1 = var_1_10003.island_production_slot[var_66_0].place
	local var_66_2

	ipairs = var_1_10005

	for iter_66_0, iter_66_1 in var_1_10005(arg_66_0.sceneData.productSystems) do
		if iter_66_1.id == var_66_1 then
			var_66_2 = iter_66_1

			break
		end
	end

	if not var_66_2 then
		return
	end

	local var_66_3 = var_66_2:GetCommissionSlotId(var_66_0)

	pg = var_6

	if var_6.island_production_commission[var_66_3].unlockObjid ~= 0 then
		local var_66_4 = arg_66_0
		local var_66_5 = arg_66_0.NotifiyCore

		ISLAND_EVT = var_1_10011

		local var_66_6 = var_1_10011.RMOVE_UNIT

		IslandConst = var_1_10012

		var_66_5(var_66_4, var_66_6, var_1_10012.UNIT_LIST_OBJ, var_7)
	end

	return
end

function var_0_1.IsPlayerInTimeline(arg_67_0)
	local var_67_0 = arg_67_0.islandSyncMgr.player

	return var_1.InTimeline(var_67_0)
end

function var_0_1.InitSyncMgr(arg_68_0)
	local var_68_0 = arg_68_0.islandSyncMgr

	var_1.Init(var_68_0, arg_68_0.sceneData.unitList)

	return
end

function var_0_1.SetVisitorSyncData(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = arg_69_0
	local var_69_1 = arg_69_0.NotifiyCore

	ISLAND_EVT = var_1_10006

	var_69_1(var_69_0, var_1_10006.SET_VISITOR_SYNC_DATA, arg_69_1, arg_69_2)

	return
end

function var_0_1.WorldObjectInterAction(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	arg_70_3 = arg_70_3 or 1
	_ = var_1_10004

	if not var_1_10004.detect(arg_70_0.sceneData.unitList, function(arg_71_0)
		return arg_71_0.id == arg_70_1
	end) or not var_4:Interactable() then
		return
	end

	if not var_4:GetEmptySlot() then
		pg = var_6

		local var_70_0 = var_6.TipsMgr.GetInstance()
		local var_70_1 = var_6.ShowTips

		i18n = var_1_10009

		var_70_1(var_70_0, var_1_10009("island_agora_no_interact_point"))

		return
	end

	local function var_70_2()
		local var_72_0 = var_0

		var_0.Lock(var_72_0, arg_70_2)

		local var_72_1 = arg_70_0
		local var_72_2 = var_0.NotifiyCore

		ISLAND_EVT = var_3

		var_72_2(var_72_1, var_3.WORLD_OBJECT_START_INTERACTION, var_0, var_0, arg_70_3)

		return
	end

	local var_70_3 = arg_70_0.islandSyncMgr
	local var_70_4 = var_7.TryControlUnit

	IslandConst = var_1_10010

	var_70_4(var_70_3, var_1_10010.SYNC_TYPE_UNIT_STATIC, arg_70_1, var_5.id, arg_70_3, function(arg_73_0)
		if arg_73_0 then
			var_70_2()
		end

		return
	end)

	return
end

function var_0_1.WorldObjectInterActionSync(arg_74_0, arg_74_1, arg_74_2, arg_74_3, arg_74_4)
	arg_74_3 = arg_74_3 or 1
	_ = var_1_10005

	if not var_1_10005.detect(arg_74_0.sceneData.unitList, function(arg_75_0)
		return arg_75_0.id == arg_74_1
	end) or not var_5:Interactable() then
		return
	end

	local var_74_0 = var_5:GetSlotById(arg_74_4)

	var_6.Lock(var_74_0, arg_74_2)

	local var_74_1 = arg_74_0
	local var_74_2 = arg_74_0.NotifiyCore

	ISLAND_EVT = var_10

	var_74_2(var_74_1, var_10.WORLD_OBJECT_START_INTERACTION, var_5, var_6, arg_74_3)

	return
end

function var_0_1.WorldObjectInterActionEnd(arg_76_0, arg_76_1, arg_76_2)
	_ = var_1_10003

	if not var_1_10003.detect(arg_76_0.sceneData.unitList, function(arg_77_0)
		return arg_77_0.id == arg_76_1
	end) or not var_3:Interactable() then
		return
	end

	local var_76_0 = var_3:GetUsingSlot(arg_76_2)

	local function var_76_1()
		Clone = var_2_10000

		local var_78_0 = var_2_10000(var_76_0)
		local var_78_1 = var_76_0

		var_1.Release(var_78_1)

		local var_78_2 = arg_76_0
		local var_78_3 = var_1.NotifiyCore

		ISLAND_EVT = var_2_10004

		var_78_3(var_78_2, var_2_10004.WORLD_OBJECT_END_INTERACTION, var_0, var_78_0)

		return
	end

	local var_76_2 = arg_76_0.islandSyncMgr
	local var_76_3 = var_6.EndControlUnit

	IslandConst = var_1_10009

	var_76_3(var_76_2, var_1_10009.SYNC_TYPE_UNIT_STATIC, arg_76_1, var_76_0.id, function(arg_79_0)
		if arg_79_0 then
			var_76_1()
		end

		return
	end)

	return
end

function var_0_1.WorldObjectInterActionEndSync(arg_80_0, arg_80_1, arg_80_2)
	_ = var_1_10003

	if not var_1_10003.detect(arg_80_0.sceneData.unitList, function(arg_81_0)
		return arg_81_0.id == arg_80_1
	end) or not var_3:Interactable() then
		return
	end

	local var_80_0 = var_3:GetUsingSlot(arg_80_2)

	Clone = var_5

	local var_80_1 = var_5(var_80_0)

	var_80_0:Release()

	local var_80_2 = arg_80_0
	local var_80_3 = arg_80_0.NotifiyCore

	ISLAND_EVT = var_1_10009

	var_80_3(var_80_2, var_1_10009.WORLD_OBJECT_END_INTERACTION, var_3, var_80_1)

	return
end

function var_0_1.WorldObjectInitStatus(arg_82_0, arg_82_1, arg_82_2)
	_ = var_1_10003

	local var_82_0 = var_1_10003.detect(arg_82_0.sceneData.unitList, function(arg_83_0)
		return arg_83_0.id == arg_82_1
	end)

	warning = var_1_10004

	var_1_10004("init", arg_82_1, arg_82_2, var_82_0)

	if not var_82_0 or not var_82_0:Interactable() then
		return
	end

	local var_82_1 = arg_82_0
	local var_82_2 = arg_82_0.NotifiyCore

	ISLAND_EVT = var_7

	var_82_2(var_82_1, var_7.WORLD_OBJECT_INIT_STATUS, var_82_0, arg_82_2)

	return
end

function var_0_1.OnOpenRestaurant(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_1.restId
	local var_84_1 = arg_84_1.postList
	local var_84_2

	ipairs = var_1_10005

	for iter_84_0, iter_84_1 in var_1_10005(arg_84_0.sceneData.systemList) do
		isa = var_1_10010

		local var_84_3 = iter_84_1

		IslandManageSystemVO = var_1_10013

		if var_1_10010(var_84_3, var_1_10013) and iter_84_1.id == var_84_0 then
			var_84_2 = iter_84_1

			break
		end
	end

	if not var_84_2 then
		return
	end

	local var_84_4 = var_84_2:GetUnits(var_84_1)

	ipairs = var_6

	for iter_84_2, iter_84_3 in var_6(var_84_4) do
		local var_84_5 = arg_84_0
		local var_84_6 = arg_84_0.NotifiyCore

		ISLAND_EVT = var_1_10014

		var_84_6(var_84_5, var_1_10014.GEN_UNIT, iter_84_3)
	end

	local var_84_7 = arg_84_0
	local var_84_8 = arg_84_0.NotifiyCore

	ISLAND_EVT = iter_84_2

	var_84_8(var_84_7, iter_84_2.START_MANAGE, var_84_2)

	return
end

function var_0_1.OnCloseRestaurant(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_1.restId
	local var_85_1 = arg_85_1.postList
	local var_85_2

	ipairs = var_1_10005

	for iter_85_0, iter_85_1 in var_1_10005(arg_85_0.sceneData.systemList) do
		isa = var_1_10010

		local var_85_3 = iter_85_1

		IslandManageSystemVO = var_1_10013

		if var_1_10010(var_85_3, var_1_10013) and iter_85_1.id == var_85_0 then
			var_85_2 = iter_85_1

			break
		end
	end

	if not var_85_2 then
		return
	end

	local var_85_4 = arg_85_0
	local var_85_5 = arg_85_0.NotifiyCore

	ISLAND_EVT = iter_85_0

	var_85_5(var_85_4, iter_85_0.END_MANAGE, var_85_2)

	local var_85_6 = var_85_2:GetUnits(var_85_1)

	ipairs = var_6

	for iter_85_2, iter_85_3 in var_6(var_85_6) do
		local var_85_7 = arg_85_0
		local var_85_8 = arg_85_0.NotifiyCore

		ISLAND_EVT = var_1_10014
		var_1_10014 = var_1_10014.RMOVE_UNIT
		IslandConst = var_1_10015

		var_85_8(var_85_7, var_1_10014, var_1_10015.UNIT_LIST_MANAGE, iter_85_3.id)
	end

	return
end

function var_0_1.OnSwitchMap(arg_86_0)
	if arg_86_0.islandSyncMgr then
		local var_86_0 = arg_86_0.islandSyncMgr

		if var_1.IsPlayerInTimeline(var_86_0) then
			local var_86_1 = arg_86_0
			local var_86_2 = arg_86_0.NotifiyCore

			ISLAND_EVT = var_1_10004

			var_86_2(var_86_1, var_1_10004.INIT_INTERACTION_OP_VIEW)
		end
	end

	return
end

return var_0_1
