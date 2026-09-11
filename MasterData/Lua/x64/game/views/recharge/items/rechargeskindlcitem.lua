local RechargeSkinDlcItem = class("RechargeSkinDlcItem", (import("game.views.shop.base.ShopItemBase")))

function RechargeSkinDlcItem:InitUI()
	self:BindCfgUI()

	self.dlcImg_.immediate = true
	self.isLimitTimeController_ = ControllerUtil.GetController(self.gameObject_.transform, "isLimitTime")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.btnController_ = ControllerUtil.GetController(self.gameObject_.transform, "btn")
	self.btn2Controller_ = ControllerUtil.GetController(self.gameObject_.transform, "btn2")
	self.btn5Controller_ = ControllerUtil.GetController(self.gameObject_.transform, "btn5")
	self.multiInfoController_ = ControllerUtil.GetController(self.gameObject_.transform, "multiInfo")
end

function RechargeSkinDlcItem:AddUIListener()
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

function RechargeSkinDlcItem:OnClickItem()
	SendMessageManagerToSDK("purchase_click_skin")
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_skin = self.skinCfg.id
	})

	if ShopConst.SHOP_ID.DLC_SHOP ~= self.shopCfg.shop_id and ShopConst.SHOP_ID.REPURCHASE_SHOP ~= self.shopCfg.shop_id then
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

	if self.callback_ then
		self.callback_(self.index_)
	end
end

function RechargeSkinDlcItem:SetCallBack(arg_8_1, arg_8_2)
	self.callback_ = arg_8_1
	self.index_ = arg_8_2
end

function RechargeSkinDlcItem:SetOutOfDateHandler(arg_9_1)
	self.outOfDateHandler_ = arg_9_1
end

function RechargeSkinDlcItem:SetData(arg_10_1, arg_10_2, arg_10_3)
	self.shopCfg = getShopCfg(arg_10_1)
	self.goodID = arg_10_1
	self.skinGoodId = arg_10_3
	self.shopID = self.shopCfg.shop_id
	self.skinId = arg_10_2
	self.skinCfg = SkinCfg[arg_10_2]
	self.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == self.shopCfg.shop_id and ShopTools.CheckDlcPurchased(arg_10_1) == false
	self.itemCfg = RechargeShopDescriptionCfg[self.shopCfg.description]

	if self.itemCfg == nil then
		self.itemCfg = ItemCfg[self.shopCfg.give_id]
	end

	self:UpdateView()
	self:UpdateTimerView()
end

function RechargeSkinDlcItem:UpdateTimerView()
	self.isLimitTimeController_:SetSelectedState("false")
	self:RefreshCommonUI()
	self:RefreshPriceUI()
end

function RechargeSkinDlcItem:UpdateView()
	self:RefreshPriceUI()
	self:RefreshCommonUI()

	local var_12_0, var_12_1, var_12_2, var_12_3, var_12_4 = ShopTools.GetPrice(self.goodID)

	self.nameLabel_.text = string.format("%s", self.itemCfg.name)
	self.titleLabel_.text = ItemTools.getItemName(ItemCfg[self.skinCfg.hero].id)
	self.dlcPriceTxt_.text = var_12_0
	self.dlcImg_.spriteSync = "TextureConfig/Character/Icon/" .. self.itemCfg.id
	self.costIcon_.sprite = ItemTools.getItemSprite(self.shopCfg.cost_id)

	if ShopTools.HasMultiPay(self.goodID) then
		self.costIcon2_.sprite = ItemTools.getItemSprite(self.shopCfg.cost_id_2)
		self.dlcPrice2Txt_.text = var_12_3
	end

	if ShopTools.IsPC() then
		SetActive(self.pcBtn_.gameObject, ShopTools.IsRMB(self.goodID))
	end
end

function RechargeSkinDlcItem:RefreshCommonUI()
	SetActive(self.discountGo_, false)
	SetActive(self.limitGiveGo_, false)
	SetActive(self.freeGiftGo_, false)
	SetActive(self.superValueGo_, self.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE)

	local var_13_0, var_13_1, var_13_2 = ShopTools.IsOnDiscountArea(self.goodID)
	local var_13_3 = ShopTools.GetDiscount(self.goodID)

	if var_13_0 and var_13_2 and #self.shopCfg.cheap_close_time > 0 then
		SetActive(self.limitDiscountGo_, self.shopCfg.is_limit_time_discount == 1)
	else
		SetActive(self.limitDiscountGo_, false)
	end

	self.btn2Controller_:SetSelectedState("false")

	if var_13_3 == 0 and var_13_0 and var_13_2 then
		SetActive(self.limitDiscountGo_, false)
		SetActive(self.limitGiveGo_, true)
		self.btn2Controller_:SetSelectedState("true")
	end

	self.btn2Controller_:SetSelectedState("false")

	if self.shopCfg.cost == 0 then
		self.btn2Controller_:SetSelectedState("true")
		self.btn5Controller_:SetSelectedState("true")
		SetActive(self.freeGiftGo_, true)
	else
		self.btn5Controller_:SetSelectedState("false")
	end

	local var_13_4 = ShopTools.HasMultiPay(self.goodID)

	if ShopTools.HaveSkin(self.skinCfg.id) and HomeSceneSettingData:GetUsedState(self.itemCfg.id) ~= SceneConst.HOME_SCENE_TYPE.UNLOCK then
		self.btnController_:SetSelectedState("true")

		if var_13_4 then
			self.multiInfoController_:SetSelectedState("true")
		else
			self.multiInfoController_:SetSelectedState("false")
		end
	elseif var_13_4 then
		self.btnController_:SetSelectedState("multiPay")
	else
		self.btnController_:SetSelectedState("false")
	end
end

function RechargeSkinDlcItem:RefreshPriceUI(arg_14_1)
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

function RechargeSkinDlcItem:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

return RechargeSkinDlcItem
