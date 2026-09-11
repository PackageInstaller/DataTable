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
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = {
			arg_4_1
		}
	}, 60055, function(arg_5_0)
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
			getReward2(arg_7_0.reward_list)
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
	manager.net:SendWithLoadingNew(64078, {
		activity_id = arg_8_0,
		task_id_list = arg_8_1
	}, 64079, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			getReward2(mergeReward2(arg_9_0.reward_list))
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
	local var_10_1

	if ActivityCultivateHeroCfg[arg_10_0] == nil then
		do return end

		var_10_1 = {}
	end

	for iter_10_0, iter_10_1 in ipairs(ActivityCultivateHeroCfg[arg_10_0].group) do
		var_10_1[#var_10_1 + 1] = string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_10_0, iter_10_1)
	end

	manager.redPoint:addGroup(var_10_0, var_10_1)
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.CULTIVATE_HERO, arg_10_0), {
		string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_10_0),
		var_10_0,
		string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_10_0),
		(string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_10_0))
	})
	manager.notify:RegistListener(ACTIVITY_PT_UPDATE, var_0_0.OnDailyPtUpdate)
end

function var_0_0.OnDailyPtUpdate()
	for iter_11_0, iter_11_1 in ipairs(ActivityCultivateHeroCfg.all) do
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
	if ActivityCultivateHeroCfg[arg_13_0] == nil then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(ActivityCultivateHeroCfg[arg_13_0].group) do
		manager.redPoint:setTip(string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0, iter_13_1), 0)
	end

	manager.redPoint:setTip(string.format("%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0), 0)
	manager.redPoint:setTip(string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_13_0), 0)
	manager.redPoint:setTip(string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0), 0)
	manager.redPoint:setTip(string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_13_0), 0)
end

return var_0_0
