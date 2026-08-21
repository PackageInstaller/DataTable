local var_0_0 = class("IslandPlayerDataMonitor", import(".IslandBaseMonitor"))

function var_0_0.register(arg_1_0)
	arg_1_0:on(21206, function(arg_2_0)
		if not arg_1_0:IsCurrentIsland(arg_2_0.island_id) then
			return
		end

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.player_list) do
			arg_1_0:HandlePlayerData(iter_2_1)
		end

		return
	end)
	arg_1_0:on(21309, function(arg_3_0)
		if not arg_1_0:IsCurrentIsland(arg_3_0.island_id) then
			return
		end

		arg_1_0:HandleAgoraData(arg_3_0.update_data)

		return
	end)
	arg_1_0:on(21407, function(arg_4_0)
		if not arg_1_0:IsCurrentIsland(arg_4_0.island_id) then
			return
		end

		arg_1_0:HandleOrderData(arg_4_0.order_info)

		return
	end)
	arg_1_0:on(21040, function(arg_5_0)
		arg_1_0:HandleTaskData(arg_5_0.task_list)

		return
	end)
	arg_1_0:on(21043, function(arg_6_0)
		arg_1_0:HandleRandomTaskData(arg_6_0)

		return
	end)
	arg_1_0:on(21422, function(arg_7_0)
		arg_1_0:HandleManageData(arg_7_0)

		return
	end)
	arg_1_0:on(21053, function(arg_8_0)
		arg_1_0:HandleAchievementData(arg_8_0.event_list)

		return
	end)
	arg_1_0:on(21342, function(arg_9_0)
		arg_1_0:HandleBookData(arg_9_0.item_list)

		return
	end)
	arg_1_0:on(21518, function(arg_10_0)
		arg_1_0:HandleSlotFormulaData(arg_10_0)
		getProxy(IslandProxy):GetIsland():GetBuildingAgency():AddFormulaNum(arg_10_0.formula_id, arg_10_0.comb_num)

		return
	end)
	arg_1_0:on(21519, function(arg_11_0)
		arg_1_0:HandleBuildUnlockData(arg_11_0)

		return
	end)
	arg_1_0:on(21515, function(arg_12_0)
		arg_1_0:HandleHandSlotUnlockData(arg_12_0)

		return
	end)
	arg_1_0:on(21314, function(arg_13_0)
		arg_1_0:HandleSignInNotify(arg_13_0)
		getProxy(IslandProxy):UpdateGiftTagCache(arg_13_0.island_id, arg_13_0.gift_count, arg_13_0.gift_timestamp)

		if not arg_1_0:IsCurrentIsland(arg_13_0.island_id) then
			return
		end

		arg_1_0:HandleSignInData(arg_13_0)

		return
	end)
	arg_1_0:on(21528, function(arg_14_0)
		if not arg_1_0:IsCurrentIsland(arg_14_0.island_id) then
			return
		end

		arg_1_0:HandleWildGatherInData(arg_14_0)

		return
	end)
	arg_1_0:on(21535, function(arg_15_0)
		if not arg_1_0:IsCurrentIsland(arg_15_0.island_id) then
			return
		end

		arg_1_0:HandleWildCollectInData(arg_15_0)

		return
	end)
	arg_1_0:on(21227, function(arg_16_0)
		if not arg_1_0:IsCurrentIsland(arg_16_0.island_id) then
			return
		end

		arg_1_0:HandleAbilityData(arg_16_0)

		return
	end)
	arg_1_0:on(21225, function(arg_17_0)
		if not arg_1_0:IsCurrentIsland(arg_17_0.island_id) then
			return
		end

		arg_1_0:SyncStartManage(arg_17_0)

		return
	end)
	arg_1_0:on(21220, function(arg_18_0)
		if not arg_1_0:IsCurrentIsland(arg_18_0.island_id) then
			return
		end

		arg_1_0:SyncStartDelegation(arg_18_0)

		return
	end)
	arg_1_0:on(21226, function(arg_19_0)
		if not arg_1_0:IsCurrentIsland(arg_19_0.island_id) then
			return
		end

		arg_1_0:SyncEndDelegation(arg_19_0)

		return
	end)
	arg_1_0:on(21222, function(arg_20_0)
		if not arg_1_0:IsCurrentIsland(arg_20_0.island_id) then
			return
		end

		arg_1_0:SyncResetSlotData(arg_20_0)

		return
	end)
	arg_1_0:on(21221, function(arg_21_0)
		if not arg_1_0:IsCurrentIsland(arg_21_0.island_id) then
			return
		end

		arg_1_0:SyncStarthHandPlant(arg_21_0)

		return
	end)
	arg_1_0:on(21701, function(arg_22_0)
		arg_1_0:ResponeAniamtion(arg_22_0)

		return
	end)
	arg_1_0:on(21325, function(arg_23_0)
		arg_1_0:AddChatMsg(arg_23_0)

		return
	end)
	arg_1_0:on(21228, function(arg_24_0)
		if not arg_1_0:IsCurrentIsland(arg_24_0.island_id) then
			return
		end

		arg_1_0:UpdateActivityNpc(arg_24_0)

		return
	end)
	arg_1_0:on(21224, function(arg_25_0)
		if not arg_1_0:IsCurrentIsland(arg_25_0.island_id) then
			return
		end

		arg_1_0:UpdatePlayerDressupData(arg_25_0)

		return
	end)
	arg_1_0:on(21232, function(arg_26_0)
		if not arg_1_0:IsCurrentIsland(arg_26_0.island_id) then
			return
		end

		arg_1_0:HandFishingStart(arg_26_0)

		return
	end)
	arg_1_0:on(21233, function(arg_27_0)
		if not arg_1_0:IsCurrentIsland(arg_27_0.island_id) then
			return
		end

		arg_1_0:HandFishingStateChange(arg_27_0)

		return
	end)
	arg_1_0:on(21242, function(arg_28_0)
		if not arg_1_0:IsCurrentIsland(arg_28_0.island_id) then
			return
		end

		arg_1_0:UpdateTradePrice(arg_28_0)

		return
	end)
	arg_1_0:on(21247, function(arg_29_0)
		arg_1_0:HandleTradeNotify(arg_29_0)

		return
	end)

	return
end

function var_0_0.HandFishingStart(arg_30_0, arg_30_1)
	arg_30_0:emitCore(ISLAND_EVT.START_FISHING, {
		unitId = arg_30_1.user_id,
		fishPointId = arg_30_1.point_id,
		rodId = arg_30_1.rod_id,
		fishId = arg_30_1.fish_id
	})

	return
end

function var_0_0.HandFishingStateChange(arg_31_0, arg_31_1)
	arg_31_0:emitCore(ISLAND_EVT.FISHING_STATE_CHANGE, {
		unitId = arg_31_1.user_id,
		fishPointId = arg_31_1.point_id,
		op = arg_31_1.type
	})

	return
end

function var_0_0.UpdateTradePrice(arg_32_0, arg_32_1)
	arg_32_0:GetIsland():GetTradeAgency():UpdateTodayPrice(arg_32_1.today_price.timestamp, arg_32_1.today_price.price)

	return
end

function var_0_0.HandleAgoraData(arg_33_0, arg_33_1)
	if getProxy(IslandProxy):GetIsland().id == arg_33_0:GetIsland().id then
		return
	end

	arg_33_0:GetIsland():GetAgoraAgency():UpdatePlacedData(arg_33_1)

	return
end

function var_0_0.HandlePlayerData(arg_34_0, arg_34_1)
	warning("HandlePlayerData>>>>>>>>>", arg_34_1.state, arg_34_1.map_id, arg_34_1.id)

	if arg_34_1.state == IslandConst.PLAYER_DATA_STATE_EMPTY then
		arg_34_0:UpdatePlayerData(arg_34_1)
	elseif arg_34_1.state == IslandConst.PLAYER_DATA_STATE_ENTER then
		arg_34_0:HandlePlayerEnter(arg_34_1)
	elseif arg_34_1.state == IslandConst.PLAYER_DATA_STATE_EXIT then
		arg_34_0:HandlePlayerExit(arg_34_1.id)
	end

	return
end

function var_0_0.HandlePlayerExit(arg_35_0, arg_35_1)
	if arg_35_0:GetIsland():GetVisitorAgency():GetPlayerList()[arg_35_1] then
		arg_35_0:GetIsland():GetVisitorAgency():DeletePlayer(arg_35_1)
	end

	local var_35_0 = arg_35_0:GetIsland():GetVisitorAgency()

	if var_35_0:GetMapVisitorList()[arg_35_1] then
		arg_35_0:GetIsland():GetVisitorAgency():DeleteMapVisitor(arg_35_1)
	end

	return
end

function var_0_0.HandlePlayerEnter(arg_36_0, arg_36_1)
	if not arg_36_0:GetIsland():GetVisitorAgency():GetPlayerList()[arg_36_1.id] then
		local var_36_0 = IslandPlayer.New(arg_36_1)

		arg_36_0:GetIsland():GetVisitorAgency():AddPlayer(var_36_0)

		if var_36_0:IsInMap(arg_36_0:GetIsland():GetMapId()) then
			arg_36_0:GetIsland():GetVisitorAgency():AddMapVisitor(var_36_0)
		end
	end

	return
end

function var_0_0.UpdatePlayerData(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetIsland():GetVisitorAgency():GetPlayerList()[arg_37_1.id]

	if var_37_0 then
		var_37_0:Flush(arg_37_1)
	end

	local var_37_1

	if var_37_0 then
		::label_37_0::

		var_37_1 = var_37_0:IsInMap(arg_37_0:GetIsland():GetMapId())
	end

	local var_37_2 = arg_37_0:GetIsland():GetVisitorAgency()
	local var_37_3 = var_37_2:GetMapVisitorList()[arg_37_1.id]

	if var_37_1 and not var_37_3 then
		arg_37_0:GetIsland():GetVisitorAgency():AddMapVisitor(var_37_0)
	elseif not var_37_1 and var_37_3 then
		arg_37_0:GetIsland():GetVisitorAgency():DeleteMapVisitor(arg_37_1.id)
	elseif var_37_1 and var_37_3 then
		var_37_3:Flush(arg_37_1)
	end

	return
end

function var_0_0.HandleOrderData(arg_38_0, arg_38_1)
	arg_38_0:GetIsland():GetOrderAgency():UpdateOrAddOrder(arg_38_1)

	return
end

function var_0_0.HandleTaskData(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:GetIsland():GetTaskAgency()

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

function var_0_0.HandleRandomTaskData(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.task_list_random or {}

	arg_41_0:GetIsland():GetTaskAgency():InitFutureTasks(var_41_0)

	local var_41_1 = arg_41_1.task_list or {}
	local var_41_2 = arg_41_0:GetIsland():GetTaskAgency()

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		var_41_2:AddTask((IslandTask.New(iter_41_1)))
	end

	if #var_41_1 > 0 then
		var_41_2:TryAutoTrackTask()
	end

	return
end

function var_0_0.HandleManageData(arg_42_0, arg_42_1)
	local var_42_0 = getProxy(IslandProxy):GetIsland():GetManageAgency()

	if arg_42_1.type == 1 then
		var_42_0:DailyRefresh(arg_42_1)
	elseif arg_42_1.type == 2 then
		var_42_0:UnlockDailyEvent(arg_42_1)
	end

	return
end

function var_0_0.SyncStartManage(arg_43_0, arg_43_1)
	local var_43_9000
	local var_43_0 = getProxy(IslandProxy):GetIsland()
	local var_43_1 = var_43_0.GetManageAgency(var_43_9000)
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

function var_0_0.HandleAchievementData(arg_44_0, arg_44_1)
	local var_44_0 = getProxy(IslandProxy):GetIsland():GetAchievementAgency()

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		var_44_0:UpdateRecord(iter_44_1.event_type, iter_44_1.event_arg, iter_44_1.value)
	end

	return
end

function var_0_0.HandleBookData(arg_45_0, arg_45_1)
	getProxy(IslandProxy):GetIsland():GetBookAgency():HandlePushData(arg_45_1)

	return
end

function var_0_0.HandleSlotFormulaData(arg_46_0, arg_46_1)
	getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetBuilding(pg.island_production_slot[arg_46_1.area_id].place):GetDelegationSlotData(arg_46_1.area_id):AddFormulaNum(arg_46_1)

	return
end

function var_0_0.HandleBuildUnlockData(arg_47_0, arg_47_1)
	getProxy(IslandProxy):GetIsland():GetBuildingAgency():InitBuildData(arg_47_1.build)

	return
end

function var_0_0.HandleHandSlotUnlockData(arg_48_0, arg_48_1)
	getProxy(IslandProxy):GetIsland():GetBuildingAgency():InitHandSlotData(arg_48_1.collect)

	return
end

function var_0_0.HandleSignInData(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:GetIsland():GetSignInAgency()

	var_49_0:UpdateGiftEndTime(arg_49_1.gift_timestamp)
	var_49_0:UpdateFetchedList(arg_49_1.gift_visitor)
	var_49_0:SetGiftCnt(arg_49_1.gift_count)

	return
end

function var_0_0.HandleTradeNotify(arg_50_0, arg_50_1)
	local var_50_0 = getProxy(FriendProxy):getFriend(arg_50_1.island_id)
	local var_50_1 = var_50_0 and var_50_0:GetName() or ""

	;({
		id = arg_50_1.island_id,
		cmd = IslandConst.VISITOR_LOG_CMD_TRADE,
		name = var_50_1
	}).time = pg.TimeMgr.GetInstance():GetServerTime()
	;({
		id = arg_50_1.island_id,
		cmd = IslandConst.VISITOR_LOG_CMD_TRADE,
		name = var_50_1
	}).mapId = arg_50_1.map_id
	;({
		id = arg_50_1.island_id,
		cmd = IslandConst.VISITOR_LOG_CMD_TRADE,
		name = var_50_1
	}).extraInfo = arg_50_1.price

	local var_50_3 = var_50_2({
		id = arg_50_1.island_id,
		cmd = IslandConst.VISITOR_LOG_CMD_TRADE,
		name = var_50_1
	})
	local var_50_4 = var_50_3:BuildWhitoutTime()

	if not var_50_4 or var_50_4 == "" then
		return
	end

	pg.IslandVisitorNotificationMgr.GetInstance():Enqueue(var_50_3)

	return
end

function var_0_0.HandleSignInNotify(arg_51_0, arg_51_1)
	if arg_51_1.cmd == 2 then
		local var_51_0 = getProxy(FriendProxy):getFriend(arg_51_1.island_id)
		local var_51_1 = var_51_0 and var_51_0:GetName() or ""

		;({
			id = arg_51_1.island_id,
			cmd = IslandConst.VISITOR_LOG_CMD_GIFT,
			name = var_51_1
		}).time = pg.TimeMgr.GetInstance():GetServerTime()

		if arg_51_0:IsCurrentIsland(arg_51_1.island_id) then
			arg_51_0:GetIsland():GetSignInAgency():AddInviter(getProxy(PlayerProxy):getRawData().id)
		end

		pg.IslandVisitorNotificationMgr.GetInstance():Enqueue((var_51_2({
			id = arg_51_1.island_id,
			cmd = IslandConst.VISITOR_LOG_CMD_GIFT,
			name = var_51_1
		})))
	end

	return
end

function var_0_0.HandleWildGatherInData(arg_52_0, arg_52_1)
	arg_52_0:GetIsland():GetWildCollectAgency():UpdateGatherData(arg_52_1)

	return
end

function var_0_0.HandleWildCollectInData(arg_53_0, arg_53_1)
	arg_53_0:GetIsland():GetWildCollectAgency():UpdateCollectFragmentData(arg_53_1)

	return
end

function var_0_0.HandleAbilityData(arg_54_0, arg_54_1)
	local var_54_0 = getProxy(IslandProxy):GetSharedIsland()

	if not var_54_0 then
		return
	end

	var_54_0:GetAblityAgency():AddAblity(arg_54_1.ability_id)

	return
end

function var_0_0.SyncStartDelegation(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:GetIsland()

	var_55_0:GetBuildingAgency():GetBuilding(pg.island_production_slot[arg_55_1.appoint_data.id].place):UpdateDeleationRoleDataBySlotId(arg_55_1.appoint_data.id, arg_55_1.appoint_data)
	var_55_0:DispatchEvent(IslandStartDelegationCommand.START_DELEGATION, {
		build_id = pg.island_production_slot[arg_55_1.appoint_data.id].place,
		ship_id = arg_55_1.appoint_data.ship_id,
		area_id = arg_55_1.appoint_data.id,
		formula_id = arg_55_1.appoint_data.formula_id
	})

	return
end

function var_0_0.SyncEndDelegation(arg_56_0, arg_56_1)
	local var_56_0 = island:GetBuildingAgency():GetBuilding(arg_56_0.buildId)

	var_56_0:UpdateDeleationRewardDataBySlotId(arg_56_0.id, {
		formula_id = arg_56_0.islandRoleDelegationData.formula_id
	})
	var_56_0:UpdateDeleationRoleDataBySlotId(arg_56_0.id, nil)
	arg_56_0:GetIsland():DispatchEvent(IslandFinishDelegationCommand.END_DELEGATION, {
		remainReward = true,
		build_id = build_id,
		ship_id = arg_56_0.islandRoleDelegationData.ship_id,
		area_id = arg_56_0.id
	})

	return
end

function var_0_0.SyncResetSlotData(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:GetIsland()
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

function var_0_0.SyncStarthHandPlant(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0:GetIsland()
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

function var_0_0.ResponeAniamtion(arg_59_0, arg_59_1)
	arg_59_0:GetIsland():DispatchEvent(IslandProxy.LINK_CORE, ISLAND_EVT.RESPON_ANIMATION_OP, {
		id = arg_59_1.player_id,
		targetId = arg_59_1.target_id,
		actionId = arg_59_1.action_id
	})

	return
end

function var_0_0.AddChatMsg(arg_60_0, arg_60_1)
	local var_60_0 = getProxy(PlayerProxy):getRawData()
	local var_60_1 = arg_60_1.user_id == var_60_0.id and var_60_0 or arg_60_0:GetIsland():GetVisitorAgency():GetPlayer(arg_60_1.user_id)

	if not var_60_1 then
		return
	end

	getProxy(IslandProxy):AddChatMsg(arg_60_1.island_id, (ChatMsg.New(ChatConst.ChannelIsland, (ChatProxy.InjectPublicMsg(arg_60_1.content, Clone(var_60_1))))))

	return
end

function var_0_0.UpdateActivityNpc(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:GetIsland():GetActivityNpcAgency()

	for iter_61_0, iter_61_1 in ipairs(arg_61_1.refresh_list) do
		if iter_61_1.type == IslandConst.ACTIVITY_NPC_OP_TYPE_UPDATE then
			var_61_0:UpdateNpc({
				id = iter_61_1.id,
				object_id = iter_61_1.object_id
			})
		elseif iter_61_1.type == IslandConst.ACTIVITY_NPC_OP_TYPE_ADD then
			var_61_0:AddNpc({
				id = iter_61_1.id,
				object_id = iter_61_1.object_id
			})
		elseif iter_61_1.type == IslandConst.ACTIVITY_NPC_OP_TYPE_DEL then
			var_61_0:RemoveNpc({
				id = iter_61_1.id,
				object_id = iter_61_1.object_id
			})
		end
	end

	return
end

function var_0_0.UpdatePlayerDressupData(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0:GetIsland()
	local var_62_1 = var_62_0:GetVisitorAgency():GetPlayer(arg_62_1.user_id)

	if not var_62_1 then
		return
	end

	local var_62_2 = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_1.dress_list) do
		local var_62_3 = 0
		local var_62_4 = arg_62_1.dress_color or {}

		for iter_62_2, iter_62_3 in ipairs(var_62_4) do
			if iter_62_3.id == iter_62_1.id then
				var_62_3 = iter_62_3.color
			end
		end

		local var_62_5 = var_62_1:GetDressByType(iter_62_1.type)
		local var_62_6 = var_62_1:GetCurrentColorByDressId(var_62_5)

		if var_62_5 ~= iter_62_1.id then
			var_62_2[iter_62_1.type] = {
				changeedDressId = iter_62_1.id,
				changedDressColorId = var_62_3
			}
		elseif var_62_6 ~= var_62_3 then
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

return var_0_0
