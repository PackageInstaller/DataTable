local var_0_0 = {}

manager.net:Bind(89025, function(arg_1_0)
	CoreVerificationChallengeMode2Data:Update(arg_1_0)
	var_0_0.UpdateRewardRedPoints()
end)

function var_0_0.SetBattleAffixs()
	local var_2_0 = CoreVerificationChallengeMode2Data:GetSelectAffixs()
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(var_2_1, iter_2_1.buff_id)
	end

	local var_2_2 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89026, {
		activity_id = var_2_2,
		buff_list = var_2_1
	}, 89027, var_0_0.OnSetBattleAffixs)
end

function var_0_0.OnSetBattleAffixs(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		-- block empty
	else
		ShowTips(arg_3_0.result)
	end
end

function var_0_0.GetReward(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(89030, {
		activity_id = arg_4_0,
		assignment_id = arg_4_1
	}, 89031, var_0_0.OnGetRewardCallback)
end

function var_0_0.OnGetRewardCallback(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		CoreVerificationChallengeMode2Data:UpdateRewardData(arg_5_1)
		CoreVerificationChallengeMode2Data:UpdateFinishTaskData(arg_5_1)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(arg_5_0.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_GET_REWARD)
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.Reset()
	local var_6_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89028, {
		activity_id = var_6_0
	}, 89029, var_0_0.OnReset)
end

function var_0_0.OnReset(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		CoreVerificationChallengeMode2Data:ResetSelectAffix()
		CoreVerificationChallengeMode2Data:ResetCommonStage()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_RESET)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.ResetCurStage(arg_8_0)
	local var_8_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89034, {
		activity_id = var_8_0,
		stage_id = arg_8_0
	}, 89035, var_0_0.OnResetCurStage)
end

function var_0_0.OnResetCurStage(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		CoreVerificationChallengeMode2Data:ResetSelectAffix()
		var_0_0.UpdateRewardRedPoints()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_9_1.stage_id)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	local var_10_0 = CoreVerificationChallengeMode2Data:IsCanGetTaskReward()

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)), var_10_0)

	local var_10_1 = CoreVerificationChallengeMode2Data:GetSeasonIsTips()
	local var_10_2 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)

	if var_10_1 and table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), var_10_2) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_10_2), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_10_2), 0)
	end
end

function var_0_0.SetSeasonIsTips()
	local var_11_0 = CoreVerificationChallengeTools.GetActivityId()

	manager.net:SendWithLoadingNew(89038, {
		activity_id = var_11_0
	}, 89039, var_0_0.OnSetSeasonIsTips)
end

function var_0_0.OnSetSeasonIsTips(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		CoreVerificationChallengeMode2Data:SetSeasonIsTips(false)
	else
		ShowTips(arg_12_0.result)
	end
end

return var_0_0
