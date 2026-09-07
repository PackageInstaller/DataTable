local ChargeMenuScene = class("ChargeMenuScene", import("...base.BaseUI"))

function ChargeMenuScene:getUIName()
	return "ChargeMenuUI"
end

function ChargeMenuScene:preload(arg_2_1)
	if getProxy(ShopsProxy):ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = arg_2_1
		})
	else
		arg_2_1()
	end

	return
end

function ChargeMenuScene:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initUIText()
	self:InitBanner()

	return
end

function ChargeMenuScene:didEnter()
	self:updatePlayerRes()
	self:updatePanel()
	self:tryAutoOpenShop()

	return
end

function ChargeMenuScene:ResUISettings()
	return true
end

function ChargeMenuScene:onBackPressed()
	if self.chargeTipWindow and self.chargeTipWindow:GetLoaded() and self.chargeTipWindow:isShowing() then
		self.chargeTipWindow:Hide()

		return
	end

	ChargeMenuScene.super.onBackPressed(self)

	return
end

function ChargeMenuScene:willExit()
	if self.bannerRect then
		self.bannerRect:Dispose()

		self.bannerRect = nil
	end

	if self.chargeOrPurchaseHandler then
		self.chargeOrPurchaseHandler:Dispose()

		self.chargeOrPurchaseHandler = nil
	end

	if self.chargeTipWindow then
		self.chargeTipWindow:Destroy()

		self.chargeTipWindow = nil
	end

	return
end

function ChargeMenuScene:initData()
	return
end

function ChargeMenuScene:initUIText()
	return
end

function ChargeMenuScene:findUI()
	self.blurTF = self._tf:Find("blur_panel")
	self.topTF = self.blurTF:Find("adapt/top")
	self.resTF = self.topTF:Find("res")
	self.backBtn = self.topTF:Find("back_button")
	self.menuTF = self._tf:Find("menu_screen")
	self.skinShopBtn = self.menuTF:Find("skin_shop")
	self.skinLockIcon = self.menuTF:Find("skin_lock")

	local var_10_0 = LOCK_SKIN_SHOP_ENTER and getProxy(PlayerProxy):getData().level < LOCK_SKIN_SHOP_ENTER_LEVEL

	setActive(self.skinShopBtn, not var_10_0)
	setActive(self.skinLockIcon, var_10_0)

	self.diamondShopBtn = self.menuTF:Find("dimond_shop")
	self.itemShopBtn = self.menuTF:Find("props")
	self.giftShopBtn = self.menuTF:Find("gift_shop")
	self.supplyShopBtn = self.menuTF:Find("supply")
	self.monthCardTag = self.diamondShopBtn:Find("monthcard_tag")
	self.giftTag = self.giftShopBtn:Find("tip")
	self.bannerRect = BannerScrollRect.New(self._tf:Find("menu_screen/banner/mask/content"), self._tf:Find("menu_screen/banner/dots"))
	self.chargeOrPurchaseHandler = ChargeOrPurchaseHandler.New()
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)

	return
end

local function var_0_1(arg_11_0, arg_11_1, arg_11_2)
	setText(arg_11_1:Find("name"), arg_11_2:GetName())
	setText(arg_11_1:Find("desc"), arg_11_2:GetDesc())

	local var_11_0 = arg_11_2:GetDropList()
	local var_11_1 = UIItemList.New(arg_11_1:Find("items"), arg_11_1:Find("items/award"))

	var_11_1:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = var_11_0[arg_12_1 + 1]

			updateDrop(arg_12_2, var_11_0[arg_12_1 + 1])
			onButton(arg_11_0, arg_12_2, function()
				arg_11_0:emit(BaseUI.ON_DROP, var_12_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_11_1:align(#var_11_0)

	local var_11_2 = arg_11_2:GetGem()

	setActive(arg_11_1:Find("gem"), var_11_2 > 0)
	setText(arg_11_1:Find("gem/Text"), var_11_2)

	local var_11_3, var_11_4, var_11_5 = arg_11_2:GetPrice()

	setText(arg_11_1:Find("price/Text"), var_11_4)
	setActive(arg_11_1:Find("price/Text/icon"), var_11_3 ~= RecommendCommodity.PRICE_TYPE_RMB)
	setText(arg_11_1:Find("price/Text/label"), var_11_3 == RecommendCommodity.PRICE_TYPE_RMB and GetMoneySymbol() or "")

	local var_11_6 = arg_11_1:Find("icon")

	GetSpriteFromAtlasAsync(arg_11_2:GetIcon(), "", function(arg_14_0)
		setImageSprite(var_11_6, arg_14_0)

		return
	end)

	var_11_6.sizeDelta = Vector2(180, 180)

	return
end

function ChargeMenuScene:InitBanner()
	for iter_15_0, iter_15_1 in ipairs((getProxy(ShopsProxy):GetRecommendCommodities())) do
		local var_15_0 = self.bannerRect:AddChild()

		var_0_1(self, var_15_0, iter_15_1)
		onButton(self, var_15_0, function()
			local var_16_0, var_16_1 = iter_15_1:IsMonthCardAndCantPurchase()

			if var_16_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_16_1)

				return
			end

			self.bannerRect:Pause()

			self.lookUpIndex = iter_15_0

			pg.m02:sendNotification(GAME.TRACK, TrackConst.GetTrackData(TrackConst.SYSTEM_SHOP, TrackConst.ACTION_LOOKUP_RECOMMEND, iter_15_0))
			self.chargeOrPurchaseHandler:ChargeOrPurchaseAsyn(iter_15_1:GetRealCommodity())

			return
		end, SFX_PANEL)
	end

	self.bannerRect:SetUp()

	return
end

function ChargeMenuScene:FlushBanner()
	self.bannerRect:Reset()
	self:InitBanner()

	return
end

function ChargeMenuScene:addListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.skinShopBtn, function()
		self:emit(ChargeMenuMediator.GO_SKIN_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.diamondShopBtn, function()
		self:emit(ChargeMenuMediator.GO_CHARGE_SHOP, ChargeScene.TYPE_DIAMOND)

		return
	end, SFX_PANEL)
	onButton(self, self.giftShopBtn, function()
		self:emit(ChargeMenuMediator.GO_CHARGE_SHOP, ChargeScene.TYPE_GIFT)
		pg.m02:sendNotification(GAME.TRACK, TrackConst.GetTrackData(TrackConst.SYSTEM_SHOP, TrackConst.ACTION_ENTER_GIFT, (isActive(self.giftTag))))

		return
	end, SFX_PANEL)
	onButton(self, self.itemShopBtn, function()
		self:emit(ChargeMenuMediator.GO_CHARGE_SHOP, ChargeScene.TYPE_ITEM)

		return
	end, SFX_PANEL)
	onButton(self, self.supplyShopBtn, function()
		self:emit(ChargeMenuMediator.GO_SUPPLY_SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end, SFX_PANEL)

	return
end

function ChargeMenuScene:updatePlayerRes()
	return
end

function ChargeMenuScene:updatePanel()
	local var_26_0 = getProxy(ActivityProxy)
	local var_26_1 = var_26_0:getActiveBannerByType(GAMEUI_BANNER_9)

	if var_26_1 ~= nil then
		LoadImageSpriteAsync("activitybanner/" .. var_26_1.pic, self.skinShopBtn)
	end

	local var_26_2 = var_26_0:getActiveBannerByType(GAMEUI_BANNER_11)

	if var_26_2 ~= nil then
		LoadImageSpriteAsync("activitybanner/" .. var_26_2.pic, self.giftShopBtn:Find("BG"))
	end

	setActive(self.monthCardTag, (MonthCardOutDateTipPanel.GetShowMonthCardTag()))
	MonthCardOutDateTipPanel.SetMonthCardTagDate()
	TagTipHelper.SetFuDaiTagMark()
	TagTipHelper.SetSkinTagMark()
	TagTipHelper.FreeGiftTag({
		self.giftTag
	})

	return
end

function ChargeMenuScene:tryAutoOpenShop()
	if self.contextData.warp ~= nil then
		if self.contextData.warp == ChargeScene.TYPE_DIAMOND then
			triggerButton(self.diamondShopBtn)
		elseif self.contextData.warp == ChargeScene.TYPE_GIFT then
			triggerButton(self.giftShopBtn)
		elseif self.contextData.warp == ChargeScene.TYPE_ITEM then
			triggerButton(self.itemShopBtn)
		end
	end

	return
end

function ChargeMenuScene:OnRemoveLayer(arg_28_1)
	if arg_28_1.mediator == ChargeItemPanelMediator and self.bannerRect then
		self.bannerRect:Resume()
	end

	return
end

function ChargeMenuScene:OnChargeSuccess(arg_29_1)
	self.chargeTipWindow:ExecuteAction("Show", arg_29_1)

	return
end

return ChargeMenuScene
