local var_0_0 = singletonClass("HeroTrialData")

function var_0_0.Init(arg_1_0)
	arg_1_0.heroTrialStateList_ = {}
	arg_1_0.selectActivityHeroIDList_ = {}
	arg_1_0.stageIDToHeroTrialID_ = {}
	arg_1_0.heroTrialedIDList_ = {}
end

function var_0_0:InitData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.activity_info) do
		self.heroTrialStateList_[iter_2_1.id] = iter_2_1.challenge_state

		if iter_2_1.challenge_state <= 1 then
			if ActivityData:GetActivityIsOpen(ActivityHeroTrialCfg[iter_2_1.id].activity_id) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[iter_2_1.id].id), 1)
			end
		elseif iter_2_1.challenge_state > 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[iter_2_1.id].id), 0)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(ActivityCfg[arg_2_1.activity_id].sub_activity_list) do
		for iter_2_4, iter_2_5 in ipairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_2_3]) do
			if not self.heroTrialStateList_[iter_2_5] then
				self.heroTrialStateList_[iter_2_5] = 0

				if ActivityData:GetActivityIsOpen(iter_2_3) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, iter_2_5), 1)
				end
			end
		end
	end
end

function var_0_0:RefreshRedData()
	if not self.heroTrialStateList_ then
		return
	end

	for iter_3_0, iter_3_1 in pairs(self.heroTrialStateList_) do
		if iter_3_0 and iter_3_0 ~= 0 then
			if (not ActivityData:GetActivityIsOpen(ActivityHeroTrialCfg[iter_3_0].activity_id) or nil) and true then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[iter_3_0].id), 0)
			end
		end
	end
end

function var_0_0:ReceiveReward(arg_4_1)
	self.heroTrialStateList_[arg_4_1] = 2

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_4_1].id), 0)
end

function var_0_0:GetHeroTrialStateList()
	return self.heroTrialStateList_
end

function var_0_0:SetSelectActivityHeroID(arg_6_1, arg_6_2)
	self.selectActivityHeroIDList_[arg_6_1] = arg_6_2

	if self.heroTrialStateList_[arg_6_2] ~= 1 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityHeroTrialCfg[arg_6_2].id), 0)
	end

	saveData("HeroTrial", "activityID_" .. tostring(arg_6_1), arg_6_2)
end

function var_0_0:GetSelectActivityHeroID(arg_7_1)
	if self.selectActivityHeroIDList_[arg_7_1] == nil then
		self.selectActivityHeroIDList_[arg_7_1] = getData("HeroTrial", "activityID_" .. tostring(arg_7_1))
	end

	return self.selectActivityHeroIDList_[arg_7_1]
end

function var_0_0:SaveStageID(arg_8_1)
	self.stageIDToHeroTrialID_[ActivityHeroTrialCfg[arg_8_1].stage_id] = arg_8_1
end

function var_0_0:GetHeroTrialID(arg_9_1)
	return self.stageIDToHeroTrialID_[arg_9_1]
end

function var_0_0:SetBattleWay(arg_10_1, arg_10_2, arg_10_3)
	self.battleWay_ = self.battleWay_ or {}
	self.battleWay_.way = arg_10_1
	self.battleWay_.route = arg_10_2
	self.battleWay_.params = arg_10_3
end

function var_0_0:GetBattleWay()
	return self.battleWay_
end

function var_0_0.GetLastContentPosX(arg_12_0, arg_12_1)
	return getData(string.format("hero_trial_%d", arg_12_1), "contentPosX")
end

function var_0_0.SetLastContentPosX(arg_13_0, arg_13_1, arg_13_2)
	saveData(string.format("hero_trial_%d", arg_13_1), "contentPosX", arg_13_2)
end

function var_0_0:InitHeroTrialedData(arg_14_1)
	self.heroTrialedIDList_ = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.hero_id_list) do
		table.insert(self.heroTrialedIDList_, iter_14_1)
	end
end

function var_0_0:IsHeroTrialed(arg_15_1)
	return table.indexof(self.heroTrialedIDList_, arg_15_1)
end

return var_0_0
