local var_0_0 = class("SimBusinessSpecialStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessSpecialSalePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.stageList = SimBusinessStageCfg.get_id_list_by_type[1]
	arg_4_0.stageItemList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.stageList) do
		arg_4_0.stageItemList[iter_4_1] = SimBusinessSpecialStageItem.New(arg_4_0["item" .. iter_4_0 .. "Go_"])

		arg_4_0.stageItemList[iter_4_1]:RegisterClickFunc(handler(arg_4_0, arg_4_0.clickStage))
	end
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgmaskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:RefreshView()
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.RefreshView(arg_10_0)
	arg_10_0:RefreshStageState()
end

function var_0_0.clickStage(arg_11_0, arg_11_1)
	SimBusinessBridge.EnterLevel(arg_11_1)
	JumpTools.Back()
end

function var_0_0.RefreshStageState(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.stageList) do
		arg_12_0.stageItemList[iter_12_1]:RefreshView(iter_12_1)
	end
end

function var_0_0.Dispose(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.stageItemList) do
		iter_13_1:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
