local RechargeSkinNewItem = class("RechargeSkinNewItem", (import("game.views.shop.base.ShopItemBase")))

function RechargeSkinNewItem:InitUI()
	self:BindCfgUI()

	self.icon_.immediate = true
	self.costTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "costType")
	self.isLimitTimeController_ = ControllerUtil.GetController(self.gameObject_.transform, "isLimitTime")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.levelController_ = ControllerUtil.GetController(self.transform_, "level")
	self.giftController_ = ControllerUtil.GetController(self.transform_, "gift")
	self.dlcController_ = ControllerUtil.GetController(self.transform_, "dlc")
	self.oathLimitDrawController_ = self.controller_:GetController("Oath")
	self.oathGiftController_ = self.controller_:GetController("OathGift")
end

function RechargeSkinNewItem:AddUIListener()
	local function var_2_0()
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
	end

	self:AddBtnListener(self.bgBtn_, nil, var_2_0)
	self:AddBtnListener(self.bottomBtn_, nil, var_2_0)
	self:AddBtnListener(self.pcBtn_, nil, function()
		ShowTips("PC_SHOP_TIPS2")
	end)
end

function RechargeSkinNewItem:OnClickItem()
	SendMessageManagerToSDK("purchase_click_skin")
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_skin = self.skinCfg.id
	})
	self:Go("/heroSkinPreview", {
		isShop = true,
		heroID = self.skinCfg.hero,
		skinID = self.skinCfg.id,
		goodId = self.goodID,
		shopID = self.shopID
	})
	OperationRecorder.RecordButtonTouch("buy_skin_button_" .. self.skinCfg.id)

	if self.callback_ then
		self.callback_(self.index_)
	end
end

function RechargeSkinNewItem:SetOutOfDateHandler(arg_8_1)
	self.outOfDateHandler_ = arg_8_1
end

function RechargeSkinNewItem:SetCallBack(arg_9_1, arg_9_2)
	self.callback_ = arg_9_1
	self.index_ = arg_9_2
end

function RechargeSkinNewItem:UpdateTimerView()
	if #self.shopCfg.close_time > 0 then
		self.isLimitTimeController_:SetSelectedState("true")

		self.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg.close_time)

		local var_10_0 = TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg.close_time)

		if var_10_0 <= TimeMgr.GetInstance():GetServerTime() then
			self.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if self.outOfDateHandler_ ~= nil then
				self.outOfDateHandler_(self.shopCfg.goods_id)
			end
		else
			self.lastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(var_10_0))
		end
	else
		self.isLimitTimeController_:SetSelectedState("false")

		self.lastTimeLabel_.text = ""
	end

	if self.dlcID ~= 0 then
		local var_10_1 = ShopTools.GetDiscount(self.dlcID)
		local var_10_2, var_10_3, var_10_4 = ShopTools.IsOnDiscountArea(self.dlcID)

		self.giftController_:SetSelectedState((var_10_2 and var_10_4 and var_10_1 == 0 or ShopTools.HasMultiPay(self.dlcID)) and "multiPay" or "false")
	end

	self:RefreshPriceUI(self.goodID)
end

function RechargeSkinNewItem:UpdateView()
	self.levelController_:SetSelectedState(tostring(self.skinCfg.skin_level))

	self.bgBtn_.interactable = not (ShopTools.HaveSkin(self.skinCfg.id) or HeroTools.CanChangeSkin(self.skinCfg.id))

	self:RefreshCommonUI()
	self:RefreshPriceUI(self.goodID)
	self:UpdateOathUI()
end

function RechargeSkinNewItem:RefreshCommonUI()
	self.nameLabel_.text = string.format("%s", self.skinCfg.name)
	self.titleLabel_.text = ItemTools.getItemName(ItemCfg[self.skinCfg.hero].id)
	self.icon_.spriteSync = "TextureConfig/Character/Icon/" .. self.skinCfg.picture_id
	self.soldTxt_.text = self.goodID < 0 and GetTips("ALREADY_GET") or GetTips("SELL_OUT")
end

function RechargeSkinNewItem:RefreshPriceUI(arg_13_1)
	self:UpdatePrice(arg_13_1)

	if ShopTools.HaveSkin(self.skinCfg.id) or HeroTools.CanChangeSkin(self.skinCfg.id) then
		self.statusController_:SetSelectedState("sellout")
	else
		self.statusController_:SetSelectedState(self.shopCfg.give_back_list and #self.shopCfg.give_back_list > 0 and "back" or "normal")
	end

	if self.shopCfg.give_back_list and #self.shopCfg.give_back_list > 0 then
		self.rebackTxt_.text = self.shopCfg.give_back_list[1].num
		self.rebackSkinIcon_.sprite = ItemTools.getItemSprite(self.shopCfg.give_back_list[1].id)
	end
end

function RechargeSkinNewItem:UpdatePrice(arg_14_1)
	local var_14_0 = getShopCfg(arg_14_1)
	local var_14_1, var_14_2, var_14_3 = ShopTools.GetPrice(arg_14_1)

	self.moneyTxt_.text = ShopTools.GetMoneySymbol(arg_14_1)

	if var_14_1 <= 0 then
		self.costTypeController_:SetSelectedState("free")
	else
		if ShopTools.IsRMB(arg_14_1) then
			self.priceText_.text = var_14_1

			if ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
				self.priceText_.text = GetTips("PC_SHOP_TIPS3")
			end
		else
			self:SetCostIcon()
			self:SetPriceText(arg_14_1)
		end

		self.costTypeController_:SetSelectedState(ShopTools.IsRMB(arg_14_1) and "money" or "currency")
	end

	if self.goodID < 0 then
		self.costTypeController_:SetSelectedState("Events")
	end

	SetActive(self.superValueGo_, var_14_0.tag == ShopConst.TAGS.SUPER_VALUE)

	self.oldPriceLabel_.text = var_14_2

	local var_14_4, var_14_5, var_14_6 = ShopTools.IsOnDiscountArea(self.goodID)

	if var_14_4 and var_14_6 then
		SetActive(self.limitDiscountGo_, self.shopCfg.is_limit_time_discount == 1)
		SetActive(self.oldPriceLabel_.gameObject, var_14_1 ~= var_14_2 and var_14_5 and ShopTools.IsPC() == false)
	else
		SetActive(self.limitDiscountGo_, false)
		SetActive(self.oldPriceLabel_.gameObject, false)
	end

	if ShopTools.IsRMB(arg_14_1) and ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		self.priceText_.text = GetTips("PC_SHOP_TIPS3")
		self.moneyTxt_.text = ""
	end

	SetActive(self.discountGo_, false)
end

function RechargeSkinNewItem:UpdateOathUI()
	if not OathDrawTools.CheckIsCanBuyOathSkin(self.skinCfg.hero, self.skinID) then
		self.oathLimitDrawController_:SetSelectedState("false")
		self.oathGiftController_:SetSelectedState("hide")

		return
	end

	if self.skinID == ActivityOathDrawData:GetSkinID() then
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

return RechargeSkinNewItem
