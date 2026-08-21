local var_0_0 = {}

manager.net:Bind(75009, function(arg_1_0)
	CoreVerificationData:UpdateCycleInfo(arg_1_0)
	var_0_0.UpdateRewardRedPoints()
	var_0_0.UpdateChallengeRedPoints()
	manager.notify:Invoke(CORE_VERIFICATION_CYCLE_UPDATE)
end)
manager.net:Bind(75015, function(arg_2_0)
	CoreVerificationData:UpdateSuperScore(arg_2_0)
end)

function var_0_0.ResetChallenge(arg_3_0)
	local var_3_0 = {
		type = arg_3_0
	}

	manager.net:SendWithLoadingNew(75010, var_3_0, 75011, var_0_0.OnResetChallengeCallBack)
end

function var_0_0.OnResetChallengeCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		if arg_4_1.type == 0 then
			CoreVerificationData:ResetStage()
			var_0_0.UpdateRewardRedPoints()
			var_0_0.UpdateChallengeRedPoints()
			manager.notify:Invoke(CORE_VERIFICATION_CYCLE_UPDATE)
			ShowTips("CORE_VERIFICATION_RESETTIPS2")
		else
			CoreVerificationData:ResetHeroInfo()
			var_0_0.UpdateRewardRedPoints()
			var_0_0.UpdateChallengeRedPoints()
			manager.notify:Invoke(CORE_VERIFICATION_CYCLE_UPDATE)
			ShowTips("CORE_VERIFICATION_TAB_DES_6")
		end
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.GetReward(arg_5_0)
	manager.net:SendWithLoadingNew(75006, arg_5_0, 75007, var_0_0.OnGetRewardCallback)
end

function var_0_0.OnGetRewardCallback(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		CoreVerificationData:UpdateRewardData(arg_6_1)
		var_0_0.UpdateRewardRedPoints()
		getReward(mergeReward(arg_6_0.reward_list))
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_GET_REWARD)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.UpdateRewardRedPoints()
	local var_7_0 = {
		0,
		0,
		0,
		0
	}

	for iter_7_0 = 1, 4 do
		local var_7_1 = CoreVerificationData:GetRewardListByType(iter_7_0)

		for iter_7_1, iter_7_2 in ipairs(var_7_1) do
			local var_7_2, var_7_3, var_7_4, var_7_5 = CoreVerificationData:GetTaskProcess(iter_7_2)

			if var_7_4 and not var_7_5 then
				var_7_0[CoreVerificationRewardCfg[iter_7_2].reward_type] = 1
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD1, var_7_0[1])
	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD2, var_7_0[2])
	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD3, var_7_0[3])
	manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_REWARD4, var_7_0[4])
end

function var_0_0.UpdateChallengeRedPoints()
	local var_8_0 = CoreVerificationData:IsStageProcess()
	local var_8_1 = getData("CoreVerification", "click_time") or 0
	local var_8_2 = _G.gameTimer:GetNextDayFreshTime()

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CORE_VERIFICATION) then
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 0)
	elseif var_8_0 or var_8_2 > 0 and var_8_2 <= var_8_1 then
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 0)
	else
		manager.redPoint:setTip(RedPointConst.CORE_VERIFICATION_CHALLENGE, 1)
	end
end

function var_0_0.SelectSuffix(arg_9_0, arg_9_1)
	local var_9_0 = {
		affix_info = {
			id = arg_9_0,
			affix_list = arg_9_1
		}
	}

	manager.net:SendWithLoadingNew(75012, var_9_0, 75013, var_0_0.OnSelectSuffix)
end

function var_0_0.OnSelectSuffix(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		CoreVerificationData:OnSaveSuffix(arg_10_1)
	else
		ShowTips(arg_10_0.result)
	end
end

return var_0_0
