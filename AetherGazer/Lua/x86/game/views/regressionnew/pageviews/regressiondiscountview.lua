local var_0_0 = class("RegressionDiscountView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnThree/RT3rd_DiscountUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.monthCardController_ = arg_3_0.monthCardController_:GetController("buyState")
	arg_3_0.passportController_ = arg_3_0.passportcontroller_:GetController("buyState")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.monthCardBuyBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 1,
			page = 3
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
		OperationRecorder.RecordButtonTouch("homepage_regression_shop_111")
		saveData("Regression", "MonthCard" .. RegressionDataNew:GetRegressionEndTime(), true)
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end)
	arg_4_0:AddBtnListener(arg_4_0.passportBuyBtn_, nil, function()
		if PassportData:IsOpen() and PassportData:IsUnlock() and RegressionDataNew:CheckIsSamePassportVsID() then
			OperationRecorder.RecordButtonTouch("homepage_regression_shop_211")
			JumpTools.OpenPageByJump("/passportMain/passportBuy")
			saveData("Regression", "Passport" .. RegressionDataNew:GetRegressionEndTime(), true)
			manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
		elseif not RegressionDataNew:CheckIsSamePassportVsID() then
			ShowTips("NEW_REGRESSION_AGREEMENT_BUY_2")
		else
			ShowTips("NEW_REGRESSION_PASSPORT_UNOPEN_TIPS")
		end
	end)
end

function var_0_0.SetData(arg_7_0)
	arg_7_0.descTxt_.text = GetTips("NEW_REGRESSION_DISCOUNT_DESC")

	arg_7_0:UpdateMonth()
	arg_7_0:UpdatePassport()

	arg_7_0.monthCardDiscountTxt_.text = GetTips("NEW_REGRESSION_MONTH_DISCOUNT_VALUE")
	arg_7_0.passportDiscountTxt_.text = GetTips("NEW_REGRESSION_PASSPORT_DISCOUNT_VALUE")
	arg_7_0.monthTitleTxt_.text = GetTips("NEW_REGRESSION_MONTH_DISCOUNT_DESC")
	arg_7_0.passportTitleTxt_.text = GetTips("NEW_REGRESSION_PASSPORT_DISCOUNT_DESC")

	arg_7_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_7_0.monthCardBuyBtn_.transform, RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG)
	manager.redPoint:bindUIandKey(arg_7_0.passportBuyBtn_.transform, RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG)
end

function var_0_0.Refresh(arg_8_0)
	arg_8_0:UpdateMonth()
	arg_8_0:UpdatePassport()
end

function var_0_0.UpdateMonth(arg_9_0)
	local var_9_0 = RegressionDataNew:GetReturnCfgData().monthly_card_discount

	if RegressionDataNew:CheckIsBuyPayID(var_9_0) then
		arg_9_0.monthCardController_:SetSelectedState("true")
	else
		arg_9_0.monthCardController_:SetSelectedState("false")
	end
end

function var_0_0.UpdatePassport(arg_10_0)
	local var_10_0 = RegressionDataNew:GetReturnCfgData().battlepass_discount[2]
	local var_10_1 = RegressionDataNew:GetReturnCfgData().battlepass_discount[3]

	if (RegressionDataNew:CheckIsBuyPayID(var_10_0) or RegressionDataNew:CheckIsBuyPayID(var_10_1)) and RegressionDataNew:CheckIsSamePassportVsID() then
		arg_10_0.passportController_:SetSelectedState("true")
	elseif not RegressionDataNew:CheckIsSamePassportVsID() then
		arg_10_0.passportController_:SetSelectedState("grey")
	else
		arg_10_0.passportController_:SetSelectedState("false")
	end
end

function var_0_0.AddTimer(arg_11_0)
	if arg_11_0.timeTimer then
		arg_11_0.timeTimer:Stop()

		arg_11_0.timeTimer = nil
	end

	local var_11_0 = RegressionDataNew:GetPassDiscountEndTimes()

	arg_11_0.monthCardRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
	arg_11_0.passportRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
	arg_11_0.timeTimer = Timer.New(function()
		arg_11_0.monthCardRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
		arg_11_0.passportRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
	end, 1, -1)

	arg_11_0.timeTimer:Start()
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.Dispose(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.monthCardBuyBtn_.transform, RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG)
	manager.redPoint:unbindUIandKey(arg_14_0.passportBuyBtn_.transform, RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG)

	if arg_14_0.timeTimer then
		arg_14_0.timeTimer:Stop()

		arg_14_0.timeTimer = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
