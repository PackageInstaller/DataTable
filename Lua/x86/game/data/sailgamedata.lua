local var_0_0 = singletonClass("SailGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.tempRewardDic_ = {}
	arg_1_0.selectedSailBtn_ = {}
	arg_1_0.selectedMainBtn_ = {}
	arg_1_0.islandLevel_ = {}
	arg_1_0.unlockBuildingDic_ = {}
	arg_1_0.lastReceiveTimeStepList_ = {}
	arg_1_0.gameDataList_ = {}
	arg_1_0.fullRecoverTimeStepList_ = {}
	arg_1_0.tempSettlementDataList_ = {}
	arg_1_0.accumulateSailTimes_ = {}
	arg_1_0.tempCurrency_ = {}
	arg_1_0.eventEndMark_ = {}
	arg_1_0.receivedBuildingDic_ = {}
	arg_1_0.receivedIslandLevelDic_ = {}
	arg_1_0.sortedTaskList_ = {}
	arg_1_0.needSortTask_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	arg_2_0.selectedSailBtn_[var_2_0] = false
	arg_2_0.selectedMainBtn_[var_2_0] = false

	local var_2_1 = arg_2_1.island_info

	arg_2_0.islandLevel_[var_2_0] = var_2_1.island_level
	arg_2_0.receivedBuildingDic_[var_2_0] = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1.building_reward_achive) do
		arg_2_0.receivedBuildingDic_[var_2_0][iter_2_1] = true
	end

	arg_2_0.receivedIslandLevelDic_[var_2_0] = {}

	for iter_2_2, iter_2_3 in ipairs(var_2_1.island_reward_achive) do
		arg_2_0.receivedIslandLevelDic_[var_2_0][iter_2_3] = true
	end

	arg_2_0:UpdateBuilding(var_2_0, var_2_1.buildings)
	arg_2_0:UpdateSailInfo(var_2_0, arg_2_1.sailing_info)
	arg_2_0:UpdateCompleteSailTimes(var_2_0, arg_2_1.complete_sailing_time)
end

function var_0_0.UpdateBuilding(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.unlockBuildingDic_[arg_3_1] = {}
	arg_3_0.lastReceiveTimeStepList_[arg_3_1] = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		arg_3_0.unlockBuildingDic_[arg_3_1][iter_3_1.building_id] = true
		arg_3_0.lastReceiveTimeStepList_[arg_3_1][iter_3_1.building_id] = iter_3_1.last_yield_timestamp
	end

	arg_3_0.needSortTask_[arg_3_1] = true
end

function var_0_0.UpdateSailInfo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.fullRecoverTimeStepList_[arg_4_1] = arg_4_2.next_reach_max_times_timestamp

	local var_4_0 = arg_4_0.gameDataList_[arg_4_1] or {}
	local var_4_1 = arg_4_2.event_list

	if not var_4_0.eventList or #var_4_0.eventList ~= #var_4_1 then
		var_4_0.eventList = {}
	end

	if #var_4_1 > 0 then
		var_4_0.gameState = SailGameConst.GAME_STATUS.RUNNING

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			arg_4_0:UpdateSingleEventInfo(var_4_0, iter_4_1)
		end
	else
		var_4_0.gameState = SailGameConst.GAME_STATUS.OVER
	end

	arg_4_0.gameDataList_[arg_4_1] = var_4_0
	arg_4_0.needSortTask_[arg_4_1] = true

	if var_4_0.gameState == SailGameConst.GAME_STATUS.RUNNING then
		arg_4_0:InitTempCurrency(arg_4_1)

		arg_4_0.eventEndMark_[arg_4_1] = {}
		arg_4_0.eventEndMark_[arg_4_1].isEnd = false
	end
end

function var_0_0.UpdateCompleteSailTimes(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.accumulateSailTimes_[arg_5_1] = arg_5_2
end

function var_0_0.UpdateEventInfo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.gameDataList_[arg_6_1]

	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		arg_6_0:UpdateSingleEventInfo(var_6_0, iter_6_1, arg_6_1)
	end
end

function var_0_0.UpdateSingleEventInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1.eventList[arg_7_2.event_order] or {}

	if arg_7_2.event_status == SailGameConst.EVENT_STATUS.RUNNING then
		arg_7_1.curStageIndex = arg_7_2.event_order
	end

	var_7_0.order = arg_7_2.event_order
	var_7_0.id = arg_7_2.event_id
	var_7_0.status = arg_7_2.event_status
	var_7_0.rewardList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_2.event_reward) do
		var_7_0.rewardList[iter_7_0] = {
			iter_7_1.reward_id,
			iter_7_1.reward_num
		}
	end

	var_7_0.lotteryInfo = nil

	if #arg_7_2.sailing_event_gamble_result > 0 then
		var_7_0.lotteryInfo = {}

		for iter_7_2, iter_7_3 in ipairs(arg_7_2.sailing_event_gamble_result) do
			var_7_0.lotteryInfo[iter_7_2] = {}
			var_7_0.lotteryInfo[iter_7_2].order = iter_7_3.gamble_order
			var_7_0.lotteryInfo[iter_7_2].result = iter_7_3.gamble_result
		end
	end

	var_7_0.shopInfo = nil

	if #arg_7_2.sailing_event_trade_commodity > 0 then
		var_7_0.shopInfo = {}

		for iter_7_4, iter_7_5 in ipairs(arg_7_2.sailing_event_trade_commodity) do
			local var_7_1 = iter_7_5.commodity_order

			var_7_0.shopInfo[var_7_1] = {}
			var_7_0.shopInfo[var_7_1].order = iter_7_5.commodity_order
			var_7_0.shopInfo[var_7_1].costID = iter_7_5.currency_id
			var_7_0.shopInfo[var_7_1].costNum = iter_7_5.currency_num
			var_7_0.shopInfo[var_7_1].goodID = iter_7_5.commodity_id
			var_7_0.shopInfo[var_7_1].goodNum = iter_7_5.commodity_num
			var_7_0.shopInfo[var_7_1].soldOut = iter_7_5.is_sell_out
		end
	end

	if arg_7_2.sailing_event_gift ~= nil then
		var_7_0.giftInfo = var_7_0.giftInfo or {}
		var_7_0.giftInfo.order = arg_7_2.sailing_event_gift.gift_order
		var_7_0.giftInfo.itemID = arg_7_2.sailing_event_gift.gift_id
		var_7_0.giftInfo.itemNum = arg_7_2.sailing_event_gift.gift_num
	end

	arg_7_1.eventList[arg_7_2.event_order] = var_7_0

	if var_7_0.id == 0 and var_7_0.status == SailGameConst.EVENT_STATUS.OVER then
		SailGameAction.GameSettlement(arg_7_3)
	end
end

function var_0_0.SaveTempSettlementData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.tempSettlementDataList_[arg_8_1] = arg_8_0.tempSettlementDataList_[arg_8_1] or {}
	arg_8_0.tempSettlementDataList_[arg_8_1].getDic = arg_8_2
	arg_8_0.tempSettlementDataList_[arg_8_1].costDic = arg_8_3
end

function var_0_0.GetTempSettlementData(arg_9_0, arg_9_1)
	return arg_9_0.tempSettlementDataList_[arg_9_1]
end

function var_0_0.GetCompleteSailTimes(arg_10_0, arg_10_1)
	return arg_10_0.accumulateSailTimes_[arg_10_1] or 0
end

function var_0_0.GetSailCount(arg_11_0, arg_11_1)
	local var_11_0 = 0
	local var_11_1 = GameSetting.activity_skadi_sea_be_out_num_max.value[1]
	local var_11_2 = arg_11_0:GetFullRecoverTimeStep(arg_11_1)
	local var_11_3 = manager.time:GetServerTime()

	if var_11_3 < var_11_2 then
		local var_11_4 = SailGameTools.GetSailRecoverTime()
		local var_11_5 = var_11_2 - var_11_3

		var_11_0 = var_11_1 - math.ceil(var_11_5 / var_11_4)
	else
		var_11_0 = var_11_1
	end

	return var_11_0
end

function var_0_0.GetSelectedSailBtn(arg_12_0, arg_12_1)
	return arg_12_0.selectedSailBtn_[arg_12_1]
end

function var_0_0.SetSelectedSailBtn(arg_13_0, arg_13_1)
	if manager.redPoint:getTipBoolean(string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, arg_13_1)) then
		arg_13_0.selectedSailBtn_[arg_13_1] = true

		SailGameAction.UpdateSailCountRedPoint(arg_13_1)
	end
end

function var_0_0.GetSelectedMainBtn(arg_14_0, arg_14_1)
	return arg_14_0.selectedMainBtn_[arg_14_1]
end

function var_0_0.SetSelectedMainBtn(arg_15_0, arg_15_1)
	if manager.redPoint:getTipBoolean(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, arg_15_1)) then
		arg_15_0.selectedMainBtn_[arg_15_1] = true

		SailGameAction.UpdateBuildingAFKRewardRedPoint(arg_15_1)
	end
end

function var_0_0.GetCurGameData(arg_16_0, arg_16_1)
	return arg_16_0.gameDataList_[arg_16_1]
end

function var_0_0.GetFullRecoverTimeStep(arg_17_0, arg_17_1)
	return arg_17_0.fullRecoverTimeStepList_[arg_17_1] or 0
end

function var_0_0.SetEventEndMark(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.eventEndMark_[arg_18_1] = arg_18_0.eventEndMark_[arg_18_1] or {}
	arg_18_0.eventEndMark_[arg_18_1].isEnd = true
	arg_18_0.eventEndMark_[arg_18_1].stageIndex = arg_18_2
	arg_18_0.eventEndMark_[arg_18_1].tipsIndex = arg_18_3
end

function var_0_0.GetEventEndMark(arg_19_0, arg_19_1)
	local var_19_0 = deepClone(arg_19_0.eventEndMark_[arg_19_1])

	arg_19_0.eventEndMark_[arg_19_1].isEnd = false

	return var_19_0
end

function var_0_0.GetEventReward(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = 0
	local var_20_1 = arg_20_0:GetCurGameData(arg_20_1).eventList[arg_20_2]

	if var_20_1.status == SailGameConst.EVENT_STATUS.OVER then
		local var_20_2 = var_20_1.rewardList

		if #var_20_2 > 0 then
			for iter_20_0, iter_20_1 in ipairs(var_20_2) do
				if iter_20_1[1] == CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id then
					var_20_0 = var_20_0 + iter_20_1[2]
				end
			end
		end

		if var_20_1.shopInfo ~= nil then
			for iter_20_2, iter_20_3 in ipairs(var_20_1.shopInfo) do
				if iter_20_3.soldOut == SailGameConst.EVENT_SHOP_STATUS.SOLD_OUT and iter_20_3.goodID == CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id then
					var_20_0 = var_20_0 + iter_20_3.goodNum
				end
			end
		end
	end

	return var_20_0
end

function var_0_0.InitTempCurrency(arg_21_0, arg_21_1)
	arg_21_0.tempCurrency_[arg_21_1] = arg_21_0.tempCurrency_[arg_21_1] or {}

	local var_21_0 = arg_21_0.gameDataList_[arg_21_1].curStageIndex
	local var_21_1 = 0

	for iter_21_0 = 1, var_21_0 - 1 do
		var_21_1 = var_21_1 + arg_21_0:GetEventReward(arg_21_1, iter_21_0)
	end

	arg_21_0.tempCurrency_[arg_21_1].lastNum = var_21_1
	arg_21_0.tempCurrency_[arg_21_1].curNum = var_21_1
end

function var_0_0.SaveTempCurrency(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:GetEventReward(arg_22_1, arg_22_2)

	arg_22_0.tempCurrency_[arg_22_1].lastNum = arg_22_0.tempCurrency_[arg_22_1].curNum
	arg_22_0.tempCurrency_[arg_22_1].curNum = arg_22_0.tempCurrency_[arg_22_1].curNum + var_22_0
end

function var_0_0.GetTempCurrency(arg_23_0, arg_23_1)
	return arg_23_0.tempCurrency_[arg_23_1]
end

function var_0_0.GetBuildingData(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.buildingDataList_[arg_24_1] then
		return arg_24_0.buildingDataList_[arg_24_1][arg_24_2] or {}
	end

	return {}
end

function var_0_0.UnLockBuilding(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.unlockBuildingDic_[arg_25_1][arg_25_2] = true
	arg_25_0.needSortTask_[arg_25_1] = true
end

function var_0_0.GetUnLockBuilding(arg_26_0, arg_26_1)
	return arg_26_0.unlockBuildingDic_[arg_26_1]
end

function var_0_0.GetRceivedBuilding(arg_27_0, arg_27_1)
	return arg_27_0.receivedBuildingDic_[arg_27_1]
end

function var_0_0.GetBuildingLastReceiveTimeList(arg_28_0, arg_28_1)
	return arg_28_0.lastReceiveTimeStepList_[arg_28_1]
end

function var_0_0.GetIslandLevel(arg_29_0, arg_29_1)
	return arg_29_0.islandLevel_[arg_29_1]
end

function var_0_0.UpgradeIsland(arg_30_0, arg_30_1)
	arg_30_0.islandLevel_[arg_30_1] = arg_30_0.islandLevel_[arg_30_1] + 1
	arg_30_0.needSortTask_[arg_30_1] = true
end

function var_0_0.GetReceivedIslandLevel(arg_31_0, arg_31_1)
	return arg_31_0.receivedIslandLevelDic_[arg_31_1]
end

function var_0_0.ReceiveTask(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_3 == SailGameConst.TASK_TYPE.BUILDING then
		arg_32_0.receivedBuildingDic_[arg_32_1][arg_32_2] = true
	elseif arg_32_3 == SailGameConst.TASK_TYPE.ISLAND_LEVEL then
		local var_32_0 = arg_32_2

		arg_32_0.receivedIslandLevelDic_[arg_32_1][var_32_0] = true
	end

	arg_32_0.needSortTask_[arg_32_1] = true
end

function var_0_0.GetSortTaskList(arg_33_0, arg_33_1)
	if not arg_33_0.needSortTask_[arg_33_1] then
		return arg_33_0.sortedTaskList_[arg_33_1]
	end

	arg_33_0.needSortTask_[arg_33_1] = false

	local var_33_0 = {}
	local var_33_1 = {}
	local var_33_2 = {}
	local var_33_3 = SailGameBuildingCfg.get_id_list_by_activity_id[arg_33_1]
	local var_33_4 = arg_33_0:GetUnLockBuilding(arg_33_1)
	local var_33_5 = arg_33_0:GetRceivedBuilding(arg_33_1)

	for iter_33_0, iter_33_1 in ipairs(var_33_3) do
		if var_33_5[iter_33_1] then
			var_33_1[#var_33_1 + 1] = {
				id = iter_33_1,
				type = SailGameConst.TASK_TYPE.BUILDING
			}
		elseif var_33_4[iter_33_1] then
			var_33_0[#var_33_0 + 1] = {
				id = iter_33_1,
				type = SailGameConst.TASK_TYPE.BUILDING
			}
		else
			var_33_2[#var_33_2 + 1] = {
				id = iter_33_1,
				type = SailGameConst.TASK_TYPE.BUILDING
			}
		end
	end

	local var_33_6 = SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_33_1]
	local var_33_7 = arg_33_0:GetIslandLevel(arg_33_1)
	local var_33_8 = arg_33_0:GetReceivedIslandLevel(arg_33_1)

	for iter_33_2, iter_33_3 in ipairs(var_33_6) do
		local var_33_9 = SailGameIslandLevelCfg[iter_33_3].level

		if var_33_9 > 1 then
			if var_33_8[var_33_9] then
				var_33_1[#var_33_1 + 1] = {
					id = iter_33_3,
					type = SailGameConst.TASK_TYPE.ISLAND_LEVEL
				}
			elseif var_33_9 <= var_33_7 then
				var_33_0[#var_33_0 + 1] = {
					id = iter_33_3,
					type = SailGameConst.TASK_TYPE.ISLAND_LEVEL
				}
			else
				var_33_2[#var_33_2 + 1] = {
					id = iter_33_3,
					type = SailGameConst.TASK_TYPE.ISLAND_LEVEL
				}
			end
		end
	end

	local var_33_10 = handler(arg_33_0, arg_33_0.SortCompareFunc)

	table.sort(var_33_1, var_33_10)
	table.sort(var_33_0, var_33_10)
	table.sort(var_33_2, var_33_10)
	table.insertto(var_33_0, var_33_2)
	table.insertto(var_33_0, var_33_1)

	arg_33_0.sortedTaskList_[arg_33_1] = var_33_0

	return var_33_0
end

function var_0_0.SortCompareFunc(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1.type == arg_34_2.type then
		return arg_34_1.id < arg_34_2.id
	else
		return arg_34_1.type < arg_34_2.type
	end
end

return var_0_0
