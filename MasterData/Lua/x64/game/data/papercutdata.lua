local var_0_0 = singletonClass("PaperCutData")

function var_0_0.Init(arg_1_0)
	arg_1_0.scoreList_ = {}
	arg_1_0.receivedList_ = {}
	arg_1_0.playedList_ = {}
end

function var_0_0:SetData(arg_2_1)
	self.scoreList_[arg_2_1.activity_id] = arg_2_1.score
	self.receivedList_[arg_2_1.activity_id] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_reward_list) do
		table.insert(self.receivedList_[arg_2_1.activity_id], iter_2_1)
	end

	self.playedList_[arg_2_1.activity_id] = arg_2_1.is_play

	self:RefreshSelectRedPoint(arg_2_1.activity_id)
	self:RefreshRewardRedPoint(arg_2_1.activity_id)
end

function var_0_0:GetPlayedList(arg_3_1)
	return self.playedList_[arg_3_1] or false
end

function var_0_0:GetScore(arg_4_1)
	return self.scoreList_[arg_4_1] or 0
end

function var_0_0:SetScore(arg_5_1, arg_5_2)
	if self.scoreList_[arg_5_1] == nil then
		self.scoreList_[arg_5_1] = arg_5_2
	elseif arg_5_2 < self.scoreList_[arg_5_1] then
		self.scoreList_[arg_5_1] = self.scoreList_[arg_5_1] or arg_5_2
	end

	self.playedList_[arg_5_1] = true

	self:RefreshSelectRedPoint(arg_5_1)
	self:RefreshRewardRedPoint(arg_5_1)
end

function var_0_0:GetReceivedList(arg_6_1)
	return self.receivedList_[arg_6_1] or {}
end

function var_0_0:SetReceivedList(arg_7_1, arg_7_2)
	self.receivedList_[arg_7_1] = self.receivedList_[arg_7_1] or {}

	if table.keyof(self.receivedList_[arg_7_1], arg_7_2) == nil then
		table.insert(self.receivedList_[arg_7_1], arg_7_2)
	end

	self:RefreshRewardRedPoint(arg_7_1)
end

function var_0_0:GetRewardList(arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0, iter_8_1 in ipairs(ActivityCfg[arg_8_1].sub_activity_list) do
		local var_8_4 = self:GetScore(iter_8_1)
		local var_8_5 = self:GetReceivedList(iter_8_1)

		for iter_8_2, iter_8_3 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_8_1]) do
			if var_8_4 < ActivityPointRewardCfg[iter_8_3].need then
				var_8_1[#var_8_1 + 1] = iter_8_3
			elseif table.keyof(var_8_5, iter_8_3) == nil then
				var_8_2[#var_8_2 + 1] = iter_8_3
			else
				var_8_3[#var_8_3 + 1] = iter_8_3
			end
		end
	end

	table.insertto(var_8_0, var_8_2)
	table.insertto(var_8_0, var_8_1)
	table.insertto(var_8_0, var_8_3)

	return var_8_0
end

function var_0_0.SetSelectActivityID(arg_9_0, arg_9_1)
	manager.redPoint:setTip(string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, PaperCutCfg[arg_9_1].main_activity_id, arg_9_1), 0)
end

function var_0_0:RefreshSelectRedPoint(arg_10_1)
	manager.redPoint:setTip(string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, PaperCutCfg[arg_10_1].main_activity_id, arg_10_1), self.playedList_[arg_10_1] == true and 0 or 1)
end

function var_0_0:RefreshRewardRedPoint(arg_11_1)
	manager.redPoint:setTip(string.format("%s_%s_%s_Reward", RedPointConst.PAPER_CUT, PaperCutCfg[arg_11_1].main_activity_id, arg_11_1), (PaperCutCfg[arg_11_1] or nil) and (self:GetScore(arg_11_1) >= ActivityPointRewardCfg[PaperCutCfg[arg_11_1].task_id].need and table.keyof(self.receivedList_[arg_11_1], PaperCutCfg[arg_11_1].task_id) == nil and 1 or 0))
end

function var_0_0.GetLastContentPosX(arg_12_0, arg_12_1)
	return getData(string.format("PaperCut_%d", arg_12_1), "contentPosX")
end

function var_0_0.SetLastContentPosX(arg_13_0, arg_13_1, arg_13_2)
	saveData(string.format("PaperCut_%d", arg_13_1), "contentPosX", arg_13_2)
end

return var_0_0
