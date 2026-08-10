local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RechargeSkinItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.isOnDiscountAreaController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isOnDiscountArea")
	arg_1_0.isDiscountController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isDiscount")
	arg_1_0.costTypeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "costType")
	arg_1_0.tipController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "tip")
	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.isLimitTimeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isLimitTime")
	arg_1_0.dlcController_ = ControllerUtil.GetController(arg_1_0.transform_, "dlc")
	arg_1_0.levelController_ = ControllerUtil.GetController(arg_1_0.transform_, "level")
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.bgBtn_, nil, function()
		SendMessageManagerToSDK("purchase_click_skin")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin = arg_2_0.skinCfg.id
		})
		arg_2_0:Go("/heroSkinPreview", {
			isShop = true,
			heroID = arg_2_0.skinCfg.hero,
			skinID = arg_2_0.skinCfg.id,
			goodId = arg_2_0.goodID,
			shopID = arg_2_0.shopID
		})
		OperationRecorder.RecordButtonTouch("buy_skin_button_" .. arg_2_0.skinCfg.id)
	end)
	arg_2_0:AddBtnListener(arg_2_0.bottomBtn_, nil, function()
		SendMessageManagerToSDK("purchase_click_skin")

		if arg_2_0.canBuyDlc then
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				goodID = arg_2_0.goodID,
				heroID = arg_2_0.skinCfg.hero,
				skinID = arg_2_0.skinCfg.id,
				shopID = arg_2_0.shopID
			}, ViewConst.SYSTEM_ID.SHOP)
		else
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				goodID = arg_2_0.goodID,
				heroID = arg_2_0.skinCfg.hero,
				skinID = arg_2_0.skinCfg.id,
				shopID = arg_2_0.shopID
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	end)
	arg_2_0:AddBtnListener(nil, arg_2_0.jumpBtn_, function()
		if arg_2_0.canBuyDlc == false then
			local var_5_0 = getShopCfg(arg_2_0.dlcID)

			JumpTools.GoToSystem("/shop", {
				shopId = var_5_0.shop_id
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.pcBtn_, nil, function()
		ShowTips("PC_SHOP_TIPS2")
	end)
end

function var_0_1.SetOutOfDateHandler(arg_7_0, arg_7_1)
	arg_7_0.outOfDateHandler_ = arg_7_1
end

function var_0_1.UpdateTimerView(arg_8_0)
	local var_8_0 = arg_8_0.shopCfg

	if arg_8_0.haveDlc and (ShopTools.HaveSkin(arg_8_0.skinCfg.id) or HeroTools.CanChangeSkin(arg_8_0.skinCfg.id)) then
		var_8_0 = arg_8_0.shopDlcCfg
	end

	if #var_8_0.close_time > 0 then
		arg_8_0.isLimitTimeController_:SetSelectedState("true")

		arg_8_0.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(var_8_0.close_time)

		local var_8_1 = TimeMgr.GetInstance():GetServerTime()
		local var_8_2 = TimeMgr.GetInstance():parseTimeFromConfig(var_8_0.close_time)

		if var_8_2 <= var_8_1 then
			arg_8_0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if arg_8_0.outOfDateHandler_ ~= nil then
				arg_8_0.outOfDateHandler_(var_8_0.goods_id)
			end
		else
			arg_8_0.lastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(var_8_2))
		end
	else
		arg_8_0.isLimitTimeController_:SetSelectedState("false")

		arg_8_0.lastTimeLabel_.text = ""
	end

	local var_8_3, var_8_4, var_8_5 = ShopTools.IsOnDiscountArea(var_8_0.goods_id)

	if var_8_4 and var_8_5 and var_8_3 then
		arg_8_0.isOnDiscountAreaController_:SetSelectedState("true")

		local var_8_6 = TimeMgr.GetInstance():GetServerTime()
		local var_8_7 = TimeMgr.GetInstance():parseTimeFromConfig(var_8_0.cheap_close_time)

		if var_8_7 <= var_8_6 then
			arg_8_0.discountLastTimeLabel_.text = "0" .. GetTips("SECOND")
		else
			arg_8_0.discountLastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(var_8_7))
		end
	else
		arg_8_0.isOnDiscountAreaController_:SetSelectedState("false")

		arg_8_0.discountLastTimeLabel_.text = ""
	end
end

function var_0_1.UpdateView(arg_9_0)
	arg_9_0.levelController_:SetSelectedState(tostring(arg_9_0.skinCfg.skin_level))

	if ShopTools.HaveSkin(arg_9_0.skinCfg.id) or HeroTools.CanChangeSkin(arg_9_0.skinCfg.id) then
		if arg_9_0.haveDlc and not ShopTools.CheckDlcPurchased(arg_9_0.dlcID) then
			arg_9_0.statusController_:SetSelectedState("normal")

			arg_9_0.bgBtn_.interactable = true
			arg_9_0.bottomBtn_.interactable = true

			arg_9_0:RefreshDlcUI()
		else
			arg_9_0.statusController_:SetSelectedState("sellout")

			arg_9_0.bgBtn_.interactable = false
			arg_9_0.bottomBtn_.interactable = false

			arg_9_0:RefreshCommonUI()
		end
	else
		arg_9_0.statusController_:SetSelectedState("normal")

		arg_9_0.bgBtn_.interactable = true
		arg_9_0.bottomBtn_.interactable = true

		arg_9_0:RefreshCommonUI()
	end

	arg_9_0.dlcController_:SetSelectedIndex(arg_9_0.haveDlc and 1 or 0)

	if arg_9_0.haveDlc then
		arg_9_0.dlcImg_.sprite = ItemTools.getItemSprite(arg_9_0.itemDlcCfg.id)
	end

	arg_9_0:UpdateSkinPrice()

	if ShopTools.IsPC() then
		SetActive(arg_9_0.pcBtn_.gameObject, ShopTools.IsRMB(arg_9_0.goodID))
		SetActive(arg_9_0.bottomGo_, ShopTools.IsRMB(arg_9_0.goodID) == false)
	end
end

function var_0_1.RefreshCommonUI(arg_10_0)
	local var_10_0 = ItemCfg[arg_10_0.skinCfg.hero]

	arg_10_0.nameLabel_.text = string.format("%s", arg_10_0.skinCfg.name)
	arg_10_0.titleLabel_.text = ItemTools.getItemName(var_10_0.id)
	arg_10_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_10_0.skinCfg.picture_id)

	local var_10_1, var_10_2, var_10_3 = ShopTools.IsOnDiscountArea(arg_10_0.goodID)

	if var_10_1 and var_10_3 then
		arg_10_0.tipController_:SetSelectedState(var_10_2 and "time_limit_discount" or "discount")
	else
		arg_10_0.tipController_:SetSelectedState(arg_10_0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE and "superValue" or "none")
	end
end

function var_0_1.RefreshDlcUI(arg_11_0)
	arg_11_0.nameLabel_.text = GetI18NText(arg_11_0.itemCfg.name)
	arg_11_0.titleLabel_.text = ""

	if arg_11_0.itemCfg and ItemConst.ITEM_TYPE.SCENE == arg_11_0.itemCfg.type then
		arg_11_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_11_0.itemCfg.param[1])
	else
		arg_11_0.icon_.sprite = nil
	end

	local var_11_0, var_11_1, var_11_2 = ShopTools.IsOnDiscountArea(arg_11_0.dlcID)

	if var_11_0 and var_11_2 then
		arg_11_0.tipController_:SetSelectedState(var_11_1 and "time_limit_discount" or "discount")
	else
		arg_11_0.tipController_:SetSelectedState(arg_11_0.shopDlcCfg.tag == ShopConst.TAGS.SUPER_VALUE and "superValue" or "none")
	end
end

function var_0_1.UpdateSkinPrice(arg_12_0)
	if ShopTools.HaveSkin(arg_12_0.skinCfg.id) or HeroTools.CanChangeSkin(arg_12_0.skinCfg.id) then
		if arg_12_0.haveDlc and not ShopTools.CheckDlcPurchased(arg_12_0.dlcID) then
			if arg_12_0.canBuyDlc then
				arg_12_0:RefreshPriceUI(arg_12_0.dlcID)
			else
				SetActive(arg_12_0.rebackSkinIcon_.gameObject, #arg_12_0.shopDlcCfg.give_back_list > 0)
				arg_12_0.costTypeController_:SetSelectedState("jump")
			end
		else
			arg_12_0:RefreshPriceUI(arg_12_0.goodID)
		end
	else
		arg_12_0:RefreshPriceUI(arg_12_0.goodID)
	end
end

function var_0_1.RefreshPriceUI(arg_13_0, arg_13_1)
	arg_13_0:UpdatePrice(arg_13_1)

	local var_13_0 = getShopCfg(arg_13_1)

	SetActive(arg_13_0.rebackSkinIcon_.gameObject, #var_13_0.give_back_list > 0)
end

function var_0_1.IsOnDiscountArea(arg_14_0, arg_14_1)
	local var_14_0 = getShopCfg(arg_14_1)
	local var_14_1, var_14_2, var_14_3 = ShopTools.IsOnDiscountArea(var_14_0.goods_id)

	if var_14_1 and var_14_3 then
		return true
	else
		return false
	end
end

return var_0_1
