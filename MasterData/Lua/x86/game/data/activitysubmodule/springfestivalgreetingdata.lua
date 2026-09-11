local var_0_0 = singletonClass("SpringFestivalGreetingData")

function var_0_0.Init(arg_1_0)
	arg_1_0.greetingList_ = {}
end

function var_0_0:InitData(arg_2_1)
	local var_2_0 = arg_2_1.progress

	if arg_2_1.progress > #ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[arg_2_1.activity_id] then
		var_2_0 = #ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[arg_2_1.activity_id]
	end

	self.greetingList_[arg_2_1.activity_id] = {
		unlockCnt = var_2_0,
		receiveCnt = #arg_2_1.admiited_reward
	}

	if #arg_2_1.admiited_reward < var_2_0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, arg_2_1.activity_id), 1)
	end

	manager.notify:Invoke(SPRING_FESTIVAL_GREETING_UPDATE)
end

function var_0_0:GetUnlockCnt(arg_3_1)
	if self.greetingList_[arg_3_1] == nil then
		self:CreateData(arg_3_1)
	end

	return self.greetingList_[arg_3_1].unlockCnt
end

function var_0_0:GetReceiveCnt(arg_4_1)
	if self.greetingList_[arg_4_1] == nil then
		self:CreateData(arg_4_1)
	end

	return self.greetingList_[arg_4_1].receiveCnt
end

function var_0_0:CreateData(arg_5_1)
	self.greetingList_[arg_5_1] = {
		receiveCnt = 0,
		unlockCnt = 1
	}
end

function var_0_0:ReceiveReward(arg_6_1)
	self.greetingList_[arg_6_1].receiveCnt = self.greetingList_[arg_6_1].receiveCnt + 1

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, arg_6_1), 0)
end

return var_0_0
