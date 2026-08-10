local var_0_0 = {}

manager.net:Bind(61071, function(arg_1_0)
	SequentialBattleData:InitData(arg_1_0)
	var_0_0.UpdateAllRedPoint(arg_1_0.main_activity_id)
end)

function var_0_0.SaveAllTeam(arg_2_0, arg_2_1)
	ReserveAction.SaveContData(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_2_0, arg_2_1)
end

function var_0_0.ResetBattle(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(61092, {
		activty_id = arg_3_0,
		reset_type = arg_3_1
	}, 61093, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			if arg_3_1 == 0 then
				ReserveAction.ResetContData(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, arg_3_0, arg_3_2)
			else
				arg_3_2()
			end
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.ReceiveReward(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(61072, {
		main_activty_id = arg_5_0,
		award_id_list = arg_5_1
	}, 61073, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			SequentialBattleData:UpdateReceiveRewardList(arg_5_0, arg_5_1)
			getReward2(mergeReward2(arg_6_0.reward_list))
			arg_5_2()
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

var_0_0.initActivityIDList_ = {}

function var_0_0.InitRedPoint(arg_7_0)
	if table.keyof(var_0_0.initActivityIDList_, arg_7_0) then
		return
	end

	table.insert(var_0_0.initActivityIDList_, arg_7_0)

	local var_7_0 = {
		string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, arg_7_0)
	}

	for iter_7_0, iter_7_1 in ipairs(ActivityCfg[arg_7_0].sub_activity_list) do
		local var_7_1 = string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, iter_7_1)

		table.insert(var_7_0, var_7_1)
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE, arg_7_0), var_7_0)
end

function var_0_0.UpdateAllRedPoint(arg_8_0)
	var_0_0.InitRedPoint(arg_8_0)

	if SequentialBattleChapterCfg.get_id_list_by_main_id[arg_8_0] == nil then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(SequentialBattleChapterCfg.get_id_list_by_main_id[arg_8_0]) do
		var_0_0.UpdateRedPoint(iter_8_1)
	end

	if ActivityData:GetActivityData(arg_8_0).stopTime <= manager.time:GetServerTime() then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, arg_8_0), 0)
	end
end

function var_0_0.UpdateRedPoint(arg_9_0)
	local var_9_0 = ActivityData:GetActivityData(arg_9_0)
	local var_9_1 = var_9_0.stopTime
	local var_9_2 = manager.time:GetServerTime()
	local var_9_3 = var_9_0.startTime

	if var_9_2 < var_9_1 and var_9_3 <= var_9_2 and getData("sequentialBattle", "activityID_" .. arg_9_0) ~= true and #SequentialBattleData:GetFinishStageList(arg_9_0) < #SequentialBattleChapterCfg[arg_9_0].stage_id then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, arg_9_0), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, arg_9_0), 0)
	end
end

function var_0_0.StopRedPoint(arg_10_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, arg_10_0), 0)
end

function var_0_0.ClickDayRedPoint(arg_11_0)
	local var_11_0 = string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, arg_11_0)

	if manager.redPoint:getTipValue(var_11_0) ~= 0 then
		manager.redPoint:setTip(var_11_0, 0)
		saveData("sequentialBattle", "activityID_" .. arg_11_0, true)
	end
end

function var_0_0.OverActivity(arg_12_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, arg_12_0), 0)

	for iter_12_0, iter_12_1 in ipairs(SequentialBattleChapterCfg.get_id_list_by_main_id[arg_12_0]) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, iter_12_1), 0)
	end
end

function var_0_0.ResetData(arg_13_0)
	var_0_0.initActivityIDList_ = {}
end

manager.notify:RegistListener(ZERO_REFRESH, function()
	for iter_14_0, iter_14_1 in pairs(var_0_0.initActivityIDList_) do
		var_0_0.UpdateAllRedPoint(iter_14_1)
	end
end)

return var_0_0
