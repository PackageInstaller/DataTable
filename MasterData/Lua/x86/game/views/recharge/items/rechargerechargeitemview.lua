local RechargeRechargeItemView = class("RechargeRechargeItemView", (import("game.views.shop.base.ShopItemBase")))

function RechargeRechargeItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:RegistEventListener(RECHARGE_UPDATE, function(arg_2_0)
		if arg_2_0 == self.Cfg.id then
			self:UpdateView()
		end
	end)
end

function RechargeRechargeItemView:InitUI()
	self:BindCfgUI()

	self.firstController_ = ControllerUtil.GetController(self.gameObject_.transform, "first")
	self.picController_ = ControllerUtil.GetController(self.gameObject_.transform, "pic")
	self.firstChargeController_ = ControllerUtil.GetController(self.gameObject_.transform, "firstCharge")
end

function RechargeRechargeItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
			ShopTools.OpenWebRecharge()

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_recharge_id = self.Cfg.id
		})
		PayAction.RequestGSPay(self.Cfg.id, 1)
	end)
end

function RechargeRechargeItemView:SetData(arg_6_1)
	self.Cfg = arg_6_1

	self:UpdateView()
end

function RechargeRechargeItemView:UpdateView()
	local var_7_0 = CurrencyConst.GetPlatformDiamondId()

	self.addIcon_.sprite = ItemTools.getItemSprite(var_7_0)
	self.rewardIcon_.sprite = ItemTools.getItemSprite(var_7_0)

	local var_7_1 = PaymentCfg[self.Cfg.id]
	local var_7_2 = PaymentCfg[self.Cfg.id].cost / 100
	local var_7_3 = SettingData:GetCurrentLanguage()

	if var_7_3 == "fr" or var_7_3 == "de" then
		var_7_2 = string.gsub(tostring(var_7_2), "%.", ",")
	end

	self.costLabel_.text = var_7_1.currency_symbol .. var_7_2
	self.rewardValueLabel_.text = string.format(GetTips("DIAMOND_AMOUNT"), tostring(self.Cfg.charge_num))

	self.picController_:SetSelectedIndex(self.Cfg.id - 1)

	if self:IsFirstRecharge() then
		self.firstController_:SetSelectedState("true")

		self.addValueLabel_.text = self.Cfg.first_charge

		self.firstChargeController_:SetSelectedState(self.Cfg.first_charge > 0 and "true" or "false")
	else
		self.firstController_:SetSelectedState("false")

		self.addValueLabel_.text = self.Cfg.not_first_charge

		self.firstChargeController_:SetSelectedState(self.Cfg.not_first_charge > 0 and "true" or "false")
		self.firstController_:SetSelectedState(self.Cfg.not_first_charge > 0 and "reback" or "false")
	end
end

function RechargeRechargeItemView:IsFirstRecharge()
	return not RechargeData:HaveRecharged(self.Cfg.id)
end

function RechargeRechargeItemView:Dispose()
	RechargeRechargeItemView.super.Dispose(self)
end

return RechargeRechargeItemView
