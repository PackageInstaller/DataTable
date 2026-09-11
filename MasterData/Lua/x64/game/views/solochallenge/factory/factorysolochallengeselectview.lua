local FactorySoloChallengeSelectView = class("FactorySoloChallengeSelectView", (import("game.views.soloChallenge.SoloChallengeSelectView")))

function FactorySoloChallengeSelectView:UIName()
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeBattleTeamUI"
end

function FactorySoloChallengeSelectView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, FactorySoloChallengeSelectItem)
	self.goBackHandler_ = handler(self, self.OnGoBack)
end

function FactorySoloChallengeSelectView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(self.goBackHandler_)
end

function FactorySoloChallengeSelectView:OnResetData(arg_4_1, arg_4_2)
	if isSuccess(arg_4_1.result) then
		SoloChallengeData:ResetLockData(arg_4_2)
		JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
			activityID = ActivitySoloChallengeCfg[self.activityID_].main_activity_id
		})
	else
		ShowTips(arg_4_1.result)
	end
end

function FactorySoloChallengeSelectView:OnGoBack()
	JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
		activityID = ActivitySoloChallengeCfg[self.activityID_].main_activity_id
	})
	JumpTools.OpenPageByJump("soloChallengeDifficultySelect", {
		activityID = self.activityID_
	})
end

function FactorySoloChallengeSelectView:Dispose()
	self.goBackHandler_ = nil

	FactorySoloChallengeSelectView.super.Dispose(self)
end

return FactorySoloChallengeSelectView
