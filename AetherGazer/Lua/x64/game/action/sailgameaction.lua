local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(68101, function(arg_1_0)
	local var_1_0 = arg_1_0.activity_id

	if not var_0_0.inited then
		var_0_0.InitConst(var_1_0)
		var_0_0.InitRedPoint()

		var_0_0.inited = true
	end

	SailGameData:InitData(arg_1_0)
	var_0_0.UpdateSailCountRedPoint(var_1_0)
	var_0_0.UpdatetTaskRedPoint(var_1_0)
	var_0_0.UpdateBuildingAFKRewardRedPoint(var_1_0)
	var_0_0.UpdateBuildingSetRedPoint(var_1_0)
	var_0_0.UpdateIslandUpgradeRedPoint(var_1_0)
end)
manager.net:Bind(68121, function(arg_2_0)
	local var_2_0 = arg_2_0.activity_id

	SailGameData:UpdateBuilding(var_2_0, arg_2_0.buildings)
	var_0_0.UpdatetTaskRedPoint(var_2_0)
	var_0_0.UpdateBuildingAFKRewardRedPoint(var_2_0)
	var_0_0.UpdateBuildingSetRedPoint(var_2_0)
	var_0_0.UpdateIslandUpgradeRedPoint(var_2_0)
end)
manager.net:Bind(68125, function(arg_3_0)
	local var_3_0 = arg_3_0.activity_id

	SailGameData:UpdateCompleteSailTimes(var_3_0, arg_3_0.complete_sailing_time)
	SailGameData:UpdateSailInfo(var_3_0, arg_3_0.sailing_info)
	var_0_0.UpdateSailCountRedPoint(var_3_0)
	var_0_0.UpdateIslandUpgradeRedPoint(var_3_0)
end)
manager.net:Bind(68123, function(arg_4_0)
	local var_4_0 = arg_4_0.activity_id

	SailGameData:UpdateEventInfo(var_4_0, arg_4_0.sailing_info)
end)

function var_0_0.InitConst(arg_5_0)
	SailGameConst.STAGE_TIME = SailGameConst.STAGE_TIME or {}
	SailGameConst.STAGE_TIME[arg_5_0] = {}

	local var_5_0 = GameSetting.activity_skadi_sea_event_time.value

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		SailGameConst.STAGE_TIME[arg_5_0][iter_5_1] = iter_5_0
	end

	local var_5_1 = GameSetting.activity_skadi_sea_total_time.value[1]

	SailGameConst.STAGE_TIME[arg_5_0][var_5_1] = #var_5_0 + 1
end

function var_0_0.UpgradeIsland(arg_6_0)
	local var_6_0 = {
		oper_type = 1,
		activity_id = arg_6_0
	}

	manager.net:SendWithLoadingNew(68106, var_6_0, 68107, function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			SailGameData:UpgradeIsland(arg_6_0)
			var_0_0.UpdateBuildingSetRedPoint(arg_6_0)
			var_0_0.UpdateIslandUpgradeRedPoint(arg_6_0)
			var_0_0.UpdatetTaskRedPoint(arg_6_0)
			manager.notify:CallUpdateFunc(SAIL_ISLAND_UPGRADE)
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.UnlockBuilding(arg_8_0, arg_8_1)
	local var_8_0 = {
		oper_type = 2,
		activity_id = arg_8_0,
		building_id = arg_8_1
	}

	manager.net:SendWithLoadingNew(68106, var_8_0, 68107, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			SailGameData:UnLockBuilding(arg_8_0, arg_8_1)
			var_0_0.UpdateBuildingSetRedPoint(arg_8_0)
			var_0_0.UpdateIslandUpgradeRedPoint(arg_8_0)
			var_0_0.UpdatetTaskRedPoint(arg_8_0)
			manager.notify:CallUpdateFunc(SAIL_BUILDING_UNLOCK)
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

function var_0_0.ReceiveTask(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {
		activity_id = arg_10_0,
		award_id = arg_10_1,
		award_type = arg_10_2
	}

	manager.net:SendWithLoadingNew(68108, var_10_0, 68109, function(arg_11_0)
		if isSuccess(arg_11_0.result) then
			SailGameData:ReceiveTask(arg_10_0, arg_10_1, arg_10_2)
			var_0_0.UpdatetTaskRedPoint(arg_10_0)
			getReward2(arg_11_0.reward_list)
			manager.notify:CallUpdateFunc(SAIL_TASK_RECEIVE)
		else
			ShowTips(arg_11_0.result)
		end
	end)
end

function var_0_0.ReceiveBuildingReward(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = 0
	local var_12_3 = SailGameBuildingCfg.get_id_list_by_activity_id[arg_12_0]

	for iter_12_0, iter_12_1 in ipairs(var_12_3) do
		local var_12_4 = SailGameTools.GetBuildingTotalReward(arg_12_0, iter_12_1)

		if var_12_4 > 0 then
			var_12_2 = var_12_2 + var_12_4

			local var_12_5 = SailGameBuildingCfg[iter_12_1].token_get[1]
			local var_12_6 = {
				var_12_5[1],
				var_12_4
			}

			var_12_0[#var_12_0 + 1] = var_12_6
			var_12_1[#var_12_1 + 1] = iter_12_1
		end
	end

	local var_12_7 = {
		activity_id = arg_12_0,
		building_id = var_12_1
	}

	manager.net:SendWithLoadingNew(68102, var_12_7, 68103, function(arg_13_0)
		if isSuccess(arg_13_0.result) then
			var_0_0.UpdateBuildingAFKRewardRedPoint(arg_12_0)
			var_0_0.UpdateBuildingSetRedPoint(arg_12_0)
			var_0_0.UpdateIslandUpgradeRedPoint(arg_12_0)
			manager.notify:CallUpdateFunc(SAIL_BUILDING_REWARD_RECEIVE, var_12_2)
		else
			ShowTips(arg_13_0.result)
		end
	end)
end

function var_0_0.StartGame(arg_14_0)
	local var_14_0 = {
		activity_id = arg_14_0
	}

	manager.net:SendWithLoadingNew(68104, var_14_0, 68105, function(arg_15_0)
		if isSuccess(arg_15_0.result) then
			SailGameTools.GoToGameView(arg_14_0)
		else
			ShowTips(arg_15_0.result)
		end
	end)
end

function var_0_0.GiveUp(arg_16_0)
	local var_16_0 = {
		activity_id = arg_16_0
	}

	manager.net:SendWithLoadingNew(68112, var_16_0, 68113, function(arg_17_0)
		if isSuccess(arg_17_0.result) then
			manager.notify:CallUpdateFunc(SAIL_GIVE_UP)
			SailGameTools.ShutDown()
			JumpTools.OpenPageByJump("/sailMain", {
				activityID = arg_16_0
			})
		else
			ShowTips(arg_17_0.result)
		end
	end)
end

function var_0_0.GameSettlement(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = SailGameData:GetCurGameData(arg_18_0).eventList

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		local var_18_3 = iter_18_1.rewardList

		for iter_18_2, iter_18_3 in ipairs(var_18_3) do
			if not var_18_0[iter_18_3[1]] then
				var_18_0[iter_18_3[1]] = iter_18_3[2]
			else
				var_18_0[iter_18_3[1]] = var_18_0[iter_18_3[1]] + iter_18_3[2]
			end
		end

		if iter_18_1.shopInfo ~= nil then
			for iter_18_4, iter_18_5 in ipairs(iter_18_1.shopInfo) do
				if iter_18_5.soldOut == SailGameConst.EVENT_SHOP_STATUS.SOLD_OUT then
					if not var_18_0[iter_18_5.goodID] then
						var_18_0[iter_18_5.goodID] = iter_18_5.goodNum
					else
						var_18_0[iter_18_5.goodID] = var_18_0[iter_18_5.goodID] + iter_18_5.goodNum
					end

					if not var_18_1[iter_18_5.costID] then
						var_18_1[iter_18_5.costID] = iter_18_5.costNum
					else
						var_18_1[iter_18_5.costID] = var_18_1[iter_18_5.costID] + iter_18_5.costNum
					end
				end
			end
		end
	end

	SailGameData:SaveTempSettlementData(arg_18_0, var_18_0, var_18_1)
	var_0_0.UpdateBuildingSetRedPoint(arg_18_0)
	var_0_0.UpdateIslandUpgradeRedPoint(arg_18_0)
end

function var_0_0.EventOperate(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_1 == #SailGameData:GetCurGameData(arg_19_0).eventList
	local var_19_1 = {
		activity_id = arg_19_0,
		event_order = arg_19_1,
		oper = arg_19_2,
		score = arg_19_3
	}

	manager.net:SendWithLoadingNew(68110, var_19_1, 68111, function(arg_20_0)
		if isSuccess(arg_20_0.result) then
			manager.notify:CallUpdateFunc(SAIL_EVENT_OPERATE_SUCCESS, arg_19_2)
		elseif not var_19_0 then
			ShowTips(arg_20_0.result)
		else
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("COMFIRM"),
				content = GetTips("ACTIVITY_SKADI_SEA_BE_OUT_SETTLEMENT_FAIL"),
				OkCallback = function()
					SailGameTools.ShutDown()
					JumpTools.OpenPageByJump("/sailMain", {
						activityID = arg_19_0
					})
				end,
				MaskCallback = function()
					SailGameTools.ShutDown()
					JumpTools.OpenPageByJump("/sailMain", {
						activityID = arg_19_0
					})
				end
			})
		end
	end)
end

function var_0_0.SetEventEndMark(arg_23_0, arg_23_1)
	local var_23_0 = SailGameData:GetCurGameData(arg_23_0).curStageIndex

	SailGameData:SetEventEndMark(arg_23_0, var_23_0 - 1, arg_23_1)
	SailGameData:SaveTempCurrency(arg_23_0, var_23_0 - 1)

	if not isNil(SailGameManager.Instance) then
		SailGameManager.Instance:UpdateStageIndex(var_23_0 - 1)
	end
end

function var_0_0.InitRedPoint()
	local var_24_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SAIL_GAME]

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_24_1 = {}
		local var_24_2 = SailGameBuildingCfg.get_id_list_by_activity_id[iter_24_1]

		for iter_24_2, iter_24_3 in ipairs(var_24_2) do
			var_24_1[#var_24_1 + 1] = string.format("%s_%d_%d", RedPointConst.SAIL_GAME_BUILDING_SET, iter_24_1, iter_24_3)
		end

		manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_SET, iter_24_1), var_24_1)

		local var_24_3 = {}

		var_24_3[#var_24_3 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, iter_24_1)
		var_24_3[#var_24_3 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, iter_24_1)
		var_24_3[#var_24_3 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_SET, iter_24_1)
		var_24_3[#var_24_3 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, iter_24_1)
		var_24_3[#var_24_3 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_TASK, iter_24_1)

		manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.SAIL_GAME, iter_24_1), var_24_3)
	end
end

function var_0_0.UpdateRedPoint(arg_25_0)
	if not ActivityData:GetActivityIsOpen(arg_25_0) then
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, arg_25_0), 0)
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, arg_25_0), 0)
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_SET, arg_25_0), 0)
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, arg_25_0), 0)
		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_TASK, arg_25_0), 0)
	end
end

function var_0_0.UpdateSailCountRedPoint(arg_26_0)
	local var_26_0 = #SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_26_0]
	local var_26_1 = SailGameData:GetIslandLevel(arg_26_0)
	local var_26_2 = SailGameData:GetSailCount(arg_26_0)
	local var_26_3 = 0

	if var_26_2 > 0 and var_26_1 < var_26_0 and not SailGameData:GetSelectedSailBtn(arg_26_0) then
		var_26_3 = 1
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, arg_26_0), var_26_3)
end

function var_0_0.UpdatetTaskRedPoint(arg_27_0)
	local var_27_0 = SailGameData:GetSortTaskList(arg_27_0)
	local var_27_1 = SailGameData:GetUnLockBuilding(arg_27_0)
	local var_27_2 = SailGameData:GetRceivedBuilding(arg_27_0)
	local var_27_3 = SailGameData:GetIslandLevel(arg_27_0)
	local var_27_4 = SailGameData:GetReceivedIslandLevel(arg_27_0)
	local var_27_5 = 0

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if iter_27_1.type == SailGameConst.TASK_TYPE.BUILDING then
			if var_27_1[iter_27_1.id] and not var_27_2[iter_27_1.id] then
				var_27_5 = 1

				break
			end
		else
			local var_27_6 = SailGameIslandLevelCfg[iter_27_1.id].level

			if var_27_6 <= var_27_3 and not var_27_4[var_27_6] then
				var_27_5 = 1

				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_TASK, arg_27_0), var_27_5)
end

function var_0_0.UpdateBuildingAFKRewardRedPoint(arg_28_0)
	local var_28_0 = #SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_28_0]
	local var_28_1 = SailGameData:GetIslandLevel(arg_28_0)
	local var_28_2 = 0

	if var_28_1 < var_28_0 and not SailGameData:GetSelectedMainBtn(arg_28_0) then
		local var_28_3 = 0
		local var_28_4 = SailGameBuildingCfg.get_id_list_by_activity_id[arg_28_0]

		for iter_28_0, iter_28_1 in ipairs(var_28_4) do
			var_28_3 = var_28_3 + SailGameTools.GetBuildingTotalReward(arg_28_0, iter_28_1)
		end

		if var_28_3 >= GameSetting.activity_skadi_sea_building_red_dot_need.value[1] then
			var_28_2 = 1
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, arg_28_0), var_28_2)
end

function var_0_0.UpdateBuildingSetRedPoint(arg_29_0)
	local var_29_0 = SailGameBuildingCfg.get_id_list_by_activity_id[arg_29_0]
	local var_29_1 = SailGameData:GetIslandLevel(arg_29_0)
	local var_29_2 = SailGameData:GetUnLockBuilding(arg_29_0)

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_3 = 0

		if not var_29_2[iter_29_1] and var_29_1 >= SailGameBuildingCfg[iter_29_1].unlock_level_need then
			local var_29_4 = SailGameBuildingCfg[iter_29_1].cost[1]

			var_29_3 = var_29_4[2] <= ItemTools.getItemNum(var_29_4[1]) and 1 or 0
		end

		manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.SAIL_GAME_BUILDING_SET, arg_29_0, iter_29_1), var_29_3)
	end
end

function var_0_0.UpdateIslandUpgradeRedPoint(arg_30_0)
	local var_30_0 = #SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_30_0]
	local var_30_1 = SailGameData:GetIslandLevel(arg_30_0)
	local var_30_2 = 1

	if var_30_1 < var_30_0 then
		local var_30_3 = var_30_1 + 1
		local var_30_4 = SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_30_0][var_30_3]
		local var_30_5 = SailGameIslandLevelCfg[var_30_4].unlock_level_need

		for iter_30_0, iter_30_1 in ipairs(var_30_5) do
			local var_30_6 = ConditionCfg[iter_30_1]
			local var_30_7
			local var_30_8

			if var_30_6.type == 2508 then
				var_30_7 = 1

				local var_30_9 = var_30_6.params[1]

				var_30_8 = SailGameData:GetUnLockBuilding(arg_30_0)[var_30_9] == true and 1 or 0
			elseif var_30_6.type == 2509 then
				var_30_7 = var_30_6.params[1]
				var_30_8 = SailGameData:GetCompleteSailTimes(arg_30_0)
			end

			if var_30_8 < var_30_7 then
				var_30_2 = 0

				break
			end
		end

		if var_30_2 == 1 then
			local var_30_10 = SailGameIslandLevelCfg[var_30_4].cost[1]

			var_30_2 = var_30_10[2] <= ItemTools.getItemNum(var_30_10[1]) and 1 or 0
		end
	else
		var_30_2 = 0
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, arg_30_0), var_30_2)
end

return var_0_0
