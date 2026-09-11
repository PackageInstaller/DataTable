local var_0_0 = singletonClass("PaChinKoData")

function var_0_0.Init(arg_1_0)
	arg_1_0.rewardList_ = {}
	arg_1_0.rewardData_ = {}
end

function var_0_0:InitPaChinKoData(arg_2_1)
	self.rewardList_[arg_2_1.activity_id] = {}
	self.rewardData_[arg_2_1.activity_id] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.reward_list) do
		self:AddPachinKoReward(arg_2_1.activity_id, iter_2_1)
	end

	PaChinKoAction.UpdateRedPoint(arg_2_1.activity_id)
end

function var_0_0:AddPachinKoReward(arg_3_1, arg_3_2)
	self.rewardData_[arg_3_1] = self.rewardData_[arg_3_1] or {}
	self.rewardList_[arg_3_1] = self.rewardList_[arg_3_1] or {}
	self.rewardData_[arg_3_1][arg_3_2] = (self.rewardData_[arg_3_1][arg_3_2] or 0) + 1

	table.insert(self.rewardList_[arg_3_1], arg_3_2)
end

function var_0_0:GetRewardData(arg_4_1)
	return self.rewardData_[arg_4_1] or {}
end

function var_0_0:GetRewardList(arg_5_1)
	return self.rewardList_[arg_5_1] or {}
end

return var_0_0
