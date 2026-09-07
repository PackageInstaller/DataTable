local LatestSkinGiftPackLayer = class("LatestSkinGiftPackLayer", import(".LatestSkinShopLayer"))

function LatestSkinGiftPackLayer:Overlay()
	pg.UIMgr.GetInstance():OverlayPanel(self.adapt, {
		pbList = {
			self.charContainer:Find("bg"),
			self.filterUI:Find("panel")
		}
	})

	return
end

function LatestSkinGiftPackLayer:UnOverlay()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.adapt, self._tf)

	return
end

function LatestSkinGiftPackLayer:GetAllCommodities()
	if self.contextData.commodityId then
		self.giftPackCommodity = self:GetCommodity(self.contextData.commodityId)

		local var_3_0 = self.giftPackCommodity:GetSkinProbability()

		self.commodities = getProxy(ShipSkinProxy):GetProbabilitySkins(var_3_0)
		self.skinProbabilitys = getProxy(ShipSkinProxy):GetSkinProbabilitys(var_3_0)
	else
		self.giftPackCommodity = self.contextData.giftPackCommodity
		self.commodities = self.contextData.skinCommodities
		self.skinProbabilitys = self.contextData.skinProbabilitys
	end

	return
end

function LatestSkinGiftPackLayer:GetCommodity(arg_4_1)
	local var_4_0 = Goods.Create({
		shop_id = arg_4_1
	}, Goods.TYPE_CHARGE)
	local var_4_1 = getProxy(ShopsProxy):getChargedList()

	var_4_1 = var_4_1 or {}

	var_4_0:updateBuyCount((ChargeConst.getBuyCount(var_4_1, var_4_0.id)))

	return var_4_0
end

function LatestSkinGiftPackLayer:SetGiftPackLayer()
	setActive(self.mainTitle, true)
	setActive(self.backBtn, true)
	setActive(self.homeBtn, true)
	setActive(self.giftPack, true)
	setActive(self.showOwnBtn, false)
	setActive(self.filterBtn, false)
	setActive(self.search, false)
	setActive(self.giftPackBtn, false)
	setActive(self.price, false)

	self.top:Find("title").anchoredPosition = Vector2(544.6, -208.3)
	self.top:Find("change_skin").anchoredPosition = Vector2(431.1, -337.8)
	self.bottom:Find("scroll").offsetMin = Vector2(378, 0)
	self.bottom:Find("scroll").offsetMax = Vector2(-19.6, 227.9)

	setText(self.giftPack:Find("panel/name"), self.giftPackCommodity:getConfig("name_display"))

	local var_5_0 = self.giftPackCommodity:getConfig("time")

	setActive(self.giftPack:Find("panel/leftTimeText"), type(var_5_0) == "table")

	if type(var_5_0) == "table" then
		local var_5_1 = pg.TimeMgr.GetInstance():Table2ServerTime({
			year = var_5_0[2][1][1],
			month = var_5_0[2][1][2],
			day = var_5_0[2][1][3],
			hour = var_5_0[2][2][1],
			min = var_5_0[2][2][2],
			sec = var_5_0[2][2][3]
		})

		self:StartTimer(function()
			local var_6_0 = pg.TimeMgr.GetInstance()
			local var_6_1 = var_5_1 - var_6_0:GetServerTime()
			local var_6_2 = math.floor(var_6_1 % 0 / 16)

			if var_6_0 > 0 then
				setText(self.giftPack:Find("panel/leftTimeText"), i18n("shop_new_during_day", (math.floor(var_6_1 / 0))))
			elseif var_6_2 > 0 then
				setText(self.giftPack:Find("panel/leftTimeText"), i18n("shop_new_during_hour", var_6_2))
			else
				setText(self.giftPack:Find("panel/leftTimeText"), i18n("shop_new_during_minite", (math.floor(var_6_1 % 0 % 16 / 60))))
			end

			return
		end)
	end

	GetImageSpriteFromAtlasAsync("chargeicon/" .. self.giftPackCommodity:getConfig("picture"), "", self.giftPack:Find("panel/icon"))
	setText(self.giftPack:Find("panel/tip1/Text"), self.giftPackCommodity:getConfig("first_text"))
	setText(self.giftPack:Find("panel/tip2/Text"), self.giftPackCommodity:getConfig("second_text"))

	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs((self.giftPackCommodity:getConfig("first_icon"))) do
		table.insert(var_5_2, Drop.Create(iter_5_1))
	end

	while #var_5_2 > 3 do
		table.remove(var_5_2, #var_5_2)
	end

	local var_5_3 = UIItemList.New(self.giftPack:Find("panel/firstItems"), self.giftPack:Find("panel/firstItems/item"))

	var_5_3:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			updateDrop(arg_7_2:Find("mask/item"), var_5_2[arg_7_1 + 1])
		end

		return
	end)
	var_5_3:align(#var_5_2)

	local var_5_4 = self.giftPackCommodity:GetDropList()

	while #var_5_4 > 3 do
		table.remove(var_5_4, #var_5_4)
	end

	local var_5_5 = UIItemList.New(self.giftPack:Find("panel/items"), self.giftPack:Find("panel/items/item"))

	var_5_5:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			updateDrop(arg_8_2:Find("mask/item"), var_5_4[arg_8_1 + 1])
		end

		return
	end)
	var_5_5:align(#var_5_4)
	setText(self.giftPack:Find("price/consume/Text"), self.giftPackCommodity:GetLimitDesc())
	setText(self.giftPack:Find("price/btns/goumai_button/Text"), GetMoneySymbol() .. self.giftPackCommodity:getConfig("money"))

	if PLATFORM_CODE == PLATFORM_CHT and self.giftPackCommodity:IsLocalPrice() then
		setText(self.giftPack:Find("price/btns/goumai_button/Text"), self.giftPackCommodity:getConfig("money"))
	end

	setGray(self.giftPack:Find("price/btns/yigoumai_button"), true, true)

	local var_5_6 = self.giftPackCommodity:getLimitCount()
	local var_5_7 = self.giftPackCommodity.buyCount or 0

	setActive(self.giftPack:Find("price/btns/goumai_button"), var_5_7 < var_5_6)
	setActive(self.giftPack:Find("price/btns/yigoumai_button"), var_5_6 <= var_5_7)
	onButton(self, self.giftPack:Find("price/btns/goumai_button"), function()
		self:confirm(self.giftPackCommodity)

		return
	end, SFX_PANEL)

	return
end

function LatestSkinGiftPackLayer:FlushGifgPackBtn(arg_10_1)
	setActive(self.giftPackBtn, false)

	return
end

function LatestSkinGiftPackLayer:OnUpdateItem(arg_11_1, arg_11_2)
	local var_11_0 = self.cards[arg_11_2]

	if not self.cards[arg_11_2] then
		self:OnInitItem(arg_11_2)

		var_11_0 = self.cards[arg_11_2]
	end

	local var_11_1 = self.displays[arg_11_1 + 1]
	local var_11_2

	if not self.displays[arg_11_1 + 1] then
		do return end

		var_11_2 = table.contains(self.returnSkins, var_11_1.id)
	end

	var_11_0:Update(var_11_1, self.selectedId == var_11_1.id, var_11_2, self.skinProbabilitys[var_11_1:getSkinId()])

	if self.triggerFirstCard and arg_11_1 == 0 then
		self.triggerFirstCard = false

		triggerButton(var_11_0._go)
	end

	return
end

function LatestSkinGiftPackLayer:confirm(arg_12_1)
	if not arg_12_1 then
		return
	end

	arg_12_1 = Clone(arg_12_1)

	if arg_12_1:isChargeType() then
		local var_12_0 = false and arg_12_1:firstPayDouble()
		local var_12_1 = var_12_0 and 4 or arg_12_1:getConfig("tag")

		if arg_12_1:isMonthCard() or arg_12_1:isGiftBox() or arg_12_1:isItemBox() or arg_12_1:isPassItem() then
			local var_12_2 = arg_12_1:GetExtraServiceItem()
			local var_12_3 = arg_12_1:GetExtraDrop()
			local var_12_4 = arg_12_1:GetBonusItem()
			local var_12_5
			local var_12_6

			if arg_12_1:isPassItem() then
				var_12_5 = i18n("battlepass_pay_tip")
			elseif arg_12_1:isMonthCard() then
				var_12_5 = i18n("charge_title_getitem_month")
				var_12_6 = i18n("charge_title_getitem_soon")
			else
				var_12_5 = i18n("charge_title_getitem")
			end

			self:emit(LatestSkinGiftPackMediator.OPEN_CHARGE_ITEM_PANEL, {
				isChargeType = true,
				commodity = arg_12_1,
				infoTip = arg_12_1:GetInfoTip(),
				icon = "chargeicon/" .. arg_12_1:getConfig("picture"),
				name = arg_12_1:getConfig("name_display"),
				tipExtra = var_12_5,
				extraItems = var_12_2,
				price = arg_12_1:getConfig("money"),
				isLocalPrice = arg_12_1:IsLocalPrice(),
				tagType = var_12_1,
				isMonthCard = arg_12_1:isMonthCard(),
				tipBonus = var_12_6,
				bonusItem = var_12_4,
				extraDrop = var_12_3,
				descExtra = arg_12_1:getConfig("descrip_extra"),
				limitArgs = arg_12_1:getConfig("limit_args"),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(LatestSkinGiftPackMediator.OPEN_CHARGE_BIRTHDAY)
					else
						self:emit(LatestSkinGiftPackMediator.CHARGE, arg_12_1.id)
					end

					return
				end
			})
		elseif arg_12_1:isGem() then
			local var_12_7 = arg_12_1:getConfig("money")
			local var_12_8 = arg_12_1:getConfig("gem")

			var_12_8 = var_12_0 and var_12_8 + arg_12_1:getConfig("gem") or var_12_8 + arg_12_1:getConfig("extra_gem")

			self:emit(LatestSkinGiftPackMediator.OPEN_CHARGE_ITEM_BOX, {
				isChargeType = true,
				commodity = arg_12_1,
				icon = "chargeicon/" .. arg_12_1:getConfig("picture"),
				name = arg_12_1:getConfig("name_display"),
				price = arg_12_1:getConfig("money"),
				isLocalPrice = arg_12_1:IsLocalPrice(),
				tagType = var_12_1,
				normalTip = i18n("charge_start_tip", var_12_7, var_12_8),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(LatestSkinGiftPackMediator.OPEN_CHARGE_BIRTHDAY)
					else
						self:emit(LatestSkinGiftPackMediator.CHARGE, arg_12_1.id)
					end

					return
				end
			})
		end
	else
		local var_12_9 = {}
		local var_12_10 = Item.getConfigData(arg_12_1:getConfig("effect_args")[1])

		if type(var_12_10.display_icon) == "table" then
			for iter_12_0, iter_12_1 in ipairs(var_12_10.display_icon) do
				table.insert(var_12_9, Drop.New({
					type = iter_12_1[1],
					id = iter_12_1[2],
					count = iter_12_1[3]
				}))
			end
		end

		self:emit(LatestSkinGiftPackMediator.OPEN_CHARGE_ITEM_PANEL, {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_12_1,
			icon = var_12_10.icon,
			name = var_12_10.name,
			tipExtra = i18n("charge_title_getitem"),
			extraItems = var_12_9,
			price = arg_12_1:getConfig("resource_num"),
			tagType = arg_12_1:getConfig("tag"),
			onYes = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("charge_scene_buy_confirm", arg_12_1:getConfig("resource_num"), var_12_10.name),
					onYes = function()
						self:emit(LatestSkinGiftPackMediator.BUY_ITEM, arg_12_1.id, 1)

						return
					end
				})

				return
			end
		})
	end

	return
end

function LatestSkinGiftPackLayer:StartTimer(arg_17_1)
	self.cardTimer = Timer.New(function()
		arg_17_1()

		return
	end, 1, -1)

	arg_17_1()
	self.cardTimer:Start()

	return
end

function LatestSkinGiftPackLayer:RemoveAllTimer()
	if self.cardTimer then
		self.cardTimer:Stop()

		self.cardTimer = nil
	end

	return
end

function LatestSkinGiftPackLayer:willExit()
	LatestSkinGiftPackLayer.super.willExit(self)
	self:RemoveAllTimer()

	return
end

return LatestSkinGiftPackLayer
