NewBattleFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedView")

local NewBattleFailedWithButtonView = class("NewBattleFailedWithButtonView", NewBattleFailedView)

function NewBattleFailedWithButtonView:AddUIListener()
	NewBattleFailedWithButtonView.super.AddUIListener(self)
	self.btnMask_.onClick:RemoveAllListeners()
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back(false, function()
			return
		end)
	end)
	self.btnController:SetSelectedState("2btn")
end

function NewBattleFailedWithButtonView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.stageID_ = self.stageData_:GetStageId()
	self.stageType_ = self.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	self:RebuildUI()
end

return NewBattleFailedWithButtonView
