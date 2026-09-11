local CanteenSignFoodInfoItem = class("CanteenSignFoodInfoItem", ReduxView)

function CanteenSignFoodInfoItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)

	SetActive(self.gameObject_, true)

	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function CanteenSignFoodInfoItem:InitUI()
	self:BindCfgUI()
end

function CanteenSignFoodInfoItem:RefreshUI(arg_3_1)
	local var_3_0 = CanteenFoodData:GetSignFoodInfo(arg_3_1)

	if BackHomeCanteenFoodCfg[arg_3_1] and var_3_0 then
		self.foodName.text = GetI18NText(BackHomeCanteenFoodCfg[arg_3_1].name)
		self.soldNum.text = var_3_0.soldNum .. "/" .. var_3_0.sellNum
		self.soldIncom.text = var_3_0.soldIncome or 0
		self.foodIcon.sprite = CanteenTools.GetFoodSprite(arg_3_1)
	end
end

function CanteenSignFoodInfoItem:Dispose()
	Object.Destroy(self.gameObject_)
	CanteenSignFoodInfoItem.super.Dispose(self)
end

return CanteenSignFoodInfoItem
