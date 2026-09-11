local SkinDiscountGiftShopDLCItem = class("SkinDiscountGiftShopDLCItem", ReduxView)

function SkinDiscountGiftShopDLCItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.dlcImg_.immediate = true
	self.isLimitTimeController_ = ControllerUtil.GetController(self.gameObject_.transform, "isLimitTime")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.btnController_ = ControllerUtil.GetController(self.gameObject_.transform, "btn")
	self.btn2Controller_ = ControllerUtil.GetController(self.gameObject_.transform, "btn2")
	self.selectedController_ = self.controllerEx_:GetController("selected")
end

function SkinDiscountGiftShopDLCItem:Dispose()
	SkinDiscountGiftShopDLCItem.super.Dispose(self)
end

function SkinDiscountGiftShopDLCItem:AddListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		manager.notify:Invoke(SKIN_DISCOUNT_FIGT_SELECT_SCENE, self.data_[1])
	end)
end

function SkinDiscountGiftShopDLCItem:SetData(arg_5_1)
	if arg_5_1 == nil then
		return
	end

	self.data_ = arg_5_1
	self.sceneGoodsID_ = arg_5_1[2]
	self.shopCfg_ = getShopCfg(self.sceneGoodsID_)

	self:UpdateView()
	self:UpdateTimerView()
end

function SkinDiscountGiftShopDLCItem:UpdateTimerView()
	self.isLimitTimeController_:SetSelectedState("false")
end

function SkinDiscountGiftShopDLCItem:UpdateView()
	self:RefreshPriceUI()
	self:RefreshCommonUI()
	self:RefreshSelectState()

	if RechargeShopDescriptionCfg[self.shopCfg_.description] == nil then
		return
	end

	local var_7_0 = ItemCfg[SkinCfg[RechargeShopDescriptionCfg[getShopCfg(self.data_[1]).description].param[1]].hero]

	self.nameLabel_.text = string.format("%s", RechargeShopDescriptionCfg[self.shopCfg_.description].name)
	self.titleLabel_.text = ItemTools.getItemName(var_7_0.id)
	self.dlcPriceTxt_.text = ShopTools.GetPrice(self.sceneGoodsID_)
	self.dlcImg_.spriteSync = "TextureConfig/Character/Icon/" .. RechargeShopDescriptionCfg[self.shopCfg_.description].id
	self.costIcon_.sprite = ItemTools.getItemSprite(self.shopCfg_.cost_id)
end

function SkinDiscountGiftShopDLCItem:RefreshCommonUI()
	SetActive(self.discountGo_, false)
	SetActive(self.limitGiveGo_, false)
	SetActive(self.freeGiftGo_, false)
	SetActive(self.superValueGo_, self.shopCfg_.tag == ShopConst.TAGS.SUPER_VALUE)

	local var_8_0, var_8_1, var_8_2 = ShopTools.IsOnDiscountArea(self.sceneGoodsID_)
	local var_8_3 = ShopTools.GetDiscount(self.sceneGoodsID_)

	if var_8_0 and var_8_2 and #self.shopCfg_.cheap_close_time > 0 then
		SetActive(self.limitDiscountGo_, self.shopCfg_.is_limit_time_discount == 1)
	else
		SetActive(self.limitDiscountGo_, false)
	end

	self.btn2Controller_:SetSelectedState("false")

	if var_8_3 == 0 and var_8_0 and var_8_2 then
		SetActive(self.limitDiscountGo_, false)
		SetActive(self.limitGiveGo_, true)
		self.btn2Controller_:SetSelectedState("true")
	end

	if self.shopCfg_.cost == 0 then
		SetActive(self.freeGiftGo_, true)
	end

	self.btnController_:SetSelectedState("false")
end

function SkinDiscountGiftShopDLCItem:RefreshPriceUI()
	if SkinDiscountGiftTools.HasScene(self.sceneGoodsID_) then
		self.statusController_:SetSelectedState("sellout")
	else
		self.statusController_:SetSelectedState(self.shopCfg_.give_back_list and #self.shopCfg_.give_back_list > 0 and "back" or "normal")
	end

	if self.shopCfg_.give_back_list and #self.shopCfg_.give_back_list > 0 then
		self.rebackTxt_.text = self.shopCfg_.give_back_list[1].num
		self.rebackSkinIcon_.sprite = ItemTools.getItemSprite(self.shopCfg_.give_back_list[1].id)
	end
end

function SkinDiscountGiftShopDLCItem:RefreshSelectState()
	if SkinDiscountGiftTools.IsSelectSceneGoodsID(self.sceneGoodsID_) then
		self.selectedController_:SetSelectedState("true")
	else
		self.selectedController_:SetSelectedState("false")
	end
end

return SkinDiscountGiftShopDLCItem
