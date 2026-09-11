local var_0_0 = singletonClass("TowerGameData")

function var_0_0:Init()
	self.levelinfo_ = {}
	self.curLevel_ = 1
	self.passMaxLevel_ = 0
	self.planeStatus_ = {}
	self.curpoint_ = 0
	self.isDirty_ = true
	self.APlaneCfg_ = {}
	self.BPlaneCfg_ = {}

	for iter_1_0, iter_1_1 in pairs(TowerGamePlaneCfg) do
		if iter_1_1.type and iter_1_1.type == 0 then
			table.insert(self.APlaneCfg_, iter_1_1)
		elseif iter_1_1.type and iter_1_1.type == 1 then
			table.insert(self.BPlaneCfg_, iter_1_1)
		end
	end

	table.sort(self.APlaneCfg_, function(arg_2_0, arg_2_1)
		return arg_2_0.id < arg_2_1.id
	end)
	table.sort(self.BPlaneCfg_, function(arg_3_0, arg_3_1)
		return arg_3_0.id < arg_3_1.id
	end)
	self:InitRedPoint()
end

function var_0_0.InitRedPoint(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(TowerGameCfg.all) do
		table.insert(var_4_0, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, iter_4_1))

		for iter_4_2, iter_4_3 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_4_1]) do
			table.insert(var_4_1, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, iter_4_3))
		end
	end

	local var_4_2 = string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME, ActivityConst.FACTORY_TOWERGAME)

	manager.redPoint:addGroup(var_4_2, var_4_0)
	manager.redPoint:addGroup(RedPointConst.MARDUK_TOWERGAME_REWARD, var_4_1)
	manager.redPoint:addGroup(var_4_2, {
		RedPointConst.MARDUK_TOWERGAME_REWARD
	})
end

function var_0_0:SetData(arg_5_1)
	self.levelinfo_[arg_5_1.activity_id] = {
		isclick = false,
		point = arg_5_1.activity_point,
		rewards = {},
		statu = arg_5_1.clear_state
	}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.reward_info) do
		self.levelinfo_[arg_5_1.activity_id].rewards[iter_5_1.point_id] = iter_5_1.point_reward_state
	end

	for iter_5_2, iter_5_3 in pairs(self.levelinfo_) do
		if iter_5_3.statu == 1 and iter_5_2 > self.passMaxLevel_ then
			self.passMaxLevel_ = iter_5_2
		end
	end

	self:RefreshPlaneStatus()
	self:RefreshRewardRedPoint()
	self:RefreshBattleRedPoint()
end

function var_0_0:GetLevelStatuByLevelId(arg_6_1)
	if ActivityData:GetActivityIsOpen(arg_6_1) then
		if self.levelinfo_[arg_6_1] and self.levelinfo_[arg_6_1].statu == 1 then
			return "finish"
		else
			return "normal"
		end
	else
		return "lock"
	end
end

function var_0_0:GetLevelIsShowPointByLevelID(arg_7_1)
	if ActivityData:GetActivityIsOpen(arg_7_1) then
		if self.levelinfo_[arg_7_1] and self.levelinfo_[arg_7_1].statu == 1 then
			return "true", self.levelinfo_[arg_7_1].point
		else
			return "false", 0
		end
	else
		return "false", 0
	end
end

function var_0_0:GetRewardStatuByLevelIDAndPointId(arg_8_1, arg_8_2)
	if self.levelinfo_[arg_8_1] and self.levelinfo_[arg_8_1].rewards and self.levelinfo_[arg_8_1].rewards[arg_8_2] and self.levelinfo_[arg_8_1].rewards[arg_8_2] == 2 then
		return "finished"
	elseif self.levelinfo_[arg_8_1] and self.levelinfo_[arg_8_1].point >= ActivityPointRewardCfg[arg_8_2].need then
		return "normal"
	else
		return "unfinished"
	end
end

function var_0_0:GetReward(arg_9_1)
	self.levelinfo_[ActivityPointRewardCfg[arg_9_1].activity_id].rewards[arg_9_1] = 2

	self:RefreshRewardRedPoint()
end

function var_0_0.SetSeverPoint(arg_10_0, arg_10_1)
	arg_10_0.curpoint_ = arg_10_1
end

function var_0_0:GetCurPoint()
	return self.curpoint_
end

function var_0_0.SetLevel(arg_12_0, arg_12_1)
	arg_12_0.curLevel_ = arg_12_1
end

function var_0_0:GetRewardsNum()
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(self.levelinfo_) do
		if iter_13_1.rewards then
			for iter_13_2, iter_13_3 in pairs(iter_13_1.rewards) do
				if iter_13_3 == 2 then
					var_13_0 = var_13_0 + 1
				end
			end
		end
	end

	return var_13_0
end

function var_0_0.GetAllRewardNum(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(TowerGameCfg.all) do
		var_14_0 = var_14_0 + #ActivityPointRewardCfg.get_id_list_by_activity_id[iter_14_1]
	end

	return var_14_0
end

function var_0_0:GetATypePlaneNum()
	return #self.APlaneCfg_
end

function var_0_0:GetBTypePlaneNum()
	return #self.BPlaneCfg_
end

function var_0_0:GetPlaneCfgByTypeAndIndex(arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		return self.APlaneCfg_[arg_17_2]
	else
		return self.BPlaneCfg_[arg_17_2]
	end
end

function var_0_0:GetPointByLevelID(arg_18_1)
	if self.levelinfo_[arg_18_1] and self.levelinfo_[arg_18_1].point then
		return self.levelinfo_[arg_18_1].point
	end
end

function var_0_0:RefreshPlaneStatus()
	for iter_19_0, iter_19_1 in ipairs(TowerGamePlaneCfg.all) do
		self.planeStatus_[iter_19_1] = TowerGamePlaneCfg[iter_19_1].condition <= self.passMaxLevel_
	end
end

function var_0_0:GetCanUsePlane()
	self:RefreshPlaneStatus()

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(self.planeStatus_) do
		if iter_20_1 then
			table.insert(var_20_0, iter_20_0)
		end
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		return arg_21_0 < arg_21_1
	end)

	return var_20_0
end

function var_0_0:GetPlaneIsUnlock(arg_22_1)
	return self.planeStatus_[arg_22_1]
end

function var_0_0:SetLevleClick(arg_23_1)
	self.levelinfo_[arg_23_1].isclick = true

	self:RefreshBattleRedPoint()
end

function var_0_0:RefreshRewardRedPoint()
	for iter_24_0, iter_24_1 in pairs(self.levelinfo_) do
		for iter_24_2, iter_24_3 in pairs(iter_24_1.rewards) do
			if iter_24_3 == 1 then
				if iter_24_1.point > ActivityPointRewardCfg[iter_24_2].need then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, iter_24_2), 1)
				else
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, iter_24_2), 0)
				end
			elseif iter_24_3 == 2 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_REWARD, iter_24_2), 0)
			end
		end
	end
end

function var_0_0:RefreshBattleRedPoint()
	for iter_25_0, iter_25_1 in pairs(self.levelinfo_) do
		if iter_25_1.statu == 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, iter_25_0), 0)
		elseif iter_25_1.statu == 0 then
			if iter_25_1.isclick == false then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, iter_25_0), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, iter_25_0), 0)
			end
		end
	end
end

function var_0_0:GetFirstCanGetRewardIndex()
	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(self.levelinfo_) do
		for iter_26_2, iter_26_3 in pairs(iter_26_1.rewards) do
			if iter_26_3 == 1 and iter_26_1.point >= ActivityPointRewardCfg[iter_26_2].need then
				if var_26_0 == 0 then
					var_26_0 = iter_26_0
				elseif iter_26_0 < var_26_0 then
					var_26_0 = iter_26_0
				end
			end
		end
	end

	if var_26_0 > 0 then
		return table.indexof(TowerGameCfg.all, var_26_0)
	else
		return 1
	end
end

return var_0_0
