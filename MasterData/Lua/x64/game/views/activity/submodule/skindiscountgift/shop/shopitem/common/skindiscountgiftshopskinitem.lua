local SkinDiscountGiftShopSkinItem = class("SkinDiscountGiftShopSkinItem", ReduxView)

function SkinDiscountGiftShopSkinItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.icon_.immediate = true
	self.costTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "costType")
	self.isLimitTimeController_ = ControllerUtil.GetController(self.gameObject_.transform, "isLimitTime")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.levelController_ = ControllerUtil.GetController(self.transform_, "level")
	self.giftController_ = ControllerUtil.GetController(self.transform_, "gift")
	self.dlcController_ = ControllerUtil.GetController(self.transform_, "dlc")
	self.selectedController_ = self.controllerEx_:GetController("selected")
end

function SkinDiscountGiftShopSkinItem:Dispose()
	SkinDiscountGiftShopSkinItem.super.Dispose(self)
end

function SkinDiscountGiftShopSkinItem:AddListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		local var_4_0 = self.skinGoodsID_
		local var_4_1 = self.sceneGoodsID_
		local var_4_2 = SkinDiscountGiftTools.HasSkin(self.skinGoodsID_)
		local var_4_3 = self.sceneGoodsID_ == nil or var_4_1 and SkinDiscountGiftTools.HasScene(var_4_1)

		if var_4_2 then
			return
		end

		manager.notify:Invoke(SKIN_DISCOUNT_GIFT_SELECT_GOODS, var_4_0, var_4_1)
	end)
end

function SkinDiscountGiftShopSkinItem:SetData(arg_5_1)
	if arg_5_1 == nil then
		return
	end

	self.data_ = arg_5_1
	self.shopCfg_ = getShopCfg(arg_5_1[1])
	self.skinGoodsID_ = self.shopCfg_.goods_id
	self.sceneGoodsID_ = arg_5_1[2] and getShopCfg(arg_5_1[2]).goods_id
	self.skinCfg_ = SkinCfg[RechargeShopDescriptionCfg[self.shopCfg_.description].param[1]]

	self:UpdateView()
	self:UpdateTimerView()
end

function SkinDiscountGiftShopSkinItem:UpdateTimerView()
	if #self.shopCfg_.close_time > 0 then
		self.isLimitTimeController_:SetSelectedState("true")

		self.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg_.close_time)

		local var_6_0 = TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg_.close_time)

		self.lastTimeLabel_.text = var_6_0 <= TimeMgr.GetInstance():GetServerTime() and GetTips("TIP_EXPIRED") or string.format("%s", manager.time:GetLostTimeStr(var_6_0))
	else
		self.isLimitTimeController_:SetSelectedState("false")

		self.lastTimeLabel_.text = ""
	end

	if self.sceneGoodsID_ then
		local var_6_1 = ShopTools.GetDiscount(self.sceneGoodsID_)
		local var_6_2, var_6_3, var_6_4 = ShopTools.IsOnDiscountArea(self.sceneGoodsID_)

		self.giftController_:SetSelectedState(var_6_2 and var_6_4 and var_6_1 == 0 and "true" or "false")
	end

	self:RefreshPriceUI(self.skinGoodsID_, self.sceneGoodsID_)
end

function SkinDiscountGiftShopSkinItem:UpdateView()
	self.levelController_:SetSelectedState(tostring(self.skinCfg_.skin_level))
	self:RefreshCommonUI()
	self:RefreshSelectState()
end

function SkinDiscountGiftShopSkinItem:RefreshCommonUI()
	self.nameLabel_.text = string.format("%s", self.skinCfg_.name)
	self.titleLabel_.text = ItemTools.getItemName(ItemCfg[self.skinCfg_.hero].id)
	self.icon_.spriteSync = "TextureConfig/Character/Icon/" .. self.skinCfg_.picture_id

	local var_8_0

	if self.sceneGoodsID_ then
		var_8_0 = ShopTools.GetSceneIdByDlcGoodsId(self.sceneGoodsID_)
	end

	self.dlcController_:SetSelectedState(tostring(var_8_0 ~= nil))

	if var_8_0 then
		self.dlcImage_.sprite = ItemTools.getItemSprite(var_8_0)
	end
end

function SkinDiscountGiftShopSkinItem:RefreshPriceUI(arg_9_1, arg_9_2)
	self:UpdatePrice(arg_9_1, arg_9_2)

	local var_9_0 = SkinDiscountGiftTools.HasSkin(arg_9_1)
	local var_9_1 = arg_9_2 == nil or arg_9_2 and SkinDiscountGiftTools.HasScene(arg_9_2)

	if var_9_0 then
		self.statusController_:SetSelectedState("sellout")
	else
		self.statusController_:SetSelectedState(self.shopCfg_.give_back_list and #self.shopCfg_.give_back_list > 0 and "back" or "normal")

		if self.shopCfg_.give_back_list and #self.shopCfg_.give_back_list > 0 then
			self.rebackTxt_.text = self.shopCfg_.give_back_list[1].num
			self.rebackSkinIcon_.sprite = ItemTools.getItemSprite(self.shopCfg_.give_back_list[1].id)
		end
	end
end

function SkinDiscountGiftShopSkinItem:UpdatePrice(arg_10_1, arg_10_2)
	self:SetCostIcon()
	self:SetPriceText(arg_10_1, arg_10_2)
	self.costTypeController_:SetSelectedState("currency")
	SetActive(self.discountGo_, false)
end

function SkinDiscountGiftShopSkinItem:SetCostIcon()
	self.costIcon_.sprite = ItemTools.getItemLittleSprite((self.shopCfg_.cost_id == 0 or nil) and self.shopCfg_.cheap_cost_id)
end

function SkinDiscountGiftShopSkinItem:SetPriceText(arg_12_1, arg_12_2)
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
			self.priceText_.text = string.format("%s + %s", var_12_0, var_12_2)
		else
			self.priceText_.text = var_12_0
		end

		return
	end

	if not var_12_4 then
		var_12_0, var_12_1 = ShopTools.GetPrice(arg_12_1)
	end

	if not var_12_5 then
		var_12_2, var_12_3 = ShopTools.GetPrice(arg_12_2)
		self.priceText_.text = string.format("%s + %s", var_12_0, var_12_2)
		self.oldPriceLabel_.text = string.format("(%s)", var_12_1 + var_12_3)
	else
		self.priceText_.text = var_12_0
		self.oldPriceLabel_.text = string.format("(%s)", var_12_1)
	end

	if var_12_0 + var_12_2 ~= var_12_1 + var_12_3 then
		SetActive(self.limitDiscountGo_, self.shopCfg_.is_limit_time_discount == 1)
		SetActive(self.oldPriceLabel_.gameObject, true)
	else
		SetActive(self.limitDiscountGo_, false)
		SetActive(self.oldPriceLabel_.gameObject, false)
	end
end

function SkinDiscountGiftShopSkinItem:RefreshSelectState()
	if SkinDiscountGiftTools.IsSelectSkinGoodsID(self.skinGoodsID_) then
		self.selectedController_:SetSelectedState("true")
	else
		self.selectedController_:SetSelectedState("false")
	end
end

return SkinDiscountGiftShopSkinItem
