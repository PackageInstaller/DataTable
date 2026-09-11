local CanteenFoodTasteitem = class("CanteenFoodTasteitem", ReduxView)

function CanteenFoodTasteitem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CanteenFoodTasteitem:Init()
	self:InitUI()
end

function CanteenFoodTasteitem:InitUI()
	self:BindCfgUI()
end

function CanteenFoodTasteitem:RefreshUI(arg_4_1)
	self.nameText_.text = string.format("<color=#%s>%s</color>", CanteenConst.FoodTaste[arg_4_1][2], GetTips(CanteenConst.FoodTaste[arg_4_1][1]))
end

function CanteenFoodTasteitem:Dispose()
	CanteenFoodTasteitem.super.Dispose(self)
end

function CanteenFoodTasteitem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return CanteenFoodTasteitem
