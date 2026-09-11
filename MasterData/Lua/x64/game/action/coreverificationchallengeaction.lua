local var_0_0 = {}

manager.net:Bind(89013, function(arg_1_0)
	CoreVerificationChallengeData:Update(arg_1_0)
	var_0_0.UpdateRewardRedPoints()
end)
manager.net:Bind(89021, function(arg_2_0)
	CoreVerificationChallengeData:UpdateIllustrated(arg_2_0)
end)

function var_0_0.SetBattleAffixs()
	manager.net:SendWithLoadingNew(89014, {
		activity_id = CoreVerificationChallengeTools.GetActivityId(),
		buff_list = CoreVerificationChallengeData:GetSelectAffixs()
	}, 89015, var_0_0.OnSetBattleAffixs)
end

function var_0_0:OnSetBattleAffixs(arg_4_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.GetReward(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(89018, {
		activity_id = arg_5_0,
		assignment_id = arg_5_1
	}, 89019, var_0_0.OnGetRewardCallback)
end

function var_0_0:OnGetRewardCallback(arg_6_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeData:UpdateRewardData(arg_6_1)
		CoreVerificationChallengeData:UpdateFinishTaskData(arg_6_1)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(self.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_GET_REWARD)
	else
		ShowTips(self.result)
	end
end

function var_0_0.Reset()
	manager.net:SendWithLoadingNew(89016, {
		activity_id = CoreVerificationChallengeTools.GetActivityId()
	}, 89017, var_0_0.OnReset)
end

function var_0_0:OnReset(arg_8_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeData:ResetSelectAffix()
		var_0_0.UpdateRewardRedPoints()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_RESET)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(self.result)
	end
end

function var_0_0.ResetCurStage(arg_9_0)
	manager.net:SendWithLoadingNew(89022, {
		activity_id = CoreVerificationChallengeTools.GetActivityId(),
		stage_id = arg_9_0
	}, 89023, var_0_0.OnResetCurStage)
end

function var_0_0:OnResetCurStage(arg_10_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeData:ResetSelectAffix()
		var_0_0.UpdateRewardRedPoints()
		manager.notify:Invoke(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_10_1.stage_id)
		ShowTips("CORE_VERIFICATION_RESETTIPS2")
	else
		ShowTips(self.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1)), (CoreVerificationChallengeData:IsCanGetTaskReward()))

	local var_11_0 = CoreVerificationChallengeTools.GetModeActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE1)

	if CoreVerificationChallengeData:GetSeasonIsTips() and table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), var_11_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_11_0), 1)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_11_0), 0)
	end
end

function var_0_0.SetSeasonIsTips()
	manager.net:SendWithLoadingNew(89036, {
		activity_id = CoreVerificationChallengeTools.GetActivityId()
	}, 89037, var_0_0.OnSetSeasonIsTips)
end

function var_0_0:OnSetSeasonIsTips(arg_13_1)
	if isSuccess(self.result) then
		CoreVerificationChallengeData:SetSeasonIsTips(false)
	else
		ShowTips(self.result)
	end
end

return var_0_0
