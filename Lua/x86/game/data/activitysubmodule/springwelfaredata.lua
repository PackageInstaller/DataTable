local var_0_0 = singletonClass("SpringPreheatData")

SPRING_WELFARE_DAY_STATE_TYPE = {
	ACQUIRED = 1,
	NEED_SIGN = 3,
	CAN_PRAY = 4,
	NOT_ACQUIRE = 2
}

function var_0_0.Ctor(arg_1_0)
	arg_1_0.prayedDays_ = {}
	arg_1_0.letterData_ = {}
	arg_1_0.systemLetterIdList_ = {}
	arg_1_0.playerLetterIdList_ = {}
	arg_1_0.userBriefInfo_ = {}
	arg_1_0.newLetterIdList_ = {}
	arg_1_0.newSystemLetterIdList_ = {}
	arg_1_0.newPlayerLetterIdList_ = {}
	arg_1_0.selectRewardList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.prayedDays_ = {}
	arg_2_0.letterData_ = {}
	arg_2_0.systemLetterIdList_ = {}
	arg_2_0.playerLetterIdList_ = {}
	arg_2_0.userBriefInfo_ = {}
	arg_2_0.newLetterIdList_ = {}
	arg_2_0.newSystemLetterIdList_ = {}
	arg_2_0.newPlayerLetterIdList_ = {}
	arg_2_0.activityId_ = arg_2_1.activity_id
	arg_2_0.day = arg_2_1.day
	arg_2_0.resignNum_ = arg_2_1.re_sign_num
	arg_2_0.point_ = arg_2_1.point
	arg_2_0.gotPointRewardList_ = arg_2_1.point_reward_list
	arg_2_0.selectRewardList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.select_reward_list) do
		local var_2_0 = {
			iter_2_1.first_reward_id,
			iter_2_1.second_reward_id
		}

		table.insertto(arg_2_0.selectRewardList_, var_2_0)
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.receive_reward_list) do
		arg_2_0.prayedDays_[iter_2_3] = true
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.system_letter) do
		local var_2_1 = arg_2_0:MakeLetterData(iter_2_5)

		arg_2_0.letterData_[var_2_1.serverId] = var_2_1

		table.insert(arg_2_0.systemLetterIdList_, var_2_1.serverId)
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.player_letter_list) do
		print(iter_2_7.sticker_id_list, iter_2_7.user_base_info, iter_2_7.sticker_id_list, iter_2_7.nick, " InitData")

		local var_2_2 = arg_2_0:MakeLetterData(iter_2_7)

		arg_2_0.letterData_[var_2_2.serverId] = var_2_2

		table.insert(arg_2_0.playerLetterIdList_, var_2_2.serverId)
		arg_2_0:RefreshLetterPlayerInfoSingle(iter_2_7)
	end

	arg_2_0.isFetched_ = false

	table.insert(arg_2_0.newSystemLetterIdList_, arg_2_0.systemLetterIdList_[1])
	table.insert(arg_2_0.newPlayerLetterIdList_, arg_2_0.playerLetterIdList_[#arg_2_0.playerLetterIdList_])
end

function var_0_0.MakeLetterData(arg_3_0, arg_3_1)
	local var_3_0 = {
		letterId = arg_3_1.letter_template_id,
		paragraphs = {}
	}

	if var_3_0.letterId == nil then
		local var_3_1 = arg_3_0:GetSystemLetterCfgList()

		if #var_3_1 < arg_3_1.day then
			Debug.LogError(string.format("第%d天系统祝福信没有对应的配置 现取第%d天的配置", arg_3_1.day, #var_3_1))

			var_3_0.letterId = var_3_1[#var_3_1].id
		else
			var_3_0.letterId = var_3_1[arg_3_1.day].id
		end
	end

	local var_3_2 = SpringPreheatData:GetLetterCfg(var_3_0.letterId)

	var_3_0.rewardList = var_3_2.reward_list
	var_3_0.title = SpringPreheatData:GetLetterTitle(var_3_2.id)

	if var_3_2.type == 1 then
		var_3_0.isSystem = true
		var_3_0.heroId = var_3_2.hero_id
		var_3_0.serverId = arg_3_1.day
		var_3_0.day = arg_3_1.day
		var_3_0.gotReward = arg_3_1.is_reward ~= 0
	elseif var_3_2.type == 2 then
		var_3_0.isPlayer = true
		var_3_0.playerId = arg_3_1.user_id
		var_3_0.gotReward = true
		var_3_0.serverId = string.format("%s_%s", arg_3_1.user_id, arg_3_1.id)
		var_3_0.timestamp = arg_3_1.id
		var_3_0.stickerList = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_1.sticker_id_list) do
			table.insert(var_3_0.stickerList, {
				id = iter_3_1
			})
		end
	end

	local var_3_3 = arg_3_1.optional_content_index
	local var_3_4 = 1

	for iter_3_2, iter_3_3 in ipairs(var_3_2.option_button_list) do
		local var_3_5 = ""

		for iter_3_4, iter_3_5 in ipairs(iter_3_3) do
			local var_3_6

			if iter_3_5 ~= 0 then
				local var_3_7 = var_3_3[var_3_4]

				if var_3_7 == nil then
					var_3_7 = 1

					print("祝福信可选文本序号缺失！")
				end

				var_3_6 = SpringPreheatData:GetLetterOptionText(var_3_2.id, iter_3_2, iter_3_4, var_3_7)
				var_3_4 = var_3_4 + 1
			else
				var_3_6 = SpringPreheatData:GetLetterFixedText(var_3_2.id, iter_3_2, iter_3_4)
			end

			var_3_5 = var_3_5 .. GetTips(var_3_6)
		end

		var_3_0.paragraphs[iter_3_2] = var_3_5
	end

	return var_3_0
end

function var_0_0.GetLetterData(arg_4_0, arg_4_1)
	return arg_4_0.letterData_[arg_4_1]
end

function var_0_0.GetLetterList(arg_5_0)
	return arg_5_0.letterData_
end

function var_0_0.GetNextNewSystemLetterId(arg_6_0)
	return arg_6_0.newSystemLetterIdList_[1]
end

function var_0_0.GetNextNewPlayerLetterId(arg_7_0)
	return arg_7_0.newPlayerLetterIdList_[1]
end

function var_0_0.GetPlayerLetterIdList(arg_8_0)
	return arg_8_0.playerLetterIdList_
end

function var_0_0.GetSystemLetterIdList(arg_9_0)
	return arg_9_0.systemLetterIdList_
end

function var_0_0.AcquireLetterReward(arg_10_0, arg_10_1)
	arg_10_0.letterData_[arg_10_1].gotReward = true
end

function var_0_0.GetPraySelectionList(arg_11_0, arg_11_1)
	local var_11_0 = 2
	local var_11_1 = 1 + var_11_0 * (arg_11_1 - 1)
	local var_11_2 = var_11_1 + var_11_0 - 1

	if var_11_2 > #arg_11_0.selectRewardList_ then
		return {
			0,
			0
		}
	end

	local var_11_3 = {}

	for iter_11_0 = var_11_1, var_11_2 do
		table.insert(var_11_3, arg_11_0.selectRewardList_[iter_11_0])
	end

	return var_11_3
end

function var_0_0.GetDayState(arg_12_0, arg_12_1)
	if arg_12_0.prayedDays_[arg_12_1] then
		return SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED
	end

	local var_12_0 = arg_12_0:GetActivityDay()

	if arg_12_1 < var_12_0 then
		return SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN
	elseif arg_12_1 == var_12_0 then
		return SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY
	end

	return SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE
end

function var_0_0.ModifyPrayedDay(arg_13_0, arg_13_1)
	arg_13_0.prayedDays_[arg_13_1] = true
end

function var_0_0.GetActivityDay(arg_14_0)
	return arg_14_0.day
end

function var_0_0.GetCurPrayDay(arg_15_0)
	local var_15_0 = SpringPreheatData:GetMaxProgress()
	local var_15_1 = arg_15_0:GetActivityDay()
	local var_15_2 = math.min(var_15_1, 7)

	if arg_15_0:GetDayState(var_15_2) == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		return var_15_2
	end

	for iter_15_0 = 1, var_15_2 do
		if arg_15_0:GetDayState(iter_15_0) == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
			return iter_15_0
		end
	end

	return var_15_2
end

function var_0_0.GetCurSignDay(arg_16_0)
	local var_16_0 = SpringPreheatData:GetMaxProgress()
	local var_16_1 = arg_16_0:GetActivityDay()

	for iter_16_0 = 1, var_16_1 do
		if arg_16_0:GetDayState(iter_16_0) == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
			return iter_16_0
		end
	end

	return -1
end

function var_0_0.GetLetterParagText(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0:GetLetterData(arg_17_1).paragraphs[arg_17_2]
end

function var_0_0.DeleteLetter(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		arg_18_0.letterData_[iter_18_1] = nil
	end
end

function var_0_0.GetPlayerInfo(arg_19_0, arg_19_1)
	return arg_19_0.userBriefInfo_[arg_19_1]
end

function var_0_0.IsFetched(arg_20_0)
	return arg_20_0.isFetched_ or true
end

function var_0_0.SetFetchState(arg_21_0, arg_21_1)
	arg_21_0.isFetched_ = arg_21_1
end

function var_0_0.RefreshLetterPlayerInfo(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		arg_22_0:RefreshLetterPlayerInfoSingle(iter_22_1)
	end
end

function var_0_0.RefreshLetterPlayerInfoSingle(arg_23_0, arg_23_1)
	arg_23_0.userBriefInfo_[arg_23_1.user_id] = {
		uid = arg_23_1.user_id,
		nick = arg_23_1.user_base_info and arg_23_1.user_base_info.nick,
		icon = arg_23_1.user_base_info and arg_23_1.user_base_info.icon,
		icon_frame = arg_23_1.user_base_info and arg_23_1.user_base_info.icon_frame,
		level = arg_23_1.level
	}
end

function var_0_0.IsFriendOrInRequest(arg_24_0, arg_24_1)
	return FriendsData:IsFriend(arg_24_1) or FriendsData:IsInRequest(arg_24_1)
end

function var_0_0.GetPoolItemList(arg_25_0)
	return SpringPreheatData:GetPoolItemList()
end

function var_0_0.GetPoolId(arg_26_0)
	return SpringPreheatData:GetPoolId()
end

function var_0_0.GetPoolCost(arg_27_0)
	return 53088, 1
end

function var_0_0.GetPoolSignCost(arg_28_0)
	local var_28_0 = arg_28_0.resignNum_
	local var_28_1 = GameSetting.spring_festival_supplementary_sign.value
	local var_28_2 = {
		1,
		0
	}

	if var_28_0 >= #var_28_1 then
		var_28_2 = var_28_1[#var_28_1]
	elseif var_28_0 >= 0 then
		var_28_2 = var_28_1[var_28_0 + 1]
	end

	local var_28_3 = var_28_2[1]
	local var_28_4 = var_28_2[2]

	return var_28_3, var_28_4
end

function var_0_0.GetTodayPtCfg(arg_29_0)
	local var_29_0 = arg_29_0.day
	local var_29_1 = math.min(var_29_0, #arg_29_0.gotPointRewardList_ + 1)
	local var_29_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_29_0:GetActivityId()]
	local var_29_3 = var_29_2[var_29_1]

	if var_29_3 == nil then
		var_29_3 = var_29_2[1]

		Debug.LogError(string.format("SpringWelfare could not find pt cfg by index:%d, day:%d, got_reward_count:%d", var_29_1, arg_29_0.day, #arg_29_0.gotPointRewardList_))
	end

	return ActivityPointRewardCfg[var_29_3]
end

function var_0_0.IsTodayPtCanAcquire(arg_30_0)
	local var_30_0 = arg_30_0:GetTodayPtCfg()

	return arg_30_0:GetTodayPtProgress() >= var_30_0.need
end

function var_0_0.IsTodayPtAcquired(arg_31_0)
	local var_31_0 = arg_31_0:GetTodayPtCfg()

	return table.indexof(arg_31_0.gotPointRewardList_, var_31_0.id)
end

function var_0_0.HasTaskCanAcquire(arg_32_0)
	local var_32_0 = TaskData2:GetActivityTaskSortList(arg_32_0:GetActivityId())

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_1 = AssignmentCfg[iter_32_1.id]
		local var_32_2 = iter_32_1.progress >= var_32_1.need
		local var_32_3 = iter_32_1.complete_flag >= 1

		if var_32_2 and not var_32_3 then
			return true
		end
	end

	return false
end

function var_0_0.GetPtItemId(arg_33_0)
	return 53089
end

function var_0_0.GetTodayPtProgress(arg_34_0)
	return arg_34_0.point_
end

function var_0_0.AddTodayPtProgress(arg_35_0, arg_35_1)
	arg_35_0.point_ = arg_35_0.point_ + arg_35_1
end

function var_0_0.AcquireDailyPointReward(arg_36_0, arg_36_1)
	table.insert(arg_36_0.gotPointRewardList_, arg_36_1)
end

function var_0_0.GetActivityId(arg_37_0)
	return arg_37_0.activityId_ or 222541
end

function var_0_0.GetSystemLetterCfgList(arg_38_0)
	if not arg_38_0.systemLetterCfgList_ then
		arg_38_0.systemLetterCfgList_ = {}

		for iter_38_0, iter_38_1 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[arg_38_0:GetActivityId()]) do
			local var_38_0 = ActivityBlessingLetterCfg[iter_38_1]

			if var_38_0.type == 1 then
				table.insert(arg_38_0.systemLetterCfgList_, var_38_0)
			end
		end
	end

	return arg_38_0.systemLetterCfgList_
end

return var_0_0
