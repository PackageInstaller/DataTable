local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RechargeRechargeItemView", var_0_0)

function var_0_1.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
	arg_1_0:RegistEventListener(RECHARGE_UPDATE, function(arg_2_0)
		if arg_2_0 == arg_1_0.Cfg.id then
			arg_1_0:UpdateView()
		end
	end)
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.firstController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "first")
	arg_3_0.picController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "pic")
	arg_3_0.firstChargeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "firstCharge")
end

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
			ShopTools.OpenWebRecharge()

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_recharge_id = arg_4_0.Cfg.id
		})
		PayAction.RequestGSPay(arg_4_0.Cfg.id, 1)
	end)
end

function var_0_1.SetData(arg_6_0, arg_6_1)
	arg_6_0.Cfg = arg_6_1

	arg_6_0:UpdateView()
end

function var_0_1.UpdateView(arg_7_0)
	local var_7_0 = CurrencyConst.GetPlatformDiamondId()

	arg_7_0.addIcon_.sprite = ItemTools.getItemSprite(var_7_0)
	arg_7_0.rewardIcon_.sprite = ItemTools.getItemSprite(var_7_0)

	local var_7_1 = PaymentCfg[arg_7_0.Cfg.id]
	local var_7_2 = var_7_1.cost / 100
	local var_7_3 = SettingData:GetCurrentLanguage()

	if var_7_3 == "fr" or var_7_3 == "de" then
		var_7_2 = string.gsub(tostring(var_7_2), "%.", ",")
	end

	arg_7_0.costLabel_.text = var_7_1.currency_symbol .. var_7_2
	arg_7_0.rewardValueLabel_.text = string.format(GetTips("DIAMOND_AMOUNT"), tostring(arg_7_0.Cfg.charge_num))

	arg_7_0.picController_:SetSelectedIndex(arg_7_0.Cfg.id - 1)

	if arg_7_0:IsFirstRecharge() then
		arg_7_0.firstController_:SetSelectedState("true")

		arg_7_0.addValueLabel_.text = arg_7_0.Cfg.first_charge

		arg_7_0.firstChargeController_:SetSelectedState(arg_7_0.Cfg.first_charge > 0 and "true" or "false")
	else
		arg_7_0.firstController_:SetSelectedState("false")

		arg_7_0.addValueLabel_.text = arg_7_0.Cfg.not_first_charge

		arg_7_0.firstChargeController_:SetSelectedState(arg_7_0.Cfg.not_first_charge > 0 and "true" or "false")
		arg_7_0.firstController_:SetSelectedState(arg_7_0.Cfg.not_first_charge > 0 and "reback" or "false")
	end
end

function var_0_1.IsFirstRecharge(arg_8_0)
	return not RechargeData:HaveRecharged(arg_8_0.Cfg.id)
end

function var_0_1.Dispose(arg_9_0)
	var_0_1.super.Dispose(arg_9_0)
end

return var_0_1
