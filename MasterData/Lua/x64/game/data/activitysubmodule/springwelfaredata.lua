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

function var_0_0:InitData(arg_2_1)
	self.prayedDays_ = {}
	self.letterData_ = {}
	self.systemLetterIdList_ = {}
	self.playerLetterIdList_ = {}
	self.userBriefInfo_ = {}
	self.newLetterIdList_ = {}
	self.newSystemLetterIdList_ = {}
	self.newPlayerLetterIdList_ = {}
	self.activityId_ = arg_2_1.activity_id
	self.day = arg_2_1.day
	self.resignNum_ = arg_2_1.re_sign_num
	self.point_ = arg_2_1.point
	self.gotPointRewardList_ = arg_2_1.point_reward_list
	self.selectRewardList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.select_reward_list) do
		table.insertto(self.selectRewardList_, {
			iter_2_1.first_reward_id,
			iter_2_1.second_reward_id
		})
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.receive_reward_list) do
		self.prayedDays_[iter_2_3] = true
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.system_letter) do
		local var_2_0 = self:MakeLetterData(iter_2_5)

		self.letterData_[var_2_0.serverId] = var_2_0

		table.insert(self.systemLetterIdList_, var_2_0.serverId)
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.player_letter_list) do
		print(iter_2_7.sticker_id_list, iter_2_7.user_base_info, iter_2_7.sticker_id_list, iter_2_7.nick, " InitData")

		local var_2_1 = self:MakeLetterData(iter_2_7)

		self.letterData_[var_2_1.serverId] = var_2_1

		table.insert(self.playerLetterIdList_, var_2_1.serverId)
		self:RefreshLetterPlayerInfoSingle(iter_2_7)
	end

	self.isFetched_ = false

	table.insert(self.newSystemLetterIdList_, self.systemLetterIdList_[1])
	table.insert(self.newPlayerLetterIdList_, self.playerLetterIdList_[#self.playerLetterIdList_])
end

function var_0_0:MakeLetterData(arg_3_1)
	local var_3_0 = {
		letterId = arg_3_1.letter_template_id,
		paragraphs = {}
	}

	if var_3_0.letterId == nil then
		local var_3_1 = self:GetSystemLetterCfgList()

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

	for iter_3_2, iter_3_3 in ipairs(var_3_2.option_button_list) do
		local var_3_4 = ""

		for iter_3_4, iter_3_5 in ipairs(iter_3_3) do
			local var_3_5
			local var_3_7

			if iter_3_5 ~= 0 then
				local var_3_6 = var_3_3[1]

				if var_3_3[1] == nil then
					var_3_6 = 1

					print("祝福信可选文本序号缺失！")
				end

				var_3_5 = SpringPreheatData:GetLetterOptionText(var_3_2.id, iter_3_2, iter_3_4, var_3_6)
				var_3_7 = 1 + 1
			else
				var_3_5 = SpringPreheatData:GetLetterFixedText(var_3_2.id, iter_3_2, iter_3_4)
			end

			var_3_4 = var_3_4 .. GetTips(var_3_5)
		end

		var_3_0.paragraphs[iter_3_2] = var_3_4
	end

	return var_3_0
end

function var_0_0:GetLetterData(arg_4_1)
	return self.letterData_[arg_4_1]
end

function var_0_0:GetLetterList()
	return self.letterData_
end

function var_0_0:GetNextNewSystemLetterId()
	return self.newSystemLetterIdList_[1]
end

function var_0_0:GetNextNewPlayerLetterId()
	return self.newPlayerLetterIdList_[1]
end

function var_0_0:GetPlayerLetterIdList()
	return self.playerLetterIdList_
end

function var_0_0:GetSystemLetterIdList()
	return self.systemLetterIdList_
end

function var_0_0:AcquireLetterReward(arg_10_1)
	self.letterData_[arg_10_1].gotReward = true
end

function var_0_0:GetPraySelectionList(arg_11_1)
	if 1 + 2 * (arg_11_1 - 1) + 2 - 1 > #self.selectRewardList_ then
		return {
			0,
			0
		}
	end

	local var_11_0 = {}

	for iter_11_0 = 1 + 2 * (arg_11_1 - 1), 1 + 2 * (arg_11_1 - 1) + 2 - 1 do
		table.insert(var_11_0, self.selectRewardList_[iter_11_0])
	end

	return var_11_0
end

function var_0_0:GetDayState(arg_12_1)
	if self.prayedDays_[arg_12_1] then
		return SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED
	end

	local var_12_0 = self:GetActivityDay()

	if arg_12_1 < var_12_0 then
		return SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN
	elseif arg_12_1 == var_12_0 then
		return SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY
	end

	return SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE
end

function var_0_0:ModifyPrayedDay(arg_13_1)
	self.prayedDays_[arg_13_1] = true
end

function var_0_0:GetActivityDay()
	return self.day
end

function var_0_0:GetCurPrayDay()
	local var_15_0 = SpringPreheatData:GetMaxProgress()
	local var_15_1 = math.min(self:GetActivityDay(), 7)

	if self:GetDayState(var_15_1) == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		return var_15_1
	end

	for iter_15_0 = 1, var_15_1 do
		if self:GetDayState(iter_15_0) == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
			return iter_15_0
		end
	end

	return var_15_1
end

function var_0_0:GetCurSignDay()
	local var_16_0 = SpringPreheatData:GetMaxProgress()

	for iter_16_0 = 1, self:GetActivityDay() do
		if self:GetDayState(iter_16_0) == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
			return iter_16_0
		end
	end

	return -1
end

function var_0_0:GetLetterParagText(arg_17_1, arg_17_2)
	return self:GetLetterData(arg_17_1).paragraphs[arg_17_2]
end

function var_0_0:DeleteLetter(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		self.letterData_[iter_18_1] = nil
	end
end

function var_0_0:GetPlayerInfo(arg_19_1)
	return self.userBriefInfo_[arg_19_1]
end

function var_0_0:IsFetched()
	return self.isFetched_ or true
end

function var_0_0.SetFetchState(arg_21_0, arg_21_1)
	arg_21_0.isFetched_ = arg_21_1
end

function var_0_0:RefreshLetterPlayerInfo(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		self:RefreshLetterPlayerInfoSingle(iter_22_1)
	end
end

function var_0_0:RefreshLetterPlayerInfoSingle(arg_23_1)
	local var_23_0 = {
		uid = arg_23_1.user_id
	}

	var_23_0.nick = arg_23_1.user_base_info and arg_23_1.user_base_info.nick
	var_23_0.icon = arg_23_1.user_base_info and arg_23_1.user_base_info.icon
	var_23_0.icon_frame = arg_23_1.user_base_info and arg_23_1.user_base_info.icon_frame
	var_23_0.level = arg_23_1.level
	self.userBriefInfo_[arg_23_1.user_id] = var_23_0
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

function var_0_0:GetPoolSignCost()
	local var_28_0 = {
		1,
		0
	}

	if self.resignNum_ >= #GameSetting.spring_festival_supplementary_sign.value then
		var_28_0 = GameSetting.spring_festival_supplementary_sign.value[#GameSetting.spring_festival_supplementary_sign.value]
	elseif self.resignNum_ >= 0 then
		var_28_0 = GameSetting.spring_festival_supplementary_sign.value[self.resignNum_ + 1]
	end

	return var_28_0[1], var_28_0[2]
end

function var_0_0:GetTodayPtCfg()
	local var_29_0 = math.min(self.day, #self.gotPointRewardList_ + 1)
	local var_29_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[self:GetActivityId()]
	local var_29_2 = var_29_1[var_29_0]

	if var_29_1[var_29_0] == nil then
		var_29_2 = var_29_1[1]

		Debug.LogError(string.format("SpringWelfare could not find pt cfg by index:%d, day:%d, got_reward_count:%d", var_29_0, self.day, #self.gotPointRewardList_))
	end

	return ActivityPointRewardCfg[var_29_2]
end

function var_0_0:IsTodayPtCanAcquire()
	return self:GetTodayPtProgress() >= self:GetTodayPtCfg().need
end

function var_0_0:IsTodayPtAcquired()
	return table.indexof(self.gotPointRewardList_, self:GetTodayPtCfg().id)
end

function var_0_0:HasTaskCanAcquire()
	for iter_32_0, iter_32_1 in ipairs((TaskData2:GetActivityTaskSortList(self:GetActivityId()))) do
		if iter_32_1.progress >= AssignmentCfg[iter_32_1.id].need and iter_32_1.complete_flag < 1 then
			return true
		end
	end

	return false
end

function var_0_0.GetPtItemId(arg_33_0)
	return 53089
end

function var_0_0:GetTodayPtProgress()
	return self.point_
end

function var_0_0:AddTodayPtProgress(arg_35_1)
	self.point_ = self.point_ + arg_35_1
end

function var_0_0:AcquireDailyPointReward(arg_36_1)
	table.insert(self.gotPointRewardList_, arg_36_1)
end

function var_0_0:GetActivityId()
	return self.activityId_ or 222541
end

function var_0_0:GetSystemLetterCfgList()
	if not self.systemLetterCfgList_ then
		self.systemLetterCfgList_ = {}

		for iter_38_0, iter_38_1 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[self:GetActivityId()]) do
			if ActivityBlessingLetterCfg[iter_38_1].type == 1 then
				table.insert(self.systemLetterCfgList_, ActivityBlessingLetterCfg[iter_38_1])
			end
		end
	end

	return self.systemLetterCfgList_
end

return var_0_0
