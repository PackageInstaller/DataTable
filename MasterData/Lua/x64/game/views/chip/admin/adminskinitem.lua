local AdminSkinItem = class("AdminSkinItem", ReduxView)

function AdminSkinItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.skinID = arg_1_2

	self:Init()
end

function AdminSkinItem:Init()
	self:InitUI()
end

function AdminSkinItem:InitUI()
	self:BindCfgUI()

	self.selController = self.controllerEx_:GetController("Select")
	self.skinController = self.controllerEx_:GetController("skin")
	self.skinCurController = self.controllerEx_:GetController("SelectCurrent")
end

function AdminSkinItem:Refresh(arg_4_1)
	self.selController:SetSelectedIndex(arg_4_1 and 1 or 0)
	self.skinCurController:SetSelectedIndex(AdminSystemTools.HeroUsingSkinInfo(1001) == self.skinID and 1 or 0)
end

function AdminSkinItem:Dispose()
	AdminSkinItem.super.Dispose(self)
end

return AdminSkinItem
