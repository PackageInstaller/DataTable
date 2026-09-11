local SimBusInessUnlockNewItem = class("SimBusInessUnlockNewItem", ReduxView)

function SimBusInessUnlockNewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusInessUnlockNewItem:Init()
	self:InitUI()

	self.showItem = SimBusinessShowItem.New(self.showItemGo_)
	self.typeContorller = self.controllers_:GetController("type")
end

function SimBusInessUnlockNewItem:InitUI()
	self:BindCfgUI()
end

function SimBusInessUnlockNewItem:RefreshView(arg_4_1, arg_4_2)
	self.id = arg_4_1

	if arg_4_2 == SimBusinessConst.ShowItmeType.shelf then
		self.name_.text = SimBusinessShelfCfg[self.id].name

		self.typeContorller:SetSelectedState("unlockShelf")
	elseif arg_4_2 == SimBusinessConst.ShowItmeType.good then
		self.name_.text = SimBusinessGoodsCfg[self.id].name

		self.typeContorller:SetSelectedState("unlockGoods")
	end

	self.showItem:RefreshView(arg_4_1, arg_4_2)
end

function SimBusInessUnlockNewItem:Dispose()
	self.showItem:Dispose()
	SimBusInessUnlockNewItem.super.Dispose(self)
end

return SimBusInessUnlockNewItem
