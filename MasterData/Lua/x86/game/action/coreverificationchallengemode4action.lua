local var_0_0 = {}

manager.net:Bind(89801, function(arg_1_0)
	CoreVerificationChallengeMode4Data:Update(arg_1_0)
	var_0_0.UpdateRewardRedPoints()
end)
manager.net:Bind(89811, function(arg_2_0)
	CoreVerificationChallengeMode4Data:UpdateLastBattleScore(arg_2_0.score)
end)

function var_0_0.ResetTeam(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(89802, {
		activity_id = arg_3_0,
		stage_id = arg_3_1,
		team_index = arg_3_2
	}, 89803, var_0_0.OnResetTeamCallBack)
end

function var_0_0:OnResetTeamCallBack(arg_4_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeMode4Data:OnResetTeam(arg_4_1.stage_id, arg_4_1.team_index)
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_4_1.stage_id, arg_4_1.team_index)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ResetStage(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(89806, {
		activity_id = arg_5_0,
		stage_id = arg_5_1
	}, 89807, var_0_0.OnResetStageCallBack)
end

function var_0_0:OnResetStageCallBack(arg_6_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeMode4Data:OnResetStage(arg_6_1.stage_id)
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_6_1.stage_id)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(self.result)
	end
end

function var_0_0.ResetAll(arg_7_0)
	manager.net:SendWithLoadingNew(89806, {
		stage_id = 0,
		activity_id = arg_7_0
	}, 89807, var_0_0.OnResetAllCallBack)
end

function var_0_0:OnResetAllCallBack(arg_8_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeMode4Data:OnResetAll()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_RESET)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(self.result)
	end
end

function var_0_0.GetReward(arg_9_0, arg_9_1)
	manager.net:SendWithLoadingNew(89804, {
		activity_id = arg_9_0,
		assignment_id = arg_9_1
	}, 89805, var_0_0.OnGetRewardCallback)
end

function var_0_0:OnGetRewardCallback(arg_10_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeMode4Data:UpdateFinishTaskData(arg_10_1.assignment_id)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(self.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_GET_REWARD)
	else
		ShowTips(self.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, (CoreVerificationChallengeMode4Data:GetActivityID())), (CoreVerificationChallengeMode4Data:IsCanGetTaskReward()))
end

function var_0_0.SetSeasonIsTips()
	var_0_0.OnSetSeasonIsTips({
		result = 0
	}, {
		activity_id = CoreVerificationChallengeTools.GetActivityId()
	})
end

function var_0_0:OnSetSeasonIsTips(arg_13_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeMode4Data:SetSeasonIsTips(false)
	else
		ShowTips(self.result)
	end
end

return var_0_0
