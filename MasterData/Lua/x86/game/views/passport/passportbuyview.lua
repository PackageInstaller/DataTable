local PassportBuyView = class("PassportBuyView", ReduxView)

function PassportBuyView:UIName()
	return "Widget/System/Passport/PassportBuyUI"
end

function PassportBuyView:UIParent()
	return manager.ui.uiMain.transform
end

function PassportBuyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportBuyView:InitUI()
	self:BindCfgUI()

	self.item68_ = {}

	for iter_4_0 = 1, 10 do
		if self["item68_" .. iter_4_0] then
			local var_4_0 = CommonItemView.New(self["item68_" .. iter_4_0])
			local var_4_1 = clone(ItemTemplateData)

			function var_4_1:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			table.insert(self.item68_, {
				item = var_4_0,
				data = var_4_1
			})
		end
	end

	self.item128_ = {}

	for iter_4_1 = 1, 10 do
		if self["item128_" .. iter_4_1] then
			local var_4_2 = CommonItemView.New(self["item128_" .. iter_4_1])
			local var_4_3 = clone(ItemTemplateData)

			function var_4_3:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end

			table.insert(self.item128_, {
				item = var_4_2,
				data = var_4_3
			})
		end
	end

	self.controller = Object.Instantiate(Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path), self.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	self.controller:SetSelectedState("PassportBuyUI")

	self.grey = Object.Instantiate(Asset.Load("UI/Materials")).transform:Find("grey"):GetComponent("SpriteRenderer").material
	self.leftReturnController_ = self.leftController_:GetController("isReturn")
	self.rightReturnController_ = self.rightController_:GetController("isReturn")
	self.returnController_ = self.controller_:GetController("isReturn")
	self.bpNewController_ = self.controller_:GetController("isNewPBRecharge")
	self.leftBtnStateController = self.leftController_:GetController("state")
	self.rightBtnStateController = self.rightController_:GetController("state")
	self.accuItem_ = AccumulateDiscountModule.New(self.accumulateGo_)
end

function PassportBuyView:cheepButListener()
	if ShopTools.IsLimitRecharge() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	SendMessageManagerToSDK("purchase_click_montlycard")
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_bp_buy = 68
	})

	if PassportData:GetEndTimestamp() - TimeMgr.GetInstance():GetServerTime() < 1200 then
		ShowTips("NOT_ENOUGH_TIME_TO_BUY")

		return
	end

	if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
		ShowTips("BATTLEPASS_HAS_BUYED")

		return
	end

	if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		ShopTools.OpenWebRecharge()

		return
	end

	local var_7_0 = self:GetPassportType()

	if RegressionDataNew:CheckIsCanBuyPassportPayID(PassportConst.PASSPORT_ALL_PAY_ID[var_7_0][PassportConst.PASSPORT_USER_TYPE.RETURN][1]) then
		self:BuyRegressPay(PassportConst.PASSPORT_ALL_PAY_ID[var_7_0][PassportConst.PASSPORT_USER_TYPE.RETURN][1])
	elseif self.passportLv and self.passportLv > 0 and var_7_0 ~= "vsn_42" then
		local var_7_1 = AccumulateSignData:GetPassportPaymentID(1)

		if var_7_1 and PaymentCfg[var_7_1] then
			PayAction.RequestGSPay(var_7_1, 1)
		else
			PayAction.RequestGSPay(PassportConst.PASSPORT_ALL_PAY_ID[var_7_0][PassportConst.PASSPORT_USER_TYPE.NORMAL][1], 1)
		end
	else
		PayAction.RequestGSPay(PassportConst.PASSPORT_ALL_PAY_ID[var_7_0][PassportConst.PASSPORT_USER_TYPE.NORMAL][1], 1)
	end
end

function PassportBuyView:expensiveBtnListener()
	if ShopTools.IsLimitRecharge() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	SendMessageManagerToSDK("purchase_click_montlycard")

	if PassportData:GetEndTimestamp() - TimeMgr.GetInstance():GetServerTime() < 1200 then
		ShowTips("NOT_ENOUGH_TIME_TO_BUY")

		return
	end

	if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL then
		ShowTips("BATTLEPASS_HAS_BUYED")

		return
	end

	if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		ShopTools.OpenWebRecharge()

		return
	end

	local var_8_0 = self:GetPassportType()

	if RegressionDataNew:CheckIsCanBuyPassportPayID(PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.RETURN][3]) then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			self:BuyRegressPay(PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.RETURN][3])
		else
			self:BuyRegressPay(PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.RETURN][2])
		end
	elseif self.passportLv and self.passportLv > 0 and var_8_0 ~= "vsn_42" then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			local var_8_1 = AccumulateSignData:GetPassportPaymentID(3)

			if var_8_1 and PaymentCfg[var_8_1] then
				PayAction.RequestGSPay(var_8_1, 1)
			else
				PayAction.RequestGSPay(PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.NORMAL][3], 1)
			end
		else
			local var_8_2 = AccumulateSignData:GetPassportPaymentID(2)

			if var_8_2 and PaymentCfg[var_8_2] then
				PayAction.RequestGSPay(var_8_2, 1)
			else
				PayAction.RequestGSPay(PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.NORMAL][2], 1)
			end
		end
	elseif PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
		PayAction.RequestGSPay(PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.NORMAL][3], 1)
	else
		PayAction.RequestGSPay(PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.NORMAL][2], 1)
	end
end

function PassportBuyView:AddUIListener()
	self:AddBtnListener(self.cheepBtn_, nil, function()
		self:cheepButListener()
	end)
	self:AddBtnListener(self.expensiveBtn_, nil, function()
		self:expensiveBtnListener()
	end)

	if self.fundsettlementmethodBtn_ and self.commercialBtn_ then
		self:AddBtnListener(self.fundsettlementmethodBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		self:AddBtnListener(self.commercialBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end

	if self.checkBtn_ then
		self:AddBtnListener(self.checkBtn_, nil, function()
			JumpTools.OpenPageByJump("passportShow", {
				isPassPortBuy = true,
				type = 2
			})
		end)
	end

	self:AddBtnListener(self.viewBtn_, nil, function()
		local var_15_0 = BattlePassListCfg[PassportData:GetId()]

		if var_15_0.battlepass_type >= 17 then
			JumpTools.OpenPageByJump("/weaponServant", {
				customServant = var_15_0.servant_list
			})
		end
	end)
end

function PassportBuyView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()

		if PassportData:GetPayLevel() > 0 and gameContext:IsOpenRoute("passportBuyPopView") then
			self:Back()
		end
	end)
end

function PassportBuyView:OnEnter()
	self.timer_ = self.timer_ or Timer.New(function()
		self:UpdateTimer()
	end, 1, -1)

	self.timer_:Start()

	self.dataList1_ = BattlePassListCfg[PassportData:GetId()].display_reward_01
	self.dataList2_ = BattlePassListCfg[PassportData:GetId()].display_reward_02

	self:UpdateView()
	self:UpdateTimer()
	self:RegisterEventListeners()
	SetActive(self.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
end

function PassportBuyView:RegisterEventListeners()
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_21_0)
		self:UpdateView()
	end)
end

function PassportBuyView:UpdateView()
	local var_22_0 = PassportConst.PASSPORT_ALL_PAY_ID[self:GetPassportType()][PassportConst.PASSPORT_USER_TYPE.NORMAL]

	if ShopTools.IsLimitRecharge() then
		self.image68_.material = self.grey
		self.image128_.material = self.grey
	else
		self.image68_.material = nil
		self.image128_.material = nil
	end

	if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL then
		self.leftBtnStateController:SetSelectedState("purchased")
		self.rightBtnStateController:SetSelectedState("purchased")
	elseif PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
		self.leftBtnStateController:SetSelectedState("purchased")
		self.rightBtnStateController:SetSelectedState("normal")

		self.priceLabel2_.text = self:GetPriceText(var_22_0[3])
	else
		self.leftBtnStateController:SetSelectedState("normal")
		self.rightBtnStateController:SetSelectedState("normal")

		self.priceLabel1_.text = self:GetPriceText(var_22_0[1])
		self.priceLabel2_.text = self:GetPriceText(var_22_0[2])
	end

	for iter_22_0, iter_22_1 in ipairs(self.item68_) do
		if self.dataList1_[iter_22_0] then
			CommonTools.SetCommonData(iter_22_1.item, {
				id = self.dataList1_[iter_22_0][1],
				number = self.dataList1_[iter_22_0][2]
			}, iter_22_1.data)
			iter_22_1.item:Show(true)
		else
			iter_22_1.item:Show(false)
		end
	end

	for iter_22_2, iter_22_3 in ipairs(self.item128_) do
		if self.dataList2_[iter_22_2] then
			CommonTools.SetCommonData(iter_22_3.item, {
				id = self.dataList2_[iter_22_2][1],
				number = self.dataList2_[iter_22_2][2]
			}, iter_22_3.data)
			iter_22_3.item:Show(true)
		else
			iter_22_3.item:Show(false)
		end
	end

	local var_22_1 = BattlePassListCfg[PassportData:GetId()].battlepass_type

	if var_22_1 >= 17 then
		self.rewardTxt_.text = GetTips("BATTLEPASS_REWARD_TIPS_MAIN")
	end

	SetActive(self.viewBtn_.gameObject, var_22_1 >= 17)
	self:UpdateDiscountInfo()
	ActivityNewbieTools.RefreshNewBPRecharge(self.bpNewController_)
end

function PassportBuyView:GetPassportType()
	if PassportData:GetId() == PassportConst.VSN_42_PASSPORT_ID then
		return PassportConst.PASSPORT_ALL_TYPE.VSN_42
	end

	return PassportConst.PASSPORT_ALL_TYPE.DEFAULT
end

function PassportBuyView:UpdateDiscountInfo()
	local var_24_0 = false
	local var_24_1 = PassportData:GetPayLevel()
	local var_24_2 = self:GetPassportType()
	local var_24_3 = PassportConst.PASSPORT_ALL_PAY_ID[var_24_2][PassportConst.PASSPORT_USER_TYPE.NORMAL]
	local var_24_4 = PassportConst.PASSPORT_ALL_PAY_ID[var_24_2][PassportConst.PASSPORT_USER_TYPE.RETURN]

	self.passportNum_ = 0
	self.passportLv = 0
	self.passportNum_, self.passportLv = AccumulateSignData:GetPassportNumAndLv()

	if var_24_1 == PassportConst.PASSPORT_USER_LEVEL.NOT_BUY and RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[1]) then
		self.priceLabel1_.text = self:GetPriceText(var_24_4[1])
		self.cheapOriginTxt_.text = self:GetPriceText(var_24_3[1], true)
		var_24_0 = true

		self.leftReturnController_:SetSelectedState("true")
	elseif var_24_1 == PassportConst.PASSPORT_USER_LEVEL.NOT_BUY and self.passportLv > 0 and var_24_2 ~= "vsn_42" then
		self.priceLabel1_.text = self:GetPriceText(GameSetting.battlepass_sale.value[self.passportLv][2])
		self.cheapOriginTxt_.text = self:GetPriceText(var_24_3[1], true)

		self.leftReturnController_:SetSelectedState("trueWithoutTime")
	else
		self.leftReturnController_:SetSelectedState("false")
	end

	if var_24_1 < PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL and RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[2]) then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			self.priceLabel2_.text = self:GetPriceText(var_24_4[3])
			self.heavyOriginTxt_.text = self:GetPriceText(var_24_3[3], true)
		else
			self.priceLabel2_.text = self:GetPriceText(var_24_4[2])
			self.heavyOriginTxt_.text = self:GetPriceText(var_24_3[2], true)
		end

		var_24_0 = true

		self.rightReturnController_:SetSelectedState("true")
	elseif var_24_1 < PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL and self.passportLv > 0 and var_24_2 ~= "vsn_42" then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			self.priceLabel2_.text = self:GetPriceText(GameSetting.battlepass_upgrade_sale.value[self.passportLv][2])
			self.heavyOriginTxt_.text = self:GetPriceText(var_24_3[3], true)
		else
			self.priceLabel2_.text = self:GetPriceText(GameSetting.battlepass_highlevel_sale.value[self.passportLv][2])
			self.heavyOriginTxt_.text = self:GetPriceText(var_24_3[2], true)
		end

		self.rightReturnController_:SetSelectedState("trueWithoutTime")
	else
		self.rightReturnController_:SetSelectedState("false")
	end

	self:AddRegressionTimer(var_24_0)

	if var_24_0 then
		self.returnController_:SetSelectedState("true")
	else
		self.returnController_:SetSelectedState("false")
	end

	local var_24_5, var_24_6 = PassportData:HasDiscount()

	if var_24_5 and var_24_6 then
		SetActive(self.discountInfoObj_, true)

		self.discountInfoText_.text = GetTips(var_24_6)
	else
		SetActive(self.discountInfoObj_, false)

		self.discountInfoText_.text = ""
	end

	if var_24_2 == "vsn_42" or RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[1]) or RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[2]) then
		self.accuItem_:SetData(2, false)
		self.accuItem_:SetActive(false)

		return
	end

	local var_24_8

	_, var_24_8 = AccumulateSignData:GetPassportNumAndLv()

	if var_24_8 > 0 then
		self.accuItem_:SetData(2, true)
		self.accuItem_:SetActive(true)
	else
		self.accuItem_:SetData(2, false)
		self.accuItem_:SetActive(false)
	end
end

function PassportBuyView:AddRegressionTimer(arg_25_1)
	if self.regressTimer then
		self.regressTimer:Stop()

		self.regressTimer = nil
	end

	if not arg_25_1 then
		return
	end

	self:UpdateRegressionTimeShow()

	self.regressTimer = Timer.New(function()
		self:UpdateRegressionTimeShow()
	end, 1, -1)

	self.regressTimer:Start()
end

function PassportBuyView:UpdateRegressionTimeShow()
	local var_27_0 = RegressionDataNew:GetPassDiscountEndTimes()
	local var_27_1 = manager.time:GetLostTimeStrWith2Unit(var_27_0)

	self.heavyReturnTimeTxt_.text = var_27_1
	self.cheapReturnTimeTxt_.text = var_27_1
	self.returnTimeTxt_.text = string.format(GetTips("NEW_REGRESSION_PASSPORT_TIME"), os.date("%Y/%m/%d %H:%M", var_27_0))
end

function PassportBuyView:GetPriceText(arg_28_1, arg_28_2)
	local var_28_0 = PaymentCfg[arg_28_1].cost / 100

	if SDKTools.GetIsKorea() then
		return var_28_0 .. GetTips("CURRENCY_TEXT")
	else
		return string.format(arg_28_2 and GetTips("NEW_REGRESSION_MONTH_PRICE_1") or GetTips("PASSPORT_BUY_BUTTON_1"), PaymentCfg[arg_28_1].currency_symbol, var_28_0)
	end
end

function PassportBuyView:BuyRegressPay(arg_29_1)
	local var_29_0 = RegressionDataNew:GetPassDiscountEndTimes()

	if RegressionDataNew:CheckIsFirstBuyPassport() and PassportData:GetEndTimestamp() - 1200 < var_29_0 then
		ShowMessageBox({
			content = string.format(GetTips("NEW_REGRESSION_AGREEMENT_BUY"), manager.time:GetLostTimeStrWith2Unit(var_29_0)),
			OkCallback = function()
				PayAction.RequestGSPay(arg_29_1, 1)
			end,
			CancelCallback = function()
				return
			end
		})
	else
		PayAction.RequestGSPay(arg_29_1, 1)
	end
end

function PassportBuyView:UpdateTimer()
	self.timeLabel_.text = manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M") .. "  -  " .. manager.time:STimeDescS(PassportData:GetEndTimestamp() - 1200, "!%Y/%m/%d %H:%M")
end

function PassportBuyView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if self.regressTimer then
		self.regressTimer:Stop()

		self.regressTimer = nil
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PassportBuyView:OnTop()
	self:UpdateBar()
end

function PassportBuyView:Dispose()
	if self.item68_ then
		for iter_35_0, iter_35_1 in pairs(self.item68_) do
			iter_35_1.item:Dispose()
		end

		self.item68_ = nil
	end

	if self.item128_ then
		for iter_35_2, iter_35_3 in pairs(self.item128_) do
			iter_35_3.item:Dispose()
		end

		self.item128_ = nil
	end

	if self.accuItem_ then
		self.accuItem_:Dispose()

		self.accuItem_ = nil
	end

	PassportBuyView.super.Dispose(self)
end

return PassportBuyView
