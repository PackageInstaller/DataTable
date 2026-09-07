local IslandBaseMsgboxWindow = class("IslandBaseMsgboxWindow", import("view.base.BaseSubView"))

function IslandBaseMsgboxWindow:Ctor(arg_1_1, arg_1_2)
	self.view = arg_1_1

	IslandBaseMsgboxWindow.super.Ctor(self, arg_1_2, self.view.event, self.view.contextData)

	return
end

function IslandBaseMsgboxWindow:Show(arg_2_1)
	IslandBaseMsgboxWindow.super.Show(self)

	self.settings = arg_2_1

	self:OnShow()
	self._tf:SetAsLastSibling()

	return
end

function IslandBaseMsgboxWindow:Hide()
	self.view:HideWindow(self)
	self:OnHide()

	self.settings = nil

	return
end

function IslandBaseMsgboxWindow:OnShow()
	return
end

function IslandBaseMsgboxWindow:OnHide()
	return
end

return IslandBaseMsgboxWindow
