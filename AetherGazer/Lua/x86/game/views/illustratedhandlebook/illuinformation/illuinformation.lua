local var_0_0 = class("ChessHome", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/IllustratedHandbook/IlluInformation"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	return
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:ShowDefaultBar()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
