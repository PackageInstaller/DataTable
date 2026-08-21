local var_0_0 = class("SimBusinessExplainView", ReduxView)

function var_0_0.GetTabToggleCtrl(arg_1_0, arg_1_1)
	return arg_1_0[string.format("tabltem%02dTgl_", arg_1_1)]
end

function var_0_0.UIName(arg_2_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessDetailsPopUI"
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.UIParent(arg_4_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()

	arg_5_0.pageList = {
		SimBusinessShelfInfoView.New(arg_5_0.shelfcontentGo_),
		SimBusinessGoodsInfoView.New(arg_5_0.goodscontentGo_),
		(SimBusinessClientInfoView.New(arg_5_0.guestcontentGo_))
	}
	arg_5_0.pageController = arg_5_0.controllerCom:GetController("category")
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.index = arg_7_0.params_.pageIndex or arg_7_0.index or 1
	arg_7_0:GetTabToggleCtrl(arg_7_0.index).isOn = true

	arg_7_0:SwitchPage(arg_7_0.index, true)
	arg_7_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0:GetTabToggleCtrl(1).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP)
	manager.redPoint:bindUIandKey(arg_8_0:GetTabToggleCtrl(2).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD)
end

function var_0_0.UnbindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0:GetTabToggleCtrl(1).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_SHELF_LEVEL_UP)
	manager.redPoint:unbindUIandKey(arg_9_0:GetTabToggleCtrl(2).transform, RedPointConst.ACTIVITY_SIM_BUSINESS_UNLOCK_GOOD)
end

function var_0_0.RegisterEvents(arg_10_0)
	return
end

function var_0_0.AddUIListener(arg_11_0)
	for iter_11_0 = 1, 3 do
		arg_11_0:AddToggleListener(arg_11_0:GetTabToggleCtrl(iter_11_0), function(arg_12_0)
			arg_11_0:SwitchPage(iter_11_0, false)
		end)
	end

	arg_11_0:AddBtnListener(arg_11_0.backBtn, nil, function()
		arg_11_0:Back()
	end)
end

function var_0_0.SwitchPage(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == arg_14_0.index and not arg_14_2 then
		return
	end

	if arg_14_0.index then
		arg_14_0.pageList[arg_14_0.index]:OnExit()
	end

	arg_14_0.index = arg_14_1

	arg_14_0.pageController:SetSelectedIndex(arg_14_1 - 1)
	arg_14_0.pageList[arg_14_0.index]:OnEnter()
end

function var_0_0.OnEventRefreshView(arg_15_0)
	if arg_15_0.pageList and arg_15_0.index then
		arg_15_0.pageList[arg_15_0.index]:OnEventRefreshView()
	end
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:UnbindRedPoint()
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.pageList) do
		iter_17_1:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.OnTop(arg_18_0)
	SimBusinessTools.SwitchBarWithFund({
		BACK_BAR
	}, true)
end

function var_0_0.OnBehind(arg_19_0)
	manager.windowBar:HideBar()
end

return var_0_0
