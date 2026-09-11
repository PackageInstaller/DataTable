local ShopTreeItem = class("ShopTreeItem", ReduxView)

function ShopTreeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function ShopTreeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShopTreeItem:InitUI()
	self:BindCfgUI()
end

function ShopTreeItem:AddUIListener()
	return
end

function ShopTreeItem:SetShopId(arg_5_1)
	self.shopId_ = arg_5_1
	self.shopListCfg_ = ShopListCfg[arg_5_1]

	self:UpdateView()
end

function ShopTreeItem:UpdateView()
	self.nameText_.text = self.shopListCfg_.remark
end

function ShopTreeItem:OnEnter()
	return
end

function ShopTreeItem:OnExit()
	return
end

function ShopTreeItem:GetToggle()
	return self.toggle_
end

function ShopTreeItem:Dispose()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)
	ShopTreeItem.super.Dispose(self)
end

return ShopTreeItem
