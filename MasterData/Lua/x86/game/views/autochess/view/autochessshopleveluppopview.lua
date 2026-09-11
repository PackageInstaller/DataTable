local AutoChessShopLevelUpPopView = class("AutoChessShopLevelUpPopView", ReduxView)

function AutoChessShopLevelUpPopView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_UpgradeShopPopUI"
end

function AutoChessShopLevelUpPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessShopLevelUpPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessShopLevelUpPopView:InitUI()
	self:BindCfgUI()

	self.beforeGradeController_ = self.controllerEx_:GetController("beforeGrade")
	self.afterGradeController_ = self.controllerEx_:GetController("afterGrade")
end

function AutoChessShopLevelUpPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()

		if self.params_.backFunc then
			self.params_.backFunc()
		end
	end)
end

function AutoChessShopLevelUpPopView:OnEnter()
	self.lastLevel_ = self.params_.lastShopLevel
	self.nowLevel_ = self.params_.nowShopLevel

	self.beforeGradeController_:SetSelectedIndex(self.lastLevel_ - 1)
	self.afterGradeController_:SetSelectedIndex(self.nowLevel_ - 1)
end

return AutoChessShopLevelUpPopView
