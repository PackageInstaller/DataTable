local ChessBagKeyItem = class("ChessBagKeyItem", ReduxView)

function ChessBagKeyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBagKeyItem:Init()
	self:InitUI()

	self.emptyController_ = self.controllerExCollection_:GetController("empty")
	self.typeController_ = self.controllerExCollection_:GetController("type")
	self.bottomAmountController_ = self.controllerExCollection_:GetController("textcom")
end

function ChessBagKeyItem:InitUI()
	self:BindCfgUI()
end

function ChessBagKeyItem:RefreshUI(arg_4_1)
	self.info_ = arg_4_1

	self.emptyController_:SetSelectedState("off")
	self.typeController_:SetSelectedState("material")
	self.bottomAmountController_:SetSelectedState("on")

	self.iconImage_.sprite = pureGetSpriteWithoutAtlas(self.info_.iconPath)
	self.bottomAmountText_.text = self.info_.number

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.bottomAmountText_.transform)
end

function ChessBagKeyItem:Dispose()
	ChessBagKeyItem.super.Dispose(self)
end

return ChessBagKeyItem
