local var_0_0 = singletonClass("CoreVerificationChallengeMode4Data")

var_0_0.TaskState = {
	Completed = 2,
	CanGetReward = 1,
	InProgress = 0
}

function var_0_0.Init(arg_1_0)
	arg_1_0.commonStage = {}
	arg_1_0.challengeStage = {}
	arg_1_0.finishedTaskInfo = {}
	arg_1_0.firstEnterTipsHasShown = false
	arg_1_0.activityID = 0
	arg_1_0.lastBattleScore = 0
end

function var_0_0:Update(arg_2_1)
	self.commonStage = {}
	self.challengeStage = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.common_stages) do
		local var_2_0 = iter_2_1.stage_id
		local var_2_1 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.common_locks) do
			var_2_1[iter_2_3.index] = {
				heroList = iter_2_3.hero_id_list,
				score = iter_2_3.cur_value,
				time = iter_2_3.seconds
			}
		end

		table.insert(((nullable(CoreVerificationClMode4Cfg, var_2_0, "stage_type") or 1) == 1 or nil) and (self.commonStage or self.challengeStage), {
			stageID = var_2_0,
			teams = var_2_1
		})
	end

	self.finishedTaskInfo = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.finish_assignment_list) do
		self.finishedTaskInfo[iter_2_5.assignment_id] = iter_2_5.state
	end

	self.firstEnterTipsHasShown = arg_2_1.first_enter
	self.maxPoint = arg_2_1.max_point

	CoreVerificationChallengeTools.InitCache()

	self.activityID = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)

	self:InitTaskInfo()
end

function var_0_0.UpdateLastBattleScore(arg_3_0, arg_3_1)
	arg_3_0.lastBattleScore = arg_3_1
end

function var_0_0:GetLastBattleScore()
	return self.lastBattleScore
end

function var_0_0:OnResetTeam(arg_5_1, arg_5_2)
	local var_5_0 = self:GetStageDataByStageID(arg_5_1)

	if var_5_0 and var_5_0.teams[arg_5_2] then
		var_5_0.teams[arg_5_2].heroList = {}
		var_5_0.teams[arg_5_2].score = 0
		var_5_0.teams[arg_5_2].time = nil
	end
end

function var_0_0:OnResetStage(arg_6_1)
	local var_6_0 = self:GetStageDataByStageID(arg_6_1)

	if var_6_0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0.teams) do
			iter_6_1.heroList = {}
			iter_6_1.score = 0
			iter_6_1.time = nil
		end
	end
end

function var_0_0:OnResetAll()
	for iter_7_0, iter_7_1 in ipairs(self.commonStage) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1.teams) do
			iter_7_3.heroList = {}
			iter_7_3.score = 0
			iter_7_3.time = nil
		end
	end

	for iter_7_4, iter_7_5 in ipairs(self.challengeStage) do
		for iter_7_6, iter_7_7 in pairs(iter_7_5.teams) do
			iter_7_7.heroList = {}
			iter_7_7.score = 0
			iter_7_7.time = nil
		end
	end
end

function var_0_0:InitTaskInfo()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(CoreVerificationClRewardCfg.get_id_list_by_activity_id[ActivityCfg[self.activityID].sub_activity_list[2]] or {}) do
		table.insert(var_8_0, {
			taskId = iter_8_1,
			reward_type = CoreVerificationClRewardCfg[iter_8_1].reward_type
		})
	end

	self.allTaskInfo = var_8_0
end

function var_0_0:GetActivityID()
	return self.activityID
end

function var_0_0:GetCommonStage()
	return self.commonStage
end

function var_0_0:GetChallengeStage()
	return self.challengeStage
end

function var_0_0:GetStageDataByStageID(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.commonStage) do
		if iter_12_1.stageID == arg_12_1 then
			return iter_12_1
		end
	end

	for iter_12_2, iter_12_3 in ipairs(self.challengeStage) do
		if iter_12_3.stageID == arg_12_1 then
			return iter_12_3
		end
	end

	return nil
end

function var_0_0:GetSeasonIsTips()
	return not self.firstEnterTipsHasShown
end

function var_0_0.SetSeasonIsTips(arg_14_0, arg_14_1)
	arg_14_0.firstEnterTipsHasShown = not arg_14_1
end

function var_0_0.UpdateIllustrated(arg_15_0, arg_15_1)
	return
end

function var_0_0:UpdateFinishTaskData(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		self.finishedTaskInfo[iter_16_1] = var_0_0.TaskState.Completed
	end
end

function var_0_0:GetCurPoint()
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(self.challengeStage) do
		for iter_17_2, iter_17_3 in pairs(iter_17_1.teams) do
			var_17_0 = var_17_0 + iter_17_3.score
		end
	end

	if var_17_0 == 0 then
		return 0
	end

	local var_17_1 = var_17_0

	for iter_17_4, iter_17_5 in ipairs(self.commonStage) do
		for iter_17_6, iter_17_7 in pairs(iter_17_5.teams) do
			var_17_1 = var_17_1 + iter_17_7.score
		end
	end

	return var_17_1
end

function var_0_0:GetMaxPoint()
	return self.maxPoint
end

function var_0_0:GetRankScore()
	return self:GetMaxPoint()
end

function var_0_0:GetAllTaskInfo()
	return self.allTaskInfo or {}
end

function var_0_0:GetTaskState(arg_21_1)
	return nullable(self.finishedTaskInfo, arg_21_1) or var_0_0.TaskState.InProgress
end

function var_0_0:GetTaskInfoById(arg_22_1)
	return {
		taskId = arg_22_1,
		state = self:GetTaskState(arg_22_1),
		reward_type = CoreVerificationClRewardCfg[arg_22_1].reward_type
	}
end

function var_0_0:IsGetAllTaskReward()
	if self.finishedTaskInfo == nil or next(self.finishedTaskInfo) == nil then
		return false
	end

	for iter_23_0, iter_23_1 in pairs(self.finishedTaskInfo) do
		if iter_23_1 ~= var_0_0.TaskState.Completed then
			return false
		end
	end

	return true
end

function var_0_0:IsGetTaskReward()
	for iter_24_0, iter_24_1 in pairs(self.finishedTaskInfo) do
		if iter_24_1 == var_0_0.TaskState.Completed then
			return true
		end
	end

	return false
end

function var_0_0:IsCanGetTaskReward()
	for iter_25_0, iter_25_1 in pairs(self.finishedTaskInfo) do
		if iter_25_1 == var_0_0.TaskState.CanGetReward then
			return 1
		end
	end

	return 0
end

function var_0_0.IsJumpAllStage(arg_26_0)
	return true
end

function var_0_0.GetChallengeStageCfg(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)

	for iter_27_0, iter_27_1 in ipairs(CoreVerificationClMode4Cfg.get_id_list_by_stage_type[2]) do
		if CoreVerificationClMode4Cfg[iter_27_1].activity_id == arg_27_1 then
			return CoreVerificationClMode4Cfg[iter_27_1]
		end
	end

	return nil
end

local function var_0_1(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_0 then
		return
	end

	local var_28_0 = nullable(arg_28_2, "stageID")
	local var_28_1 = nullable(arg_28_2, "teamIndex")

	for iter_28_0, iter_28_1 in ipairs(arg_28_0) do
		for iter_28_2, iter_28_3 in pairs(iter_28_1.teams) do
			if iter_28_3.heroList and (var_28_0 ~= iter_28_1.stageID or var_28_1 ~= iter_28_2) then
				for iter_28_4, iter_28_5 in ipairs(iter_28_3.heroList) do
					table.insert(arg_28_1, iter_28_5)
				end
			end
		end
	end
end

function var_0_0:PushStageLockedHero(arg_29_1, arg_29_2)
	var_0_1(self:GetChallengeStage(), arg_29_2, arg_29_1)
	var_0_1(self:GetCommonStage(), arg_29_2, arg_29_1)
end

return var_0_0
