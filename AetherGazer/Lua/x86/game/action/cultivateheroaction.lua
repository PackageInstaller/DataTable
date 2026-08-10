local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(64077, function(arg_1_0)
	if var_0_1 == false then
		CultivateHeroData:Init()

		var_0_1 = true
	end

	CultivateHeroData:SetData(arg_1_0)
end)
manager.net:Bind(64081, function(arg_2_0)
	CultivateHeroData:UpdateHeroTask(arg_2_0)
end)
manager.net:Bind(64083, function(arg_3_0)
	CultivateHeroData:UpdateDailyTask(arg_3_0)
end)

function var_0_0.RequireReceiveAccumulateTask(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		point_reward_id_list = {
			arg_4_1
		}
	}

	manager.net:SendWithLoadingNew(60054, var_4_0, 60055, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			getReward2(arg_5_0.reward_list)
			CultivateHeroData:SetReceivedAccumulateTask(arg_4_1, arg_4_0)

			if arg_4_2 then
				arg_4_2()
			end
		else
			ShowTips(arg_5_0.result)
		end
	end)
end

function var_0_0.RequireReceiveDailyTask(arg_6_0, arg_6_1)
	manager.net:SendWithLoadingNew(64084, {
		activity_id = arg_6_0
	}, 64085, function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			local var_7_0 = arg_7_0.reward_list

			getReward2(var_7_0)
			CultivateHeroData:SetReceivedDailyTask(arg_6_0)

			if arg_6_1 then
				arg_6_1()
			end
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.RequireReceiveHeroTaskList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		activity_id = arg_8_0,
		task_id_list = arg_8_1
	}

	manager.net:SendWithLoadingNew(64078, var_8_0, 64079, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			local var_9_0 = arg_9_0.reward_list

			getReward2(mergeReward2(var_9_0))
			CultivateHeroData:SetReceivedHeroTaskList(arg_8_1, arg_8_0)

			if arg_8_2 then
				arg_8_2()
			end
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

function var_0_0.InitRedPointKey(arg_10_0)
	local var_10_0 = string.format("%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_10_0)

	if ActivityCultivateHeroCfg[arg_10_0] == nil then
		return
	end

	local var_10_1 = ActivityCultivateHeroCfg[arg_10_0].group
	local var_10_2 = {}
	local var_10_3

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_4 = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_10_0, iter_10_1)

		var_10_2[#var_10_2 + 1] = var_10_4
	end

	manager.redPoint:addGroup(var_10_0, var_10_2)

	local var_10_5 = string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_10_0)
	local var_10_6 = string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_10_0)
	local var_10_7 = string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_10_0)

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.CULTIVATE_HERO, arg_10_0), {
		var_10_5,
		var_10_0,
		var_10_6,
		var_10_7
	})
	manager.notify:RegistListener(ACTIVITY_PT_UPDATE, var_0_0.OnDailyPtUpdate)
end

function var_0_0.OnDailyPtUpdate()
	local var_11_0 = ActivityCultivateHeroCfg.all

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if ActivityData:GetActivityIsOpen(iter_11_1) and var_0_1 == true then
			CultivateHeroData:RefreshDailyRedPoint(iter_11_1)
		end
	end
end

function var_0_0.RefreshRedPoint(arg_12_0)
	local var_12_0 = ActivityData:GetActivityData(arg_12_0)

	if not var_12_0 or not var_12_0:IsActivitying() then
		CultivateHeroAction.ClearRed(arg_12_0)

		return
	end
end

function var_0_0.ClearRed(arg_13_0)
	local var_13_0 = string.format("%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0)

	if ActivityCultivateHeroCfg[arg_13_0] == nil then
		return
	end

	local var_13_1 = ActivityCultivateHeroCfg[arg_13_0].group
	local var_13_2 = {}
	local var_13_3

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_4 = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0, iter_13_1)

		manager.redPoint:setTip(var_13_4, 0)
	end

	manager.redPoint:setTip(var_13_0, 0)

	local var_13_5 = string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_13_0)
	local var_13_6 = string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0)
	local var_13_7 = string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0)

	manager.redPoint:setTip(var_13_5, 0)
	manager.redPoint:setTip(var_13_6, 0)
	manager.redPoint:setTip(var_13_7, 0)
end

return var_0_0
