local var_0_0 = {}
local var_0_1

manager.net:Bind(83221, function(arg_1_0)
	ActivityAreaBattleData:InitAreaBattleData(arg_1_0)
	var_0_0.InitRedPoint(arg_1_0.activity_id)
	var_0_0.UpdateRewardRedPoint(arg_1_0.activity_id)
end)
manager.net:Bind(83227, function(arg_2_0)
	ActivityAreaBattleData:UpdateAreaBattleData(arg_2_0)

	local var_2_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_2_0.area_battle_data.activity_id][1]

	var_0_0.UpdateRewardRedPoint(var_2_0)
end)

function var_0_0.ResetBattleData(arg_3_0, arg_3_1)
	local var_3_0 = {
		activity_id = arg_3_0,
		stage_id_list = arg_3_1
	}

	manager.net:SendWithLoadingNew(83222, var_3_0, 83223, var_0_0.ResetBattleDataCallBack)
end

function var_0_0.ResetBattleDataCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		ActivityAreaBattleData:ResetBattleData(arg_4_1)

		local var_4_0 = ActivityAreaBattleCfg[arg_4_1.activity_id]
		local var_4_1 = arg_4_1.stage_id_list[1]
		local var_4_2 = 1

		for iter_4_0, iter_4_1 in pairs(var_4_0.stage_id[3 - var_4_2]) do
			if var_4_1 == iter_4_1 then
				var_4_2 = 2
			end
		end

		saveData("AreaBattle", tostring(var_4_0.stage_id[var_4_2][3]), "")
		manager.notify:CallUpdateFunc(AREA_BATTLE_AREA_RESET)
	else
		ShowTips(GetTips(arg_4_0.result))
	end
end

function var_0_0.GetReward(arg_5_0, arg_5_1)
	local var_5_0 = {
		activity_id = arg_5_0,
		target_score_list = arg_5_1
	}

	manager.net:SendWithLoadingNew(83224, var_5_0, 83225, var_0_0.GetRewardCallBack)
end

function var_0_0.GetRewardCallBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		ActivityAreaBattleData:GetReward(arg_6_1)
		manager.notify:CallUpdateFunc(AREA_BATTLE_GET_REWARD)

		local var_6_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_6_1.activity_id][1]

		var_0_0.UpdateRewardRedPoint(var_6_0)
	else
		ShowTips(GetTips(arg_6_0.result))
	end
end

function var_0_0.SaveAffix(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {
		activity_id = arg_7_0,
		affix_list = arg_7_1,
		stage_id = arg_7_2
	}

	manager.net:SendWithLoadingNew(83228, var_7_0, 83229, var_0_0.SaveAffixCallBack)
end

function var_0_0.SaveAffixCallBack(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		-- block empty
	else
		ShowTips(GetTips(arg_8_0.result))
	end
end

function var_0_0.UpdateRewardRedPoint(arg_9_0)
	local var_9_0 = ActivityAreaBattleData:GetDataByActivityID(arg_9_0)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_REWARD, iter_9_0), 0)

		if TaskTools:IsHasReceiveTask(AssignmentCfg.get_id_list_by_activity_id[iter_9_0] or {}) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_REWARD, iter_9_0), 1)
		end
	end
end

function var_0_0.InitRedPoint(arg_10_0)
	local var_10_0 = ActivityAreaBattleData:GetDataByActivityID(arg_10_0)
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_2 = {}

		table.insert(var_10_2, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_REWARD, iter_10_0))
		table.insert(var_10_2, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA_NEW, iter_10_0))
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA, iter_10_0), var_10_2)
		table.insert(var_10_1, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA, iter_10_0))
	end

	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(arg_10_0) .. arg_10_0, var_10_1)

	if var_0_1 then
		var_0_1:Stop()

		var_0_1 = nil
	end

	var_0_1 = Timer.New(function()
		for iter_11_0, iter_11_1 in pairs(var_10_0) do
			if ActivityTools.GetActivityStatus(iter_11_0) == ActivityConst.ACTIVITY_STATE.ACTIVING and getData("AREA_BATTLE", string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA_NEW, iter_11_0)) ~= "1" then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA_NEW, iter_11_0), 1)
			end
		end
	end, 1, -1)

	var_0_1:Start()
end

return var_0_0
