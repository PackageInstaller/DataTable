local var_0_0 = class("PassportBuyLevelConfirmView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportBuyLevelConfirmUI"
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
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < arg_5_0.params_.cost then
			JumpTools.OpenPopUp("rechargeDiamondExchange", {
				defaultNum = 0,
				getBaseNum = 1,
				useBaseNum = 1,
				useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
				getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
			}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level_buy = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
		})
		PassportAction.BuyLevel(arg_5_0.params_.num)

		local var_8_0 = arg_5_0.params_.callback

		arg_5_0:Back()

		if var_8_0 then
			var_8_0()
		end
	end)
end

function var_0_0.UpdateBar(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.text_.text = string.format(GetTips("PASSPORT_LEVEL_BUY_CONTENT"), ItemTools.getItemName(GameSetting.battlepass_level_price.value[1]), arg_10_0.params_.cost, arg_10_0.params_.level)
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.list_ then
		arg_13_0.list_:Dispose()

		arg_13_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
