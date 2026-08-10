local var_0_0 = import("game.views.soloChallenge.Factory.FactorySoloChallengeMainView")
local var_0_1 = class("SoloChallengeMainView_1_7", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeMainUI"
end

function var_0_1.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_2_0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeRewardView_1_7", {
			activityID = arg_2_0.selectActivityID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_2_0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeDifficultySelectView_1_7", {
			activityID = arg_2_0.selectActivityID_
		})
	end)
end

return var_0_1
