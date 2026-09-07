local IslandPlayerDataMonitor = class("IslandPlayerDataMonitor", import(".IslandBaseMonitor"))

function IslandPlayerDataMonitor:register()
	self:on(21206, function(arg_2_0)
		if not self:IsCurrentIsland(arg_2_0.island_id) then
			return
		end

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.player_list) do
			self:HandlePlayerData(iter_2_1)
		end

		return
	end)
	self:on(21309, function(arg_3_0)
		if not self:IsCurrentIsland(arg_3_0.island_id) then
			return
		end

		self:HandleAgoraData(arg_3_0.update_data)

		return
	end)
	self:on(21407, function(arg_4_0)
		if not self:IsCurrentIsland(arg_4_0.island_id) then
			return
		end

		self:HandleOrderData(arg_4_0.order_info)

		return
	end)
	self:on(21040, function(arg_5_0)
		self:HandleTaskData(arg_5_0.task_list)

		return
	end)
	self:on(21043, function(arg_6_0)
		self:HandleRandomTaskData(arg_6_0)

		return
	end)
	self:on(21422, function(arg_7_0)
		self:HandleManageData(arg_7_0)

		return
	end)
	self:on(21053, function(arg_8_0)
		self:HandleAchievementData(arg_8_0.event_list)

		return
	end)
	self:on(21342, function(arg_9_0)
		self:HandleBookData(arg_9_0.item_list)

		return
	end)
	self:on(21518, function(arg_10_0)
		self:HandleSlotFormulaData(arg_10_0)
		getProxy(IslandProxy):GetIsland():GetBuildingAgency():AddFormulaNum(arg_10_0.formula_id, arg_10_0.comb_num)

		return
	end)
	self:on(21519, function(arg_11_0)
		self:HandleBuildUnlockData(arg_11_0)

		return
	end)
	self:on(21515, function(arg_12_0)
		self:HandleHandSlotUnlockData(arg_12_0)

		return
	end)
	self:on(21314, function(arg_13_0)
		self:HandleSignInNotify(arg_13_0)
		getProxy(IslandProxy):UpdateGiftTagCache(arg_13_0.island_id, arg_13_0.gift_count, arg_13_0.gift_timestamp)

		if not self:IsCurrentIsland(arg_13_0.island_id) then
			return
		end

		self:HandleSignInData(arg_13_0)

		return
	end)
	self:on(21528, function(arg_14_0)
		if not self:IsCurrentIsland(arg_14_0.island_id) then
			return
		end

		self:HandleWildGatherInData(arg_14_0)

		return
	end)
	self:on(21535, function(arg_15_0)
		if not self:IsCurrentIsland(arg_15_0.island_id) then
			return
		end

		self:HandleWildCollectInData(arg_15_0)

		return
	end)
	self:on(21227, function(arg_16_0)
		if not self:IsCurrentIsland(arg_16_0.island_id) then
			return
		end

		self:HandleAbilityData(arg_16_0)

		return
	end)
	self:on(21225, function(arg_17_0)
		if not self:IsCurrentIsland(arg_17_0.island_id) then
			return
		end

		self:SyncStartManage(arg_17_0)

		return
	end)
	self:on(21220, function(arg_18_0)
		if not self:IsCurrentIsland(arg_18_0.island_id) then
			return
		end

		self:SyncStartDelegation(arg_18_0)

		return
	end)
	self:on(21226, function(arg_19_0)
		if not self:IsCurrentIsland(arg_19_0.island_id) then
			return
		end

		self:SyncEndDelegation(arg_19_0)

		return
	end)
	self:on(21222, function(arg_20_0)
		if not self:IsCurrentIsland(arg_20_0.island_id) then
			return
		end

		self:SyncResetSlotData(arg_20_0)

		return
	end)
	self:on(21221, function(arg_21_0)
		if not self:IsCurrentIsland(arg_21_0.island_id) then
			return
		end

		self:SyncStarthHandPlant(arg_21_0)

		return
	end)
	self:on(21701, function(arg_22_0)
		self:ResponeAniamtion(arg_22_0)

		return
	end)
	self:on(21325, function(arg_23_0)
		self:AddChatMsg(arg_23_0)

		return
	end)
	self:on(21228, function(arg_24_0)
		if not self:IsCurrentIsland(arg_24_0.island_id) then
			return
		end

		self:UpdateActivityNpc(arg_24_0)

		return
	end)
	self:on(21224, function(arg_25_0)
		if not self:IsCurrentIsland(arg_25_0.island_id) then
			return
		end

		self:UpdatePlayerDressupData(arg_25_0)

		return
	end)
	self:on(21232, function(arg_26_0)
		if not self:IsCurrentIsland(arg_26_0.island_id) then
			return
		end

		self:HandFishingStart(arg_26_0)

		return
	end)
	self:on(21233, function(arg_27_0)
		if not self:IsCurrentIsland(arg_27_0.island_id) then
			return
		end

		self:HandFishingStateChange(arg_27_0)

		return
	end)
	self:on(21242, function(arg_28_0)
		if not self:IsCurrentIsland(arg_28_0.island_id) then
			return
		end

		self:UpdateTradePrice(arg_28_0)

		return
	end)
	self:on(21247, function(arg_29_0)
		self:HandleTradeNotify(arg_29_0)

		return
	end)

	return
end

function IslandPlayerDataMonitor:HandFishingStart(arg_30_1)
	self:emitCore(ISLAND_EVT.START_FISHING, {
		unitId = arg_30_1.user_id,
		fishPointId = arg_30_1.point_id,
		rodId = arg_30_1.rod_id,
		fishId = arg_30_1.fish_id
	})

	return
end

function IslandPlayerDataMonitor:HandFishingStateChange(arg_31_1)
	self:emitCore(ISLAND_EVT.FISHING_STATE_CHANGE, {
		unitId = arg_31_1.user_id,
		fishPointId = arg_31_1.point_id,
		op = arg_31_1.type
	})

	return
end

function IslandPlayerDataMonitor:UpdateTradePrice(arg_32_1)
	self:GetIsland():GetTradeAgency():UpdateTodayPrice(arg_32_1.today_price.timestamp, arg_32_1.today_price.price)

	return
end

function IslandPlayerDataMonitor:HandleAgoraData(arg_33_1)
	if getProxy(IslandProxy):GetIsland().id == self:GetIsland().id then
		return
	end

	self:GetIsland():GetAgoraAgency():UpdatePlacedData(arg_33_1)

	return
end

function IslandPlayerDataMonitor:HandlePlayerData(arg_34_1)
	warning("HandlePlayerData>>>>>>>>>", arg_34_1.state, arg_34_1.map_id, arg_34_1.id)

	if arg_34_1.state == IslandConst.PLAYER_DATA_STATE_EMPTY then
		self:UpdatePlayerData(arg_34_1)
	elseif arg_34_1.state == IslandConst.PLAYER_DATA_STATE_ENTER then
		self:HandlePlayerEnter(arg_34_1)
	elseif arg_34_1.state == IslandConst.PLAYER_DATA_STATE_EXIT then
		self:HandlePlayerExit(arg_34_1.id)
	end

	return
end

function IslandPlayerDataMonitor:HandlePlayerExit(arg_35_1)
	if self:GetIsland():GetVisitorAgency():GetPlayerList()[arg_35_1] then
		self:GetIsland():GetVisitorAgency():DeletePlayer(arg_35_1)
	end

	if self:GetIsland():GetVisitorAgency():GetMapVisitorList()[arg_35_1] then
		self:GetIsland():GetVisitorAgency():DeleteMapVisitor(arg_35_1)
	end

	return
end

function IslandPlayerDataMonitor:HandlePlayerEnter(arg_36_1)
	if not self:GetIsland():GetVisitorAgency():GetPlayerList()[arg_36_1.id] then
		local var_36_0 = IslandPlayer.New(arg_36_1)

		self:GetIsland():GetVisitorAgency():AddPlayer(var_36_0)

		if var_36_0:IsInMap(self:GetIsland():GetMapId()) then
			self:GetIsland():GetVisitorAgency():AddMapVisitor(var_36_0)
		end
	end

	return
end

function IslandPlayerDataMonitor:UpdatePlayerData(arg_37_1)
	local var_37_0 = self:GetIsland():GetVisitorAgency():GetPlayerList()[arg_37_1.id]

	if var_37_0 then
		var_37_0:Flush(arg_37_1)
	end

	local var_37_1

	if var_37_0 then
		::label_37_0::

		var_37_1 = var_37_0:IsInMap(self:GetIsland():GetMapId())
	end

	local var_37_2 = self:GetIsland():GetVisitorAgency():GetMapVisitorList()[arg_37_1.id]

	if var_37_1 and not var_37_2 then
		self:GetIsland():GetVisitorAgency():AddMapVisitor(var_37_0)
	elseif not var_37_1 and var_37_2 then
		self:GetIsland():GetVisitorAgency():DeleteMapVisitor(arg_37_1.id)
	elseif var_37_1 and var_37_2 then
		var_37_2:Flush(arg_37_1)
	end

	return
end

function IslandPlayerDataMonitor:HandleOrderData(arg_38_1)
	self:GetIsland():GetOrderAgency():UpdateOrAddOrder(arg_38_1)

	return
end

function IslandPlayerDataMonitor:HandleTaskData(arg_39_1)
	local var_39_0 = self:GetIsland():GetTaskAgency()

	for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
		local var_39_1 = IslandTask.New(iter_39_1)

		if underscore.all(iter_39_1.process_list, function(arg_40_0)
			return arg_40_0.target_count == 0
		end) then
			var_39_0:AddTask(var_39_1)
		else
			var_39_0:UpdateTask(var_39_1)
		end
	end

	return
end

function IslandPlayerDataMonitor:HandleRandomTaskData(arg_41_1)
	self:GetIsland():GetTaskAgency():InitFutureTasks(arg_41_1.task_list_random or {})

	local var_41_1 = arg_41_1.task_list or {}
	local var_41_2 = self:GetIsland():GetTaskAgency()

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		var_41_2:AddTask((IslandTask.New(iter_41_1)))
	end

	if #var_41_1 > 0 then
		var_41_2:TryAutoTrackTask()
	end

	return
end

function IslandPlayerDataMonitor:HandleManageData(arg_42_1)
	local var_42_0 = getProxy(IslandProxy):GetIsland():GetManageAgency()

	if arg_42_1.type == 1 then
		var_42_0:DailyRefresh(arg_42_1)
	elseif arg_42_1.type == 2 then
		var_42_0:UnlockDailyEvent(arg_42_1)
	end

	return
end

function IslandPlayerDataMonitor:SyncStartManage(arg_43_1)
	local var_43_0 = getProxy(IslandProxy):GetIsland()
	local var_43_1 = var_43_0:GetManageAgency()
	local var_43_2 = var_43_1:GetRestaurant(arg_43_1.trade.id)

	if not var_43_0 then
		var_43_1:UnlockNewRestaurant(arg_43_1.trade.id)

		var_43_2 = var_43_1:GetRestaurant(arg_43_1.trade.id)
	end

	var_43_2:UpdateData(arg_43_1.trade)
	getProxy(IslandProxy):GetSharedIsland():DispatchEvent(IslandOpenRestaurantCommand.OPEN_RESTAURANT, {
		restId = var_43_2.id,
		postList = arg_43_1.trade.post_list
	})

	return
end

function IslandPlayerDataMonitor:HandleAchievementData(arg_44_1)
	local var_44_0 = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		var_44_0:UpdateRecord(iter_44_1.event_type, iter_44_1.event_arg, iter_44_1.value)
	end

	return
end

function IslandPlayerDataMonitor:HandleBookData(arg_45_1)
	getProxy(IslandProxy):GetIsland():GetBookAgency():HandlePushData(arg_45_1)

	return
end

function IslandPlayerDataMonitor:HandleSlotFormulaData(arg_46_1)
	getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(pg.island_production_slot[arg_46_1.area_id].place):GetDelegationSlotData(arg_46_1.area_id):AddFormulaNum(arg_46_1)

	return
end

function IslandPlayerDataMonitor:HandleBuildUnlockData(arg_47_1)
	getProxy(IslandProxy):GetIsland():GetBuildingAgency():InitBuildData(arg_47_1.build)

	return
end

function IslandPlayerDataMonitor:HandleHandSlotUnlockData(arg_48_1)
	getProxy(IslandProxy):GetIsland():GetBuildingAgency():InitHandSlotData(arg_48_1.collect)

	return
end

function IslandPlayerDataMonitor:HandleSignInData(arg_49_1)
	local var_49_0 = self:GetIsland():GetSignInAgency()

	var_49_0:UpdateGiftEndTime(arg_49_1.gift_timestamp)
	var_49_0:UpdateFetchedList(arg_49_1.gift_visitor)
	var_49_0:SetGiftCnt(arg_49_1.gift_count)

	return
end

function IslandPlayerDataMonitor:HandleTradeNotify(arg_50_1)
	local var_50_0 = getProxy(FriendProxy):getFriend(arg_50_1.island_id)
	local var_50_1 = var_50_0 and var_50_0:GetName() or ""
	local var_50_2 = {
		id = arg_50_1.island_id,
		cmd = IslandConst.VISITOR_LOG_CMD_TRADE,
		name = var_50_1
	}

	var_50_2.time = pg.TimeMgr.GetInstance():GetServerTime()
	var_50_2.mapId = arg_50_1.map_id
	var_50_2.extraInfo = arg_50_1.price

	local var_50_3 = IslandVisitorLog.New(var_50_2)
	local var_50_4 = var_50_3:BuildWhitoutTime()

	if not var_50_4 or var_50_4 == "" then
		return
	end

	pg.IslandVisitorNotificationMgr.GetInstance():Enqueue(var_50_3)

	return
end

function IslandPlayerDataMonitor:HandleSignInNotify(arg_51_1)
	if arg_51_1.cmd == 2 then
		local var_51_0 = getProxy(FriendProxy):getFriend(arg_51_1.island_id)
		local var_51_1 = var_51_0 and var_51_0:GetName() or ""
		local var_51_2 = {
			id = arg_51_1.island_id,
			cmd = IslandConst.VISITOR_LOG_CMD_GIFT,
			name = var_51_1
		}

		var_51_2.time = pg.TimeMgr.GetInstance():GetServerTime()

		if self:IsCurrentIsland(arg_51_1.island_id) then
			self:GetIsland():GetSignInAgency():AddInviter(getProxy(PlayerProxy):getRawData().id)
		end

		pg.IslandVisitorNotificationMgr.GetInstance():Enqueue((IslandVisitorLog.New(var_51_2)))
	end

	return
end

function IslandPlayerDataMonitor:HandleWildGatherInData(arg_52_1)
	self:GetIsland():GetWildCollectAgency():UpdateGatherData(arg_52_1)

	return
end

function IslandPlayerDataMonitor:HandleWildCollectInData(arg_53_1)
	self:GetIsland():GetWildCollectAgency():UpdateCollectFragmentData(arg_53_1)

	return
end

function IslandPlayerDataMonitor:HandleAbilityData(arg_54_1)
	local var_54_0 = getProxy(IslandProxy):GetSharedIsland()

	if not var_54_0 then
		return
	end

	var_54_0:GetAblityAgency():AddAblity(arg_54_1.ability_id)

	return
end

function IslandPlayerDataMonitor:SyncStartDelegation(arg_55_1)
	local var_55_0 = self:GetIsland()

	var_55_0:GetBuildingAgency():GetBuilding(pg.island_production_slot[arg_55_1.appoint_data.id].place):UpdateDeleationRoleDataBySlotId(arg_55_1.appoint_data.id, arg_55_1.appoint_data)
	var_55_0:DispatchEvent(IslandStartDelegationCommand.START_DELEGATION, {
		build_id = pg.island_production_slot[arg_55_1.appoint_data.id].place,
		ship_id = arg_55_1.appoint_data.ship_id,
		area_id = arg_55_1.appoint_data.id,
		formula_id = arg_55_1.appoint_data.formula_id
	})

	return
end

function IslandPlayerDataMonitor:SyncEndDelegation(arg_56_1)
	local var_56_0 = island:GetBuildingAgency():GetBuilding(self.buildId)

	var_56_0:UpdateDeleationRewardDataBySlotId(self.id, {
		formula_id = self.islandRoleDelegationData.formula_id
	})
	var_56_0:UpdateDeleationRoleDataBySlotId(self.id, nil)
	self:GetIsland():DispatchEvent(IslandFinishDelegationCommand.END_DELEGATION, {
		remainReward = true,
		build_id = build_id,
		ship_id = self.islandRoleDelegationData.ship_id,
		area_id = self.id
	})

	return
end

function IslandPlayerDataMonitor:SyncResetSlotData(arg_57_1)
	local var_57_0 = self:GetIsland()
	local var_57_1 = var_57_0:GetBuildingAgency()

	for iter_57_0, iter_57_1 in ipairs(arg_57_1.slot_list) do
		local var_57_2 = var_57_1:GetBuilding(pg.island_production_slot[iter_57_1].place)

		if pg.island_production_slot[iter_57_1].type == 9 or pg.island_production_slot[iter_57_1].type == 3 then
			local var_57_3 = var_57_2:GetDelegationSlotData(iter_57_1)
			local var_57_4 = var_57_3 and var_57_3:GetSlotRoleData()

			if var_57_4 then
				var_57_2:UpdateDeleationRoleDataBySlotId(iter_57_1, nil)
				var_57_0:DispatchEvent(IslandFinishDelegationCommand.END_DELEGATION, {
					remainReward = false,
					build_id = pg.island_production_slot[iter_57_1].place,
					ship_id = var_57_4.ship_id,
					area_id = iter_57_1
				})
			end

			var_57_2:UpdateDeleationRewardDataBySlotId(iter_57_1, nil)
			var_57_0:DispatchEvent(IslandBuildingAgency.SLOT_RESET_DELEGATION_STATE_DONE, {
				build_id = pg.island_production_slot[iter_57_1].place,
				area_id = iter_57_1
			})
		elseif pg.island_production_slot[iter_57_1].type == 1 then
			var_57_2:UpdateHandPlantDataBySlotId({
				formula_id = 0,
				end_time = 0,
				state = 0,
				id = iter_57_1
			})
			var_57_0:DispatchEvent(IslandSlotHandPlantAwardCommand.START_HANDPLANT_AWARD_DONE, {
				build_id = pg.island_production_slot[iter_57_1].place,
				area_id = iter_57_1
			})
		end
	end

	return
end

function IslandPlayerDataMonitor:SyncStarthHandPlant(arg_58_1)
	local var_58_0 = self:GetIsland()
	local var_58_1 = var_58_0:GetBuildingAgency()

	for iter_58_0, iter_58_1 in ipairs(arg_58_1.hand_list) do
		var_58_1:GetBuilding(pg.island_production_slot[iter_58_1.id].place):UpdateHandPlantDataBySlotId(iter_58_1)
		var_58_0:DispatchEvent(IslandSlotHandPlantCommand.START_HANDPLANT_DONE, {
			build_id = pg.island_production_slot[iter_58_1.id].place,
			area_id = iter_58_1.id,
			formula_id = iter_58_1.formula_id
		})
	end

	return
end

function IslandPlayerDataMonitor:ResponeAniamtion(arg_59_1)
	self:GetIsland():DispatchEvent(IslandProxy.LINK_CORE, ISLAND_EVT.RESPON_ANIMATION_OP, {
		id = arg_59_1.player_id,
		targetId = arg_59_1.target_id,
		actionId = arg_59_1.action_id
	})

	return
end

function IslandPlayerDataMonitor:AddChatMsg(arg_60_1)
	local var_60_0 = getProxy(PlayerProxy):getRawData()
	local var_60_1 = arg_60_1.user_id == var_60_0.id and var_60_0 or self:GetIsland():GetVisitorAgency():GetPlayer(arg_60_1.user_id)

	if not var_60_1 then
		return
	end

	getProxy(IslandProxy):AddChatMsg(arg_60_1.island_id, (ChatMsg.New(ChatConst.ChannelIsland, (ChatProxy.InjectPublicMsg(arg_60_1.content, Clone(var_60_1))))))

	return
end

function IslandPlayerDataMonitor:UpdateActivityNpc(arg_61_1)
	local var_61_0 = self:GetIsland():GetActivityNpcAgency()

	for iter_61_0, iter_61_1 in ipairs(arg_61_1.refresh_list) do
		local var_61_1 = {
			id = iter_61_1.id,
			object_id = iter_61_1.object_id
		}

		if iter_61_1.type == IslandConst.ACTIVITY_NPC_OP_TYPE_UPDATE then
			var_61_0:UpdateNpc(var_61_1)
		elseif iter_61_1.type == IslandConst.ACTIVITY_NPC_OP_TYPE_ADD then
			var_61_0:AddNpc(var_61_1)
		elseif iter_61_1.type == IslandConst.ACTIVITY_NPC_OP_TYPE_DEL then
			var_61_0:RemoveNpc(var_61_1)
		end
	end

	return
end

function IslandPlayerDataMonitor:UpdatePlayerDressupData(arg_62_1)
	local var_62_0 = self:GetIsland()
	local var_62_1 = var_62_0:GetVisitorAgency():GetPlayer(arg_62_1.user_id)

	if not var_62_1 then
		return
	end

	local var_62_2 = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_1.dress_list) do
		local var_62_3 = 0

		for iter_62_2, iter_62_3 in ipairs(arg_62_1.dress_color or {}) do
			if iter_62_3.id == iter_62_1.id then
				var_62_3 = iter_62_3.color
			end
		end

		local var_62_4 = var_62_1:GetDressByType(iter_62_1.type)

		if var_62_4 ~= iter_62_1.id then
			var_62_2[iter_62_1.type] = {
				changeedDressId = iter_62_1.id,
				changedDressColorId = var_62_3
			}
		elseif var_62_1:GetCurrentColorByDressId(var_62_4) ~= var_62_3 then
			var_62_2[iter_62_1.type] = {
				changedDressColorId = var_62_3
			}
		end
	end

	var_62_0:DispatchEvent(IslandProxy.LINK_CORE, ISLAND_EVT.CHANGE_VISTER_DRESS, {
		id = arg_62_1.user_id,
		changeDressData = var_62_2
	})
	var_62_1:ChangeDressupData(arg_62_1.dress_list, arg_62_1.dress_color)

	return
end

return IslandPlayerDataMonitor
