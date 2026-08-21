local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RechargeSkinDlcItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.dlcImg_.immediate = true
	arg_1_0.isLimitTimeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isLimitTime")
	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.btnController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "btn")
	arg_1_0.btn2Controller_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "btn2")
	arg_1_0.btn5Controller_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "btn5")
	arg_1_0.multiInfoController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "multiInfo")
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

	if ShopConst.SHOP_ID.DLC_SHOP ~= arg_6_0.shopCfg.shop_id and ShopConst.SHOP_ID.REPURCHASE_SHOP ~= arg_6_0.shopCfg.shop_id then
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

	if arg_6_0.callback_ then
		arg_6_0.callback_(arg_6_0.index_)
	end
end

function var_0_1.SetCallBack(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.callback_ = arg_8_1
	arg_8_0.index_ = arg_8_2
end

function var_0_1.SetOutOfDateHandler(arg_9_0, arg_9_1)
	arg_9_0.outOfDateHandler_ = arg_9_1
end

function var_0_1.SetData(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.shopCfg = getShopCfg(arg_10_1)
	arg_10_0.goodID = arg_10_1
	arg_10_0.skinGoodId = arg_10_3
	arg_10_0.shopID = arg_10_0.shopCfg.shop_id
	arg_10_0.skinId = arg_10_2
	arg_10_0.skinCfg = SkinCfg[arg_10_2]
	arg_10_0.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == arg_10_0.shopCfg.shop_id and ShopTools.CheckDlcPurchased(arg_10_1) == false
	arg_10_0.itemCfg = RechargeShopDescriptionCfg[arg_10_0.shopCfg.description]

	if arg_10_0.itemCfg == nil then
		arg_10_0.itemCfg = ItemCfg[arg_10_0.shopCfg.give_id]
	end

	arg_10_0:UpdateView()
	arg_10_0:UpdateTimerView()
end

function var_0_1.UpdateTimerView(arg_11_0)
	arg_11_0.isLimitTimeController_:SetSelectedState("false")
	arg_11_0:RefreshCommonUI()
	arg_11_0:RefreshPriceUI()
end

function var_0_1.UpdateView(arg_12_0)
	arg_12_0:RefreshPriceUI()
	arg_12_0:RefreshCommonUI()

	local var_12_0 = ItemCfg[arg_12_0.skinCfg.hero]
	local var_12_1 = ShopTools.HasMultiPay(arg_12_0.goodID)
	local var_12_2, var_12_3, var_12_4, var_12_5, var_12_6 = ShopTools.GetPrice(arg_12_0.goodID)

	arg_12_0.nameLabel_.text = string.format("%s", arg_12_0.itemCfg.name)
	arg_12_0.titleLabel_.text = ItemTools.getItemName(var_12_0.id)
	arg_12_0.dlcPriceTxt_.text = var_12_2
	arg_12_0.dlcImg_.spriteSync = "TextureConfig/Character/Icon/" .. arg_12_0.itemCfg.id
	arg_12_0.costIcon_.sprite = ItemTools.getItemSprite(arg_12_0.shopCfg.cost_id)

	if var_12_1 then
		arg_12_0.costIcon2_.sprite = ItemTools.getItemSprite(arg_12_0.shopCfg.cost_id_2)
		arg_12_0.dlcPrice2Txt_.text = var_12_5
	end

	if ShopTools.IsPC() then
		SetActive(arg_12_0.pcBtn_.gameObject, ShopTools.IsRMB(arg_12_0.goodID))
	end
end

function var_0_1.RefreshCommonUI(arg_13_0)
	SetActive(arg_13_0.discountGo_, false)
	SetActive(arg_13_0.limitGiveGo_, false)
	SetActive(arg_13_0.freeGiftGo_, false)
	SetActive(arg_13_0.superValueGo_, arg_13_0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE)

	local var_13_0, var_13_1, var_13_2 = ShopTools.IsOnDiscountArea(arg_13_0.goodID)
	local var_13_3 = ShopTools.GetDiscount(arg_13_0.goodID)

	if var_13_0 and var_13_2 and #arg_13_0.shopCfg.cheap_close_time > 0 then
		SetActive(arg_13_0.limitDiscountGo_, arg_13_0.shopCfg.is_limit_time_discount == 1)
	else
		SetActive(arg_13_0.limitDiscountGo_, false)
	end

	arg_13_0.btn2Controller_:SetSelectedState("false")

	if var_13_3 == 0 and var_13_0 and var_13_2 then
		SetActive(arg_13_0.limitDiscountGo_, false)
		SetActive(arg_13_0.limitGiveGo_, true)
		arg_13_0.btn2Controller_:SetSelectedState("true")
	end

	arg_13_0.btn2Controller_:SetSelectedState("false")

	if arg_13_0.shopCfg.cost == 0 then
		arg_13_0.btn2Controller_:SetSelectedState("true")
		arg_13_0.btn5Controller_:SetSelectedState("true")
		SetActive(arg_13_0.freeGiftGo_, true)
	else
		arg_13_0.btn5Controller_:SetSelectedState("false")
	end

	local var_13_4 = ShopTools.HasMultiPay(arg_13_0.goodID)

	if ShopTools.HaveSkin(arg_13_0.skinCfg.id) and HomeSceneSettingData:GetUsedState(arg_13_0.itemCfg.id) ~= SceneConst.HOME_SCENE_TYPE.UNLOCK then
		arg_13_0.btnController_:SetSelectedState("true")

		if var_13_4 then
			arg_13_0.multiInfoController_:SetSelectedState("true")
		else
			arg_13_0.multiInfoController_:SetSelectedState("false")
		end
	elseif var_13_4 then
		arg_13_0.btnController_:SetSelectedState("multiPay")
	else
		arg_13_0.btnController_:SetSelectedState("false")
	end
end

function var_0_1.RefreshPriceUI(arg_14_0, arg_14_1)
	if ShopConst.SHOP_ID.DLC_SHOP == arg_14_0.shopCfg.shop_id and ShopTools.CheckDlcPurchased(arg_14_0.goodID) == false then
		arg_14_0.statusController_:SetSelectedState(arg_14_0.shopCfg.give_back_list and #arg_14_0.shopCfg.give_back_list > 0 and "back" or "normal")
	elseif ShopTools.CheckDlcPurchased(arg_14_0.goodID) == false then
		arg_14_0.statusController_:SetSelectedState("normal")
	else
		arg_14_0.statusController_:SetSelectedState("sellout")
	end

	if arg_14_0.shopCfg.give_back_list and #arg_14_0.shopCfg.give_back_list > 0 then
		arg_14_0.rebackTxt_.text = arg_14_0.shopCfg.give_back_list[1].num
	end
end

function var_0_1.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

return var_0_1
