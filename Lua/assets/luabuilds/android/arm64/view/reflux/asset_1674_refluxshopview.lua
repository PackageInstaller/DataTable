local RefluxShopView = class("RefluxShopView", import("..base.BaseSubView"))

RefluxShopView.GiftPackType = {
	Gold = 3,
	Money = 1,
	Diamond = 2
}
RefluxShopView.GiftPackTypeName = {
	"pack_type_1",
	"pack_type_2",
	"pack_type_3"
}
RefluxShopView.Special_ID_Gold = 1
RefluxShopView.Special_ID_Gem = 14

function RefluxShopView:getUIName()
	return "RefluxShopUI"
end

function RefluxShopView:OnInit()
	self:initData()
	self:initUI()
	self:updateUI()
	RefluxShopView.SaveEnterTag()

	return
end

function RefluxShopView:OnDestroy()
	for iter_3_0, iter_3_1 in pairs(RefluxShopView.GiftPackType) do
		if self.packTimerList[iter_3_1] then
			self.packTimerList[iter_3_1]:Stop()

			self.packTimerList[iter_3_1] = nil
		end

		if self.packNextTimerList[iter_3_1] then
			self.packNextTimerList[iter_3_1]:Stop()

			self.packNextTimerList[iter_3_1] = nil
		end
	end

	return
end

function RefluxShopView:OnBackPress()
	self:Hide()

	return
end

function RefluxShopView:initData()
	self.refluxProxy = getProxy(RefluxProxy)
	self.shopProxy = getProxy(ShopsProxy)

	return
end

function RefluxShopView:initUI()
	setActive(self._tf:Find("BG/MoneyTip"), false)

	self.itemTpl = self._tf:Find("ItemTpl")
	self.packTpl = self._tf:Find("PackTpl")
	self.packContainerTF = self._tf:Find("Container")
	self.packItemList = UIItemList.New(self.packContainerTF, self.packTpl)

	self.packItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			self:updatePack(arg_7_2, self.goodVOList[arg_7_1], arg_7_1)
		end

		return
	end)

	self.packTimerList = {}
	self.packNextTimerList = {}

	local var_6_0 = self.itemTpl:Find("CommonItemTemplate")

	setActive(var_6_0:Find("icon_bg/count"), true)
	setLocalScale(var_6_0, {
		x = 0.45,
		y = 0.45
	})

	return
end

function RefluxShopView:updateData()
	local var_8_0 = self:getCurDayGiftPackIDList()
	local var_8_1 = false
	local var_8_2

	if var_8_0[1] then
		var_8_1 = Goods.Create({
			shop_id = var_8_0[1]
		}, Goods.TYPE_CHARGE)
		var_8_2 = {
			var_8_1
		}
	end

	var_8_2[2] = Goods.Create({
		shop_id = var_8_0[2]
	}, Goods.TYPE_GIFT_PACKAGE)
	var_8_2[3] = Goods.Create({
		shop_id = var_8_0[3]
	}, Goods.TYPE_GIFT_PACKAGE)
	self.goodVOList = var_8_2

	return
end

function RefluxShopView:updateUI()
	self:updateData()
	self:updatePackList()

	return
end

function RefluxShopView:updateOutline()
	for iter_10_0 = 1, self.packContainerTF.childCount do
		local var_10_0 = self.packContainerTF:GetChild(iter_10_0 - 1)
		local var_10_1 = var_10_0:Find("TimeLimit/Text"):GetComponent(typeof(Text))

		var_10_1.material = Object.Instantiate(var_10_1.material)

		local var_10_2 = var_10_0:Find("Price/Text"):GetComponent(typeof(Text))

		var_10_2.material = Object.Instantiate(var_10_2.material)

		local var_10_3 = var_10_0:Find("Mask/Text"):GetComponent(typeof(Text))

		var_10_3.material = Object.Instantiate(var_10_3.material)
	end

	return
end

function RefluxShopView:updateItem(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("Count")
	local var_11_1 = arg_11_2.type or arg_11_2[1]
	local var_11_2 = arg_11_2.id or arg_11_2[2]
	local var_11_3 = arg_11_2.count or arg_11_2[3]

	setText(var_11_0, var_11_3)
	setActive(arg_11_1:Find("Frame"), false)
	setActive(arg_11_1:Find("Icon"), false)
	setActive(var_11_0, false)

	local var_11_4 = findTF(arg_11_1, "CommonItemTemplate")

	setActive(var_11_4, true)
	updateDrop(var_11_4, {
		type = var_11_1,
		id = var_11_2,
		count = var_11_3
	})

	return
end

function RefluxShopView:updatePack(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == false then
		setActive(arg_12_1, false)

		return
	elseif arg_12_3 == RefluxShopView.GiftPackType.Money and self:isBuyEver(arg_12_2.id) then
		setActive(arg_12_1, false)

		return
	else
		setActive(arg_12_1, true)
	end

	local var_12_1

	if arg_12_3 == RefluxShopView.GiftPackType.Money then
		-- block empty
	else
		var_12_1 = Item.getConfigData(arg_12_2:getConfig("effect_args")[1])
	end

	setImageSprite(arg_12_1:Find("PackIcon"), LoadSprite(arg_12_3 == RefluxShopView.GiftPackType.Money and "chargeicon/" .. arg_12_2:getConfig("picture") or var_12_1.icon), true)

	local var_12_4 = arg_12_1:Find("PackName")

	if arg_12_3 == RefluxShopView.GiftPackType.Money then
		setText(var_12_4, arg_12_2:getConfig("name_display"))
	else
		setText(var_12_4, var_12_1.name)
	end

	local var_12_5 = arg_12_1:Find("ItemList")
	local var_12_6 = arg_12_3 == RefluxShopView.GiftPackType.Money and arg_12_2:getConfig("display") or var_12_1.display_icon
	local var_12_7 = UIItemList.New(var_12_5, self.itemTpl)

	var_12_7:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			arg_13_1 = arg_13_1 + 1

			self:updateItem(arg_13_2, var_12_6[arg_13_1])
		end

		return
	end)
	var_12_7:align(#var_12_6)

	local var_12_8 = arg_12_1:Find("DescFrame/Text")

	if arg_12_3 == RefluxShopView.GiftPackType.Money then
		setText(var_12_8, arg_12_2:getConfig("descrip"))
	else
		setText(var_12_8, var_12_1.display)
	end

	local var_12_9 = arg_12_1:Find("TimeLimit")

	if arg_12_3 ~= RefluxShopView.GiftPackType.Money and self:isHaveNextPack(RefluxShopView.GiftPackTypeName[arg_12_3]) and not self:isBuyEver(arg_12_2.id) then
		setActive(var_12_9, true)
		self:updatePackTimeLimit(var_12_9:Find("Text"), arg_12_3)
	end

	local var_12_11

	do
		setActive(var_12_9, false)

		var_12_11 = setActive
	end

	var_12_11(arg_12_1:Find("MoneyTag"), arg_12_3 == RefluxShopView.GiftPackType.Money)

	local var_12_12 = arg_12_1:Find("Price/IconMoney")
	local var_12_13 = arg_12_1:Find("Price/Icon")
	local var_12_14 = arg_12_1:Find("Price/Icon/Res")
	local var_12_15 = arg_12_1:Find("Price/Text")

	if arg_12_3 == RefluxShopView.GiftPackType.Money then
		setActive(var_12_12, true)
		setActive(var_12_13, false)
		setText(var_12_15, arg_12_2:getConfig("money"))
	else
		setActive(var_12_12, false)
		setActive(var_12_13, true)
		setText(var_12_15, arg_12_2:getConfig("resource_num"))

		local var_12_16 = arg_12_2:getConfig("resource_type")
		local var_12_17

		if var_12_16 == RefluxShopView.Special_ID_Gem then
			var_12_17 = "props/gem"
		elseif var_12_16 == RefluxShopView.Special_ID_Gold then
			var_12_17 = "props/gold"
		end

		setImageSprite(var_12_14, LoadSprite(var_12_17), true)
	end

	local var_12_18 = arg_12_1:Find("Mask")
	local var_12_19 = self:isBuyEver(arg_12_2.id)

	setActive(var_12_18, var_12_19)

	if var_12_19 then
		local var_12_20 = var_12_18:Find("NextTime")
		local var_12_21 = var_12_18:Find("Text")
		local var_12_22 = var_12_18:Find("Sellout")

		if self:isHaveNextPack(RefluxShopView.GiftPackTypeName[arg_12_3]) then
			setActive(var_12_20, true)
			setActive(var_12_21, true)
			setActive(var_12_22, false)
			self:updatePackNextTime(var_12_21, arg_12_3)
		else
			setActive(var_12_20, false)
			setActive(var_12_21, false)
			setActive(var_12_22, true)
		end
	end

	onButton(self, arg_12_1, function()
		if not isActive(var_12_18) then
			self:confirm(arg_12_2)
		end

		return
	end, SFX_PANEL)

	return
end

function RefluxShopView:updatePackTimeLimit(arg_15_1, arg_15_2)
	local var_15_0 = self:calcNextGiftPackSecByType(RefluxShopView.GiftPackTypeName[arg_15_2], (self:getCurDay()))
	local var_15_1 = self.packTimerList[arg_15_2]

	if self.packTimerList[arg_15_2] then
		var_15_1:Stop()

		self.packTimerList[arg_15_2] = nil
	end

	local function var_15_2()
		if var_15_0 >= 0 then
			setText(arg_15_1, (pg.TimeMgr.GetInstance():DescCDTime(var_15_0)))

			var_15_0 = var_15_0 - 1
		else
			var_15_1:Stop()

			self.packTimerList[arg_15_2] = nil
		end

		return
	end

	var_15_1 = Timer.New(var_15_2, 1, -1)

	var_15_1:Start()

	self.packTimerList[arg_15_2] = var_15_1

	var_15_2()

	return
end

function RefluxShopView:updatePackNextTime(arg_17_1, arg_17_2)
	local var_17_0 = self:calcNextGiftPackSecByType(RefluxShopView.GiftPackTypeName[arg_17_2], (self:getCurDay()))
	local var_17_1 = self.packNextTimerList[arg_17_2]

	if self.packNextTimerList[arg_17_2] then
		var_17_1:Stop()

		self.packNextTimerList[arg_17_2] = nil
	end

	local function var_17_2()
		if var_17_0 >= 0 then
			setText(arg_17_1, (pg.TimeMgr.GetInstance():DescCDTime(var_17_0)))

			var_17_0 = var_17_0 - 1
		else
			var_17_1:Stop()

			self.packNextTimerList[arg_17_2] = nil
		end

		return
	end

	var_17_1 = Timer.New(var_17_2, 1, -1)

	var_17_1:Start()

	self.packNextTimerList[arg_17_2] = var_17_1

	var_17_2()

	return
end

function RefluxShopView:updatePackList()
	self.packItemList:align(#self.goodVOList)

	return
end

function RefluxShopView.isShowRedPot()
	if PlayerPrefs.GetInt("RefluxShop_Enter_Day", 0) < getProxy(RefluxProxy).signCount then
		return true
	else
		return false
	end

	return
end

function RefluxShopView.SaveEnterTag()
	PlayerPrefs.SetInt("RefluxShop_Enter_Day", getProxy(RefluxProxy).signCount)

	return
end

function RefluxShopView:getCurDay()
	local var_22_0 = pg.TimeMgr.GetInstance():DiffDay(self.refluxProxy.returnTimestamp, (pg.TimeMgr.GetInstance():GetServerTime()))

	if var_22_0 < #pg.return_giftpack_template.all then
		return var_22_0 + 1
	else
		return #pg.return_giftpack_template.all
	end

	return
end

function RefluxShopView:getLevelIndex(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(pg.return_giftpack_template[arg_23_1 or self:getCurDay()].level) do
		if iter_23_1[1] <= self.refluxProxy.returnLV and self.refluxProxy.returnLV <= iter_23_1[2] then
			return iter_23_0
		end
	end

	return
end

function RefluxShopView:getCurDayGiftPackIDByType(arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 or self:getCurDay()

	if var_24_0 > #pg.return_giftpack_template.all then
		return false
	end

	local var_24_1 = pg.return_giftpack_template[var_24_0][arg_24_1]
	local var_24_2 = var_24_0

	while var_24_1 == "" and var_24_2 > 1 do
		var_24_2 = var_24_2 - 1
		var_24_1 = pg.return_giftpack_template[var_24_2][arg_24_1]
	end

	if var_24_1 == "" then
		return false
	else
		return var_24_1[self:getLevelIndex(var_24_2)]
	end

	return
end

function RefluxShopView:getCurDayGiftPackIDList()
	local var_25_0 = self:getCurDay()

	return {
		[RefluxShopView.GiftPackType.Money] = self:getCurDayGiftPackIDByType("pack_type_1", var_25_0),
		[RefluxShopView.GiftPackType.Diamond] = self:getCurDayGiftPackIDByType("pack_type_2", var_25_0),
		[RefluxShopView.GiftPackType.Gold] = self:getCurDayGiftPackIDByType("pack_type_3", var_25_0)
	}
end

function RefluxShopView:getNextGiftPackDayByType(arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2 or self:getCurDay()
	local var_26_1

	if var_26_0 >= #pg.return_giftpack_template.all then
		do return false end

		var_26_1 = pg.return_giftpack_template[var_26_0 + 1][arg_26_1]
	end

	local var_26_2 = var_26_0 + 1

	while var_26_1 == "" and var_26_2 > 1 and var_26_2 <= #pg.return_giftpack_template.all do
		var_26_1 = pg.return_giftpack_template[var_26_2][arg_26_1]
		var_26_2 = var_26_2 + 1
	end

	if var_26_1 == "" then
		return false
	else
		return var_26_2
	end

	return
end

function RefluxShopView:isHaveNextPack(arg_27_1, arg_27_2)
	return self:getNextGiftPackDayByType(arg_27_1, arg_27_2 or self:getCurDay()) ~= false
end

function RefluxShopView:calcNextGiftPackSecByType(arg_28_1, arg_28_2)
	return self.refluxProxy.returnTimestamp + (self:getNextGiftPackDayByType(arg_28_1, arg_28_2 or self:getCurDay()) - 1) * 0 - pg.TimeMgr.GetInstance():GetServerTime()
end

function RefluxShopView:isBuyEver(arg_29_1)
	local var_29_0 = getProxy(ShopsProxy)

	return 0 + ChargeConst.getBuyCount(var_29_0:getChargedList(), arg_29_1) + ChargeConst.getBuyCount(var_29_0:GetNormalList(), arg_29_1) > 0
end

function RefluxShopView:confirm(arg_30_1)
	if not arg_30_1 then
		return
	end

	arg_30_1 = Clone(arg_30_1)

	if arg_30_1:isChargeType() then
		local var_30_0 = not table.contains(self.firstChargeIds, arg_30_1.id) and arg_30_1:firstPayDouble()
		local var_30_1 = var_30_0 and 4 or arg_30_1:getConfig("tag")

		if arg_30_1:isMonthCard() or arg_30_1:isGiftBox() or arg_30_1:isItemBox() or arg_30_1:isPassItem() then
			local var_30_2 = arg_30_1:GetExtraServiceItem()
			local var_30_3 = arg_30_1:GetExtraDrop()
			local var_30_4 = arg_30_1:GetBonusItem()
			local var_30_5
			local var_30_6

			if arg_30_1:isPassItem() then
				var_30_5 = i18n("battlepass_pay_tip")
			elseif arg_30_1:isMonthCard() then
				var_30_5 = i18n("charge_title_getitem_month")
				var_30_6 = i18n("charge_title_getitem_soon")
			else
				var_30_5 = i18n("charge_title_getitem")
			end

			self:emit(RefluxMediator.OPEN_CHARGE_ITEM_PANEL, {
				isChargeType = true,
				commodity = arg_30_1,
				infoTip = arg_30_1:GetInfoTip(),
				icon = "chargeicon/" .. arg_30_1:getConfig("picture"),
				name = arg_30_1:getConfig("name_display"),
				tipExtra = var_30_5,
				extraItems = var_30_2,
				price = arg_30_1:getConfig("money"),
				isLocalPrice = arg_30_1:IsLocalPrice(),
				tagType = var_30_1,
				isMonthCard = arg_30_1:isMonthCard(),
				tipBonus = var_30_6,
				bonusItem = var_30_4,
				extraDrop = var_30_3,
				descExtra = arg_30_1:getConfig("descrip_extra"),
				limitArgs = arg_30_1:getConfig("limit_args"),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(RefluxMediator.OPEN_CHARGE_BIRTHDAY)
					else
						pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
							shopId = arg_30_1.id
						})
					end

					return
				end
			})
		elseif arg_30_1:isGem() then
			local var_30_7 = arg_30_1:getConfig("money")
			local var_30_8 = arg_30_1:getConfig("gem")

			var_30_8 = var_30_0 and var_30_8 + arg_30_1:getConfig("gem") or var_30_8 + arg_30_1:getConfig("extra_gem")

			self:emit(RefluxMediator.OPEN_CHARGE_ITEM_BOX, {
				isChargeType = true,
				commodity = arg_30_1,
				icon = "chargeicon/" .. arg_30_1:getConfig("picture"),
				name = arg_30_1:getConfig("name_display"),
				price = arg_30_1:getConfig("money"),
				isLocalPrice = arg_30_1:IsLocalPrice(),
				tagType = var_30_1,
				normalTip = i18n("charge_start_tip", var_30_7, var_30_8),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						self:emit(RefluxMediator.OPEN_CHARGE_BIRTHDAY)
					else
						pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
							shopId = arg_30_1.id
						})
					end

					return
				end
			})
		end
	else
		local var_30_9 = {}
		local var_30_10 = Item.getConfigData(arg_30_1:getConfig("effect_args")[1])

		if type(var_30_10.display_icon) == "table" then
			for iter_30_0, iter_30_1 in ipairs(var_30_10.display_icon) do
				table.insert(var_30_9, Drop.Create(iter_30_1))
			end
		end

		local var_30_11 = arg_30_1:getConfig("resource_type") == RefluxShopView.Special_ID_Gold
		local var_30_12 = var_30_11 and i18n("charge_scene_buy_confirm_gold", arg_30_1:getConfig("resource_num"), var_30_10.name) or i18n("charge_scene_buy_confirm", arg_30_1:getConfig("resource_num"), var_30_10.name)

		self:emit(RefluxMediator.OPEN_CHARGE_ITEM_PANEL, {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_30_1,
			icon = var_30_10.icon,
			name = var_30_10.name,
			tipExtra = i18n("charge_title_getitem"),
			extraItems = var_30_9,
			price = arg_30_1:getConfig("resource_num"),
			tagType = arg_30_1:getConfig("tag"),
			isForceGold = var_30_11,
			onYes = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = var_30_12,
					onYes = function()
						pg.m02:sendNotification(GAME.SHOPPING, {
							count = 1,
							id = arg_30_1.id
						})

						return
					end
				})

				return
			end
		})
	end

	return
end

function RefluxShopView.getAllRefluxPackID()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(pg.return_giftpack_template.all) do
		if type(pg.return_giftpack_template[iter_35_1].pack_type_1) == "table" then
			for iter_35_2, iter_35_3 in pairs(pg.return_giftpack_template[iter_35_1].pack_type_1) do
				table.insert(var_35_0, iter_35_3)
			end
		end

		if type(pg.return_giftpack_template[iter_35_1].pack_type_2) == "table" then
			for iter_35_4, iter_35_5 in pairs(pg.return_giftpack_template[iter_35_1].pack_type_2) do
				table.insert(var_35_0, iter_35_5)
			end
		end

		if type(pg.return_giftpack_template[iter_35_1].pack_type_3) == "table" then
			for iter_35_6, iter_35_7 in pairs(pg.return_giftpack_template[iter_35_1].pack_type_3) do
				table.insert(var_35_0, iter_35_7)
			end
		end
	end

	return var_35_0
end

return RefluxShopView
