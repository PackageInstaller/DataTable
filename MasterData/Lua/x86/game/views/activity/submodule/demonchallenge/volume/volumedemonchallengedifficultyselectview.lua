local VolumeDemonChallengeDifficultySelectView = class("VolumeDemonChallengeDifficultySelectView", DemonChallengeDifficultySelectView)

function VolumeDemonChallengeDifficultySelectView:RefreshUI()
	self:RefreshSelectedUI()
	self:RefreshDesc()

	local var_1_0 = SubDemonChallengeData:GetChallengeInfo(self.activityId_)

	if var_1_0.challengeInfo then
		if var_1_0.challengeInfo[3].challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED and var_1_0.challengeInfo[3].hurt_state == ActivityConst.DEMON_CHALLENGE_HURT_STATE.NO_HURT then
			self.completedUIControllerS_[3]:SetSelectedState("nodamag")
		end
	end
end

return VolumeDemonChallengeDifficultySelectView
