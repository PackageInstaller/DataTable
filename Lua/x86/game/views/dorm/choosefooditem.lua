local var_0_0 = class("ChooseFoodItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemController = ControllerUtil.GetController(arg_3_0.transform_, "name")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.setupBtn_, nil, function()
		if CanteenFoodData:CheckIsSignFood(arg_4_0.ID_) then
			local var_5_0 = BackHomeCanteenFoodCfg[arg_4_0.ID_].name

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CANTEEN_FOOD_REMOVE"), var_5_0),
				OkCallback = function()
					CanteenAction:SendSignFoodInfo(arg_4_0.ID_, 0)
				end,
				CancelCallback = function()
					return
				end
			})

			return
		end

		if arg_4_0.changeListFun then
			if arg_4_0.flag then
				arg_4_0.changeListFun(arg_4_0.ID_, arg_4_0.transform_)
			else
				ShowTips(GetTips("DORM_CANTEEN_INGREDIENTS_NOT_ENOUGH"))
			end
		end
	end)
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	if CanteenFoodData:CheckIsSignFood(arg_8_1) then
		arg_8_0.itemController:SetSelectedState("sign")
	else
		arg_8_0.itemController:SetSelectedState("normal")
	end

	local var_8_0 = BackHomeCanteenFoodCfg[arg_8_1]

	arg_8_0.ID_ = var_8_0.id
	arg_8_0.titleText_.text = GetI18NText(var_8_0.name)
	arg_8_0.priceText_.text = CanteenFoodData:GetFoodUnitCost(var_8_0.id)
	arg_8_0.iconImg_.sprite = CanteenTools.GetFoodSprite(arg_8_0.ID_)

	local var_8_1 = BackHomeCanteenFoodCfg[arg_8_1].ingredient_list
	local var_8_2 = ""

	arg_8_0.flag = true

	if CanteenFoodData:CalculateFoodCanCookNum(arg_8_1) <= 0 then
		arg_8_0.flag = false
	end

	local var_8_3

	if arg_8_0.flag then
		var_8_3 = string.format("<color='#FFFFFF'>%s</color>", GetTips("CANTEEN_FOOD_COST"))
	else
		var_8_3 = string.format("<color='#CBD2D9'>%s</color>", GetTips("CANTEEN_FOOD_COST"))
	end

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_4 = ItemTools.getItemName(iter_8_1[1])
		local var_8_5 = iter_8_1[2]
		local var_8_6 = CanteenFoodData:GetCateenIngredientNum(iter_8_1[1])
		local var_8_7 = NumberTools.RetractNumberForWindBar(var_8_5)
		local var_8_8 = NumberTools.RetractNumberForWindBar(var_8_6)

		if var_8_6 < var_8_5 then
			var_8_2 = var_8_2 .. string.format(GetTips("CANTEEN_FOOD_MENU1"), var_8_4, var_8_8, var_8_7)
		elseif arg_8_0.flag then
			var_8_2 = var_8_2 .. string.format(GetTips("CANTEEN_FOOD_MENU2"), var_8_4, var_8_8, var_8_7)
		else
			var_8_2 = var_8_2 .. string.format(GetTips("CANTEEN_FOOD_MENU3"), var_8_4, var_8_8, var_8_7)
		end
	end

	if SDKTools.GetIsEnglish() or SDKTools.GetIsKorea() then
		var_8_2 = string.sub(var_8_2, 1, #var_8_2 - 2)
	elseif SDKTools.GetIsJapan() or SDKTools.GetIsTw() then
		var_8_2 = string.sub(var_8_2, 1, #var_8_2 - 1)
	else
		var_8_2 = string.sub(var_8_2, 1, -2)
	end

	local var_8_9 = string.format(var_8_3, var_8_2)

	arg_8_0.materialtextText_.text = var_8_9
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.changeListFun = arg_9_1
end

function var_0_0.RegisterLackCallBack(arg_10_0, arg_10_1)
	arg_10_0.lackBtnFunc = arg_10_1
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
