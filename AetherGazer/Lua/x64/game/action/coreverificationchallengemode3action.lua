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

function var_0_0.OnGetRewardCallback(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		CoreVerificationChallengeMode3Data:UpdateRewardData(arg_3_1)
		CoreVerificationChallengeMode3Data:UpdateFinishTaskData(arg_3_1)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(arg_3_0.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_GET_REWARD)
	else
		ShowTips(arg_3_0.result)
	end
end

function var_0_0.Reset()
	local var_4_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89432, {
		activity_id = var_4_0
	}, 89433, var_0_0.OnReset)
end

function var_0_0.OnReset(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_RESET)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.ResetCurStage(arg_6_0)
	local var_6_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89436, {
		activity_id = var_6_0,
		stage_id = arg_6_0
	}, 89437, var_0_0.OnResetCurStage)
end

function var_0_0.OnResetCurStage(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		var_0_0.UpdateRewardRedPoints()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_7_1.stage_id)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	local var_8_0 = CoreVerificationChallengeMode3Data:IsCanGetTaskReward()

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3)), var_8_0)

	local var_8_1 = CoreVerificationChallengeMode3Data:GetSeasonIsTips()
	local var_8_2 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE3)

	if var_8_1 and table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), var_8_2) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_8_2), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_8_2), 0)
	end
end

function var_0_0.SetSeasonIsTips()
	local var_9_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89438, {
		activity_id = var_9_0
	}, 89439, var_0_0.OnSetSeasonIsTips)
end

function var_0_0.OnSetSeasonIsTips(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		CoreVerificationChallengeMode3Data:SetSeasonIsTips(false)
	else
		ShowTips(arg_10_0.result)
	end
end

return var_0_0
