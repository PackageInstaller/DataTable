local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeMonthCardPageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.firstRewardController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "firstRecharge")
	arg_1_0.retrunController_ = arg_1_0.controller_:GetController("isReturn")

	if SDKTools.GetIsOverSea() then
		SetActive(arg_1_0.rewardContainer_.gameObject, true)

		arg_1_0.priceText_.text = GetTips("MONTHLY_CARD_PRICE")
		arg_1_0.immeLabelText_.text = GetTips("MONTHLY_CARD_ONCE_GET_1")
		arg_1_0.dailyLabelText_.text = GetTips("MONTHLY_CARD_DAILY_GET_1")
		arg_1_0.immeNumText_.text = GetTips("MONTHLY_CARD_ONCE_GET_2")
		arg_1_0.dailyNumText_.text = GetTips("MONTHLY_CARD_DAILY_GET_2")
	end

	arg_1_0.rechargeUpdateHandler_ = handler(arg_1_0, arg_1_0.OnRechargeUpdate)
	arg_1_0.accuItem_ = AccumulateDiscountModule.New(arg_1_0.accumulateGo_)
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.helpBtn_, nil, function()
		JumpTools.OpenPageByJump("rechargeMonthCardDesc")
	end)
	arg_2_0:AddBtnListener(arg_2_0.buyBtn_, nil, function()
		if ShopTools.IsLimitRecharge() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
			ShopTools.OpenWebRecharge()

			return
		end

		SendMessageManagerToSDK("purchase_click_montlycard")
		arg_2_0:BuyMonthCard()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_monthcard = 0
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.pcBtn_, nil, function()
		ShowTips("PC_SHOP_TIPS2")
	end)
	arg_2_0:AddBtnListener(arg_2_0.rebuyBtn_, nil, function()
		if ShopTools.IsPC() then
			ShopTools.OpenWebRecharge()

			return
		end

		SendMessageManagerToSDK("purchase_click_montlycard")
		arg_2_0:BuyMonthCard()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_monthcard = 1
		})
	end)

	if SDKTools.GetIsInputServer("kr") then
		arg_2_0:AddBtnListener(arg_2_0.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = {
					"Widget/System/Recharge/RefundPolicyKR_01"
				}
			})
		end)
	end

	if arg_2_0.newbieBtn_ then
		arg_2_0:AddBtnListener(arg_2_0.newbieBtn_, nil, function()
			ActivityNewbieTools.ReceiveRechargeReward(2, 1, function()
				arg_2_0:RefreshNewbie(true)
			end)
		end)
	end

	if arg_2_0.newbieRewardBtn_ then
		arg_2_0:AddBtnListener(arg_2_0.newbieRewardBtn_, nil, function()
			local var_10_0 = GameSetting.newbie_first_monthly_card_cumulative.value

			ShowPopItem(POP_ITEM, var_10_0[2])
		end)
	end

	if arg_2_0.fundsettlementmethodBtn_ and arg_2_0.commercialBtn_ then
		arg_2_0:AddBtnListener(arg_2_0.fundsettlementmethodBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		arg_2_0:AddBtnListener(arg_2_0.commercialBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end
end

function var_0_1.BuyMonthCard(arg_13_0)
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

function var_0_1.OnTop(arg_14_0)
	return
end

function var_0_1.UpdateView(arg_15_0)
	local var_15_0 = GameSetting.monthly_card_num_max.value[1]

	if RechargeData:HaveMonthCard() then
		local var_15_1 = RechargeData:GetCardNum()

		arg_15_0.lastDayLabel_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(RechargeData:GetMonthCardDeadTime(), true))

		if var_15_0 <= var_15_1 then
			arg_15_0.statusController_:SetSelectedState("limit")
		else
			arg_15_0.statusController_:SetSelectedState("notFirst")
		end
	else
		arg_15_0.statusController_:SetSelectedState("first")
	end

	if ShopTools.IsLimitRecharge() then
		if RechargeData:HaveMonthCard() then
			arg_15_0.statusController_:SetSelectedState("pc")
		else
			arg_15_0.statusController_:SetSelectedState("pcFirst")
		end
	end

	SetActive(arg_15_0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	arg_15_0:UpdateRegressionDiscountShow()
	arg_15_0:UpdateAccumulateDiscountShow()

	if RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		local var_15_2 = RegressionDataNew:GetPassDiscountEndTimes()

		arg_15_0.regressCountDownTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_15_2))
	end
end

function var_0_1.RefreshNewbie(arg_16_0, arg_16_1)
	SetActive(arg_16_0.getGo_, false)

	local var_16_0 = ActivityNewbieTools.GetFirstMonthlyCardStatus()

	if var_16_0 then
		local var_16_1 = var_16_0.isRecharged
		local var_16_2 = var_16_0.signTimes
		local var_16_3 = GameSetting.newbie_first_monthly_card_cumulative.value[1]

		arg_16_0.progreeeText_.text = string.format("<color=#FA962E>%d</color>/%d", var_16_2, var_16_3)
		arg_16_0.status_ = 0

		if var_16_2 == 0 and not var_16_1 then
			if RechargeData:HaveMonthCard() then
				arg_16_0.status_ = 2
			else
				arg_16_0.status_ = 1
			end
		elseif var_16_2 < var_16_3 then
			arg_16_0.status_ = 2

			SetActive(arg_16_0.getGo_, false)
		elseif var_16_0.signRewardFlag == false then
			arg_16_0.status_ = 3

			SetActive(arg_16_0.getGo_, true)
		else
			arg_16_0.status_ = 0
		end

		arg_16_0.firstRewardController_:SetSelectedIndex(arg_16_0.status_)
	else
		arg_16_0.firstRewardController_:SetSelectedIndex(0)
	end
end

function var_0_1.OnEnter(arg_17_0)
	arg_17_0:UpdateView()

	if arg_17_0.timer_ == nil then
		arg_17_0.timer_ = Timer.New(function()
			arg_17_0:UpdateView()
		end, 1, -1)
	end

	arg_17_0:RefreshNewbie(true)
	arg_17_0.timer_:Start()
	SetActive(arg_17_0.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(arg_17_0.refundGo_, not SDKTools.GetIsKorea())
	SetActive(arg_17_0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(arg_17_0.refundbtn_.gameObject, arg_17_0.curPageIndex_ ~= 4 and arg_17_0.curPageIndex_ ~= 6)
	end

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, arg_17_0.rechargeUpdateHandler_)
end

function var_0_1.UpdateRegressionDiscountShow(arg_19_0)
	if RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		arg_19_0.retrunController_:SetSelectedState("true")

		arg_19_0.regressPriceText_.text = arg_19_0:GetPriceText(111)
	else
		arg_19_0.retrunController_:SetSelectedState("false")
	end
end

function var_0_1.UpdateAccumulateDiscountShow(arg_20_0)
	if RegressionDataNew:CheckIsCanBuyRuturnDiscount(111) then
		arg_20_0.accuItem_:SetData(1, false)
		arg_20_0.accuItem_:SetActive(false)

		return
	end

	arg_20_0.monthcardLv = 0
	arg_20_0.accPaymentID = 0
	arg_20_0.monthCardNum_, arg_20_0.monthcardLv = AccumulateSignData:GetMonthCardNumAndLv()

	if arg_20_0.monthcardLv > 0 then
		arg_20_0.accPaymentID = GameSetting.monthlycard_sale.value[arg_20_0.monthcardLv][2]

		arg_20_0.retrunController_:SetSelectedState("truewithouttime")

		arg_20_0.regressPriceText_.text = arg_20_0:GetPriceText(arg_20_0.accPaymentID)

		arg_20_0.accuItem_:SetData(1, true)
		arg_20_0.accuItem_:SetActive(true)
	else
		arg_20_0.accuItem_:SetData(1, false)
		arg_20_0.accuItem_:SetActive(false)
	end
end

function var_0_1.GetPriceText(arg_21_0, arg_21_1)
	local var_21_0 = PaymentCfg[arg_21_1].cost / 100

	if SDKTools.GetIsKorea() then
		return var_21_0 .. GetTips("CURRENCY_TEXT")
	else
		return string.format(GetTips("NEW_REGRESSION_MONTH_PRICE"), PaymentCfg[arg_21_1].currency_symbol, var_21_0)
	end
end

function var_0_1.OnExit(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end

	manager.notify:RemoveListener(NEWBIE_RECHARGE_UPDATE, arg_22_0.rechargeUpdateHandler_)
end

function var_0_1.Hide(arg_23_0)
	var_0_1.super.Hide(arg_23_0)
end

function var_0_1.Dispose(arg_24_0)
	arg_24_0.rechargeUpdateHandler_ = nil

	if arg_24_0.accuItem_ then
		arg_24_0.accuItem_:Dispose()

		arg_24_0.accuItem_ = nil
	end

	var_0_1.super.Dispose(arg_24_0)
end

function var_0_1.OnRechargeUpdate(arg_25_0, arg_25_1)
	arg_25_0:RefreshNewbie(true)
end

return var_0_1
