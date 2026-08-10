local var_0_0 = class("PassportBuyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportBuyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.item68_ = {}

	for iter_4_0 = 1, 10 do
		if arg_4_0["item68_" .. iter_4_0] then
			local var_4_0 = CommonItemView.New(arg_4_0["item68_" .. iter_4_0])
			local var_4_1 = clone(ItemTemplateData)

			function var_4_1.clickFun(arg_5_0)
				ShowPopItem(POP_ITEM, {
					arg_5_0.id,
					arg_5_0.number
				})
			end

			table.insert(arg_4_0.item68_, {
				item = var_4_0,
				data = var_4_1
			})
		end
	end

	arg_4_0.item128_ = {}

	for iter_4_1 = 1, 10 do
		if arg_4_0["item128_" .. iter_4_1] then
			local var_4_2 = CommonItemView.New(arg_4_0["item128_" .. iter_4_1])
			local var_4_3 = clone(ItemTemplateData)

			function var_4_3.clickFun(arg_6_0)
				ShowPopItem(POP_ITEM, {
					arg_6_0.id,
					arg_6_0.number
				})
			end

			table.insert(arg_4_0.item128_, {
				item = var_4_2,
				data = var_4_3
			})
		end
	end

	local var_4_4 = Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path)

	arg_4_0.controller = Object.Instantiate(var_4_4, arg_4_0.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	arg_4_0.controller:SetSelectedState("PassportBuyUI")

	arg_4_0.grey = Object.Instantiate(Asset.Load("UI/Materials")).transform:Find("grey"):GetComponent("SpriteRenderer").material
	arg_4_0.leftReturnController_ = arg_4_0.leftController_:GetController("isReturn")
	arg_4_0.rightReturnController_ = arg_4_0.rightController_:GetController("isReturn")
	arg_4_0.returnController_ = arg_4_0.controller_:GetController("isReturn")
	arg_4_0.bpNewController_ = arg_4_0.controller_:GetController("isNewPBRecharge")
	arg_4_0.leftBtnStateController = arg_4_0.leftController_:GetController("state")
	arg_4_0.rightBtnStateController = arg_4_0.rightController_:GetController("state")
	arg_4_0.accuItem_ = AccumulateDiscountModule.New(arg_4_0.accumulateGo_)
end

function var_0_0.cheepButListener(arg_7_0)
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

	local var_7_0 = arg_7_0:GetPassportType()
	local var_7_1 = PassportConst.PASSPORT_ALL_PAY_ID[var_7_0][PassportConst.PASSPORT_USER_TYPE.NORMAL]
	local var_7_2 = PassportConst.PASSPORT_ALL_PAY_ID[var_7_0][PassportConst.PASSPORT_USER_TYPE.RETURN]

	if RegressionDataNew:CheckIsCanBuyPassportPayID(var_7_2[1]) then
		arg_7_0:BuyRegressPay(var_7_2[1])
	elseif arg_7_0.passportLv and arg_7_0.passportLv > 0 and var_7_0 ~= "vsn_42" then
		local var_7_3 = AccumulateSignData:GetPassportPaymentID(1)

		if var_7_3 and PaymentCfg[var_7_3] then
			PayAction.RequestGSPay(var_7_3, 1)
		else
			PayAction.RequestGSPay(var_7_1[1], 1)
		end
	else
		PayAction.RequestGSPay(var_7_1[1], 1)
	end
end

function var_0_0.expensiveBtnListener(arg_8_0)
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

	local var_8_0 = arg_8_0:GetPassportType()
	local var_8_1 = PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.NORMAL]
	local var_8_2 = PassportConst.PASSPORT_ALL_PAY_ID[var_8_0][PassportConst.PASSPORT_USER_TYPE.RETURN]

	if RegressionDataNew:CheckIsCanBuyPassportPayID(var_8_2[3]) then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			arg_8_0:BuyRegressPay(var_8_2[3])
		else
			arg_8_0:BuyRegressPay(var_8_2[2])
		end
	elseif arg_8_0.passportLv and arg_8_0.passportLv > 0 and var_8_0 ~= "vsn_42" then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			local var_8_3 = AccumulateSignData:GetPassportPaymentID(3)

			if var_8_3 and PaymentCfg[var_8_3] then
				PayAction.RequestGSPay(var_8_3, 1)
			else
				PayAction.RequestGSPay(var_8_1[3], 1)
			end
		else
			local var_8_4 = AccumulateSignData:GetPassportPaymentID(2)

			if var_8_4 and PaymentCfg[var_8_4] then
				PayAction.RequestGSPay(var_8_4, 1)
			else
				PayAction.RequestGSPay(var_8_1[2], 1)
			end
		end
	elseif PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
		PayAction.RequestGSPay(var_8_1[3], 1)
	else
		PayAction.RequestGSPay(var_8_1[2], 1)
	end
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.cheepBtn_, nil, function()
		arg_9_0:cheepButListener()
	end)
	arg_9_0:AddBtnListener(arg_9_0.expensiveBtn_, nil, function()
		arg_9_0:expensiveBtnListener()
	end)

	if arg_9_0.fundsettlementmethodBtn_ and arg_9_0.commercialBtn_ then
		arg_9_0:AddBtnListener(arg_9_0.fundsettlementmethodBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		arg_9_0:AddBtnListener(arg_9_0.commercialBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end

	if arg_9_0.checkBtn_ then
		arg_9_0:AddBtnListener(arg_9_0.checkBtn_, nil, function()
			JumpTools.OpenPageByJump("passportShow", {
				isPassPortBuy = true,
				type = 2
			})
		end)
	end

	arg_9_0:AddBtnListener(arg_9_0.viewBtn_, nil, function()
		local var_15_0 = PassportData:GetId()
		local var_15_1 = BattlePassListCfg[var_15_0]

		if var_15_1.battlepass_type >= 17 then
			JumpTools.OpenPageByJump("/weaponServant", {
				customServant = var_15_1.servant_list
			})
		end
	end)
end

function var_0_0.UpdateBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_16_0:Back()

		if PassportData:GetPayLevel() > 0 and gameContext:IsOpenRoute("passportBuyPopView") then
			arg_16_0:Back()
		end
	end)
end

function var_0_0.OnEnter(arg_18_0)
	if not arg_18_0.timer_ then
		arg_18_0.timer_ = Timer.New(function()
			arg_18_0:UpdateTimer()
		end, 1, -1)
	end

	arg_18_0.timer_:Start()

	arg_18_0.dataList1_ = BattlePassListCfg[PassportData:GetId()].display_reward_01
	arg_18_0.dataList2_ = BattlePassListCfg[PassportData:GetId()].display_reward_02

	arg_18_0:UpdateView()
	arg_18_0:UpdateTimer()
	arg_18_0:RegisterEventListeners()
	SetActive(arg_18_0.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
end

function var_0_0.RegisterEventListeners(arg_20_0)
	arg_20_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_21_0)
		arg_20_0:UpdateView()
	end)
end

function var_0_0.UpdateView(arg_22_0)
	local var_22_0 = arg_22_0:GetPassportType()
	local var_22_1 = PassportConst.PASSPORT_ALL_PAY_ID[var_22_0][PassportConst.PASSPORT_USER_TYPE.NORMAL]

	if ShopTools.IsLimitRecharge() then
		arg_22_0.image68_.material = arg_22_0.grey
		arg_22_0.image128_.material = arg_22_0.grey
	else
		arg_22_0.image68_.material = nil
		arg_22_0.image128_.material = nil
	end

	if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL then
		arg_22_0.leftBtnStateController:SetSelectedState("purchased")
		arg_22_0.rightBtnStateController:SetSelectedState("purchased")
	elseif PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
		arg_22_0.leftBtnStateController:SetSelectedState("purchased")
		arg_22_0.rightBtnStateController:SetSelectedState("normal")

		arg_22_0.priceLabel2_.text = arg_22_0:GetPriceText(var_22_1[3])
	else
		arg_22_0.leftBtnStateController:SetSelectedState("normal")
		arg_22_0.rightBtnStateController:SetSelectedState("normal")

		arg_22_0.priceLabel1_.text = arg_22_0:GetPriceText(var_22_1[1])
		arg_22_0.priceLabel2_.text = arg_22_0:GetPriceText(var_22_1[2])
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.item68_) do
		if arg_22_0.dataList1_[iter_22_0] then
			CommonTools.SetCommonData(iter_22_1.item, {
				id = arg_22_0.dataList1_[iter_22_0][1],
				number = arg_22_0.dataList1_[iter_22_0][2]
			}, iter_22_1.data)
			iter_22_1.item:Show(true)
		else
			iter_22_1.item:Show(false)
		end
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.item128_) do
		if arg_22_0.dataList2_[iter_22_2] then
			CommonTools.SetCommonData(iter_22_3.item, {
				id = arg_22_0.dataList2_[iter_22_2][1],
				number = arg_22_0.dataList2_[iter_22_2][2]
			}, iter_22_3.data)
			iter_22_3.item:Show(true)
		else
			iter_22_3.item:Show(false)
		end
	end

	local var_22_2 = PassportData:GetId()
	local var_22_3 = BattlePassListCfg[var_22_2].battlepass_type

	if var_22_3 >= 17 then
		arg_22_0.rewardTxt_.text = GetTips("BATTLEPASS_REWARD_TIPS_MAIN")
	end

	SetActive(arg_22_0.viewBtn_.gameObject, var_22_3 >= 17)
	arg_22_0:UpdateDiscountInfo()
	ActivityNewbieTools.RefreshNewBPRecharge(arg_22_0.bpNewController_)
end

function var_0_0.GetPassportType(arg_23_0)
	if PassportData:GetId() == PassportConst.VSN_42_PASSPORT_ID then
		return PassportConst.PASSPORT_ALL_TYPE.VSN_42
	end

	return PassportConst.PASSPORT_ALL_TYPE.DEFAULT
end

function var_0_0.UpdateDiscountInfo(arg_24_0)
	local var_24_0 = false
	local var_24_1 = PassportData:GetPayLevel()
	local var_24_2 = arg_24_0:GetPassportType()
	local var_24_3 = PassportConst.PASSPORT_ALL_PAY_ID[var_24_2][PassportConst.PASSPORT_USER_TYPE.NORMAL]
	local var_24_4 = PassportConst.PASSPORT_ALL_PAY_ID[var_24_2][PassportConst.PASSPORT_USER_TYPE.RETURN]

	arg_24_0.passportNum_ = 0
	arg_24_0.passportLv = 0
	arg_24_0.passportNum_, arg_24_0.passportLv = AccumulateSignData:GetPassportNumAndLv()

	if var_24_1 == PassportConst.PASSPORT_USER_LEVEL.NOT_BUY and RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[1]) then
		arg_24_0.priceLabel1_.text = arg_24_0:GetPriceText(var_24_4[1])
		arg_24_0.cheapOriginTxt_.text = arg_24_0:GetPriceText(var_24_3[1], true)
		var_24_0 = true

		arg_24_0.leftReturnController_:SetSelectedState("true")
	elseif var_24_1 == PassportConst.PASSPORT_USER_LEVEL.NOT_BUY and arg_24_0.passportLv > 0 and var_24_2 ~= "vsn_42" then
		local var_24_5 = GameSetting.battlepass_sale.value[arg_24_0.passportLv][2]

		arg_24_0.priceLabel1_.text = arg_24_0:GetPriceText(var_24_5)
		arg_24_0.cheapOriginTxt_.text = arg_24_0:GetPriceText(var_24_3[1], true)

		arg_24_0.leftReturnController_:SetSelectedState("trueWithoutTime")
	else
		arg_24_0.leftReturnController_:SetSelectedState("false")
	end

	if var_24_1 < PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL and RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[2]) then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			arg_24_0.priceLabel2_.text = arg_24_0:GetPriceText(var_24_4[3])
			arg_24_0.heavyOriginTxt_.text = arg_24_0:GetPriceText(var_24_3[3], true)
		else
			arg_24_0.priceLabel2_.text = arg_24_0:GetPriceText(var_24_4[2])
			arg_24_0.heavyOriginTxt_.text = arg_24_0:GetPriceText(var_24_3[2], true)
		end

		var_24_0 = true

		arg_24_0.rightReturnController_:SetSelectedState("true")
	elseif var_24_1 < PassportConst.PASSPORT_USER_LEVEL.FULL_LEVEL and arg_24_0.passportLv > 0 and var_24_2 ~= "vsn_42" then
		if PassportData:GetPayLevel() == PassportConst.PASSPORT_USER_LEVEL.BASE_LEVEL then
			local var_24_6 = GameSetting.battlepass_upgrade_sale.value[arg_24_0.passportLv][2]

			arg_24_0.priceLabel2_.text = arg_24_0:GetPriceText(var_24_6)
			arg_24_0.heavyOriginTxt_.text = arg_24_0:GetPriceText(var_24_3[3], true)
		else
			local var_24_7 = GameSetting.battlepass_highlevel_sale.value[arg_24_0.passportLv][2]

			arg_24_0.priceLabel2_.text = arg_24_0:GetPriceText(var_24_7)
			arg_24_0.heavyOriginTxt_.text = arg_24_0:GetPriceText(var_24_3[2], true)
		end

		arg_24_0.rightReturnController_:SetSelectedState("trueWithoutTime")
	else
		arg_24_0.rightReturnController_:SetSelectedState("false")
	end

	arg_24_0:AddRegressionTimer(var_24_0)

	if var_24_0 then
		arg_24_0.returnController_:SetSelectedState("true")
	else
		arg_24_0.returnController_:SetSelectedState("false")
	end

	local var_24_8, var_24_9 = PassportData:HasDiscount()

	if var_24_8 and var_24_9 then
		SetActive(arg_24_0.discountInfoObj_, true)

		arg_24_0.discountInfoText_.text = GetTips(var_24_9)
	else
		SetActive(arg_24_0.discountInfoObj_, false)

		arg_24_0.discountInfoText_.text = ""
	end

	if var_24_2 == "vsn_42" or RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[1]) or RegressionDataNew:CheckIsCanBuyPassportPayID(var_24_4[2]) then
		arg_24_0.accuItem_:SetData(2, false)
		arg_24_0.accuItem_:SetActive(false)

		return
	end

	local var_24_10 = 0
	local var_24_11

	_, var_24_11 = AccumulateSignData:GetPassportNumAndLv()

	if var_24_11 > 0 then
		arg_24_0.accuItem_:SetData(2, true)
		arg_24_0.accuItem_:SetActive(true)
	else
		arg_24_0.accuItem_:SetData(2, false)
		arg_24_0.accuItem_:SetActive(false)
	end
end

function var_0_0.AddRegressionTimer(arg_25_0, arg_25_1)
	if arg_25_0.regressTimer then
		arg_25_0.regressTimer:Stop()

		arg_25_0.regressTimer = nil
	end

	if not arg_25_1 then
		return
	end

	arg_25_0:UpdateRegressionTimeShow()

	arg_25_0.regressTimer = Timer.New(function()
		arg_25_0:UpdateRegressionTimeShow()
	end, 1, -1)

	arg_25_0.regressTimer:Start()
end

function var_0_0.UpdateRegressionTimeShow(arg_27_0)
	local var_27_0 = RegressionDataNew:GetPassDiscountEndTimes()
	local var_27_1 = manager.time:GetLostTimeStrWith2Unit(var_27_0)

	arg_27_0.heavyReturnTimeTxt_.text = var_27_1
	arg_27_0.cheapReturnTimeTxt_.text = var_27_1
	arg_27_0.returnTimeTxt_.text = string.format(GetTips("NEW_REGRESSION_PASSPORT_TIME"), os.date("%Y/%m/%d %H:%M", var_27_0))
end

function var_0_0.GetPriceText(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = PaymentCfg[arg_28_1].cost / 100

	if SDKTools.GetIsKorea() then
		return var_28_0 .. GetTips("CURRENCY_TEXT")
	else
		local var_28_1

		if arg_28_2 then
			var_28_1 = GetTips("NEW_REGRESSION_MONTH_PRICE_1")
		else
			var_28_1 = GetTips("PASSPORT_BUY_BUTTON_1")
		end

		return string.format(var_28_1, PaymentCfg[arg_28_1].currency_symbol, var_28_0)
	end
end

function var_0_0.BuyRegressPay(arg_29_0, arg_29_1)
	local var_29_0 = RegressionDataNew:GetPassDiscountEndTimes()
	local var_29_1 = PassportData:GetEndTimestamp() - 1200

	if RegressionDataNew:CheckIsFirstBuyPassport() and var_29_1 < var_29_0 then
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

function var_0_0.UpdateTimer(arg_32_0)
	local var_32_0 = PassportData:GetEndTimestamp() - 1200
	local var_32_1 = PassportData:GetStartTimestamp()

	arg_32_0.timeLabel_.text = manager.time:STimeDescS(var_32_1, "!%Y/%m/%d %H:%M") .. "  -  " .. manager.time:STimeDescS(var_32_0, "!%Y/%m/%d %H:%M")
end

function var_0_0.OnExit(arg_33_0)
	arg_33_0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if arg_33_0.regressTimer then
		arg_33_0.regressTimer:Stop()

		arg_33_0.regressTimer = nil
	end

	if arg_33_0.timer_ then
		arg_33_0.timer_:Stop()

		arg_33_0.timer_ = nil
	end
end

function var_0_0.OnTop(arg_34_0)
	arg_34_0:UpdateBar()
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.item68_ then
		for iter_35_0, iter_35_1 in pairs(arg_35_0.item68_) do
			iter_35_1.item:Dispose()
		end

		arg_35_0.item68_ = nil
	end

	if arg_35_0.item128_ then
		for iter_35_2, iter_35_3 in pairs(arg_35_0.item128_) do
			iter_35_3.item:Dispose()
		end

		arg_35_0.item128_ = nil
	end

	if arg_35_0.accuItem_ then
		arg_35_0.accuItem_:Dispose()

		arg_35_0.accuItem_ = nil
	end

	var_0_0.super.Dispose(arg_35_0)
end

return var_0_0
