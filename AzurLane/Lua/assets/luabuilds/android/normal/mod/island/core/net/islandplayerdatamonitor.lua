class = var_0_10000

local var_0_0 = "IslandPlayerDataMonitor"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseMonitor"))

function var_0_1.register(arg_1_0)
	arg_1_0:on(21206, function(arg_2_0)
		local var_2_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_2_0, arg_2_0.island_id) then
			return
		end

		ipairs = var_1

		for iter_2_0, iter_2_1 in var_1(arg_2_0.player_list) do
			local var_2_1 = arg_1_0

			var_6.HandlePlayerData(var_2_1, iter_2_1)
		end

		return
	end)
	arg_1_0:on(21309, function(arg_3_0)
		local var_3_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_3_0, arg_3_0.island_id) then
			return
		end

		local var_3_1 = arg_1_0

		var_1.HandleAgoraData(var_3_1, arg_3_0.update_data)

		return
	end)
	arg_1_0:on(21407, function(arg_4_0)
		local var_4_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_4_0, arg_4_0.island_id) then
			return
		end

		local var_4_1 = arg_1_0

		var_1.HandleOrderData(var_4_1, arg_4_0.order_info)

		return
	end)
	arg_1_0:on(21040, function(arg_5_0)
		local var_5_0 = arg_1_0

		var_1.HandleTaskData(var_5_0, arg_5_0.task_list)

		return
	end)
	arg_1_0:on(21043, function(arg_6_0)
		local var_6_0 = arg_1_0

		var_1.HandleRandomTaskData(var_6_0, arg_6_0)

		return
	end)
	arg_1_0:on(21422, function(arg_7_0)
		local var_7_0 = arg_1_0

		var_1.HandleManageData(var_7_0, arg_7_0)

		return
	end)
	arg_1_0:on(21053, function(arg_8_0)
		local var_8_0 = arg_1_0

		var_1.HandleAchievementData(var_8_0, arg_8_0.event_list)

		return
	end)
	arg_1_0:on(21342, function(arg_9_0)
		local var_9_0 = arg_1_0

		var_1.HandleBookData(var_9_0, arg_9_0.item_list)

		return
	end)
	arg_1_0:on(21518, function(arg_10_0)
		local var_10_0 = arg_1_0

		var_1.HandleSlotFormulaData(var_10_0, arg_10_0)

		getProxy = var_1
		IslandProxy = var_10_0

		local var_10_1 = var_1(var_10_0)
		local var_10_2 = var_1.GetIsland(var_10_1)
		local var_10_3 = var_1.GetBuildingAgency(var_10_2)

		var_1.AddFormulaNum(var_10_3, arg_10_0.formula_id, arg_10_0.comb_num)

		return
	end)
	arg_1_0:on(21519, function(arg_11_0)
		local var_11_0 = arg_1_0

		var_1.HandleBuildUnlockData(var_11_0, arg_11_0)

		return
	end)
	arg_1_0:on(21515, function(arg_12_0)
		local var_12_0 = arg_1_0

		var_1.HandleHandSlotUnlockData(var_12_0, arg_12_0)

		return
	end)
	arg_1_0:on(21314, function(arg_13_0)
		local var_13_0 = arg_1_0

		var_1.HandleSignInNotify(var_13_0, arg_13_0)

		getProxy = var_1
		IslandProxy = var_13_0

		local var_13_1 = var_1(var_13_0)

		var_1.UpdateGiftTagCache(var_13_1, arg_13_0.island_id, arg_13_0.gift_count, arg_13_0.gift_timestamp)

		local var_13_2 = arg_1_0

		if not var_1.IsCurrentIsland(var_13_2, arg_13_0.island_id) then
			return
		end

		local var_13_3 = arg_1_0

		var_1.HandleSignInData(var_13_3, arg_13_0)

		return
	end)
	arg_1_0:on(21528, function(arg_14_0)
		local var_14_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_14_0, arg_14_0.island_id) then
			return
		end

		local var_14_1 = arg_1_0

		var_1.HandleWildGatherInData(var_14_1, arg_14_0)

		return
	end)
	arg_1_0:on(21535, function(arg_15_0)
		local var_15_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_15_0, arg_15_0.island_id) then
			return
		end

		local var_15_1 = arg_1_0

		var_1.HandleWildCollectInData(var_15_1, arg_15_0)

		return
	end)
	arg_1_0:on(21227, function(arg_16_0)
		local var_16_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_16_0, arg_16_0.island_id) then
			return
		end

		local var_16_1 = arg_1_0

		var_1.HandleAbilityData(var_16_1, arg_16_0)

		return
	end)
	arg_1_0:on(21225, function(arg_17_0)
		local var_17_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_17_0, arg_17_0.island_id) then
			return
		end

		local var_17_1 = arg_1_0

		var_1.SyncStartManage(var_17_1, arg_17_0)

		return
	end)
	arg_1_0:on(21220, function(arg_18_0)
		local var_18_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_18_0, arg_18_0.island_id) then
			return
		end

		local var_18_1 = arg_1_0

		var_1.SyncStartDelegation(var_18_1, arg_18_0)

		return
	end)
	arg_1_0:on(21226, function(arg_19_0)
		local var_19_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_19_0, arg_19_0.island_id) then
			return
		end

		local var_19_1 = arg_1_0

		var_1.SyncEndDelegation(var_19_1, arg_19_0)

		return
	end)
	arg_1_0:on(21222, function(arg_20_0)
		local var_20_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_20_0, arg_20_0.island_id) then
			return
		end

		local var_20_1 = arg_1_0

		var_1.SyncResetSlotData(var_20_1, arg_20_0)

		return
	end)
	arg_1_0:on(21221, function(arg_21_0)
		local var_21_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_21_0, arg_21_0.island_id) then
			return
		end

		local var_21_1 = arg_1_0

		var_1.SyncStarthHandPlant(var_21_1, arg_21_0)

		return
	end)
	arg_1_0:on(21701, function(arg_22_0)
		local var_22_0 = arg_1_0

		var_1.ResponeAniamtion(var_22_0, arg_22_0)

		return
	end)
	arg_1_0:on(21325, function(arg_23_0)
		local var_23_0 = arg_1_0

		var_1.AddChatMsg(var_23_0, arg_23_0)

		return
	end)
	arg_1_0:on(21228, function(arg_24_0)
		local var_24_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_24_0, arg_24_0.island_id) then
			return
		end

		local var_24_1 = arg_1_0

		var_1.UpdateActivityNpc(var_24_1, arg_24_0)

		return
	end)
	arg_1_0:on(21224, function(arg_25_0)
		local var_25_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_25_0, arg_25_0.island_id) then
			return
		end

		local var_25_1 = arg_1_0

		var_1.UpdatePlayerDressupData(var_25_1, arg_25_0)

		return
	end)
	arg_1_0:on(21232, function(arg_26_0)
		local var_26_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_26_0, arg_26_0.island_id) then
			return
		end

		local var_26_1 = arg_1_0

		var_1.HandFishingStart(var_26_1, arg_26_0)

		return
	end)
	arg_1_0:on(21233, function(arg_27_0)
		local var_27_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_27_0, arg_27_0.island_id) then
			return
		end

		local var_27_1 = arg_1_0

		var_1.HandFishingStateChange(var_27_1, arg_27_0)

		return
	end)
	arg_1_0:on(21242, function(arg_28_0)
		local var_28_0 = arg_1_0

		if not var_1.IsCurrentIsland(var_28_0, arg_28_0.island_id) then
			return
		end

		local var_28_1 = arg_1_0

		var_1.UpdateTradePrice(var_28_1, arg_28_0)

		return
	end)
	arg_1_0:on(21247, function(arg_29_0)
		local var_29_0 = arg_1_0

		var_1.HandleTradeNotify(var_29_0, arg_29_0)

		return
	end)

	return
end

function var_0_1.HandFishingStart(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.emitCore

	ISLAND_EVT = var_1_10004

	var_30_1(var_30_0, var_1_10004.START_FISHING, {
		unitId = arg_30_1.user_id,
		fishPointId = arg_30_1.point_id,
		rodId = arg_30_1.rod_id,
		fishId = arg_30_1.fish_id
	})

	return
end

function var_0_1.HandFishingStateChange(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.emitCore

	ISLAND_EVT = var_1_10004

	var_31_1(var_31_0, var_1_10004.FISHING_STATE_CHANGE, {
		unitId = arg_31_1.user_id,
		fishPointId = arg_31_1.point_id,
		op = arg_31_1.type
	})

	return
end

function var_0_1.UpdateTradePrice(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.today_price.timestamp
	local var_32_1 = arg_32_1.today_price.price
	local var_32_2 = arg_32_0:GetIsland()
	local var_32_3 = var_4.GetTradeAgency(var_32_2)

	var_4.UpdateTodayPrice(var_32_3, var_32_0, var_32_1)

	return
end

function var_0_1.HandleAgoraData(arg_33_0, arg_33_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_33_0 = var_1_10002(var_1_10003)

	if var_2.GetIsland(var_33_0).id == arg_33_0:GetIsland().id then
		return
	end

	local var_33_1 = arg_33_0:GetIsland()
	local var_33_2 = var_3.GetAgoraAgency(var_33_1)

	var_3.UpdatePlacedData(var_33_2, arg_33_1)

	return
end

function var_0_1.HandlePlayerData(arg_34_0, arg_34_1)
	warning = var_1_10002

	var_1_10002("HandlePlayerData>>>>>>>>>", arg_34_1.state, arg_34_1.map_id, arg_34_1.id)

	local var_34_0 = arg_34_1.state

	IslandConst = var_3

	local var_34_1

	if var_34_0 == var_3.PLAYER_DATA_STATE_EMPTY then
		var_34_1 = arg_34_0

		arg_34_0.UpdatePlayerData(var_34_1, arg_34_1)
	else
		local var_34_2 = arg_34_1.state

		IslandConst = var_34_1

		local var_34_3

		if var_34_2 == var_34_1.PLAYER_DATA_STATE_ENTER then
			var_34_3 = arg_34_0

			arg_34_0.HandlePlayerEnter(var_34_3, arg_34_1)
		else
			local var_34_4 = arg_34_1.state

			IslandConst = var_34_3

			if var_34_4 == var_34_3.PLAYER_DATA_STATE_EXIT then
				arg_34_0:HandlePlayerExit(arg_34_1.id)
			end
		end
	end

	return
end

function var_0_1.HandlePlayerExit(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:GetIsland()
	local var_35_1 = var_2.GetVisitorAgency(var_35_0)

	if var_2.GetPlayerList(var_35_1)[arg_35_1] then
		local var_35_2 = arg_35_0:GetIsland()
		local var_35_3 = var_4.GetVisitorAgency(var_35_2)

		var_4.DeletePlayer(var_35_3, arg_35_1)
	end

	local var_35_4 = arg_35_0:GetIsland()
	local var_35_5 = var_4.GetVisitorAgency(var_35_4)

	if var_4.GetMapVisitorList(var_35_5)[arg_35_1] then
		local var_35_6 = arg_35_0:GetIsland()
		local var_35_7 = var_5.GetVisitorAgency(var_35_6)

		var_5.DeleteMapVisitor(var_35_7, arg_35_1)
	end

	return
end

function var_0_1.HandlePlayerEnter(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.id
	local var_36_1 = arg_36_0:GetIsland()
	local var_36_2 = var_3.GetVisitorAgency(var_36_1)

	if not var_3.GetPlayerList(var_36_2)[var_36_0] then
		IslandPlayer = var_1_10005

		local var_36_3 = var_1_10005.New(arg_36_1)
		local var_36_4 = arg_36_0:GetIsland()
		local var_36_5 = var_6.GetVisitorAgency(var_36_4)

		var_6.AddPlayer(var_36_5, var_36_3)

		local var_36_6 = var_36_3
		local var_36_7 = var_36_3.IsInMap
		local var_36_8 = arg_36_0:GetIsland()

		if var_36_7(var_36_6, var_8.GetMapId(var_36_8)) then
			local var_36_9 = arg_36_0:GetIsland()
			local var_36_10 = var_6.GetVisitorAgency(var_36_9)

			var_6.AddMapVisitor(var_36_10, var_36_3)
		end
	end

	return
end

function var_0_1.UpdatePlayerData(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetIsland()
	local var_37_1 = var_2.GetVisitorAgency(var_37_0)

	if var_2.GetPlayerList(var_37_1)[arg_37_1.id] then
		var_3:Flush(arg_37_1)
	end

	local var_37_5

	if var_3 then
		::label_37_0::

		local var_37_2 = var_3
		local var_37_3 = var_3.IsInMap
		local var_37_4 = arg_37_0:GetIsland()

		var_37_5 = var_37_3(var_37_2, var_6.GetMapId(var_37_4))
	end

	local var_37_6 = arg_37_0:GetIsland()
	local var_37_7 = var_5.GetVisitorAgency(var_37_6)
	local var_37_8 = var_5.GetMapVisitorList(var_37_7)[arg_37_1.id]

	if var_37_5 and not var_37_8 then
		local var_37_9 = arg_37_0:GetIsland()
		local var_37_10 = var_7.GetVisitorAgency(var_37_9)

		var_7.AddMapVisitor(var_37_10, var_3)
	elseif not var_37_5 and var_37_8 then
		local var_37_11 = arg_37_0:GetIsland()
		local var_37_12 = var_7.GetVisitorAgency(var_37_11)

		var_7.DeleteMapVisitor(var_37_12, arg_37_1.id)
	elseif var_37_5 and var_37_8 then
		var_37_8:Flush(arg_37_1)
	end

	return
end

function var_0_1.HandleOrderData(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:GetIsland()
	local var_38_1 = var_2.GetOrderAgency(var_38_0)

	var_2.UpdateOrAddOrder(var_38_1, arg_38_1)

	return
end

function var_0_1.HandleTaskData(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:GetIsland()
	local var_39_1 = var_2.GetTaskAgency(var_39_0)

	ipairs = var_39_0

	for iter_39_0, iter_39_1 in var_39_0(arg_39_1) do
		underscore = var_1_10008
		var_1_10008 = var_1_10008.all(iter_39_1.process_list, function(arg_40_0)
			return arg_40_0.target_count == 0
		end)
		IslandTask = var_9

		local var_39_2 = var_9.New(iter_39_1)

		if var_1_10008 then
			var_39_1:AddTask(var_39_2)
		else
			var_39_1:UpdateTask(var_39_2)
		end
	end

	return
end

function var_0_1.HandleRandomTaskData(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:GetIsland()
	local var_41_1 = var_2.GetTaskAgency(var_41_0)
	local var_41_2 = var_2.InitFutureTasks
	local var_41_3

	if not arg_41_1.task_list_random then
		var_41_3 = {}
	end

	var_41_2(var_41_1, var_41_3)

	local var_41_4

	if not arg_41_1.task_list then
		var_41_4 = {}
	end

	local var_41_5 = arg_41_0:GetIsland()
	local var_41_6 = var_3.GetTaskAgency(var_41_5)

	ipairs = var_41_5

	for iter_41_0, iter_41_1 in var_41_5(var_41_4) do
		IslandTask = var_1_10009
		var_1_10009 = var_1_10009.New(iter_41_1)

		var_41_6:AddTask(var_1_10009)
	end

	if #var_41_4 > 0 then
		var_41_6:TryAutoTrackTask()
	end

	return
end

function var_0_1.HandleManageData(arg_42_0, arg_42_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_42_0 = var_1_10002(var_1_10003)
	local var_42_1 = var_2.GetIsland(var_42_0)
	local var_42_2 = var_2.GetManageAgency(var_42_1)

	if arg_42_1.type == 1 then
		var_42_2:DailyRefresh(arg_42_1)
	elseif arg_42_1.type == 2 then
		var_42_2:UnlockDailyEvent(arg_42_1)
	end

	return
end

function var_0_1.SyncStartManage(arg_43_0, arg_43_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_43_0 = var_1_10002(var_1_10003)
	local var_43_1 = var_2.GetIsland(var_43_0)
	local var_43_2 = var_2.GetManageAgency(var_43_1)
	local var_43_3 = arg_43_1.trade
	local var_43_4

	if not var_43_2:GetRestaurant(var_43_3.id) then
		var_43_2:UnlockNewRestaurant(var_43_3.id)

		var_43_4 = var_43_2:GetRestaurant(var_43_3.id)
	end

	local var_43_5 = var_43_4

	var_43_4.UpdateData(var_43_5, var_43_3)

	getProxy = var_5
	IslandProxy = var_43_5

	local var_43_6 = var_5(var_43_5)
	local var_43_7 = var_5.GetSharedIsland(var_43_6)
	local var_43_8 = var_5.DispatchEvent

	IslandOpenRestaurantCommand = var_1_10008

	var_43_8(var_43_7, var_1_10008.OPEN_RESTAURANT, {
		restId = var_43_4.id,
		postList = var_43_3.post_list
	})

	return
end

function var_0_1.HandleAchievementData(arg_44_0, arg_44_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_44_0 = var_1_10002(var_1_10003)
	local var_44_1 = var_2.GetIsland(var_44_0)
	local var_44_2 = var_2.GetAchievementAgency(var_44_1)

	ipairs = var_44_1

	for iter_44_0, iter_44_1 in var_44_1(arg_44_1) do
		var_44_2:UpdateRecord(iter_44_1.event_type, iter_44_1.event_arg, iter_44_1.value)
	end

	return
end

function var_0_1.HandleBookData(arg_45_0, arg_45_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_45_0 = var_1_10002(var_1_10003)
	local var_45_1 = var_2.GetIsland(var_45_0)
	local var_45_2 = var_2.GetBookAgency(var_45_1)

	var_2.HandlePushData(var_45_2, arg_45_1)

	return
end

function var_0_1.HandleSlotFormulaData(arg_46_0, arg_46_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_46_0 = var_1_10002(var_1_10003)
	local var_46_1 = var_2.GetIsland(var_46_0)
	local var_46_2 = var_2.GetBuildingAgency(var_46_1)
	local var_46_3 = arg_46_1.area_id

	pg = var_1_10004

	local var_46_4 = var_1_10004.island_production_slot[var_46_3].place
	local var_46_5 = var_46_2:GetBuilding(var_46_4)
	local var_46_6 = var_5.GetDelegationSlotData(var_46_5, var_46_3)

	var_6.AddFormulaNum(var_46_6, arg_46_1)

	return
end

function var_0_1.HandleBuildUnlockData(arg_47_0, arg_47_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_47_0 = var_1_10002(var_1_10003)
	local var_47_1 = var_2.GetIsland(var_47_0)
	local var_47_2 = var_2.GetBuildingAgency(var_47_1)

	var_2.InitBuildData(var_47_2, arg_47_1.build)

	return
end

function var_0_1.HandleHandSlotUnlockData(arg_48_0, arg_48_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_48_0 = var_1_10002(var_1_10003)
	local var_48_1 = var_2.GetIsland(var_48_0)
	local var_48_2 = var_2.GetBuildingAgency(var_48_1)

	var_2.InitHandSlotData(var_48_2, arg_48_1.collect)

	return
end

function var_0_1.HandleSignInData(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:GetIsland()
	local var_49_1 = var_2.GetSignInAgency(var_49_0)

	var_2.UpdateGiftEndTime(var_49_1, arg_49_1.gift_timestamp)
	var_2:UpdateFetchedList(arg_49_1.gift_visitor)
	var_2:SetGiftCnt(arg_49_1.gift_count)

	return
end

function var_0_1.HandleTradeNotify(arg_50_0, arg_50_1)
	getProxy = var_1_10002
	FriendProxy = var_1_10003

	local var_50_0 = var_1_10002(var_1_10003)

	if var_2.getFriend(var_50_0, arg_50_1.island_id) then
		local var_50_1 = var_2
		local var_50_2

		if not var_2.GetName(var_50_1) then
			var_50_2 = ""
		end

		IslandVisitorLog = var_50_1

		local var_50_3 = var_50_1.New
		local var_50_4 = {
			id = arg_50_1.island_id
		}

		IslandConst = var_6
		var_50_4.cmd = var_6.VISITOR_LOG_CMD_TRADE
		var_50_4.name = var_50_2
		pg = var_6

		local var_50_5 = var_6.TimeMgr.GetInstance()

		var_50_4.time = var_6.GetServerTime(var_50_5)
		var_50_4.mapId = arg_50_1.map_id
		var_50_4.extraInfo = arg_50_1.price

		local var_50_6 = var_50_3(var_50_4)

		if not var_4.BuildWhitoutTime(var_50_6) or var_5 == "" then
			return
		end

		pg = var_50_6

		local var_50_7 = var_50_6.IslandVisitorNotificationMgr.GetInstance()

		var_6.Enqueue(var_50_7, var_4)

		return
	end
end

function var_0_1.HandleSignInNotify(arg_51_0, arg_51_1)
	if arg_51_1.cmd == 2 then
		getProxy = var_2
		FriendProxy = var_1_10003

		local var_51_0 = var_2(var_1_10003)

		if var_2.getFriend(var_51_0, arg_51_1.island_id) then
			local var_51_1 = var_2
			local var_51_2

			if not var_2.GetName(var_51_1) then
				var_51_2 = ""
			end

			IslandVisitorLog = var_51_1

			local var_51_3 = var_51_1.New
			local var_51_4 = {
				id = arg_51_1.island_id
			}

			IslandConst = var_6
			var_51_4.cmd = var_6.VISITOR_LOG_CMD_GIFT
			var_51_4.name = var_51_2
			pg = var_6

			local var_51_5 = var_6.TimeMgr.GetInstance()

			var_51_4.time = var_6.GetServerTime(var_51_5)

			local var_51_6 = var_51_3(var_51_4)
			local var_51_8

			if arg_51_0:IsCurrentIsland(arg_51_1.island_id) then
				local var_51_7 = arg_51_0:GetIsland()

				var_51_8 = var_51_8.GetSignInAgency(var_51_7)
				getProxy = var_51_7
				PlayerProxy = var_7

				local var_51_9 = var_51_7(var_7)
				local var_51_10 = var_6.getRawData(var_51_9).id

				var_51_8:AddInviter(var_51_10)
			end

			pg = var_51_8

			local var_51_11 = var_51_8.IslandVisitorNotificationMgr.GetInstance()

			var_5.Enqueue(var_51_11, var_51_6)

			return
		end
	end
end

function var_0_1.HandleWildGatherInData(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0:GetIsland()
	local var_52_1 = var_2.GetWildCollectAgency(var_52_0)

	var_2.UpdateGatherData(var_52_1, arg_52_1)

	return
end

function var_0_1.HandleWildCollectInData(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:GetIsland()
	local var_53_1 = var_2.GetWildCollectAgency(var_53_0)

	var_2.UpdateCollectFragmentData(var_53_1, arg_53_1)

	return
end

function var_0_1.HandleAbilityData(arg_54_0, arg_54_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_54_0 = var_1_10002(var_1_10003)

	if not var_2.GetSharedIsland(var_54_0) then
		return
	end

	local var_54_1 = var_2:GetAblityAgency()

	var_3.AddAblity(var_54_1, arg_54_1.ability_id)

	return
end

function var_0_1.SyncStartDelegation(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:GetIsland()
	local var_55_1 = var_2.GetBuildingAgency(var_55_0)

	pg = var_55_0

	local var_55_2 = var_55_0.island_production_slot[arg_55_1.appoint_data.id].place
	local var_55_3 = var_55_1:GetBuilding(var_55_2)

	var_6.UpdateDeleationRoleDataBySlotId(var_55_3, arg_55_1.appoint_data.id, arg_55_1.appoint_data)

	local var_55_4 = arg_55_1.appoint_data.ship_id
	local var_55_5 = arg_55_1.appoint_data.id
	local var_55_6 = arg_55_1.appoint_data.formula_id
	local var_55_7 = var_2
	local var_55_8 = var_2.DispatchEvent

	IslandStartDelegationCommand = var_1_10012

	var_55_8(var_55_7, var_1_10012.START_DELEGATION, {
		build_id = var_55_2,
		ship_id = var_55_4,
		area_id = var_55_5,
		formula_id = var_55_6
	})

	return
end

function var_0_1.SyncEndDelegation(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0
	local var_56_1 = arg_56_0.GetIsland(var_56_0)

	island = var_56_0

	local var_56_2 = var_56_0:GetBuildingAgency()
	local var_56_3 = var_3.GetBuilding(var_56_2, arg_56_0.buildId)
	local var_56_4 = arg_56_0.islandRoleDelegationData.formula_id
	local var_56_5 = arg_56_0.islandRoleDelegationData.ship_id
	local var_56_6 = arg_56_0.id

	var_56_3:UpdateDeleationRewardDataBySlotId(arg_56_0.id, {
		formula_id = var_56_4
	})
	var_56_3:UpdateDeleationRoleDataBySlotId(arg_56_0.id, nil)

	local var_56_7 = var_56_1
	local var_56_8 = var_56_1.DispatchEvent

	IslandFinishDelegationCommand = var_10

	local var_56_9 = var_10.END_DELEGATION
	local var_56_10 = {
		remainReward = true
	}

	build_id = var_1_10012
	var_56_10.build_id = var_1_10012
	var_56_10.ship_id = var_56_5
	var_56_10.area_id = var_56_6

	var_56_8(var_56_7, var_56_9, var_56_10)

	return
end

function var_0_1.SyncResetSlotData(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:GetIsland()
	local var_57_1 = var_2.GetBuildingAgency(var_57_0)

	ipairs = var_57_0

	for iter_57_0, iter_57_1 in var_57_0(arg_57_1.slot_list) do
		pg = var_1_10009

		local var_57_2 = var_1_10009.island_production_slot[iter_57_1].place
		local var_57_3 = var_57_1:GetBuilding(var_57_2)

		if var_1_10009.type == 9 or var_1_10009.type == 3 then
			if var_57_3:GetDelegationSlotData(iter_57_1) and var_12:GetSlotRoleData() then
				local var_57_4 = var_13.ship_id
				local var_57_5 = iter_57_1

				var_57_3:UpdateDeleationRoleDataBySlotId(iter_57_1, nil)

				local var_57_6 = var_2
				local var_57_7 = var_2.DispatchEvent

				IslandFinishDelegationCommand = var_18

				var_57_7(var_57_6, var_18.END_DELEGATION, {
					remainReward = false,
					build_id = var_57_2,
					ship_id = var_57_4,
					area_id = var_57_5
				})
			end

			var_57_3:UpdateDeleationRewardDataBySlotId(iter_57_1, nil)

			local var_57_8 = var_2
			local var_57_9 = var_2.DispatchEvent

			IslandBuildingAgency = var_16

			var_57_9(var_57_8, var_16.SLOT_RESET_DELEGATION_STATE_DONE, {
				build_id = var_57_2,
				area_id = iter_57_1
			})
		elseif var_1_10009.type == 1 then
			var_57_3:UpdateHandPlantDataBySlotId({
				formula_id = 0,
				end_time = 0,
				state = 0,
				id = iter_57_1
			})

			local var_57_10 = var_2
			local var_57_11 = var_2.DispatchEvent

			IslandSlotHandPlantAwardCommand = var_14

			var_57_11(var_57_10, var_14.START_HANDPLANT_AWARD_DONE, {
				build_id = var_57_2,
				area_id = iter_57_1
			})
		end
	end

	return
end

function var_0_1.SyncStarthHandPlant(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0:GetIsland()
	local var_58_1 = var_2.GetBuildingAgency(var_58_0)

	ipairs = var_58_0

	for iter_58_0, iter_58_1 in var_58_0(arg_58_1.hand_list) do
		pg = var_1_10009

		local var_58_2 = var_1_10009.island_production_slot[iter_58_1.id].place
		local var_58_3 = var_58_1:GetBuilding(var_58_2)

		var_11.UpdateHandPlantDataBySlotId(var_58_3, iter_58_1)

		local var_58_4 = var_2
		local var_58_5 = var_2.DispatchEvent

		IslandSlotHandPlantCommand = var_14

		var_58_5(var_58_4, var_14.START_HANDPLANT_DONE, {
			build_id = var_58_2,
			area_id = iter_58_1.id,
			formula_id = iter_58_1.formula_id
		})
	end

	return
end

function var_0_1.ResponeAniamtion(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0:GetIsland()
	local var_59_1 = var_2.DispatchEvent

	IslandProxy = var_1_10005

	local var_59_2 = var_1_10005.LINK_CORE

	ISLAND_EVT = var_1_10006

	var_59_1(var_59_0, var_59_2, var_1_10006.RESPON_ANIMATION_OP, {
		id = arg_59_1.player_id,
		targetId = arg_59_1.target_id,
		actionId = arg_59_1.action_id
	})

	return
end

function var_0_1.AddChatMsg(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0:GetIsland()
	local var_60_1 = var_2.GetVisitorAgency(var_60_0)

	getProxy = var_60_0
	PlayerProxy = var_1_10005

	local var_60_2 = var_60_0(var_1_10005)
	local var_60_3 = var_4.getRawData(var_60_2)
	local var_60_4, var_60_5

	if arg_60_1.user_id ~= var_60_3.id or not var_60_3 then
		::label_60_0::

		var_60_4 = var_60_1
		var_60_5 = var_60_1.GetPlayer(var_60_4, arg_60_1.user_id)
	end

	if not var_60_5 then
		return
	end

	ChatProxy = var_60_4

	local var_60_6 = var_60_4.InjectPublicMsg
	local var_60_7 = arg_60_1.content

	Clone = var_1_10008

	local var_60_8 = var_60_6(var_60_7, var_1_10008(var_60_5))

	ChatMsg = var_60_7

	local var_60_9 = var_60_7.New

	ChatConst = var_8

	local var_60_10 = var_60_9(var_8.ChannelIsland, var_60_8)

	getProxy = var_8
	IslandProxy = var_9

	local var_60_11 = var_8(var_9)

	var_8.AddChatMsg(var_60_11, arg_60_1.island_id, var_60_10)

	return
end

function var_0_1.UpdateActivityNpc(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:GetIsland()
	local var_61_1 = var_2.GetActivityNpcAgency(var_61_0)

	ipairs = var_61_0

	for iter_61_0, iter_61_1 in var_61_0(arg_61_1.refresh_list) do
		local var_61_2 = {
			id = iter_61_1.id,
			object_id = iter_61_1.object_id
		}
		local var_61_3 = iter_61_1.type

		IslandConst = var_1_10011

		if var_61_3 == var_1_10011.ACTIVITY_NPC_OP_TYPE_UPDATE then
			var_1_10011 = var_61_1

			var_61_1.UpdateNpc(var_1_10011, var_61_2)
		else
			local var_61_4 = iter_61_1.type

			IslandConst = var_1_10011

			if var_61_4 == var_1_10011.ACTIVITY_NPC_OP_TYPE_ADD then
				var_1_10011 = var_61_1

				var_61_1.AddNpc(var_1_10011, var_61_2)
			else
				local var_61_5 = iter_61_1.type

				IslandConst = var_1_10011

				if var_61_5 == var_1_10011.ACTIVITY_NPC_OP_TYPE_DEL then
					var_1_10011 = var_61_1

					var_61_1.RemoveNpc(var_1_10011, var_61_2)
				end
			end
		end
	end

	return
end

function var_0_1.UpdatePlayerDressupData(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0:GetIsland()
	local var_62_1 = var_2.GetVisitorAgency(var_62_0)

	if not var_3.GetPlayer(var_62_1, arg_62_1.user_id) then
		return
	end

	local var_62_2 = {}

	ipairs = var_6

	for iter_62_0, iter_62_1 in var_6(arg_62_1.dress_list) do
		local var_62_3 = iter_62_1.type
		local var_62_4 = iter_62_1.id
		local var_62_5 = 0

		ipairs = var_1_10014

		local var_62_6

		if not arg_62_1.dress_color then
			var_62_6 = {}
		end

		for iter_62_2, iter_62_3 in var_1_10014(var_62_6) do
			if iter_62_3.id == var_62_4 then
				var_62_5 = iter_62_3.color
			end
		end

		var_1_10014 = var_4:GetDressByType(var_62_3)

		local var_62_7 = var_4:GetCurrentColorByDressId(var_1_10014)

		if var_1_10014 ~= var_62_4 then
			var_62_2[var_62_3] = {
				changeedDressId = var_62_4,
				changedDressColorId = var_62_5
			}
		elseif var_62_7 ~= var_62_5 then
			var_62_2[var_62_3] = {
				changedDressColorId = var_62_5
			}
		end
	end

	local var_62_8 = var_2
	local var_62_9 = var_2.DispatchEvent

	IslandProxy = var_8

	local var_62_10 = var_8.LINK_CORE

	ISLAND_EVT = iter_62_0

	var_62_9(var_62_8, var_62_10, iter_62_0.CHANGE_VISTER_DRESS, {
		id = arg_62_1.user_id,
		changeDressData = var_62_2
	})
	var_4:ChangeDressupData(arg_62_1.dress_list, arg_62_1.dress_color)

	return
end

return var_0_1
