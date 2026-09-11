local SoloChallengeMainView_1_7 = class("SoloChallengeMainView_1_7", (import("game.views.soloChallenge.Factory.FactorySoloChallengeMainView")))

function SoloChallengeMainView_1_7:UIName()
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeMainUI"
end

function SoloChallengeMainView_1_7:AddListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeRewardView_1_7", {
			activityID = self.selectActivityID_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeDifficultySelectView_1_7", {
			activityID = self.selectActivityID_
		})
	end)
end

return SoloChallengeMainView_1_7
