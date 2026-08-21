local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RechargeSkinListDlcItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.isLimitTimeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isLimitTime")
	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.giftController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "gift")
	arg_1_0.costTypeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "costType")
	arg_1_0.oathLimitDrawController_ = arg_1_0.controller_:GetController("Oath")
	arg_1_0.oathGiftController_ = arg_1_0.controller_:GetController("OathGift")
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.bgBtn_, nil, function()
		local var_3_0 = SkinDiscountGiftTools.HasDiscountGoodsID(arg_2_0.goodID)

		if var_3_0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_SKIN_DISCOUNT_HIGH_COST_EFFECTIVENESS_TIPS_1"),
				OkCallback = function()
					OperationRecorder.RecordButtonTouch({
						button_name = string.format("message_push_activity_%s_enter", var_3_0),
						source = SkinDiscountGiftConst.EXIST_GIFT_AND_JUMP_TIPS
					})
					SkinDiscountGiftAction.JumpToSkinDiscountGiftWindow(arg_2_0.goodID)
				end,
				CancelCallback = function()
					OperationRecorder.RecordButtonTouch({
						button_name = string.format("message_push_activity_%s_close", var_3_0),
						source = SkinDiscountGiftConst.EXIST_GIFT_AND_JUMP_TIPS
					})
					arg_2_0:OnClickItem()
				end
			})
		else
			arg_2_0:OnClickItem()
		end
	end)
end

function var_0_1.OnClickItem(arg_6_0)
	SendMessageManagerToSDK("purchase_click_skin")
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_skin = arg_6_0.skinCfg.id
	})

	if ShopConst.SHOP_ID.DLC_SHOP ~= arg_6_0.shopCfg.shop_id then
		if ShopTools.HaveSkin(arg_6_0.skinId) then
			ShowMessageBox({
				content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(arg_6_0.shopCfg.give_id)),
				OkCallback = function()
					JumpTools.GoToSystem("/shop", {
						shopId = arg_6_0.shopID,
						goodId = arg_6_0.goodID
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			})

			return
		end

		arg_6_0:Go("/heroSkinPreview", {
			isShop = true,
			isDlc = true,
			heroID = arg_6_0.skinCfg.hero,
			skinID = arg_6_0.skinCfg.id,
			shopID = arg_6_0.shopID
		})
		OperationRecorder.RecordButtonTouch("buy_skin_button_" .. arg_6_0.goodID)
	else
		arg_6_0:Go("/heroSkinPreview", {
			isShop = true,
			isDlc = true,
			heroID = arg_6_0.skinCfg.hero,
			skinID = arg_6_0.skinCfg.id,
			shopID = arg_6_0.shopID
		})
		OperationRecorder.RecordButtonTouch("buy_skin_button_" .. arg_6_0.goodID)
	end
end

function var_0_1.SetOutOfDateHandler(arg_8_0, arg_8_1)
	arg_8_0.outOfDateHandler_ = arg_8_1
end

function var_0_1.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.shopCfg = getShopCfg(arg_9_1)
	arg_9_0.goodID = arg_9_1
	arg_9_0.skinGoodId = arg_9_3
	arg_9_0.shopID = arg_9_0.shopCfg.shop_id
	arg_9_0.skinId = arg_9_2
	arg_9_0.skinCfg = SkinCfg[arg_9_2]
	arg_9_0.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == arg_9_0.shopCfg.shop_id and ShopTools.CheckDlcPurchased(arg_9_1) == false
	arg_9_0.itemCfg = RechargeShopDescriptionCfg[arg_9_0.shopCfg.description]

	if arg_9_0.itemCfg == nil then
		arg_9_0.itemCfg = ItemCfg[arg_9_0.shopCfg.give_id]
	end

	arg_9_0:UpdateView()
	arg_9_0:UpdateTimerView()
end

function var_0_1.UpdateTimerView(arg_10_0)
	arg_10_0.isLimitTimeController_:SetSelectedState("false")
	arg_10_0:RefreshCommonUI()
	arg_10_0:RefreshPriceUI()
end

function var_0_1.UpdateView(arg_11_0)
	arg_11_0:RefreshPriceUI()
	arg_11_0:RefreshCommonUI()

	local var_11_0 = ItemCfg[arg_11_0.skinCfg.hero]

	arg_11_0.nameLabel_.text = string.format("%s", arg_11_0.itemCfg.name)
	arg_11_0.titleLabel_.text = ItemTools.getItemName(var_11_0.id)

	local var_11_1 = ""

	if ShopTools.HaveSkin(arg_11_0.skinId) or arg_11_0.shopID == ShopConst.SHOP_ID.PASSPORT_SHOP then
		var_11_1, oriPrice, _, price2, oriPrice2 = ShopTools.GetPrice(arg_11_0.goodID)
	else
		var_11_1 = ShopTools.GetPrice(arg_11_0.skinGoodId) .. " + " .. ShopTools.GetPrice(arg_11_0.goodID)
	end

	arg_11_0.priceText_.text = var_11_1
	arg_11_0.icon_.spriteSync = "TextureConfig/Character/Icon/" .. arg_11_0.itemCfg.id
	arg_11_0.costIcon_.sprite = ItemTools.getItemSprite(arg_11_0.shopCfg.cost_id)

	if ShopTools.IsPC() then
		SetActive(arg_11_0.pcBtn_.gameObject, ShopTools.IsRMB(arg_11_0.goodID))
	end

	if ShopTools.HasMultiPay(arg_11_0.goodID) then
		arg_11_0.giftController_:SetSelectedState("multiPay")

		if ShopTools.HaveSkin(arg_11_0.skinCfg.id) then
			arg_11_0.costTypeController_:SetSelectedState("DualCurrencies")
		else
			arg_11_0.costTypeController_:SetSelectedState("currency")
		end

		arg_11_0.costIcon2_.sprite = ItemTools.getItemSprite(arg_11_0.shopCfg.cost_id_2)
		arg_11_0.priceText2_.text = price2
	else
		arg_11_0.giftController_:SetSelectedState("false")
		arg_11_0.costTypeController_:SetSelectedState("currency")
	end

	arg_11_0:UpdateOathUI()
end

function var_0_1.RefreshCommonUI(arg_12_0)
	SetActive(arg_12_0.discountGo_, false)
	SetActive(arg_12_0.limitGiveGo_, false)
	SetActive(arg_12_0.freeGiftGo_, false)
	SetActive(arg_12_0.superValueGo_, arg_12_0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE)

	local var_12_0, var_12_1, var_12_2 = ShopTools.IsOnDiscountArea(arg_12_0.goodID)
	local var_12_3 = ShopTools.GetDiscount(arg_12_0.goodID)

	if var_12_0 and var_12_2 and #arg_12_0.shopCfg.cheap_close_time > 0 then
		SetActive(arg_12_0.limitDiscountGo_, arg_12_0.shopCfg.is_limit_time_discount == 1)
	else
		SetActive(arg_12_0.limitDiscountGo_, false)
	end

	if arg_12_0.shopCfg.cost == 0 then
		SetActive(arg_12_0.freeGiftGo_, true)
	end
end

function var_0_1.RefreshPriceUI(arg_13_0, arg_13_1)
	if ShopConst.SHOP_ID.DLC_SHOP == arg_13_0.shopCfg.shop_id and ShopTools.CheckDlcPurchased(arg_13_0.goodID) == false then
		arg_13_0.statusController_:SetSelectedState(arg_13_0.shopCfg.give_back_list and #arg_13_0.shopCfg.give_back_list > 0 and "back" or "normal")
	elseif ShopTools.CheckDlcPurchased(arg_13_0.goodID) == false then
		arg_13_0.statusController_:SetSelectedState("normal")
	else
		arg_13_0.statusController_:SetSelectedState("sellout")
	end

	if arg_13_0.shopCfg.give_back_list and #arg_13_0.shopCfg.give_back_list > 0 then
		arg_13_0.rebackTxt_.text = arg_13_0.shopCfg.give_back_list[1].num
	end
end

function var_0_1.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_1.UpdateOathUI(arg_15_0)
	local var_15_0 = arg_15_0.skinCfg.hero

	if not OathDrawTools.CheckIsCanBuyOathSkin(var_15_0, arg_15_0.skinId) then
		arg_15_0.oathLimitDrawController_:SetSelectedState("false")
		arg_15_0.oathGiftController_:SetSelectedState("hide")

		return
	end

	if arg_15_0.skinId == ActivityOathDrawData:GetSkinID() then
		arg_15_0.oathLimitDrawController_:SetSelectedState("true")
	else
		arg_15_0.oathLimitDrawController_:SetSelectedState("false")
	end

	if not ShopTools.HaveSkin(arg_15_0.skinCfg.id) then
		arg_15_0.oathGiftController_:SetSelectedState("show")

		arg_15_0.oathGiftImg_.sprite = ItemTools.getItemSprite(OathDrawTools.GetCouponID())
	else
		arg_15_0.oathGiftController_:SetSelectedState("hide")
	end
end

return var_0_1
