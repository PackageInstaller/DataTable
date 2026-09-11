local NeedCookFoodItem = class("NeedCookFoodItem", ReduxView)

function NeedCookFoodItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NeedCookFoodItem:Init()
	self:InitUI()

	self.itemController = ControllerUtil.GetController(self.transform_, "food")
end

function NeedCookFoodItem:InitUI()
	self:BindCfgUI()
end

function NeedCookFoodItem:RefreshUI(arg_4_1)
	if CanteenFoodData:GetSignFoodCanCookNum(arg_4_1) > 0 then
		self.itemController:SetSelectedState("on")

		self.foodtextText_.text = BackHomeCanteenFoodCfg[arg_4_1].name
	else
		self.itemController:SetSelectedState("off")

		self.foodnameText_.text = BackHomeCanteenFoodCfg[arg_4_1].name
	end
end

function NeedCookFoodItem:Dispose()
	NeedCookFoodItem.super.Dispose(self)
end

return NeedCookFoodItem
