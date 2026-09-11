local ChooseFoodItem = class("ChooseFoodItem", ReduxView)

function ChooseFoodItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChooseFoodItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChooseFoodItem:InitUI()
	self:BindCfgUI()

	self.itemController = ControllerUtil.GetController(self.transform_, "name")
end

function ChooseFoodItem:AddUIListener()
	self:AddBtnListener(self.setupBtn_, nil, function()
		if CanteenFoodData:CheckIsSignFood(self.ID_) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CANTEEN_FOOD_REMOVE"), BackHomeCanteenFoodCfg[self.ID_].name),
				OkCallback = function()
					CanteenAction:SendSignFoodInfo(self.ID_, 0)
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		if self.changeListFun then
			if self.flag then
				self.changeListFun(self.ID_, self.transform_)
			else
				ShowTips(GetTips("DORM_CANTEEN_INGREDIENTS_NOT_ENOUGH"))
			end
		end
	end)
end

function ChooseFoodItem:RefreshUI(arg_8_1)
	if CanteenFoodData:CheckIsSignFood(arg_8_1) then
		self.itemController:SetSelectedState("sign")
	else
		self.itemController:SetSelectedState("normal")
	end

	local var_8_0 = BackHomeCanteenFoodCfg[arg_8_1]

	self.ID_ = BackHomeCanteenFoodCfg[arg_8_1].id
	self.titleText_.text = GetI18NText(var_8_0.name)
	self.priceText_.text = CanteenFoodData:GetFoodUnitCost(var_8_0.id)
	self.iconImg_.sprite = CanteenTools.GetFoodSprite(self.ID_)

	local var_8_1 = BackHomeCanteenFoodCfg[arg_8_1].ingredient_list
	local var_8_2 = ""

	self.flag = true

	if CanteenFoodData:CalculateFoodCanCookNum(arg_8_1) <= 0 then
		self.flag = false
	end

	local var_8_3 = self.flag and string.format("<color='#FFFFFF'>%s</color>", GetTips("CANTEEN_FOOD_COST")) or string.format("<color='#CBD2D9'>%s</color>", GetTips("CANTEEN_FOOD_COST"))

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_4 = ItemTools.getItemName(iter_8_1[1])
		local var_8_5 = CanteenFoodData:GetCateenIngredientNum(iter_8_1[1])
		local var_8_6 = NumberTools.RetractNumberForWindBar(iter_8_1[2])
		local var_8_7 = NumberTools.RetractNumberForWindBar(var_8_5)

		var_8_2 = var_8_5 < iter_8_1[2] and var_8_2 .. string.format(GetTips("CANTEEN_FOOD_MENU1"), var_8_4, var_8_7, var_8_6) or self.flag and var_8_2 .. string.format(GetTips("CANTEEN_FOOD_MENU2"), var_8_4, var_8_7, var_8_6) or var_8_2 .. string.format(GetTips("CANTEEN_FOOD_MENU3"), var_8_4, var_8_7, var_8_6)
	end

	var_8_2 = (SDKTools.GetIsEnglish() or SDKTools.GetIsKorea()) and string.sub(var_8_2, 1, #var_8_2 - 2) or (SDKTools.GetIsJapan() or SDKTools.GetIsTw()) and string.sub(var_8_2, 1, #var_8_2 - 1) or string.sub(var_8_2, 1, -2)
	self.materialtextText_.text = string.format(var_8_3, var_8_2)
end

function ChooseFoodItem:RegistCallBack(arg_9_1)
	self.changeListFun = arg_9_1
end

function ChooseFoodItem:RegisterLackCallBack(arg_10_1)
	self.lackBtnFunc = arg_10_1
end

function ChooseFoodItem:Dispose()
	self:RemoveAllListeners()
	ChooseFoodItem.super.Dispose(self)
end

return ChooseFoodItem
