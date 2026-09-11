local RechargeMonthCardPageView = class("RechargeMonthCardPageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeMonthCardPageView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.firstRewardController_ = ControllerUtil.GetController(self.gameObject_.transform, "firstRecharge")
	self.retrunController_ = self.controller_:GetController("isReturn")

	if SDKTools.GetIsOverSea() then
		SetActive(self.rewardContainer_.gameObject, true)

		self.priceText_.text = GetTips("MONTHLY_CARD_PRICE")
		self.immeLabelText_.text = GetTips("MONTHLY_CARD_ONCE_GET_1")
		self.dailyLabelText_.text = GetTips("MONTHLY_CARD_DAILY_GET_1")
		self.immeNumText_.text = GetTips("MONTHLY_CARD_ONCE_GET_2")
		self.dailyNumText_.text = GetTips("MONTHLY_CARD_DAILY_GET_2")
	end

	self.rechargeUpdateHandler_ = handler(self, self.OnRechargeUpdate)
	self.accuItem_ = AccumulateDiscountModule.New(self.accumulateGo_)
end

function RechargeMonthCardPageView:AddUIListener()
	self:AddBtnListener(self.helpBtn_, nil, function()
		JumpTools.OpenPageByJump("rechargeMonthCardDesc")
	end)
	self:AddBtnListener(self.buyBtn_, nil, function()
		if ShopTools.IsLimitRecharge() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
			ShopTools.OpenWebRecharge()

			return
		end

		SendMessageManagerToSDK("purchase_click_montlycard")
		self:BuyMonthCard()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_monthcard = 0
		})
	end)
	self:AddBtnListener(self.pcBtn_, nil, function()
		ShowTips("PC_SHOP_TIPS2")
	end)
	self:AddBtnListener(self.rebuyBtn_, nil, function()
		if ShopTools.IsPC() then
			ShopTools.OpenWebRecharge()

			return
		end

		SendMessageManagerToSDK("purchase_click_montlycard")
		self:BuyMonthCard()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_monthcard = 1
		})
	end)

	if SDKTools.GetIsInputServer("kr") then
		self:AddBtnListener(self.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = {
					"Widget/System/Recharge/RefundPolicyKR_01"
				}
			})
		end)
	end

	if self.newbieBtn_ then
		self:AddBtnListener(self.newbieBtn_, nil, function()
			ActivityNewbieTools.ReceiveRechargeReward(2, 1, function()
				self:RefreshNewbie(true)
			end)
		end)
	end

	if self.newbieRewardBtn_ then
		self:AddBtnListener(self.newbieRewardBtn_, nil, function()
			ShowPopItem(POP_ITEM, GameSetting.newbie_first_monthly_card_cumulative.value[2])
		end)
	end

	if self.fundsettlementmethodBtn_ and self.commercialBtn_ then
		self:AddBtnListener(self.fundsettlementmethodBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		self:AddBtnListener(self.commercialBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end
end

function RechargeMonthCardPageView:BuyMonthCard()
	if not RechargeData:HaveMonthCard() then
		RechargeData:ResetSign()
	end

	if RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		PayAction.RequestGSPay(111, 1)
	else
		local var_13_0 = AccumulateSignData:GetMonthCardPaymentID()

		if var_13_0 and PaymentCfg[var_13_0] then
			PayAction.RequestGSPay(var_13_0, 1)
		else
			PayAction.RequestGSPay(101, 1)
		end
	end
end

function RechargeMonthCardPageView:OnTop()
	return
end

function RechargeMonthCardPageView:UpdateView()
	if RechargeData:HaveMonthCard() then
		self.lastDayLabel_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(RechargeData:GetMonthCardDeadTime(), true))

		if GameSetting.monthly_card_num_max.value[1] <= RechargeData:GetCardNum() then
			self.statusController_:SetSelectedState("limit")
		else
			self.statusController_:SetSelectedState("notFirst")
		end
	else
		self.statusController_:SetSelectedState("first")
	end

	if ShopTools.IsLimitRecharge() then
		if RechargeData:HaveMonthCard() then
			self.statusController_:SetSelectedState("pc")
		else
			self.statusController_:SetSelectedState("pcFirst")
		end
	end

	SetActive(self.refundGo_, not SDKTools.GetIsInputServer("kr"))
	self:UpdateRegressionDiscountShow()
	self:UpdateAccumulateDiscountShow()

	if RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		self.regressCountDownTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit((RegressionDataNew:GetPassDiscountEndTimes())))
	end
end

function RechargeMonthCardPageView:RefreshNewbie(arg_16_1)
	SetActive(self.getGo_, false)

	local var_16_0 = ActivityNewbieTools.GetFirstMonthlyCardStatus()

	if var_16_0 then
		self.progreeeText_.text = string.format("<color=#FA962E>%d</color>/%d", var_16_0.signTimes, GameSetting.newbie_first_monthly_card_cumulative.value[1])
		self.status_ = 0

		if var_16_0.signTimes == 0 and not var_16_0.isRecharged then
			self.status_ = RechargeData:HaveMonthCard() and 2 or 1
		elseif var_16_0.signTimes < GameSetting.newbie_first_monthly_card_cumulative.value[1] then
			self.status_ = 2

			SetActive(self.getGo_, false)
		elseif var_16_0.signRewardFlag == false then
			self.status_ = 3

			SetActive(self.getGo_, true)
		else
			self.status_ = 0
		end

		self.firstRewardController_:SetSelectedIndex(self.status_)
	else
		self.firstRewardController_:SetSelectedIndex(0)
	end
end

function RechargeMonthCardPageView:OnEnter()
	self:UpdateView()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateView()
		end, 1, -1)
	end

	self:RefreshNewbie(true)
	self.timer_:Start()
	SetActive(self.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(self.refundGo_, not SDKTools.GetIsKorea())
	SetActive(self.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(self.refundbtn_.gameObject, self.curPageIndex_ ~= 4 and self.curPageIndex_ ~= 6)
	end

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, self.rechargeUpdateHandler_)
end

function RechargeMonthCardPageView:UpdateRegressionDiscountShow()
	if RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		self.retrunController_:SetSelectedState("true")

		self.regressPriceText_.text = self:GetPriceText(111)
	else
		self.retrunController_:SetSelectedState("false")
	end
end

function RechargeMonthCardPageView:UpdateAccumulateDiscountShow()
	if RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		self.accuItem_:SetData(1, false)
		self.accuItem_:SetActive(false)

		return
	end

	self.monthcardLv = 0
	self.accPaymentID = 0
	self.monthCardNum_, self.monthcardLv = AccumulateSignData:GetMonthCardNumAndLv()

	if self.monthcardLv > 0 then
		self.accPaymentID = GameSetting.monthlycard_sale.value[self.monthcardLv][2]

		self.retrunController_:SetSelectedState("truewithouttime")

		self.regressPriceText_.text = self:GetPriceText(self.accPaymentID)

		self.accuItem_:SetData(1, true)
		self.accuItem_:SetActive(true)
	else
		self.accuItem_:SetData(1, false)
		self.accuItem_:SetActive(false)
	end
end

function RechargeMonthCardPageView:GetPriceText(arg_21_1)
	if SDKTools.GetIsKorea() then
		return PaymentCfg[arg_21_1].cost / 100 .. GetTips("CURRENCY_TEXT")
	else
		return string.format(GetTips("NEW_REGRESSION_MONTH_PRICE"), PaymentCfg[arg_21_1].currency_symbol, PaymentCfg[arg_21_1].cost / 100)
	end
end

function RechargeMonthCardPageView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.notify:RemoveListener(NEWBIE_RECHARGE_UPDATE, self.rechargeUpdateHandler_)
end

function RechargeMonthCardPageView:Hide()
	RechargeMonthCardPageView.super.Hide(self)
end

function RechargeMonthCardPageView:Dispose()
	self.rechargeUpdateHandler_ = nil

	if self.accuItem_ then
		self.accuItem_:Dispose()

		self.accuItem_ = nil
	end

	RechargeMonthCardPageView.super.Dispose(self)
end

function RechargeMonthCardPageView:OnRechargeUpdate(arg_25_1)
	self:RefreshNewbie(true)
end

return RechargeMonthCardPageView
