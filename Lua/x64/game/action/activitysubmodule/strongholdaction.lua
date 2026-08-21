local var_0_0 = {}

manager.net:Bind(65415, function(arg_1_0)
	StrongholdData:InitData(arg_1_0)
	var_0_0.CheckRewardRedPoint()
	var_0_0.CheckIncreaseRedPoint()
end)
manager.net:Bind(65417, function(arg_2_0)
	StrongholdData:InitRoomExt(arg_2_0)
end)
manager.net:Bind(65419, function(arg_3_0)
	StrongholdData:InitStrongholdResultData(arg_3_0)
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_4_0)
	if arg_4_0 == CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_1 or arg_4_0 == CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_2 or arg_4_0 == CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_3 then
		var_0_0.CheckRewardRedPoint()
		var_0_0.CheckIncreaseRedPoint()
	end
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.CheckTaskRedPoint()
end)

function var_0_0.QueryChooseRoomSkillType(arg_6_0, arg_6_1)
	local var_6_0, var_6_1, var_6_2, var_6_3 = StrongholdData:GetStrongholdLevel(arg_6_1)
	local var_6_4 = StrongholdData:GetSkillLimitLv()

	if var_6_1 < var_6_4 then
		local var_6_5 = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. arg_6_1)

		ShowTips(string.format(GetTips("ACTIVITY_STRONGHOLD_TYPE_LIMIT_LV"), var_6_5, var_6_4))

		return
	end

	manager.net:SendWithLoadingNew(65410, {
		room_id = arg_6_0,
		type = arg_6_1
	}, 65411, var_0_0.OnChooseRoomSkillTypeCallBack)
end

function var_0_0.OnChooseRoomSkillTypeCallBack(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		-- block empty
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.QueryUpgradeIncrease(arg_8_0, arg_8_1)
	local var_8_0 = StrongholdData:GetUsePoint(arg_8_0)
	local var_8_1, var_8_2 = StrongholdData:GetStrongholdLevelAndIncreasePoint(arg_8_0)
	local var_8_3 = var_8_2 - var_8_0
	local var_8_4 = ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[arg_8_1][StrongholdData:GetIncreaseLevel(arg_8_0, arg_8_1) + 1]
	local var_8_5 = ActivityStrongholdIncreaseCfg[var_8_4]

	if not var_8_5 then
		return
	end

	if var_8_3 < var_8_5.cost then
		ShowTips("ACTIVITY_STRONGHOLD_LACK_INCREASE_POINT")

		return
	end

	manager.net:SendWithLoadingNew(65412, {
		activity_id = arg_8_0,
		skill_id = arg_8_1
	}, 65413, var_0_0.OnUpgradeIncreaseCallBack)
end

function var_0_0.OnUpgradeIncreaseCallBack(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		StrongholdData:UpgradeIncreaseLevel(arg_9_1.activity_id, arg_9_1.skill_id)
		manager.notify:CallUpdateFunc(STRONGHOLD_UPGRADE_INCREASE)
		var_0_0.CheckIncreaseRedPoint()
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.QueryReward(arg_10_0, arg_10_1)
	manager.net:SendWithLoadingNew(65420, {
		activity_id = arg_10_0,
		reward_id = arg_10_1
	}, 65421, var_0_0.OnRewardCallBack)
end

function var_0_0.OnRewardCallBack(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		StrongholdData:UpdateReward(arg_11_1.activity_id, arg_11_1.reward_id)

		local var_11_0 = arg_11_0.reward_list
		local var_11_1 = mergeReward2(var_11_0)

		getReward(var_11_1)
		manager.notify:CallUpdateFunc(STRONGHOLD_UPDATE_REWARD)
		var_0_0.CheckRewardRedPoint()
	else
		ShowTips(arg_11_0.result)
	end
end

function var_0_0.UpgradeAltas(arg_12_0, arg_12_1)
	StrongholdData:UpgradeAltas(arg_12_0, arg_12_1)
end

function var_0_0.CheckRewardRedPoint()
	for iter_13_0, iter_13_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
		local var_13_0 = false

		if ActivityData:GetActivityIsOpen(iter_13_1) then
			for iter_13_2, iter_13_3 in ipairs(ActivityStrongholdRewardCfg.all) do
				if StrongholdData:GetRewardState(iter_13_1, iter_13_3) == 0 then
					var_13_0 = true

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, iter_13_1), var_13_0 and 1 or 0)
	end
end

function var_0_0.CheckIncreaseRedPoint()
	for iter_14_0, iter_14_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
		local var_14_0 = false

		if ActivityData:GetActivityIsOpen(iter_14_1) then
			local var_14_1, var_14_2 = StrongholdData:GetStrongholdLevelAndIncreasePoint(iter_14_1)
			local var_14_3 = var_14_2 - StrongholdData:GetUsePoint(iter_14_1)

			for iter_14_2, iter_14_3 in pairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id) do
				local var_14_4 = iter_14_3[StrongholdData:GetIncreaseLevel(iter_14_1, iter_14_2) + 1]
				local var_14_5 = ActivityStrongholdIncreaseCfg[var_14_4]

				if var_14_5 and var_14_3 >= var_14_5.cost then
					var_14_0 = true

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, iter_14_1), var_14_0 and 1 or 0)
	end
end

function var_0_0.CheckTaskRedPoint()
	for iter_15_0, iter_15_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
		local var_15_0 = false

		if ActivityData:GetActivityIsOpen(iter_15_1) then
			local var_15_1 = ActivityCfg[iter_15_1]

			for iter_15_2, iter_15_3 in ipairs(var_15_1.sub_activity_list) do
				if ActivityTemplateConst.TASK == ActivityCfg[iter_15_3].activity_template and #TaskTools:GetCanGetActivityTaskList(iter_15_3) > 0 then
					var_15_0 = true

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, iter_15_1), var_15_0 and 1 or 0)
	end
end

return var_0_0
