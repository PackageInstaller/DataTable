local var_0_0 = {}

manager.net:Bind(89431, function(arg_1_0)
	CoreVerificationChallengeMode3Data:Update(arg_1_0)
	var_0_0.UpdateRewardRedPoints()
end)

function var_0_0.GetReward(arg_2_0, arg_2_1)
	manager.net:SendWithLoadingNew(89434, {
		activity_id = arg_2_0,
		assignment_id = arg_2_1
	}, 89435, var_0_0.OnGetRewardCallback)
end

function var_0_0:OnGetRewardCallback(arg_3_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeMode3Data:UpdateRewardData(arg_3_1)
		CoreVerificationChallengeMode3Data:UpdateFinishTaskData(arg_3_1)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(self.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_GET_REWARD)
	else
		ShowTips(self.result)
	end
end

function var_0_0.Reset()
	manager.net:SendWithLoadingNew(89432, {
		activity_id = CoreVerificationChallengeTools.GetActivityId()
	}, 89433, var_0_0.OnReset)
end

function var_0_0:OnReset(arg_5_1)
	if isSuccess(self.result) then
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_RESET)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(self.result)
	end
end

function var_0_0.ResetCurStage(arg_6_0)
	manager.net:SendWithLoadingNew(89436, {
		activity_id = CoreVerificationChallengeTools.GetActivityId(),
		stage_id = arg_6_0
	}, 89437, var_0_0.OnResetCurStage)
end

function var_0_0:OnResetCurStage(arg_7_1)
	if isSuccess(self.result) then
		var_0_0.UpdateRewardRedPoints()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_7_1.stage_id)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(self.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3)), (CoreVerificationChallengeMode3Data:IsCanGetTaskReward()))

	local var_8_0 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3)

	if CoreVerificationChallengeMode3Data:GetSeasonIsTips() and table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), var_8_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_8_0), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_8_0), 0)
	end
end

function var_0_0.SetSeasonIsTips()
	manager.net:SendWithLoadingNew(89438, {
		activity_id = CoreVerificationChallengeTools.GetActivityId()
	}, 89439, var_0_0.OnSetSeasonIsTips)
end

function var_0_0:OnSetSeasonIsTips(arg_10_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeMode3Data:SetSeasonIsTips(false)
	else
		ShowTips(self.result)
	end
end

return var_0_0
