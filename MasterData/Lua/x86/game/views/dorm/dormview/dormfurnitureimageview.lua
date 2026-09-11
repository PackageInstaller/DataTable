local DormFurnitureImageView = class("DormFurnitureImageView", ReduxView)

function DormFurnitureImageView:UIName()
	return "Widget/System/Shop/contentViews/furnitureImageView"
end

function DormFurnitureImageView:UIParent()
	return manager.ui.uiPop.transform
end

function DormFurnitureImageView:OnCtor()
	return
end

function DormFurnitureImageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormFurnitureImageView:OnEnter()
	self:RefreshUI()
end

function DormFurnitureImageView:InitUI()
	self:BindCfgUI()
end

function DormFurnitureImageView:AddUIListener()
	self:AddBtnListener(self.imageBtn_, nil, function()
		JumpTools.Back()
	end)
end

function DormFurnitureImageView:RefreshUI()
	self.shopID = self.params_.shopID
	self.imageImg_.sprite = DormTools.GetShopStyleImage(self.shopID)
end

function DormFurnitureImageView:Dispose()
	DormFurnitureImageView.super.Dispose(self)
end

return DormFurnitureImageView
