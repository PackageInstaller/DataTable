local EquipBaseView = class("EquipBaseView", ReduxView)

function EquipBaseView:Init()
	return
end

function EquipBaseView:Show(arg_2_1)
	SetActive(self.gameObject_, true)

	self.params_ = arg_2_1

	self:OnEnter()
end

function EquipBaseView:Hide()
	SetActive(self.gameObject_, false)
	self:OnExit()
end

function EquipBaseView:Dispose()
	EquipBaseView.super.Dispose(self)
end

return EquipBaseView
