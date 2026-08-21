local var_0_0 = class("TotalRechargeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/TotalRecharge"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rechargeBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 2,
			page = 3
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	arg_6_0:AddBtnListener(arg_6_0.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.freeText_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE)
	arg_9_0.paidText_.text = ItemTools.getItemNum(CurrencyConst.GetPlatformDiamondId())
	arg_9_0.totalText_.text = CurrencyData:GetRechargeDiamond()
end

return var_0_0
