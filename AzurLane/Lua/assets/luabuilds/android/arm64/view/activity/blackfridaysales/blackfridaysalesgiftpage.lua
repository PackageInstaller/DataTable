class = var_0_10000

local var_0_0 = "BlackFridaySalesGiftPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BlackFridaySalesGiftPage"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.player = var_1.getData(var_3_0)
	getProxy = var_1
	ActivityProxy = var_3_0

	local var_3_1 = var_1(var_3_0)
	local var_3_2 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_3_0.activity = var_3_2(var_3_1, var_1_10004.ACTIVITY_TYPE_GIFT_UP)

	arg_3_0:initGiftGoods()

	arg_3_0.openIndex = 1

	arg_3_0:updateGiftGoodsVOList()

	return
end

function var_0_1.initUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.content = var_1.Find(var_4_0, "scrollrect/content")

	local var_4_1 = arg_4_0._tf

	arg_4_0.soldOutTF = var_1.Find(var_4_1, "sold_out")
	setText = var_1

	local var_4_2 = arg_4_0.soldOutTF
	local var_4_3 = var_3.Find(var_4_2, "Text")

	i18n = var_4

	var_1(var_4_3, var_4("newserver_soldout"))

	setActive = var_1

	var_1(arg_4_0.soldOutTF, #arg_4_0.giftGoodsVOList == 0)

	local var_4_4 = {}
	local var_4_5 = arg_4_0._tf

	var_4_4[1] = var_2.Find(var_4_5, "pagefooter/dailyPacks")

	local var_4_6 = arg_4_0._tf

	var_4_4[2] = var_2.Find(var_4_6, "pagefooter/specialPacks")
	arg_4_0.pagefooters = var_4_4
	setText = var_4_4

	local var_4_7 = arg_4_0._tf
	local var_4_8 = var_3.Find(var_4_7, "pagefooter/dailyPacks/Text")

	i18n = var_4_6

	var_4_4(var_4_8, var_4_6("blackfriday_dailypack"))

	setText = var_4_4

	local var_4_9 = arg_4_0._tf
	local var_4_10 = var_3.Find(var_4_9, "pagefooter/dailyPacks/mark")

	i18n = var_4

	var_4_4(var_4_10, var_4("blackfriday_dailypack"))

	setText = var_4_4

	local var_4_11 = arg_4_0._tf
	local var_4_12 = var_3.Find(var_4_11, "pagefooter/specialPacks/Text")

	i18n = var_4

	var_4_4(var_4_12, var_4("blackfriday_specialpack"))

	setText = var_4_4

	local var_4_13 = arg_4_0._tf
	local var_4_14 = var_3.Find(var_4_13, "pagefooter/specialPacks/mark")

	i18n = var_4

	var_4_4(var_4_14, var_4("blackfriday_specialpack"))

	arg_4_0.pagefooterWid = arg_4_0.pagefooters[1].rect.width
	arg_4_0.pagefooterStartPosX = arg_4_0.pagefooters[1].anchoredPosition.x
	UIItemList = var_1

	local var_4_15 = var_1.New
	local var_4_16 = arg_4_0.content
	local var_4_17 = arg_4_0._tf

	arg_4_0.giftItemList = var_4_15(var_4_16, var_4.Find(var_4_17, "gift_tpl"))
	arg_4_0.chargeCardTable = {}

	local var_4_18 = arg_4_0.giftItemList

	var_1.make(var_4_18, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		local var_5_1

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_4_0

			var_5_1 = var_5_1.initGift
			go = var_2_10006

			var_5_1(var_5_0, var_2_10006(arg_5_2))
		else
			UIItemList = var_5_1

			if arg_5_0 == var_5_1.EventUpdate then
				local var_5_2 = arg_4_0
				local var_5_3 = var_3.updateGift

				go = var_2_10006

				var_5_3(var_5_2, var_2_10006(arg_5_2), arg_5_1)
			end
		end

		return
	end)

	local var_4_19 = arg_4_0.giftItemList

	var_1.align(var_4_19, #arg_4_0.giftGoodsVOList)
	arg_4_0:UpdatePageFooters()

	return
end

function var_0_1.UpdatePageFooters(arg_6_0)
	arg_6_0.pagefooterTrs = {}

	for iter_6_0 = 1, 2 do
		local var_6_0 = arg_6_0.pagefooters[iter_6_0]

		arg_6_0:UpdatePageFooter(var_6_0, iter_6_0)

		arg_6_0.pagefooterTrs[iter_6_0] = var_6_0
	end

	local var_6_1

	if not arg_6_0.contextData.index then
		var_6_1 = 1
	end

	triggerButton = var_2

	var_2(arg_6_0.pagefooterTrs[var_6_1])

	return
end

local var_0_2 = 0

function var_0_1.UpdatePageFooter(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.pagefooterStartPosX + (var_0_2 + arg_7_0.pagefooterWid) * (arg_7_2 - 1)

	setAnchoredPosition = var_4

	var_4(arg_7_1, {
		x = var_7_0
	})
	arg_7_0:OnSwitch(arg_7_1, function()
		local var_8_0 = arg_7_0

		var_0.SwitchTab(var_8_0, arg_7_2)

		return
	end)

	return
end

function var_0_1.OnSwitch(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.Find(var_9_0, "mark")

	local function var_9_2()
		if arg_9_0.markTr then
			setActive = var_0

			var_0(arg_9_0.markTr, false)
		end

		local var_10_0 = arg_9_0

		var_10_0.markTr = var_9_1
		setActive = var_10_0

		var_10_0(var_9_1, true)

		return
	end

	onButton = var_9_0

	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_1

	local function var_9_5()
		var_9_2()
		arg_9_2()

		return
	end

	SFX_PANEL = var_1_10010

	var_9_0(var_9_3, var_9_4, var_9_5, var_1_10010)

	return
end

function var_0_1.SwitchTab(arg_12_0, arg_12_1)
	arg_12_0.openIndex = arg_12_1

	arg_12_0:onUpdateGift()

	return
end

function var_0_1.initGift(arg_13_0, arg_13_1)
	BlackFridayChargeCard = var_1_10002

	local var_13_0 = var_1_10002.New(arg_13_1)

	onButton = var_1_10003

	local var_13_1 = arg_13_0
	local var_13_2 = var_13_0.tr

	local function var_13_3()
		local var_14_0 = var_13_0

		if var_0.inTime(var_14_0) then
			local var_14_1 = arg_13_0

			var_0.confirm(var_14_1, var_13_0.goods)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_13_1, var_13_2, var_13_3, var_1_10008)

	arg_13_0.chargeCardTable[arg_13_1] = var_13_0

	return
end

function var_0_1.updateGift(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if not arg_15_0.chargeCardTable[arg_15_1] then
		arg_15_0.initGift(arg_15_1)

		var_15_0 = arg_15_0.chargeCardTable[arg_15_1]
	end

	if arg_15_0.giftGoodsVOList[arg_15_2] then
		var_15_0:update(var_4, arg_15_0.player, arg_15_0.firstChargeIds)
	end

	return
end

function var_0_1.confirm(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	Clone = var_1_10002

	local var_16_0 = var_1_10002(arg_16_1)

	if arg_16_1.isChargeType(var_16_0) then
		table = var_2
		var_16_0 = not var_2.contains(arg_16_0.firstChargeIds, arg_16_1.id) and arg_16_1:firstPayDouble() and 4 or arg_16_1:getConfig("tag")

		local var_16_1 = arg_16_1:GetExtraServiceItem()
		local var_16_2 = arg_16_1:GetExtraDrop()
		local var_16_3 = arg_16_1:GetBonusItem()
		local var_16_4
		local var_16_5

		if arg_16_1:isPassItem() then
			i18n = var_10
			var_16_4 = var_10("battlepass_pay_tip")
		elseif arg_16_1:isMonthCard() then
			i18n = var_10
			var_16_4 = var_10("charge_title_getitem_month")
			i18n = var_10
			var_16_5 = var_10("charge_title_getitem_soon")
		else
			i18n = var_10
			var_16_4 = var_10("charge_title_getitem")
		end

		local var_16_6 = {
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
				ChargeConst = var_2_10000

				if var_2_10000.isNeedSetBirth() then
					local var_17_0 = arg_16_0
					local var_17_1 = var_0.emit

					BlackFridaySalesMediator = var_2_10003

					var_17_1(var_17_0, var_2_10003.OPEN_CHARGE_BIRTHDAY)
				else
					local var_17_2 = arg_16_0
					local var_17_3 = var_0.emit

					BlackFridaySalesMediator = var_2_10003

					var_17_3(var_17_2, var_2_10003.CHARGE, arg_16_1.id)
				end

				return
			end
		}
		local var_16_7 = arg_16_0

		var_1_10011 = arg_16_0.emit
		BlackFridaySalesMediator = var_14

		var_1_10011(var_16_7, var_14.GIFT_OPEN_ITEM_PANEL, var_16_6)
	else
		local var_16_8 = {}
		local var_16_9 = arg_16_1:getConfig("effect_args")

		Item = var_16_0

		local var_16_10 = var_16_0.getConfigData(var_16_9[1]).display_icon

		type = var_6

		if var_6(var_16_10) == "table" then
			ipairs = var_6

			for iter_16_0, iter_16_1 in var_6(var_16_10) do
				table = var_1_10011

				var_1_10011.insert(var_16_8, {
					type = iter_16_1[1],
					id = iter_16_1[2],
					count = iter_16_1[3]
				})
			end
		end

		local var_16_11 = {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_16_1,
			icon = var_4.icon,
			name = var_4.name
		}

		i18n = var_7
		var_16_11.tipExtra = var_7("charge_title_getitem")
		var_16_11.extraItems = var_16_8
		var_16_11.price = arg_16_1:getConfig("resource_num")
		var_16_11.tagType = arg_16_1:getConfig("tag")

		function var_16_11.onYes()
			pg = var_2_10000

			local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_18_1 = var_0.ShowMsgBox
			local var_18_2 = {}

			i18n = var_2_10004

			local var_18_3 = "charge_scene_buy_confirm"
			local var_18_4 = arg_16_1

			var_18_2.content = var_2_10004(var_18_3, var_7.getConfig(var_18_4, "resource_num"), var_0.name)

			function var_18_2.onYes()
				local var_19_0 = arg_16_0
				local var_19_1 = var_0.emit

				BlackFridaySalesMediator = var_3_10003

				var_19_1(var_19_0, var_3_10003.GIFT_BUY_ITEM, arg_16_1.id, 1)

				return
			end

			var_18_1(var_18_0, var_18_2)

			return
		end

		local var_16_12 = arg_16_0
		local var_16_13 = arg_16_0.emit

		BlackFridaySalesMediator = var_10

		var_16_13(var_16_12, var_10.GIFT_OPEN_ITEM_PANEL, var_16_11)
	end

	return
end

function var_0_1.onUpdatePlayer(arg_20_0, arg_20_1)
	arg_20_0.player = arg_20_1

	return
end

function var_0_1.onUpdateGift(arg_21_0)
	arg_21_0:updateGiftGoodsVOList()

	local var_21_0 = arg_21_0.giftItemList

	var_1.align(var_21_0, #arg_21_0.giftGoodsVOList)

	setActive = var_1

	var_1(arg_21_0.soldOutTF, #arg_21_0.giftGoodsVOList == 0)

	return
end

function var_0_1.initGiftGoods(arg_22_0)
	arg_22_0.giftList = {
		{},
		{}
	}

	local var_22_0 = arg_22_0.activity
	local var_22_1 = var_1.getConfig(var_22_0, "config_client")

	getProxy = var_2
	ShopsProxy = var_4

	local var_22_2 = var_2(var_4)
	local var_22_3

	if not var_2.getChargedList(var_22_2) then
		var_22_3 = {}
	end

	pairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(var_22_1.gifts[1]) do
		Goods = var_1_10008
		var_1_10008 = var_1_10008.Create

		local var_22_4 = {
			shop_id = iter_22_1
		}

		Goods = var_1_10011
		var_1_10008 = var_1_10008(var_22_4, var_1_10011.TYPE_CHARGE)
		table = var_1_10009

		var_1_10009.insert(arg_22_0.giftList[1], var_1_10008)
	end

	pairs = var_3

	for iter_22_2, iter_22_3 in var_3(var_22_1.gifts[2]) do
		Goods = var_1_10008
		var_1_10008 = var_1_10008.Create

		local var_22_5 = {
			shop_id = iter_22_3
		}

		Goods = var_1_10011
		var_1_10008 = var_1_10008(var_22_5, var_1_10011.TYPE_NEW_SERVER)
		table = var_1_10009

		var_1_10009.insert(arg_22_0.giftList[1], var_1_10008)
	end

	pairs = var_3

	for iter_22_4, iter_22_5 in var_3(var_22_1.gifts_2) do
		Goods = var_1_10008
		var_1_10008 = var_1_10008.Create

		local var_22_6 = {
			shop_id = iter_22_5
		}

		Goods = var_1_10011
		var_1_10008 = var_1_10008(var_22_6, var_1_10011.TYPE_CHARGE)
		ChargeConst = var_1_10009
		var_1_10009 = var_1_10009.getBuyCount(var_22_3, iter_22_5)

		var_1_10008:updateBuyCount(var_1_10009)

		table = var_10

		var_10.insert(arg_22_0.giftList[2], var_1_10008)
	end

	return
end

function var_0_1.updateGiftGoodsVOList(arg_23_0, arg_23_1)
	arg_23_1 = arg_23_1 or arg_23_0.openIndex
	Clone = var_1_10002
	arg_23_0.giftGoodsVOList = var_1_10002(arg_23_0.giftList[arg_23_1])
	getProxy = var_2
	ShopsProxy = var_4

	local var_23_0 = var_2(var_4)

	arg_23_0.normalList = var_2.GetNormalList(var_23_0)
	getProxy = var_2
	ShopsProxy = var_23_0

	local var_23_1 = var_2(var_23_0)

	arg_23_0.chargedList = var_2.getChargedList(var_23_1)

	local var_23_2 = {}

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(arg_23_0.giftGoodsVOList) do
		local var_23_3

		if iter_23_1:isChargeType() then
			ChargeConst = var_9
			var_23_3 = var_9.getBuyCount(arg_23_0.chargedList, iter_23_1.id)
		else
			ChargeConst = var_9
			var_23_3 = var_9.getBuyCount(arg_23_0.normalList, iter_23_1.id)
		end

		iter_23_1:updateBuyCount(var_23_3)

		if iter_23_1:canPurchase() then
			table = var_9

			var_9.insert(var_23_2, iter_23_1)
		end
	end

	pg = var_3

	local var_23_4 = var_3.TimeMgr.GetInstance()

	table = var_4

	var_4.sort(var_23_2, function(arg_24_0, arg_24_1)
		local var_24_0 = var_23_4
		local var_24_1 = var_2.inTime(var_24_0, arg_24_0:getConfig("time")) and 1 or 0
		local var_24_2 = var_23_4
		local var_24_3 = var_3.inTime(var_24_2, arg_24_1:getConfig("time")) and 1 or 0
		local var_24_4 = arg_24_0:isChargeType() and 1 or 0
		local var_24_5 = arg_24_1:isChargeType() and 1 or 0

		if var_24_1 == var_24_3 then
			if var_24_4 == var_24_5 then
				return arg_24_0.id < arg_24_1.id
			else
				return var_24_4 < var_24_5
			end
		else
			return var_24_3 < var_24_1
		end

		return
	end)

	arg_23_0.giftGoodsVOList = var_23_2

	return
end

function var_0_1.isTip(arg_25_0)
	local var_25_0 = false

	pg = var_1_10002

	local var_25_1 = var_1_10002.TimeMgr.GetInstance()
	local var_25_2

	if not (function(arg_26_0)
		local var_26_0 = false

		Clone = var_2_10002

		local var_26_1 = var_2_10002(arg_25_0.giftList[arg_26_0])

		ipairs = var_2_10003

		for iter_26_0, iter_26_1 in var_2_10003(var_26_1) do
			local var_26_2

			if iter_26_1:isChargeType() then
				ChargeConst = var_26_2
				var_26_2 = var_26_2.getBuyCount(arg_25_0.chargedList, iter_26_1.id)
				var_26_2 = count
			else
				ChargeConst = var_26_2

				local var_26_3 = var_26_2.getBuyCount(arg_25_0.normalList, iter_26_1.id)
				local var_26_4 = count
			end

			local var_26_5 = iter_26_1
			local var_26_6 = iter_26_1.updateBuyCount

			count = var_2_10011

			var_26_6(var_26_5, var_2_10011)

			if iter_26_1:canPurchase() and not iter_26_1:isChargeType() then
				local var_26_7 = var_25_1

				if var_8.inTime(var_26_7, iter_26_1:getConfig("time")) then
					var_26_0 = true
				end
			end
		end

		return var_26_0
	end)(1) then
		var_25_2 = var_3(2)
	end

	return var_25_2
end

function var_0_1.OnDestroy(arg_27_0)
	return
end

return var_0_1
