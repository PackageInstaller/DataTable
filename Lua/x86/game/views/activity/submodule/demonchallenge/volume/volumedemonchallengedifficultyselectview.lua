local var_0_0 = class("VolumeDemonChallengeDifficultySelectView", DemonChallengeDifficultySelectView)

function var_0_0.RefreshUI(arg_1_0)
	arg_1_0:RefreshSelectedUI()
	arg_1_0:RefreshDesc()

	local var_1_0 = SubDemonChallengeData:GetChallengeInfo(arg_1_0.activityId_)

	if var_1_0.challengeInfo then
		local var_1_1 = var_1_0.challengeInfo[3].challenge_state
		local var_1_2 = var_1_0.challengeInfo[3].hurt_state

		if var_1_1 == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED and var_1_2 == ActivityConst.DEMON_CHALLENGE_HURT_STATE.NO_HURT then
			arg_1_0.completedUIControllerS_[3]:SetSelectedState("nodamag")
		end
	end
end

return var_0_0
