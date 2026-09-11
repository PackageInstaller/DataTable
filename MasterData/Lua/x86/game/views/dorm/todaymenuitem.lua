local todayMenuItem = class("todayMenuItem", ReduxView)

function todayMenuItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.listFlag = false

	self:Init()
end

function todayMenuItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function todayMenuItem:InitUI()
	self:BindCfgUI()
end

function todayMenuItem:AddUIListener()
	self:AddBtnListener(self.setdownBtn_, nil, function()
		if BackHomeCanteenFoodCfg[self.ID_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTipsF("CANTEEN_FOOD_REMOVE", (GetI18NText(BackHomeCanteenFoodCfg[self.ID_].name))),
				OkCallback = function()
					CanteenAction:SendSignFoodInfo(self.ID_, 0)
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
	self:AddBtnListener(self.shelvesbtnBtn_, nil, function()
		CanteenAction:SendSignFoodInfo(self.ID_, 0)
	end)
end

function todayMenuItem:RefreshUI(arg_9_1)
	self.ID_ = arg_9_1
	self.titleText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_9_1].name)
	self.foodiconImg_.sprite = CanteenTools.GetFoodSprite(self.ID_)
	self.awardnumText_.text = CanteenFoodData:GetSignFoodInfo(arg_9_1).soldIncome or 0
	self.timeText_.text = DormTools:SecondSwitchTime((CanteenFoodData:GetSignFoodTime(self.ID_)))

	local var_9_0 = ""

	for iter_9_0, iter_9_1 in ipairs(BackHomeCanteenFoodCfg[arg_9_1].ingredient_list) do
		local var_9_1 = ItemTools.getItemName(iter_9_1[1])
		local var_9_2 = CanteenFoodData:GetCateenIngredient()[iter_9_1[1]]
		local var_9_3 = NumberTools.RetractNumberForWindBar(iter_9_1[2])
		local var_9_4 = NumberTools.RetractNumberForWindBar(var_9_2)

		var_9_0 = var_9_2 < iter_9_1[2] and var_9_0 .. string.format(GetTips("CANTEEN_FOOD_MENU1"), var_9_1, var_9_4, var_9_3) or var_9_0 .. string.format(GetTips("CANTEEN_FOOD_MENU2"), var_9_1, var_9_4, var_9_3)
	end

	self.materialtextText_.text = string.sub(string.format(GetTips("CANTEEN_FOOD_COST"), var_9_0), 1, -2)

	local var_9_5 = CanteenFoodData:GetSignFoodInfo(self.ID_)

	self.soldNumText_.text = string.format("<color='#5C8B60'>%d</color>/%d", var_9_5.soldNum, var_9_5.sellNum)

	if var_9_5.sellNum == var_9_5.soldNum then
		self.canvasGroup.alpha = GameDisplayCfg.canteen_canteen_food_item_diaphaneity.value[1]

		self.stateController:SetSelectedState("sellout")
	else
		self.canvasGroup.alpha = 1

		self.stateController:SetSelectedState("normal")
	end
end

function todayMenuItem:RegistCallBack(arg_10_1)
	self.changeListFun = arg_10_1
end

function todayMenuItem:Dispose()
	self:RemoveAllListeners()
	todayMenuItem.super.Dispose(self)
end

return todayMenuItem
