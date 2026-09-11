local var_0_0 = singletonClass("MoonBoData")

function var_0_0:Init()
	self.todayGetCount_ = 0
	self.showRewards_ = {}
	self.curDices_ = {}
	self.curLevel_ = 0
	self.curReward_ = {}
	self.canGetCount_ = 0
	self.isShowReward_ = false
	self.isShowText_ = false
	self.rewards_ = {}
	self.rewardsCount_ = {}
	self.isOpenActivity_ = false
	self.isOpenReprintActivity_ = false
	self.freshTime_ = TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)

	for iter_1_0, iter_1_1 in ipairs(MoonBoCfg.all) do
		self.rewards_[iter_1_1] = {}
		self.rewardsCount_[iter_1_1] = {}

		local var_1_0 = 1

		for iter_1_2, iter_1_3 in pairs(MoonBoCfg[iter_1_1].reward) do
			if self.rewards_[iter_1_1][var_1_0 - 1] and iter_1_3[1] ~= self.rewards_[iter_1_1][var_1_0 - 1][1] then
				self.rewards_[iter_1_1][var_1_0] = iter_1_3
				var_1_0 = var_1_0 + 1
			end

			if self.rewards_[iter_1_1][var_1_0 - 1] == nil then
				self.rewards_[iter_1_1][var_1_0] = iter_1_3
				var_1_0 = var_1_0 + 1
			end

			self.rewardsCount_[iter_1_1][iter_1_3[1]] = self.rewardsCount_[iter_1_1][iter_1_3[1]] and self.rewardsCount_[iter_1_1][iter_1_3[1]] + 1 or 1
		end
	end
end

function var_0_0:SetData(arg_2_1)
	if arg_2_1.activity_id == ActivityConst.MOONBO or arg_2_1.activity_id == ActivityConst.ACTIVITY_2_4_MOONBO then
		self.todayTime_ = manager.time:GetServerTime()
		self.todayGetCount_ = arg_2_1.today_draw_times

		self:FreshCanGetCount()

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.unclaimed_reward) do
			self.showRewards_[iter_2_1.level] = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.unclaimed_item) do
				if self.showRewards_[iter_2_1.level][iter_2_3.id] ~= nil then
					self.showRewards_[iter_2_1.level][iter_2_3.id].count = self.showRewards_[iter_2_1.level][iter_2_3.id].count + 1
				else
					self.showRewards_[iter_2_1.level][iter_2_3.id] = {
						count = 1,
						id = iter_2_3.id,
						num = iter_2_3.num
					}
				end
			end
		end
	end
end

function var_0_0:GetRewards(arg_3_1)
	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.dice_list) do
			self.curDices_[iter_3_0] = iter_3_1
		end

		if arg_3_1.level then
			self.curLevel_ = arg_3_1.level
		end

		if arg_3_1.reward then
			self.curReward_ = {
				{
					arg_3_1.reward.id,
					arg_3_1.reward.num
				}
			}

			if self.showRewards_[self.curLevel_] and self.showRewards_[self.curLevel_][arg_3_1.reward.id] and self.showRewards_[self.curLevel_][arg_3_1.reward.id].count > 0 then
				self.showRewards_[self.curLevel_][arg_3_1.reward.id].count = self.showRewards_[self.curLevel_][arg_3_1.reward.id].count - 1
				self.isShowText_ = false
			else
				self.isShowText_ = true
			end
		end

		self.todayGetCount_ = self.todayGetCount_ + 1

		self:FreshCanGetCount()
	end
end

function var_0_0:GetCurDices()
	return self.curDices_
end

function var_0_0:GetCurReward()
	return self.curReward_
end

function var_0_0:GetCanGetCount()
	self:FreshCanGetCount()

	return self.canGetCount_
end

function var_0_0:SubTodayGetCount(arg_7_1)
	self.todayGetCount_ = self.todayGetCount_ + arg_7_1

	self:FreshCanGetCount()
end

function var_0_0:FreshCanGetCount()
	self.isOpenActivity_ = ActivityData:GetActivityIsOpen(ActivityConst.MOONBO)
	self.isOpenReprintActivity_ = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_2_4_MOONBO)

	if self.isOpenActivity_ or self.isOpenReprintActivity_ then
		local var_8_0 = 0

		for iter_8_0, iter_8_1 in ipairs(GameSetting.activity_mooncake_gambling_num_get.value) do
			if iter_8_1 <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) then
				var_8_0 = iter_8_0
			else
				break
			end
		end

		self.canGetCount_ = var_8_0 - self.todayGetCount_
	else
		self.canGetCount_ = 0

		manager.notify:Invoke(ACTIVITY_MOONBO_NEWDAY)
	end

	if self.canGetCount_ > 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO), 1)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO), 0)
	end
end

function var_0_0:FreshTime()
	self:FreshCanGetCount()

	local var_9_0 = TimeMgr.GetInstance():GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)

	if self.freshTime_ ~= var_9_0 then
		self.freshTime_ = var_9_0

		self:PassDayClear()
	end
end

function var_0_0:PassDayClear()
	self.todayGetCount_ = 0

	self:FreshCanGetCount()
	manager.notify:Invoke(ACTIVITY_MOONBO_NEWDAY)
end

function var_0_0:GetRewardIsShow(arg_11_1, arg_11_2)
	if self.showRewards_[arg_11_1] and self.showRewards_[arg_11_1][arg_11_2] and self.showRewards_[arg_11_1][arg_11_2].count > 0 then
		return true
	end

	return false
end

function var_0_0.LevelNumToLanguage(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = GetTips("ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO")

	return GetTips(var_12_1 + arg_12_1)
end

function var_0_0:GetCurLevel()
	return self.curLevel_
end

function var_0_0.SetIsShowReward(arg_14_0, arg_14_1)
	arg_14_0.isShowReward_ = arg_14_1
end

function var_0_0:GetIsShowReward()
	return self.isShowReward_
end

function var_0_0:GetIsShowText()
	return self.isShowText_
end

function var_0_0:GetCfgRewards(arg_17_1)
	return self.rewards_[arg_17_1]
end

function var_0_0:GetCfgRewardsCount(arg_18_1, arg_18_2)
	return self.rewardsCount_[arg_18_1][arg_18_2]
end

function var_0_0:GetCurCanGetRewardCount(arg_19_1, arg_19_2)
	if self.showRewards_[arg_19_1] and self.showRewards_[arg_19_1][arg_19_2] and self.showRewards_[arg_19_1][arg_19_2].count then
		return self.showRewards_[arg_19_1][arg_19_2].count
	end

	return 0
end

return var_0_0
