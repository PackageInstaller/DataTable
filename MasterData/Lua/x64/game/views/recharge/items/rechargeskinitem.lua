local RechargeSkinItem = class("RechargeSkinItem", (import("game.views.shop.base.ShopItemBase")))

function RechargeSkinItem:InitUI()
	self:BindCfgUI()

	self.isOnDiscountAreaController_ = ControllerUtil.GetController(self.gameObject_.transform, "isOnDiscountArea")
	self.isDiscountController_ = ControllerUtil.GetController(self.gameObject_.transform, "isDiscount")
	self.costTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "costType")
	self.tipController_ = ControllerUtil.GetController(self.gameObject_.transform, "tip")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.isLimitTimeController_ = ControllerUtil.GetController(self.gameObject_.transform, "isLimitTime")
	self.dlcController_ = ControllerUtil.GetController(self.transform_, "dlc")
	self.levelController_ = ControllerUtil.GetController(self.transform_, "level")
end

function RechargeSkinItem:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
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
	end)
	self:AddBtnListener(self.bottomBtn_, nil, function()
		SendMessageManagerToSDK("purchase_click_skin")

		if self.canBuyDlc then
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				goodID = self.goodID,
				heroID = self.skinCfg.hero,
				skinID = self.skinCfg.id,
				shopID = self.shopID
			}, ViewConst.SYSTEM_ID.SHOP)
		else
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				goodID = self.goodID,
				heroID = self.skinCfg.hero,
				skinID = self.skinCfg.id,
				shopID = self.shopID
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	end)
	self:AddBtnListener(nil, self.jumpBtn_, function()
		if self.canBuyDlc == false then
			JumpTools.GoToSystem("/shop", {
				shopId = getShopCfg(self.dlcID).shop_id
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	self:AddBtnListener(self.pcBtn_, nil, function()
		ShowTips("PC_SHOP_TIPS2")
	end)
end

function RechargeSkinItem:SetOutOfDateHandler(arg_7_1)
	self.outOfDateHandler_ = arg_7_1
end

function RechargeSkinItem:UpdateTimerView()
	local var_8_0 = self.shopCfg

	if self.haveDlc and (ShopTools.HaveSkin(self.skinCfg.id) or HeroTools.CanChangeSkin(self.skinCfg.id)) then
		var_8_0 = self.shopDlcCfg
	end

	if #var_8_0.close_time > 0 then
		self.isLimitTimeController_:SetSelectedState("true")

		self.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(var_8_0.close_time)

		local var_8_1 = TimeMgr.GetInstance():parseTimeFromConfig(var_8_0.close_time)

		if var_8_1 <= TimeMgr.GetInstance():GetServerTime() then
			self.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if self.outOfDateHandler_ ~= nil then
				self.outOfDateHandler_(var_8_0.goods_id)
			end
		else
			self.lastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(var_8_1))
		end
	else
		self.isLimitTimeController_:SetSelectedState("false")

		self.lastTimeLabel_.text = ""
	end

	local var_8_2, var_8_3, var_8_4 = ShopTools.IsOnDiscountArea(var_8_0.goods_id)

	if var_8_3 and var_8_4 and var_8_2 then
		self.isOnDiscountAreaController_:SetSelectedState("true")

		local var_8_5 = TimeMgr.GetInstance():parseTimeFromConfig(var_8_0.cheap_close_time)

		self.discountLastTimeLabel_.text = var_8_5 <= TimeMgr.GetInstance():GetServerTime() and "0" .. GetTips("SECOND") or string.format("%s", manager.time:GetLostTimeStr(var_8_5))
	else
		self.isOnDiscountAreaController_:SetSelectedState("false")

		self.discountLastTimeLabel_.text = ""
	end
end

function RechargeSkinItem:UpdateView()
	self.levelController_:SetSelectedState(tostring(self.skinCfg.skin_level))

	if ShopTools.HaveSkin(self.skinCfg.id) or HeroTools.CanChangeSkin(self.skinCfg.id) then
		if self.haveDlc and not ShopTools.CheckDlcPurchased(self.dlcID) then
			self.statusController_:SetSelectedState("normal")

			self.bgBtn_.interactable = true
			self.bottomBtn_.interactable = true

			self:RefreshDlcUI()
		else
			self.statusController_:SetSelectedState("sellout")

			self.bgBtn_.interactable = false
			self.bottomBtn_.interactable = false

			self:RefreshCommonUI()
		end
	else
		self.statusController_:SetSelectedState("normal")

		self.bgBtn_.interactable = true
		self.bottomBtn_.interactable = true

		self:RefreshCommonUI()
	end

	self.dlcController_:SetSelectedIndex(self.haveDlc and 1 or 0)

	if self.haveDlc then
		self.dlcImg_.sprite = ItemTools.getItemSprite(self.itemDlcCfg.id)
	end

	self:UpdateSkinPrice()

	if ShopTools.IsPC() then
		SetActive(self.pcBtn_.gameObject, ShopTools.IsRMB(self.goodID))
		SetActive(self.bottomGo_, ShopTools.IsRMB(self.goodID) == false)
	end
end

function RechargeSkinItem:RefreshCommonUI()
	self.nameLabel_.text = string.format("%s", self.skinCfg.name)
	self.titleLabel_.text = ItemTools.getItemName(ItemCfg[self.skinCfg.hero].id)
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.skinCfg.picture_id)

	local var_10_0, var_10_1, var_10_2 = ShopTools.IsOnDiscountArea(self.goodID)

	if var_10_0 and var_10_2 then
		self.tipController_:SetSelectedState(var_10_1 and "time_limit_discount" or "discount")
	else
		self.tipController_:SetSelectedState(self.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE and "superValue" or "none")
	end
end

function RechargeSkinItem:RefreshDlcUI()
	self.nameLabel_.text = GetI18NText(self.itemCfg.name)
	self.titleLabel_.text = ""
	self.icon_.sprite = self.itemCfg and ItemConst.ITEM_TYPE.SCENE == self.itemCfg.type and pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.itemCfg.param[1]) or nil

	local var_11_0, var_11_1, var_11_2 = ShopTools.IsOnDiscountArea(self.dlcID)

	if var_11_0 and var_11_2 then
		self.tipController_:SetSelectedState(var_11_1 and "time_limit_discount" or "discount")
	else
		self.tipController_:SetSelectedState(self.shopDlcCfg.tag == ShopConst.TAGS.SUPER_VALUE and "superValue" or "none")
	end
end

function RechargeSkinItem:UpdateSkinPrice()
	if ShopTools.HaveSkin(self.skinCfg.id) or HeroTools.CanChangeSkin(self.skinCfg.id) then
		if self.haveDlc and not ShopTools.CheckDlcPurchased(self.dlcID) then
			if self.canBuyDlc then
				self:RefreshPriceUI(self.dlcID)
			else
				SetActive(self.rebackSkinIcon_.gameObject, #self.shopDlcCfg.give_back_list > 0)
				self.costTypeController_:SetSelectedState("jump")
			end
		else
			self:RefreshPriceUI(self.goodID)
		end
	else
		self:RefreshPriceUI(self.goodID)
	end
end

function RechargeSkinItem:RefreshPriceUI(arg_13_1)
	self:UpdatePrice(arg_13_1)
	SetActive(self.rebackSkinIcon_.gameObject, #getShopCfg(arg_13_1).give_back_list > 0)
end

function RechargeSkinItem:IsOnDiscountArea(arg_14_1)
	local var_14_0, var_14_1, var_14_2 = ShopTools.IsOnDiscountArea(getShopCfg(arg_14_1).goods_id)

	if var_14_0 and var_14_2 then
		return true
	else
		return false
	end
end

return RechargeSkinItem
