local IslandController = class("IslandController", import(".IslandBaseController"))

function IslandController:Init()
	self.sceneData = IslandDataConvertor.Island2SceneData(self.island)
	self.mapId = self.sceneData.mapId

	return
end

function IslandController:SystemCtor()
	self.strollAllocator = IslandStrollAllocator.New(self)
	self.visibilityAllocator = IslandVisibilityAllocator.New(self)
	self.giftAllocator = IslandGiftAllocator.New(self)
	self.activityNpcAllocator = IslandActivityNpcAllocator.New(self)
	self.timeDelayCreate = IslandDelayCreationSystem.New(self)
	self.playerInputManager = PlayerInputManager.New(self)
	self.islandSyncMgr = IslandSyncMgr.New(self)

	return
end

function IslandController:SetUp()
	self:SystemCtor()

	for iter_3_0, iter_3_1 in ipairs(self.sceneData.unitList) do
		if self.visibilityAllocator:IsVisible(iter_3_1.id) then
			self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(self.sceneData.activityUnits) do
		if self.activityNpcAllocator:IsVisible(iter_3_3.id) then
			self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_3_3)
		end
	end

	for iter_3_4, iter_3_5 in ipairs(self.sceneData.giftUnits) do
		if self.giftAllocator:IsVisible(iter_3_4) then
			self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_3_5)
		end
	end

	for iter_3_6, iter_3_7 in ipairs(self.sceneData.systemList) do
		self:NotifiyCore(ISLAND_EVT.GEN_SYSTEM, iter_3_7)
	end

	for iter_3_8, iter_3_9 in ipairs(self.sceneData.systemUnits) do
		self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_3_9)
	end

	for iter_3_10, iter_3_11 in ipairs(self.sceneData.strollUnits) do
		local var_3_0, var_3_1 = self.strollAllocator:Allocator(iter_3_11:GetDefaultPathId(self.mapId))

		iter_3_11:SetPath(var_3_0, var_3_1)
		self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_3_11)
	end

	for iter_3_12, iter_3_13 in ipairs(self.sceneData.followUnits) do
		self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_3_13)
	end

	self.timeDelayCreate:InitUnit()

	return
end

function IslandController:ResetPlayerPosition(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.sceneData.unitList) do
		if iter_4_1:IsPlayer() then
			self:NotifiyCore(ISLAND_EVT.RESET_UNIT_POS, iter_4_1.id, IslandConst.UNIT_LIST_PLAYER, iter_4_1.position)
		end
	end

	return
end

function IslandController:OnCoreInitFinish()
	self:NotifiyCore(ISLAND_EVT.INIT_FINISH, self.sceneData.camreaZoomData)
	self:NotifiyIsland(ISLAND_EX_EVT.INIT_FINISH)
	self.playerInputManager:Init()
	self:InitStrollUnitsAwards()
	self:InitSyncMgr()
	self:InitVisitor()

	return
end

function IslandController:InitVisitor()
	for iter_6_0, iter_6_1 in pairs((self.island:GetVisitorAgency():GetMapVisitorList())) do
		if not iter_6_1:IsSelf() then
			self:OnPlayerAdd({
				player = iter_6_1
			})
		else
			self.islandSyncMgr:OnVisitorEnter(iter_6_1.id, nil)
		end
	end

	return
end

function IslandController:InitStrollUnitsAwards()
	for iter_7_0, iter_7_1 in ipairs(self.sceneData.strollUnits) do
		if iter_7_1:ExistGreetingActionFeedback() then
			self:NotifiyCore(ISLAND_EVT.SHOW_NPC_ANIMATION_BUBBLE, iter_7_1)
		end
	end

	return
end

function IslandController:GetMapID()
	return self.mapId
end

function IslandController:AddListeners()
	self:AddIslandListener(IslandVisitorAgency.VISITOR_ADD, self.OnPlayerAdd)
	self:AddIslandListener(IslandVisitorAgency.VISITOR_EXIT, self.OnPlayerExit)
	self:AddIslandListener(IslandDressUpAgency.MORPH_PLAYER_DRESS, self.OnPlayerMorphDress)
	self:AddIslandListener(IslandDressUpAgency.CHANGE_PLAYER_DRESS, self.OnPlayerChangeDress)
	self:AddIslandListener(IslandCharacterAgency.CHANGE_CHARACTER_DRESS, self.OnShipChangeDress)
	self:AddIslandListener(IslandCharacterAgency.SHIP_SKILL_STATE_CHANGE, self.OnShipSkillStateChange)
	self:AddIslandListener(IslandSyncMgr.ISLAND_SYNC_DATA_UPDATE, self.OnSyncDataUpdate)
	self:AddIslandListener(IslandSyncMgr.ISLAND_SYNC_OBJ_UPDATE, self.OnSyncObjUpdate)
	self:AddIslandListener(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, self.OnCollectSlotUnitInit)
	self:AddIslandListener(IslandBuildingAgency.COLLECT_SlOT_UNIT_UPDATE, self.OnCollectSlotUnitUpdate)
	self:AddIslandListener(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, self.OnCollectSloSlotUnitRemove)
	self:AddIslandListener(IslandStartDelegationCommand.START_DELEGATION, self.OnStartDelegation)
	self:AddIslandListener(IslandFinishDelegationCommand.END_DELEGATION, self.OnEndDelegation)
	self:AddIslandListener(IslandBuildingAgency.SLOT_RESET_DELEGATION_STATE_DONE, self.OnGetAllDelegationAward)
	self:AddIslandListener(IslandTaskAgency.TASK_ADDED, self.OnTaskAdd)
	self:AddIslandListener(IslandTaskAgency.TASK_FINISH, self.OnFinishTask)
	self:AddIslandListener(IslandTaskAgency.TASK_UPDATED, self.OnUpdateTask)
	self:AddIslandListener(IslandSlotHandPlantCommand.START_HANDPLANT_DONE, self.OnStartPlant)
	self:AddIslandListener(IslandSlotHandPlantAwardCommand.START_HANDPLANT_AWARD_DONE, self.OnEndPlant)
	self:AddIslandListener(IslandSlotCollectCommand.START_HAND_COLLECT_DONE, self.OnStartHandCollect)
	self:AddIslandListener(IslandBuildingAgency.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, self.OnHandPlantSlotChangeUnit)
	self:AddIslandListener(IslandBuildingAgency.CHANGE_PRODUCT_MODEL, self.OnProductPlaceChangeUnit)
	self:AddIslandListener(IslandGatherCollectAgency.RemoveGatherUnit, self.OnRemoveWildGatherDone)
	self:AddIslandListener(IslandGatherCollectAgency.AddGatherUnit, self.OnAddWildGatherDone)
	self:AddIslandListener(ISLAND_EVT.CHANGE_SLOT_MODEL, self.OnChangeSlotModel)
	self:AddIslandListener(IslandOpenRestaurantCommand.OPEN_RESTAURANT, self.OnOpenRestaurant)
	self:AddIslandListener(IslandCloseRestaurantCommand.CLOSE_RESTAURANT, self.OnCloseRestaurant)
	self:AddIslandListener(IslandProxy.STORY_START, self.OnStartStory)
	self:AddIslandListener(IslandProxy.STORY_END, self.OnEndStory)
	self:AddIslandListener(IslandProxy.PERFORMANCE_START, self.OnStartPerformance)
	self:AddIslandListener(IslandProxy.PERFORMANCE_END, self.OnEndPerformance)
	self:AddIslandListener(IslandProxy.START_PATHFINDER, self.OnStartPathFinder)
	self:AddIslandListener(IslandProxy.END_PATHFINDER, self.OnEndPathFinder)
	self:AddIslandListener(IslandProxy.ACTIVE_OR_DISABLE_UNIT, self.OnActiveOrDisableUnit)
	self:AddIslandListener(IslandProxy.LINK_CORE, self.OnLinkCore)
	self:AddIslandListener(IslandBuildingAgency.GEN_ANIMAL_INT, self.OnAnimalInit)
	self:AddIslandListener(IslandBuildingAgency.SLOT_DELEGATE_INIT, self.OnSlotDelegateInit)
	self:AddIslandListener(IslandNpcFeedbackAgency.NPC_ACTION_CHANGE, self.OnNpcActionFeedBackChange)
	self:AddIslandListener(IslandNpcFeedbackAgency.RESET_NPC_ACTIONS, self.OnResetNpcActionFeedback)
	self:AddIslandListener(IslandFollowerAgency.ADD_FOLLOWER, self.OnAddFollower)
	self:AddIslandListener(IslandFollowerAgency.DEL_FOLLOWER, self.OnDelFollower)
	self:AddIslandListener(ActivityProxy.ACTIVITY_UPDATED, self.OnActivityUpdate)
	self:AddIslandListener(IslandProxy.GEN_RECYCLEITEM, self.OnGenRecycleItem)
	self:AddIslandListener(IslandActivityNpcAgency.ACTIVITY_NPC_ADD, self.OnActivityNpcAdd)
	self:AddIslandListener(IslandActivityNpcAgency.ACTIVITY_NPC_UPDATE, self.OnActivityNpcUpdate)
	self:AddIslandListener(IslandActivityNpcAgency.ACTIVITY_NPC_DEL, self.OnActivityNpcDel)
	self:AddIslandListener(IslandAblityAgency.UNLOCK_SYSTEM, self.OnSystemUnlock)
	self:AddIslandListener(IslandProxy.LOCK_NPC_REFRESH, self.OnLockNpcRefresh)
	self:AddIslandListener(IslandProxy.RELEASE_NPC_REFRESH, self.OnReleaseNpcRefresh)
	self:AddIslandListener(IslandProxy.RESET_SP, self.OnResetSp)
	self:AddIslandListener(IslandFishingAgency.BAIT_UPDATE, self.OnBaitUpdate)
	self:AddIslandListener(ISLAND_EVT.SWITCH_MAP, self.OnSwitchMap)

	return
end

function IslandController:RemoveListeners()
	self:RemoveIslandListener(IslandVisitorAgency.VISITOR_ADD, self.OnPlayerAdd)
	self:RemoveIslandListener(IslandVisitorAgency.VISITOR_EXIT, self.OnPlayerExit)
	self:RemoveIslandListener(IslandDressUpAgency.MORPH_PLAYER_DRESS, self.OnPlayerMorphDress)
	self:RemoveIslandListener(IslandDressUpAgency.CHANGE_PLAYER_DRESS, self.OnPlayerChangeDress)
	self:RemoveIslandListener(IslandCharacterAgency.CHANGE_CHARACTER_DRESS, self.OnShipChangeDress)
	self:RemoveIslandListener(IslandCharacterAgency.SHIP_SKILL_STATE_CHANGE, self.OnShipSkillStateChange)
	self:RemoveIslandListener(IslandSyncMgr.ISLAND_SYNC_DATA_UPDATE, self.OnSyncDataUpdate)
	self:RemoveIslandListener(IslandSyncMgr.ISLAND_SYNC_OBJ_UPDATE, self.OnSyncObjUpdate)
	self:RemoveIslandListener(IslandBuildingAgency.COLLECT_SlOT_UNIT_INIT, self.OnCollectSlotUnitInit)
	self:RemoveIslandListener(IslandBuildingAgency.COLLECT_SlOT_UNIT_UPDATE, self.OnCollectSlotUnitUpdate)
	self:RemoveIslandListener(IslandBuildingAgency.COLLECT_SLOT_UNIT_REMOVE, self.OnCollectSloSlotUnitRemove)
	self:RemoveIslandListener(IslandStartDelegationCommand.START_DELEGATION, self.OnStartDelegation)
	self:RemoveIslandListener(IslandFinishDelegationCommand.END_DELEGATION, self.OnEndDelegation)
	self:RemoveIslandListener(IslandBuildingAgency.SLOT_RESET_DELEGATION_STATE_DONE, self.OnGetAllDelegationAward)
	self:RemoveIslandListener(IslandTaskAgency.TASK_ADDED, self.OnTaskAdd)
	self:RemoveIslandListener(IslandTaskAgency.TASK_FINISH, self.OnFinishTask)
	self:RemoveIslandListener(IslandTaskAgency.TASK_UPDATED, self.OnUpdateTask)
	self:RemoveIslandListener(IslandSlotHandPlantCommand.START_HANDPLANT_DONE, self.OnStartPlant)
	self:RemoveIslandListener(IslandSlotHandPlantAwardCommand.START_HANDPLANT_AWARD_DONE, self.OnEndPlant)
	self:RemoveIslandListener(IslandSlotCollectCommand.START_HAND_COLLECT_DONE, self.OnStartHandCollect)
	self:RemoveIslandListener(IslandBuildingAgency.SLOT_HANDPLABT_SLOT_UNIT_CHANGE, self.OnHandPlantSlotChangeUnit)
	self:RemoveIslandListener(IslandBuildingAgency.CHANGE_PRODUCT_MODEL, self.OnProductPlaceChangeUnit)
	self:RemoveIslandListener(IslandGatherCollectAgency.RemoveGatherUnit, self.OnRemoveWildGatherDone)
	self:RemoveIslandListener(IslandGatherCollectAgency.AddGatherUnit, self.OnAddWildGatherDone)
	self:RemoveIslandListener(ISLAND_EVT.CHANGE_SLOT_MODEL, self.OnChangeSlotModel)
	self:RemoveIslandListener(IslandOpenRestaurantCommand.OPEN_RESTAURANT, self.OnOpenRestaurant)
	self:RemoveIslandListener(IslandProxy.STORY_START, self.OnStartStory)
	self:RemoveIslandListener(IslandProxy.STORY_END, self.OnEndStory)
	self:RemoveIslandListener(IslandProxy.PERFORMANCE_START, self.OnStartPerformance)
	self:RemoveIslandListener(IslandProxy.PERFORMANCE_END, self.OnEndPerformance)
	self:RemoveIslandListener(IslandProxy.START_PATHFINDER, self.OnStartPathFinder)
	self:RemoveIslandListener(IslandProxy.END_PATHFINDER, self.OnEndPathFinder)
	self:RemoveIslandListener(IslandProxy.ACTIVE_OR_DISABLE_UNIT, self.OnActiveOrDisableUnit)
	self:RemoveIslandListener(IslandProxy.LINK_CORE, self.OnLinkCore)
	self:RemoveIslandListener(IslandBuildingAgency.GEN_ANIMAL_INT, self.OnAnimalInit)
	self:RemoveIslandListener(IslandBuildingAgency.SLOT_DELEGATE_INIT, self.OnSlotDelegateInit)
	self:RemoveIslandListener(IslandNpcFeedbackAgency.NPC_ACTION_CHANGE, self.OnNpcActionFeedBackChange)
	self:RemoveIslandListener(IslandNpcFeedbackAgency.RESET_NPC_ACTIONS, self.OnResetNpcActionFeedback)
	self:RemoveIslandListener(IslandFollowerAgency.ADD_FOLLOWER, self.OnAddFollower)
	self:RemoveIslandListener(IslandFollowerAgency.DEL_FOLLOWER, self.OnDelFollower)
	self:RemoveIslandListener(ActivityProxy.ACTIVITY_UPDATED, self.OnActivityUpdate)
	self:RemoveIslandListener(IslandProxy.GEN_RECYCLEITEM, self.OnGenRecycleItem)
	self:RemoveIslandListener(IslandActivityNpcAgency.ACTIVITY_NPC_ADD, self.OnActivityNpcAdd)
	self:RemoveIslandListener(IslandActivityNpcAgency.ACTIVITY_NPC_UPDATE, self.OnActivityNpcUpdate)
	self:RemoveIslandListener(IslandActivityNpcAgency.ACTIVITY_NPC_DEL, self.OnActivityNpcDel)
	self:RemoveIslandListener(IslandAblityAgency.UNLOCK_SYSTEM, self.OnSystemUnlock)
	self:RemoveIslandListener(IslandProxy.LOCK_NPC_REFRESH, self.OnLockNpcRefresh)
	self:RemoveIslandListener(IslandProxy.RELEASE_NPC_REFRESH, self.OnReleaseNpcRefresh)
	self:RemoveIslandListener(IslandProxy.RESET_SP, self.OnResetSp)
	self:RemoveIslandListener(IslandFishingAgency.BAIT_UPDATE, self.OnBaitUpdate)
	self:RemoveIslandListener(ISLAND_EVT.SWITCH_MAP, self.OnSwitchMap)

	return
end

function IslandController:OnBaitUpdate(arg_11_1)
	self:NotifiyCore(ISLAND_EVT.BAIT_UPDATE, arg_11_1)

	return
end

function IslandController:OnResetSp()
	for iter_12_0, iter_12_1 in ipairs(pg.island_world_objects.get_id_list_by_mapId[self.mapId] or {}) do
		if pg.island_world_objects[iter_12_1].unitId == 0 then
			spConfig = pg.island_world_objects[iter_12_1]

			break
		end
	end

	local var_12_1

	if not spConfig then
		do return end

		var_12_1 = getProxy(PlayerProxy):getRawData().id
	end

	self:NotifiyCore(ISLAND_EVT.RESET_UNIT_POS, var_12_1, IslandConst.UNIT_LIST_PLAYER, (BuildVector3(spConfig.param.position)))
	self:NotifiyCore(ISLAND_EVT.RESET_UNIT_ROT, var_12_1, IslandConst.UNIT_LIST_PLAYER, (BuildVector3(spConfig.param.rotation)))

	return
end

function IslandController:OnLockNpcRefresh(arg_13_1, arg_13_2)
	self.visibilityAllocator:LockNpc(arg_13_1, arg_13_2)

	return
end

function IslandController:OnReleaseNpcRefresh(arg_14_1, arg_14_2)
	self.visibilityAllocator:ReleaseNpc(arg_14_1, arg_14_2)

	return
end

function IslandController:OnSystemUnlock(arg_15_1)
	self:NotifiyCore(ISLAND_EVT.SYSTEM_UNLOCK, arg_15_1)

	return
end

function IslandController:OnActivityNpcAdd(arg_16_1)
	self.activityNpcAllocator:AddNpc(arg_16_1)
	self.activityNpcAllocator:Flush()

	return
end

function IslandController:OnActivityNpcUpdate(arg_17_1, arg_17_2)
	self.activityNpcAllocator:DelNpc(arg_17_1)
	self.activityNpcAllocator:AddNpc(arg_17_2)
	self.activityNpcAllocator:Flush()

	return
end

function IslandController:OnActivityNpcDel(arg_18_1)
	self.activityNpcAllocator:DelNpc(arg_18_1)
	self.activityNpcAllocator:Flush()

	return
end

function IslandController:OnActivityUpdate()
	self.activityNpcAllocator:Flush()

	return
end

function IslandController:OnGenRecycleItem(arg_20_1)
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (IslandDataConvertor.GenDelayRecycleIslandUnit(arg_20_1)))

	return
end

function IslandController:OnAddFollower(arg_21_1)
	local var_21_0 = self:GetIsland():GetCharacterAgency():GetShipById(arg_21_1)
	local var_21_1 = IslandFollowerUnitVO.New(var_21_0.id, arg_21_1, var_21_0:GetModelUnit(), self:GetView():GetPlayerLastGroundedPosition(), Vector3(0, 0, 0), not (#self.sceneData.followUnits > 0))

	table.insert(self.sceneData.followUnits, var_21_1)
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, var_21_1)

	for iter_21_0, iter_21_1 in ipairs(self.sceneData.strollUnits) do
		if var_21_0:getConfig("unit_id") == iter_21_1.config.unit_id then
			self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_STROLL, iter_21_1.id)
		end
	end

	self:NotifiyCore(ISLAND_EVT.ADD_FOLLOWER, var_21_1.id)

	return
end

function IslandController:OnDelFollower(arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(self.sceneData.followUnits) do
		if iter_22_1.id == arg_22_1 then
			var_22_0 = iter_22_0

			break
		end
	end

	if var_22_0 <= 0 then
		return
	end

	local var_22_1 = table.remove(self.sceneData.followUnits, var_22_0)

	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_FOLLOW, var_22_1.id)

	if var_22_1:IsRandomizer() and #self.sceneData.followUnits > 0 then
		self.sceneData.followUnits[1]:ActiveRandomizer()
		self:NotifiyCore(ISLAND_EVT.RESET_FOLLOW_RANDOMIZER, self.sceneData.followUnits[1].id)
	end

	local var_22_2 = self:GetIsland():GetCharacterAgency():GetShipById(arg_22_1)

	for iter_22_2, iter_22_3 in ipairs(self.sceneData.strollUnits) do
		if var_22_2:getConfig("unit_id") == iter_22_3.config.unit_id then
			self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_22_3)
		end
	end

	self:NotifiyCore(ISLAND_EVT.DEL_FOLLOWER, var_22_1.id)

	return
end

function IslandController:OnResetNpcActionFeedback()
	for iter_23_0, iter_23_1 in ipairs(self.sceneData.strollUnits) do
		if iter_23_1:ExistGreetingActionFeedback() then
			iter_23_1:ClearGreetingActionFeedback()
			self:NotifiyCore(ISLAND_EVT.HIDE_NPC_ANIMATION_BUBBLE, iter_23_1)
		end
	end

	IslandDataConvertor.DistributeAward4StrollUnits(self.sceneData.strollUnits, self:GetIsland())
	self:InitStrollUnitsAwards()

	return
end

function IslandController:OnNpcActionFeedBackChange(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self.sceneData.strollUnits) do
		if iter_24_1.id == arg_24_1 and iter_24_1:ExistActionFeedback() then
			iter_24_1:ClearActionFeedback()
			self:NotifiyCore(ISLAND_EVT.HIDE_NPC_ANIMATION_BUBBLE, iter_24_1)
		end
	end

	return
end

function IslandController:OnShipSkillStateChange(arg_25_1, arg_25_2)
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(self.sceneData.strollUnits) do
		if iter_25_1:IsSameShip(arg_25_1) then
			var_25_0 = iter_25_1

			break
		end
	end

	if var_25_0 then
		if not arg_25_2 then
			var_25_0:ClearSkillActionFeedback()
			self:NotifiyCore(ISLAND_EVT.HIDE_NPC_ANIMATION_BUBBLE, var_25_0)
		else
			local var_25_1 = self:GetIsland()

			IslandDataConvertor.DistributeShipSkillAward4StrollUnits(self.sceneData.strollUnits, var_25_1, (IslandDataConvertor.GetOwnActions(var_25_1)))
			self:InitStrollUnitsAwards()
		end
	end

	return
end

function IslandController:OnLinkCore(arg_26_1, ...)
	self:NotifiyCore(arg_26_1, ...)

	return
end

function IslandController:OnActiveOrDisableUnit(arg_27_1, arg_27_2, arg_27_3)
	self:NotifiyCore(ISLAND_EVT.ACTIVE_OR_DISACTIVE_UNIT, arg_27_1, arg_27_2, arg_27_3)

	return
end

function IslandController:OnStartPathFinder(arg_28_1)
	self:NotifiyCore(ISLAND_EVT.GEN_PATH_FINDER, arg_28_1)

	return
end

function IslandController:OnEndPathFinder()
	self.visibilityAllocator:Flush()

	return
end

function IslandController:OnStartPerformance()
	self:NotifiyCore(ISLAND_EVT.START_STORY)
	self:NotifiyCore(ISLAND_EVT.START_PERFORMANCE)

	return
end

function IslandController:OnEndPerformance(arg_31_1)
	self:NotifiyCore(ISLAND_EVT.END_STORY)
	self:NotifiyCore(ISLAND_EVT.END_PERFORMANCE)

	if arg_31_1 then
		self:OnUpdateTask()
	end

	return
end

function IslandController:OnStartStory()
	self:NotifiyCore(ISLAND_EVT.START_STORY)

	return
end

function IslandController:OnEndStory(arg_33_1)
	self:NotifiyCore(ISLAND_EVT.END_STORY)

	if arg_33_1 then
		self.visibilityAllocator:Flush()
	end

	return
end

function IslandController:OnTaskAdd()
	self.visibilityAllocator:Flush()
	self:NotifiyCore(ISLAND_EVT.REFRESH_INTERACTION)
	self:NotifiyCore(ISLAND_EVT.REFRESH_TASK_HUD_INFO)

	return
end

function IslandController:OnFinishTask(arg_35_1)
	self.visibilityAllocator:Flush()
	self:NotifiyCore(ISLAND_EVT.REFRESH_INTERACTION)
	self:NotifiyCore(ISLAND_EVT.REFRESH_TASK_HUD_INFO)
	self:CheckFinishTask(arg_35_1, IslandTaskType.DAILY, "daily_task_follow_action")
	self:CheckFinishTask(arg_35_1, IslandTaskType.WEEKLY, "weekly_task_follow_action")

	return
end

local function var_0_1(arg_36_0)
	if #arg_36_0 == 0 then
		return nil
	end

	return arg_36_0[math.random(1, #arg_36_0)]
end

function IslandController:CheckFinishTask(arg_37_1, arg_37_2, arg_37_3)
	if IslandTask.New({
		id = arg_37_1,
		process_list = {}
	}):GetType() ~= arg_37_2 then
		return
	end

	local var_37_0 = pg.island_set[arg_37_3]

	if not pg.island_set[arg_37_3] then
		return
	end

	local var_37_1

	if var_37_0 then
		var_37_1 = var_37_0.key_value_varchar or {} or {}
	end

	local var_37_2 = self:GetSelfIsland():GetTaskAgency()

	for iter_37_0, iter_37_1 in ipairs((var_37_2:GetTasks())) do
		if iter_37_1:GetType() == arg_37_2 then
			return
		end
	end

	local var_37_3 = false

	for iter_37_2, iter_37_3 in ipairs((var_37_2:GetFinishedIds())) do
		if IslandTask.New({
			id = iter_37_3,
			process_list = {}
		}):GetType() == arg_37_2 then
			var_37_3 = true

			break
		end
	end

	if var_37_3 then
		self:NotifiyCore(ISLAND_EVT.ALL_DAILY_OR_WEEKLY_FINISH, var_0_1(var_37_1))
	end

	return
end

function IslandController:OnUpdateTask()
	self:Debounce("RefreshTask", function()
		if not self.visibilityAllocator then
			return
		end

		self.visibilityAllocator:Flush()
		self:NotifiyCore(ISLAND_EVT.REFRESH_INTERACTION)
		self:NotifiyCore(ISLAND_EVT.REFRESH_TASK_HUD_INFO)

		return
	end, 0.5, false)()

	return
end

function IslandController:Debounce(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	self.__debouncers = self.__debouncers or {}
	self.__debouncers[arg_40_1] = self.__debouncers[arg_40_1] or debounce(arg_40_2, arg_40_3, arg_40_4)

	return self.__debouncers[arg_40_1]
end

function IslandController:OnPlayerAdd(arg_41_1)
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, IslandDataConvertor.PlayerData2IslandUnit(arg_41_1.player, self.mapId, self:GetIsland().id), function(arg_42_0)
		self.islandSyncMgr:OnVisitorEnter(arg_41_1.player.id, arg_42_0)

		return
	end)

	return
end

function IslandController:OnPlayerExit(arg_43_1)
	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_PLAYER, arg_43_1.id)
	self.islandSyncMgr:OnVisitorExit(arg_43_1.id)

	return
end

function IslandController:OnPlayerMorphDress(...)
	self:NotifiyCore(ISLAND_EVT.MORPH_FORM_CHANGE, ...)

	return
end

function IslandController:OnPlayerChangeDress(arg_45_1, arg_45_2)
	self:NotifiyCore(ISLAND_EVT.CHANGE_DRESS, arg_45_1, arg_45_2)

	return
end

function IslandController:OnShipChangeDress(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	self:NotifiyCore(ISLAND_EVT.CHANGE_CHARACTER_DRESS, arg_46_1, arg_46_2, arg_46_3, arg_46_4)

	return
end

function IslandController:OnStartPlant(arg_47_1)
	local var_47_0

	for iter_47_0, iter_47_1 in ipairs(self.sceneData.productSystems) do
		if iter_47_1.id == arg_47_1.build_id then
			var_47_0 = iter_47_1

			break
		end
	end

	if not var_47_0 then
		return
	end

	local var_47_1 = var_47_0:GetUnitIdBySlotId(arg_47_1.area_id)

	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, var_47_1)
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (var_47_0:GenHandPlantUnitBySlotData(arg_47_1.area_id, arg_47_1.formula_id)))
	self:NotifiyCore(ISLAND_EVT.UPDATE_HUD, var_47_1)

	return
end

function IslandController:OnEndPlant(arg_48_1)
	local var_48_0

	for iter_48_0, iter_48_1 in ipairs(self.sceneData.productSystems) do
		if iter_48_1.id == arg_48_1.build_id then
			var_48_0 = iter_48_1

			break
		end
	end

	if not var_48_0 then
		return
	end

	local var_48_1 = var_48_0:GetUnitIdBySlotId(arg_48_1.area_id)

	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, var_48_1)
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (var_48_0:GenHandPlantUnitBySlotData(arg_48_1.area_id)))
	self:NotifiyCore(ISLAND_EVT.UPDATE_HUD, var_48_1)

	return
end

function IslandController:OnStartDelegation(arg_49_1)
	local var_49_0

	for iter_49_0, iter_49_1 in ipairs(self.sceneData.systemList) do
		if isa(iter_49_1, IslandCharacterSystemVO) and iter_49_1.id == arg_49_1.build_id then
			var_49_0 = iter_49_1

			break
		end
	end

	if not var_49_0 then
		return
	end

	local var_49_1

	for iter_49_2, iter_49_3 in ipairs(self.sceneData.productSystems) do
		if iter_49_3.id == arg_49_1.build_id then
			var_49_1 = iter_49_3

			break
		end
	end

	if table.contains(IslandProductConst.PlantPlaceIdLists, arg_49_1.build_id) then
		for iter_49_4, iter_49_5 in ipairs(pg.island_production_slot[arg_49_1.area_id].exclusion_slot) do
			local var_49_2 = var_49_1:GetUnitVOByUnitId((var_49_1:GetUnitIdBySlotId(iter_49_5)))

			if var_49_2 then
				var_49_2:ChangeSlotType(IslandProductConst.ProductSlotType.RoleDelegation)
			end
		end
	end

	local var_49_3 = {}

	if table.contains(IslandProductConst.havePerformPlace, arg_49_1.build_id) then
		local var_49_4 = var_49_1:GetDelegateUnitsByBuildIdAndSlotId(arg_49_1.build_id, arg_49_1.area_id, arg_49_1.formula_id)

		var_49_3.commissionSlotId = var_49_1:GetCommissionSlotId(arg_49_1.area_id)
		var_49_3.unitIds = {}

		for iter_49_6, iter_49_7 in ipairs(var_49_4) do
			table.insert(var_49_3.unitIds, iter_49_7.id)
		end

		for iter_49_8, iter_49_9 in ipairs(var_49_4) do
			self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_49_9)
		end
	end

	local var_49_5 = var_49_1:GetDelegateEffectsByCommissonId(arg_49_1.area_id)

	if var_49_5 then
		local var_49_6 = var_49_1:GenUnitByDelegateEffectId(var_49_5)

		if var_49_6 then
			self:NotifiyCore(ISLAND_EVT.GEN_UNIT, var_49_6)
		end
	end

	local var_49_7 = var_49_0:GetUnit(arg_49_1.ship_id, arg_49_1.area_id, true)

	if var_49_7 then
		self:NotifiyCore(ISLAND_EVT.GEN_UNIT, var_49_7)
	end

	self:NotifiyCore(ISLAND_EVT.START_DEGATION, arg_49_1, var_49_3)

	return
end

function IslandController:OnEndDelegation(arg_50_1)
	local var_50_0

	for iter_50_0, iter_50_1 in ipairs(self.sceneData.systemList) do
		if isa(iter_50_1, IslandCharacterSystemVO) and iter_50_1.id == arg_50_1.build_id then
			var_50_0 = iter_50_1

			break
		end
	end

	if not var_50_0 then
		return
	end

	self:NotifiyCore(ISLAND_EVT.END_DEGATION, arg_50_1)

	local var_50_1 = var_50_0:GetUnitShipIdBySlotId(arg_50_1.ship_id, arg_50_1.area_id)

	if var_50_1 then
		self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_DELEGATION, var_50_1)
	end

	local var_50_2

	for iter_50_2, iter_50_3 in ipairs(self.sceneData.productSystems) do
		if iter_50_3.id == arg_50_1.build_id then
			var_50_2 = iter_50_3

			break
		end
	end

	if table.contains(IslandProductConst.havePerformPlace, arg_50_1.build_id) then
		for iter_50_4, iter_50_5 in ipairs((var_50_2:GetDelegatUnitsBySlotId(arg_50_1.area_id))) do
			self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_DELEGATE_UNIT, iter_50_5)
		end
	end

	local var_50_3 = var_50_2:GetDelegateEffectsByCommissonId(arg_50_1.area_id)

	if var_50_3 then
		self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, var_50_3)
	end

	if arg_50_1.remainReward then
		return
	end

	if table.contains(IslandProductConst.PlantPlaceIdLists, arg_50_1.build_id) then
		for iter_50_6, iter_50_7 in ipairs(pg.island_production_slot[arg_50_1.area_id].exclusion_slot) do
			self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, (var_50_2:GetUnitIdBySlotId(iter_50_7)))
			self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (var_50_2:GenHandPlantUnitBySlotData(iter_50_7)))
		end
	end

	return
end

function IslandController:OnGetAllDelegationAward(arg_51_1)
	local var_51_0

	for iter_51_0, iter_51_1 in ipairs(self.sceneData.systemList) do
		if isa(iter_51_1, IslandCharacterSystemVO) and iter_51_1.id == arg_51_1.build_id then
			var_51_0 = iter_51_1

			break
		end
	end

	if not var_51_0 then
		return
	end

	local var_51_1

	for iter_51_2, iter_51_3 in ipairs(self.sceneData.productSystems) do
		if iter_51_3.id == arg_51_1.build_id then
			var_51_1 = iter_51_3

			break
		end
	end

	if arg_51_1.build_id ~= IslandProductConst.FarmlandPlaceId and arg_51_1.build_id ~= IslandProductConst.OrchardPlaceId then
		if arg_51_1.build_id == IslandProductConst.GardenPlaceId then
			for iter_51_4, iter_51_5 in ipairs(pg.island_production_slot[arg_51_1.area_id].exclusion_slot) do
				self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, (var_51_1:GetUnitIdBySlotId(iter_51_5)))
				self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (var_51_1:GenHandPlantUnitBySlotData(iter_51_5)))
			end
		end
	end

	return
end

function IslandController:OnChangeSlotModel(arg_52_1)
	local var_52_0

	for iter_52_0, iter_52_1 in ipairs(self.sceneData.productSystems) do
		if iter_52_1.id == IslandProductConst.FarmlandPlaceId then
			var_52_0 = iter_52_1

			break
		end
	end

	if not var_52_0 then
		return
	end

	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, arg_52_1.id)

	local var_52_1 = var_52_0:GetUnitVOByUnitId(arg_52_1.id)

	var_52_1.modelId = arg_52_1.modelId

	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, var_52_1)

	return
end

function IslandController:OnStartHandCollect(arg_53_1)
	local var_53_0

	for iter_53_0, iter_53_1 in ipairs(self.sceneData.productSystems) do
		if iter_53_1.id == arg_53_1.build_id then
			var_53_0 = iter_53_1

			break
		end
	end

	if not var_53_0 then
		return
	end

	local var_53_1 = var_53_0:GetUnitIdBySlotId(arg_53_1.area_id)

	self:NotifiyCore(ISLAND_EVT.UPDATE_UNIT_HAND_COLLECT, var_53_1)
	self:NotifiyCore(ISLAND_EVT.UPDATE_HUD, var_53_1)

	return
end

function IslandController:OnHandPlantSlotChangeUnit(arg_54_1)
	local var_54_0

	for iter_54_0, iter_54_1 in ipairs(self.sceneData.productSystems) do
		if iter_54_1.id == arg_54_1.build_id then
			var_54_0 = iter_54_1

			break
		end
	end

	if not var_54_0 then
		return
	end

	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, (var_54_0:GetUnitIdBySlotId(arg_54_1.slotId)))
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (var_54_0:GenHandPlantUnitBySlotData(arg_54_1.slotId)))

	return
end

function IslandController:OnProductPlaceChangeUnit(arg_55_1)
	local var_55_0

	for iter_55_0, iter_55_1 in ipairs(self.sceneData.productSystems) do
		if iter_55_1.id == arg_55_1.build_id then
			var_55_0 = iter_55_1

			break
		end
	end

	if not var_55_0 then
		return
	end

	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, (var_55_0:GetPlaceModelId(false)))
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (var_55_0:GetPlaceModelUnit(true)))

	return
end

function IslandController:OnRemoveWildGatherDone(arg_56_1)
	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, arg_56_1.unitId)
	self:NotifiyCore(ISLAND_EVT.LEAVE_UNIT, {
		id = arg_56_1.unitId
	})

	return
end

function IslandController:OnAddWildGatherDone(arg_57_1)
	self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (IslandDataConvertor.GenWildGatherUnit(arg_57_1)))

	return
end

function IslandController:OnCollectSlotUnitInit(arg_58_1)
	local var_58_0

	for iter_58_0, iter_58_1 in ipairs(self.sceneData.productSystems) do
		if iter_58_1.id == pg.island_production_slot[arg_58_1.slotId].place then
			var_58_0 = iter_58_1

			break
		end
	end

	if not var_58_0 then
		return
	end

	local var_58_1 = var_58_0:InitHandCollectSlotBySlotId(arg_58_1.slotId)

	if var_58_1 then
		self:NotifiyCore(ISLAND_EVT.GEN_UNIT, var_58_1)
	end

	return
end

function IslandController:OnCollectSlotUnitUpdate(arg_59_1)
	local var_59_0

	for iter_59_0, iter_59_1 in ipairs(self.sceneData.productSystems) do
		if iter_59_1.id == pg.island_production_slot[arg_59_1.slotId].place then
			var_59_0 = iter_59_1

			break
		end
	end

	if not var_59_0 then
		return
	end

	local var_59_1 = var_59_0:GetUnitIdBySlotId(arg_59_1.slotId)

	if var_59_1 then
		self:NotifiyCore(ISLAND_EVT.UPDATE_UNIT_HAND_COLLECT, var_59_1)
		self:NotifiyCore(ISLAND_EVT.UPDATE_HUD, var_59_1)
	end

	return
end

function IslandController:OnCollectSloSlotUnitRemove(arg_60_1)
	local var_60_0

	for iter_60_0, iter_60_1 in ipairs(self.sceneData.productSystems) do
		if iter_60_1.id == pg.island_production_slot[arg_60_1.slotId].place then
			var_60_0 = iter_60_1

			break
		end
	end

	if not var_60_0 then
		return
	end

	self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, (var_60_0:GetHandCollectSlotBySlotId(arg_60_1.slotId)))

	return
end

function IslandController:OnSyncDataUpdate(arg_61_1)
	self.islandSyncMgr:HandleSyncData(arg_61_1)

	return
end

function IslandController:OnSyncObjUpdate(arg_62_1)
	self.islandSyncMgr:HandleSyncObj(arg_62_1)

	return
end

function IslandController:Update()
	self.playerInputManager:Update()
	self.islandSyncMgr:Update()

	return
end

function IslandController:OnDispose()
	if self.playerInputManager then
		self.playerInputManager:Dispose()

		self.playerInputManager = nil
	end

	if self.islandSyncMgr then
		self.islandSyncMgr:Dispose()

		self.islandSyncMgr = nil
	end

	if self.strollAllocator then
		self.strollAllocator:Dispose()

		self.strollAllocator = nil
	end

	if self.visibilityAllocator then
		self.visibilityAllocator:Dispose()

		self.visibilityAllocator = nil
	end

	if self.giftAllocator then
		self.giftAllocator:Dispose()

		self.giftAllocator = nil
	end

	if self.timeDelayCreate then
		self.timeDelayCreate:Dispose()

		self.timeDelayCreate = nil
	end

	if self.activityNpcAllocator then
		self.activityNpcAllocator:Dispose()

		self.activityNpcAllocator = nil
	end

	self.__debouncers = nil

	return
end

function IslandController:OnAnimalInit(arg_65_1)
	local var_65_0

	for iter_65_0, iter_65_1 in ipairs(self.sceneData.productSystems) do
		if iter_65_1.id == IslandProductConst.PasturePlaceId then
			var_65_0 = iter_65_1

			break
		end
	end

	if not var_65_0 then
		return
	end

	local var_65_1 = arg_65_1.slotId

	for iter_65_2, iter_65_3 in ipairs(arg_65_1.aniList) do
		self:NotifiyCore(ISLAND_EVT.GEN_UNIT, (var_65_0:GenAnimalByAnialConfig(iter_65_3, var_65_1)))
	end

	return
end

function IslandController:OnSlotDelegateInit(arg_66_1)
	local var_66_0

	for iter_66_0, iter_66_1 in ipairs(self.sceneData.productSystems) do
		if iter_66_1.id == pg.island_production_slot[arg_66_1.slotId].place then
			var_66_0 = iter_66_1

			break
		end
	end

	if not var_66_0 then
		return
	end

	local var_66_1 = pg.island_production_commission[var_66_0:GetCommissionSlotId(arg_66_1.slotId)].unlockObjid

	if var_66_1 ~= 0 then
		self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, var_66_1)
	end

	return
end

function IslandController:IsPlayerInTimeline()
	return self.islandSyncMgr.player:InTimeline()
end

function IslandController:InitSyncMgr()
	self.islandSyncMgr:Init(self.sceneData.unitList)

	return
end

function IslandController:SetVisitorSyncData(arg_69_1, arg_69_2)
	self:NotifiyCore(ISLAND_EVT.SET_VISITOR_SYNC_DATA, arg_69_1, arg_69_2)

	return
end

function IslandController:WorldObjectInterAction(arg_70_1, arg_70_2, arg_70_3)
	arg_70_3 = arg_70_3 or 1

	local var_70_0 = _.detect(self.sceneData.unitList, function(arg_71_0)
		return arg_71_0.id == arg_70_1
	end)

	if not var_70_0 or not var_70_0:Interactable() then
		return
	end

	local var_70_1 = var_70_0:GetEmptySlot()

	if not var_70_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_interact_point"))

		return
	end

	local function var_70_2()
		var_70_1:Lock(arg_70_2)
		self:NotifiyCore(ISLAND_EVT.WORLD_OBJECT_START_INTERACTION, var_70_0, var_70_1, arg_70_3)

		return
	end

	self.islandSyncMgr:TryControlUnit(IslandConst.SYNC_TYPE_UNIT_STATIC, arg_70_1, var_70_1.id, arg_70_3, function(arg_73_0)
		if arg_73_0 then
			var_70_2()
		end

		return
	end)

	return
end

function IslandController:WorldObjectInterActionSync(arg_74_1, arg_74_2, arg_74_3, arg_74_4)
	arg_74_3 = arg_74_3 or 1

	local var_74_0 = _.detect(self.sceneData.unitList, function(arg_75_0)
		return arg_75_0.id == arg_74_1
	end)

	if not var_74_0 or not var_74_0:Interactable() then
		return
	end

	local var_74_1 = var_74_0:GetSlotById(arg_74_4)

	var_74_1:Lock(arg_74_2)
	self:NotifiyCore(ISLAND_EVT.WORLD_OBJECT_START_INTERACTION, var_74_0, var_74_1, arg_74_3)

	return
end

function IslandController:WorldObjectInterActionEnd(arg_76_1, arg_76_2)
	local var_76_0 = _.detect(self.sceneData.unitList, function(arg_77_0)
		return arg_77_0.id == arg_76_1
	end)

	if not var_76_0 or not var_76_0:Interactable() then
		return
	end

	local var_76_1 = var_76_0:GetUsingSlot(arg_76_2)

	local function var_76_2()
		var_76_1:Release()
		self:NotifiyCore(ISLAND_EVT.WORLD_OBJECT_END_INTERACTION, var_76_0, (Clone(var_76_1)))

		return
	end

	self.islandSyncMgr:EndControlUnit(IslandConst.SYNC_TYPE_UNIT_STATIC, arg_76_1, var_76_1.id, function(arg_79_0)
		if arg_79_0 then
			var_76_2()
		end

		return
	end)

	return
end

function IslandController:WorldObjectInterActionEndSync(arg_80_1, arg_80_2)
	local var_80_0 = _.detect(self.sceneData.unitList, function(arg_81_0)
		return arg_81_0.id == arg_80_1
	end)

	if not var_80_0 or not var_80_0:Interactable() then
		return
	end

	local var_80_1 = var_80_0:GetUsingSlot(arg_80_2)

	var_80_1:Release()
	self:NotifiyCore(ISLAND_EVT.WORLD_OBJECT_END_INTERACTION, var_80_0, (Clone(var_80_1)))

	return
end

function IslandController:WorldObjectInitStatus(arg_82_1, arg_82_2)
	local var_82_0 = _.detect(self.sceneData.unitList, function(arg_83_0)
		return arg_83_0.id == arg_82_1
	end)

	warning("init", arg_82_1, arg_82_2, var_82_0)

	if not var_82_0 or not var_82_0:Interactable() then
		return
	end

	self:NotifiyCore(ISLAND_EVT.WORLD_OBJECT_INIT_STATUS, var_82_0, arg_82_2)

	return
end

function IslandController:OnOpenRestaurant(arg_84_1)
	local var_84_0

	for iter_84_0, iter_84_1 in ipairs(self.sceneData.systemList) do
		if isa(iter_84_1, IslandManageSystemVO) and iter_84_1.id == arg_84_1.restId then
			var_84_0 = iter_84_1

			break
		end
	end

	if not var_84_0 then
		return
	end

	for iter_84_2, iter_84_3 in ipairs((var_84_0:GetUnits(arg_84_1.postList))) do
		self:NotifiyCore(ISLAND_EVT.GEN_UNIT, iter_84_3)
	end

	self:NotifiyCore(ISLAND_EVT.START_MANAGE, var_84_0)

	return
end

function IslandController:OnCloseRestaurant(arg_85_1)
	local var_85_0

	for iter_85_0, iter_85_1 in ipairs(self.sceneData.systemList) do
		if isa(iter_85_1, IslandManageSystemVO) and iter_85_1.id == arg_85_1.restId then
			var_85_0 = iter_85_1

			break
		end
	end

	if not var_85_0 then
		return
	end

	self:NotifiyCore(ISLAND_EVT.END_MANAGE, var_85_0)

	for iter_85_2, iter_85_3 in ipairs((var_85_0:GetUnits(arg_85_1.postList))) do
		self:NotifiyCore(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_MANAGE, iter_85_3.id)
	end

	return
end

function IslandController:OnSwitchMap()
	if self.islandSyncMgr and self.islandSyncMgr:IsPlayerInTimeline() then
		self:NotifiyCore(ISLAND_EVT.INIT_INTERACTION_OP_VIEW)
	end

	return
end

return IslandController
