local var_0_0 = singletonClass("ActivityPointData")

function var_0_0.Init(arg_1_0)
	arg_1_0.residentScoreDataDic_ = {}
	arg_1_0.completedIdDic_ = {}
	arg_1_0.activityUseDunDunDataList_ = {}
end

function var_0_0:InitData(arg_2_1)
	self:UpdateCompletedData(arg_2_1.reward_list)
end

function var_0_0:UpdateCompletedData(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self:AddPointRewardID(iter_3_1)
	end
end

function var_0_0:InitResidentScore(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.score_info_list) do
		self.residentScoreDataDic_[iter_4_1.key] = iter_4_1.score
	end
end

function var_0_0:InitResidentCompletedData(arg_5_1)
	self:UpdateCompletedData(arg_5_1.reward_info_list)
end

function var_0_0:GetResidentScore(arg_6_1)
	return self.residentScoreDataDic_[arg_6_1] or 0
end

function var_0_0:IsCompleteID(arg_7_1)
	if not self.completedIdDic_[arg_7_1] then
		return false
	end

	return self.completedIdDic_[arg_7_1] == true
end

function var_0_0:AddPointRewardID(arg_8_1)
	self.completedIdDic_[arg_8_1] = true
end

function var_0_0:InitUseDunDunData(arg_9_1)
	self.activityUseDunDunDataList_ = {}
	self.activityUseDunDunDataList_[arg_9_1.activity_id] = {
		point = arg_9_1.point,
		rewardIDList = cleanProtoTable(arg_9_1.reward_list)
	}

	self:UpdateUseDunDunRedPoint(arg_9_1.activity_id)
end

function var_0_0:GetUseDunDunRewardIsGet(arg_10_1, arg_10_2)
	if self.activityUseDunDunDataList_[arg_10_1] then
		if table.indexof(self.activityUseDunDunDataList_[arg_10_1].rewardIDList, arg_10_2) then
			return true
		else
			return false
		end
	end
end

function var_0_0:GetCurDunDunPoint(arg_11_1)
	if self.activityUseDunDunDataList_[arg_11_1] then
		return self.activityUseDunDunDataList_[arg_11_1].point
	else
		return 0
	end
end

function var_0_0:GetUseDunDunReward(arg_12_1, arg_12_2)
	if self.activityUseDunDunDataList_[arg_12_1] and self.activityUseDunDunDataList_[arg_12_1].rewardIDList then
		for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
			table.insert(self.activityUseDunDunDataList_[arg_12_1].rewardIDList, iter_12_1)
		end
	else
		self.activityUseDunDunDataList_[arg_12_1] = {
			point = 0,
			rewardIDList = {}
		}

		for iter_12_2, iter_12_3 in ipairs(arg_12_2) do
			table.insert(self.activityUseDunDunDataList_[arg_12_1].rewardIDList, iter_12_3)
		end
	end

	self:UpdateUseDunDunRedPoint(arg_12_1)
end

function var_0_0:UpdateUseDunDunRedPoint(arg_13_1)
	if ActivityData:GetActivityIsOpen(arg_13_1) then
		if self.activityUseDunDunDataList_[arg_13_1] then
			for iter_13_0, iter_13_1 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_13_1]) do
				if self.activityUseDunDunDataList_[arg_13_1].point >= ActivityPointRewardCfg[iter_13_1].need then
					if table.indexof(self.activityUseDunDunDataList_[arg_13_1].rewardIDList, iter_13_1) then
						manager.redPoint:setTip(RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_1, 0)
					else
						manager.redPoint:setTip(RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_1, 1)
					end
				else
					manager.redPoint:setTip(RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_1, 0)
				end
			end
		else
			for iter_13_2, iter_13_3 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_13_1]) do
				manager.redPoint:setTip(RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_3, 0)
			end
		end
	else
		for iter_13_4, iter_13_5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_13_1]) do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_USE_DUNDUN_REWARD .. iter_13_5, 0)
		end
	end
end

return var_0_0
