local RechargeSkinListDlcItem = class("RechargeSkinListDlcItem", (import("game.views.shop.base.ShopItemBase")))

function RechargeSkinListDlcItem:InitUI()
	self:BindCfgUI()

	self.isLimitTimeController_ = ControllerUtil.GetController(self.gameObject_.transform, "isLimitTime")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.giftController_ = ControllerUtil.GetController(self.gameObject_.transform, "gift")
	self.costTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "costType")
	self.oathLimitDrawController_ = self.controller_:GetController("Oath")
	self.oathGiftController_ = self.controller_:GetController("OathGift")
end

function RechargeSkinListDlcItem:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		local var_3_0 = SkinDiscountGiftTools.HasDiscountGoodsID(self.goodID)

		if var_3_0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_SKIN_DISCOUNT_HIGH_COST_EFFECTIVENESS_TIPS_1"),
				OkCallback = function()
					OperationRecorder.RecordButtonTouch({
						button_name = string.format("message_push_activity_%s_enter", var_3_0),
						source = SkinDiscountGiftConst.EXIST_GIFT_AND_JUMP_TIPS
					})
					SkinDiscountGiftAction.JumpToSkinDiscountGiftWindow(self.goodID)
				end,
				CancelCallback = function()
					OperationRecorder.RecordButtonTouch({
						button_name = string.format("message_push_activity_%s_close", var_3_0),
						source = SkinDiscountGiftConst.EXIST_GIFT_AND_JUMP_TIPS
					})
					self:OnClickItem()
				end
			})
		else
			self:OnClickItem()
		end
	end)
end

function RechargeSkinListDlcItem:OnClickItem()
	SendMessageManagerToSDK("purchase_click_skin")
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_skin = self.skinCfg.id
	})

	if ShopConst.SHOP_ID.DLC_SHOP ~= self.shopCfg.shop_id then
		if ShopTools.HaveSkin(self.skinId) then
			ShowMessageBox({
				content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(self.shopCfg.give_id)),
				OkCallback = function()
					JumpTools.GoToSystem("/shop", {
						shopId = self.shopID,
						goodId = self.goodID
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			})

			return
		end

		self:Go("/heroSkinPreview", {
			isShop = true,
			isDlc = true,
			heroID = self.skinCfg.hero,
			skinID = self.skinCfg.id,
			shopID = self.shopID
		})
		OperationRecorder.RecordButtonTouch("buy_skin_button_" .. self.goodID)
	else
		self:Go("/heroSkinPreview", {
			isShop = true,
			isDlc = true,
			heroID = self.skinCfg.hero,
			skinID = self.skinCfg.id,
			shopID = self.shopID
		})
		OperationRecorder.RecordButtonTouch("buy_skin_button_" .. self.goodID)
	end
end

function RechargeSkinListDlcItem:SetOutOfDateHandler(arg_8_1)
	self.outOfDateHandler_ = arg_8_1
end

function RechargeSkinListDlcItem:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.shopCfg = getShopCfg(arg_9_1)
	self.goodID = arg_9_1
	self.skinGoodId = arg_9_3
	self.shopID = self.shopCfg.shop_id
	self.skinId = arg_9_2
	self.skinCfg = SkinCfg[arg_9_2]
	self.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == self.shopCfg.shop_id and ShopTools.CheckDlcPurchased(arg_9_1) == false
	self.itemCfg = RechargeShopDescriptionCfg[self.shopCfg.description]

	if self.itemCfg == nil then
		self.itemCfg = ItemCfg[self.shopCfg.give_id]
	end

	self:UpdateView()
	self:UpdateTimerView()
end

function RechargeSkinListDlcItem:UpdateTimerView()
	self.isLimitTimeController_:SetSelectedState("false")
	self:RefreshCommonUI()
	self:RefreshPriceUI()
end

function RechargeSkinListDlcItem:UpdateView()
	self:RefreshPriceUI()
	self:RefreshCommonUI()

	self.nameLabel_.text = string.format("%s", self.itemCfg.name)
	self.titleLabel_.text = ItemTools.getItemName(ItemCfg[self.skinCfg.hero].id)

	local var_11_0 = ""

	if ShopTools.HaveSkin(self.skinId) or self.shopID == ShopConst.SHOP_ID.PASSPORT_SHOP then
		var_11_0, oriPrice, _, price2, oriPrice2 = ShopTools.GetPrice(self.goodID)
	else
		var_11_0 = ShopTools.GetPrice(self.skinGoodId) .. " + " .. ShopTools.GetPrice(self.goodID)
	end

	self.priceText_.text = var_11_0
	self.icon_.spriteSync = "TextureConfig/Character/Icon/" .. self.itemCfg.id
	self.costIcon_.sprite = ItemTools.getItemSprite(self.shopCfg.cost_id)

	if ShopTools.IsPC() then
		SetActive(self.pcBtn_.gameObject, ShopTools.IsRMB(self.goodID))
	end

	if ShopTools.HasMultiPay(self.goodID) then
		self.giftController_:SetSelectedState("multiPay")

		if ShopTools.HaveSkin(self.skinCfg.id) then
			self.costTypeController_:SetSelectedState("DualCurrencies")
		else
			self.costTypeController_:SetSelectedState("currency")
		end

		self.costIcon2_.sprite = ItemTools.getItemSprite(self.shopCfg.cost_id_2)
		self.priceText2_.text = price2
	else
		self.giftController_:SetSelectedState("false")
		self.costTypeController_:SetSelectedState("currency")
	end

	self:UpdateOathUI()
end

function RechargeSkinListDlcItem:RefreshCommonUI()
	SetActive(self.discountGo_, false)
	SetActive(self.limitGiveGo_, false)
	SetActive(self.freeGiftGo_, false)
	SetActive(self.superValueGo_, self.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE)

	local var_12_0, var_12_1, var_12_2 = ShopTools.IsOnDiscountArea(self.goodID)
	local var_12_3 = ShopTools.GetDiscount(self.goodID)

	if var_12_0 and var_12_2 and #self.shopCfg.cheap_close_time > 0 then
		SetActive(self.limitDiscountGo_, self.shopCfg.is_limit_time_discount == 1)
	else
		SetActive(self.limitDiscountGo_, false)
	end

	if self.shopCfg.cost == 0 then
		SetActive(self.freeGiftGo_, true)
	end
end

function RechargeSkinListDlcItem:RefreshPriceUI(arg_13_1)
	if ShopConst.SHOP_ID.DLC_SHOP == self.shopCfg.shop_id and ShopTools.CheckDlcPurchased(self.goodID) == false then
		self.statusController_:SetSelectedState(self.shopCfg.give_back_list and #self.shopCfg.give_back_list > 0 and "back" or "normal")
	elseif ShopTools.CheckDlcPurchased(self.goodID) == false then
		self.statusController_:SetSelectedState("normal")
	else
		self.statusController_:SetSelectedState("sellout")
	end

	if self.shopCfg.give_back_list and #self.shopCfg.give_back_list > 0 then
		self.rebackTxt_.text = self.shopCfg.give_back_list[1].num
	end
end

function RechargeSkinListDlcItem:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

function RechargeSkinListDlcItem:UpdateOathUI()
	if not OathDrawTools.CheckIsCanBuyOathSkin(self.skinCfg.hero, self.skinId) then
		self.oathLimitDrawController_:SetSelectedState("false")
		self.oathGiftController_:SetSelectedState("hide")

		return
	end

	if self.skinId == ActivityOathDrawData:GetSkinID() then
		self.oathLimitDrawController_:SetSelectedState("true")
	else
		self.oathLimitDrawController_:SetSelectedState("false")
	end

	if not ShopTools.HaveSkin(self.skinCfg.id) then
		self.oathGiftController_:SetSelectedState("show")

		self.oathGiftImg_.sprite = ItemTools.getItemSprite(OathDrawTools.GetCouponID())
	else
		self.oathGiftController_:SetSelectedState("hide")
	end
end

return RechargeSkinListDlcItem
