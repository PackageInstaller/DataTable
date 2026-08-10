local var_0_0 = singletonClass("SpringFestivalGreetingData")

function var_0_0.Init(arg_1_0)
	arg_1_0.greetingList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.progress
	local var_2_1 = #arg_2_1.admiited_reward
	local var_2_2 = ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[arg_2_1.activity_id]

	if var_2_0 > #var_2_2 then
		var_2_0 = #var_2_2
	end

	arg_2_0.greetingList_[arg_2_1.activity_id] = {
		unlockCnt = var_2_0,
		receiveCnt = var_2_1
	}

	if var_2_1 < var_2_0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, arg_2_1.activity_id), 1)
	end

	manager.notify:Invoke(SPRING_FESTIVAL_GREETING_UPDATE)
end

function var_0_0.GetUnlockCnt(arg_3_0, arg_3_1)
	if arg_3_0.greetingList_[arg_3_1] == nil then
		arg_3_0:CreateData(arg_3_1)
	end

	return arg_3_0.greetingList_[arg_3_1].unlockCnt
end

function var_0_0.GetReceiveCnt(arg_4_0, arg_4_1)
	if arg_4_0.greetingList_[arg_4_1] == nil then
		arg_4_0:CreateData(arg_4_1)
	end

	return arg_4_0.greetingList_[arg_4_1].receiveCnt
end

function var_0_0.CreateData(arg_5_0, arg_5_1)
	arg_5_0.greetingList_[arg_5_1] = {
		receiveCnt = 0,
		unlockCnt = 1
	}
end

function var_0_0.ReceiveReward(arg_6_0, arg_6_1)
	arg_6_0.greetingList_[arg_6_1].receiveCnt = arg_6_0.greetingList_[arg_6_1].receiveCnt + 1

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, arg_6_1), 0)
end

return var_0_0
