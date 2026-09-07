local NewShopMainScene = class("NewShopMainScene", import("...base.BaseUI"))

NewShopMainScene.CLOSE_ALL_LAYER = "NewShopMainScene.CLOSE_ALL_LAYER"
NewShopMainScene.SHOW_OR_HIDE_UI = "NewShopMainScene.SHOW_OR_HIDE_UI"
NewShopMainScene.SHOW_OR_HIDE_UI_2 = "NewShopMainScene.SHOW_OR_HIDE_UI_2"
NewShopMainScene.CLOSE_VIEW = "NewShopMainScene.CLOSE_VIEW"
NewShopMainScene.TYPE_CHARGE = "charge"
NewShopMainScene.TYPE_SKIN = "skin"
NewShopMainScene.ON_CLICK_SKIN_SHOP = "NewShopMainScene::ON_CLICK_SKIN_SHOP"

function NewShopMainScene:getUIName()
	return "NewShopUI"
end

function NewShopMainScene:preload(arg_2_1)
	local var_2_0 = getProxy(ShopsProxy)

	local function var_2_1()
		local var_3_0 = var_2_0:getFirstChargeList()
		local var_3_1 = var_2_0:getChargedList()
		local var_3_2 = var_2_0:GetNormalList()
		local var_3_3 = var_2_0:GetNormalGroupList()

		if var_3_0 then
			self:setFirstChargeIds(var_3_0)
		end

		if var_3_1 then
			self:setChargedList(var_3_1)
		end

		if var_3_2 then
			self:setNormalList(var_3_2)
		end

		if var_3_3 then
			self:setNormalGroupList(var_3_3)
		end

		arg_2_1()

		return
	end

	if var_2_0:ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = var_2_1
		})
	else
		var_2_1()
	end

	return
end

function NewShopMainScene:init()
	local var_4_0 = self._tf:Find("buttonList")

	self.buttonList = var_4_0
	self.backBtn = var_4_0:Find("top/closeBtn")
	self.homeBtn = var_4_0:Find("top/homeBtn")
	self.resourcePanel = var_4_0:Find("top/resources")

	setActive(self.resourcePanel, false)

	self.goldBtn = var_4_0:Find("top/resources/gold")
	self.goldText = var_4_0:Find("top/resources/gold/Text"):GetComponent(typeof(Text))
	self.goldMax = var_4_0:Find("top/resources/gold/max"):GetComponent(typeof(Text))
	self.oilBtn = var_4_0:Find("top/resources/oil")
	self.oilText = var_4_0:Find("top/resources/oil/Text"):GetComponent(typeof(Text))
	self.oilMax = var_4_0:Find("top/resources/oil/max"):GetComponent(typeof(Text))
	self.diamondBtn = var_4_0:Find("top/resources/gem")
	self.diamondText = var_4_0:Find("top/resources/gem/Text"):GetComponent(typeof(Text))

	setText(var_4_0:Find("top/title/Text"), i18n("shop_title"))
	setText(var_4_0:Find("shop1List/recommendation/shop1Tg/name"), i18n("shop_recommend"))
	setText(var_4_0:Find("shop1List/skinShop/shop1Tg/name"), i18n("shop_skin"))
	setText(var_4_0:Find("shop1List/diamondShop/shop1Tg/name"), i18n("shop_diamond_title"))
	setText(var_4_0:Find("shop1List/specialShop/shop1Tg/name"), i18n("shop_akashi_pick_title"))
	setText(var_4_0:Find("shop1List/giftPackShop/shop1Tg/name"), i18n("shop_gift_title"))
	setText(var_4_0:Find("shop1List/functionalItemShop/shop1Tg/name"), i18n("shop_item_title"))
	setText(var_4_0:Find("shop1List/supplyShop/shop1Tg/name"), i18n("shop_supply_prop"))
	setText(var_4_0:Find("shop1List/recommendation/shop1Tg/name/en"), i18n("shop_recommend_en"))
	setText(var_4_0:Find("shop1List/skinShop/shop1Tg/name/en"), i18n("shop_skin_en"))
	setText(var_4_0:Find("shop1List/diamondShop/shop1Tg/name/en"), i18n("shop_diamond_title_en"))
	setText(var_4_0:Find("shop1List/specialShop/shop1Tg/name/en"), i18n("shop_side_lable_en"))
	setText(var_4_0:Find("shop1List/giftPackShop/shop1Tg/name/en"), i18n("shop_gift_title_en"))
	setText(var_4_0:Find("shop1List/functionalItemShop/shop1Tg/name/en"), i18n("shop_item_title_en"))
	setText(var_4_0:Find("shop1List/supplyShop/shop1Tg/name/en"), i18n("shop_supply_prop_en"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/monthShop/name"), i18n("shop_month"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/monthShop/selected/name"), i18n("shop_month"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/supplyShop/name"), i18n("shop_supply"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/supplyShop/selected/name"), i18n("shop_supply"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/activityShop/name"), i18n("shop_activity"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/activityShop/selected/name"), i18n("shop_activity"))

	self.frame = self._tf:Find("frame")
	self.viewContainer = self._tf:Find("viewContainer")
	self.painting = self._tf:Find("frame/painting")
	self.chat = self._tf:Find("frame/chat")
	self.chatText = self.chat:Find("Text")
	self.stamp = self._tf:Find("frame/stamp")
	self.specialTip = var_4_0:Find("shop1List/specialShop/shop1Tg/tip")
	self.giftTip = var_4_0:Find("shop1List/giftPackShop/shop1Tg/tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.specialTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_5_0)
		getProxy(ShopsProxy):GiftPackageRedDotTip({
			arg_5_0
		}, true)

		return
	end)
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.giftTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_6_0)
		getProxy(ShopsProxy):GiftPackageRedDotTip({
			arg_6_0
		}, false)

		return
	end)

	self.toggleList = {
		{
			type = ChargeScene.TYPE_DIAMOND,
			go = var_4_0:Find("shop1List/diamondShop/shop1Tg")
		},
		{
			type = ChargeScene.TYPE_GIFT,
			go = var_4_0:Find("shop1List/giftPackShop/shop1Tg")
		},
		{
			type = ChargeScene.TYPE_ITEM,
			go = var_4_0:Find("shop1List/functionalItemShop/shop1Tg")
		},
		{
			type = ChargeScene.TYPE_PICK,
			go = var_4_0:Find("shop1List/specialShop/shop1Tg")
		}
	}
	GetComponent(var_4_0:Find("shop1List/supplyShop/shop2List/supplyShop"), typeof(Toggle)).isOn = true
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)

	self:LoadMingshi()
	self:jpUIInit()
	self:blurView()
	self:initSubView()

	self.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(self, self.pageContainer, Vector2.New(-35, -90))

	if self.bulinTip then
		self.bulinTip:RegisterView(self)
		self.bulinTip:CallbackInvoke(function()
			self:OverlayPanel(self.bulinTip._tf, {
				groupDelta = 1
			})

			return
		end)

		function self.bulinTip.destroyCall()
			if self.bulinTip:GetLoaded() then
				self:UnOverlayPanel(self.bulinTip._tf)
			end

			return
		end
	end

	return
end

function NewShopMainScene:setPlayer(arg_9_1)
	self.player = arg_9_1

	if self.subViewList[self.curSubViewNum] and self.subViewList[self.curSubViewNum]:IsSupplyShop() then
		self.subViewList[self.curSubViewNum]:SetPlayer(arg_9_1)
	end

	if self.goldMax then
		PlayerResUI.StaticFlush(self.player, self.goldMax, self.goldText, self.oilMax, self.oilText, self.diamondText)
	end

	return
end

function NewShopMainScene:setFirstChargeIds(arg_10_1)
	self.firstChargeIds = arg_10_1

	return
end

function NewShopMainScene:setChargedList(arg_11_1)
	self.chargedList = arg_11_1

	return
end

function NewShopMainScene:setNormalList(arg_12_1)
	self.normalList = arg_12_1

	return
end

function NewShopMainScene:setNormalGroupList(arg_13_1)
	self.normalGroupList = arg_13_1

	self:addRefreshTimer(GetZeroTime())

	return
end

function NewShopMainScene:SetSupplyShopList(arg_14_1)
	self.supplyShopList = arg_14_1

	self:SortActivityShops()

	return
end

function NewShopMainScene:SortActivityShops()
	for iter_15_0, iter_15_1 in pairs(self.supplyShopList) do
		if #iter_15_1 > 1 then
			table.sort(iter_15_1, function(arg_16_0, arg_16_1)
				return arg_16_0:getStartTime() > arg_16_1:getStartTime()
			end)
		end
	end

	return
end

function NewShopMainScene:OnInitItems(arg_17_1)
	self.items = arg_17_1

	self.subViewList[ShopConst.SHOP_ID.MONTH]:OnUpdateItems(arg_17_1)
	self.subViewList[ShopConst.SHOP_ID.SUPPLY]:OnUpdateItems(arg_17_1)
	self.subViewList[ShopConst.SHOP_ID.ACTIVITY]:OnUpdateItems(arg_17_1)

	return
end

function NewShopMainScene:OnUpdateItems(arg_18_1)
	self.items = arg_18_1

	if self.subViewList[self.curSubViewNum] and self.subViewList[self.curSubViewNum]:IsSupplyShop() then
		self.subViewList[self.curSubViewNum]:OnUpdateItems(arg_18_1)
	end

	return
end

function NewShopMainScene:OnUpdateShop(arg_19_1, arg_19_2)
	self:SetShop(arg_19_1, arg_19_2)

	if self.subViewList[self.curSubViewNum] and self.subViewList[self.curSubViewNum]:IsSupplyShop() then
		self.subViewList[self.curSubViewNum]:OnUpdateShop(arg_19_1, arg_19_2)
	end

	return
end

function NewShopMainScene:OnUpdateCommodity(arg_20_1, arg_20_2, arg_20_3)
	self:SetShop(arg_20_1, arg_20_2)

	if self.subViewList[self.curSubViewNum] and self.subViewList[self.curSubViewNum]:IsSupplyShop() then
		self.subViewList[self.curSubViewNum]:OnUpdateCommodity(arg_20_1, arg_20_2, arg_20_3)
	end

	return
end

function NewShopMainScene:OnFragmentSellUpdate()
	if self.subViewList[self.curSubViewNum] and self.subViewList[self.curSubViewNum]:IsSupplyShop() then
		self.subViewList[self.curSubViewNum]:OnFragmentSellUpdate()
	end

	return
end

function NewShopMainScene:SetShop(arg_22_1, arg_22_2)
	if not self.supplyShopList then
		return
	end

	if self.supplyShopList[arg_22_1] then
		for iter_22_0, iter_22_1 in ipairs(self.supplyShopList[arg_22_1]) do
			if iter_22_1:IsSameKind(arg_22_2) then
				self.supplyShopList[arg_22_1][iter_22_0] = arg_22_2

				break
			end
		end
	end

	return
end

function NewShopMainScene:didEnter()
	self.eventIDList = {
		self:bind(NewShopMainScene.ON_CLICK_SKIN_SHOP, handler(self, self.OnClickSkinShop))
	}

	setActive(self.chat, false)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(NewShopMainScene.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.goldBtn, function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, self.oilBtn, function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, self.diamondBtn, function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	onToggle(self, self.buttonList:Find("shop1List/recommendation/shop1Tg"), function(arg_29_0)
		if arg_29_0 then
			self.contextData.shop1 = nil
			self.contextData.shop2 = nil

			if self.shop1 == "recommendation" then
				return
			end

			self.shop1 = "recommendation"
			self.shop2 = nil

			self:ShowChargeWarp(false)
			pg.m02:sendNotification(NewShopMainScene.CLOSE_ALL_LAYER)
			self:emit(NewShopMainMediator.OPEN_LAYER, NewRecommendationShopLayer, NewRecommendationShopMediator)
		end

		return
	end, SFX_PANEL)
	self:InitSkinToggleList()

	for iter_23_0 = 1, #self.toggleList do
		local var_23_0 = self.toggleList[iter_23_0]

		onToggle(self, self.toggleList[iter_23_0].go, function(arg_30_0)
			if arg_30_0 then
				self:ShowChargeWarp(true)
				pg.m02:sendNotification(NewShopMainScene.CLOSE_ALL_LAYER)

				self.contextData.shop1 = nil
				self.contextData.shop2 = nil
				self.shop1 = nil
				self.shop2 = nil

				originalPrint(string.format("Begin: toggleType=%s, goName=%s", var_23_0.type, var_23_0.go.parent.name))

				self.contextData.type = ShopConst.SHOP_TYPE.CHARGE
				self.contextData.warp = var_23_0.type

				originalPrint(string.format("End: warp=%s", self.contextData.warp))
				self:switchSubView((self:GetShopID(ShopConst.SHOP_TYPE.CHARGE, var_23_0.type)))
			end

			local var_30_0 = switch(var_23_0.type, {
				[ChargeScene.TYPE_PICK] = function()
					return "payshop_pack_red_dot"
				end,
				[ChargeScene.TYPE_GIFT] = function()
					return "gemshop_pack_red_dot"
				end
			})

			if var_30_0 then
				if arg_30_0 then
					self.toggleMark = self.toggleMark or {}
					self.toggleMark[var_23_0.type] = defaultValue(self.toggleMark[var_23_0.type], 0) + 1
				elseif self.toggleMark and defaultValue(self.toggleMark[var_23_0.type], 0) > 0 then
					self.toggleMark[var_23_0.type] = self.toggleMark[var_23_0.type] - 1

					PlayerPrefs.SetInt(var_30_0, getGameset(var_30_0)[1])
					pg.EasyRedDotMgr.GetInstance():TriggerMarks("Charge_Page_Exposure")
				end
			end

			return
		end, SFX_PANEL)
	end

	onToggle(self, self.buttonList:Find("shop1List/supplyShop/shop1Tg"), function(arg_33_0)
		setActive(self.buttonList:Find("shop1List/supplyShop/shop2List"), arg_33_0)

		if arg_33_0 then
			triggerToggle(self.buttonList:Find("shop1List/supplyShop/shop2List/" .. self:GetDefaultSupplyShopName()), true)
		end

		return
	end, SFX_PANEL)

	for iter_23_1, iter_23_2 in ipairs({
		{
			type = ShopConst.CATEGORY_MONTH,
			go = self.buttonList:Find("shop1List/supplyShop/shop2List/monthShop")
		},
		{
			type = ShopConst.CATEGORY_SUPPLY,
			go = self.buttonList:Find("shop1List/supplyShop/shop2List/supplyShop")
		},
		{
			type = ShopConst.CATEGORY_ACTIVITY,
			go = self.buttonList:Find("shop1List/supplyShop/shop2List/activityShop")
		}
	}) do
		onToggle(self, iter_23_2.go, function(arg_34_0)
			if arg_34_0 then
				self:ShowChargeWarp(true)
				pg.m02:sendNotification(NewShopMainScene.CLOSE_ALL_LAYER)

				self.contextData.shop1 = nil
				self.contextData.shop2 = nil
				self.shop1 = nil
				self.shop2 = nil
				self.contextData.type = ShopConst.SHOP_TYPE.SUPPLY
				self.contextData.warp = iter_23_2.type

				self:switchSubView((self:GetShopID(ShopConst.SHOP_TYPE.SUPPLY, iter_23_2.type)))
			end

			return
		end, SFX_PANEL)
	end

	local var_23_1 = "recommendation"

	if self.contextData.type == ShopConst.SHOP_TYPE.CHARGE then
		var_23_1 = self.contextData.warp == ChargeScene.TYPE_DIAMOND and "diamondShop" or self.contextData.warp == ChargeScene.TYPE_GIFT and "giftPackShop" or self.contextData.warp == ChargeScene.TYPE_ITEM and "functionalItemShop" or self.contextData.warp == ChargeScene.TYPE_PICK and "specialShop" or "diamondShop"
	elseif self.contextData.type == ShopConst.SHOP_TYPE.SKIN then
		var_23_1 = "skinShop"
	elseif self.contextData.type == ShopConst.SHOP_TYPE.SUPPLY then
		var_23_1 = "supplyShop"
	end

	if self.contextData.shop1 then
		var_23_1 = self.contextData.shop1
	end

	triggerToggle(self.buttonList:Find("shop1List/" .. var_23_1 .. "/shop1Tg"), true)

	if var_23_1 == "skinShop" then
		-- block empty
	elseif var_23_1 == "supplyShop" then
		triggerToggle(self.buttonList:Find("shop1List/supplyShop/shop2List/" .. self:GetDefaultSupplyShopName()), true)
	end

	onButton(self, self.painting, function()
		self:displayShipWord()
		self:emit(NewShopMainMediator.CLICK_MING_SHI)

		return
	end, SFX_PANEL)
	onButton(self, self.stamp, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(4)

		return
	end, SFX_CONFIRM)
	self:RefreshActivityShop()
	self:updateNoRes()
	self:jpUIEnter()

	return
end

function NewShopMainScene:GetDefaultSupplyShopName()
	if self.contextData.type ~= ShopConst.SHOP_TYPE.SUPPLY then
		return "supplyShop"
	end

	local var_37_0 = self.contextData.warp

	if type(self.contextData.warp) == "string" then
		self.contextData.warp = ShopConst.SHOP_NAME_LIST[var_37_0][1]
		self.contextData.shopID = ShopConst.SHOP_NAME_LIST[var_37_0][2]
	elseif type(var_37_0) == "number" and self.contextData.shopID == nil then
		for iter_37_0, iter_37_1 in pairs(ShopConst.SUPPLY_SHOP_LIST) do
			for iter_37_2, iter_37_3 in pairs(iter_37_1) do
				if iter_37_3 == var_37_0 then
					self.contextData.warp = iter_37_0
					self.contextData.shopID = iter_37_3

					break
				end
			end
		end
	end

	return self.contextData.warp == ShopConst.CATEGORY_MONTH and "monthShop" or self.contextData.warp == ShopConst.CATEGORY_SUPPLY and "supplyShop" or self.contextData.warp == ShopConst.CATEGORY_ACTIVITY and "activityShop" or "supplyShop"
end

function NewShopMainScene:RefreshActivityShop()
	setActive(self.buttonList:Find("shop1List/supplyShop/shop2List/activityShop"), #(self.supplyShopList[ShopConst.TYPE_ACTIVITY] or {}) > 0)

	return
end

function NewShopMainScene:ShowOrHideUI(arg_39_1)
	self:setVisible(arg_39_1)
	setActive(self.buttonList, arg_39_1)

	return
end

function NewShopMainScene:ShowOrHideUI2(arg_40_1)
	for iter_40_0 = 0, self._tf.childCount - 1 do
		setActive(self._tf:GetChild(iter_40_0), arg_40_1)
	end

	setActive(self.buttonList:Find("leftBg"), arg_40_1)
	setActive(self.buttonList:Find("shop1List"), arg_40_1)
	setActive(self.buttonList:Find("top"), true)

	return
end

function NewShopMainScene:OnChargeSuccess(arg_41_1)
	self.chargeTipWindow:ExecuteAction("Show", arg_41_1)

	return
end

function NewShopMainScene:LoadMingshi()
	if Live2dConst.GetLive2DArm32MatchAble() then
		local var_42_0 = Ship.New({
			configId = 312011
		}):getPainting()

		LoadPaintingPrefabAsync(self.painting, var_42_0, var_42_0, "mainNormal", function()
			self.loading = false

			return
		end)
	else
		self:createLive2D()
	end

	self:AddLive2dTimer()

	return
end

function NewShopMainScene:AddLive2dTimer()
	self:StopLive2dTimer()

	self.live2dTimer = Timer.New(function()
		local var_45_0 = pg.ChargeShipTalkInfo.Actions[math.random(#pg.ChargeShipTalkInfo.Actions)]

		if self:checkBuyDone(var_45_0.action) then
			self:displayShipWord(nil, false, var_45_0.dialog_index)
		end

		return
	end, 20, -1)

	self.live2dTimer:Start()

	return
end

function NewShopMainScene:StopLive2dTimer()
	if self.live2dTimer then
		self.live2dTimer:Stop()

		self.live2dTimer = nil
	end

	return
end

function NewShopMainScene:ShowChargeWarp(arg_47_1)
	setActive(self.frame, arg_47_1)
	setActive(self.viewContainer, arg_47_1)
	self:ShowResourceBar(arg_47_1)

	if self.subViewList[self.curSubViewNum] then
		if arg_47_1 == false then
			self.subViewList[self.curSubViewNum]:Destroy()

			self.curSubViewNum = 0
		else
			self.subViewList[self.curSubViewNum]:ShowPanel(arg_47_1)
		end
	end

	return
end

function NewShopMainScene:ShowResourceBar(arg_48_1)
	if self.resourceBarFlag == arg_48_1 then
		return
	end

	self.resourceBarFlag = arg_48_1

	setActive(self.resourcePanel, arg_48_1)

	return
end

function NewShopMainScene:willExit()
	for iter_49_0, iter_49_1 in ipairs(self.eventIDList) do
		self:disconnect(iter_49_1)
	end

	self.eventIDList = nil

	if self.bulinTip then
		self.bulinTip:Destroy()

		self.bulinTip = nil
	end

	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.specialTip)
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.giftTip)

	if self.toggleMark then
		for iter_49_2, iter_49_3 in pairs(self.toggleMark) do
			if iter_49_3 > 0 then
				local var_49_0 = switch(iter_49_2, {
					[ChargeScene.TYPE_PICK] = function()
						return "payshop_pack_red_dot"
					end,
					[ChargeScene.TYPE_GIFT] = function()
						return "gemshop_pack_red_dot"
					end
				})

				PlayerPrefs.SetInt(var_49_0, getGameset(var_49_0)[1])
			end
		end

		self.toggleMark = nil
	end

	self:ShowResourceBar()
	self:unBlurView()

	if self.chargeTipWindow then
		self.chargeTipWindow:Destroy()

		self.chargeTipWindow = nil
	end

	self.contextData.singleWindow:Destroy()
	self.contextData.multiWindow:Destroy()
	self.contextData.singleWindowForESkin:Destroy()
	self.contextData.paintingView:Dispose()

	self.contextData.singleWindow = nil
	self.contextData.multiWindow = nil
	self.contextData.singleWindowForESkin = nil
	self.contextData.paintingView = nil
	self.bulinTip = nil

	for iter_49_4, iter_49_5 in pairs(self.subViewList) do
		iter_49_5:Destroy()
	end

	self.subViewList = nil

	if self.heartsTimer then
		self.heartsTimer:Stop()

		self.heartsTimer = nil
	end

	if self.live2dChar then
		self.live2dChar:Dispose()
	end

	self:StopLive2dTimer()
	self:stopCV()
	self:DisposeSkinToggleList()

	if self.giftShopView then
		self.giftShopView:OnDestroy()
	end

	return
end

function NewShopMainScene:onBackPressed()
	if self.contextData.singleWindow:GetLoaded() and self.contextData.singleWindow:isShowing() then
		self.contextData.singleWindow:Close()

		return
	end

	if self.contextData.multiWindow:GetLoaded() and self.contextData.multiWindow:isShowing() then
		self.contextData.multiWindow:Close()

		return
	end

	if self.contextData.singleWindowForESkin:GetLoaded() and self.contextData.singleWindowForESkin:isShowing() then
		self.contextData.singleWindowForESkin:Hide()

		return
	end

	NewShopMainScene.super.onBackPressed(self)

	return
end

function NewShopMainScene:initSubView()
	self.curSubViewNum = 0
	self.subViewList = {
		[ShopConst.SHOP_ID.DIAMOND] = ChargeDiamondShopView.New(self.viewContainer, self.event, self.contextData),
		[ShopConst.SHOP_ID.GIFT] = ChargeGiftShopView.New(self.viewContainer, self.event, self.contextData),
		[ShopConst.SHOP_ID.ITEM] = ChargeItemShopView.New(self.viewContainer, self.event, self.contextData),
		[ShopConst.SHOP_ID.PICK] = ChargePickShopView.New(self.viewContainer, self.event, self.contextData),
		[ShopConst.SHOP_ID.MONTH] = SupplyShopView.New(self.viewContainer, self.event, self.contextData, ShopConst.CATEGORY_MONTH),
		[ShopConst.SHOP_ID.SUPPLY] = SupplyShopView.New(self.viewContainer, self.event, self.contextData, ShopConst.CATEGORY_SUPPLY),
		[ShopConst.SHOP_ID.ACTIVITY] = SupplyShopView.New(self.viewContainer, self.event, self.contextData, ShopConst.CATEGORY_ACTIVITY)
	}

	for iter_53_0, iter_53_1 in pairs(self.subViewList) do
		iter_53_1:RegisterView(self)
	end

	self.contextData.singleWindow = ShopSingleWindow.New(self._tf, self.event)
	self.contextData.multiWindow = ShopMultiWindow.New(self._tf, self.event)
	self.contextData.singleWindowForESkin = EquipmentSkinInfoUIForShopWindow.New(self._tf, self.event)
	self.contextData.paintingView = ShopPaintingView.New(self._tf:Find("frame/supplyPaint"), self._tf:Find("frame/chat"))

	self.contextData.paintingView:setSecretaryPos(self._tf:Find("frame/secretaryPos"))

	return
end

function NewShopMainScene:GetShopID(arg_54_1, arg_54_2)
	return ShopConst.SHOP_LIST[arg_54_1][arg_54_2]
end

function NewShopMainScene:switchSubView(arg_55_1)
	originalPrint(string.format("End: shopID=%s curShopID=%s", arg_55_1, self.curSubViewNum))

	if arg_55_1 == self.curSubViewNum then
		return
	end

	self.subViewList[arg_55_1]:setGoodData(self.firstChargeIds, self.chargedList, self.normalList, self.normalGroupList)
	self.subViewList[arg_55_1]:Reset()
	self.subViewList[arg_55_1]:Load()

	if self.subViewList[arg_55_1].SetAllShopData then
		self.subViewList[arg_55_1]:ActionInvoke("SetAllShopData", self.supplyShopList)
	end

	if self.subViewList[self.curSubViewNum] then
		self.subViewList[self.curSubViewNum]:Destroy()
	end

	self.curSubViewNum = arg_55_1

	self:SwitchPainting(self.subViewList[arg_55_1]:IsSupplyShop())

	if PLATFORM_CODE == PLATFORM_JP then
		setActive(self.userAgreeBtn3, arg_55_1 == ChargeScene.TYPE_DIAMOND)
		setActive(self.userAgreeBtn4, arg_55_1 == ChargeScene.TYPE_DIAMOND)
	end

	return
end

function NewShopMainScene:SwitchPainting(arg_56_1)
	self.contextData.paintingView:Show(arg_56_1)
	setActive(self.painting, not arg_56_1)

	if arg_56_1 then
		self:StopLive2dTimer()

		self.chatFlag = nil

		self:stopCV()
		setActive(self.stamp, getProxy(TaskProxy):mingshiTouchFlagEnabled())

		if LOCK_CLICK_MINGSHI then
			setActive(self.stamp, false)
		end
	else
		setActive(self.stamp, false)
		self:AddLive2dTimer()
	end

	return
end

function NewShopMainScene:switchSubViewByTogger(arg_57_1)
	triggerToggle(self.toggleList[arg_57_1].go, true)

	return
end

function NewShopMainScene:updateCurSubView()
	if not isActive(self.viewContainer) then
		return
	end

	local var_58_0 = self.subViewList[self.curSubViewNum]

	if self.subViewList[self.curSubViewNum] == nil then
		return
	end

	var_58_0:setGoodData(self.firstChargeIds, self.chargedList, self.normalList, self.normalGroupList)
	var_58_0:reUpdateAll()

	return
end

function NewShopMainScene:updateNoRes(arg_59_1)
	if not arg_59_1 then
		arg_59_1 = self.contextData.noRes
	else
		self.contextData.noRes = arg_59_1
	end

	if not arg_59_1 or #arg_59_1 <= 0 then
		return
	end

	self.contextData.noRes = {}

	local var_59_0 = getProxy(BagProxy):getData()
	local var_59_1 = ""

	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		if iter_59_1[2] > 0 then
			arg_59_1[iter_59_0][2] = iter_59_1[1] == 59001 and iter_59_1[3] - self.player.gold or iter_59_1[3] - ((var_59_0[iter_59_1[1]] or nil) and (var_59_0[iter_59_1[1]].count or 0))
		end

		if arg_59_1[iter_59_0][2] > 0 then
			table.insert(self.contextData.noRes, arg_59_1[iter_59_0])
		end
	end

	for iter_59_2, iter_59_3 in ipairs(self.contextData.noRes) do
		var_59_1 = var_59_1 .. i18n(iter_59_3[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", Item.getConfigData(iter_59_3[1]).name, iter_59_3[2])

		if iter_59_2 < #self.contextData.noRes then
			var_59_1 = var_59_1 .. i18n("text_noRes_info_tip_link")
		end
	end

	if var_59_1 == "" then
		self:displayShipWord(i18n("text_shop_enoughRes_tip"), false)
	else
		self:displayShipWord(i18n("text_shop_noRes_tip", var_59_1), true)
	end

	return
end

function NewShopMainScene:displayShipWord(arg_60_1, arg_60_2, arg_60_3)
	if not self.chatFlag then
		if not arg_60_1 and self.contextData.noRes and #self.contextData.noRes > 0 then
			setActive(self.chat, false)

			self.chat.transform.localScale = Vector3(0, 0, 1)
		end

		self.chatFlag = true

		if not self.isInitChatPosition then
			self.isInitChatPosition = true

			self:InitChatPosition()
		end

		setActive(self.chat, true)

		local var_60_0 = arg_60_3 or math.random(1, (self.player:getChargeLevel()))
		local var_60_1 = arg_60_3 and pg.pay_level_award[var_60_0].dialog or arg_60_1 or pg.pay_level_award[var_60_0].dialog

		if not arg_60_1 then
			self:playCV(var_60_0)
		end

		setText(self.chatText, var_60_1)

		local var_60_2 = self.chatText:GetComponent(typeof(Text))

		;(function()
			local var_61_0 = 3
			local var_61_1 = 0.3

			LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(1, 1, 1), 0.3):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				if not arg_60_2 then
					LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(0, 0, 1), var_61_1):setEase(LeanTweenType.easeInBack):setDelay(var_61_1 + var_61_0):setOnComplete(System.Action(function()
						self.chatFlag = nil

						setActive(self.chat, false)

						if self.contextData.noRes and #self.contextData.noRes > 0 then
							self:updateNoRes()
						end

						return
					end))
				else
					self.chatFlag = nil
				end

				return
			end))

			return
		end)()
	end

	return
end

function NewShopMainScene:InitChatPosition()
	return
end

function NewShopMainScene:playHeartEffect()
	if self.heartsTimer then
		self.heartsTimer:Stop()
	end

	local var_65_0 = self.painting:Find("heartsfly")

	setActive(var_65_0, true)

	self.heartsTimer = Timer.New(function()
		setActive(var_65_0, false)

		return
	end, 1, 1)

	self.heartsTimer:Start()

	return
end

function NewShopMainScene:createLive2D()
	self.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
		ship = Ship.New({
			configId = 312011
		}),
		offset = {
			0,
			0,
			0,
			75
		},
		position = Vector3(0, 0, 0),
		parent = self._tf:Find("frame/painting/live2d")
	}), function(arg_68_0)
		arg_68_0:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)

		return
	end)

	return
end

function NewShopMainScene:checkBuyDone(arg_69_1)
	if not self.live2dChar or not self.live2dChar:IsLoaded() then
		return
	end

	local var_69_0

	if type(arg_69_1) == "string" then
		var_69_0 = arg_69_1 == "damonds" and "diamond" or arg_69_1
	else
		local var_69_1 = pg.shop_template[arg_69_1]

		if pg.shop_template[arg_69_1] and var_69_1.effect_args and type(var_69_1.effect_args) == "table" then
			for iter_69_0, iter_69_1 in ipairs(var_69_1.effect_args) do
				if iter_69_1 == 1 then
					var_69_0 = "gold"
				end
			end
		end
	end

	local var_69_2 = (self.preAniName == "gold" or self.preAniName == "diamond") and (var_69_0 == "gold" or var_69_0 == "diamond") or not (self.preAniName == "gold" or self.preAniName == "diamond")

	var_69_2 = var_69_0 and self.preAniName ~= var_69_0 and var_69_2

	if var_69_2 then
		self.preAniName = var_69_0

		self.live2dChar:TriggerAction(var_69_0, nil, true)
	end

	return var_69_2
end

function NewShopMainScene:playCV(arg_70_1)
	local var_70_0

	if pg.pay_level_award[arg_70_1] and pg.pay_level_award[arg_70_1].cv_key ~= "" then
		var_70_0 = "event:/cv/chargeShop/" .. pg.pay_level_award[arg_70_1].cv_key
	end

	if var_70_0 then
		self:stopCV()

		self._currentVoice = var_70_0

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_70_0)
	end

	return
end

function NewShopMainScene:stopCV()
	if self._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self._currentVoice)
	end

	self._currentVoice = nil

	return
end

function NewShopMainScene:blurView()
	self:OverlayPanel(self.buttonList, {
		pbList = {
			self.buttonList:Find("leftBg")
		}
	})

	return
end

function NewShopMainScene:unBlurView()
	self:UnOverlayPanel(self.buttonList, self._tf)

	return
end

function NewShopMainScene:jpUIInit()
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	self.userAgreeBtn3 = self._tf:Find("frame/raw1Btn")
	self.userAgreeBtn4 = self._tf:Find("frame/raw2Btn")

	return
end

function NewShopMainScene:jpUIEnter()
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	onButton(self, self.userAgreeBtn3, function()
		self:emit(NewShopMainMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement3") or "")

		return
	end, SFX_PANEL)
	onButton(self, self.userAgreeBtn4, function()
		self:emit(NewShopMainMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement4") or "")

		return
	end, SFX_PANEL)

	return
end

function NewShopMainScene:addRefreshTimer(arg_78_1)
	local function var_78_0()
		if self.refreshTimer then
			self.refreshTimer:Stop()

			self.refreshTimer = nil
		end

		return
	end

	var_78_0()

	self.refreshTimer = Timer.New(function()
		if arg_78_1 + 1 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
			var_78_0()
			self:emit(NewShopMainMediator.GET_CHARGE_LIST)
		end

		return
	end, 1, -1)

	self.refreshTimer:Start()
	self.refreshTimer.func()

	return
end

function NewShopMainScene:InitSkinToggleList()
	self.uiSkinToggleParent = self.buttonList:Find("shop1List/skinShop/shop2List")
	self.uiSkinToggleItem = self.buttonList:Find("shop1List/skinShop/shop2List/skinToggleItem")

	setActive(self.buttonList:Find("shop1List/skinShop/shop1Tg/timeLimit"), #getProxy(ShipSkinProxy):GetInTimeSkins() > 0)

	self.skinShopList = self:GetSkinShopList()
	self.skinShopItemList = {}

	onToggle(self, self.buttonList:Find("shop1List/skinShop/shop1Tg"), function(arg_82_0)
		setActive(self.buttonList:Find("shop1List/skinShop/shop2List"), arg_82_0)

		if arg_82_0 then
			if self.shop1 == "skinShop" then
				return
			end

			self.shop1 = "skinShop"

			local var_82_0 = self.skinShopItemList[table.keyof(self.skinShopList, self:GetDefaultSkinShop())]

			var_82_0 = self.contextData.shop1 and self.contextData.shop2 and self.skinShopItemList[table.keyof(self.skinShopList, self.contextData.shop2)] or var_82_0
			self.contextData.shop1 = "skinShop"

			var_82_0:TriggerToggle()
		end

		return
	end, SFX_PANEL)

	for iter_81_0, iter_81_1 in ipairs(self.skinShopList) do
		self.skinShopItemList[iter_81_0] = self.skinShopItemList[iter_81_0] or NewShopMainSkinToggleItem.New(Object.Instantiate(self.uiSkinToggleItem, self.uiSkinToggleParent), self)

		self.skinShopItemList[iter_81_0]:didEnter(iter_81_1)
	end

	return
end

function NewShopMainScene:OnClickSkinShop(arg_83_1, arg_83_2)
	self.contextData.shop2 = arg_83_2

	if self.shop2 == arg_83_2 then
		return
	end

	self.shop2 = arg_83_2

	self:ShowChargeWarp(false)
	pg.m02:sendNotification(NewShopMainScene.CLOSE_ALL_LAYER)
	self:emit(NewShopMainMediator.OPEN_LAYER, LatestSkinShopLayer, LatestSkinShopMediator, {
		type = arg_83_2,
		mode = self.contextData.mode
	})

	return
end

function NewShopMainScene:DisposeSkinToggleList()
	for iter_84_0, iter_84_1 in ipairs(self.skinShopItemList) do
		iter_84_1:willExit()
	end

	self.skinShopItemList = nil

	return
end

function NewShopMainScene:GetSkinShopList()
	local var_85_0 = Clone(pg.shop_skin_subsheet.get_id_list_by_type[0])

	if #getProxy(ShipSkinProxy):GetInTimeSkins() <= 0 then
		table.remove(var_85_0, 1)
	end

	local var_85_1 = pg.TimeMgr.GetInstance()
	local var_85_2 = getProxy(ShipSkinProxy):GetAllSkins()

	for iter_85_0, iter_85_1 in ipairs(pg.shop_skin_subsheet.get_id_list_by_type[1] or {}) do
		if var_85_1:inTime(pg.shop_skin_subsheet[iter_85_1].time) then
			for iter_85_2, iter_85_3 in ipairs(var_85_2) do
				if table.keyof(pg.shop_skin_subsheet[iter_85_1].param, iter_85_3.id) then
					table.insert(var_85_0, iter_85_1)

					break
				end
			end
		end
	end

	table.sort(var_85_0, function(arg_86_0, arg_86_1)
		return pg.shop_skin_subsheet[arg_86_0].sort == pg.shop_skin_subsheet[arg_86_0].sort and arg_86_0 < arg_86_1 or pg.shop_skin_subsheet[arg_86_0].sort < pg.shop_skin_subsheet[arg_86_1].sort
	end)

	return var_85_0
end

function NewShopMainScene:GetDefaultSkinShop()
	local var_87_0 = Clone(self.skinShopList)

	table.sort(var_87_0, function(arg_88_0, arg_88_1)
		local var_88_0 = pg.shop_skin_subsheet[arg_88_0]
		local var_88_1 = pg.shop_skin_subsheet[arg_88_1]

		if pg.shop_skin_subsheet[arg_88_0].shop_skin_subsheet == pg.shop_skin_subsheet[arg_88_1].shop_skin_subsheet then
			return var_88_0.sort == var_88_1.sort and arg_88_0 < arg_88_1 or var_88_0.sort < var_88_1.sort
		else
			return var_88_0.shop_skin_subsheet < var_88_1.shop_skin_subsheet
		end

		return
	end)

	return var_87_0[1]
end

return NewShopMainScene
