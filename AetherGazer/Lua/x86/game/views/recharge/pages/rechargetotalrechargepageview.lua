local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeTotalRechargePageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.list_ = LuaList.New(handler(arg_1_0, arg_1_0.indexItem), arg_1_0.listGo_, RechargeTotalRechargeItem)
end

function var_0_1.indexItem(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_1.AddUIListener(arg_3_0)
	return
end

function var_0_1.OnTop(arg_4_0)
	return
end

function var_0_1.OnEnter(arg_5_0)
	return
end

function var_0_1.OnExit(arg_6_0)
	return
end

function var_0_1.Hide(arg_7_0)
	var_0_1.super.Hide(arg_7_0)
end

function var_0_1.Dispose(arg_8_0)
	if arg_8_0.list_ then
		arg_8_0.list_:Dispose()

		arg_8_0.list_ = nil
	end

	var_0_1.super.Dispose(arg_8_0)
end

return var_0_1
