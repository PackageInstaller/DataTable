local var_0_0 = class("CanteenLackFoodIngredientsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamLackMaterialPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.foodID = arg_4_0.params_.foodID
	arg_4_0.ingredientsList = BackHomeCanteenFoodCfg[arg_4_0.foodID].ingredient_list

	arg_4_0.ingredientsListScroll_:StartScroll(#arg_4_0.ingredientsList)

	arg_4_0.titletextText_.text = BackHomeCanteenFoodCfg[arg_4_0.foodID].name .. GetTips("ERROR_ITEM_NO_ENOUGH_MATERIAL")
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.ingredientsListScroll_ = LuaList.New(handler(arg_5_0, arg_5_0.indexIngredientsItem), arg_5_0.ingredientslistUilist_, FoodMaterialItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgmaskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.indexIngredientsItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshItem(arg_8_0.ingredientsList[arg_8_1])
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.ingredientsListScroll_ then
		arg_9_0.ingredientsListScroll_:Dispose()

		arg_9_0.ingredientsListScroll_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
