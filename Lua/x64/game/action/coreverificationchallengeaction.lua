local var_0_0 = {}

manager.net:Bind(89013, function(arg_1_0)
	CoreVerificationChallengeData:Update(arg_1_0)
	var_0_0.UpdateRewardRedPoints()
end)
manager.net:Bind(89021, function(arg_2_0)
	CoreVerificationChallengeData:UpdateIllustrated(arg_2_0)
end)

function var_0_0.SetBattleAffixs()
	local var_3_0 = CoreVerificationChallengeData:GetSelectAffixs()
	local var_3_1 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89014, {
		activity_id = var_3_1,
		buff_list = var_3_0
	}, 89015, var_0_0.OnSetBattleAffixs)
end

function var_0_0.OnSetBattleAffixs(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		-- block empty
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.GetReward(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(89018, {
		activity_id = arg_5_0,
		assignment_id = arg_5_1
	}, 89019, var_0_0.OnGetRewardCallback)
end

function var_0_0.OnGetRewardCallback(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		CoreVerificationChallengeData:UpdateRewardData(arg_6_1)
		CoreVerificationChallengeData:UpdateFinishTaskData(arg_6_1)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(arg_6_0.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_GET_REWARD)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.Reset()
	local var_7_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89016, {
		activity_id = var_7_0
	}, 89017, var_0_0.OnReset)
end

function var_0_0.OnReset(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		CoreVerificationChallengeData:ResetSelectAffix()
		var_0_0.UpdateRewardRedPoints()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_RESET)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(arg_8_0.result)
	end
end

function var_0_0.ResetCurStage(arg_9_0)
	local var_9_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89022, {
		activity_id = var_9_0,
		stage_id = arg_9_0
	}, 89023, var_0_0.OnResetCurStage)
end

function var_0_0.OnResetCurStage(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		CoreVerificationChallengeData:ResetSelectAffix()
		var_0_0.UpdateRewardRedPoints()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_10_1.stage_id)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(arg_10_0.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	local var_11_0 = CoreVerificationChallengeData:IsCanGetTaskReward()

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1)), var_11_0)

	local var_11_1 = CoreVerificationChallengeData:GetSeasonIsTips()
	local var_11_2 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1)

	if var_11_1 and table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), var_11_2) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_11_2), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_11_2), 0)
	end
end

function var_0_0.SetSeasonIsTips()
	local var_12_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89036, {
		activity_id = var_12_0
	}, 89037, var_0_0.OnSetSeasonIsTips)
end

function var_0_0.OnSetSeasonIsTips(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		CoreVerificationChallengeData:SetSeasonIsTips(false)
	else
		ShowTips(arg_13_0.result)
	end
end

return var_0_0
