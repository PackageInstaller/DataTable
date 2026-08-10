local var_0_0 = class("PopSetFoodView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamShelvesToDeterminePop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.cookMaterialItemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexFoodMaterialItem), arg_4_0.uilistUilist_, FoodMaterialItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.confirmbtnBtn_, nil, function()
		DormData:ReviseSignFood(arg_5_0.foodID, true)
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.canclebtnBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.foodID = arg_9_0.params_.foodID

	local var_9_0 = arg_9_0.foodID

	arg_9_0.titletextText_.text = string.format(GetTips("CANTEEN_FOOD_ADD"), BackHomeCanteenFoodCfg[var_9_0].name)

	arg_9_0:UpdateFoodMaterialData(var_9_0)
	arg_9_0.cookMaterialItemScroll_:StartScroll(#arg_9_0.itemList_)
end

function var_0_0.indexFoodMaterialItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RefreshItem(arg_10_0.itemList_[arg_10_1])
end

function var_0_0.UpdateFoodMaterialData(arg_11_0, arg_11_1)
	arg_11_0.itemList_ = {}

	for iter_11_0, iter_11_1 in pairs(BackHomeCanteenFoodCfg[arg_11_1].ingredient_list) do
		table.insert(arg_11_0.itemList_, iter_11_1)
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.cookMaterialItemScroll_ then
		arg_12_0.cookMaterialItemScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
