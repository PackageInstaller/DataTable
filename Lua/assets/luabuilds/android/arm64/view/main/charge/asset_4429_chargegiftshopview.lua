local ChargeGiftShopView = class("ChargeGiftShopView", import("...base.BaseSubView"))

ChargeGiftShopView.ShowPickUp = false

function ChargeGiftShopView:getUIName()
	return "ChargeGiftShopUI"
end

function ChargeGiftShopView:OnInit()
	self:initData()
	self:initUI()
	self:Show()

	return
end

function ChargeGiftShopView:OnDestroy()
	for iter_3_0, iter_3_1 in pairs(self.chargeCardTable or {}) do
		iter_3_1:Dispose()
	end

	self:removeUpdateTimer()

	return
end

function ChargeGiftShopView:initData()
	self.giftGoodsVOListForShow = {}
	self.packageSortList = {
		0
	}
	self.prevBtn = nil
	self.selectedPackageType = nil
	self.updateTime = nil
	self.updateTimer = nil
	self.player = getProxy(PlayerProxy):getData()

	self:updateData()

	return
end

function ChargeGiftShopView:initUI()
	self.emptyGo = self._tf:Find("emptyText")

	setText(self.emptyGo, i18n("shop_pack_empty"))

	self.lScrollRect = GetComponent(self._tf:Find("lScrollRect"), "LScrollRect")
	self.chargeCardTable = {}

	self:initScrollRect()
	self:initToggleList()
	self:updateToggleList()
	self:updateScrollRect()
	triggerButton(self._tf:Find("toggleGroup"):GetChild(0))

	return
end

function ChargeGiftShopView:GetViewSkinWrap()
	return ChargeScene.TYPE_GIFT
end

function ChargeGiftShopView:initScrollRect(arg_7_1, arg_7_2, arg_7_3)
	self.chargeCardTable = {}

	local function var_7_0(arg_8_0)
		local var_8_0 = ChargeCard.New(arg_8_0)

		onButton(self, var_8_0.tr, function()
			if var_8_0.goods:isChargeType() then
				switch(var_8_0.goods:getShowType(), {
					[Goods.SHOW_TYPE_TECH] = function()
						self:emit(NewShopMainMediator.OPEN_TEC_SHIP_GIFT_SELL_LAYER, var_8_0.goods, self.chargedList)

						return
					end,
					[Goods.SHOW_TYPE_BATTLE_UI] = function()
						self:emit(NewShopMainMediator.OPEN_BATTLE_UI_SELL_LAYER, var_8_0.goods, self.chargedList)

						return
					end
				}, function()
					self:confirm(var_8_0.goods)

					return
				end)
			else
				self:confirm(var_8_0.goods)
			end

			return
		end, SFX_PANEL)
		onButton(self, var_8_0.viewBtn, function()
			if not var_8_0.goods:isChargeType() then
				return
			end

			local var_13_0 = var_8_0.goods:GetSkinProbability()

			if #var_13_0 > 0 then
				if #var_13_0 ~= #getProxy(ShipSkinProxy):GetProbabilitySkins(var_13_0) then
					self:emit(BaseUI.ON_DROP, (var_8_0.goods:GetSkinProbabilityItem()))

					goto label_13_0
				end
			end

			self:emit(NewShopMainMediator.VIEW_SKIN_PROBABILITY, var_8_0.goods.id, self:GetViewSkinWrap())

			::label_13_0::

			return
		end, SFX_PANEL)

		self.chargeCardTable[arg_8_0] = var_8_0

		return
	end

	self.lScrollRect.onInitItem = var_7_0

	function self.lScrollRect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = self.chargeCardTable[arg_14_1]

		if not self.chargeCardTable[arg_14_1] then
			var_7_0(arg_14_1)

			var_14_0 = self.chargeCardTable[arg_14_1]
		end

		if self.filterList[arg_14_0 + 1] then
			var_14_0:update(self.filterList[arg_14_0 + 1], self.player, self.firstChargeIds)
		end

		return
	end

	return
end

function ChargeGiftShopView:updateToggleList()
	self.uiToggleList:align(#self.packageSortList)

	return
end

function ChargeGiftShopView:updateScrollRect()
	self.filterList = self:getFilterList()
	self.lScrollRect.enabled = true

	self.lScrollRect:SetTotalCount(#self.filterList, self.lScrollRect.value)
	setActive(self.emptyGo, #self.filterList <= 0)

	return
end

function ChargeGiftShopView:confirm(arg_17_1)
	if not arg_17_1 then
		return
	end

	arg_17_1 = Clone(arg_17_1)

	if arg_17_1:isChargeType() then
		local var_17_0 = not table.contains(self.firstChargeIds, arg_17_1.id) and arg_17_1:firstPayDouble()
		local var_17_1 = var_17_0 and 4 or arg_17_1:getConfig("tag")

		if arg_17_1:isMonthCard() or arg_17_1:isGiftBox() or arg_17_1:isItemBox() or arg_17_1:isPassItem() then
			local var_17_2 = arg_17_1:GetExtraServiceItem()
			local var_17_3 = arg_17_1:GetExtraDrop()
			local var_17_4 = arg_17_1:GetBonusItem()
			local var_17_5
			local var_17_6

			if arg_17_1:isPassItem() then
				var_17_5 = i18n("battlepass_pay_tip")
			elseif arg_17_1:isMonthCard() then
				var_17_5 = i18n("charge_title_getitem_month")
				var_17_6 = i18n("charge_title_getitem_soon")
			else
				var_17_5 = i18n("charge_title_getitem")
			end

			self:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_PANEL, {
				isChargeType = true,
				commodity = arg_17_1,
				infoTip = arg_17_1:GetInfoTip(),
				icon = "chargeicon/" .. arg_17_1:getConfig("picture"),
				name = arg_17_1:getConfig("name_display"),
				tipExtra = var_17_5,
				extraItems = var_17_2,
				price = arg_17_1:getConfig("money"),
				isLocalPrice = arg_17_1:IsLocalPrice(),
				tagType = var_17_1,
				isMonthCard = arg_17_1:isMonthCard(),
				tipBonus = var_17_6,
				bonusItem = var_17_4,
				extraDrop = var_17_3,
				descExtra = arg_17_1:getConfig("descrip_extra"),
				limitArgs = arg_17_1:getConfig("limit_args"),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(NewShopMainMediator.OPEN_CHARGE_BIRTHDAY)
					else
						self:emit(NewShopMainMediator.CHARGE, arg_17_1.id)
					end

					return
				end
			})
		elseif arg_17_1:isGem() then
			local var_17_7 = arg_17_1:getConfig("money")
			local var_17_8 = arg_17_1:getConfig("gem")

			var_17_8 = var_17_0 and var_17_8 + arg_17_1:getConfig("gem") or var_17_8 + arg_17_1:getConfig("extra_gem")

			self:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_BOX, {
				isChargeType = true,
				commodity = arg_17_1,
				icon = "chargeicon/" .. arg_17_1:getConfig("picture"),
				name = arg_17_1:getConfig("name_display"),
				price = arg_17_1:getConfig("money"),
				isLocalPrice = arg_17_1:IsLocalPrice(),
				tagType = var_17_1,
				normalTip = i18n("charge_start_tip", var_17_7, var_17_8),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(NewShopMainMediator.OPEN_CHARGE_BIRTHDAY)
					else
						self:emit(NewShopMainMediator.CHARGE, arg_17_1.id)
					end

					return
				end
			})
		end
	elseif arg_17_1:isActGiftPackage() then
		self:emit(NewShopMainMediator.OPEN_GIFT_ACT_LAYER, arg_17_1:getBindActivity().id)
	else
		local var_17_9 = {}
		local var_17_10 = Item.getConfigData(arg_17_1:getConfig("effect_args")[1])

		if type(var_17_10.display_icon) == "table" then
			for iter_17_0, iter_17_1 in ipairs(var_17_10.display_icon) do
				table.insert(var_17_9, Drop.New({
					type = iter_17_1[1],
					id = iter_17_1[2],
					count = iter_17_1[3]
				}))
			end
		end

		self:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_PANEL, {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_17_1,
			icon = var_17_10.icon,
			name = var_17_10.name,
			tipExtra = i18n("charge_title_getitem"),
			extraItems = var_17_9,
			price = arg_17_1:getConfig("resource_num"),
			tagType = arg_17_1:getConfig("tag"),
			onYes = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("charge_scene_buy_confirm", arg_17_1:getConfig("resource_num"), var_17_10.name),
					onYes = function()
						self:emit(NewShopMainMediator.BUY_ITEM, arg_17_1.id, 1)

						return
					end
				})

				return
			end
		})
	end

	return
end

function ChargeGiftShopView:initToggleList()
	self.uiToggleList = UIItemList.New(self._tf:Find("toggleGroup"), self._tf:Find("toggleGroup/Toggle"))

	self.uiToggleList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventInit then
			setText(arg_23_2:Find("selected/Label"), i18n(string.format("shop_package_sort_%s", self.packageSortList[arg_23_1 + 1])))
			setText(arg_23_2:Find("selected/enText"), i18n(string.format("shop_package_sort_en_%s", self.packageSortList[arg_23_1 + 1])))
			setText(arg_23_2:Find("unselected/Label"), i18n(string.format("shop_package_sort_%s", self.packageSortList[arg_23_1 + 1])))
			setActive(arg_23_2:Find("unselected"), true)
			setActive(arg_23_2:Find("selected"), false)
		elseif arg_23_0 == UIItemList.EventUpdate then
			onButton(self, arg_23_2, function()
				if self.selectedPackageType == self.packageSortList[arg_23_1 + 1] then
					return
				end

				setActive(arg_23_2:Find("unselected"), false)
				setActive(arg_23_2:Find("selected"), true)

				if self.prevBtn then
					setActive(self.prevBtn:Find("unselected"), true)
					setActive(self.prevBtn:Find("selected"), false)
				end

				self.prevBtn = arg_23_2
				self.selectedPackageType = self.packageSortList[arg_23_1 + 1]

				self:updateScrollRect()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function ChargeGiftShopView:sortGiftGoodsVOList()
	local var_25_1

	self.giftGoodsVOListForShow, var_25_1 = getProxy(ShopsProxy):GetAllShowGiftPackages(self.ShowPickUp)
	self.packageSortList = {
		0
	}

	local var_25_2 = {
		[0] = true
	}

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_3, var_25_4 = pg.TimeMgr.GetInstance():inTime(iter_25_1:getConfig("time"))

		if var_25_4 then
			self:addUpdateTimer(var_25_4)
		end
	end

	for iter_25_2, iter_25_3 in ipairs(self.giftGoodsVOListForShow) do
		if not iter_25_3:isChargeType() then
			local var_25_5, var_25_6 = pg.TimeMgr.GetInstance():inTime(iter_25_3:getConfig("time"))

			if var_25_6 then
				self:addUpdateTimer(var_25_6)
			end
		end

		local var_25_7 = iter_25_3:getConfig("package_sort_id")

		if not var_25_2[var_25_7] then
			var_25_2[var_25_7] = true

			table.insert(self.packageSortList, var_25_7)
		end
	end

	table.sort(self.packageSortList)

	local function var_25_8(arg_26_0)
		local var_26_0 = arg_26_0:getConfig("time")
		local var_26_1 = 0

		if type(var_26_0) == "string" then
			var_26_1 = var_26_1 + 999999999999
		elseif type(var_26_0) == "table" then
			var_26_1 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_26_0[2]) - pg.TimeMgr.GetInstance():GetServerTime()
			var_26_1 = var_26_1 > 0 and var_26_1 or 999999999999
		else
			var_26_1 = var_26_1 + 999999999999
		end

		return var_26_1
	end

	local var_25_9 = {}
	local var_25_10 = getProxy(ActivityProxy)

	for iter_25_4, iter_25_5 in ipairs(var_25_10:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_GIFT_UP)) do
		if var_25_10:IsActivityNotEnd(iter_25_5.id) then
			underscore(iter_25_5:getConfig("config_client").gifts):chain():flatten():map(function(arg_27_0)
				var_25_9[arg_27_0] = true

				return
			end)
		end
	end

	table.sort(self.giftGoodsVOListForShow, CompareFuncs({
		function(arg_28_0)
			return var_25_9[arg_28_0.id] and 0 or 1
		end,
		function(arg_29_0)
			return (arg_29_0:getConfig("type_order") - 1) % 1000
		end,
		function(arg_30_0)
			return var_25_8(arg_30_0)
		end,
		function(arg_31_0)
			return -arg_31_0:getConfig("tag")
		end,
		function(arg_32_0)
			return arg_32_0:getConfig("order") or 999
		end,
		function(arg_33_0)
			return arg_33_0.id
		end
	}))

	return
end

function ChargeGiftShopView:getFilterList()
	if self.selectedPackageType == nil or self.selectedPackageType == 0 then
		return self.giftGoodsVOListForShow
	end

	return self:getFilterListByType(self.selectedPackageType)
end

function ChargeGiftShopView:getFilterListByType(arg_35_1)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(self.giftGoodsVOListForShow) do
		if iter_35_1:getConfig("package_sort_id") == arg_35_1 then
			table.insert(var_35_0, iter_35_1)
		end
	end

	return var_35_0
end

function ChargeGiftShopView:updateGoodsData()
	self.firstChargeIds = self.contextData.firstChargeIds
	self.chargedList = self.contextData.chargedList

	return
end

function ChargeGiftShopView:setGoodData(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	self.firstChargeIds = arg_37_1
	self.chargedList = arg_37_2

	return
end

function ChargeGiftShopView:updateData()
	self.player = getProxy(PlayerProxy):getData()

	self:sortGiftGoodsVOList()

	return
end

function ChargeGiftShopView:addUpdateTimer(arg_39_1)
	local var_39_0 = pg.TimeMgr.GetInstance()
	local var_39_1 = var_39_0:Table2ServerTime(arg_39_1)

	if self.updateTime and var_39_1 > var_39_0:Table2ServerTime(self.updateTime) then
		return
	end

	self.updateTime = arg_39_1

	self:removeUpdateTimer()

	self.updateTimer = Timer.New(function()
		if var_39_0:GetServerTime() > var_39_1 then
			self:removeUpdateTimer()
			self:reUpdateAll()
		end

		return
	end, 1, -1)

	self.updateTimer:Start()
	self.updateTimer.func()

	return
end

function ChargeGiftShopView:removeUpdateTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	return
end

function ChargeGiftShopView:IsSupplyShop()
	return false
end

function ChargeGiftShopView:reUpdateAll()
	self:updateData()
	self:updateToggleList()
	self:updateScrollRect()

	if not table.contains(self.packageSortList, self.selectedPackageType) then
		triggerButton(self._tf:Find("toggleGroup"):GetChild(0))
	end

	return
end

function ChargeGiftShopView:ShowPanel(arg_44_1)
	setActive(self._go, arg_44_1)

	return
end

return ChargeGiftShopView
