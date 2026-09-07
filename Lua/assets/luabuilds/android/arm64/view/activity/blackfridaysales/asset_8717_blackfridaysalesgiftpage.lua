local BlackFridaySalesGiftPage = class("BlackFridaySalesGiftPage", import("...base.BaseSubView"))

function BlackFridaySalesGiftPage:getUIName()
	return "BlackFridaySalesGiftPage"
end

function BlackFridaySalesGiftPage:OnInit()
	self:initData()
	self:initUI()

	return
end

function BlackFridaySalesGiftPage:initData()
	self.player = getProxy(PlayerProxy):getData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_GIFT_UP)

	self:initGiftGoods()

	self.openIndex = 1

	self:updateGiftGoodsVOList()

	return
end

function BlackFridaySalesGiftPage:initUI()
	self.content = self._tf:Find("scrollrect/content")
	self.soldOutTF = self._tf:Find("sold_out")

	setText(self.soldOutTF:Find("Text"), i18n("newserver_soldout"))
	setActive(self.soldOutTF, #self.giftGoodsVOList == 0)

	self.pagefooters = {
		self._tf:Find("pagefooter/dailyPacks"),
		self._tf:Find("pagefooter/specialPacks")
	}

	setText(self._tf:Find("pagefooter/dailyPacks/Text"), i18n("blackfriday_dailypack"))
	setText(self._tf:Find("pagefooter/dailyPacks/mark"), i18n("blackfriday_dailypack"))
	setText(self._tf:Find("pagefooter/specialPacks/Text"), i18n("blackfriday_specialpack"))
	setText(self._tf:Find("pagefooter/specialPacks/mark"), i18n("blackfriday_specialpack"))

	self.pagefooterWid = self.pagefooters[1].rect.width
	self.pagefooterStartPosX = self.pagefooters[1].anchoredPosition.x
	self.giftItemList = UIItemList.New(self.content, self._tf:Find("gift_tpl"))
	self.chargeCardTable = {}

	self.giftItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventInit then
			self:initGift(go(arg_5_2))
		elseif arg_5_0 == UIItemList.EventUpdate then
			self:updateGift(go(arg_5_2), arg_5_1)
		end

		return
	end)
	self.giftItemList:align(#self.giftGoodsVOList)
	self:UpdatePageFooters()

	return
end

function BlackFridaySalesGiftPage:UpdatePageFooters()
	self.pagefooterTrs = {}

	for iter_6_0 = 1, 2 do
		self:UpdatePageFooter(self.pagefooters[iter_6_0], iter_6_0)

		self.pagefooterTrs[iter_6_0] = self.pagefooters[iter_6_0]
	end

	triggerButton(self.pagefooterTrs[self.contextData.index or 1])

	return
end

local var_0_1 = 0

function BlackFridaySalesGiftPage:UpdatePageFooter(arg_7_1, arg_7_2)
	setAnchoredPosition(arg_7_1, {
		x = self.pagefooterStartPosX + (var_0_1 + self.pagefooterWid) * (arg_7_2 - 1)
	})
	self:OnSwitch(arg_7_1, function()
		self:SwitchTab(arg_7_2)

		return
	end)

	return
end

function BlackFridaySalesGiftPage:OnSwitch(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:Find("mark")

	local function var_9_1()
		if self.markTr then
			setActive(self.markTr, false)
		end

		self.markTr = var_9_0

		setActive(var_9_0, true)

		return
	end

	onButton(self, arg_9_1, function()
		var_9_1()
		arg_9_2()

		return
	end, SFX_PANEL)

	return
end

function BlackFridaySalesGiftPage:SwitchTab(arg_12_1)
	self.openIndex = arg_12_1

	self:onUpdateGift()

	return
end

function BlackFridaySalesGiftPage:initGift(arg_13_1)
	local var_13_0 = BlackFridayChargeCard.New(arg_13_1)

	onButton(self, var_13_0.tr, function()
		if var_13_0:inTime() then
			self:confirm(var_13_0.goods)
		end

		return
	end, SFX_PANEL)

	self.chargeCardTable[arg_13_1] = var_13_0

	return
end

function BlackFridaySalesGiftPage:updateGift(arg_15_1, arg_15_2)
	local var_15_0 = self.chargeCardTable[arg_15_1]

	if not self.chargeCardTable[arg_15_1] then
		self.initGift(arg_15_1)

		var_15_0 = self.chargeCardTable[arg_15_1]
	end

	if self.giftGoodsVOList[arg_15_2] then
		var_15_0:update(self.giftGoodsVOList[arg_15_2], self.player, self.firstChargeIds)
	end

	return
end

function BlackFridaySalesGiftPage:confirm(arg_16_1)
	if not arg_16_1 then
		return
	end

	arg_16_1 = Clone(arg_16_1)

	if arg_16_1:isChargeType() then
		local var_16_0 = not table.contains(self.firstChargeIds, arg_16_1.id) and arg_16_1:firstPayDouble() and 4 or arg_16_1:getConfig("tag")
		local var_16_1 = arg_16_1:GetExtraServiceItem()
		local var_16_2 = arg_16_1:GetExtraDrop()
		local var_16_3 = arg_16_1:GetBonusItem()
		local var_16_4
		local var_16_5

		if arg_16_1:isPassItem() then
			var_16_4 = i18n("battlepass_pay_tip")
		elseif arg_16_1:isMonthCard() then
			var_16_4 = i18n("charge_title_getitem_month")
			var_16_5 = i18n("charge_title_getitem_soon")
		else
			var_16_4 = i18n("charge_title_getitem")
		end

		self:emit(BlackFridaySalesMediator.GIFT_OPEN_ITEM_PANEL, {
			isChargeType = true,
			commodity = arg_16_1,
			infoTip = arg_16_1:GetInfoTip(),
			icon = "chargeicon/" .. arg_16_1:getConfig("picture"),
			name = arg_16_1:getConfig("name_display"),
			tipExtra = var_16_4,
			extraItems = var_16_1,
			price = arg_16_1:getConfig("money"),
			isLocalPrice = arg_16_1:IsLocalPrice(),
			tagType = var_16_0,
			isMonthCard = arg_16_1:isMonthCard(),
			tipBonus = var_16_5,
			bonusItem = var_16_3,
			extraDrop = var_16_2,
			descExtra = arg_16_1:getConfig("descrip_extra"),
			limitArgs = arg_16_1:getConfig("limit_args"),
			onYes = function()
				if ChargeConst.isNeedSetBirth() then
					self:emit(BlackFridaySalesMediator.OPEN_CHARGE_BIRTHDAY)
				else
					self:emit(BlackFridaySalesMediator.CHARGE, arg_16_1.id)
				end

				return
			end
		})
	else
		local var_16_6 = {}
		local var_16_7 = Item.getConfigData(arg_16_1:getConfig("effect_args")[1])

		if type(var_16_7.display_icon) == "table" then
			for iter_16_0, iter_16_1 in ipairs(var_16_7.display_icon) do
				table.insert(var_16_6, {
					type = iter_16_1[1],
					id = iter_16_1[2],
					count = iter_16_1[3]
				})
			end
		end

		self:emit(BlackFridaySalesMediator.GIFT_OPEN_ITEM_PANEL, {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_16_1,
			icon = var_16_7.icon,
			name = var_16_7.name,
			tipExtra = i18n("charge_title_getitem"),
			extraItems = var_16_6,
			price = arg_16_1:getConfig("resource_num"),
			tagType = arg_16_1:getConfig("tag"),
			onYes = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("charge_scene_buy_confirm", arg_16_1:getConfig("resource_num"), var_16_7.name),
					onYes = function()
						self:emit(BlackFridaySalesMediator.GIFT_BUY_ITEM, arg_16_1.id, 1)

						return
					end
				})

				return
			end
		})
	end

	return
end

function BlackFridaySalesGiftPage:onUpdatePlayer(arg_20_1)
	self.player = arg_20_1

	return
end

function BlackFridaySalesGiftPage:onUpdateGift()
	self:updateGiftGoodsVOList()
	self.giftItemList:align(#self.giftGoodsVOList)
	setActive(self.soldOutTF, #self.giftGoodsVOList == 0)

	return
end

function BlackFridaySalesGiftPage:initGiftGoods()
	self.giftList = {
		{},
		{}
	}

	local var_22_0 = self.activity:getConfig("config_client")
	local var_22_1 = getProxy(ShopsProxy):getChargedList()

	var_22_1 = var_22_1 or {}

	for iter_22_0, iter_22_1 in pairs(var_22_0.gifts[1]) do
		table.insert(self.giftList[1], (Goods.Create({
			shop_id = iter_22_1
		}, Goods.TYPE_CHARGE)))
	end

	for iter_22_2, iter_22_3 in pairs(var_22_0.gifts[2]) do
		table.insert(self.giftList[1], (Goods.Create({
			shop_id = iter_22_3
		}, Goods.TYPE_NEW_SERVER)))
	end

	for iter_22_4, iter_22_5 in pairs(var_22_0.gifts_2) do
		local var_22_2 = Goods.Create({
			shop_id = iter_22_5
		}, Goods.TYPE_CHARGE)

		var_22_2:updateBuyCount((ChargeConst.getBuyCount(var_22_1, iter_22_5)))
		table.insert(self.giftList[2], var_22_2)
	end

	return
end

function BlackFridaySalesGiftPage:updateGiftGoodsVOList(arg_23_1)
	arg_23_1 = arg_23_1 or self.openIndex
	self.giftGoodsVOList = Clone(self.giftList[arg_23_1])
	self.normalList = getProxy(ShopsProxy):GetNormalList()
	self.chargedList = getProxy(ShopsProxy):getChargedList()

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(self.giftGoodsVOList) do
		iter_23_1:updateBuyCount(iter_23_1:isChargeType() and ChargeConst.getBuyCount(self.chargedList, iter_23_1.id) or ChargeConst.getBuyCount(self.normalList, iter_23_1.id))

		if iter_23_1:canPurchase() then
			table.insert(var_23_0, iter_23_1)
		end
	end

	local var_23_2 = pg.TimeMgr.GetInstance()

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		local var_24_0 = var_23_2:inTime(arg_24_0:getConfig("time")) and 1 or 0
		local var_24_1 = var_23_2:inTime(arg_24_1:getConfig("time")) and 1 or 0
		local var_24_2 = arg_24_0:isChargeType() and 1 or 0
		local var_24_3 = arg_24_1:isChargeType() and 1 or 0

		if var_24_0 == var_24_1 then
			if var_24_2 == var_24_3 then
				return arg_24_0.id < arg_24_1.id
			else
				return var_24_2 < var_24_3
			end
		else
			return var_24_1 < var_24_0
		end

		return
	end)

	self.giftGoodsVOList = var_23_0

	return
end

function BlackFridaySalesGiftPage:isTip()
	local var_25_1 = pg.TimeMgr.GetInstance()

	local function var_25_2(arg_26_0)
		local var_26_0 = false

		for iter_26_0, iter_26_1 in ipairs((Clone(self.giftList[arg_26_0]))) do
			count = iter_26_1:isChargeType() and ChargeConst.getBuyCount(self.chargedList, iter_26_1.id) or ChargeConst.getBuyCount(self.normalList, iter_26_1.id)

			iter_26_1:updateBuyCount(count)

			if iter_26_1:canPurchase() and not iter_26_1:isChargeType() and var_25_1:inTime(iter_26_1:getConfig("time")) then
				var_26_0 = true
			end
		end

		return var_26_0
	end

	return var_25_2(1) or var_25_2(2)
end

function BlackFridaySalesGiftPage:OnDestroy()
	return
end

return BlackFridaySalesGiftPage
