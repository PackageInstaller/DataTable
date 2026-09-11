local PopEquipSuitView = class("PopEquipSuitView", import("game.views.sectionSelect.equip.SuitSelectView"))

function PopEquipSuitView:InitUI()
	self.super.InitUI(self)

	self.popController = self.controller:GetController("state")
end

function PopEquipSuitView:OnEnter()
	self.super.OnEnter(self)
end

function PopEquipSuitView:UpdateData()
	self.suitList_ = {}

	table.insert(self.suitList_, self.params_.suitId)
end

function PopEquipSuitView:OnExit()
	self.super.OnExit(self)
end

return PopEquipSuitView
