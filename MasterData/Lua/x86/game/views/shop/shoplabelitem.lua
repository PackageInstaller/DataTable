local ShopLabelItem = class("ShopLabelItem", ReduxView)

function ShopLabelItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ShopLabelItem:Init()
	self:InitUI()
end

function ShopLabelItem:InitUI()
	self:BindCfgUI()
end

function ShopLabelItem:RefreshUI(arg_4_1, arg_4_2)
	if BackHomeFurniture[arg_4_1] then
		self.textText_.text = DormTools:GetFurLableDesc(arg_4_1, arg_4_2)
	end
end

function ShopLabelItem:Dispose()
	ShopLabelItem.super.Dispose(self)
end

return ShopLabelItem
