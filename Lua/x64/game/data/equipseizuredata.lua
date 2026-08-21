local var_0_0 = singletonClass("EquipSeizureData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageID_ = nil
	arg_1_0.challengeRate_ = 1
	arg_1_0.affixIDList_ = {}
	arg_1_0.receivedList_ = {}
	arg_1_0.canReceiveList_ = {}
	arg_1_0.affixRefreshTimestamp_ = 0
	arg_1_0.todayMaxScore_ = 0
	arg_1_0.sumScore_ = 0
	arg_1_0.nextRefreshTimestamp_ = 0
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.stageID_ = arg_2_1.stage_id
	arg_2_0.challengeRate_ = arg_2_1.challenge_rate or 1
	arg_2_0.affixRefreshTimestamp_ = arg_2_1.affix_info.refresh_timestamp or 0
	arg_2_0.affixIDList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.affix_info.affix_id_list) do
		table.insert(arg_2_0.affixIDList_, iter_2_1)
	end

	arg_2_0.todayMaxScore_ = arg_2_1.today_max_score or 0
	arg_2_0.sumScore_ = arg_2_1.sum_score or 0
	arg_2_0.nextRefreshTimestamp_ = arg_2_1.refresh_timestamp or 0

	if arg_2_0.affixRefreshTimestamp_ > arg_2_0.nextRefreshTimestamp_ then
		arg_2_0.affixRefreshTimestamp_ = arg_2_0.nextRefreshTimestamp_
	end

	arg_2_0.receivedList_ = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.got_reward_id_list) do
		table.insert(arg_2_0.receivedList_, iter_2_3)
	end

	arg_2_0:CheckRedPoint()
	arg_2_0:SortRewardList()
end

function var_0_0.RefreshBattleScore(arg_3_0, arg_3_1)
	arg_3_0.isValid_ = arg_3_1.is_valid
	arg_3_0.resultScore_ = arg_3_1.score or 0

	if arg_3_1.is_valid and arg_3_0.resultScore_ > arg_3_0.todayMaxScore_ then
		arg_3_0.todayMaxScore_ = arg_3_0.resultScore_
		arg_3_0.sumScore_ = arg_3_1.sum_score or arg_3_0.sumScore_

		arg_3_0:CheckRedPoint()
		arg_3_0:SortRewardList()
	end
end

function var_0_0.GetStageID(arg_4_0)
	return arg_4_0.stageID_
end

function var_0_0.GetChallengeRate(arg_5_0)
	return arg_5_0.challengeRate_
end

function var_0_0.GetAffixRefreshTimestamp(arg_6_0)
	return arg_6_0.affixRefreshTimestamp_
end

function var_0_0.GetAffixIDList(arg_7_0)
	return arg_7_0.affixIDList_
end

function var_0_0.GetTodayMaxScore(arg_8_0)
	return arg_8_0.todayMaxScore_
end

function var_0_0.GetTotalScore(arg_9_0)
	return arg_9_0.sumScore_
end

function var_0_0.NextRefreshTimestamp(arg_10_0)
	return arg_10_0.nextRefreshTimestamp_
end

function var_0_0.GetResultScore(arg_11_0)
	return arg_11_0.resultScore_
end

function var_0_0.GetCanReceiveList(arg_12_0)
	return arg_12_0.canReceiveList_
end

function var_0_0.GetReceiveList(arg_13_0)
	return arg_13_0.receivedList_
end

function var_0_0.GetSortRewardList(arg_14_0)
	return arg_14_0.sortRewardList_
end

function var_0_0.ReceiveReward(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(arg_15_0.receivedList_, iter_15_1)
	end

	arg_15_0:CheckRedPoint()
	arg_15_0:SortRewardList()
end

function var_0_0.SortRewardList(arg_16_0)
	arg_16_0.canReceiveList_ = {}

	local var_16_0 = {}
	local var_16_1 = arg_16_0:GetTotalScore()

	for iter_16_0, iter_16_1 in ipairs(EquipSeizurePointRewardCfg.all) do
		if var_16_1 < EquipSeizurePointRewardCfg[iter_16_1].need then
			table.insert(var_16_0, iter_16_1)
		elseif table.keyof(arg_16_0.receivedList_, iter_16_1) == nil then
			table.insert(arg_16_0.canReceiveList_, iter_16_1)
		end
	end

	local var_16_2 = {}

	table.insertto(var_16_2, arg_16_0.canReceiveList_)
	table.insertto(var_16_2, var_16_0)
	table.insertto(var_16_2, arg_16_0.receivedList_)

	arg_16_0.sortRewardList_ = var_16_2
end

function var_0_0.CheckRedPoint(arg_17_0)
	local var_17_0 = arg_17_0:GetTotalScore()

	for iter_17_0, iter_17_1 in ipairs(EquipSeizurePointRewardCfg.all) do
		if var_17_0 >= EquipSeizurePointRewardCfg[iter_17_1].need and not table.keyof(arg_17_0.receivedList_, iter_17_1) then
			manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_REWARD, 0)
end

return var_0_0
