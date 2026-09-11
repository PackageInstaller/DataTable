local NewHeroSkinPreview = class("NewHeroSkinPreview", (import("game.views.newHero.skin.NewHeroSkinView")))

function NewHeroSkinPreview:RefreshShop()
	self:RefreshCurrencyToken(true)
end

function NewHeroSkinPreview:GetSkinItem()
	return NewHeroSkinPreviewItem.New(self.itemGo_, self.contentTf_)
end

function NewHeroSkinPreview:OnSelectSkin(arg_3_1, arg_3_2)
	self:SetButtonActive(8)
end

function NewHeroSkinPreview:OnEnter()
	ShopTools.FilterShopDataList(ShopConst.SHOP_ID.SKIN_SHOP)

	self.descList_ = {}
	self.showDlc_ = false
	self.heroID_ = not self.params_.heroID and HeroSkinRouteData:GetRoute().heroID or self.params_.heroID

	if not self.params_.isBack then
		if not self.params_.skinID then
			self.skinID_ = HeroTools.HeroUsingSkinInfo(self.heroID_).id
		else
			self.skinID_ = self.params_.skinID
			self.params_.initSkinID = self.params_.initSkinID or self.params_.skinID
		end
	elseif self.skinID_ == 1 or self.skinID_ == nil then
		if not self.params_.skinID then
			self.skinID_ = HeroTools.HeroUsingSkinInfo(self.heroID_).id
		else
			self.skinID_ = self.params_.skinID
			self.params_.initSkinID = self.params_.skinID
		end
	end

	self.plotController_:SetSelectedState("off")

	self.isOpenPlotTalk = false

	manager.heroRaiseTrack:SetModelState(self.skinID_)
	self:RefreshShop()
	self:RegistEventListener(GET_SKIN_GIFT, handler(self, self.OnGetSkinGift))
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_5_0)
		self:RefreshUI()
	end)
	self:RegistEventListener(HERO_BATTLE_SKIN_CHANGE, function(arg_6_0)
		self:RefreshBattleSkinBtn()
		self:RefreshBattleSkinTag(arg_6_0)
	end)
	self:RefreshUI()

	if self.params_.isDlc then
		self.params_.isDlc = false

		self:ChangeShowDlcState(1)
	elseif not self.params_.isBack then
		self:ChangeShowDlcState(0)
	else
		self:ChangeShowDlcState(self.showDlcState_ or 0)
	end

	manager.notify:RegistListener(CHANGE_POSTER_GIRL, handler(self, self.RefreshInfoOther))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self:Scroll2SelectItem(100)
end

function NewHeroSkinPreview:RefreshUIWithOutScroll()
	self:RefreshInfo()
	self:RefreshCost()
	self:SetButtonActive(self:SkinState(self.skinID_))
end

function NewHeroSkinPreview:RefreshButton(arg_8_1)
	self.selectIndex_ = arg_8_1.index_

	local var_8_0 = arg_8_1:SkinState()
	local var_8_1 = arg_8_1.skinID_

	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_8_1.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)

	if var_8_1 == self.skinID_ then
		self:Scroll2SelectItem(5)

		return
	end

	OperationRecorder.RecordButtonTouch("hero_skin_" .. var_8_1)

	self.skinID_ = var_8_1

	local var_8_2 = SkinCfg[var_8_1]

	self:SetButtonActive(var_8_0)
	manager.heroRaiseTrack:SetModelState(self.skinID_)
	SetActive(self.plotBtn_, #var_8_2.plot_title > 0)
	self.plotController_:SetSelectedState("off")

	self.isOpenPlotTalk = false

	self:RefreshInfo()
	self:RefreshCost()
	self:CheckDlc(var_8_1, var_8_0)
	self:RefreshDlcBtn()
	self:ChangeShowDlcState(0)
	self:RefreshDescBtn()
	self:RefreshGiftBtn()
	self:HideMessage()
	self:RefreshUI()
	self:Scroll2SelectItem(5)
end

function NewHeroSkinPreview:UpdateBar()
	if self.btnState_ == 3 or self.dlcBtnController_:GetSelectedState() == "buyDlc" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId(),
			CurrencyConst.CURRENCY_TYPE_SKIN
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function NewHeroSkinPreview:SetButtonActive(arg_10_1)
	self:CheckDlc(self.skinID_, arg_10_1)

	if self:JudgeDLC(self.skinID_) then
		if not self:isDlcOwned() then
			self.dlc_dlcController_:SetSelectedIndex(0)
		else
			self.dlc_dlcController_:SetSelectedIndex(1)
		end
	end

	if arg_10_1 == 8 and HeroTools.GetHasOwnedSkin(self.skinID_) or arg_10_1 == 7 and self.skinID_ ~= self.heroID_ or arg_10_1 == 9 and HeroTools.GetHasOwnedSkin(self.skinID_) then
		self.dlc_skinController_:SetSelectedIndex(1)
	else
		self.dlc_skinController_:SetSelectedIndex(0)
	end

	if self.btnState_ == arg_10_1 then
		return
	end

	self.statusController_:SetSelectedIndex(arg_10_1 - 1)

	self.btnState_ = arg_10_1

	self:UpdateBar()
end

function NewHeroSkinPreview:SkinState(arg_11_1)
	self:ChangeDlcBtn()

	if self:isUnlockOrCanChange(arg_11_1) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[self.skinID_].hero) == false and self.skinID_ == SkinCfg[self.skinID_].hero then
			return 7
		end

		if self.showDlcState_ == 1 and not self:isDlcOwned() then
			return 9
		end

		return 8
	else
		if HeroTools.IsSkinOutOfDate(arg_11_1) then
			if self.showDlcState_ == 1 and not self:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(self.skinID_) then
				return 9
			end

			if self.showDlcState_ == 1 and self:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(self.skinID_) then
				return 8
			end

			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB((HeroTools.GetShopIdBySkinId(self.skinID_))) then
			return 12
		end

		return 3
	end
end

function NewHeroSkinPreview:ChangeDlcBtn()
	local var_12_0 = 0

	if self:JudgeDLC(self.skinID_) then
		local var_12_1 = self:CheckIsSpecial()

		if var_12_1 == 1 then
			self:ChangeDlcBtnSpecial()

			return
		elseif var_12_1 == 2 then
			self.sourceDlcText_.text = GetI18NText(ItemCfg[self.dlcItemID_].desc_source) or ""

			if not self:isDlcOwned() then
				var_12_0 = 4
			end
		else
			local var_12_2 = getShopCfg(self.dlcID_)

			if self.showDlcState_ == 1 and ShopTools.CheckShopIsUnLock(var_12_2.shop_id) and ShopTools.IsGoodCanDisplay(var_12_2.shop_id, var_12_2.goods_id) then
				local var_12_3 = self:isUnlock(self.skinID_)
				local var_12_4 = self:isDlcOwned()

				if var_12_3 and not var_12_4 then
					var_12_0 = 1
				elseif not var_12_3 and var_12_4 then
					var_12_0 = 3
				end
			end
		end
	end

	self.dlcBtnController_:SetSelectedIndex(var_12_0)
end

function NewHeroSkinPreview:SaveRoute()
	SkinTrialData:SaveRoute({
		name = "heroSkinPreview",
		skinID = self.skinID_,
		heroID = self.heroID_,
		initSkinID = self.params_.initSkinID
	})
end

function NewHeroSkinPreview:AddBtnListenerOther()
	self:AddBtnListener(self.btn_dlcSpecialExchangeBtn_, nil, function()
		local var_15_0 = getShopCfg(self.dlcID_)

		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(var_15_0.give_id)),
			OkCallback = function()
				if var_15_0 then
					JumpTools.GoToSystem("/shop", {
						shopId = var_15_0.shop_id
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function NewHeroSkinPreview:OnTryToUseItemOther(arg_18_1)
	self:SetButtonActive(8)
end

function NewHeroSkinPreview:ChangeShowDlcStateOther()
	self:RefreshCost()
	self:ChangeDlcBtn()
	self:SetButtonActive(self:SkinState(self.skinID_))
	self:RefreshInfo()
end

function NewHeroSkinPreview:RefreshInfoOther()
	self:RefreshLimitTime(self.skinID_)
	self:RefreshBattleSkinBtn(self.skinID_)
	self:RefreshBattleSkinTag(self.battleSkinID_)
end

function NewHeroSkinPreview:RefreshCost()
	local var_21_0 = getShopCfg(HeroTools.GetShopIdBySkinId(self.skinID_))

	SetActive(self.tokenPlusGo_, false)

	if var_21_0 then
		local var_21_1 = 0
		local var_21_3
		local var_21_4
		local var_21_6 = var_21_0.dlc or nil
		local var_21_7 = false

		if var_21_6 and var_21_6 ~= 0 then
			var_21_3 = getShopCfg(var_21_6)

			if var_21_3 then
				var_21_1, _, _, var_21_4 = ShopTools.GetPrice(var_21_6)
			end

			var_21_7 = ShopTools.HasMultiPay(var_21_6)
		end

		local var_21_8 = ShopTools.GetPrice(var_21_0.goods_id, var_21_0.shop_id)
		local var_21_9 = var_21_8

		if self:CheckIsSpecial() == 0 and self.showDlcState_ == 1 and not self:isDlcOwned() then
			SetActive(self.tokenPlusGo_, true)

			var_21_9 = var_21_8 + var_21_1
		end

		if var_21_0.cost_type == 1 then
			self.currencyImage_.sprite = nil
			self.currencyText_.text = ShopTools.GetMoneySymbol(var_21_0.goods_id) .. var_21_8

			SetActive(self.currencyGo_, false)
		else
			self.currencyImage_.sprite = ItemTools.getItemLittleSprite(var_21_0.cost_id)
			self.currencyText_.text = var_21_9

			if var_21_7 then
				self.goodDlcCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_21_0.cost_id)
				self.goodDlcCurrencyText_.text = var_21_8
				self.goodDlcSecondCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_21_3.cost_id_2)
				self.goodDlcSecondCurrencyText_.text = var_21_4
			end

			SetActive(self.currencyGo_, true)
		end

		if var_21_1 and var_21_1 ~= 0 then
			SetActive(self.dlctokenGo_, true)

			if ShopTools.IsRMB(var_21_6) then
				self.dlccurrencyImage_.sprite = nil
				self.dlccurrencyText_.text = ShopTools.GetMoneySymbol(var_21_6) .. var_21_1

				SetActive(self.dlccurrencyGo_, false)
			else
				self.dlccurrencyImage_.sprite = ItemTools.getItemLittleSprite(var_21_0.cost_id)
				self.dlccurrencyText_.text = var_21_1

				if var_21_7 then
					self.dlcSecondCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_21_3.cost_id_2)
					self.dlcSecnondCurrencyText_.text = var_21_4
				end

				SetActive(self.dlccurrencyGo_, true)
			end
		elseif var_21_6 and var_21_6 ~= 0 and var_21_1 == 0 then
			local var_21_10

			_, var_21_10 = ShopTools.GetPrice(var_21_6)
			self.dlccurrencyImage_.sprite = ItemTools.getItemLittleSprite(var_21_3.cost_id)
			self.dlccurrencyText_.text = var_21_10
		end

		SetActive(self.dlcSecondCurrencyGo_, var_21_7)
	end

	self:RefreshTokenNumText()
end

local function var_0_1(arg_22_0)
	local var_22_0 = 0

	if ShopTools.IsPC() then
		return 0
	end

	if arg_22_0:CheckIsSpecial() == 1 then
		return 0
	end

	if not arg_22_0:isUnlockOrCanChange(arg_22_0.skinID_) and not HeroTools.IsSkinOnlySellDLC(arg_22_0.skinID_) then
		var_22_0 = var_22_0 + 1
	end

	if arg_22_0.showDlcState_ == 1 and not arg_22_0:isDlcOwned() then
		var_22_0 = var_22_0 + 1
	end

	return var_22_0
end

function NewHeroSkinPreview:RefreshTokenNumText()
	local var_23_0 = var_0_1(self)

	SetActive(self.tokenNum1Go_, var_23_0 == 1)
	SetActive(self.tokenNum2Go_, var_23_0 == 2)
end

return NewHeroSkinPreview
