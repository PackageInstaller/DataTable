local var_0_0 = class("SkinDiscountGiftShopSkinItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.icon_.immediate = true
	arg_1_0.costTypeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "costType")
	arg_1_0.isLimitTimeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isLimitTime")
	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.levelController_ = ControllerUtil.GetController(arg_1_0.transform_, "level")
	arg_1_0.giftController_ = ControllerUtil.GetController(arg_1_0.transform_, "gift")
	arg_1_0.dlcController_ = ControllerUtil.GetController(arg_1_0.transform_, "dlc")
	arg_1_0.selectedController_ = arg_1_0.controllerEx_:GetController("selected")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.bgBtn_, nil, function()
		local var_4_0 = arg_3_0.skinGoodsID_
		local var_4_1 = arg_3_0.sceneGoodsID_
		local var_4_2 = SkinDiscountGiftTools.HasSkin(var_4_0)
		local var_4_3

		var_4_3 = var_4_1 == nil or var_4_1 and SkinDiscountGiftTools.HasScene(var_4_1)

		if var_4_2 then
			return
		end

		manager.notify:Invoke(SKIN_DISCOUNT_GIFT_SELECT_GOODS, var_4_0, var_4_1)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		return
	end

	arg_5_0.data_ = arg_5_1
	arg_5_0.shopCfg_ = getShopCfg(arg_5_1[1])
	arg_5_0.skinGoodsID_ = arg_5_0.shopCfg_.goods_id
	arg_5_0.sceneGoodsID_ = arg_5_1[2] and getShopCfg(arg_5_1[2]).goods_id

	local var_5_0 = RechargeShopDescriptionCfg[arg_5_0.shopCfg_.description].param[1]

	arg_5_0.skinCfg_ = SkinCfg[var_5_0]

	arg_5_0:UpdateView()
	arg_5_0:UpdateTimerView()
end

function var_0_0.UpdateTimerView(arg_6_0)
	local var_6_0 = arg_6_0.shopCfg_

	if #var_6_0.close_time > 0 then
		arg_6_0.isLimitTimeController_:SetSelectedState("true")

		arg_6_0.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(var_6_0.close_time)

		local var_6_1 = TimeMgr.GetInstance():GetServerTime()
		local var_6_2 = TimeMgr.GetInstance():parseTimeFromConfig(var_6_0.close_time)

		if var_6_2 <= var_6_1 then
			arg_6_0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")
		else
			arg_6_0.lastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(var_6_2))
		end
	else
		arg_6_0.isLimitTimeController_:SetSelectedState("false")

		arg_6_0.lastTimeLabel_.text = ""
	end

	if arg_6_0.sceneGoodsID_ then
		local var_6_3 = ShopTools.GetDiscount(arg_6_0.sceneGoodsID_)
		local var_6_4, var_6_5, var_6_6 = ShopTools.IsOnDiscountArea(arg_6_0.sceneGoodsID_)

		arg_6_0.giftController_:SetSelectedState(var_6_4 and var_6_6 and var_6_3 == 0 and "true" or "false")
	end

	arg_6_0:RefreshPriceUI(arg_6_0.skinGoodsID_, arg_6_0.sceneGoodsID_)
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.levelController_:SetSelectedState(tostring(arg_7_0.skinCfg_.skin_level))
	arg_7_0:RefreshCommonUI()
	arg_7_0:RefreshSelectState()
end

function var_0_0.RefreshCommonUI(arg_8_0)
	local var_8_0 = ItemCfg[arg_8_0.skinCfg_.hero]

	arg_8_0.nameLabel_.text = string.format("%s", arg_8_0.skinCfg_.name)
	arg_8_0.titleLabel_.text = ItemTools.getItemName(var_8_0.id)
	arg_8_0.icon_.spriteSync = "TextureConfig/Character/Icon/" .. arg_8_0.skinCfg_.picture_id

	local var_8_1

	if arg_8_0.sceneGoodsID_ then
		var_8_1 = ShopTools.GetSceneIdByDlcGoodsId(arg_8_0.sceneGoodsID_)
	end

	arg_8_0.dlcController_:SetSelectedState(tostring(var_8_1 ~= nil))

	if var_8_1 then
		arg_8_0.dlcImage_.sprite = ItemTools.getItemSprite(var_8_1)
	end
end

function var_0_0.RefreshPriceUI(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:UpdatePrice(arg_9_1, arg_9_2)

	local var_9_0 = SkinDiscountGiftTools.HasSkin(arg_9_1)
	local var_9_1

	var_9_1 = arg_9_2 == nil or arg_9_2 and SkinDiscountGiftTools.HasScene(arg_9_2)

	if var_9_0 then
		arg_9_0.statusController_:SetSelectedState("sellout")
	else
		arg_9_0.statusController_:SetSelectedState(arg_9_0.shopCfg_.give_back_list and #arg_9_0.shopCfg_.give_back_list > 0 and "back" or "normal")

		if arg_9_0.shopCfg_.give_back_list and #arg_9_0.shopCfg_.give_back_list > 0 then
			arg_9_0.rebackTxt_.text = arg_9_0.shopCfg_.give_back_list[1].num
			arg_9_0.rebackSkinIcon_.sprite = ItemTools.getItemSprite(arg_9_0.shopCfg_.give_back_list[1].id)
		end
	end
end

function var_0_0.UpdatePrice(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:SetCostIcon()
	arg_10_0:SetPriceText(arg_10_1, arg_10_2)
	arg_10_0.costTypeController_:SetSelectedState("currency")
	SetActive(arg_10_0.discountGo_, false)
end

function var_0_0.SetCostIcon(arg_11_0)
	local var_11_0 = arg_11_0.shopCfg_.cost_id

	if var_11_0 == 0 then
		var_11_0 = arg_11_0.shopCfg_.cheap_cost_id
	end

	arg_11_0.costIcon_.sprite = ItemTools.getItemLittleSprite(var_11_0)
end

function var_0_0.SetPriceText(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = 0
	local var_12_3 = 0
	local var_12_4 = SkinDiscountGiftTools.HasSkin(arg_12_1)
	local var_12_5 = arg_12_2 == nil or arg_12_2 and SkinDiscountGiftTools.HasScene(arg_12_2)

	if var_12_4 then
		var_12_0, var_12_1 = ShopTools.GetPrice(arg_12_1)

		if arg_12_2 then
			var_12_2, var_12_3 = ShopTools.GetPrice(arg_12_2)
			arg_12_0.priceText_.text = string.format("%s + %s", var_12_0, var_12_2)
		else
			arg_12_0.priceText_.text = var_12_0
		end

		return
	end

	if not var_12_4 then
		var_12_0, var_12_1 = ShopTools.GetPrice(arg_12_1)
	end

	if not var_12_5 then
		var_12_2, var_12_3 = ShopTools.GetPrice(arg_12_2)
		arg_12_0.priceText_.text = string.format("%s + %s", var_12_0, var_12_2)
		arg_12_0.oldPriceLabel_.text = string.format("(%s)", var_12_1 + var_12_3)
	else
		arg_12_0.priceText_.text = var_12_0
		arg_12_0.oldPriceLabel_.text = string.format("(%s)", var_12_1)
	end

	if var_12_0 + var_12_2 ~= var_12_1 + var_12_3 then
		SetActive(arg_12_0.limitDiscountGo_, arg_12_0.shopCfg_.is_limit_time_discount == 1)
		SetActive(arg_12_0.oldPriceLabel_.gameObject, true)
	else
		SetActive(arg_12_0.limitDiscountGo_, false)
		SetActive(arg_12_0.oldPriceLabel_.gameObject, false)
	end
end

function var_0_0.RefreshSelectState(arg_13_0)
	if SkinDiscountGiftTools.IsSelectSkinGoodsID(arg_13_0.skinGoodsID_) then
		arg_13_0.selectedController_:SetSelectedState("true")
	else
		arg_13_0.selectedController_:SetSelectedState("false")
	end
end

return var_0_0
