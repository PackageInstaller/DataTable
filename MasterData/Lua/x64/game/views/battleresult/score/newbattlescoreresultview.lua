NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local NewBattleScoreResultView = class("NewBattleScoreResultView", NewBattleSettlementView)

function NewBattleScoreResultView:OnAddListner()
	self:AddBtnListener(self.nextStageBtn_, nil, function()
		self:ConfirmFunc()
	end)
	SetActive(self.costImage_.gameObject, false)

	self.confirmBtnTxt_.text = GetTips("CHALLENGE_ONCE_MORE")
end

function NewBattleScoreResultView:ShowContent()
	self:onRenderChallengeContent()
end

function NewBattleScoreResultView:onRenderChallengeContent()
	self.chanllengeView = self.chanllengeView or BattleSettlementChallengeModule.New(self.contentContainer_)

	self.chanllengeView:RenderView({
		score = self.params_.score,
		stageType = self.stageType,
		stageData = self.stageData,
		scoreTitle = (self.params_.title and self.params_.title ~= "" or nil) and GetI18NText(self.params_.title)
	})
end

function NewBattleScoreResultView:ConfirmFunc()
	if self.params_.condition then
		local var_5_0, var_5_1 = self.params_.condition()

		if var_5_0 then
			BattleController.GetInstance():LaunchBattle(self.params_.stageData)
		else
			ShowTips(var_5_1)
		end
	else
		BattleController.GetInstance():LaunchBattle(self.params_.stageData)
	end
end

function NewBattleScoreResultView:OnTop()
	NewBattleScoreResultView.super.OnTop(self)

	if self.chanllengeView then
		self.chanllengeView:OnTop()
	end
end

function NewBattleScoreResultView:NeedOnceMore()
	if self.params_.notOnceMore or self.params_.noOnceMore then
		return false
	end

	return true
end

function NewBattleScoreResultView:Dispose()
	self.chanllengeView:Dispose()
	NewBattleScoreResultView.super.Dispose(self)
end

return NewBattleScoreResultView
