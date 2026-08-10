local var_0_0 = class("SkinDiscountGiftShopDLCItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.dlcImg_.immediate = true
	arg_1_0.isLimitTimeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "isLimitTime")
	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")
	arg_1_0.btnController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "btn")
	arg_1_0.btn2Controller_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "btn2")
	arg_1_0.selectedController_ = arg_1_0.controllerEx_:GetController("selected")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.bgBtn_, nil, function()
		manager.notify:Invoke(SKIN_DISCOUNT_FIGT_SELECT_SCENE, arg_3_0.data_[1])
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		return
	end

	arg_5_0.data_ = arg_5_1
	arg_5_0.sceneGoodsID_ = arg_5_1[2]
	arg_5_0.shopCfg_ = getShopCfg(arg_5_0.sceneGoodsID_)

	arg_5_0:UpdateView()
	arg_5_0:UpdateTimerView()
end

function var_0_0.UpdateTimerView(arg_6_0)
	arg_6_0.isLimitTimeController_:SetSelectedState("false")
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0:RefreshPriceUI()
	arg_7_0:RefreshCommonUI()
	arg_7_0:RefreshSelectState()

	local var_7_0 = RechargeShopDescriptionCfg[arg_7_0.shopCfg_.description]

	if var_7_0 == nil then
		return
	end

	local var_7_1 = getShopCfg(arg_7_0.data_[1])
	local var_7_2 = RechargeShopDescriptionCfg[var_7_1.description].param[1]
	local var_7_3 = SkinCfg[var_7_2]
	local var_7_4 = ItemCfg[var_7_3.hero]

	arg_7_0.nameLabel_.text = string.format("%s", var_7_0.name)
	arg_7_0.titleLabel_.text = ItemTools.getItemName(var_7_4.id)
	arg_7_0.dlcPriceTxt_.text = ShopTools.GetPrice(arg_7_0.sceneGoodsID_)
	arg_7_0.dlcImg_.spriteSync = "TextureConfig/Character/Icon/" .. var_7_0.id
	arg_7_0.costIcon_.sprite = ItemTools.getItemSprite(arg_7_0.shopCfg_.cost_id)
end

function var_0_0.RefreshCommonUI(arg_8_0)
	SetActive(arg_8_0.discountGo_, false)
	SetActive(arg_8_0.limitGiveGo_, false)
	SetActive(arg_8_0.freeGiftGo_, false)
	SetActive(arg_8_0.superValueGo_, arg_8_0.shopCfg_.tag == ShopConst.TAGS.SUPER_VALUE)

	local var_8_0, var_8_1, var_8_2 = ShopTools.IsOnDiscountArea(arg_8_0.sceneGoodsID_)
	local var_8_3 = ShopTools.GetDiscount(arg_8_0.sceneGoodsID_)

	if var_8_0 and var_8_2 and #arg_8_0.shopCfg_.cheap_close_time > 0 then
		SetActive(arg_8_0.limitDiscountGo_, arg_8_0.shopCfg_.is_limit_time_discount == 1)
	else
		SetActive(arg_8_0.limitDiscountGo_, false)
	end

	arg_8_0.btn2Controller_:SetSelectedState("false")

	if var_8_3 == 0 and var_8_0 and var_8_2 then
		SetActive(arg_8_0.limitDiscountGo_, false)
		SetActive(arg_8_0.limitGiveGo_, true)
		arg_8_0.btn2Controller_:SetSelectedState("true")
	end

	if arg_8_0.shopCfg_.cost == 0 then
		SetActive(arg_8_0.freeGiftGo_, true)
	end

	arg_8_0.btnController_:SetSelectedState("false")
end

function var_0_0.RefreshPriceUI(arg_9_0)
	if SkinDiscountGiftTools.HasScene(arg_9_0.sceneGoodsID_) then
		arg_9_0.statusController_:SetSelectedState("sellout")
	else
		arg_9_0.statusController_:SetSelectedState(arg_9_0.shopCfg_.give_back_list and #arg_9_0.shopCfg_.give_back_list > 0 and "back" or "normal")
	end

	if arg_9_0.shopCfg_.give_back_list and #arg_9_0.shopCfg_.give_back_list > 0 then
		arg_9_0.rebackTxt_.text = arg_9_0.shopCfg_.give_back_list[1].num
		arg_9_0.rebackSkinIcon_.sprite = ItemTools.getItemSprite(arg_9_0.shopCfg_.give_back_list[1].id)
	end
end

function var_0_0.RefreshSelectState(arg_10_0)
	if SkinDiscountGiftTools.IsSelectSceneGoodsID(arg_10_0.sceneGoodsID_) then
		arg_10_0.selectedController_:SetSelectedState("true")
	else
		arg_10_0.selectedController_:SetSelectedState("false")
	end
end

return var_0_0
