local NewSkinBuyCheckView = class("NewSkinBuyCheckView", ReduxView)
local var_0_1 = {
	OnlySkin = 1,
	OnlyDlc = 2,
	SpecialShow = 3,
	FakeData = 5,
	BuyDlcAndSkin = 4
}

function NewSkinBuyCheckView:UIName()
	return "Widget/System/Recharge/RechargeSkinPopUI"
end

function NewSkinBuyCheckView:UIParent()
	return manager.ui.uiPop.transform
end

function NewSkinBuyCheckView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewSkinBuyCheckView:InitUI()
	self:BindCfgUI()

	self.dlcselController = self.controller_:GetController("dlcsel")
	self.dlcbtnController = self.controller_:GetController("dlcbtn")
	self.dlcbgController = self.controller_:GetController("dlcbg")
	self.dlcIconController = self.controller_:GetController("dlcIcon")
	self.discountController = self.controller_:GetController("discount")
	self.skinDiscountController = self.controller_:GetController("skinEvent")
	self.multiTabController = self.controller_:GetController("multiTab")
	self.multiPayController = self.controller_:GetController("multiPay")
	self.multiSelectTabController = self.skinTabController_:GetController("tab")
	self.oathDrawStateController = self.controller_:GetController("oathDraw")
	self.giveBackItem2 = CommonItemView.New(self.giveBackGo2_, true)
end

function NewSkinBuyCheckView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.calcelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.jumpBtn_, nil, function()
		local var_8_0 = getShopCfg(self.dlcID)

		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(self.itemDlcCfg.id)),
			OkCallback = function()
				JumpTools.GoToSystem("/shop", {
					shopId = var_8_0.shop_id,
					goodId = self.dlcID
				}, ViewConst.SYSTEM_ID.SHOP)
			end
		})
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		local var_10_0, var_10_1, var_10_2 = ShopTools.GetPrice(self.goodID)
		local var_10_3 = 0

		if self.dlcID and self.dlcID ~= 0 then
			local var_10_4, var_10_5, var_10_6, var_10_7, var_10_8 = ShopTools.GetPrice(self.dlcID)

			var_10_3 = self.selectCurrencyIndex == 2 and var_10_8 or var_10_4
		end

		local var_10_9 = {
			self.goodID
		}
		local var_10_10 = var_10_0

		if self.showModel == var_0_1.BuyDlcAndSkin then
			table.insert(var_10_9, self.dlcID)

			if self.selectCurrencyIndex == 1 then
				var_10_10 = var_10_0 + var_10_3
			end
		elseif self.showModel == var_0_1.OnlyDlc then
			var_10_10 = var_10_3
		elseif self.showModel == var_0_1.FakeData then
			var_10_9 = {
				self.dlcID
			}
			var_10_10 = var_10_3
		end

		local function var_10_11(arg_11_0)
			if ShopTools.IsRMB(arg_11_0[1]) then
				PayAction.RequestGSPay(ShopTools.GetCostId(self.goodID), 1, self.shopID, arg_11_0[1])
			elseif self.showModel == var_0_1.BuyDlcAndSkin then
				ShopTools.ConfirmBuySkin(arg_11_0, {
					1,
					1
				}, nil, nil, nil, self.selectCurrencyIndex - 1)
			elseif self.showModel == var_0_1.FakeData then
				ShopTools.ConfirmBuySkin(arg_11_0, {
					1,
					1
				}, nil, nil, nil, self.selectCurrencyIndex - 1)
			elseif self.showModel == var_0_1.OnlyDlc then
				ShopTools.ConfirmBuyItem(arg_11_0[1], 1, nil, nil, nil, self.selectCurrencyIndex - 1)
			else
				ShopTools.ConfirmBuyItem(arg_11_0[1], 1, nil, nil, nil, 0)
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = self.skinID
		})

		if ShopData.IsGoodOutOfDate(self.goodID) then
			ShowTips("SKIN_SALE_FINISH")
			self:Back()

			return
		end

		CommonTools.Ask({
			{
				check = function()
					return HeroData:GetHeroData(self.heroID).unlock == 0
				end,
				content = GetTipsF("NOT_HAVE_HERO_SKIN_CONFIRM", GetI18NText(self.heroCfg.name)),
				cancelCallback = function()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			}
		}, function(arg_12_0)
			if not arg_12_0 then
				return
			end

			if ShopTools.IsRMB(self.goodID) == false and ShopTools.GetCostCount(self.goodID) < var_10_10 then
				var_10_11(var_10_9)
			else
				var_10_11(var_10_9)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_skin_buy_unlock = 0
				})
			end
		end)
	end)
	self:AddBtnListener(self.dlcBtn_, nil, function()
		if ShopTools.CheckDlcCanBuy(self.dlcID) and ShopTools.CheckDlcPurchased(self.dlcID) == false then
			if self.selectDLC == true then
				self.dlcselController:SetSelectedState("false")

				self.selectDLC = false
			else
				self.selectDLC = true

				self.dlcselController:SetSelectedState("true")

				self.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. self.skinCfg.id)
			end
		end
	end)
	self:AddBtnListener(self.addDlcBtn_, nil, function()
		self.showModel = var_0_1.BuyDlcAndSkin

		self:UpdateView()
		self.dlcbtnController:SetSelectedState("buy")

		if self.dlcID then
			local var_16_0 = getShopCfg(self.dlcID)

			if var_16_0 then
				local var_16_1 = var_16_0.give_id or var_16_0.description

				if var_16_1 then
					OperationRecorder.RecordButtonTouch("skin_buy_add_" .. var_16_1)
				end
			end
		end
	end)
	self:AddBtnListener(self.cancelDlcBtn_, nil, function()
		self.showModel = var_0_1.OnlySkin

		self:UpdateView()
	end)
	self:AddBtnListener(self.btnView_, nil, function()
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = self.goodID
		})
	end)
	self:AddBtnListener(self.skinDiscountBtn_, nil, function()
		SkinDiscountGiftAction.JumpToSkinDiscountGiftWindow(self.goodID)
	end)
	self:AddBtnListener(self.currencyTab1_, nil, function()
		self:SelectCurrencyTab(1)
		self:UpdatePrice()
	end)
	self:AddBtnListener(self.currencyTab2_, nil, function()
		self:SelectCurrencyTab(2)
		self:UpdatePrice()
	end)
	self:AddBtnListener(self.oathBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityOathDrawMainView", {
			activityID = ActivityOathDrawData:GetMainActivityID()
		})
	end)
end

function NewSkinBuyCheckView:OnShopBuyResult(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1 == 0 then
		self:Back()
	else
		self:Back()
	end
end

function NewSkinBuyCheckView:UpdateBar()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId(),
		CurrencyConst.CURRENCY_TYPE_SKIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
end

function NewSkinBuyCheckView:OnTop()
	self:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function NewSkinBuyCheckView:UpdateData()
	self.shopCfg = getShopCfg(self.goodID)
	self.shopID = self.shopCfg.shop_id
	self.skinCfg = SkinCfg[self.skinID]
	self.heroCfg = HeroCfg[self.skinCfg.hero]
	self.desCfg = RechargeShopDescriptionCfg[self.shopCfg.description]
	self.descID = self.desCfg.id
	self.dlcID = self.shopCfg.dlc or nil
	self.shopDlcCfg = getShopCfg(self.dlcID)

	if self.params_.onlySkin then
		self.showModel = var_0_1.OnlySkin or var_0_1.BuyDlcAndSkin
	end

	if self.shopDlcCfg and self.shopDlcCfg.shop_id == self.shopID or self.shopDlcCfg and self.shopDlcCfg.shop_id == ShopConst.SHOP_ID.PASSPORT_SHOP then
		self.itemDlcCfg = RechargeShopDescriptionCfg[self.shopDlcCfg.description]

		if self.itemDlcCfg == nil then
			self.itemDlcCfg = ItemCfg[self.shopDlcCfg.give_id]
			self.showModel = var_0_1.OnlySkin
		end
	end

	if self.goodID <= 0 then
		self.showModel = var_0_1.FakeData
	elseif ShopTools.HaveSkin(self.skinID) then
		self.showModel = var_0_1.OnlyDlc
		self.goodID = self.dlcID
	end
end

function NewSkinBuyCheckView:UpdatePrice()
	local var_27_0 = ItemCfg[self.skinCfg.hero]

	SetActive(self.oriOriceTxt_.gameObject, false)
	SetActive(self.skinOriginTxt_.gameObject, false)
	SetActive(self.dlcPrice_.gameObject, false)
	SetActive(self.allPriceTxt_.gameObject, self.selectCurrencyIndex == 1 and self.showModel == var_0_1.BuyDlcAndSkin)
	SetActive(self.dlcPrice_.gameObject, self.selectCurrencyIndex == 1 and self.showModel == var_0_1.BuyDlcAndSkin)
	SetActive(self.kuoGo_, self.selectCurrencyIndex == 1 and self.showModel == var_0_1.BuyDlcAndSkin)
	SetActive(self.secondCurrencyGo_, self.selectCurrencyIndex == 2 and self.showModel == var_0_1.BuyDlcAndSkin)
	self.dlcbgController:SetSelectedState(self.showModel == var_0_1.OnlyDlc and "true" or "false")

	local var_27_1, var_27_2, var_27_3 = ShopTools.IsOnDiscountArea(self.goodID)
	local var_27_4, var_27_5, var_27_6 = ShopTools.GetPrice(self.goodID)

	if self.showModel == var_0_1.BuyDlcAndSkin then
		local var_27_7, var_27_8, var_27_9, var_27_10, var_27_11 = ShopTools.GetPrice(self.dlcID)
		local var_27_12, var_27_13, var_27_14, var_27_15, var_27_16, var_27_17 = ShopTools.IsOnDiscountArea(self.dlcID)

		if ShopTools.IsRMB(self.goodID) then
			SetActive(self.costiconImg_.gameObject, false)

			self.priceText_.text = ShopTools.GetMoneySymbol(self.goodID) .. var_27_4 + var_27_7
		else
			self.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(self.shopCfg.cost_id), var_27_4 + var_27_7, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(self.shopCfg.description)) .. string.format(GetTips("BUY_SKIN_TIPS_TICKET_NAME"), ItemTools.getItemName(self.itemDlcCfg.id))

			SetActive(self.costiconImg_.gameObject, true)

			if var_27_1 and var_27_3 then
				SetActive(self.skinOriginTxt_.gameObject, var_27_4 ~= var_27_5)

				if var_27_4 ~= var_27_5 then
					self.skinOriginTxt_.text = var_27_5
				end
			end

			if var_27_12 and var_27_14 then
				local var_27_18
				local var_27_19

				if self.selectCurrencyIndex == 1 then
					var_27_18 = var_27_7
					var_27_19 = var_27_8
				elseif self.selectCurrencyIndex == 2 then
					var_27_18 = var_27_10
					var_27_19 = var_27_11
				end

				SetActive(self.oriOriceTxt_.gameObject, var_27_18 ~= var_27_19)

				if var_27_18 ~= var_27_19 then
					self.oriOriceTxt_.text = var_27_19
				end
			else
				SetActive(self.oriOriceTxt_.gameObject, false)
			end

			if self.selectCurrencyIndex == 2 then
				local var_27_20, var_27_21 = ShopTools.GetCostId(self.goodID)
				local var_27_22, var_27_23 = ShopTools.GetCostId(self.dlcID)

				self.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET_MULTIPAY"), "[" .. ItemTools.getItemName(var_27_20) .. "]" .. var_27_4 .. " + [" .. ItemTools.getItemName(var_27_23) .. "]" .. var_27_10, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(self.shopCfg.description)) .. string.format(GetTips("BUY_SKIN_TIPS_TICKET_NAME"), ItemTools.getItemName(self.itemDlcCfg.id))
				self.secondCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_27_23)
				self.secondCurrencyText_.text = var_27_10 > ItemTools.getItemNum(var_27_23) and "<color=#FF000B>" .. var_27_10 .. "</color>" or var_27_10
				self.priceText_.text = var_27_4 > ItemTools.getItemNum(var_27_20) and "<color=#FF000B>" .. var_27_4 .. "</color>" or var_27_4
			else
				self.costiconImg_.sprite = ItemTools.getItemLittleSprite(self.shopCfg.cost_id)
				self.priceText_.text = var_27_4 + var_27_7

				if ItemTools.getItemNum(self.shopCfg.cost_id) < var_27_4 + var_27_7 then
					self.priceText_.text = "<color=#FF000B>" .. var_27_4 + var_27_7 .. "</color>"
				end

				self.dlcPrice_.text = "+" .. var_27_7
				self.allPriceTxt_.text = string.format("( %d", var_27_4)
			end
		end

		if #self.shopCfg.give_back_list ~= 0 then
			self.rebackSkinTicketText_.text = self.shopCfg.give_back_list[1].num
			self.allrebackTxt_.text = ""
		end
	else
		local var_27_24, var_27_25 = ShopTools.GetCostId(self.goodID)
		local var_27_26
		local var_27_27

		if self.dlcID ~= 0 then
			var_27_26, var_27_27 = ShopTools.GetCostId(self.dlcID)
		end

		if self.showModel == var_0_1.OnlyDlc or self.showModel == var_0_1.FakeData then
			local var_27_28

			var_27_4, var_27_5, var_27_28, price2, oriPrice2 = ShopTools.GetPrice(self.dlcID)
			self.dlcItemIcon_.sprite = ItemTools.getItemSprite(self.itemDlcCfg.id)

			if self.selectCurrencyIndex == 2 then
				var_27_4 = price2
				var_27_5 = oriPrice2
				var_27_26 = var_27_27
			end

			SetActive(self.oriOriceTxt_.gameObject, var_27_4 ~= var_27_5)

			if var_27_4 ~= var_27_5 then
				self.oriOriceTxt_.text = var_27_5
			end
		end

		if ShopTools.IsRMB(self.goodID) then
			SetActive(self.costiconImg_.gameObject, false)

			self.priceText_.text = ShopTools.GetMoneySymbol(self.goodID) .. var_27_4
			self.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS"), ShopTools.GetMoneySymbol(self.goodID) .. var_27_4, "", ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(self.shopCfg.description))

			if var_27_1 and var_27_3 then
				SetActive(self.skinOriginTxt_.gameObject, var_27_4 ~= var_27_5)

				if var_27_4 ~= var_27_5 then
					self.skinOriginTxt_.text = var_27_5
				end
			end
		else
			if self.showModel == var_0_1.OnlyDlc then
				self.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(var_27_26), var_27_4, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(self.itemDlcCfg.id))
			elseif self.showModel == var_0_1.FakeData then
				self.buyDesc_.text = string.format(GetTips("BUY_SKIN_DLC_SINGLE_TIPS"), ItemTools.getItemName(var_27_26), var_27_4, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(self.itemDlcCfg.id))
			else
				self.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(var_27_24), var_27_4, ItemTools.getItemName(var_27_0.id), ItemTools.getItemName(self.shopCfg.description))
				var_27_26 = var_27_24
			end

			if var_27_1 and var_27_3 then
				SetActive(self.skinOriginTxt_.gameObject, var_27_4 ~= var_27_5 and self.showModel ~= var_0_1.OnlyDlc)

				if var_27_4 ~= var_27_5 then
					self.skinOriginTxt_.text = var_27_5
				end
			end

			SetActive(self.costiconImg_.gameObject, true)

			self.costiconImg_.sprite = ItemTools.getItemLittleSprite(var_27_26)
			self.priceText_.text = var_27_4

			if var_27_4 > ItemTools.getItemNum(var_27_26) then
				self.priceText_.text = "<color=#FF000B>" .. var_27_4 .. "</color>"
			end
		end

		if #self.shopCfg.give_back_list ~= 0 then
			self.rebackSkinTicketText_.text = self.shopCfg.give_back_list[1].num
			self.allrebackTxt_.text = ""
		end

		self.allrebackTxt_.text = ""
		self.allPriceTxt_.text = ""

		SetActive(self.kuoGo_, false)
	end

	if self.dlcID and self.dlcID ~= 0 then
		local var_27_29 = ShopTools.HasMultiPay(self.dlcID)

		self.multiTabController:SetSelectedState((self.showModel == var_0_1.OnlyDlc or self.showModel == var_0_1.BuyDlcAndSkin) and var_27_29 and "true" or "false")
		self.multiPayController:SetSelectedState(tostring(var_27_29 and self.showModel == var_0_1.OnlySkin))

		if var_27_29 then
			local var_27_30, var_27_31, var_27_32, var_27_33, var_27_34 = ShopTools.GetPrice(self.dlcID)

			SetActive(self.currencyOriPriceText2_.gameObject, var_27_33 ~= var_27_34)
			SetActive(self.currencyOriPriceText1_.gameObject, var_27_30 ~= var_27_31)

			self.currencyPriceText1_.text = var_27_30
			self.currencyOriPriceText1_.text = var_27_31
			self.currencyPriceText2_.text = var_27_33
			self.currencyOriPriceText2_.text = var_27_34
		else
			self.selectCurrencyIndex = 1
		end
	else
		self.multiTabController:SetSelectedState("false")
	end
end

function NewSkinBuyCheckView:UpdateTitle()
	if self.showModel == var_0_1.OnlyDlc or self.showModel == var_0_1.BuyDlcAndSkin or self.showModel == var_0_1.FakeData then
		self.textnameText_.text = ItemTools.getItemName(self.itemDlcCfg.id)
		self.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(self.itemDlcCfg.id)) .. ItemTools.getItemDesc(self.itemDlcCfg.id)
	else
		self.textnameText_.text = ItemTools.getItemName(self.shopCfg.description)
		self.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(self.shopCfg.description)) .. ItemTools.getItemDesc(self.descID)
	end
end

function NewSkinBuyCheckView:UpdateDLCBg()
	local var_29_0 = self.itemDlcCfg and HomeSceneSettingCfg[self.itemDlcCfg.id]

	if var_29_0 and var_29_0.prefix then
		self.dlcBgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. var_29_0.prefix)
	end
end

function NewSkinBuyCheckView:UpdateDLCInfo()
	if self.showModel == var_0_1.FakeData then
		self.littleSkinIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", self.skinCfg.picture_id)
		self.dlcItemNameTxt_.text = string.format(ItemTools.getItemName(self.desCfg.id))
		self.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. self.skinCfg.id .. "_character")

		self.dlcbtnController:SetSelectedState("Events")
	else
		if self.shopDlcCfg.shop_id == self.shopID then
			local var_30_0 = ShopTools.HasMultiPay(self.dlcID)

			if ShopTools.CheckDlcPurchased(self.dlcID) then
				self.dlcbtnController:SetSelectedState("get")
			elseif ShopTools.CheckDlcCanBuy(self.dlcID) then
				if self.showModel == var_0_1.BuyDlcAndSkin then
					self.dlcbtnController:SetSelectedState("buy")
				else
					self.dlcbtnController:SetSelectedState("notBuy")
				end
			else
				self.dlcbtnController:SetSelectedState("cannotBuy")
			end

			self.dlcbuyTxt_.text = GetTipsF("BUY_SKIN_DLC_TIPS", ItemTools.getItemName(self.itemDlcCfg.id))
		else
			self.dlcbtnController:SetSelectedState("cannotBuy")
		end

		self:UpdateDLCBg()

		self.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. self.skinCfg.id .. "_character")
		self.dlcLittleIcon_.sprite = ItemTools.getItemSprite(self.itemDlcCfg.id)
		self.dlcItemNameTxt_.text = ItemTools.getItemName(self.itemDlcCfg.id)
	end
end

function NewSkinBuyCheckView:UpdateView()
	self:UpdateOathUI()
	self:UpdatePrice()
	self:UpdateTitle()
	SetActive(self.dlcItemLimit_, false)
	SetActive(self.freeGiveGo_, false)
	self.dlcselController:SetSelectedState((self.showModel == var_0_1.OnlyDlc or self.showModel == var_0_1.BuyDlcAndSkin or self.showModel == var_0_1.FakeData) and "true" or "false")
	SetActive(self.giveBackGo_, #self.shopCfg.give_back_list ~= 0 and self.showModel ~= var_0_1.OnlyDlc)

	if nullable(self.shopCfg.give_back_list, 2) and self.showModel ~= var_0_1.OnlyDlc then
		self.giveBackItem2:SetData((rewardToItemTemplate(formatReward(self.shopCfg.give_back_list[2]), nil, true)))
		SetActive(self.giveBackItem2.gameObject_, true)
	else
		SetActive(self.giveBackItem2.gameObject_, false)
	end

	SetActive(self.skinRemainGo_, false)

	self.skinImg_.sprite = getSpriteViaConfig("HeroIcon", self.skinCfg.picture_id)

	self.skinImg_:SetNativeSize()

	if self.dlcID == 0 or self.showModel == var_0_1.OnlyDlc then
		if self.showModel == var_0_1.OnlyDlc then
			self:UpdateDLCBg()
		end

		self.dlcIconController:SetSelectedState("false")
	else
		self.dlcIconController:SetSelectedState("true")
		self:UpdateDLCInfo()
	end

	self:UpdateTimeView()
	self:UpdateSkinDiscountGift()
end

function NewSkinBuyCheckView:UpdateTimer()
	self:UpdateTimeView()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimeView()
		end, 1, -1, -1)

		self.timer_:Start()
	end
end

function NewSkinBuyCheckView:UpdateTimeView()
	if (self.showModel == var_0_1.OnlyDlc or self.showModel == var_0_1.BuyDlcAndSkin or self.showModel == var_0_1.FakeData) and self.shopDlcCfg then
		local var_34_0, var_34_1, var_34_2, var_34_3, var_34_4 = ShopTools.IsOnDiscountArea(self.dlcID)
		local var_34_5 = self.shopDlcCfg.cheap_close_time
		local var_34_6 = self.shopDlcCfg.is_limit_time_discount

		if self.selectCurrencyIndex == 2 then
			var_34_5 = self.shopDlcCfg.cheap_close_time_2
			var_34_6 = self.shopDlcCfg.is_limit_time_discount_2
			var_34_0 = var_34_0 and (var_34_3 == 2 or var_34_3 == 3)
		else
			var_34_0 = var_34_0 and (var_34_3 == 1 or var_34_3 == 3)
		end

		if var_34_0 and var_34_2 and var_34_6 == 1 then
			SetActive(self.dlcItemLimit_, true)

			self.dlcItemLimitTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(var_34_5))
		else
			SetActive(self.dlcItemLimit_, false)
		end
	else
		SetActive(self.dlcItemLimit_, false)
	end

	local var_34_7 = self.shopCfg.close_time
	local var_34_8 = self.shopCfg

	if self.showModel == var_0_1.OnlyDlc then
		var_34_7 = self.shopDlcCfg.close_time
		var_34_8 = self.shopDlcCfg
	end

	SetActive(self.timeGo_, #var_34_7 > 0)

	if #var_34_7 <= 0 then
		self.discountController:SetSelectedState("none")
	end

	if #var_34_7 > 0 then
		local var_34_9 = TimeMgr.GetInstance():parseTimeFromConfig(var_34_7)

		self.remainTxt_.text = var_34_9 <= TimeMgr.GetInstance():GetServerTime() and GetTips("TIP_EXPIRED") or string.format("%s", manager.time:GetLostTimeStr(var_34_9))
	end

	local var_34_10, var_34_11, var_34_12, var_34_13 = ShopTools.IsOnDiscountArea(var_34_8.goods_id)
	local var_34_14 = var_34_8.cheap_close_time
	local var_34_15 = var_34_8.is_limit_time_discount

	if self.showModel == var_0_1.OnlyDlc or self.showModel == var_0_1.BuyDlcAndSkin or self.showModel == var_0_1.FakeData then
		if self.selectCurrencyIndex == 2 then
			var_34_14 = var_34_8.cheap_close_time_2
			var_34_15 = var_34_8.is_limit_time_discount_2
			var_34_10 = var_34_10 and (var_34_13 == 2 or var_34_13 == 3)
		else
			var_34_10 = var_34_10 and (var_34_13 == 1 or var_34_13 == 3)
		end
	end

	if #var_34_14 > 0 and var_34_15 == 1 then
		if var_34_10 and var_34_12 then
			self.discountController:SetSelectedState("limitedtime")
			SetActive(self.skinRemainGo_, var_34_15 == 1)

			self.skinRemianTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(var_34_14))
		else
			self.discountController:SetSelectedState("none")
			SetActive(self.skinRemainGo_, false)
		end
	else
		self.discountController:SetSelectedState("none")
		SetActive(self.skinRemainGo_, false)
	end

	self:UpdatePrice()
end

function NewSkinBuyCheckView:UpdateSkinDiscountGift()
	if SkinDiscountGiftTools.HasDiscountGoodsID(self.goodID) then
		self.skinDiscountController:SetSelectedState("state1")
	else
		self.skinDiscountController:SetSelectedState("state0")
	end
end

function NewSkinBuyCheckView:UpdateOathUI()
	if not OathDrawTools.CheckIsCanBuyOathSkin(self.heroID, self.skinID) then
		self.oathDrawStateController:SetSelectedState("hide")
	elseif ShopTools.HaveSkin(self.skinCfg.id) then
		self.oathDrawStateController:SetSelectedState("hide")
	elseif self.skinID == ActivityOathDrawData:GetSkinID() then
		self.oathDrawStateController:SetSelectedState("show")
	else
		self.oathDrawStateController:SetSelectedState("hide")
	end
end

function NewSkinBuyCheckView:SelectCurrencyTab(arg_37_1)
	if self.dlcID and self.dlcID ~= 0 then
		local var_37_0 = ShopTools.HasMultiPay(self.dlcID)

		self.selectCurrencyIndex = arg_37_1

		self.multiSelectTabController:SetSelectedState(arg_37_1 == 1 and "select1" or "select2")
	end

	self:UpdateTimeView()
end

function NewSkinBuyCheckView:OnEnter()
	self.goodID = self.params_.goodID
	self.heroID = self.params_.heroID
	self.skinID = self.params_.skinID
	self.selectDLC = not self.params_.onlySkin
	self.selectCurrencyIndex = self.params_.selectCurrencyIndex or 1

	self:UpdateData()
	self:UpdateView()
	self:UpdateTimer()
	self:SelectCurrencyTab(self.selectCurrencyIndex)
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_39_0)
		local var_39_0 = HeroTools.GetSkinChangeItem(self.skinID)

		self:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(var_39_0)),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						item_info = {
							num = 1,
							id = var_39_0
						},
						use_list = {}
					}
				})
			end
		})
	end)
end

function NewSkinBuyCheckView:OnExit()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function NewSkinBuyCheckView:Dispose()
	self.giveBackItem2:Dispose()
	NewSkinBuyCheckView.super.Dispose(self)
end

return NewSkinBuyCheckView
