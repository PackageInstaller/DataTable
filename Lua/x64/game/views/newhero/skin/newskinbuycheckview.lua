local var_0_0 = class("NewSkinBuyCheckView", ReduxView)
local var_0_1 = {
	OnlySkin = 1,
	OnlyDlc = 2,
	SpecialShow = 3,
	FakeData = 5,
	BuyDlcAndSkin = 4
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeSkinPopUI"
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

	arg_4_0.dlcselController = arg_4_0.controller_:GetController("dlcsel")
	arg_4_0.dlcbtnController = arg_4_0.controller_:GetController("dlcbtn")
	arg_4_0.dlcbgController = arg_4_0.controller_:GetController("dlcbg")
	arg_4_0.dlcIconController = arg_4_0.controller_:GetController("dlcIcon")
	arg_4_0.discountController = arg_4_0.controller_:GetController("discount")
	arg_4_0.skinDiscountController = arg_4_0.controller_:GetController("skinEvent")
	arg_4_0.multiTabController = arg_4_0.controller_:GetController("multiTab")
	arg_4_0.multiPayController = arg_4_0.controller_:GetController("multiPay")
	arg_4_0.multiSelectTabController = arg_4_0.skinTabController_:GetController("tab")
	arg_4_0.oathDrawStateController = arg_4_0.controller_:GetController("oathDraw")
	arg_4_0.giveBackItem2 = CommonItemView.New(arg_4_0.giveBackGo2_, true)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.calcelBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.jumpBtn_, nil, function()
		local var_8_0 = getShopCfg(arg_5_0.dlcID)

		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(arg_5_0.itemDlcCfg.id)),
			OkCallback = function()
				JumpTools.GoToSystem("/shop", {
					shopId = var_8_0.shop_id,
					goodId = arg_5_0.dlcID
				}, ViewConst.SYSTEM_ID.SHOP)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		local var_10_0, var_10_1, var_10_2 = ShopTools.GetPrice(arg_5_0.goodID)
		local var_10_3 = var_10_0
		local var_10_4 = 0

		if arg_5_0.dlcID and arg_5_0.dlcID ~= 0 then
			local var_10_5, var_10_6, var_10_7, var_10_8, var_10_9 = ShopTools.GetPrice(arg_5_0.dlcID)

			if arg_5_0.selectCurrencyIndex == 2 then
				var_10_4 = var_10_9
			else
				var_10_4 = var_10_5
			end
		end

		local var_10_10 = {
			arg_5_0.goodID
		}
		local var_10_11 = var_10_3

		if arg_5_0.showModel == var_0_1.BuyDlcAndSkin then
			table.insert(var_10_10, arg_5_0.dlcID)

			if arg_5_0.selectCurrencyIndex == 1 then
				var_10_11 = var_10_3 + var_10_4
			end
		elseif arg_5_0.showModel == var_0_1.OnlyDlc then
			var_10_11 = var_10_4
		elseif arg_5_0.showModel == var_0_1.FakeData then
			var_10_10 = {
				arg_5_0.dlcID
			}
			var_10_11 = var_10_4
		end

		local function var_10_12(arg_11_0)
			if ShopTools.IsRMB(arg_11_0[1]) then
				PayAction.RequestGSPay(ShopTools.GetCostId(arg_5_0.goodID), 1, arg_5_0.shopID, arg_11_0[1])
			elseif arg_5_0.showModel == var_0_1.BuyDlcAndSkin then
				ShopTools.ConfirmBuySkin(arg_11_0, {
					1,
					1
				}, nil, nil, nil, arg_5_0.selectCurrencyIndex - 1)
			elseif arg_5_0.showModel == var_0_1.FakeData then
				ShopTools.ConfirmBuySkin(arg_11_0, {
					1,
					1
				}, nil, nil, nil, arg_5_0.selectCurrencyIndex - 1)
			elseif arg_5_0.showModel == var_0_1.OnlyDlc then
				ShopTools.ConfirmBuyItem(arg_11_0[1], 1, nil, nil, nil, arg_5_0.selectCurrencyIndex - 1)
			else
				ShopTools.ConfirmBuyItem(arg_11_0[1], 1, nil, nil, nil, 0)
			end
		end

		local function var_10_13(arg_12_0)
			if not arg_12_0 then
				return
			end

			if ShopTools.IsRMB(arg_5_0.goodID) == false and ShopTools.GetCostCount(arg_5_0.goodID) < var_10_11 then
				var_10_12(var_10_10)
			else
				var_10_12(var_10_10)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_skin_buy_unlock = 0
				})
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = arg_5_0.skinID
		})

		if ShopData.IsGoodOutOfDate(arg_5_0.goodID) then
			ShowTips("SKIN_SALE_FINISH")
			arg_5_0:Back()

			return
		end

		local var_10_14 = {
			{
				check = function()
					return HeroData:GetHeroData(arg_5_0.heroID).unlock == 0
				end,
				content = GetTipsF("NOT_HAVE_HERO_SKIN_CONFIRM", GetI18NText(arg_5_0.heroCfg.name)),
				cancelCallback = function()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			}
		}

		CommonTools.Ask(var_10_14, var_10_13)
	end)
	arg_5_0:AddBtnListener(arg_5_0.dlcBtn_, nil, function()
		if ShopTools.CheckDlcCanBuy(arg_5_0.dlcID) and ShopTools.CheckDlcPurchased(arg_5_0.dlcID) == false then
			if arg_5_0.selectDLC == true then
				arg_5_0.dlcselController:SetSelectedState("false")

				arg_5_0.selectDLC = false
			else
				arg_5_0.selectDLC = true

				arg_5_0.dlcselController:SetSelectedState("true")

				arg_5_0.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. arg_5_0.skinCfg.id)
			end
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.addDlcBtn_, nil, function()
		arg_5_0.showModel = var_0_1.BuyDlcAndSkin

		arg_5_0:UpdateView()
		arg_5_0.dlcbtnController:SetSelectedState("buy")

		if arg_5_0.dlcID then
			local var_16_0 = getShopCfg(arg_5_0.dlcID)

			if var_16_0 then
				local var_16_1 = var_16_0.give_id or var_16_0.description

				if var_16_1 then
					OperationRecorder.RecordButtonTouch("skin_buy_add_" .. var_16_1)
				end
			end
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelDlcBtn_, nil, function()
		arg_5_0.showModel = var_0_1.OnlySkin

		arg_5_0:UpdateView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnView_, nil, function()
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = arg_5_0.goodID
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinDiscountBtn_, nil, function()
		SkinDiscountGiftAction.JumpToSkinDiscountGiftWindow(arg_5_0.goodID)
	end)
	arg_5_0:AddBtnListener(arg_5_0.currencyTab1_, nil, function()
		arg_5_0:SelectCurrencyTab(1)
		arg_5_0:UpdatePrice()
	end)
	arg_5_0:AddBtnListener(arg_5_0.currencyTab2_, nil, function()
		arg_5_0:SelectCurrencyTab(2)
		arg_5_0:UpdatePrice()
	end)
	arg_5_0:AddBtnListener(arg_5_0.oathBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityOathDrawMainView", {
			activityID = ActivityOathDrawData:GetMainActivityID()
		})
	end)
end

function var_0_0.OnShopBuyResult(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1 == 0 then
		arg_23_0:Back()
	else
		arg_23_0:Back()
	end
end

function var_0_0.UpdateBar(arg_24_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId(),
		CurrencyConst.CURRENCY_TYPE_SKIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
end

function var_0_0.OnTop(arg_25_0)
	arg_25_0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.UpdateData(arg_26_0)
	arg_26_0.shopCfg = getShopCfg(arg_26_0.goodID)
	arg_26_0.shopID = arg_26_0.shopCfg.shop_id
	arg_26_0.skinCfg = SkinCfg[arg_26_0.skinID]
	arg_26_0.heroCfg = HeroCfg[arg_26_0.skinCfg.hero]
	arg_26_0.desCfg = RechargeShopDescriptionCfg[arg_26_0.shopCfg.description]
	arg_26_0.descID = arg_26_0.desCfg.id
	arg_26_0.dlcID = arg_26_0.shopCfg.dlc or nil
	arg_26_0.shopDlcCfg = getShopCfg(arg_26_0.dlcID)
	arg_26_0.showModel = arg_26_0.params_.onlySkin and var_0_1.OnlySkin or var_0_1.BuyDlcAndSkin

	if arg_26_0.shopDlcCfg and arg_26_0.shopDlcCfg.shop_id == arg_26_0.shopID or arg_26_0.shopDlcCfg and arg_26_0.shopDlcCfg.shop_id == ShopConst.SHOP_ID.PASSPORT_SHOP then
		arg_26_0.itemDlcCfg = RechargeShopDescriptionCfg[arg_26_0.shopDlcCfg.description]

		if arg_26_0.itemDlcCfg == nil then
			arg_26_0.itemDlcCfg = ItemCfg[arg_26_0.shopDlcCfg.give_id]
			arg_26_0.showModel = var_0_1.OnlySkin
		end
	end

	if arg_26_0.goodID <= 0 then
		arg_26_0.showModel = var_0_1.FakeData
	elseif ShopTools.HaveSkin(arg_26_0.skinID) then
		arg_26_0.showModel = var_0_1.OnlyDlc
		arg_26_0.goodID = arg_26_0.dlcID
	end
end

function var_0_0.UpdatePrice(arg_27_0)
	local var_27_0 = ItemCfg[arg_27_0.skinCfg.hero]

	SetActive(arg_27_0.oriOriceTxt_.gameObject, false)
	SetActive(arg_27_0.skinOriginTxt_.gameObject, false)
	SetActive(arg_27_0.dlcPrice_.gameObject, false)
	SetActive(arg_27_0.allPriceTxt_.gameObject, arg_27_0.selectCurrencyIndex == 1 and arg_27_0.showModel == var_0_1.BuyDlcAndSkin)
	SetActive(arg_27_0.dlcPrice_.gameObject, arg_27_0.selectCurrencyIndex == 1 and arg_27_0.showModel == var_0_1.BuyDlcAndSkin)
	SetActive(arg_27_0.kuoGo_, arg_27_0.selectCurrencyIndex == 1 and arg_27_0.showModel == var_0_1.BuyDlcAndSkin)
	SetActive(arg_27_0.secondCurrencyGo_, arg_27_0.selectCurrencyIndex == 2 and arg_27_0.showModel == var_0_1.BuyDlcAndSkin)
	arg_27_0.dlcbgController:SetSelectedState(arg_27_0.showModel == var_0_1.OnlyDlc and "true" or "false")

	local var_27_1, var_27_2, var_27_3 = ShopTools.IsOnDiscountArea(arg_27_0.goodID)
	local var_27_4, var_27_5, var_27_6 = ShopTools.GetPrice(arg_27_0.goodID)

	if arg_27_0.showModel == var_0_1.BuyDlcAndSkin then
		local var_27_7, var_27_8, var_27_9, var_27_10, var_27_11 = ShopTools.GetPrice(arg_27_0.dlcID)
		local var_27_12, var_27_13, var_27_14, var_27_15, var_27_16, var_27_17 = ShopTools.IsOnDiscountArea(arg_27_0.dlcID)

		if ShopTools.IsRMB(arg_27_0.goodID) then
			SetActive(arg_27_0.costiconImg_.gameObject, false)

			arg_27_0.priceText_.text = ShopTools.GetMoneySymbol(arg_27_0.goodID) .. var_27_4 + var_27_7
		else
			arg_27_0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(arg_27_0.shopCfg.cost_id), var_27_4 + var_27_7, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(arg_27_0.shopCfg.description)) .. string.format(GetTips("BUY_SKIN_TIPS_TICKET_NAME"), ItemTools.getItemName(arg_27_0.itemDlcCfg.id))

			SetActive(arg_27_0.costiconImg_.gameObject, true)

			if var_27_1 and var_27_3 then
				SetActive(arg_27_0.skinOriginTxt_.gameObject, var_27_4 ~= var_27_5)

				if var_27_4 ~= var_27_5 then
					arg_27_0.skinOriginTxt_.text = var_27_5
				end
			end

			if var_27_12 and var_27_14 then
				local var_27_18
				local var_27_19

				if arg_27_0.selectCurrencyIndex == 1 then
					var_27_18 = var_27_7
					var_27_19 = var_27_8
				elseif arg_27_0.selectCurrencyIndex == 2 then
					var_27_18 = var_27_10
					var_27_19 = var_27_11
				end

				SetActive(arg_27_0.oriOriceTxt_.gameObject, var_27_18 ~= var_27_19)

				if var_27_18 ~= var_27_19 then
					arg_27_0.oriOriceTxt_.text = var_27_19
				end
			else
				SetActive(arg_27_0.oriOriceTxt_.gameObject, false)
			end

			if arg_27_0.selectCurrencyIndex == 2 then
				local var_27_20, var_27_21 = ShopTools.GetCostId(arg_27_0.goodID)
				local var_27_22, var_27_23 = ShopTools.GetCostId(arg_27_0.dlcID)

				arg_27_0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET_MULTIPAY"), "[" .. ItemTools.getItemName(var_27_20) .. "]" .. var_27_4 .. " + [" .. ItemTools.getItemName(var_27_23) .. "]" .. var_27_10, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(arg_27_0.shopCfg.description)) .. string.format(GetTips("BUY_SKIN_TIPS_TICKET_NAME"), ItemTools.getItemName(arg_27_0.itemDlcCfg.id))
				arg_27_0.secondCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_27_23)

				if var_27_10 > ItemTools.getItemNum(var_27_23) then
					arg_27_0.secondCurrencyText_.text = "<color=#FF000B>" .. var_27_10 .. "</color>"
				else
					arg_27_0.secondCurrencyText_.text = var_27_10
				end

				if var_27_4 > ItemTools.getItemNum(var_27_20) then
					arg_27_0.priceText_.text = "<color=#FF000B>" .. var_27_4 .. "</color>"
				else
					arg_27_0.priceText_.text = var_27_4
				end
			else
				arg_27_0.costiconImg_.sprite = ItemTools.getItemLittleSprite(arg_27_0.shopCfg.cost_id)
				arg_27_0.priceText_.text = var_27_4 + var_27_7

				if ItemTools.getItemNum(arg_27_0.shopCfg.cost_id) < var_27_4 + var_27_7 then
					arg_27_0.priceText_.text = "<color=#FF000B>" .. var_27_4 + var_27_7 .. "</color>"
				end

				arg_27_0.dlcPrice_.text = "+" .. var_27_7
				arg_27_0.allPriceTxt_.text = string.format("( %d", var_27_4)
			end
		end

		if #arg_27_0.shopCfg.give_back_list ~= 0 then
			arg_27_0.rebackSkinTicketText_.text = arg_27_0.shopCfg.give_back_list[1].num
			arg_27_0.allrebackTxt_.text = ""
		end
	else
		local var_27_24, var_27_25 = ShopTools.GetCostId(arg_27_0.goodID)
		local var_27_26
		local var_27_27

		if arg_27_0.dlcID ~= 0 then
			var_27_26, var_27_27 = ShopTools.GetCostId(arg_27_0.dlcID)
		end

		if arg_27_0.showModel == var_0_1.OnlyDlc or arg_27_0.showModel == var_0_1.FakeData then
			local var_27_28

			var_27_4, var_27_5, var_27_28, price2, oriPrice2 = ShopTools.GetPrice(arg_27_0.dlcID)
			arg_27_0.dlcItemIcon_.sprite = ItemTools.getItemSprite(arg_27_0.itemDlcCfg.id)

			if arg_27_0.selectCurrencyIndex == 2 then
				var_27_4 = price2
				var_27_5 = oriPrice2
				var_27_26 = var_27_27
			end

			SetActive(arg_27_0.oriOriceTxt_.gameObject, var_27_4 ~= var_27_5)

			if var_27_4 ~= var_27_5 then
				arg_27_0.oriOriceTxt_.text = var_27_5
			end
		end

		if ShopTools.IsRMB(arg_27_0.goodID) then
			SetActive(arg_27_0.costiconImg_.gameObject, false)

			arg_27_0.priceText_.text = ShopTools.GetMoneySymbol(arg_27_0.goodID) .. var_27_4
			arg_27_0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS"), ShopTools.GetMoneySymbol(arg_27_0.goodID) .. var_27_4, "", ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(arg_27_0.shopCfg.description))

			if var_27_1 and var_27_3 then
				SetActive(arg_27_0.skinOriginTxt_.gameObject, var_27_4 ~= var_27_5)

				if var_27_4 ~= var_27_5 then
					arg_27_0.skinOriginTxt_.text = var_27_5
				end
			end
		else
			if arg_27_0.showModel == var_0_1.OnlyDlc then
				arg_27_0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(var_27_26), var_27_4, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(arg_27_0.itemDlcCfg.id))
			elseif arg_27_0.showModel == var_0_1.FakeData then
				arg_27_0.buyDesc_.text = string.format(GetTips("BUY_SKIN_DLC_SINGLE_TIPS"), ItemTools.getItemName(var_27_26), var_27_4, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(arg_27_0.itemDlcCfg.id))
			else
				arg_27_0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(var_27_24), var_27_4, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(arg_27_0.shopCfg.description))
				var_27_26 = var_27_24
			end

			if var_27_1 and var_27_3 then
				SetActive(arg_27_0.skinOriginTxt_.gameObject, var_27_4 ~= var_27_5 and arg_27_0.showModel ~= var_0_1.OnlyDlc)

				if var_27_4 ~= var_27_5 then
					arg_27_0.skinOriginTxt_.text = var_27_5
				end
			end

			SetActive(arg_27_0.costiconImg_.gameObject, true)

			arg_27_0.costiconImg_.sprite = ItemTools.getItemLittleSprite(var_27_26)
			arg_27_0.priceText_.text = var_27_4

			if var_27_4 > ItemTools.getItemNum(var_27_26) then
				arg_27_0.priceText_.text = "<color=#FF000B>" .. var_27_4 .. "</color>"
			end
		end

		if #arg_27_0.shopCfg.give_back_list ~= 0 then
			arg_27_0.rebackSkinTicketText_.text = arg_27_0.shopCfg.give_back_list[1].num
			arg_27_0.allrebackTxt_.text = ""
		end

		arg_27_0.allrebackTxt_.text = ""
		arg_27_0.allPriceTxt_.text = ""

		SetActive(arg_27_0.kuoGo_, false)
	end

	if arg_27_0.dlcID and arg_27_0.dlcID ~= 0 then
		local var_27_29 = ShopTools.HasMultiPay(arg_27_0.dlcID)

		arg_27_0.multiTabController:SetSelectedState((arg_27_0.showModel == var_0_1.OnlyDlc or arg_27_0.showModel == var_0_1.BuyDlcAndSkin) and var_27_29 and "true" or "false")
		arg_27_0.multiPayController:SetSelectedState(tostring(var_27_29 and arg_27_0.showModel == var_0_1.OnlySkin))

		if var_27_29 then
			local var_27_30, var_27_31, var_27_32, var_27_33, var_27_34 = ShopTools.GetPrice(arg_27_0.dlcID)

			SetActive(arg_27_0.currencyOriPriceText2_.gameObject, var_27_33 ~= var_27_34)
			SetActive(arg_27_0.currencyOriPriceText1_.gameObject, var_27_30 ~= var_27_31)

			arg_27_0.currencyPriceText1_.text = var_27_30
			arg_27_0.currencyOriPriceText1_.text = var_27_31
			arg_27_0.currencyPriceText2_.text = var_27_33
			arg_27_0.currencyOriPriceText2_.text = var_27_34
		else
			arg_27_0.selectCurrencyIndex = 1
		end
	else
		arg_27_0.multiTabController:SetSelectedState("false")
	end
end

function var_0_0.UpdateTitle(arg_28_0)
	if arg_28_0.showModel == var_0_1.OnlyDlc or arg_28_0.showModel == var_0_1.BuyDlcAndSkin or arg_28_0.showModel == var_0_1.FakeData then
		arg_28_0.textnameText_.text = ItemTools.getItemName(arg_28_0.itemDlcCfg.id)
		arg_28_0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(arg_28_0.itemDlcCfg.id)) .. ItemTools.getItemDesc(arg_28_0.itemDlcCfg.id)
	else
		arg_28_0.textnameText_.text = ItemTools.getItemName(arg_28_0.shopCfg.description)
		arg_28_0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(arg_28_0.shopCfg.description)) .. ItemTools.getItemDesc(arg_28_0.descID)
	end
end

function var_0_0.UpdateDLCBg(arg_29_0)
	local var_29_0 = arg_29_0.itemDlcCfg and HomeSceneSettingCfg[arg_29_0.itemDlcCfg.id]

	if var_29_0 and var_29_0.prefix then
		arg_29_0.dlcBgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. var_29_0.prefix)
	end
end

function var_0_0.UpdateDLCInfo(arg_30_0)
	if arg_30_0.showModel == var_0_1.FakeData then
		arg_30_0.littleSkinIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", arg_30_0.skinCfg.picture_id)
		arg_30_0.dlcItemNameTxt_.text = string.format(ItemTools.getItemName(arg_30_0.desCfg.id))
		arg_30_0.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. arg_30_0.skinCfg.id .. "_character")

		arg_30_0.dlcbtnController:SetSelectedState("Events")
	else
		if arg_30_0.shopDlcCfg.shop_id == arg_30_0.shopID then
			local var_30_0 = ShopTools.HasMultiPay(arg_30_0.dlcID)

			if ShopTools.CheckDlcPurchased(arg_30_0.dlcID) then
				arg_30_0.dlcbtnController:SetSelectedState("get")
			elseif ShopTools.CheckDlcCanBuy(arg_30_0.dlcID) then
				if arg_30_0.showModel == var_0_1.BuyDlcAndSkin then
					arg_30_0.dlcbtnController:SetSelectedState("buy")
				else
					arg_30_0.dlcbtnController:SetSelectedState("notBuy")
				end
			else
				arg_30_0.dlcbtnController:SetSelectedState("cannotBuy")
			end

			arg_30_0.dlcbuyTxt_.text = GetTipsF("BUY_SKIN_DLC_TIPS", ItemTools.getItemName(arg_30_0.itemDlcCfg.id))
		else
			arg_30_0.dlcbtnController:SetSelectedState("cannotBuy")
		end

		arg_30_0:UpdateDLCBg()

		arg_30_0.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. arg_30_0.skinCfg.id .. "_character")
		arg_30_0.dlcLittleIcon_.sprite = ItemTools.getItemSprite(arg_30_0.itemDlcCfg.id)
		arg_30_0.dlcItemNameTxt_.text = ItemTools.getItemName(arg_30_0.itemDlcCfg.id)
	end
end

function var_0_0.UpdateView(arg_31_0)
	arg_31_0:UpdateOathUI()
	arg_31_0:UpdatePrice()
	arg_31_0:UpdateTitle()
	SetActive(arg_31_0.dlcItemLimit_, false)
	SetActive(arg_31_0.freeGiveGo_, false)
	arg_31_0.dlcselController:SetSelectedState((arg_31_0.showModel == var_0_1.OnlyDlc or arg_31_0.showModel == var_0_1.BuyDlcAndSkin or arg_31_0.showModel == var_0_1.FakeData) and "true" or "false")
	SetActive(arg_31_0.giveBackGo_, #arg_31_0.shopCfg.give_back_list ~= 0 and arg_31_0.showModel ~= var_0_1.OnlyDlc)

	if nullable(arg_31_0.shopCfg.give_back_list, 2) and arg_31_0.showModel ~= var_0_1.OnlyDlc then
		local var_31_0 = rewardToItemTemplate(formatReward(arg_31_0.shopCfg.give_back_list[2]), nil, true)

		arg_31_0.giveBackItem2:SetData(var_31_0)
		SetActive(arg_31_0.giveBackItem2.gameObject_, true)
	else
		SetActive(arg_31_0.giveBackItem2.gameObject_, false)
	end

	SetActive(arg_31_0.skinRemainGo_, false)

	arg_31_0.skinImg_.sprite = getSpriteViaConfig("HeroIcon", arg_31_0.skinCfg.picture_id)

	arg_31_0.skinImg_:SetNativeSize()

	if arg_31_0.dlcID == 0 or arg_31_0.showModel == var_0_1.OnlyDlc then
		if arg_31_0.showModel == var_0_1.OnlyDlc then
			arg_31_0:UpdateDLCBg()
		end

		arg_31_0.dlcIconController:SetSelectedState("false")
	else
		arg_31_0.dlcIconController:SetSelectedState("true")
		arg_31_0:UpdateDLCInfo()
	end

	arg_31_0:UpdateTimeView()
	arg_31_0:UpdateSkinDiscountGift()
end

function var_0_0.UpdateTimer(arg_32_0)
	arg_32_0:UpdateTimeView()

	if arg_32_0.timer_ == nil then
		arg_32_0.timer_ = Timer.New(function()
			arg_32_0:UpdateTimeView()
		end, 1, -1, -1)

		arg_32_0.timer_:Start()
	end
end

function var_0_0.UpdateTimeView(arg_34_0)
	if (arg_34_0.showModel == var_0_1.OnlyDlc or arg_34_0.showModel == var_0_1.BuyDlcAndSkin or arg_34_0.showModel == var_0_1.FakeData) and arg_34_0.shopDlcCfg then
		local var_34_0, var_34_1, var_34_2, var_34_3, var_34_4 = ShopTools.IsOnDiscountArea(arg_34_0.dlcID)
		local var_34_5 = arg_34_0.shopDlcCfg.cheap_close_time
		local var_34_6 = arg_34_0.shopDlcCfg.is_limit_time_discount

		if arg_34_0.selectCurrencyIndex == 2 then
			var_34_5 = arg_34_0.shopDlcCfg.cheap_close_time_2
			var_34_6 = arg_34_0.shopDlcCfg.is_limit_time_discount_2
			var_34_0 = var_34_0 and (var_34_3 == 2 or var_34_3 == 3)
		else
			var_34_0 = var_34_0 and (var_34_3 == 1 or var_34_3 == 3)
		end

		if var_34_0 and var_34_2 and var_34_6 == 1 then
			SetActive(arg_34_0.dlcItemLimit_, true)

			arg_34_0.dlcItemLimitTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(var_34_5))
		else
			SetActive(arg_34_0.dlcItemLimit_, false)
		end
	else
		SetActive(arg_34_0.dlcItemLimit_, false)
	end

	local var_34_7 = arg_34_0.shopCfg.close_time
	local var_34_8 = arg_34_0.shopCfg

	if arg_34_0.showModel == var_0_1.OnlyDlc then
		var_34_7 = arg_34_0.shopDlcCfg.close_time
		var_34_8 = arg_34_0.shopDlcCfg
	end

	SetActive(arg_34_0.timeGo_, #var_34_7 > 0)

	if #var_34_7 <= 0 then
		arg_34_0.discountController:SetSelectedState("none")
	end

	if #var_34_7 > 0 then
		local var_34_9 = TimeMgr.GetInstance():GetServerTime()
		local var_34_10 = TimeMgr.GetInstance():parseTimeFromConfig(var_34_7)

		if var_34_10 <= var_34_9 then
			arg_34_0.remainTxt_.text = GetTips("TIP_EXPIRED")
		else
			arg_34_0.remainTxt_.text = string.format("%s", manager.time:GetLostTimeStr(var_34_10))
		end
	end

	local var_34_11, var_34_12, var_34_13, var_34_14 = ShopTools.IsOnDiscountArea(var_34_8.goods_id)
	local var_34_15 = var_34_8.cheap_close_time
	local var_34_16 = var_34_8.is_limit_time_discount

	if arg_34_0.showModel == var_0_1.OnlyDlc or arg_34_0.showModel == var_0_1.BuyDlcAndSkin or arg_34_0.showModel == var_0_1.FakeData then
		if arg_34_0.selectCurrencyIndex == 2 then
			var_34_15 = var_34_8.cheap_close_time_2
			var_34_16 = var_34_8.is_limit_time_discount_2
			var_34_11 = var_34_11 and (var_34_14 == 2 or var_34_14 == 3)
		else
			var_34_11 = var_34_11 and (var_34_14 == 1 or var_34_14 == 3)
		end
	end

	if #var_34_15 > 0 and var_34_16 == 1 then
		if var_34_11 and var_34_13 then
			arg_34_0.discountController:SetSelectedState("limitedtime")
			SetActive(arg_34_0.skinRemainGo_, var_34_16 == 1)

			arg_34_0.skinRemianTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(var_34_15))
		else
			arg_34_0.discountController:SetSelectedState("none")
			SetActive(arg_34_0.skinRemainGo_, false)
		end
	else
		arg_34_0.discountController:SetSelectedState("none")
		SetActive(arg_34_0.skinRemainGo_, false)
	end

	arg_34_0:UpdatePrice()
end

function var_0_0.UpdateSkinDiscountGift(arg_35_0)
	if SkinDiscountGiftTools.HasDiscountGoodsID(arg_35_0.goodID) then
		arg_35_0.skinDiscountController:SetSelectedState("state1")
	else
		arg_35_0.skinDiscountController:SetSelectedState("state0")
	end
end

function var_0_0.UpdateOathUI(arg_36_0)
	if not OathDrawTools.CheckIsCanBuyOathSkin(arg_36_0.heroID, arg_36_0.skinID) then
		arg_36_0.oathDrawStateController:SetSelectedState("hide")
	elseif ShopTools.HaveSkin(arg_36_0.skinCfg.id) then
		arg_36_0.oathDrawStateController:SetSelectedState("hide")
	elseif arg_36_0.skinID == ActivityOathDrawData:GetSkinID() then
		arg_36_0.oathDrawStateController:SetSelectedState("show")
	else
		arg_36_0.oathDrawStateController:SetSelectedState("hide")
	end
end

function var_0_0.SelectCurrencyTab(arg_37_0, arg_37_1)
	if arg_37_0.dlcID and arg_37_0.dlcID ~= 0 then
		local var_37_0 = ShopTools.HasMultiPay(arg_37_0.dlcID)

		arg_37_0.selectCurrencyIndex = arg_37_1

		arg_37_0.multiSelectTabController:SetSelectedState(arg_37_1 == 1 and "select1" or "select2")
	end

	arg_37_0:UpdateTimeView()
end

function var_0_0.OnEnter(arg_38_0)
	arg_38_0.goodID = arg_38_0.params_.goodID
	arg_38_0.heroID = arg_38_0.params_.heroID
	arg_38_0.skinID = arg_38_0.params_.skinID
	arg_38_0.selectDLC = not arg_38_0.params_.onlySkin
	arg_38_0.selectCurrencyIndex = arg_38_0.params_.selectCurrencyIndex or 1

	arg_38_0:UpdateData()
	arg_38_0:UpdateView()
	arg_38_0:UpdateTimer()
	arg_38_0:SelectCurrencyTab(arg_38_0.selectCurrencyIndex)
	arg_38_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_39_0)
		local var_39_0 = HeroTools.GetSkinChangeItem(arg_38_0.skinID)

		arg_38_0:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(var_39_0)),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						item_info = {
							num = 1,
							id = var_39_0
						},
						use_list = {}
					}
				})
			end
		})
	end)
end

function var_0_0.OnExit(arg_41_0)
	if arg_41_0.timer_ ~= nil then
		arg_41_0.timer_:Stop()

		arg_41_0.timer_ = nil
	end

	manager.windowBar:HideBar()
	arg_41_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_42_0)
	arg_42_0.giveBackItem2:Dispose()
	var_0_0.super.Dispose(arg_42_0)
end

return var_0_0
