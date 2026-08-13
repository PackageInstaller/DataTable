class = var_0_10000

local var_0_0 = "ChargeDiamondShopView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

var_0_1.MonthCardID = 1

function var_0_1.getUIName(arg_1_0)
	return "ChargeDiamondShopUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:Show()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	return
end

function var_0_1.initData(arg_4_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		PLATFORM_CODE = var_1_10001
		PLATFORM_US = var_1_10002

		local var_4_0

		if var_1_10001 == var_1_10002 then
			pg = var_1_10001
			var_1_10003 = var_1_10001.SdkMgr.GetInstance()
			var_4_0 = var_1.CheckAudit(var_1_10003)
		else
			var_4_0 = false
		end

		if false then
			var_4_0 = true
		end

		arg_4_0.isNeedHideMonthCard = var_4_0
		arg_4_0.diamondGoodsVOList = {}
		arg_4_0.diamondGoodsVOListForShow = {}
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_4_1 = var_1(var_1_10003)

		arg_4_0.player = var_1.getData(var_4_1)

		arg_4_0:updateData()

		return
	end
end

function var_0_1.initUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.itemTpl = var_1.Find(var_5_0, "ItemTpl")

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_1.Find(var_5_1, "content")

	arg_5_0.monthCardTF = var_1.Find(var_5_2, "ItemMonth")
	arg_5_0.itemContainerTF = var_1:Find("ItemList")
	arg_5_0.uiItemList = arg_5_0:initUIItemList()

	arg_5_0:updateView()

	return
end

function var_0_1.initUIItemList(arg_6_0)
	UIItemList = var_1_10001

	local var_6_0 = var_1_10001.New(arg_6_0.itemContainerTF, arg_6_0.itemTpl)

	var_1.make(var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			arg_7_1 = arg_7_1 + 1
			ChargeDiamondCard = var_3

			local var_7_0 = var_3.New

			go = var_2_10005

			local var_7_1 = var_7_0(var_2_10005(arg_7_2), arg_6_0.monthCardTF, arg_6_0)
			local var_7_2 = arg_6_0.diamondGoodsVOListForShow[arg_7_1]

			var_7_1:update(var_7_2, arg_6_0.player, arg_6_0.firstChargeIds)

			onButton = var_5

			local var_7_3 = arg_6_0
			local var_7_4 = var_7_1.tr

			local function var_7_5()
				local var_8_0 = arg_6_0

				var_0.confirm(var_8_0, var_7_1.goods)

				return
			end

			SFX_PANEL = var_10

			var_5(var_7_3, var_7_4, var_7_5, var_10)
		end

		return
	end)

	arg_6_0.uiItemList = var_1

	return var_1
end

function var_0_1.updateUIItemList(arg_9_0)
	local var_9_0 = arg_9_0.uiItemList

	var_1.align(var_9_0, #arg_9_0.diamondGoodsVOListForShow)

	return
end

function var_0_1.updateView(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.monthCardTF, not arg_10_0.isNeedHideMonthCard)
	arg_10_0:updateUIItemList()

	return
end

function var_0_1.confirm(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	Clone = var_1_10002

	local var_11_0 = var_1_10002(arg_11_1)

	if arg_11_1.isChargeType(var_11_0) then
		table = var_2
		var_11_0 = not var_2.contains(arg_11_0.firstChargeIds, arg_11_1.id) and arg_11_1:firstPayDouble() and 4 or arg_11_1:getConfig("tag")

		if arg_11_1:isMonthCard() or arg_11_1:isGiftBox() or arg_11_1:isItemBox() or arg_11_1:isPassItem() then
			local var_11_1 = arg_11_1:GetExtraServiceItem()
			local var_11_2 = arg_11_1:GetExtraDrop()
			local var_11_3 = arg_11_1:GetBonusItem()
			local var_11_4
			local var_11_5

			if arg_11_1:isPassItem() then
				i18n = var_10
				var_11_4 = var_10("battlepass_pay_tip")
			elseif arg_11_1:isMonthCard() then
				i18n = var_10
				var_11_4 = var_10("charge_title_getitem_month")
				i18n = var_10
				var_11_5 = var_10("charge_title_getitem_soon")
			else
				i18n = var_10
				var_11_4 = var_10("charge_title_getitem")
			end

			local var_11_6 = {
				isChargeType = true,
				commodity = arg_11_1,
				infoTip = arg_11_1:GetInfoTip(),
				icon = "chargeicon/" .. arg_11_1:getConfig("picture"),
				name = arg_11_1:getConfig("name_display"),
				tipExtra = var_11_4,
				extraItems = var_11_1,
				price = arg_11_1:getConfig("money"),
				isLocalPrice = arg_11_1:IsLocalPrice(),
				tagType = var_11_0,
				isMonthCard = arg_11_1:isMonthCard(),
				tipBonus = var_11_5,
				bonusItem = var_11_3,
				extraDrop = var_11_2,
				descExtra = arg_11_1:getConfig("descrip_extra"),
				onYes = function()
					ChargeConst = var_2_10000

					if var_2_10000.isNeedSetBirth() then
						local var_12_0 = arg_11_0
						local var_12_1 = var_0.emit

						NewShopMainMediator = var_2_10003

						var_12_1(var_12_0, var_2_10003.OPEN_CHARGE_BIRTHDAY)
					else
						local var_12_2 = arg_11_0
						local var_12_3 = var_0.emit

						NewShopMainMediator = var_2_10003

						var_12_3(var_12_2, var_2_10003.CHARGE, arg_11_1.id)
					end

					return
				end
			}
			local var_11_7 = arg_11_0

			var_1_10011 = arg_11_0.emit
			NewShopMainMediator = var_14

			var_1_10011(var_11_7, var_14.OPEN_CHARGE_ITEM_PANEL, var_11_6)
		elseif arg_11_1:isGem() then
			local var_11_8 = arg_11_1:getConfig("money")
			local var_11_9 = arg_11_1:getConfig("gem")

			if var_3 then
				var_11_9 = var_11_9 + arg_11_1:getConfig("gem")
			else
				var_11_9 = var_11_9 + arg_11_1:getConfig("extra_gem")
			end

			local var_11_10 = {
				isChargeType = true,
				commodity = arg_11_1
			}
			local var_11_11 = "chargeicon/"

			var_1_10011 = arg_11_1
			var_11_10.icon = var_11_11 .. arg_11_1.getConfig(var_1_10011, "picture")
			var_11_10.name = arg_11_1:getConfig("name_display")
			var_11_10.price = arg_11_1:getConfig("money")
			var_11_10.isLocalPrice = arg_11_1:IsLocalPrice()
			var_11_10.tagType = var_11_0
			i18n = var_8
			var_11_10.normalTip = var_8("charge_start_tip", var_11_8, var_11_9)

			function var_11_10.onYes()
				ChargeConst = var_2_10000

				if var_2_10000.isNeedSetBirth() then
					local var_13_0 = arg_11_0
					local var_13_1 = var_0.emit

					NewShopMainMediator = var_2_10003

					var_13_1(var_13_0, var_2_10003.OPEN_CHARGE_BIRTHDAY)
				else
					local var_13_2 = arg_11_0
					local var_13_3 = var_0.emit

					NewShopMainMediator = var_2_10003

					var_13_3(var_13_2, var_2_10003.CHARGE, arg_11_1.id)
				end

				return
			end

			local var_11_12 = arg_11_0
			local var_11_13 = arg_11_0.emit

			NewShopMainMediator = var_1_10011

			var_11_13(var_11_12, var_1_10011.OPEN_CHARGE_ITEM_BOX, var_11_10)
		end
	else
		local var_11_14 = {}
		local var_11_15 = arg_11_1:getConfig("effect_args")

		Item = var_11_0

		local var_11_16 = var_11_0.getConfigData(var_11_15[1]).display_icon

		type = var_6

		if var_6(var_11_16) == "table" then
			ipairs = var_6

			for iter_11_0, iter_11_1 in var_6(var_11_16) do
				table = var_1_10011

				var_1_10011.insert(var_11_14, {
					type = iter_11_1[1],
					id = iter_11_1[2],
					count = iter_11_1[3]
				})
			end
		end

		local var_11_17 = {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_11_1,
			icon = var_4.icon,
			name = var_4.name
		}

		i18n = var_7
		var_11_17.tipExtra = var_7("charge_title_getitem")
		var_11_17.extraItems = var_11_14
		var_11_17.price = arg_11_1:getConfig("resource_num")
		var_11_17.tagType = arg_11_1:getConfig("tag")

		function var_11_17.onYes()
			pg = var_2_10000

			local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_14_1 = var_0.ShowMsgBox
			local var_14_2 = {}

			i18n = var_2_10004

			local var_14_3 = "charge_scene_buy_confirm"
			local var_14_4 = arg_11_1

			var_14_2.content = var_2_10004(var_14_3, var_7.getConfig(var_14_4, "resource_num"), var_0.name)

			function var_14_2.onYes()
				local var_15_0 = arg_11_0
				local var_15_1 = var_0.emit

				NewShopMainMediator = var_3_10003

				var_15_1(var_15_0, var_3_10003.BUY_ITEM, arg_11_1.id, 1)

				return
			end

			var_14_1(var_14_0, var_14_2)

			return
		end

		local var_11_18 = arg_11_0
		local var_11_19 = arg_11_0.emit

		NewShopMainMediator = var_10

		var_11_19(var_11_18, var_10.OPEN_CHARGE_ITEM_PANEL, var_11_17)
	end

	return
end

function var_0_1.updateDiamondGoodsVOList(arg_16_0)
	arg_16_0.diamondGoodsVOList = {}
	pg = var_1

	local var_16_0 = var_1.pay_data_display

	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(var_16_0.all) do
		local var_16_1 = var_16_0[iter_16_1].extra_service

		if arg_16_0.isNeedHideMonthCard and iter_16_1 == var_0_1.MonthCardID then
			goto label_16_0
		end

		pg = var_9

		local var_16_2 = var_9.SdkMgr.GetInstance()

		if var_9.IgnorePlatform(var_16_2, var_16_0[iter_16_1].ignorePlatform) then
			goto label_16_0
		end

		Goods = var_9

		if var_16_1 ~= var_9.MONTH_CARD then
			Goods = var_9

			if var_16_1 ~= var_9.GEM then
				Goods = var_9

				if var_16_1 == var_9.GIFT_BOX then
					Goods = var_9

					local var_16_3 = var_9.Create
					local var_16_4 = {
						shop_id = iter_16_1
					}

					Goods = var_12

					local var_16_5 = var_16_3(var_16_4, var_12.TYPE_CHARGE)

					table = var_1_10010

					var_1_10010.insert(arg_16_0.diamondGoodsVOList, var_16_5)
				end

				::label_16_0::
			end
		end
	end

	return
end

function var_0_1.sortDiamondGoodsVOList(arg_17_0)
	arg_17_0.diamondGoodsVOListForShow = {}
	ipairs = var_1

	for iter_17_0, iter_17_1 in var_1(arg_17_0.diamondGoodsVOList) do
		ChargeConst = var_1_10006
		var_1_10006 = var_1_10006.getBuyCount(arg_17_0.chargedList, iter_17_1.id)

		iter_17_1:updateBuyCount(var_1_10006)

		if iter_17_1:canPurchase() and iter_17_1:inTime() then
			table = var_7

			var_7.insert(arg_17_0.diamondGoodsVOListForShow, iter_17_1)
		end
	end

	table = var_1

	local var_17_0 = var_1.sort
	local var_17_1 = arg_17_0.diamondGoodsVOListForShow

	CompareFuncs = iter_17_0

	var_17_0(var_17_1, iter_17_0({
		function(arg_18_0)
			return arg_18_0:isFree() and 0 or 1
		end,
		function(arg_19_0)
			if arg_19_0:isChargeType() and arg_19_0:isMonthCard() then
				local var_19_0 = arg_17_0.player
				local var_19_1 = var_1.getCardById

				VipCard = var_2_10004

				if var_19_1(var_19_0, var_2_10004.MONTH) then
					local var_19_2 = var_1
					local var_19_3 = var_1.getLeftDate(var_19_2)

					pg = var_19_0

					local var_19_4 = var_19_0.TimeMgr.GetInstance()
					local var_19_5 = var_3.GetServerTime(var_19_4)

					math = var_19_2

					local var_19_6 = var_19_2.floor((var_19_3 - var_19_5) / 0)
					local var_19_7

					if not arg_19_0:getConfig("limit_arg") then
						var_19_7 = 0
					end

					if var_19_7 < var_19_6 then
						return 1
					end
				end
			end

			return 0
		end,
		function(arg_20_0)
			table = var_2_10001

			return not var_2_10001.contains(arg_17_0.firstChargeIds, arg_20_0.id) and arg_20_0:firstPayDouble() and 0 or 1
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

function var_0_1.updateGoodsData(arg_23_0)
	arg_23_0.firstChargeIds = arg_23_0.contextData.firstChargeIds
	arg_23_0.chargedList = arg_23_0.contextData.chargedList
	arg_23_0.normalList = arg_23_0.contextData.normalList
	arg_23_0.normalGroupList = arg_23_0.contextData.normalGroupList

	return
end

function var_0_1.setGoodData(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	arg_24_0.firstChargeIds = arg_24_1
	arg_24_0.chargedList = arg_24_2
	arg_24_0.normalList = arg_24_3
	arg_24_0.normalGroupList = arg_24_4

	return
end

function var_0_1.updateData(arg_25_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_25_0 = var_1_10001(var_1_10003)

	arg_25_0.player = var_1.getData(var_25_0)

	arg_25_0:updateDiamondGoodsVOList()
	arg_25_0:sortDiamondGoodsVOList()

	return
end

function var_0_1.IsSupplyShop(arg_26_0)
	return false
end

function var_0_1.reUpdateAll(arg_27_0)
	arg_27_0:updateData()
	arg_27_0:updateView()

	return
end

function var_0_1.ShowPanel(arg_28_0, arg_28_1)
	setActive = var_1_10002

	var_1_10002(arg_28_0._go, arg_28_1)

	return
end

return var_0_1
