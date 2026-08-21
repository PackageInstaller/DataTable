local var_0_0 = class("CanteenManualRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamManualModeEndPop"
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

	arg_4_0.materialItemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.refreshItem), arg_4_0.listUilist_, FoodMaterialItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		CanteenManualData:ExitManualState()
		JumpTools.OpenPageByJump("/restaurantMain")
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		CanteenManualData:ExitManualState()
		JumpTools.OpenPageByJump("/restaurantMain")
	end)
end

function var_0_0.refreshItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshItem(arg_8_0.materialList[arg_8_1], nil, nil, DormEnum.FoodSellType.SignFood)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = CanteenManualData:GetManualInfo()
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(var_10_0.manualSettlementList) do
		var_10_1 = var_10_1 + 1
	end

	arg_10_0.foodnumText_.text = var_10_1
	arg_10_0.totalcustomernumText_.text = var_10_0.manualGenCusNum
	arg_10_0.servercustomernumText_.text = var_10_0.manualSerCusNum
	arg_10_0.rewardnumText_.text = var_10_0.manualTotalIncome
	arg_10_0.maxpopnumText_.text = var_10_0.hightPopularityNum
	arg_10_0.addpopnumText_.text = CanteenManualData:CalculateRemainPopularity()

	local var_10_2
	local var_10_3
	local var_10_4, var_10_5 = CanteenManualData:MostPopFoodIdAndNum()

	arg_10_0.foodnameText_.text = GetI18NText(var_10_4)

	if var_10_5 > 0 then
		arg_10_0.foodpopnumText_.text = string.format(GetTips("CANTEEN_SELL_INFO"), var_10_5)
	end

	arg_10_0.materialList = CanteenManualData:ManualConsumeMaterial()

	arg_10_0.materialItemScroll_:StartScroll(#arg_10_0.materialList)
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.materialItemScroll_ then
		arg_11_0.materialItemScroll_:Dispose()

		arg_11_0.materialItemScroll_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
