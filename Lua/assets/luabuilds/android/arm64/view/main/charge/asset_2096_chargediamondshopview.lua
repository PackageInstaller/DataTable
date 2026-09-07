local ChargeDiamondShopView = class("ChargeDiamondShopView", import("...base.BaseSubView"))

ChargeDiamondShopView.MonthCardID = 1

function ChargeDiamondShopView:getUIName()
	return "ChargeDiamondShopUI"
end

function ChargeDiamondShopView:OnInit()
	self:initData()
	self:initUI()
	self:Show()

	return
end

function ChargeDiamondShopView:OnDestroy()
	return
end

function ChargeDiamondShopView:initData()
	self.isNeedHideMonthCard = (PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_US) and pg.SdkMgr.GetInstance():CheckAudit()
	self.diamondGoodsVOList = {}
	self.diamondGoodsVOListForShow = {}
	self.player = getProxy(PlayerProxy):getData()

	self:updateData()

	return
end

function ChargeDiamondShopView:initUI()
	self.itemTpl = self._tf:Find("ItemTpl")

	local var_5_0 = self._tf:Find("content")

	self.monthCardTF = var_5_0:Find("ItemMonth")
	self.itemContainerTF = var_5_0:Find("ItemList")
	self.uiItemList = self:initUIItemList()

	self:updateView()

	return
end

function ChargeDiamondShopView:initUIItemList()
	local var_6_0 = UIItemList.New(self.itemContainerTF, self.itemTpl)

	var_6_0:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			local var_7_0 = ChargeDiamondCard.New(go(arg_7_2), self.monthCardTF, self)

			var_7_0:update(self.diamondGoodsVOListForShow[arg_7_1], self.player, self.firstChargeIds)
			onButton(self, var_7_0.tr, function()
				self:confirm(var_7_0.goods)

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.uiItemList = var_6_0

	return var_6_0
end

function ChargeDiamondShopView:updateUIItemList()
	self.uiItemList:align(#self.diamondGoodsVOListForShow)

	return
end

function ChargeDiamondShopView:updateView()
	setActive(self.monthCardTF, not self.isNeedHideMonthCard)
	self:updateUIItemList()

	return
end

function ChargeDiamondShopView:confirm(arg_11_1)
	if not arg_11_1 then
		return
	end

	arg_11_1 = Clone(arg_11_1)

	if arg_11_1:isChargeType() then
		local var_11_0 = not table.contains(self.firstChargeIds, arg_11_1.id) and arg_11_1:firstPayDouble()
		local var_11_1 = var_11_0 and 4 or arg_11_1:getConfig("tag")

		if arg_11_1:isMonthCard() or arg_11_1:isGiftBox() or arg_11_1:isItemBox() or arg_11_1:isPassItem() then
			local var_11_2 = arg_11_1:GetExtraServiceItem()
			local var_11_3 = arg_11_1:GetExtraDrop()
			local var_11_4 = arg_11_1:GetBonusItem()
			local var_11_5
			local var_11_6

			if arg_11_1:isPassItem() then
				var_11_5 = i18n("battlepass_pay_tip")
			elseif arg_11_1:isMonthCard() then
				var_11_5 = i18n("charge_title_getitem_month")
				var_11_6 = i18n("charge_title_getitem_soon")
			else
				var_11_5 = i18n("charge_title_getitem")
			end

			self:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_PANEL, {
				isChargeType = true,
				commodity = arg_11_1,
				infoTip = arg_11_1:GetInfoTip(),
				icon = "chargeicon/" .. arg_11_1:getConfig("picture"),
				name = arg_11_1:getConfig("name_display"),
				tipExtra = var_11_5,
				extraItems = var_11_2,
				price = arg_11_1:getConfig("money"),
				isLocalPrice = arg_11_1:IsLocalPrice(),
				tagType = var_11_1,
				isMonthCard = arg_11_1:isMonthCard(),
				tipBonus = var_11_6,
				bonusItem = var_11_4,
				extraDrop = var_11_3,
				descExtra = arg_11_1:getConfig("descrip_extra"),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(NewShopMainMediator.OPEN_CHARGE_BIRTHDAY)
					else
						self:emit(NewShopMainMediator.CHARGE, arg_11_1.id)
					end

					return
				end
			})
		elseif arg_11_1:isGem() then
			local var_11_7 = arg_11_1:getConfig("money")
			local var_11_8 = arg_11_1:getConfig("gem")

			var_11_8 = var_11_0 and var_11_8 + arg_11_1:getConfig("gem") or var_11_8 + arg_11_1:getConfig("extra_gem")

			self:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_BOX, {
				isChargeType = true,
				commodity = arg_11_1,
				icon = "chargeicon/" .. arg_11_1:getConfig("picture"),
				name = arg_11_1:getConfig("name_display"),
				price = arg_11_1:getConfig("money"),
				isLocalPrice = arg_11_1:IsLocalPrice(),
				tagType = var_11_1,
				normalTip = i18n("charge_start_tip", var_11_7, var_11_8),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(NewShopMainMediator.OPEN_CHARGE_BIRTHDAY)
					else
						self:emit(NewShopMainMediator.CHARGE, arg_11_1.id)
					end

					return
				end
			})
		end
	else
		local var_11_9 = {}
		local var_11_10 = Item.getConfigData(arg_11_1:getConfig("effect_args")[1])

		if type(var_11_10.display_icon) == "table" then
			for iter_11_0, iter_11_1 in ipairs(var_11_10.display_icon) do
				table.insert(var_11_9, {
					type = iter_11_1[1],
					id = iter_11_1[2],
					count = iter_11_1[3]
				})
			end
		end

		self:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_PANEL, {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_11_1,
			icon = var_11_10.icon,
			name = var_11_10.name,
			tipExtra = i18n("charge_title_getitem"),
			extraItems = var_11_9,
			price = arg_11_1:getConfig("resource_num"),
			tagType = arg_11_1:getConfig("tag"),
			onYes = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("charge_scene_buy_confirm", arg_11_1:getConfig("resource_num"), var_11_10.name),
					onYes = function()
						self:emit(NewShopMainMediator.BUY_ITEM, arg_11_1.id, 1)

						return
					end
				})

				return
			end
		})
	end

	return
end

function ChargeDiamondShopView:updateDiamondGoodsVOList()
	self.diamondGoodsVOList = {}

	for iter_16_0, iter_16_1 in pairs(pg.pay_data_display.all) do
		if self.isNeedHideMonthCard and iter_16_1 == ChargeDiamondShopView.MonthCardID then
			-- block empty
		elseif pg.SdkMgr.GetInstance():IgnorePlatform(pg.pay_data_display[iter_16_1].ignorePlatform) then
			-- block empty
		elseif pg.pay_data_display[iter_16_1].extra_service ~= Goods.MONTH_CARD and pg.pay_data_display[iter_16_1].extra_service ~= Goods.GEM then
			if pg.pay_data_display[iter_16_1].extra_service == Goods.GIFT_BOX then
				table.insert(self.diamondGoodsVOList, (Goods.Create({
					shop_id = iter_16_1
				}, Goods.TYPE_CHARGE)))
			end
		end
	end

	return
end

function ChargeDiamondShopView:sortDiamondGoodsVOList()
	self.diamondGoodsVOListForShow = {}

	for iter_17_0, iter_17_1 in ipairs(self.diamondGoodsVOList) do
		iter_17_1:updateBuyCount((ChargeConst.getBuyCount(self.chargedList, iter_17_1.id)))

		if iter_17_1:canPurchase() and iter_17_1:inTime() then
			table.insert(self.diamondGoodsVOListForShow, iter_17_1)
		end
	end

	table.sort(self.diamondGoodsVOListForShow, CompareFuncs({
		function(arg_18_0)
			return arg_18_0:isFree() and 0 or 1
		end,
		function(arg_19_0)
			if arg_19_0:isChargeType() and arg_19_0:isMonthCard() then
				local var_19_0 = self.player:getCardById(VipCard.MONTH)

				if var_19_0 then
					local var_19_1 = pg.TimeMgr.GetInstance()
					local var_19_2 = arg_19_0:getConfig("limit_arg")

					if ((not var_19_1 or nil) and 0) < math.floor((var_19_0:getLeftDate() - var_19_1:GetServerTime()) / 0) then
						return 1
					end
				end
			end

			return 0
		end,
		function(arg_20_0)
			return not table.contains(self.firstChargeIds, arg_20_0.id) and arg_20_0:firstPayDouble() and 0 or 1
		end,
		function(arg_21_0)
			return arg_21_0:getConfig("tag") == 2 and 0 or 1
		end,
		function(arg_22_0)
			return arg_22_0.id
		end
	}))

	return
end

function ChargeDiamondShopView:updateGoodsData()
	self.firstChargeIds = self.contextData.firstChargeIds
	self.chargedList = self.contextData.chargedList
	self.normalList = self.contextData.normalList
	self.normalGroupList = self.contextData.normalGroupList

	return
end

function ChargeDiamondShopView:setGoodData(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	self.firstChargeIds = arg_24_1
	self.chargedList = arg_24_2
	self.normalList = arg_24_3
	self.normalGroupList = arg_24_4

	return
end

function ChargeDiamondShopView:updateData()
	self.player = getProxy(PlayerProxy):getData()

	self:updateDiamondGoodsVOList()
	self:sortDiamondGoodsVOList()

	return
end

function ChargeDiamondShopView:IsSupplyShop()
	return false
end

function ChargeDiamondShopView:reUpdateAll()
	self:updateData()
	self:updateView()

	return
end

function ChargeDiamondShopView:ShowPanel(arg_28_1)
	setActive(self._go, arg_28_1)

	return
end

return ChargeDiamondShopView
