local var_0_0 = import("game.views.regression.pages.RegressionSignPage")
local var_0_1 = class("RegressionSignNewPage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnTwo/RT2stSignInUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.list = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.m_list, RegressionSignItem)
	arg_2_0.descText_.text = GetTips("REGRESSION_SIGN_DESCRIPE")
end

function var_0_1.UpdateBar(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

return var_0_1
