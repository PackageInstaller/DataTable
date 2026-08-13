class = var_0_10000

local var_0_0 = "LatestSkinGiftPackLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".LatestSkinShopLayer"))

function var_0_1.Overlay(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.UIMgr.GetInstance()
	local var_1_1 = var_1.OverlayPanel
	local var_1_2 = arg_1_0.adapt
	local var_1_3 = {}
	local var_1_4 = {}
	local var_1_5 = arg_1_0.charContainer

	var_1_4[1] = var_7.Find(var_1_5, "bg")

	local var_1_6 = arg_1_0.filterUI

	var_1_4[2] = var_7.Find(var_1_6, "panel")
	var_1_3.pbList = var_1_4

	var_1_1(var_1_0, var_1_2, var_1_3)

	return
end

function var_0_1.UnOverlay(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_2_0, arg_2_0.adapt, arg_2_0._tf)

	return
end

function var_0_1.GetAllCommodities(arg_3_0)
	if arg_3_0.contextData.commodityId then
		arg_3_0.giftPackCommodity = arg_3_0:GetCommodity(arg_3_0.contextData.commodityId)

		local var_3_0 = arg_3_0.giftPackCommodity
		local var_3_1 = var_1.GetSkinProbability(var_3_0)

		getProxy = var_1_10002
		ShipSkinProxy = var_4

		local var_3_2 = var_1_10002(var_4)

		arg_3_0.commodities = var_2.GetProbabilitySkins(var_3_2, var_3_1)
		getProxy = var_2
		ShipSkinProxy = var_3_2

		local var_3_3 = var_2(var_3_2)

		arg_3_0.skinProbabilitys = var_2.GetSkinProbabilitys(var_3_3, var_3_1)
	else
		arg_3_0.giftPackCommodity = arg_3_0.contextData.giftPackCommodity
		arg_3_0.commodities = arg_3_0.contextData.skinCommodities
		arg_3_0.skinProbabilitys = arg_3_0.contextData.skinProbabilitys
	end

	return
end

function var_0_1.GetCommodity(arg_4_0, arg_4_1)
	Goods = var_1_10002

	local var_4_0 = var_1_10002.Create
	local var_4_1 = {
		shop_id = arg_4_1
	}

	Goods = var_1_10005

	local var_4_2 = var_4_0(var_4_1, var_1_10005.TYPE_CHARGE)

	getProxy = var_1_10003
	ShopsProxy = var_5

	local var_4_3 = var_1_10003(var_5)
	local var_4_4

	if not var_3.getChargedList(var_4_3) then
		var_4_4 = {}
	end

	ChargeConst = var_4_1

	local var_4_5 = var_4_1.getBuyCount(var_4_4, var_4_2.id)

	var_4_2:updateBuyCount(var_4_5)

	return var_4_2
end

function var_0_1.SetGiftPackLayer(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.mainTitle, true)

	setActive = var_1_10001

	var_1_10001(arg_5_0.backBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_5_0.homeBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_5_0.giftPack, true)

	setActive = var_1_10001

	var_1_10001(arg_5_0.showOwnBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0.filterBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0.search, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0.giftPackBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_5_0.price, false)

	local var_5_0 = arg_5_0.top
	local var_5_1 = var_1.Find(var_5_0, "title")

	Vector2 = var_1_10002
	var_5_1.anchoredPosition = var_1_10002(544.6, -208.3)

	local var_5_2 = arg_5_0.top
	local var_5_3 = var_1.Find(var_5_2, "change_skin")

	Vector2 = var_2
	var_5_3.anchoredPosition = var_2(431.1, -337.8)

	local var_5_4 = arg_5_0.bottom
	local var_5_5 = var_1.Find(var_5_4, "scroll")

	Vector2 = var_2
	var_5_5.offsetMin = var_2(378, 0)

	local var_5_6 = arg_5_0.bottom
	local var_5_7 = var_1.Find(var_5_6, "scroll")

	Vector2 = var_2
	var_5_7.offsetMax = var_2(-19.6, 227.9)
	setText = var_5_7

	local var_5_8 = arg_5_0.giftPack
	local var_5_9 = var_3.Find(var_5_8, "panel/name")
	local var_5_10 = arg_5_0.giftPackCommodity

	var_5_7(var_5_9, var_4.getConfig(var_5_10, "name_display"))

	local var_5_11 = arg_5_0.giftPackCommodity
	local var_5_12 = var_1.getConfig(var_5_11, "time")

	setActive = var_2

	local var_5_13 = arg_5_0.giftPack
	local var_5_14 = var_4.Find(var_5_13, "panel/leftTimeText")

	type = var_5_8

	var_2(var_5_14, var_5_8(var_5_12) == "table")

	type = var_2

	local var_5_15

	if var_2(var_5_12) == "table" then
		var_5_15 = var_5_12[2]
		pg = var_5_11

		local var_5_16 = var_5_11.TimeMgr.GetInstance()
		local var_5_17 = var_3.Table2ServerTime(var_5_16, {
			year = var_5_15[1][1],
			month = var_5_15[1][2],
			day = var_5_15[1][3],
			hour = var_5_15[2][1],
			min = var_5_15[2][2],
			sec = var_5_15[2][3]
		})

		arg_5_0:StartTimer(function()
			pg = var_2_10000

			local var_6_0 = var_2_10000.TimeMgr.GetInstance()
			local var_6_1 = var_0.GetServerTime(var_6_0)
			local var_6_2 = var_5_17 - var_6_1

			math = var_6_0

			local var_6_3 = var_6_0.floor(var_6_2 / 0)

			math = var_2_10003

			local var_6_4 = var_2_10003.floor(var_6_2 % 0 / 16)

			math = var_4

			local var_6_5 = var_4.floor(var_6_2 % 0 % 16 / 60)

			if 0 < var_6_3 then
				setText = var_5

				local var_6_6 = arg_5_0.giftPack
				local var_6_7 = var_7.Find(var_6_6, "panel/leftTimeText")

				i18n = var_2_10008

				var_5(var_6_7, var_2_10008("shop_new_during_day", var_6_3))
			elseif 0 < var_6_4 then
				setText = var_5

				local var_6_8 = arg_5_0.giftPack
				local var_6_9 = var_7.Find(var_6_8, "panel/leftTimeText")

				i18n = var_2_10008

				var_5(var_6_9, var_2_10008("shop_new_during_hour", var_6_4))
			else
				setText = var_5

				local var_6_10 = arg_5_0.giftPack
				local var_6_11 = var_7.Find(var_6_10, "panel/leftTimeText")

				i18n = var_2_10008

				var_5(var_6_11, var_2_10008("shop_new_during_minite", var_6_5))
			end

			return
		end)
	end

	GetImageSpriteFromAtlasAsync = var_5_15

	local var_5_18 = "chargeicon/"
	local var_5_19 = arg_5_0.giftPackCommodity
	local var_5_20 = var_5_18 .. var_5.getConfig(var_5_19, "picture")
	local var_5_21 = ""
	local var_5_22 = arg_5_0.giftPack

	var_5_15(var_5_20, var_5_21, var_6.Find(var_5_22, "panel/icon"))

	setText = var_5_15

	local var_5_23 = arg_5_0.giftPack
	local var_5_24 = var_4.Find(var_5_23, "panel/tip1/Text")
	local var_5_25 = arg_5_0.giftPackCommodity

	var_5_15(var_5_24, var_5.getConfig(var_5_25, "first_text"))

	setText = var_5_15

	local var_5_26 = arg_5_0.giftPack
	local var_5_27 = var_4.Find(var_5_26, "panel/tip2/Text")
	local var_5_28 = arg_5_0.giftPackCommodity

	var_5_15(var_5_27, var_5.getConfig(var_5_28, "second_text"))

	local var_5_29 = arg_5_0.giftPackCommodity
	local var_5_30 = var_2.getConfig(var_5_29, "first_icon")
	local var_5_31 = {}

	ipairs = var_5_29

	for iter_5_0, iter_5_1 in var_5_29(var_5_30) do
		table = var_5_32

		local var_5_32 = var_5_32.insert
		local var_5_33 = var_5_31

		Drop = var_1_10012

		var_5_32(var_5_33, var_1_10012.Create(iter_5_1))
	end

	while #var_5_31 > 3 do
		table = var_4

		var_4.remove(var_5_31, #var_5_31)
	end

	UIItemList = var_4

	local var_5_34 = var_4.New
	local var_5_35 = arg_5_0.giftPack
	local var_5_36 = var_6.Find(var_5_35, "panel/firstItems")
	local var_5_37 = arg_5_0.giftPack
	local var_5_38 = var_5_34(var_5_36, var_7.Find(var_5_37, "panel/firstItems/item"))

	var_4.make(var_5_38, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = var_5_31[arg_7_1 + 1]

			updateDrop = var_4

			var_4(arg_7_2:Find("mask/item"), var_7_0)
		end

		return
	end)
	var_4:align(#var_5_31)

	local var_5_39 = arg_5_0.giftPackCommodity
	local var_5_40 = var_5.GetDropList(var_5_39)

	while #var_5_40 > 3 do
		table = var_6

		var_6.remove(var_5_40, #var_5_40)
	end

	UIItemList = var_6

	local var_5_41 = var_6.New
	local var_5_42 = arg_5_0.giftPack
	local var_5_43 = var_8.Find(var_5_42, "panel/items")
	local var_5_44 = arg_5_0.giftPack
	local var_5_45 = var_5_41(var_5_43, var_9.Find(var_5_44, "panel/items/item"))

	var_6.make(var_5_45, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = var_5_40[arg_8_1 + 1]

			updateDrop = var_4

			var_4(arg_8_2:Find("mask/item"), var_8_0)
		end

		return
	end)
	var_6:align(#var_5_40)

	setText = var_7

	local var_5_46 = arg_5_0.giftPack
	local var_5_47 = var_9.Find(var_5_46, "price/consume/Text")
	local var_5_48 = arg_5_0.giftPackCommodity

	var_7(var_5_47, var_10.GetLimitDesc(var_5_48))

	setText = var_7

	local var_5_49 = arg_5_0.giftPack
	local var_5_50 = var_9.Find(var_5_49, "price/btns/goumai_button/Text")

	GetMoneySymbol = var_10

	local var_5_51 = var_10()
	local var_5_52 = arg_5_0.giftPackCommodity

	var_7(var_5_50, var_5_51 .. var_11.getConfig(var_5_52, "money"))

	PLATFORM_CODE = var_7
	PLATFORM_CHT = var_5_43

	if var_7 == var_5_43 then
		local var_5_53 = arg_5_0.giftPackCommodity

		if var_7.IsLocalPrice(var_5_53) then
			setText = var_7

			local var_5_54 = arg_5_0.giftPack
			local var_5_55 = var_9.Find(var_5_54, "price/btns/goumai_button/Text")
			local var_5_56 = arg_5_0.giftPackCommodity

			var_7(var_5_55, var_10.getConfig(var_5_56, "money"))
		end
	end

	setGray = var_7

	local var_5_57 = arg_5_0.giftPack

	var_7(var_9.Find(var_5_57, "price/btns/yigoumai_button"), true, true)

	local var_5_58 = arg_5_0.giftPackCommodity
	local var_5_59 = var_7.getLimitCount(var_5_58)
	local var_5_60

	if not arg_5_0.giftPackCommodity.buyCount then
		var_5_60 = 0
	end

	setActive = var_5_58

	local var_5_61 = arg_5_0.giftPack

	var_5_58(var_11.Find(var_5_61, "price/btns/goumai_button"), var_5_60 < var_5_59)

	setActive = var_5_58

	local var_5_62 = arg_5_0.giftPack

	var_5_58(var_11.Find(var_5_62, "price/btns/yigoumai_button"), var_5_59 <= var_5_60)

	onButton = var_5_58

	local var_5_63 = arg_5_0
	local var_5_64 = arg_5_0.giftPack
	local var_5_65 = var_12.Find(var_5_64, "price/btns/goumai_button")

	local function var_5_66()
		local var_9_0 = arg_5_0

		var_0.confirm(var_9_0, arg_5_0.giftPackCommodity)

		return
	end

	SFX_PANEL = var_5_64

	var_5_58(var_5_63, var_5_65, var_5_66, var_5_64)

	return
end

function var_0_1.FlushGifgPackBtn(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0.giftPackBtn, false)

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)

		var_11_0 = arg_11_0.cards[arg_11_2]
	end

	if not arg_11_0.displays[arg_11_1 + 1] then
		return
	end

	local var_11_1 = arg_11_0.selectedId == var_4.id

	table = var_6

	local var_11_2 = var_6.contains(arg_11_0.returnSkins, var_4.id)

	var_11_0:Update(var_4, var_11_1, var_11_2, arg_11_0.skinProbabilitys[var_4:getSkinId()])

	if arg_11_0.triggerFirstCard and arg_11_1 == 0 then
		arg_11_0.triggerFirstCard = false
		triggerButton = var_7

		var_7(var_11_0._go)
	end

	return
end

function var_0_1.confirm(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	Clone = var_1_10002

	local var_12_0 = var_1_10002(arg_12_1)

	if arg_12_1.isChargeType(var_12_0) then
		local var_12_1 = false

		var_12_0 = var_12_1 and arg_12_1:firstPayDouble() and 4 or arg_12_1:getConfig("tag")

		if arg_12_1:isMonthCard() or arg_12_1:isGiftBox() or arg_12_1:isItemBox() or arg_12_1:isPassItem() then
			local var_12_2 = arg_12_1:GetExtraServiceItem()
			local var_12_3 = arg_12_1:GetExtraDrop()
			local var_12_4 = arg_12_1:GetBonusItem()
			local var_12_5
			local var_12_6

			if arg_12_1:isPassItem() then
				i18n = var_10
				var_12_5 = var_10("battlepass_pay_tip")
			elseif arg_12_1:isMonthCard() then
				i18n = var_10
				var_12_5 = var_10("charge_title_getitem_month")
				i18n = var_10
				var_12_6 = var_10("charge_title_getitem_soon")
			else
				i18n = var_10
				var_12_5 = var_10("charge_title_getitem")
			end

			local var_12_7 = {
				isChargeType = true,
				commodity = arg_12_1,
				infoTip = arg_12_1:GetInfoTip()
			}

			var_1_10011 = "chargeicon/"
			var_1_10014 = arg_12_1
			var_12_7.icon = var_1_10011 .. arg_12_1.getConfig(var_1_10014, "picture")
			var_12_7.name = arg_12_1:getConfig("name_display")
			var_12_7.tipExtra = var_12_5
			var_12_7.extraItems = var_12_2
			var_12_7.price = arg_12_1:getConfig("money")
			var_12_7.isLocalPrice = arg_12_1:IsLocalPrice()
			var_12_7.tagType = var_12_0
			var_12_7.isMonthCard = arg_12_1:isMonthCard()
			var_12_7.tipBonus = var_12_6
			var_12_7.bonusItem = var_12_4
			var_12_7.extraDrop = var_12_3
			var_12_7.descExtra = arg_12_1:getConfig("descrip_extra")
			var_12_7.limitArgs = arg_12_1:getConfig("limit_args")

			function var_12_7.onYes()
				ChargeConst = var_2_10000

				if var_2_10000.isNeedSetBirth() then
					local var_13_0 = arg_12_0
					local var_13_1 = var_0.emit

					LatestSkinGiftPackMediator = var_2_10003

					var_13_1(var_13_0, var_2_10003.OPEN_CHARGE_BIRTHDAY)
				else
					local var_13_2 = arg_12_0
					local var_13_3 = var_0.emit

					LatestSkinGiftPackMediator = var_2_10003

					var_13_3(var_13_2, var_2_10003.CHARGE, arg_12_1.id)
				end

				return
			end

			local var_12_8 = arg_12_0

			var_1_10011 = arg_12_0.emit
			LatestSkinGiftPackMediator = var_1_10014

			var_1_10011(var_12_8, var_1_10014.OPEN_CHARGE_ITEM_PANEL, var_12_7)
		elseif arg_12_1:isGem() then
			local var_12_9 = arg_12_1:getConfig("money")
			local var_12_10 = arg_12_1:getConfig("gem")

			if var_3 then
				var_12_10 = var_12_10 + arg_12_1:getConfig("gem")
			else
				var_12_10 = var_12_10 + arg_12_1:getConfig("extra_gem")
			end

			local var_12_11 = {
				isChargeType = true,
				commodity = arg_12_1
			}
			local var_12_12 = "chargeicon/"

			var_1_10011 = arg_12_1
			var_12_11.icon = var_12_12 .. arg_12_1.getConfig(var_1_10011, "picture")
			var_12_11.name = arg_12_1:getConfig("name_display")
			var_12_11.price = arg_12_1:getConfig("money")
			var_12_11.isLocalPrice = arg_12_1:IsLocalPrice()
			var_12_11.tagType = var_12_0
			i18n = var_8
			var_12_11.normalTip = var_8("charge_start_tip", var_12_9, var_12_10)

			function var_12_11.onYes()
				ChargeConst = var_2_10000

				if var_2_10000.isNeedSetBirth() then
					local var_14_0 = arg_12_0
					local var_14_1 = var_0.emit

					LatestSkinGiftPackMediator = var_2_10003

					var_14_1(var_14_0, var_2_10003.OPEN_CHARGE_BIRTHDAY)
				else
					local var_14_2 = arg_12_0
					local var_14_3 = var_0.emit

					LatestSkinGiftPackMediator = var_2_10003

					var_14_3(var_14_2, var_2_10003.CHARGE, arg_12_1.id)
				end

				return
			end

			local var_12_13 = arg_12_0
			local var_12_14 = arg_12_0.emit

			LatestSkinGiftPackMediator = var_1_10011

			var_12_14(var_12_13, var_1_10011.OPEN_CHARGE_ITEM_BOX, var_12_11)
		end
	else
		local var_12_15 = {}
		local var_12_16 = arg_12_1:getConfig("effect_args")

		Item = var_12_0

		local var_12_17 = var_12_0.getConfigData(var_12_16[1]).display_icon

		type = var_6

		if var_6(var_12_17) == "table" then
			ipairs = var_6

			for iter_12_0, iter_12_1 in var_6(var_12_17) do
				table = var_1_10011
				var_1_10011 = var_1_10011.insert

				local var_12_18 = var_12_15

				Drop = var_1_10014

				var_1_10011(var_12_18, var_1_10014.New({
					type = iter_12_1[1],
					id = iter_12_1[2],
					count = iter_12_1[3]
				}))
			end
		end

		local var_12_19 = {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_12_1,
			icon = var_4.icon,
			name = var_4.name
		}

		i18n = var_7
		var_12_19.tipExtra = var_7("charge_title_getitem")
		var_12_19.extraItems = var_12_15
		var_12_19.price = arg_12_1:getConfig("resource_num")
		var_12_19.tagType = arg_12_1:getConfig("tag")

		function var_12_19.onYes()
			pg = var_2_10000

			local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_15_1 = var_0.ShowMsgBox
			local var_15_2 = {}

			i18n = var_2_10004

			local var_15_3 = "charge_scene_buy_confirm"
			local var_15_4 = arg_12_1

			var_15_2.content = var_2_10004(var_15_3, var_7.getConfig(var_15_4, "resource_num"), var_0.name)

			function var_15_2.onYes()
				local var_16_0 = arg_12_0
				local var_16_1 = var_0.emit

				LatestSkinGiftPackMediator = var_3_10003

				var_16_1(var_16_0, var_3_10003.BUY_ITEM, arg_12_1.id, 1)

				return
			end

			var_15_1(var_15_0, var_15_2)

			return
		end

		local var_12_20 = arg_12_0
		local var_12_21 = arg_12_0.emit

		LatestSkinGiftPackMediator = var_10

		var_12_21(var_12_20, var_10.OPEN_CHARGE_ITEM_PANEL, var_12_19)
	end

	return
end

function var_0_1.StartTimer(arg_17_0, arg_17_1)
	Timer = var_1_10002
	arg_17_0.cardTimer = var_1_10002.New(function()
		arg_17_1()

		return
	end, 1, -1)

	arg_17_1()

	local var_17_0 = arg_17_0.cardTimer

	var_2.Start(var_17_0)

	return
end

function var_0_1.RemoveAllTimer(arg_19_0)
	if arg_19_0.cardTimer then
		local var_19_0 = arg_19_0.cardTimer

		var_1.Stop(var_19_0)

		arg_19_0.cardTimer = nil
	end

	return
end

function var_0_1.willExit(arg_20_0)
	var_0_1.super.willExit(arg_20_0)
	arg_20_0:RemoveAllTimer()

	return
end

return var_0_1
