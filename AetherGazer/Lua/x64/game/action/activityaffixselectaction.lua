local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	var_0_1 = false
end

manager.notify:RegistListener(ACTIVITY_REWARD_GET, function(arg_2_0)
	ActivityAffixSelectData:OnScoreRewardGet(arg_2_0.point_reward_id_list)
	var_0_0.UpdateScoreBonusRedPoint()
end)
manager.net:Bind(11073, function(arg_3_0)
	ActivityAffixSelectData:OnPushMainActivityData(arg_3_0)
end)
manager.net:Bind(11075, function(arg_4_0)
	ActivityAffixSelectData:OnPushSubActivityData(arg_4_0)
	var_0_0.UpdateFirstBonusRedPoint()
	var_0_0.UpdateUnPassRedPoint()
	var_0_0.UpdateScoreBonusRedPoint()
end)

function var_0_0.InitRedPointKey(arg_5_0)
	local var_5_0 = {
		string.format("%s_%s", RedPointConst.AFFIX_SELECT_BONUS_UNPASS, arg_5_0),
		string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, arg_5_0),
		string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, arg_5_0)
	}

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.AFFIX_SELECT, arg_5_0), var_5_0)
end

function var_0_0.UpdateUnPassRedPoint()
	local var_6_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT] or {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = false

		if ActivityData:GetActivityIsOpen(iter_6_1) then
			local var_6_2 = ActivityAffixSelectData:GetOpenedSubActivityDatas(iter_6_1)

			if not var_0_1 then
				for iter_6_2, iter_6_3 in pairs(var_6_2) do
					if ActivityData:GetActivityIsOpen(iter_6_3.activityId) and iter_6_3.clickState == 1 then
						var_6_1 = true

						break
					end
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.AFFIX_SELECT_BONUS_UNPASS, iter_6_1), var_6_1 and 1 or 0)
	end
end

function var_0_0.ReadUnPassRedPoint()
	var_0_0.UpdateUnPassRedPoint()
end

function var_0_0.UpdateFirstBonusRedPoint()
	local var_8_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT] or {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = false

		if ActivityData:GetActivityIsOpen(iter_8_1) then
			local var_8_2 = ActivityAffixSelectData:GetOpenedSubActivityDatas(iter_8_1)

			for iter_8_2, iter_8_3 in pairs(var_8_2) do
				if ActivityData:GetActivityIsOpen(iter_8_3.activityId) and iter_8_3.clearState == 2 then
					var_8_1 = true

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, iter_8_1), var_8_1 and 1 or 0)
	end
end

function var_0_0.UpdateScoreBonusRedPoint()
	local var_9_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_AFFIX_SELECT] or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = false

		if ActivityData:GetActivityIsOpen(iter_9_1) then
			local var_9_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[iter_9_1]

			for iter_9_2, iter_9_3 in ipairs(var_9_2) do
				local var_9_3 = ActivityPointRewardCfg[iter_9_3]
				local var_9_4 = ActivityData:GetActivityIsOpen(var_9_3.activity_id)
				local var_9_5 = ActivityAffixSelectData:GetTotalScore(iter_9_1) >= var_9_3.need
				local var_9_6 = ActivityAffixSelectData:HaveGotScoreReward(iter_9_1, iter_9_3)

				if var_9_4 and var_9_5 and not var_9_6 then
					var_9_1 = true

					break
				end
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.AFFIX_SELECT_SCORE_BONUS_CAN_GET, iter_9_1), var_9_1 and 1 or 0)
	end
end

function var_0_0.GetAllFirsrtRewards(arg_10_0)
	local var_10_0 = {
		id_list = arg_10_0
	}

	manager.net:SendWithLoadingNew(11076, var_10_0, 11077, var_0_0.OnGetFirstPassRewardCallback)
end

function var_0_0.OnGetFirstPassRewardCallback(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		for iter_11_0, iter_11_1 in pairs(arg_11_1.id_list) do
			ActivityAffixSelectData:OnGetFirstBonus(iter_11_1)
		end

		local var_11_0 = arg_11_0.item_list

		getReward2(mergeReward2(var_11_0))
		var_0_0.UpdateFirstBonusRedPoint()
	else
		ShowTips(GetTips(arg_11_0.result))
	end
end

function var_0_0.SetAffixList(arg_12_0, arg_12_1)
	local var_12_0 = {
		id = arg_12_0,
		affix_id_list = arg_12_1
	}

	manager.net:SendWithLoadingNew(11078, var_12_0, 11079, var_0_0.OnSelectAffixListCallback)
end

function var_0_0.OnSelectAffixListCallback(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		ActivityAffixSelectData:OnSetAffix(arg_13_1.id, arg_13_1.affix_id_list)
	else
		ShowTips(GetTips(arg_13_0.result))
	end
end

return var_0_0
