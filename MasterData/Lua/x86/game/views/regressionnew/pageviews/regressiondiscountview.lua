local RegressionDiscountView = class("RegressionDiscountView", ReduxView)

function RegressionDiscountView:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnThree/RT3rd_DiscountUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionDiscountView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionDiscountView:InitUI()
	self:BindCfgUI()

	self.monthCardController_ = self.monthCardController_:GetController("buyState")
	self.passportController_ = self.passportcontroller_:GetController("buyState")
end

function RegressionDiscountView:AddUIListener()
	self:AddBtnListener(self.monthCardBuyBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 1,
			page = 3
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
		OperationRecorder.RecordButtonTouch("homepage_regression_shop_111")
		saveData("Regression", "MonthCard" .. RegressionDataNew:GetRegressionEndTime(), true)
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end)
	self:AddBtnListener(self.passportBuyBtn_, nil, function()
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

function RegressionDiscountView:SetData()
	self.descTxt_.text = GetTips("NEW_REGRESSION_DISCOUNT_DESC")

	self:UpdateMonth()
	self:UpdatePassport()

	self.monthCardDiscountTxt_.text = GetTips("NEW_REGRESSION_MONTH_DISCOUNT_VALUE")
	self.passportDiscountTxt_.text = GetTips("NEW_REGRESSION_PASSPORT_DISCOUNT_VALUE")
	self.monthTitleTxt_.text = GetTips("NEW_REGRESSION_MONTH_DISCOUNT_DESC")
	self.passportTitleTxt_.text = GetTips("NEW_REGRESSION_PASSPORT_DISCOUNT_DESC")

	self:AddTimer()
	manager.redPoint:bindUIandKey(self.monthCardBuyBtn_.transform, RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG)
	manager.redPoint:bindUIandKey(self.passportBuyBtn_.transform, RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG)
end

function RegressionDiscountView:Refresh()
	self:UpdateMonth()
	self:UpdatePassport()
end

function RegressionDiscountView:UpdateMonth()
	if RegressionDataNew:CheckIsBuyPayID(RegressionDataNew:GetReturnCfgData().monthly_card_discount) then
		self.monthCardController_:SetSelectedState("true")
	else
		self.monthCardController_:SetSelectedState("false")
	end
end

function RegressionDiscountView:UpdatePassport()
	if (RegressionDataNew:CheckIsBuyPayID(RegressionDataNew:GetReturnCfgData().battlepass_discount[2]) or RegressionDataNew:CheckIsBuyPayID(RegressionDataNew:GetReturnCfgData().battlepass_discount[3])) and RegressionDataNew:CheckIsSamePassportVsID() then
		self.passportController_:SetSelectedState("true")
	elseif not RegressionDataNew:CheckIsSamePassportVsID() then
		self.passportController_:SetSelectedState("grey")
	else
		self.passportController_:SetSelectedState("false")
	end
end

function RegressionDiscountView:AddTimer()
	if self.timeTimer then
		self.timeTimer:Stop()

		self.timeTimer = nil
	end

	local var_11_0 = RegressionDataNew:GetPassDiscountEndTimes()

	self.monthCardRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
	self.passportRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
	self.timeTimer = Timer.New(function()
		self.monthCardRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
		self.passportRemainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_11_0))
	end, 1, -1)

	self.timeTimer:Start()
end

function RegressionDiscountView:SetActive(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function RegressionDiscountView:Dispose()
	manager.redPoint:unbindUIandKey(self.monthCardBuyBtn_.transform, RedPointConst.NEW_REGRESSION_MONTHCARD_NEW_TAG)
	manager.redPoint:unbindUIandKey(self.passportBuyBtn_.transform, RedPointConst.NEW_REGRESSION_PASSPORT_NEW_TAG)

	if self.timeTimer then
		self.timeTimer:Stop()

		self.timeTimer = nil
	end

	RegressionDiscountView.super.Dispose(self)
end

return RegressionDiscountView
