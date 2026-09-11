local PassportBuyLevelConfirmView = class("PassportBuyLevelConfirmView", ReduxView)

function PassportBuyLevelConfirmView:UIName()
	return "Widget/System/Passport/PassportBuyLevelConfirmUI"
end

function PassportBuyLevelConfirmView:UIParent()
	return manager.ui.uiPop.transform
end

function PassportBuyLevelConfirmView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportBuyLevelConfirmView:InitUI()
	self:BindCfgUI()
end

function PassportBuyLevelConfirmView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < self.params_.cost then
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
		PassportAction.BuyLevel(self.params_.num)
		self:Back()

		if self.params_.callback then
			self.params_.callback()
		end
	end)
end

function PassportBuyLevelConfirmView:UpdateBar()
	return
end

function PassportBuyLevelConfirmView:OnEnter()
	self.text_.text = string.format(GetTips("PASSPORT_LEVEL_BUY_CONTENT"), ItemTools.getItemName(GameSetting.battlepass_level_price.value[1]), self.params_.cost, self.params_.level)
end

function PassportBuyLevelConfirmView:OnExit()
	return
end

function PassportBuyLevelConfirmView:OnTop()
	self:UpdateBar()
end

function PassportBuyLevelConfirmView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	PassportBuyLevelConfirmView.super.Dispose(self)
end

return PassportBuyLevelConfirmView
