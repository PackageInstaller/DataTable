local var_0_0 = singletonClass("MoonBoData")

function var_0_0.Init(arg_1_0)
	arg_1_0.todayGetCount_ = 0
	arg_1_0.showRewards_ = {}
	arg_1_0.curDices_ = {}
	arg_1_0.curLevel_ = 0
	arg_1_0.curReward_ = {}
	arg_1_0.canGetCount_ = 0
	arg_1_0.isShowReward_ = false
	arg_1_0.isShowText_ = false
	arg_1_0.rewards_ = {}
	arg_1_0.rewardsCount_ = {}
	arg_1_0.isOpenActivity_ = false
	arg_1_0.isOpenReprintActivity_ = false

	local var_1_0 = GameSetting.refresh_time1.value[1][1]

	arg_1_0.freshTime_ = TimeMgr.GetInstance():GetNextTime(var_1_0, 0, 0)

	for iter_1_0, iter_1_1 in ipairs(MoonBoCfg.all) do
		arg_1_0.rewards_[iter_1_1] = {}
		arg_1_0.rewardsCount_[iter_1_1] = {}

		local var_1_1 = 1

		for iter_1_2, iter_1_3 in pairs(MoonBoCfg[iter_1_1].reward) do
			if arg_1_0.rewards_[iter_1_1][var_1_1 - 1] and iter_1_3[1] ~= arg_1_0.rewards_[iter_1_1][var_1_1 - 1][1] then
				arg_1_0.rewards_[iter_1_1][var_1_1] = iter_1_3
				var_1_1 = var_1_1 + 1
			end

			if arg_1_0.rewards_[iter_1_1][var_1_1 - 1] == nil then
				arg_1_0.rewards_[iter_1_1][var_1_1] = iter_1_3
				var_1_1 = var_1_1 + 1
			end

			if arg_1_0.rewardsCount_[iter_1_1][iter_1_3[1]] then
				arg_1_0.rewardsCount_[iter_1_1][iter_1_3[1]] = arg_1_0.rewardsCount_[iter_1_1][iter_1_3[1]] + 1
			else
				arg_1_0.rewardsCount_[iter_1_1][iter_1_3[1]] = 1
			end
		end
	end
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if arg_2_1.activity_id == ActivityConst.MOONBO or arg_2_1.activity_id == ActivityConst.ACTIVITY_2_4_MOONBO then
		arg_2_0.todayTime_ = manager.time:GetServerTime()
		arg_2_0.todayGetCount_ = arg_2_1.today_draw_times

		arg_2_0:FreshCanGetCount()

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.unclaimed_reward) do
			arg_2_0.showRewards_[iter_2_1.level] = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1.unclaimed_item) do
				if arg_2_0.showRewards_[iter_2_1.level][iter_2_3.id] ~= nil then
					arg_2_0.showRewards_[iter_2_1.level][iter_2_3.id].count = arg_2_0.showRewards_[iter_2_1.level][iter_2_3.id].count + 1
				else
					arg_2_0.showRewards_[iter_2_1.level][iter_2_3.id] = {
						count = 1,
						id = iter_2_3.id,
						num = iter_2_3.num
					}
				end
			end
		end
	end
end

function var_0_0.GetRewards(arg_3_0, arg_3_1)
	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.dice_list) do
			arg_3_0.curDices_[iter_3_0] = iter_3_1
		end

		if arg_3_1.level then
			arg_3_0.curLevel_ = arg_3_1.level
		end

		if arg_3_1.reward then
			arg_3_0.curReward_ = {
				{
					arg_3_1.reward.id,
					arg_3_1.reward.num
				}
			}

			if arg_3_0.showRewards_[arg_3_0.curLevel_] and arg_3_0.showRewards_[arg_3_0.curLevel_][arg_3_1.reward.id] and arg_3_0.showRewards_[arg_3_0.curLevel_][arg_3_1.reward.id].count > 0 then
				arg_3_0.showRewards_[arg_3_0.curLevel_][arg_3_1.reward.id].count = arg_3_0.showRewards_[arg_3_0.curLevel_][arg_3_1.reward.id].count - 1
				arg_3_0.isShowText_ = false
			else
				arg_3_0.isShowText_ = true
			end
		end

		arg_3_0.todayGetCount_ = arg_3_0.todayGetCount_ + 1

		arg_3_0:FreshCanGetCount()
	end
end

function var_0_0.GetCurDices(arg_4_0)
	return arg_4_0.curDices_
end

function var_0_0.GetCurReward(arg_5_0)
	return arg_5_0.curReward_
end

function var_0_0.GetCanGetCount(arg_6_0)
	arg_6_0:FreshCanGetCount()

	return arg_6_0.canGetCount_
end

function var_0_0.SubTodayGetCount(arg_7_0, arg_7_1)
	arg_7_0.todayGetCount_ = arg_7_0.todayGetCount_ + arg_7_1

	arg_7_0:FreshCanGetCount()
end

function var_0_0.FreshCanGetCount(arg_8_0)
	arg_8_0.isOpenActivity_ = ActivityData:GetActivityIsOpen(ActivityConst.MOONBO)
	arg_8_0.isOpenReprintActivity_ = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_2_4_MOONBO)

	if arg_8_0.isOpenActivity_ or arg_8_0.isOpenReprintActivity_ then
		local var_8_0 = 0

		for iter_8_0, iter_8_1 in ipairs(GameSetting.activity_mooncake_gambling_num_get.value) do
			if iter_8_1 <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) then
				var_8_0 = iter_8_0
			else
				break
			end
		end

		arg_8_0.canGetCount_ = var_8_0 - arg_8_0.todayGetCount_
	else
		arg_8_0.canGetCount_ = 0

		manager.notify:Invoke(ACTIVITY_MOONBO_NEWDAY)
	end

	if arg_8_0.canGetCount_ > 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO), 1)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO), 0)
	end
end

function var_0_0.FreshTime(arg_9_0)
	arg_9_0:FreshCanGetCount()

	local var_9_0 = GameSetting.refresh_time1.value[1][1]
	local var_9_1 = TimeMgr.GetInstance():GetNextTime(var_9_0, 0, 0)

	if arg_9_0.freshTime_ ~= var_9_1 then
		arg_9_0.freshTime_ = var_9_1

		arg_9_0:PassDayClear()
	end
end

function var_0_0.PassDayClear(arg_10_0)
	arg_10_0.todayGetCount_ = 0

	arg_10_0:FreshCanGetCount()
	manager.notify:Invoke(ACTIVITY_MOONBO_NEWDAY)
end

function var_0_0.GetRewardIsShow(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.showRewards_[arg_11_1] and arg_11_0.showRewards_[arg_11_1][arg_11_2] and arg_11_0.showRewards_[arg_11_1][arg_11_2].count > 0 then
		return true
	end

	return false
end

function var_0_0.LevelNumToLanguage(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = GetTips("ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO")

	return GetTips(var_12_1 + arg_12_1)
end

function var_0_0.GetCurLevel(arg_13_0)
	return arg_13_0.curLevel_
end

function var_0_0.SetIsShowReward(arg_14_0, arg_14_1)
	arg_14_0.isShowReward_ = arg_14_1
end

function var_0_0.GetIsShowReward(arg_15_0)
	return arg_15_0.isShowReward_
end

function var_0_0.GetIsShowText(arg_16_0)
	return arg_16_0.isShowText_
end

function var_0_0.GetCfgRewards(arg_17_0, arg_17_1)
	return arg_17_0.rewards_[arg_17_1]
end

function var_0_0.GetCfgRewardsCount(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_0.rewardsCount_[arg_18_1][arg_18_2]
end

function var_0_0.GetCurCanGetRewardCount(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0.showRewards_[arg_19_1] and arg_19_0.showRewards_[arg_19_1][arg_19_2] and arg_19_0.showRewards_[arg_19_1][arg_19_2].count then
		return arg_19_0.showRewards_[arg_19_1][arg_19_2].count
	end

	return 0
end

return var_0_0
