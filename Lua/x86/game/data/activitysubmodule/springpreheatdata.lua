local var_0_0 = singletonClass("SpringPreheatData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.praySelectList_ = {}
	arg_1_0.progressAcquired_ = {}
	arg_1_0.lastWriteTime_ = 0
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.activityId_ = arg_2_1.activity_id
	arg_2_0.letterStorage_ = arg_2_1.letter_storage
	arg_2_0.lastWriteTime_ = arg_2_1.last_write_time
	arg_2_0.progress_ = arg_2_1.progress
	arg_2_0.progressAcquired_ = {}
	arg_2_0.praySelection_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0:GetPoolItemList()) do
		arg_2_0.praySelection_[iter_2_1] = false
	end

	arg_2_0.praySelectList_ = {}

	local var_2_0 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.select_reward_list) do
		table.insert(var_2_0, iter_2_3.first_reward_id)
		table.insert(var_2_0, iter_2_3.second_reward_id)
	end

	arg_2_0:ModifyPraySelection(var_2_0)

	for iter_2_4, iter_2_5 in ipairs(arg_2_0:GetProgressRewardList()) do
		arg_2_0.progressAcquired_[iter_2_5.id] = false
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.got_point_id_list) do
		arg_2_0:AcquireProgressReward(iter_2_7)
	end
end

function var_0_0.GetLetterStorage(arg_3_0)
	return arg_3_0.letterStorage_ or 0
end

function var_0_0.SendLetter(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.letterStorage_ = arg_4_0:GetLetterStorage() + 1
	arg_4_0.lastWriteTime_ = manager.time:GetServerTime()
	arg_4_0.progress_ = arg_4_0.progress_ + arg_4_0:GetLetterScore()
end

function var_0_0.GetProgressRewardList(arg_5_0)
	if not arg_5_0.progressRewardList_ then
		arg_5_0.progressRewardList_ = {}

		for iter_5_0, iter_5_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_5_0:GetActivityId()] or {}) do
			table.insert(arg_5_0.progressRewardList_, ActivityPointRewardCfg[iter_5_1])
		end
	end

	return arg_5_0.progressRewardList_
end

function var_0_0.GetProgressRewardScore(arg_6_0)
	return arg_6_0.progress_ or 0
end

function var_0_0.GetMaxPrgressRewardScore(arg_7_0)
	if not arg_7_0.progressRewardMaxScore then
		arg_7_0.progressRewardMaxScore = 0

		for iter_7_0, iter_7_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_7_0:GetActivityId()] or {}) do
			arg_7_0.progressRewardMaxScore = math.max(arg_7_0.progressRewardMaxScore, ActivityPointRewardCfg[iter_7_1].need)
		end
	end

	return arg_7_0.progressRewardMaxScore
end

function var_0_0.CanAcquire(arg_8_0, arg_8_1)
	return ActivityPointRewardCfg[arg_8_1].need <= arg_8_0:GetProgressRewardScore()
end

function var_0_0.IsAcquired(arg_9_0, arg_9_1)
	return arg_9_0.progressAcquired_[arg_9_1]
end

function var_0_0.AcquireProgressReward(arg_10_0, arg_10_1)
	arg_10_0.progressAcquired_[arg_10_1] = true
end

function var_0_0.HasRewardCanAcquire(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0:GetProgressRewardList()) do
		if arg_11_0:CanAcquire(iter_11_1.id) and not arg_11_0:IsAcquired(iter_11_1.id) then
			return true
		end
	end

	return false
end

function var_0_0.GetPoolItemList(arg_12_0)
	return ActivityRewardPoolItemCfg.get_id_list_by_activity_id[arg_12_0:GetPoolId()]
end

function var_0_0.GetPoolId(arg_13_0)
	if not arg_13_0.poolId_ then
		arg_13_0.poolId_ = KagutsuchiGachaData:GetPoolIds(arg_13_0:GetWelfareActivityId())[1]
	end

	return arg_13_0.poolId_
end

function var_0_0.ModifyPraySelection(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		arg_14_0.praySelection_[iter_14_1] = true
	end

	table.insertto(arg_14_0.praySelectList_, arg_14_1)
end

function var_0_0.GetPraySelectionList(arg_15_0, arg_15_1)
	local var_15_0 = 2
	local var_15_1 = 1 + var_15_0 * (arg_15_1 - 1)
	local var_15_2 = var_15_1 + var_15_0 - 1

	if var_15_2 > #arg_15_0.praySelectList_ then
		return {
			0,
			0
		}
	end

	local var_15_3 = {}

	for iter_15_0 = var_15_1, var_15_2 do
		table.insert(var_15_3, arg_15_0.praySelectList_[iter_15_0])
	end

	return var_15_3
end

function var_0_0.GetPraySelectionFullList(arg_16_0)
	return arg_16_0.praySelectList_
end

function var_0_0.IsSelected(arg_17_0, arg_17_1)
	return table.indexof(arg_17_0.praySelectList_, arg_17_1)
end

function var_0_0.GetNextSelectionIndex(arg_18_0)
	return arg_18_0:GetCurSelectionDay() + 1
end

function var_0_0.GetCurSelectionDay(arg_19_0)
	return #arg_19_0.praySelectList_ / 2
end

function var_0_0.GetActivityDay(arg_20_0)
	local var_20_0 = ActivityData:GetActivityData(arg_20_0:GetActivityId()).startTime
	local var_20_1 = manager.time:GetServerTime()
	local var_20_2 = manager.time:DiffDay(var_20_0, var_20_1) + 1

	return math.max(var_20_2, 1)
end

function var_0_0.GetActivityTotalDay(arg_21_0)
	local var_21_0 = ActivityData:GetActivityData(arg_21_0:GetActivityId())
	local var_21_1 = var_21_0.startTime
	local var_21_2 = var_21_0.stopTime

	return (manager.time:DiffDay(var_21_1, var_21_2))
end

function var_0_0.GetDayState(arg_22_0, arg_22_1)
	local var_22_0 = {
		LOCKED = 1,
		SELECTABLE = 3,
		SELECTED = 4,
		NOT_READY = 2
	}
	local var_22_1 = arg_22_0:GetNextSelectionIndex()

	if arg_22_1 > arg_22_0:GetLetterStorage() then
		return var_22_0.LOCKED
	elseif var_22_1 < arg_22_1 then
		return var_22_0.NOT_READY
	elseif arg_22_1 == var_22_1 then
		return var_22_0.SELECTABLE
	else
		return var_22_0.SELECTED
	end
end

function var_0_0.IsTodayWritten(arg_23_0)
	local var_23_0 = 86400
	local var_23_1 = manager.time:GetNextFreshTime()
	local var_23_2 = manager.time:GetServerTime()

	return math.floor((var_23_1 - var_23_2) / var_23_0) == math.floor((var_23_1 - arg_23_0.lastWriteTime_) / var_23_0)
end

function var_0_0.GetActivityId(arg_24_0)
	return arg_24_0.activityId_ or 212531
end

function var_0_0.GetWelfareActivityId(arg_25_0)
	return 222541
end

function var_0_0.GetSystemLetterList(arg_26_0)
	if not arg_26_0.systemLetterList_ then
		arg_26_0.systemLetterList_ = {}

		for iter_26_0, iter_26_1 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[arg_26_0:GetActivityId()]) do
			if ActivityBlessingLetterCfg[iter_26_1].type == 1 then
				table.insert(arg_26_0.systemLetterList_, iter_26_1)
			end
		end
	end

	return arg_26_0.systemLetterList_
end

function var_0_0.GetPlayerLetterList(arg_27_0)
	if not arg_27_0.playerLetterList_ then
		arg_27_0.playerLetterList_ = {}

		for iter_27_0, iter_27_1 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[arg_27_0:GetActivityId()]) do
			if ActivityBlessingLetterCfg[iter_27_1].type == 2 then
				table.insert(arg_27_0.playerLetterList_, iter_27_1)
			end
		end
	end

	return arg_27_0.playerLetterList_
end

function var_0_0.GetLetterCfg(arg_28_0, arg_28_1)
	return ActivityBlessingLetterCfg[arg_28_1]
end

function var_0_0.GetPlayerLetter(arg_29_0)
	return arg_29_0:GetLetterCfg(arg_29_0:GetPlayerLetterList()[1])
end

function var_0_0.GetLetterTitle(arg_30_0, arg_30_1)
	return arg_30_0:GetLetterCfg(arg_30_1).title
end

function var_0_0.GetLetterFixedText(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0:GetLetterCfg(arg_31_1)

	return arg_31_0:GetLetterOptionList(arg_31_1, arg_31_2, arg_31_3)[1]
end

function var_0_0.GetLetterOptionList(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	return arg_32_0:GetLetterCfg(arg_32_1).fixed_or_option_text_list[arg_32_2][arg_32_3]
end

function var_0_0.GetLetterOptionText(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	return arg_33_0:GetLetterOptionList(arg_33_1, arg_33_2, arg_33_3)[arg_33_4]
end

function var_0_0.GetEnableOptionList(arg_34_0, arg_34_1, arg_34_2)
	return arg_34_0:GetLetterCfg(arg_34_1).option_button_list[arg_34_2]
end

function var_0_0.IsEnableOption(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	return arg_35_0:GetEnableOptionList(arg_35_1, arg_35_2)[arg_35_3] ~= 0
end

function var_0_0.GetLetterHeroId(arg_36_0, arg_36_1)
	return arg_36_0:GetLetterCfg(arg_36_1).hero_id
end

function var_0_0.GetLetterRewards(arg_37_0, arg_37_1)
	return arg_37_0:GetLetterCfg(arg_37_1).reward_list
end

function var_0_0.GetSentenceIdx(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = SpringPreheatData:GetPlayerLetter()
	local var_38_1 = 1

	for iter_38_0 = 1, #var_38_0.option_button_list[arg_38_1] do
		if SpringPreheatData:IsEnableOption(var_38_0.id, arg_38_1, iter_38_0) then
			if var_38_1 == arg_38_2 then
				return iter_38_0
			end

			var_38_1 = var_38_1 + 1
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
