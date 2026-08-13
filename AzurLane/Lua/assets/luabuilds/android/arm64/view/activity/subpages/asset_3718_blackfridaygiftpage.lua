class = var_0_10000

local var_0_0 = "BlackFridayGiftPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

var_0_1.DAY_COLOR = {
	"110C08",
	"C8A471"
}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtGift = var_1.Find(var_1_0, "AD/gift")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtFreeGift = var_1.Find(var_1_1, "AD/gift_free")

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_1.Find(var_1_2, "AD/days")

	UIItemList = var_1_10002
	arg_1_0.uiList = var_1_10002.New(var_1_3, var_1_3:Find("day"))

	local var_1_4 = arg_1_0.uiList

	var_2.make(var_1_4, function(arg_2_0, arg_2_1, arg_2_2)
		arg_2_1 = arg_2_1 + 1
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_2_2:Find("Text"), "DAY" .. arg_2_1)

			setTextColor = var_3

			local var_2_0 = arg_2_2:Find("Text")

			Color = var_6

			var_3(var_2_0, var_6.NewHex(arg_1_0.DAY_COLOR[2]))

			setActive = var_3

			var_3(arg_2_2:Find("lock"), arg_2_1 > arg_1_0.nday)

			setActive = var_3

			local var_2_1 = arg_2_2:Find("tip")
			local var_2_2, var_2_3

			if arg_2_1 <= arg_1_0.nday then
				var_2_2 = arg_1_0.freeGifts[arg_2_1]
				var_2_3 = var_6.canPurchase(var_2_2)
			else
				var_2_3 = false
			end

			if false then
				var_2_3 = true
			end

			var_3(var_2_1, var_2_3)

			onToggle = var_3

			local var_2_4 = arg_1_0
			local var_2_5 = arg_2_2

			local function var_2_6(arg_3_0)
				if arg_3_0 then
					var_3_10001 = arg_1_0
					var_3_10001.index = arg_2_1

					local var_3_0 = arg_1_0

					var_3_10001.ShowGifts(var_3_0, arg_2_1)
				end

				setTextColor = var_3_10001

				local var_3_1 = arg_2_2
				local var_3_2 = var_3.Find(var_3_1, "Text")

				Color = var_3_10004

				var_3_10001(var_3_2, var_3_10004.NewHex(arg_1_0.DAY_COLOR[arg_3_0 and 1 or 2]))

				return
			end

			SFX_PANEL = var_2_2

			var_3(var_2_4, var_2_5, var_2_6, var_2_2)
		end

		return
	end)

	return
end

function var_0_1.OnDataSetting(arg_4_0)
	if not arg_4_0.idLists then
		local var_4_0 = arg_4_0.activity

		arg_4_0.idLists = var_1.getConfig(var_4_0, "config_client").gifts
		assert = var_1

		var_1(#arg_4_0.idLists[1] == #arg_4_0.idLists[2])
	end

	math = var_1

	local var_4_1 = var_1.min
	local var_4_2 = #arg_4_0.idLists[1]
	local var_4_3 = arg_4_0.activity

	arg_4_0.nday = var_4_1(var_4_2, var_4.getNDay(var_4_3))
	getProxy = var_1
	ShopsProxy = var_4_2

	local var_4_4 = var_1(var_4_2)

	underscore = var_1_10002
	arg_4_0.gifts = var_1_10002.map(arg_4_0.idLists[1], function(arg_5_0)
		local var_5_0 = var_4_4
		local var_5_1 = var_1.GetGiftCommodity
		local var_5_2 = arg_5_0

		Goods = var_2_10005

		return var_5_1(var_5_0, var_5_2, var_2_10005.TYPE_CHARGE)
	end)
	underscore = var_2
	arg_4_0.freeGifts = var_2.map(arg_4_0.idLists[2], function(arg_6_0)
		local var_6_0 = var_4_4
		local var_6_1 = var_1.GetGiftCommodity
		local var_6_2 = arg_6_0

		Goods = var_2_10005

		return var_6_1(var_6_0, var_6_2, var_2_10005.TYPE_GIFT_PACKAGE)
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0.uiList

	var_1.align(var_7_0, #arg_7_0.idLists[1])

	if not arg_7_0.index then
		arg_7_0.index = arg_7_0.nday

		::label_7_0::

		if arg_7_0.index > 0 then
			local var_7_1 = arg_7_0.gifts[arg_7_0.index]

			if not var_1.canPurchase(var_7_1) then
				local var_7_2 = arg_7_0.freeGifts[arg_7_0.index]

				if not var_1.canPurchase(var_7_2) then
					repeat
						arg_7_0.index = arg_7_0.index - 1

						goto label_7_0
					until true
				end
			end
		end

		arg_7_0.index = (arg_7_0.index - 1) % arg_7_0.nday + 1
		triggerToggle = var_1

		local var_7_3 = arg_7_0.uiList.container

		var_1(var_3.GetChild(var_7_3, arg_7_0.index - 1), true)
	else
		arg_7_0:ShowGifts(arg_7_0.index)
	end

	return
end

function var_0_1.ShowGifts(arg_8_0, arg_8_1)
	arg_8_0:UpdateCard(arg_8_0.rtGift, arg_8_0.gifts[arg_8_0.index])
	arg_8_0:UpdateCard(arg_8_0.rtFreeGift, arg_8_0.freeGifts[arg_8_0.index])

	return
end

local function var_0_2(arg_9_0)
	local var_9_0

	if not ({
		"hot",
		"new_tag",
		"tuijian",
		"shuangbei_tag",
		"activity",
		"xianshi"
	})[arg_9_0] then
		var_9_0 = "hot"
	end

	return var_9_0
end

function var_0_1.UpdateCard(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1

	if arg_10_2:isChargeType() then
		var_10_1 = {
			isFree = false,
			name = arg_10_2:getConfig("name_display"),
			price = arg_10_2:getConfig("money"),
			count = arg_10_2:GetLimitDesc(),
			desc = arg_10_2:getConfig("descrip")
		}
		i18n = var_1_10005
		var_10_1.free = var_1_10005("shop_free_tag")
		i18n = var_1_10005
		var_10_1.purchased = var_1_10005("blackfriday_pack_purchased")
		var_10_1.icon = "ChargeIcon/" .. arg_10_2:getConfig("picture")
		underscore = var_1_10005

		local var_10_2 = var_1_10005(arg_10_2:getConfig("display"))
		local var_10_3 = var_1_10005.chain(var_10_2)
		local var_10_4 = var_1_10005.first(var_10_3, 3)
		local var_10_5 = var_1_10005.map(var_10_4, function(arg_11_0)
			local var_11_0 = {}

			unpack = var_2_10002
			var_11_0.type, var_11_0.id, var_11_0.count = var_2_10002(arg_11_0)

			return var_11_0
		end)

		var_10_1.items = var_1_10005.value(var_10_5)
		var_10_0 = var_10_1
	else
		Item = var_10_1
		var_10_1 = var_10_1.getConfigData(arg_10_2:getConfig("effect_args")[1])
		var_1_10005 = {
			isFree = true,
			name = var_10_1.name,
			price = arg_10_2:getConfig("resource_num"),
			count = arg_10_2:GetLimitDesc(),
			desc = var_10_1.display
		}
		i18n = var_6
		var_1_10005.free = var_6("shop_free_tag")
		i18n = var_6
		var_1_10005.purchased = var_6("blackfriday_pack_purchased")
		var_1_10005.icon = var_10_1.icon
		underscore = var_6

		local var_10_6 = var_6(var_10_1.display_icon)
		local var_10_7 = var_6.chain(var_10_6)
		local var_10_8 = var_6.first(var_10_7, 3)
		local var_10_9 = var_6.map(var_10_8, function(arg_12_0)
			local var_12_0 = {}

			unpack = var_2_10002
			var_12_0.type, var_12_0.id, var_12_0.count = var_2_10002(arg_12_0)

			return var_12_0
		end)

		var_1_10005.items = var_6.value(var_10_9)
		var_10_0 = var_1_10005
	end

	setText = var_10_1

	local var_10_10 = arg_10_1

	var_10_1(arg_10_1.Find(var_10_10, "name/Text"), var_10_0.name)

	local var_10_11 = var_10_0.isFree

	tonumber = var_1_10005

	if not var_1_10005(var_10_0.price) then
		setText = var_5

		var_5(arg_10_1:Find("price"), var_10_0.price)
	else
		setText = var_5

		local var_10_12 = arg_10_1:Find("price")

		GetMoneySymbol = var_10_10

		var_5(var_10_12, var_10_10() .. var_10_0.price)
	end

	setText = var_5

	var_5(arg_10_1:Find("count"), var_10_0.count)

	setText = var_5

	var_5(arg_10_1:Find("desc"), var_10_0.desc)

	setText = var_5

	var_5(arg_10_1:Find("free"), var_10_0.free)

	setText = var_5

	var_5(arg_10_1:Find("purchased"), var_10_0.purchased)

	local var_10_13 = arg_10_2
	local var_10_14 = arg_10_2.inTime(var_10_13)

	setActive = var_6

	var_6(arg_10_1:Find("mask_lock"), not var_10_14)

	local var_10_15 = arg_10_2
	local var_10_16 = arg_10_2.canPurchase(var_10_15)

	setActive = var_10_13

	var_10_13(arg_10_1:Find("mask_purchased"), not var_10_16)

	setActive = var_10_13

	var_10_13(arg_10_1:Find("purchased"), not var_10_16)

	setActive = var_10_13

	var_10_13(arg_10_1:Find("free"), var_10_16 and var_10_11)

	setActive = var_10_13

	var_10_13(arg_10_1:Find("price"), var_10_16 and not var_10_11)

	GetImageSpriteFromAtlasAsync = var_10_13

	var_10_13(var_10_0.icon, "", arg_10_1:Find("icon/Image"), true)

	GetImageSpriteFromAtlasAsync = var_10_13

	var_10_13("chargeTag", var_0_2(arg_10_2:getConfig("tag")), arg_10_1:Find("icon/tag"), true)

	UIItemList = var_10_13

	var_10_13.StaticAlign(arg_10_1:Find("awards"), arg_10_1:Find("awards/award"), #var_10_0.items, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_10_0.items[arg_13_1 + 1]

			updateDrop = var_4

			var_4(arg_13_2, var_13_0)

			onButton = var_4

			local var_13_1 = arg_10_0
			local var_13_2 = arg_13_2

			local function var_13_3()
				local var_14_0 = arg_10_0
				local var_14_1 = var_0.emit

				BaseUI = var_3_10003

				var_14_1(var_14_0, var_3_10003.ON_DROP, var_13_0)

				return
			end

			SFX_PANEL = var_2_10009

			var_4(var_13_1, var_13_2, var_13_3, var_2_10009)
		end

		return
	end)

	local var_10_17 = arg_10_1

	if arg_10_1.Find(var_10_17, "tip") then
		setActive = var_10_15

		var_10_15(var_7, var_10_14 and var_10_16)
	end

	local var_10_18 = arg_10_2
	local var_10_19 = arg_10_2.getTimeStamp(var_10_18)

	pg = var_10_17

	local var_10_20 = var_10_17.TimeMgr.GetInstance()
	local var_10_21 = var_9.STimeDescS(var_10_20, var_10_19, "%m.%d")

	onButton = var_10_18

	local var_10_22 = arg_10_0
	local var_10_23 = arg_10_1

	local function var_10_24()
		if not var_10_14 then
			pg = var_0

			local var_15_0 = var_0.TipsMgr.GetInstance()
			local var_15_1 = var_0.ShowTips

			i18n = var_2_10003

			var_15_1(var_15_0, var_2_10003("blackfriday_pack_lock", var_10_21))
		else
			local var_15_2 = arg_10_2

			if not var_0.canPurchase(var_15_2) then
				pg = var_0

				local var_15_3 = var_0.TipsMgr.GetInstance()
				local var_15_4 = var_0.ShowTips

				i18n = var_2_10003

				var_15_4(var_15_3, var_2_10003("buy_countLimit"))
			else
				local var_15_5 = arg_10_0

				var_0.OnCharge(var_15_5, arg_10_2)
			end
		end

		return
	end

	SFX_PANEL = var_15

	var_10_18(var_10_22, var_10_23, var_10_24, var_15)

	return
end

function var_0_1.OnCharge(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1

	if arg_16_1.isChargeType(var_16_0) then
		var_16_0 = arg_16_1

		local var_16_1 = arg_16_1.getConfig(var_16_0, "tag")
		local var_16_2 = arg_16_1:GetExtraServiceItem()

		var_16_0 = nil

		local var_16_3

		i18n = var_1_10006

		local var_16_4 = var_1_10006("charge_title_getitem")
		local var_16_5
		local var_16_6 = {
			isChargeType = true,
			commodity = arg_16_1
		}

		var_1_10011 = arg_16_1
		var_16_6.infoTip = arg_16_1.GetInfoTip(var_1_10011)
		var_16_6.icon = "chargeicon/" .. arg_16_1:getConfig("picture")
		var_1_10011 = arg_16_1
		var_16_6.name = arg_16_1.getConfig(var_1_10011, "name_display")
		var_16_6.tipExtra = var_16_4
		var_16_6.extraItems = var_16_2
		var_1_10011 = arg_16_1
		var_16_6.price = arg_16_1.getConfig(var_1_10011, "money")
		var_1_10011 = arg_16_1
		var_16_6.isLocalPrice = arg_16_1.IsLocalPrice(var_1_10011)
		var_16_6.tagType = var_16_1
		var_1_10011 = arg_16_1
		var_16_6.isMonthCard = arg_16_1.isMonthCard(var_1_10011)
		var_16_6.tipBonus = var_16_5
		var_16_6.bonusItem = var_16_3
		var_16_6.extraDrop = var_16_0
		var_1_10011 = arg_16_1
		var_16_6.descExtra = arg_16_1.getConfig(var_1_10011, "descrip_extra")
		var_1_10011 = arg_16_1
		var_16_6.limitArgs = arg_16_1.getConfig(var_1_10011, "limit_args")

		function var_16_6.onYes()
			ChargeConst = var_2_10000

			if var_2_10000.isNeedSetBirth() then
				local var_17_0 = arg_16_0
				local var_17_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_17_1(var_17_0, var_2_10003.OPEN_CHARGE_BIRTHDAY)
			else
				local var_17_2 = arg_16_0
				local var_17_3 = var_0.emit

				ActivityMediator = var_2_10003

				var_17_3(var_17_2, var_2_10003.CHARGE, arg_16_1.id)
			end

			return
		end

		var_1_10011 = arg_16_0

		local var_16_7 = arg_16_0.emit

		ActivityMediator = var_12

		var_16_7(var_1_10011, var_12.OPEN_CHARGE_ITEM_PANEL, var_16_6)
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

				ActivityMediator = var_3_10003

				var_19_1(var_19_0, var_3_10003.BUY_ITEM, arg_16_1.id, 1)

				return
			end

			var_18_1(var_18_0, var_18_2)

			return
		end

		local var_16_12 = arg_16_0
		local var_16_13 = arg_16_0.emit

		ActivityMediator = var_10

		var_16_13(var_16_12, var_10.OPEN_CHARGE_ITEM_PANEL, var_16_11)
	end

	return
end

function var_0_1.OnDestroy(arg_20_0)
	return
end

return var_0_1
