NewBattleChallengeFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleChallengeFailedView")

local NewBattleChallengeFailedWithButtonView = class("NewBattleChallengeFailedWithButtonView", NewBattleChallengeFailedView)

function NewBattleChallengeFailedWithButtonView:AddUIListener()
	NewBattleChallengeFailedWithButtonView.super.AddUIListener(self)
	self.btnMask_.onClick:RemoveAllListeners()
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back(false, function()
			return
		end)
	end)
	self.btnController:SetSelectedState("2btn")
end

function NewBattleChallengeFailedWithButtonView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.stageID_ = self.stageData_:GetStageId()
	self.stageType_ = self.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	self:RebuildUI()
end

return NewBattleChallengeFailedWithButtonView
