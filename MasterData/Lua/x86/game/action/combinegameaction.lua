local var_0_0 = {}

manager.net:Bind(78051, function(arg_1_0)
	CombineGameData:InitServerData(arg_1_0)
	CombineGameAction.UpdateGameRedPoint()
	CombineGameAction.BindRedPoint()

	local var_1_0, var_1_1 = KagutsuchiGachaData:GetDrawCost(KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1], 1)

	CombineGameAction.UpdatePoolRedPoint(var_1_0)
	manager.notify:CallUpdateFunc(COMBINE_GAME_NEW_SERVER_DATA)
end)

function var_0_0.GameWin(arg_2_0, arg_2_1)
	local var_2_0

	arg_2_1 = math.max(arg_2_1, 0)

	for iter_2_0, iter_2_1 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[iter_2_0].type == CombineGameConst.TypeConst.ENDLESS then
			var_2_0 = iter_2_0
		end
	end

	if arg_2_0 ~= var_2_0 then
		arg_2_1 = nil
	end

	if ActivityCombineLevelCfg[arg_2_0].type == CombineGameConst.TypeConst.DAILY and CombineGameData:GetDataByPara("nowDay") ~= arg_2_0 then
		ShowTips("STAGE_REFRESH_DATA")

		return
	end

	manager.net:SendWithLoadingNew(78052, {
		activity_id = CombineGameData:GetDataByPara("activityId"),
		reward_id = arg_2_0,
		score = arg_2_1
	}, 78053, var_0_0.GameWinCallBack)
end

function var_0_0:GameWinCallBack(arg_3_1)
	if isSuccess(self.result) then
		CombineGameData:UpdateStageData(arg_3_1)
		getReward(formatRewardCfgList(ActivityCombineLevelCfg[arg_3_1.reward_id].reward_list))
		manager.notify:CallUpdateFunc(COMBINE_GAME_NEW_SERVER_DATA)
		CombineGameAction.UpdateGameRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0.UpdatePoolRedPoint(arg_4_0)
	local var_4_0 = KagutsuchiGachaData:GetPoolIds(ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_POOL)[1]
	local var_4_1, var_4_2 = KagutsuchiGachaData:GetDrawCost(var_4_0, 1)

	if var_4_1 == nil then
		return
	end

	if var_4_1 == arg_4_0 then
		local var_4_3 = KagutsuchiGachaData:GetMaxDrawTimes(var_4_0)
		local var_4_4 = KagutsuchiGachaData:GetPoolRemains(var_4_0)

		manager.redPoint:setTip(RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN", var_4_3 > 1 and var_4_4 > 0 and 1 or 0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE", var_4_3 == 1 and var_4_4 > 0 and 1 or 0)
	end
end

manager.notify:RegistListener(MATERIAL_MODIFY, function(arg_5_0)
	CombineGameAction.UpdatePoolRedPoint(arg_5_0)
end)

function var_0_0.UpdateGameRedPoint()
	local var_6_0 = CombineGameData:GetDataByPara("nowDay")
	local var_6_1 = CombineGameData:GetDataByPara("activityId")
	local var_6_2 = CombineGameData:GetDataByPara("stageDataTable")
	local var_6_3 = {}
	local var_6_4

	for iter_6_0, iter_6_1 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[iter_6_1].type == 1 then
			var_6_4 = iter_6_1

			manager.redPoint:setTip(string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(var_6_1), var_6_1, iter_6_1), var_6_2[iter_6_1] == true and 0 or 1)
		end

		if ActivityCombineLevelCfg[iter_6_1].type == 4 then
			table.insert(var_6_3, iter_6_1)
		end
	end

	local var_6_5 = {}

	for iter_6_2, iter_6_3 in ipairs(var_6_3) do
		local var_6_6 = string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(var_6_1), var_6_1, iter_6_3)

		manager.redPoint:setTip(var_6_6, var_6_2[var_6_4] == true and var_6_2[iter_6_3] ~= true and 1 or 0)
		table.insert(var_6_5, var_6_6)
	end

	table.insert(var_6_5, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(var_6_1), var_6_1, var_6_4))
	manager.redPoint:addGroup(string.format("%s%s_TEACH", ActivityTools.GetRedPointKey(var_6_1), var_6_1), var_6_5)
	manager.redPoint:setTip(string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(var_6_1), var_6_1), var_6_2[var_6_0] ~= true and var_6_2[var_6_4] == true and 1 or 0)
end

function var_0_0.BindRedPoint()
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL, {
		RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "TEN",
		RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL .. "ONE"
	})

	local var_7_0 = CombineGameData:GetDataByPara("activityId")
	local var_7_1 = string.format("%s%s", ActivityTools.GetRedPointKey(var_7_0), var_7_0)

	manager.redPoint:addGroup(var_7_1, {
		var_7_1 .. "_DAILY",
		var_7_1 .. "_TEACH",
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK),
		RedPointConst.ACTIVITY_SPRING_COMBINE_GAME_POOL
	})
end

return var_0_0
