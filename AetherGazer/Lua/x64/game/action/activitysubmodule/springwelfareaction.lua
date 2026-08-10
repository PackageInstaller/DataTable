local var_0_0 = {}

manager.net:Bind(76411, function(arg_1_0)
	SpringWelfareData:InitData(arg_1_0)
	SpringWelfareAction:InitRedPoint(arg_1_0)
	Timer.New(function()
		SpringWelfareAction:UpdateRedPoint(arg_1_0.activity_id)
	end, 1, 0):Start()
	manager.notify:CallUpdateFunc(ACTIVITY_SPRING_WELFARE_INIT)
end)

function var_0_0.StartPray(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0
	local var_3_1 = SpringWelfareData:GetDayState(arg_3_1)

	if var_3_1 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		var_3_0 = 1
	elseif var_3_1 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		var_3_0 = 0
	else
		return
	end

	local var_3_2 = {
		activity_id = SpringWelfareData:GetActivityId(),
		type = var_3_0
	}

	manager.net:SendWithLoadingNew(76414, var_3_2, 76415, function(arg_4_0, arg_4_1)
		if not isSuccess(arg_4_0.result) then
			ShowTips(arg_4_0.result)

			return
		end

		SpringWelfareData:ModifyPrayedDay(arg_3_1)
		arg_3_2(arg_3_1)
		getReward(arg_4_0.reward_list or {})
	end)
end

function var_0_0.AcquireDailyPointReward(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		point_reward_id_list = {
			arg_5_1
		}
	}

	manager.net:SendWithLoadingNew(60054, var_5_0, 60055, function(arg_6_0, arg_6_1)
		if not isSuccess(arg_6_0.result) then
			ShowTips(arg_6_0.result)

			return
		end

		getReward2(mergeReward2(arg_6_0.reward_list))
		SpringWelfareData:AcquireDailyPointReward(arg_5_1)
		arg_5_2()
	end)
end

function var_0_0.FetchAllLetterPlayerInfo(arg_7_0)
	if SpringWelfareData:IsFetched() then
		return
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(SpringWelfareData:GetLetterList()) do
		local var_7_1 = SpringWelfareData:GetLetterData(iter_7_1)

		if var_7_1.isPlayer then
			table.insert(var_7_0, var_7_1.playerId)
		end
	end

	local var_7_2 = {
		user_id_list = var_7_0
	}

	manager.net:SendWithLoadingNew(32036, var_7_2, 32037, function(arg_8_0, arg_8_1)
		if not isSuccess(arg_8_0.result) then
			ShowTips(arg_8_0.result)

			return
		end

		SpringWelfareData:RefreshLetterPlayerInfo(arg_8_0.user_brief_list)
		SpringWelfareData:SetFetchState(true)
		manager.notify:CallUpdateFunc("OnLetterPlayerInfoFetched")
	end)
end

function var_0_0.AcquireLetterReward(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {
		activity_id = SpringWelfareData:GetActivityId(),
		day = arg_9_1
	}

	manager.net:SendWithLoadingNew(76412, var_9_0, 76413, function(arg_10_0, arg_10_1)
		if not isSuccess(arg_10_0.result) then
			ShowTips(arg_10_0.result)

			return
		end

		local var_10_0 = arg_9_1

		SpringWelfareData:AcquireLetterReward(var_10_0)
		getReward(arg_10_0.reward_list or {})
		arg_9_2()
	end)
end

function var_0_0.InitRedPoint(arg_11_0, arg_11_1)
	arg_11_0.BannedRedPoint_ = arg_11_0.BannedRedPoint_ or {}

	local var_11_0 = arg_11_1.activity_id

	arg_11_0.activityId_ = var_11_0

	if not ActivityData:GetActivityIsOpen(var_11_0) then
		return
	end

	local var_11_1 = ActivityTools.GetRedPointKey(var_11_0) .. var_11_0
	local var_11_2 = string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, var_11_1)
	local var_11_3 = string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, var_11_1)
	local var_11_4 = {}

	table.insert(var_11_4, var_11_2)
	table.insert(var_11_4, var_11_3)
	manager.redPoint:addGroup(var_11_1, var_11_4)

	if not arg_11_0.registerEvent_ then
		manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
			arg_11_0:UpdateRedPoint(arg_11_0.activityId_)
		end)

		arg_11_0.registerEvent_ = true
	end
end

function var_0_0.UpdateRedPoint(arg_13_0, arg_13_1)
	local var_13_0 = ActivityTools.GetRedPointKey(arg_13_1) .. arg_13_1
	local var_13_1 = string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, var_13_0)
	local var_13_2 = string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, var_13_0)
	local var_13_3 = 0
	local var_13_4 = SpringWelfareData:GetSystemLetterIdList()

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		if SpringWelfareData:GetLetterData(iter_13_1).gotReward == false then
			var_13_3 = 1

			break
		end
	end

	local var_13_5 = 0

	if SpringWelfareData:HasTaskCanAcquire() then
		var_13_5 = 1
	elseif not SpringWelfareData:IsTodayPtAcquired() and SpringWelfareData:IsTodayPtCanAcquire() then
		var_13_5 = 1
	end

	manager.redPoint:setTip(var_13_1, var_13_3)
	manager.redPoint:setTip(var_13_2, var_13_5)
end

function var_0_0.BanRedPoint(arg_14_0, arg_14_1)
	arg_14_0.BannedRedPoint_[arg_14_1] = true
end

return var_0_0
