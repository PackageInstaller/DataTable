local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RechargeSkinNewItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.icon_.immediate = true
	arg_1_0.costTypeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "costType")
	arg_1_0.isLimitTimeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isLimitTime")
	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.levelController_ = ControllerUtil.GetController(arg_1_0.transform_, "level")
	arg_1_0.giftController_ = ControllerUtil.GetController(arg_1_0.transform_, "gift")
	arg_1_0.dlcController_ = ControllerUtil.GetController(arg_1_0.transform_, "dlc")
	arg_1_0.oathLimitDrawController_ = arg_1_0.controller_:GetController("Oath")
	arg_1_0.oathGiftController_ = arg_1_0.controller_:GetController("OathGift")
end

function var_0_1.AddUIListener(arg_2_0)
	local function var_2_0()
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
	end

	arg_2_0:AddBtnListener(arg_2_0.bgBtn_, nil, var_2_0)
	arg_2_0:AddBtnListener(arg_2_0.bottomBtn_, nil, var_2_0)
	arg_2_0:AddBtnListener(arg_2_0.pcBtn_, nil, function()
		ShowTips("PC_SHOP_TIPS2")
	end)
end

function var_0_1.OnClickItem(arg_7_0)
	SendMessageManagerToSDK("purchase_click_skin")
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_skin = arg_7_0.skinCfg.id
	})
	arg_7_0:Go("/heroSkinPreview", {
		isShop = true,
		heroID = arg_7_0.skinCfg.hero,
		skinID = arg_7_0.skinCfg.id,
		goodId = arg_7_0.goodID,
		shopID = arg_7_0.shopID
	})
	OperationRecorder.RecordButtonTouch("buy_skin_button_" .. arg_7_0.skinCfg.id)

	if arg_7_0.callback_ then
		arg_7_0.callback_(arg_7_0.index_)
	end
end

function var_0_1.SetOutOfDateHandler(arg_8_0, arg_8_1)
	arg_8_0.outOfDateHandler_ = arg_8_1
end

function var_0_1.SetCallBack(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.callback_ = arg_9_1
	arg_9_0.index_ = arg_9_2
end

function var_0_1.UpdateTimerView(arg_10_0)
	local var_10_0 = arg_10_0.shopCfg

	if #var_10_0.close_time > 0 then
		arg_10_0.isLimitTimeController_:SetSelectedState("true")

		arg_10_0.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(var_10_0.close_time)

		local var_10_1 = TimeMgr.GetInstance():GetServerTime()
		local var_10_2 = TimeMgr.GetInstance():parseTimeFromConfig(var_10_0.close_time)

		if var_10_2 <= var_10_1 then
			arg_10_0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if arg_10_0.outOfDateHandler_ ~= nil then
				arg_10_0.outOfDateHandler_(var_10_0.goods_id)
			end
		else
			arg_10_0.lastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(var_10_2))
		end
	else
		arg_10_0.isLimitTimeController_:SetSelectedState("false")

		arg_10_0.lastTimeLabel_.text = ""
	end

	if arg_10_0.dlcID ~= 0 then
		local var_10_3 = ShopTools.GetDiscount(arg_10_0.dlcID)
		local var_10_4, var_10_5, var_10_6 = ShopTools.IsOnDiscountArea(arg_10_0.dlcID)
		local var_10_7 = ShopTools.HasMultiPay(arg_10_0.dlcID)

		arg_10_0.giftController_:SetSelectedState((var_10_4 and var_10_6 and var_10_3 == 0 or var_10_7) and "multiPay" or "false")
	end

	arg_10_0:RefreshPriceUI(arg_10_0.goodID)
end

function var_0_1.UpdateView(arg_11_0)
	arg_11_0.levelController_:SetSelectedState(tostring(arg_11_0.skinCfg.skin_level))

	if ShopTools.HaveSkin(arg_11_0.skinCfg.id) or HeroTools.CanChangeSkin(arg_11_0.skinCfg.id) then
		arg_11_0.bgBtn_.interactable = false
	else
		arg_11_0.bgBtn_.interactable = true
	end

	arg_11_0:RefreshCommonUI()
	arg_11_0:RefreshPriceUI(arg_11_0.goodID)
	arg_11_0:UpdateOathUI()
end

function var_0_1.RefreshCommonUI(arg_12_0)
	local var_12_0 = ItemCfg[arg_12_0.skinCfg.hero]

	arg_12_0.nameLabel_.text = string.format("%s", arg_12_0.skinCfg.name)
	arg_12_0.titleLabel_.text = ItemTools.getItemName(var_12_0.id)
	arg_12_0.icon_.spriteSync = "TextureConfig/Character/Icon/" .. arg_12_0.skinCfg.picture_id

	if arg_12_0.goodID < 0 then
		arg_12_0.soldTxt_.text = GetTips("ALREADY_GET")
	else
		arg_12_0.soldTxt_.text = GetTips("SELL_OUT")
	end
end

function var_0_1.RefreshPriceUI(arg_13_0, arg_13_1)
	arg_13_0:UpdatePrice(arg_13_1)

	if ShopTools.HaveSkin(arg_13_0.skinCfg.id) or HeroTools.CanChangeSkin(arg_13_0.skinCfg.id) then
		arg_13_0.statusController_:SetSelectedState("sellout")
	else
		arg_13_0.statusController_:SetSelectedState(arg_13_0.shopCfg.give_back_list and #arg_13_0.shopCfg.give_back_list > 0 and "back" or "normal")
	end

	if arg_13_0.shopCfg.give_back_list and #arg_13_0.shopCfg.give_back_list > 0 then
		arg_13_0.rebackTxt_.text = arg_13_0.shopCfg.give_back_list[1].num
		arg_13_0.rebackSkinIcon_.sprite = ItemTools.getItemSprite(arg_13_0.shopCfg.give_back_list[1].id)
	end
end

function var_0_1.UpdatePrice(arg_14_0, arg_14_1)
	local var_14_0 = getShopCfg(arg_14_1)
	local var_14_1, var_14_2, var_14_3 = ShopTools.GetPrice(arg_14_1)

	arg_14_0.moneyTxt_.text = ShopTools.GetMoneySymbol(arg_14_1)

	if var_14_1 <= 0 then
		arg_14_0.costTypeController_:SetSelectedState("free")
	else
		if ShopTools.IsRMB(arg_14_1) then
			arg_14_0.priceText_.text = var_14_1

			if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
				arg_14_0.priceText_.text = GetTips("PC_SHOP_TIPS3")
			end
		else
			arg_14_0:SetCostIcon()
			arg_14_0:SetPriceText(arg_14_1)
		end

		arg_14_0.costTypeController_:SetSelectedState(ShopTools.IsRMB(arg_14_1) and "money" or "currency")
	end

	if arg_14_0.goodID < 0 then
		arg_14_0.costTypeController_:SetSelectedState("Events")
	end

	SetActive(arg_14_0.superValueGo_, var_14_0.tag == ShopConst.TAGS.SUPER_VALUE)

	arg_14_0.oldPriceLabel_.text = var_14_2

	local var_14_4, var_14_5, var_14_6 = ShopTools.IsOnDiscountArea(arg_14_0.goodID)

	if var_14_4 and var_14_6 then
		SetActive(arg_14_0.limitDiscountGo_, arg_14_0.shopCfg.is_limit_time_discount == 1)
		SetActive(arg_14_0.oldPriceLabel_.gameObject, var_14_1 ~= var_14_2 and var_14_5 and ShopTools.IsPC() == false)
	else
		SetActive(arg_14_0.limitDiscountGo_, false)
		SetActive(arg_14_0.oldPriceLabel_.gameObject, false)
	end

	if ShopTools.IsRMB(arg_14_1) and ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		arg_14_0.priceText_.text = GetTips("PC_SHOP_TIPS3")
		arg_14_0.moneyTxt_.text = ""
	end

	SetActive(arg_14_0.discountGo_, false)
end

function var_0_1.UpdateOathUI(arg_15_0)
	local var_15_0 = arg_15_0.skinCfg.hero

	if not OathDrawTools.CheckIsCanBuyOathSkin(var_15_0, arg_15_0.skinID) then
		arg_15_0.oathLimitDrawController_:SetSelectedState("false")
		arg_15_0.oathGiftController_:SetSelectedState("hide")

		return
	end

	if arg_15_0.skinID == ActivityOathDrawData:GetSkinID() then
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
