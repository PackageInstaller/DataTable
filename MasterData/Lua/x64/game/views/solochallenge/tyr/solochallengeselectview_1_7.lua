local SoloChallengeSelectView_1_7 = class("SoloChallengeSelectView_1_7", (import("game.views.soloChallenge.Factory.FactorySoloChallengeSelectView")))

function SoloChallengeSelectView_1_7:UIName()
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeConfigUI"
end

function SoloChallengeSelectView_1_7:OnEnter()
	SoloChallengeSelectView_1_7.super.OnEnter(self)

	self.activityID_ = self.params_.activityID
	self.difficultyIndex_ = self.params_.difficultyIndex
	self.stageList_ = ActivitySoloChallengeCfg[self.activityID_].stage_id[self.difficultyIndex_][2]

	self:SetDefaultCustom()
end

function SoloChallengeSelectView_1_7:SetDefaultCustom()
	return
end

function SoloChallengeSelectView_1_7:OnResetData(arg_4_1, arg_4_2)
	if isSuccess(arg_4_1.result) then
		SoloChallengeData:ResetLockData(arg_4_2)
		JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
			activityID = ActivitySoloChallengeCfg[self.activityID_].main_activity_id
		})
	else
		ShowTips(arg_4_1.result)
	end
end

function SoloChallengeSelectView_1_7:OnGoBack()
	JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
		activityID = ActivitySoloChallengeCfg[self.activityID_].main_activity_id
	})
end

return SoloChallengeSelectView_1_7
