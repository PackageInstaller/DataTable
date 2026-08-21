local var_0_0 = class("todayMenuItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.listFlag = false

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.setdownBtn_, nil, function()
		if BackHomeCanteenFoodCfg[arg_4_0.ID_] then
			local var_5_0 = GetI18NText(BackHomeCanteenFoodCfg[arg_4_0.ID_].name)

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTipsF("CANTEEN_FOOD_REMOVE", var_5_0),
				OkCallback = function()
					CanteenAction:SendSignFoodInfo(arg_4_0.ID_, 0)
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.shelvesbtnBtn_, nil, function()
		CanteenAction:SendSignFoodInfo(arg_4_0.ID_, 0)
	end)
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1)
	local var_9_0 = BackHomeCanteenFoodCfg[arg_9_1]

	arg_9_0.ID_ = arg_9_1
	arg_9_0.titleText_.text = GetI18NText(var_9_0.name)

	local var_9_1 = BackHomeCanteenFoodCfg[arg_9_1].ingredient_list

	arg_9_0.foodiconImg_.sprite = CanteenTools.GetFoodSprite(arg_9_0.ID_)
	arg_9_0.awardnumText_.text = CanteenFoodData:GetSignFoodInfo(arg_9_1).soldIncome or 0

	local var_9_2 = CanteenFoodData:GetSignFoodTime(arg_9_0.ID_)

	arg_9_0.timeText_.text = DormTools:SecondSwitchTime(var_9_2)

	local var_9_3 = ""
	local var_9_4 = GetTips("CANTEEN_FOOD_COST")

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_5 = ItemTools.getItemName(iter_9_1[1])
		local var_9_6 = iter_9_1[2]
		local var_9_7 = CanteenFoodData:GetCateenIngredient()[iter_9_1[1]]
		local var_9_8 = NumberTools.RetractNumberForWindBar(var_9_6)
		local var_9_9 = NumberTools.RetractNumberForWindBar(var_9_7)

		if var_9_7 < var_9_6 then
			var_9_3 = var_9_3 .. string.format(GetTips("CANTEEN_FOOD_MENU1"), var_9_5, var_9_9, var_9_8)
		else
			var_9_3 = var_9_3 .. string.format(GetTips("CANTEEN_FOOD_MENU2"), var_9_5, var_9_9, var_9_8)
		end
	end

	local var_9_10 = string.format(var_9_4, var_9_3)

	arg_9_0.materialtextText_.text = string.sub(var_9_10, 1, -2)

	local var_9_11 = CanteenFoodData:GetSignFoodInfo(arg_9_0.ID_)

	arg_9_0.soldNumText_.text = string.format("<color='#5C8B60'>%d</color>/%d", var_9_11.soldNum, var_9_11.sellNum)

	if var_9_11.sellNum == var_9_11.soldNum then
		arg_9_0.canvasGroup.alpha = GameDisplayCfg.canteen_canteen_food_item_diaphaneity.value[1]

		arg_9_0.stateController:SetSelectedState("sellout")
	else
		arg_9_0.canvasGroup.alpha = 1

		arg_9_0.stateController:SetSelectedState("normal")
	end
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.changeListFun = arg_10_1
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
