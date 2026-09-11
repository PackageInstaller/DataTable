local CookFoodItem = class("CookFoodItem", ReduxView)

function CookFoodItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CookFoodItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CookFoodItem:InitUI()
	self:BindCfgUI()

	self.itemController = ControllerUtil.GetController(self.transform_, "state")
end

function CookFoodItem:AddUIListener()
	self:AddBtnListener(self.buttonBtn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.uid_)
		end
	end)
end

function CookFoodItem:RegistCallBack(arg_6_1)
	self.clickFunc = arg_6_1
end

function CookFoodItem:RefreshUI(arg_7_1, arg_7_2)
	self.uid_ = arg_7_1.id

	if arg_7_1.type == DormEnum.UniversalUIType.FoodName then
		if arg_7_1.id == arg_7_2 then
			self.itemController:SetSelectedState("choose")
		else
			self.itemController:SetSelectedState("unchoose")
		end

		self.nameText_.text = GetI18NText(BackHomeCanteenFoodCfg[self.uid_].name)
	elseif arg_7_1.type == DormEnum.UniversalUIType.TasteName then
		if arg_7_1.id == arg_7_2 then
			self.itemController:SetSelectedState("choose")
		else
			self.itemController:SetSelectedState("unchoose")
		end

		self.nameText_.text = GetTips(CanteenConst.FoodTaste[arg_7_1.id][1])
	end
end

function CookFoodItem:Dispose()
	CookFoodItem.super.Dispose(self)
end

return CookFoodItem
