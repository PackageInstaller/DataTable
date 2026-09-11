local CanteenPassTableFoodItem = class("CanteenPassTableFoodItem", ReduxView)

function CanteenPassTableFoodItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CanteenPassTableFoodItem:Init()
	self:InitUI()
end

function CanteenPassTableFoodItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function CanteenPassTableFoodItem:RefreshItem(arg_4_1)
	self.foodEid = arg_4_1

	local var_4_0 = CanteenAIFunction:GetEntityData(arg_4_1)

	self.foodCfgID = var_4_0.cfgID
	self.nameText_.text = string.format("<color=#%s>%s</color>", CanteenConst.FoodTaste[var_4_0.taste][2], GetTips(CanteenConst.FoodTaste[var_4_0.taste][1]))
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[self.foodCfgID].icon)
end

function CanteenPassTableFoodItem:AddUIListener()
	self:AddBtnListener(self.fooditemBtn_, nil, function()
		if self.btnCallBack then
			self.btnCallBack(self.foodEid)
		end
	end)
end

function CanteenPassTableFoodItem:RegistCallBack(arg_7_1)
	self.btnCallBack = arg_7_1
end

function CanteenPassTableFoodItem:Dispose()
	CanteenPassTableFoodItem.super.Dispose(self)
end

return CanteenPassTableFoodItem
