class = var_0_10000

local var_0_0 = "ChargeGiftShopView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

var_0_1.ShowPickUp = false

function var_0_1.getUIName(arg_1_0)
	return "ChargeGiftShopUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:Show()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	pairs = var_1_10001

	local var_3_0

	if not arg_3_0.chargeCardTable then
		var_3_0 = {}
	end

	for iter_3_0, iter_3_1 in var_1_10001(var_3_0) do
		iter_3_1:Dispose()
	end

	arg_3_0:removeUpdateTimer()

	return
end

function var_0_1.initData(arg_4_0)
	arg_4_0.giftGoodsVOListForShow = {}
	arg_4_0.packageSortList = {
		0
	}
	arg_4_0.prevBtn = nil
	arg_4_0.selectedPackageType = nil
	arg_4_0.updateTime = nil
	arg_4_0.updateTimer = nil
	getProxy = var_1
	PlayerProxy = var_1_10002

	local var_4_0 = var_1(var_1_10002)

	arg_4_0.player = var_1.getData(var_4_0)

	arg_4_0:updateData()

	return
end

function var_0_1.initUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.emptyGo = var_1.Find(var_5_0, "emptyText")
	setText = var_1

	local var_5_1 = arg_5_0.emptyGo

	i18n = var_3

	var_1(var_5_1, var_3("shop_pack_empty"))

	GetComponent = var_1

	local var_5_2 = arg_5_0._tf

	arg_5_0.lScrollRect = var_1(var_2.Find(var_5_2, "lScrollRect"), "LScrollRect")
	arg_5_0.chargeCardTable = {}

	arg_5_0:initScrollRect()
	arg_5_0:initToggleList()
	arg_5_0:updateToggleList()
	arg_5_0:updateScrollRect()

	triggerButton = var_1

	local var_5_3 = arg_5_0._tf
	local var_5_4 = var_2.Find(var_5_3, "toggleGroup")

	var_1(var_2.GetChild(var_5_4, 0))

	return
end

function var_0_1.GetViewSkinWrap(arg_6_0)
	ChargeScene = var_1_10001

	return var_1_10001.TYPE_GIFT
end

function var_0_1.initScrollRect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.chargeCardTable = {}

	local function var_7_0(arg_8_0)
		ChargeCard = var_2_10001

		local var_8_0 = var_2_10001.New(arg_8_0)

		onButton = var_2

		local var_8_1 = arg_7_0
		local var_8_2 = var_8_0.tr

		local function var_8_3()
			local var_9_0 = var_8_0.goods

			if var_0.isChargeType(var_9_0) then
				switch = var_0

				local var_9_1 = var_8_0.goods
				local var_9_2 = var_1.getShowType(var_9_1)
				local var_9_3 = {}

				Goods = var_3_10003
				var_9_3[var_3_10003.SHOW_TYPE_TECH] = function()
					local var_10_0 = arg_7_0
					local var_10_1 = var_0.emit

					NewShopMainMediator = var_4_10002

					var_10_1(var_10_0, var_4_10002.OPEN_TEC_SHIP_GIFT_SELL_LAYER, var_8_0.goods, arg_7_0.chargedList)

					return
				end
				Goods = var_3
				var_9_3[var_3.SHOW_TYPE_BATTLE_UI] = function()
					local var_11_0 = arg_7_0
					local var_11_1 = var_0.emit

					NewShopMainMediator = var_4_10002

					var_11_1(var_11_0, var_4_10002.OPEN_BATTLE_UI_SELL_LAYER, var_8_0.goods, arg_7_0.chargedList)

					return
				end

				var_0(var_9_2, var_9_3, function()
					local var_12_0 = arg_7_0

					var_0.confirm(var_12_0, var_8_0.goods)

					return
				end)
			else
				local var_9_4 = arg_7_0

				var_0.confirm(var_9_4, var_8_0.goods)
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2(var_8_1, var_8_2, var_8_3, var_2_10006)

		onButton = var_2

		local var_8_4 = arg_7_0
		local var_8_5 = var_8_0.viewBtn

		local function var_8_6()
			local var_13_0 = var_8_0.goods

			if not var_0.isChargeType(var_13_0) then
				return
			end

			local var_13_1 = var_8_0.goods
			local var_13_2 = var_0.GetSkinProbability(var_13_1)

			getProxy = var_13_1
			ShipSkinProxy = var_3_10002

			local var_13_3 = var_13_1(var_3_10002)
			local var_13_4 = var_1.GetProbabilitySkins(var_13_3, var_13_2)

			if #var_13_2 <= 0 or #var_13_2 ~= #var_13_4 then
				local var_13_5 = var_8_0.goods
				local var_13_6 = var_2.GetSkinProbabilityItem(var_13_5)

				var_3_10004 = arg_7_0

				local var_13_7 = var_3.emit

				BaseUI = var_3_10005

				var_13_7(var_3_10004, var_3_10005.ON_DROP, var_13_6)
			else
				local var_13_8 = arg_7_0
				local var_13_9 = var_2.emit

				NewShopMainMediator = var_3_10004

				local var_13_10 = var_3_10004.VIEW_SKIN_PROBABILITY
				local var_13_11 = var_8_0.goods.id
				local var_13_12 = arg_7_0

				var_13_9(var_13_8, var_13_10, var_13_11, var_6.GetViewSkinWrap(var_13_12))
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2(var_8_4, var_8_5, var_8_6, var_2_10006)

		arg_7_0.chargeCardTable[arg_8_0] = var_8_0

		return
	end

	local function var_7_1(arg_14_0, arg_14_1)
		local var_14_0

		if not arg_7_0.chargeCardTable[arg_14_1] then
			var_7_0(arg_14_1)

			var_14_0 = arg_7_0.chargeCardTable[arg_14_1]
		end

		if arg_7_0.filterList[arg_14_0 + 1] then
			var_14_0:update(var_3, arg_7_0.player, arg_7_0.firstChargeIds)
		end

		return
	end

	arg_7_0.lScrollRect.onInitItem = var_7_0
	arg_7_0.lScrollRect.onUpdateItem = var_7_1

	return
end

function var_0_1.updateToggleList(arg_15_0)
	local var_15_0 = arg_15_0.uiToggleList

	var_1.align(var_15_0, #arg_15_0.packageSortList)

	return
end

function var_0_1.updateScrollRect(arg_16_0)
	arg_16_0.filterList = arg_16_0:getFilterList()
	arg_16_0.lScrollRect.enabled = true

	local var_16_0 = arg_16_0.lScrollRect

	var_1.SetTotalCount(var_16_0, #arg_16_0.filterList, arg_16_0.lScrollRect.value)

	setActive = var_1

	var_1(arg_16_0.emptyGo, #arg_16_0.filterList <= 0)

	return
end

function var_0_1.confirm(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	Clone = var_1_10002

	local var_17_0 = var_1_10002(arg_17_1)

	if arg_17_1.isChargeType(var_17_0) then
		table = var_2

		local var_17_1

		if not var_2.contains(arg_17_0.firstChargeIds, arg_17_1.id) and arg_17_1:firstPayDouble() then
			var_17_1 = 4
		else
			var_1_10005 = arg_17_1
			var_17_1 = arg_17_1.getConfig(var_1_10005, "tag")
		end

		var_1_10006 = arg_17_1

		if not arg_17_1.isMonthCard(var_1_10006) then
			var_1_10006 = arg_17_1

			if not arg_17_1.isGiftBox(var_1_10006) then
				var_1_10006 = arg_17_1

				if not arg_17_1.isItemBox(var_1_10006) then
					var_1_10006 = arg_17_1

					if arg_17_1.isPassItem(var_1_10006) then
						var_1_10006 = arg_17_1
						var_1_10005 = arg_17_1.GetExtraServiceItem(var_1_10006)
						var_1_10006 = arg_17_1:GetExtraDrop()

						local var_17_2 = arg_17_1:GetBonusItem()
						local var_17_3
						local var_17_4

						var_1_10011 = arg_17_1

						if arg_17_1.isPassItem(var_1_10011) then
							i18n = var_10
							var_17_3 = var_10("battlepass_pay_tip")
						else
							var_1_10011 = arg_17_1

							if arg_17_1.isMonthCard(var_1_10011) then
								i18n = var_10
								var_17_3 = var_10("charge_title_getitem_month")
								i18n = var_10
								var_17_4 = var_10("charge_title_getitem_soon")
							else
								i18n = var_10
								var_17_3 = var_10("charge_title_getitem")
							end
						end

						local var_17_5 = {
							isChargeType = true,
							commodity = arg_17_1,
							infoTip = arg_17_1:GetInfoTip()
						}

						var_1_10011 = "chargeicon/"
						var_1_10013 = arg_17_1
						var_17_5.icon = var_1_10011 .. arg_17_1.getConfig(var_1_10013, "picture")
						var_17_5.name = arg_17_1:getConfig("name_display")
						var_17_5.tipExtra = var_17_3
						var_17_5.extraItems = var_1_10005
						var_17_5.price = arg_17_1:getConfig("money")
						var_17_5.isLocalPrice = arg_17_1:IsLocalPrice()
						var_17_5.tagType = var_17_1
						var_17_5.isMonthCard = arg_17_1:isMonthCard()
						var_17_5.tipBonus = var_17_4
						var_17_5.bonusItem = var_17_2
						var_17_5.extraDrop = var_1_10006
						var_17_5.descExtra = arg_17_1:getConfig("descrip_extra")
						var_17_5.limitArgs = arg_17_1:getConfig("limit_args")

						function var_17_5.onYes()
							ChargeConst = var_2_10000

							if var_2_10000.isNeedSetBirth() then
								local var_18_0 = arg_17_0
								local var_18_1 = var_0.emit

								NewShopMainMediator = var_2_10002

								var_18_1(var_18_0, var_2_10002.OPEN_CHARGE_BIRTHDAY)
							else
								local var_18_2 = arg_17_0
								local var_18_3 = var_0.emit

								NewShopMainMediator = var_2_10002

								var_18_3(var_18_2, var_2_10002.CHARGE, arg_17_1.id)
							end

							return
						end

						local var_17_6 = arg_17_0

						var_1_10011 = arg_17_0.emit
						NewShopMainMediator = var_1_10013

						var_1_10011(var_17_6, var_1_10013.OPEN_CHARGE_ITEM_PANEL, var_17_5)
					else
						var_1_10006 = arg_17_1

						if arg_17_1.isGem(var_1_10006) then
							var_1_10006 = arg_17_1
							var_1_10005 = arg_17_1.getConfig(var_1_10006, "money")
							var_1_10006 = arg_17_1:getConfig("gem")

							if var_3 then
								var_1_10006 = var_1_10006 + arg_17_1:getConfig("gem")
							else
								var_1_10006 = var_1_10006 + arg_17_1:getConfig("extra_gem")
							end

							local var_17_7 = {
								isChargeType = true,
								commodity = arg_17_1,
								icon = "chargeicon/" .. arg_17_1:getConfig("picture"),
								name = arg_17_1:getConfig("name_display"),
								price = arg_17_1:getConfig("money"),
								isLocalPrice = arg_17_1:IsLocalPrice(),
								tagType = var_17_1
							}

							i18n = var_8
							var_17_7.normalTip = var_8("charge_start_tip", var_1_10005, var_1_10006)

							function var_17_7.onYes()
								ChargeConst = var_2_10000

								if var_2_10000.isNeedSetBirth() then
									local var_19_0 = arg_17_0
									local var_19_1 = var_0.emit

									NewShopMainMediator = var_2_10002

									var_19_1(var_19_0, var_2_10002.OPEN_CHARGE_BIRTHDAY)
								else
									local var_19_2 = arg_17_0
									local var_19_3 = var_0.emit

									NewShopMainMediator = var_2_10002

									var_19_3(var_19_2, var_2_10002.CHARGE, arg_17_1.id)
								end

								return
							end

							local var_17_8 = arg_17_0
							local var_17_9 = arg_17_0.emit

							NewShopMainMediator = var_10

							var_17_9(var_17_8, var_10.OPEN_CHARGE_ITEM_BOX, var_17_7)
						end
					end

					goto label_17_0

					if arg_17_1:isActGiftPackage() then
						local var_17_10 = arg_17_1:getBindActivity()
						local var_17_11 = arg_17_0
						local var_17_12 = arg_17_0.emit

						NewShopMainMediator = var_1_10005

						var_17_12(var_17_11, var_1_10005.OPEN_GIFT_ACT_LAYER, var_17_10.id)
					else
						local var_17_13 = {}
						local var_17_14 = arg_17_1
						local var_17_15 = arg_17_1.getConfig(var_17_14, "effect_args")

						Item = var_17_14

						local var_17_16 = var_17_14.getConfigData(var_17_15[1]).display_icon

						type = var_1_10006

						if var_1_10006(var_17_16) == "table" then
							ipairs = var_6

							for iter_17_0, iter_17_1 in var_6(var_17_16) do
								table = var_1_10011
								var_1_10011 = var_1_10011.insert

								local var_17_17 = var_17_13

								Drop = var_1_10013

								var_1_10011(var_17_17, var_1_10013.New({
									type = iter_17_1[1],
									id = iter_17_1[2],
									count = iter_17_1[3]
								}))
							end
						end

						local var_17_18 = {
							isLocalPrice = false,
							isChargeType = false,
							isMonthCard = false,
							commodity = arg_17_1,
							icon = var_4.icon,
							name = var_4.name
						}

						i18n = var_7
						var_17_18.tipExtra = var_7("charge_title_getitem")
						var_17_18.extraItems = var_17_13
						var_17_18.price = arg_17_1:getConfig("resource_num")
						var_17_18.tagType = arg_17_1:getConfig("tag")

						function var_17_18.onYes()
							pg = var_2_10000

							local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
							local var_20_1 = var_0.ShowMsgBox
							local var_20_2 = {}

							i18n = var_2_10003

							local var_20_3 = "charge_scene_buy_confirm"
							local var_20_4 = arg_17_1

							var_20_2.content = var_2_10003(var_20_3, var_5.getConfig(var_20_4, "resource_num"), var_0.name)

							function var_20_2.onYes()
								local var_21_0 = arg_17_0
								local var_21_1 = var_0.emit

								NewShopMainMediator = var_3_10002

								var_21_1(var_21_0, var_3_10002.BUY_ITEM, arg_17_1.id, 1)

								return
							end

							var_20_1(var_20_0, var_20_2)

							return
						end

						local var_17_19 = arg_17_0
						local var_17_20 = arg_17_0.emit

						NewShopMainMediator = var_9

						var_17_20(var_17_19, var_9.OPEN_CHARGE_ITEM_PANEL, var_17_18)
					end

					::label_17_0::

					return
				end
			end
		end
	end
end

function var_0_1.initToggleList(arg_22_0)
	UIItemList = var_1_10001

	local var_22_0 = var_1_10001.New
	local var_22_1 = arg_22_0._tf
	local var_22_2 = var_2.Find(var_22_1, "toggleGroup")
	local var_22_3 = arg_22_0._tf

	arg_22_0.uiToggleList = var_22_0(var_22_2, var_3.Find(var_22_3, "toggleGroup/Toggle"))

	local var_22_4 = arg_22_0.uiToggleList

	var_1.make(var_22_4, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		local var_23_0

		if arg_23_0 == var_2_10003.EventInit then
			var_23_0 = arg_22_0.packageSortList[arg_23_1 + 1]
			setText = var_4

			local var_23_1 = arg_23_2
			local var_23_2 = arg_23_2.Find(var_23_1, "selected/Label")

			i18n = var_23_1
			string = var_2_10007

			var_4(var_23_2, var_23_1(var_2_10007.format("shop_package_sort_%s", var_23_0)))

			setText = var_4

			local var_23_3 = arg_23_2
			local var_23_4 = arg_23_2.Find(var_23_3, "selected/enText")

			i18n = var_23_3
			string = var_2_10007

			var_4(var_23_4, var_23_3(var_2_10007.format("shop_package_sort_en_%s", var_23_0)))

			setText = var_4

			local var_23_5 = arg_23_2
			local var_23_6 = arg_23_2.Find(var_23_5, "unselected/Label")

			i18n = var_23_5
			string = var_2_10007

			var_4(var_23_6, var_23_5(var_2_10007.format("shop_package_sort_%s", var_23_0)))

			setActive = var_4

			var_4(arg_23_2:Find("unselected"), true)

			setActive = var_4

			var_4(arg_23_2:Find("selected"), false)
		else
			UIItemList = var_23_0

			if arg_23_0 == var_23_0.EventUpdate then
				onButton = var_3

				local var_23_7 = arg_22_0
				local var_23_8 = arg_23_2

				local function var_23_9()
					local var_24_0 = arg_22_0.packageSortList[arg_23_1 + 1]

					if arg_22_0.selectedPackageType == var_24_0 then
						return
					end

					setActive = var_1

					local var_24_1 = arg_23_2

					var_1(var_2.Find(var_24_1, "unselected"), false)

					setActive = var_1

					local var_24_2 = arg_23_2

					var_1(var_2.Find(var_24_2, "selected"), true)

					if arg_22_0.prevBtn then
						setActive = var_1

						local var_24_3 = arg_22_0.prevBtn

						var_1(var_2.Find(var_24_3, "unselected"), true)

						setActive = var_1

						local var_24_4 = arg_22_0.prevBtn

						var_1(var_2.Find(var_24_4, "selected"), false)
					end

					arg_22_0.prevBtn = arg_23_2
					arg_22_0.selectedPackageType = var_24_0

					local var_24_5 = arg_22_0

					var_1.updateScrollRect(var_24_5)

					return
				end

				SFX_PANEL = var_2_10007

				var_3(var_23_7, var_23_8, var_23_9, var_2_10007)
			end
		end

		return
	end)

	return
end

function var_0_1.sortGiftGoodsVOList(arg_25_0)
	local var_25_0

	getProxy = var_1_10002
	ShopsProxy = var_1_10003

	local var_25_1 = var_1_10002(var_1_10003)
	local var_25_2, var_25_3 = var_2.GetAllShowGiftPackages(var_25_1, arg_25_0.ShowPickUp)
	local var_25_4 = var_25_3

	arg_25_0.giftGoodsVOListForShow = var_25_2
	arg_25_0.packageSortList = {
		0
	}

	local var_25_5 = {
		[0] = true
	}

	ipairs = var_25_3

	for iter_25_0, iter_25_1 in var_25_3(var_25_4) do
		pg = var_1_10008
		var_1_10009 = var_1_10008.TimeMgr.GetInstance()
		var_1_10008, var_1_10009 = var_1_10008.inTime(var_1_10009, iter_25_1:getConfig("time"))

		if var_1_10009 then
			arg_25_0:addUpdateTimer(var_1_10009)
		end
	end

	ipairs = var_3

	for iter_25_2, iter_25_3 in var_3(arg_25_0.giftGoodsVOListForShow) do
		var_1_10009 = iter_25_3

		if not iter_25_3.isChargeType(var_1_10009) then
			pg = var_8
			var_1_10009 = var_8.TimeMgr.GetInstance()

			local var_25_6

			var_25_6, var_1_10009 = var_8.inTime(var_1_10009, iter_25_3:getConfig("time"))

			if var_1_10009 then
				arg_25_0:addUpdateTimer(var_1_10009)
			end
		end

		var_1_10009 = iter_25_3

		if not var_25_5[iter_25_3.getConfig(var_1_10009, "package_sort_id")] then
			var_25_5[var_8] = true
			table = var_1_10009

			var_1_10009.insert(arg_25_0.packageSortList, var_8)
		end
	end

	table = var_3

	var_3.sort(arg_25_0.packageSortList)

	local function var_25_7(arg_26_0)
		local var_26_0 = arg_26_0:getConfig("time")
		local var_26_1 = 0

		type = var_3

		if var_3(var_26_0) == "string" then
			var_26_1 = var_26_1 + 999999999999
		else
			type = var_3

			if var_3(var_26_0) == "table" then
				pg = var_3

				local var_26_2 = var_3.TimeMgr.GetInstance()
				local var_26_3 = var_3.parseTimeFromConfig(var_26_2, var_26_0[2])

				pg = var_26_2

				local var_26_4 = var_26_2.TimeMgr.GetInstance()

				var_26_1 = var_26_3 - var_4.GetServerTime(var_26_4) > 0 and var_26_1 or 999999999999
			else
				var_26_1 = var_26_1 + 999999999999
			end
		end

		return var_26_1
	end

	local var_25_8 = {}

	getProxy = var_5
	ActivityProxy = iter_25_2

	local var_25_9 = var_5(iter_25_2)

	ipairs = iter_25_2

	local var_25_10 = var_25_9
	local var_25_11 = var_25_9.getActivitiesByType

	ActivityConst = var_1_10009

	for iter_25_4, iter_25_5 in iter_25_2(var_25_11(var_25_10, var_1_10009.ACTIVITY_TYPE_GIFT_UP)) do
		if var_25_9:IsActivityNotEnd(iter_25_5.id) then
			underscore = var_11

			local var_25_12 = var_11(iter_25_5:getConfig("config_client").gifts)
			local var_25_13 = var_11.chain(var_25_12)
			local var_25_14 = var_11.flatten(var_25_13)

			var_11.map(var_25_14, function(arg_27_0)
				var_25_8[arg_27_0] = true

				return
			end)
		end
	end

	table = var_6

	local var_25_15 = var_6.sort
	local var_25_16 = arg_25_0.giftGoodsVOListForShow

	CompareFuncs = var_8

	var_25_15(var_25_16, var_8({
		function(arg_28_0)
			return var_25_8[arg_28_0.id] and 0 or 1
		end,
		function(arg_29_0)
			return (arg_29_0:getConfig("type_order") - 1) % 1000
		end,
		function(arg_30_0)
			return var_25_7(arg_30_0)
		end,
		function(arg_31_0)
			return -arg_31_0:getConfig("tag")
		end,
		function(arg_32_0)
			local var_32_0

			if not arg_32_0:getConfig("order") then
				var_32_0 = 999
			end

			return var_32_0
		end,
		function(arg_33_0)
			return arg_33_0.id
		end
	}))

	return
end

function var_0_1.getFilterList(arg_34_0)
	if arg_34_0.selectedPackageType == nil or arg_34_0.selectedPackageType == 0 then
		return arg_34_0.giftGoodsVOListForShow
	end

	return arg_34_0:getFilterListByType(arg_34_0.selectedPackageType)
end

function var_0_1.getFilterListByType(arg_35_0, arg_35_1)
	local var_35_0 = {}

	ipairs = var_1_10003

	for iter_35_0, iter_35_1 in var_1_10003(arg_35_0.giftGoodsVOListForShow) do
		if iter_35_1:getConfig("package_sort_id") == arg_35_1 then
			table = var_8

			var_8.insert(var_35_0, iter_35_1)
		end
	end

	return var_35_0
end

function var_0_1.updateGoodsData(arg_36_0)
	arg_36_0.firstChargeIds = arg_36_0.contextData.firstChargeIds
	arg_36_0.chargedList = arg_36_0.contextData.chargedList

	return
end

function var_0_1.setGoodData(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_0.firstChargeIds = arg_37_1
	arg_37_0.chargedList = arg_37_2

	return
end

function var_0_1.updateData(arg_38_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_38_0 = var_1_10001(var_1_10002)

	arg_38_0.player = var_1.getData(var_38_0)

	arg_38_0:sortGiftGoodsVOList()

	return
end

function var_0_1.addUpdateTimer(arg_39_0, arg_39_1)
	pg = var_1_10002

	local var_39_0 = var_1_10002.TimeMgr.GetInstance()
	local var_39_1 = var_2.Table2ServerTime(var_39_0, arg_39_1)

	if arg_39_0.updateTime and var_39_1 > var_2:Table2ServerTime(arg_39_0.updateTime) then
		return
	end

	arg_39_0.updateTime = arg_39_1

	arg_39_0:removeUpdateTimer()

	Timer = var_4
	arg_39_0.updateTimer = var_4.New(function()
		local var_40_0 = var_0

		if var_0.GetServerTime(var_40_0) > var_39_1 then
			local var_40_1 = arg_39_0

			var_0.removeUpdateTimer(var_40_1)

			local var_40_2 = arg_39_0

			var_0.reUpdateAll(var_40_2)
		end

		return
	end, 1, -1)

	local var_39_2 = arg_39_0.updateTimer

	var_4.Start(var_39_2)
	arg_39_0.updateTimer.func()

	return
end

function var_0_1.removeUpdateTimer(arg_41_0)
	if arg_41_0.updateTimer then
		local var_41_0 = arg_41_0.updateTimer

		var_1.Stop(var_41_0)

		arg_41_0.updateTimer = nil
	end

	return
end

function var_0_1.IsSupplyShop(arg_42_0)
	return false
end

function var_0_1.reUpdateAll(arg_43_0)
	arg_43_0:updateData()
	arg_43_0:updateToggleList()
	arg_43_0:updateScrollRect()

	table = var_1

	if not var_1.contains(arg_43_0.packageSortList, arg_43_0.selectedPackageType) then
		triggerButton = var_1

		local var_43_0 = arg_43_0._tf
		local var_43_1 = var_2.Find(var_43_0, "toggleGroup")

		var_1(var_2.GetChild(var_43_1, 0))
	end

	return
end

function var_0_1.ShowPanel(arg_44_0, arg_44_1)
	setActive = var_1_10002

	var_1_10002(arg_44_0._go, arg_44_1)

	return
end

return var_0_1
