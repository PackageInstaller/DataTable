local var_0_0 = singletonClass("DestroyBoxGameData")

var_0_0.CHALLENGE_MAX_HARD_LEVEL = 2
var_0_0.SPECTIAL_HARD_LEVEL = 9

function var_0_0:Init()
	self.boxStageData_ = {}
	self.receiveRewardList_ = {}
	self.boxDifficultList_ = {}

	self:ParseCfg()

	self.curSelectID_ = {}
	self.curSelectDifficult_ = {}
	self.lastSelectNormalID_ = {}
end

function var_0_0:ParseCfg()
	for iter_2_0, iter_2_1 in pairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id) do
		self.boxDifficultList_[iter_2_0] = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			if self.boxDifficultList_[iter_2_0][DestroyBoxGameCfg[iter_2_3].difficult] == nil then
				self.boxDifficultList_[iter_2_0][DestroyBoxGameCfg[iter_2_3].difficult] = {}
			end

			table.insert(self.boxDifficultList_[iter_2_0][DestroyBoxGameCfg[iter_2_3].difficult], iter_2_3)
		end
	end
end

function var_0_0:InitData(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.stage_info_list) do
		self.boxStageData_[iter_3_1.id] = {
			isSuccess = iter_3_1.is_success,
			maxScore = iter_3_1.history_max_score
		}
	end

	self.receiveRewardList_[arg_3_1.main_activity_id] = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.got_reward_id_list) do
		table.insert(self.receiveRewardList_[arg_3_1.main_activity_id], iter_3_3)
	end

	DestroyBoxGameAction.UpdateAllRedPoint(arg_3_1.main_activity_id)
	self:UpdateRewardRedPoint(arg_3_1.main_activity_id)
end

function var_0_0:GetDifficultList(arg_4_1)
	return self.boxDifficultList_[arg_4_1]
end

function var_0_0:GetStageData(arg_5_1)
	return self.boxStageData_[arg_5_1]
end

function var_0_0:GetReceiveRewardList(arg_6_1)
	return self.receiveRewardList_[arg_6_1]
end

function var_0_0:UpdateReceiveRewardList(arg_7_1, arg_7_2)
	table.insertto(self.receiveRewardList_[arg_7_1], arg_7_2)
	self:UpdateRewardRedPoint(arg_7_1)
end

function var_0_0:UpdateRewardRedPoint(arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(DestroyBoxGameRewardCfg.get_id_list_by_main_activity_id[arg_8_1]) do
		local var_8_1 = 0

		if DestroyBoxGameTools.IsUnlockReward(iter_8_1) and not table.keyof(self.receiveRewardList_[arg_8_1], iter_8_1) then
			if DestroyBoxGameRewardCfg[iter_8_1].need_show == 1 then
				var_8_0 = 1
			else
				var_8_1 = 1
			end
		end

		if DestroyBoxGameRewardCfg[iter_8_1].need_show ~= 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_CHALLENGE_REWARD, DestroyBoxGameRewardCfg[iter_8_1].activity_id), var_8_1)
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, arg_8_1), var_8_0)
end

function var_0_0:IsClearStage(arg_9_1)
	return (self.boxStageData_[arg_9_1] or nil) and (self.boxStageData_[arg_9_1].isSuccess or false)
end

function var_0_0:IsFinishPreStage(arg_10_1)
	if DestroyBoxGameCfg[arg_10_1].unlock_condition ~= "" then
		if self.boxStageData_[DestroyBoxGameCfg[arg_10_1].unlock_condition[1]] and self.boxStageData_[DestroyBoxGameCfg[arg_10_1].unlock_condition[1]].isSuccess and DestroyBoxGameCfg[arg_10_1].unlock_condition[2] <= self.boxStageData_[DestroyBoxGameCfg[arg_10_1].unlock_condition[1]].maxScore then
			return true
		end

		return false
	end

	return true
end

function var_0_0:RefreshScore(arg_11_1)
	if self.boxStageData_[arg_11_1.id] then
		self.boxStageData_[arg_11_1.id].historyMaxScore = self.boxStageData_[arg_11_1.id].maxScore

		if arg_11_1.settle_score > self.boxStageData_[arg_11_1.id].maxScore then
			self.boxStageData_[arg_11_1.id].maxScore = arg_11_1.settle_score
		end

		self.boxStageData_[arg_11_1.id].score = arg_11_1.settle_score
		self.boxStageData_[arg_11_1.id].isSuccess = true
	else
		self.boxStageData_[arg_11_1.id] = {
			isSuccess = true,
			historyMaxScore = 0,
			maxScore = arg_11_1.settle_score,
			score = arg_11_1.settle_score
		}
	end

	local var_11_0 = DestroyBoxGameCfg[arg_11_1.id].main_activity_id

	DestroyBoxGameAction.UpdateAllRedPoint(DestroyBoxGameCfg[arg_11_1.id].main_activity_id)
	self:UpdateRewardRedPoint(var_11_0)
end

function var_0_0:SwitchDifficult(arg_12_1, arg_12_2)
	local var_12_0 = DestroyBoxGameCfg[arg_12_1]

	if DestroyBoxGameCfg[arg_12_1].difficult <= var_0_0.CHALLENGE_MAX_HARD_LEVEL then
		arg_12_1 = DestroyBoxGameCfg.get_id_list_by_activity_id[var_12_0.activity_id][arg_12_2]
	else
		local var_12_1 = var_12_0.main_activity_id
		local var_12_2 = DestroyBoxGameCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[self:GetLastSelectNormalID(var_12_0.main_activity_id)].activity_id][arg_12_2]

		self.lastSelectNormalID_[var_12_0.main_activity_id] = var_12_2

		saveData("destroyBoxGame", string.format("lastSelectNormalID_%s", var_12_1), var_12_2)
	end

	return arg_12_1
end

function var_0_0:SetSelectIDAndDifficult(arg_13_1, arg_13_2, arg_13_3)
	self.curSelectID_[arg_13_1] = arg_13_2

	saveData("destroyBoxGame", string.format("id_%s", arg_13_1), arg_13_2)

	local var_13_0

	if not arg_13_3 then
		::label_13_0::

		var_13_0 = self.curSelectDifficult_[arg_13_1] or 1
	end

	self.curSelectDifficult_[arg_13_1] = var_13_0

	if DestroyBoxGameCfg[arg_13_2].difficult <= var_0_0.CHALLENGE_MAX_HARD_LEVEL then
		self.lastSelectNormalID_[arg_13_1] = arg_13_2

		saveData("destroyBoxGame", string.format("lastSelectNormalID_%s", arg_13_1), arg_13_2)
	end
end

function var_0_0:GetSelectID(arg_14_1)
	local var_14_0 = self.curSelectID_[arg_14_1]

	if not self.curSelectID_[arg_14_1] then
		var_14_0 = getData("destroyBoxGame", string.format("id_%s", arg_14_1))
		var_14_0 = var_14_0 or self:GetCurMaxStageID(arg_14_1)
	end

	self.curSelectID_[arg_14_1] = var_14_0

	return self.curSelectID_[arg_14_1]
end

function var_0_0:GetSelectDifficult(arg_15_1)
	if self.curSelectDifficult_[arg_15_1] then
		return self.curSelectDifficult_[arg_15_1]
	end

	local var_15_0 = self:GetLastSelectNormalID(arg_15_1)
	local var_15_1 = table.keyof(DestroyBoxGameCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[var_15_0].activity_id], var_15_0) or 1

	self.curSelectDifficult_[arg_15_1] = var_15_1

	return var_15_1
end

function var_0_0:GetLastSelectNormalID(arg_16_1)
	local var_16_0 = self.lastSelectNormalID_[arg_16_1]

	if not self.lastSelectNormalID_[arg_16_1] then
		var_16_0 = getData("destroyBoxGame", string.format("lastSelectNormalID_%s", arg_16_1))
		var_16_0 = var_16_0 or self:GetCurMaxNormalStageID(arg_16_1)
	end

	self.lastSelectNormalID_[arg_16_1] = var_16_0

	return self.lastSelectNormalID_[arg_16_1]
end

function var_0_0:GetCurMaxStageID(arg_17_1)
	local var_17_0

	for iter_17_0, iter_17_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[arg_17_1]) do
		if iter_17_0 == 1 and not self:IsFinishFirstStage(DestroyBoxGameCfg[iter_17_1].activity_id) then
			return iter_17_1
		end

		if not self:IsFinishPreStage(iter_17_1) then
			return var_17_0
		end

		var_17_0 = iter_17_1
	end

	return var_17_0
end

function var_0_0:GetCurMaxNormalStageID(arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[arg_18_1]) do
		if iter_18_0 == 1 and not self:IsFinishFirstStage(DestroyBoxGameCfg[iter_18_1].activity_id) then
			return iter_18_1
		end

		if DestroyBoxGameCfg[iter_18_1].difficult <= var_0_0.CHALLENGE_MAX_HARD_LEVEL then
			if not self:IsFinishPreStage(iter_18_1) then
				return iter_18_1
			end

			var_18_0 = iter_18_1
		end
	end

	return var_18_0
end

function var_0_0:IsFinishFirstStage(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[arg_19_1]) do
		if self.boxStageData_[iter_19_1] and self.boxStageData_[iter_19_1].isSuccess then
			return true
		end
	end

	return false
end

return var_0_0
