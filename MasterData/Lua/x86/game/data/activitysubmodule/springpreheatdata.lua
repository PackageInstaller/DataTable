local var_0_0 = singletonClass("SpringPreheatData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.praySelectList_ = {}
	arg_1_0.progressAcquired_ = {}
	arg_1_0.lastWriteTime_ = 0
end

function var_0_0:InitData(arg_2_1)
	self.activityId_ = arg_2_1.activity_id
	self.letterStorage_ = arg_2_1.letter_storage
	self.lastWriteTime_ = arg_2_1.last_write_time
	self.progress_ = arg_2_1.progress
	self.progressAcquired_ = {}
	self.praySelection_ = {}

	for iter_2_0, iter_2_1 in ipairs(self:GetPoolItemList()) do
		self.praySelection_[iter_2_1] = false
	end

	self.praySelectList_ = {}

	local var_2_0 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.select_reward_list) do
		table.insert(var_2_0, iter_2_3.first_reward_id)
		table.insert(var_2_0, iter_2_3.second_reward_id)
	end

	self:ModifyPraySelection(var_2_0)

	for iter_2_4, iter_2_5 in ipairs(self:GetProgressRewardList()) do
		self.progressAcquired_[iter_2_5.id] = false
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.got_point_id_list) do
		self:AcquireProgressReward(iter_2_7)
	end
end

function var_0_0:GetLetterStorage()
	return self.letterStorage_ or 0
end

function var_0_0:SendLetter(arg_4_1, arg_4_2, arg_4_3)
	self.letterStorage_ = self:GetLetterStorage() + 1
	self.lastWriteTime_ = manager.time:GetServerTime()
	self.progress_ = self.progress_ + self:GetLetterScore()
end

function var_0_0:GetProgressRewardList()
	if not self.progressRewardList_ then
		self.progressRewardList_ = {}

		for iter_5_0, iter_5_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self:GetActivityId()] or {}) do
			table.insert(self.progressRewardList_, ActivityPointRewardCfg[iter_5_1])
		end
	end

	return self.progressRewardList_
end

function var_0_0:GetProgressRewardScore()
	return self.progress_ or 0
end

function var_0_0:GetMaxPrgressRewardScore()
	if not self.progressRewardMaxScore then
		self.progressRewardMaxScore = 0

		for iter_7_0, iter_7_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self:GetActivityId()] or {}) do
			self.progressRewardMaxScore = math.max(self.progressRewardMaxScore, ActivityPointRewardCfg[iter_7_1].need)
		end
	end

	return self.progressRewardMaxScore
end

function var_0_0:CanAcquire(arg_8_1)
	return ActivityPointRewardCfg[arg_8_1].need <= self:GetProgressRewardScore()
end

function var_0_0:IsAcquired(arg_9_1)
	return self.progressAcquired_[arg_9_1]
end

function var_0_0:AcquireProgressReward(arg_10_1)
	self.progressAcquired_[arg_10_1] = true
end

function var_0_0:HasRewardCanAcquire()
	for iter_11_0, iter_11_1 in ipairs(self:GetProgressRewardList()) do
		if self:CanAcquire(iter_11_1.id) and not self:IsAcquired(iter_11_1.id) then
			return true
		end
	end

	return false
end

function var_0_0:GetPoolItemList()
	return ActivityRewardPoolItemCfg.get_id_list_by_activity_id[self:GetPoolId()]
end

function var_0_0:GetPoolId()
	self.poolId_ = self.poolId_ or KagutsuchiGachaData:GetPoolIds(self:GetWelfareActivityId())[1]

	return self.poolId_
end

function var_0_0:ModifyPraySelection(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		self.praySelection_[iter_14_1] = true
	end

	table.insertto(self.praySelectList_, arg_14_1)
end

function var_0_0:GetPraySelectionList(arg_15_1)
	if 1 + 2 * (arg_15_1 - 1) + 2 - 1 > #self.praySelectList_ then
		return {
			0,
			0
		}
	end

	local var_15_0 = {}

	for iter_15_0 = 1 + 2 * (arg_15_1 - 1), 1 + 2 * (arg_15_1 - 1) + 2 - 1 do
		table.insert(var_15_0, self.praySelectList_[iter_15_0])
	end

	return var_15_0
end

function var_0_0:GetPraySelectionFullList()
	return self.praySelectList_
end

function var_0_0:IsSelected(arg_17_1)
	return table.indexof(self.praySelectList_, arg_17_1)
end

function var_0_0:GetNextSelectionIndex()
	return self:GetCurSelectionDay() + 1
end

function var_0_0:GetCurSelectionDay()
	return #self.praySelectList_ / 2
end

function var_0_0:GetActivityDay()
	return math.max(manager.time:DiffDay(ActivityData:GetActivityData(self:GetActivityId()).startTime, (manager.time:GetServerTime())) + 1, 1)
end

function var_0_0:GetActivityTotalDay()
	local var_21_0 = ActivityData:GetActivityData(self:GetActivityId())

	return (manager.time:DiffDay(var_21_0.startTime, var_21_0.stopTime))
end

function var_0_0:GetDayState(arg_22_1)
	local var_22_0 = {
		LOCKED = 1,
		SELECTABLE = 3,
		SELECTED = 4,
		NOT_READY = 2
	}
	local var_22_1 = self:GetNextSelectionIndex()

	if arg_22_1 > self:GetLetterStorage() then
		return var_22_0.LOCKED
	elseif var_22_1 < arg_22_1 then
		return var_22_0.NOT_READY
	elseif arg_22_1 == var_22_1 then
		return var_22_0.SELECTABLE
	else
		return var_22_0.SELECTED
	end
end

function var_0_0:IsTodayWritten()
	local var_23_0 = manager.time:GetNextFreshTime()

	return math.floor((var_23_0 - manager.time:GetServerTime()) / 86400) == math.floor((var_23_0 - self.lastWriteTime_) / 86400)
end

function var_0_0:GetActivityId()
	return self.activityId_ or 212531
end

function var_0_0.GetWelfareActivityId(arg_25_0)
	return 222541
end

function var_0_0:GetSystemLetterList()
	if not self.systemLetterList_ then
		self.systemLetterList_ = {}

		for iter_26_0, iter_26_1 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[self:GetActivityId()]) do
			if ActivityBlessingLetterCfg[iter_26_1].type == 1 then
				table.insert(self.systemLetterList_, iter_26_1)
			end
		end
	end

	return self.systemLetterList_
end

function var_0_0:GetPlayerLetterList()
	if not self.playerLetterList_ then
		self.playerLetterList_ = {}

		for iter_27_0, iter_27_1 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[self:GetActivityId()]) do
			if ActivityBlessingLetterCfg[iter_27_1].type == 2 then
				table.insert(self.playerLetterList_, iter_27_1)
			end
		end
	end

	return self.playerLetterList_
end

function var_0_0.GetLetterCfg(arg_28_0, arg_28_1)
	return ActivityBlessingLetterCfg[arg_28_1]
end

function var_0_0:GetPlayerLetter()
	return self:GetLetterCfg(self:GetPlayerLetterList()[1])
end

function var_0_0:GetLetterTitle(arg_30_1)
	return self:GetLetterCfg(arg_30_1).title
end

function var_0_0:GetLetterFixedText(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = self:GetLetterCfg(arg_31_1)

	return self:GetLetterOptionList(arg_31_1, arg_31_2, arg_31_3)[1]
end

function var_0_0:GetLetterOptionList(arg_32_1, arg_32_2, arg_32_3)
	return self:GetLetterCfg(arg_32_1).fixed_or_option_text_list[arg_32_2][arg_32_3]
end

function var_0_0:GetLetterOptionText(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	return self:GetLetterOptionList(arg_33_1, arg_33_2, arg_33_3)[arg_33_4]
end

function var_0_0:GetEnableOptionList(arg_34_1, arg_34_2)
	return self:GetLetterCfg(arg_34_1).option_button_list[arg_34_2]
end

function var_0_0:IsEnableOption(arg_35_1, arg_35_2, arg_35_3)
	return self:GetEnableOptionList(arg_35_1, arg_35_2)[arg_35_3] ~= 0
end

function var_0_0:GetLetterHeroId(arg_36_1)
	return self:GetLetterCfg(arg_36_1).hero_id
end

function var_0_0:GetLetterRewards(arg_37_1)
	return self:GetLetterCfg(arg_37_1).reward_list
end

function var_0_0.GetSentenceIdx(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = SpringPreheatData:GetPlayerLetter()

	for iter_38_0 = 1, #var_38_0.option_button_list[arg_38_1] do
		if SpringPreheatData:IsEnableOption(var_38_0.id, arg_38_1, iter_38_0) then
			if 1 == arg_38_2 then
				return iter_38_0
			end
		end
	end

	return -1
end

function var_0_0.GetOptionCount(arg_39_0, arg_39_1)
	local var_39_0 = SpringPreheatData:GetPlayerLetter()
	local var_39_1 = 0

	for iter_39_0 = 1, #var_39_0.option_button_list[arg_39_1] do
		if SpringPreheatData:IsEnableOption(var_39_0.id, arg_39_1, iter_39_0) then
			var_39_1 = var_39_1 + 1
		end
	end

	return var_39_1
end

function var_0_0.GetMaxProgress(arg_40_0)
	return GameSetting.spring_preheat_2_8_progress_max.value[1]
end

function var_0_0.GetLetterScore(arg_41_0)
	return GameSetting.spring_preheat_2_8_letter_getscore.value[1]
end

return var_0_0
