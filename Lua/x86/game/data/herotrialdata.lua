local var_0_0 = singletonClass("HeroTrialData")

function var_0_0.Init(arg_1_0)
	arg_1_0.heroTrialStateList_ = {}
	arg_1_0.selectActivityHeroIDList_ = {}
	arg_1_0.stageIDToHeroTrialID_ = {}
	arg_1_0.heroTrialedIDList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_info) do
		arg_2_0.heroTrialStateList_[iter_2_1.id] = iter_2_1.challenge_state

		local var_2_0 = ActivityHeroTrialCfg[iter_2_1.id]

		if iter_2_1.challenge_state <= 1 then
			if ActivityData:GetActivityIsOpen(var_2_0.activity_id) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, var_2_0.id), 1)
			end
		elseif iter_2_1.challenge_state > 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, var_2_0.id), 0)
		end
	end

	local var_2_1 = arg_2_1.activity_id
	local var_2_2 = ActivityCfg[var_2_1].sub_activity_list

	for iter_2_2, iter_2_3 in ipairs(var_2_2) do
		local var_2_3 = ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_2_3]

		for iter_2_4, iter_2_5 in ipairs(var_2_3) do
			if not arg_2_0.heroTrialStateList_[iter_2_5] then
				arg_2_0.heroTrialStateList_[iter_2_5] = 0

				if ActivityData:GetActivityIsOpen(iter_2_3) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, iter_2_5), 1)
				end
			end
		end
	end
end

function var_0_0.RefreshRedData(arg_3_0)
	if not arg_3_0.heroTrialStateList_ then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.heroTrialStateList_) do
		if iter_3_0 and iter_3_0 ~= 0 then
			local var_3_0 = ActivityHeroTrialCfg[iter_3_0]
			local var_3_1 = false

			if not iter_3_1 then
				var_3_1 = true
			end

			if not ActivityData:GetActivityIsOpen(var_3_0.activity_id) then
				var_3_1 = true
			end

			if var_3_1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, var_3_0.id), 0)
			end
		end
	end
end

function var_0_0.ReceiveReward(arg_4_0, arg_4_1)
	arg_4_0.heroTrialStateList_[arg_4_1] = 2

	local var_4_0 = ActivityHeroTrialCfg[arg_4_1]

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, var_4_0.id), 0)
end

function var_0_0.GetHeroTrialStateList(arg_5_0)
	return arg_5_0.heroTrialStateList_
end

function var_0_0.SetSelectActivityHeroID(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.selectActivityHeroIDList_[arg_6_1] = arg_6_2

	if arg_6_0.heroTrialStateList_[arg_6_2] ~= 1 then
		local var_6_0 = ActivityHeroTrialCfg[arg_6_2]

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, var_6_0.id), 0)
	end

	saveData("HeroTrial", "activityID_" .. tostring(arg_6_1), arg_6_2)
end

function var_0_0.GetSelectActivityHeroID(arg_7_0, arg_7_1)
	if arg_7_0.selectActivityHeroIDList_[arg_7_1] == nil then
		arg_7_0.selectActivityHeroIDList_[arg_7_1] = getData("HeroTrial", "activityID_" .. tostring(arg_7_1))
	end

	return arg_7_0.selectActivityHeroIDList_[arg_7_1]
end

function var_0_0.SaveStageID(arg_8_0, arg_8_1)
	local var_8_0 = ActivityHeroTrialCfg[arg_8_1].stage_id

	arg_8_0.stageIDToHeroTrialID_[var_8_0] = arg_8_1
end

function var_0_0.GetHeroTrialID(arg_9_0, arg_9_1)
	return arg_9_0.stageIDToHeroTrialID_[arg_9_1]
end

function var_0_0.SetBattleWay(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.battleWay_ = arg_10_0.battleWay_ or {}
	arg_10_0.battleWay_.way = arg_10_1
	arg_10_0.battleWay_.route = arg_10_2
	arg_10_0.battleWay_.params = arg_10_3
end

function var_0_0.GetBattleWay(arg_11_0)
	return arg_11_0.battleWay_
end

function var_0_0.GetLastContentPosX(arg_12_0, arg_12_1)
	return getData(string.format("hero_trial_%d", arg_12_1), "contentPosX")
end

function var_0_0.SetLastContentPosX(arg_13_0, arg_13_1, arg_13_2)
	saveData(string.format("hero_trial_%d", arg_13_1), "contentPosX", arg_13_2)
end

function var_0_0.InitHeroTrialedData(arg_14_0, arg_14_1)
	arg_14_0.heroTrialedIDList_ = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.hero_id_list) do
		table.insert(arg_14_0.heroTrialedIDList_, iter_14_1)
	end
end

function var_0_0.IsHeroTrialed(arg_15_0, arg_15_1)
	return table.indexof(arg_15_0.heroTrialedIDList_, arg_15_1)
end

return var_0_0
