class = var_0_10000

local var_0_0 = "ChargeItemShopView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeItemShopUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:Show()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	arg_3_0:unBlurView()

	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.cardList) do
		iter_3_1:Dispose()
	end

	return
end

function var_0_1.initData(arg_4_0)
	arg_4_0.itemGoodsVOList = {}
	getProxy = var_1
	PlayerProxy = var_1_10003

	local var_4_0 = var_1(var_1_10003)

	arg_4_0.player = var_1.getData(var_4_0)
	arg_4_0.packageSortList = {
		0
	}
	arg_4_0.selectedPackageType = nil
	arg_4_0.prevBtn = nil

	arg_4_0:updateData()

	return
end

function var_0_1.initUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.contextTF = var_1.Find(var_5_0, "scroll")
	GetComponent = var_1
	arg_5_0.lScrollRect = var_1(arg_5_0.contextTF, "LScrollRect")

	local var_5_1 = arg_5_0._tf

	arg_5_0.scrollContent = var_1.Find(var_5_1, "scroll/content")
	GetComponent = var_1

	local var_5_2 = arg_5_0.scrollContent

	typeof = var_4
	RectTransform = var_1_10006
	arg_5_0.scrollRectTF = var_1(var_5_2, var_4(var_1_10006))
	GetComponent = var_1

	local var_5_3 = arg_5_0.scrollContent

	typeof = var_4
	GridLayoutGroup = var_1_10006
	arg_5_0.layoutGroup = var_1(var_5_3, var_4(var_1_10006))

	local var_5_4 = arg_5_0.scrollRectTF.rect.width
	local var_5_5 = arg_5_0.layoutGroup.cellSize.x

	math = var_5_3

	local var_5_6 = var_5_3.floor(var_5_4 / var_5_5)
	local var_5_7

	if var_5_4 % var_5_5 / var_5_6 < 12 then
		var_5_7 = (var_5_4 - var_5_5 * (var_5_6 - 1)) / var_3
	end

	local var_5_8 = arg_5_0.layoutGroup

	Vector2 = var_1_10007
	var_5_8.spacing = var_1_10007(var_5_7, var_5_7)
	arg_5_0.layoutGroup.padding.left = var_5_7 / 2
	arg_5_0.cardTable = {}
	arg_5_0.cardList = {}

	arg_5_0:initScrollRect()
	arg_5_0:initToggleList()
	arg_5_0:updateToggleList()
	arg_5_0:updateScrollRect()

	triggerButton = var_6

	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_8.Find(var_5_9, "toggleGroup")

	var_6(var_8.GetChild(var_5_10, 0))
	arg_5_0:blurView()

	return
end

function var_0_1.initScrollRect(arg_6_0)
	arg_6_0.cardTable = {}
	arg_6_0.cardList = {}

	local function var_6_0(arg_7_0)
		ChargeGoodsCard = var_2_10001

		local var_7_0 = var_2_10001.New(arg_7_0)

		table = var_2_10002

		var_2_10002.insert(arg_6_0.cardList, var_7_0)

		onButton = var_2

		var_2(arg_6_0, var_7_0.tf, function()
			local var_8_0 = var_7_0.goodsVO

			if var_0.isLevelLimit(var_8_0, arg_6_0.player.level) then
				pg = var_0

				local var_8_1 = var_0.TipsMgr.GetInstance()
				local var_8_2 = var_0.ShowTips

				i18n = var_3

				var_8_2(var_8_1, var_3("charge_level_limit"))

				return
			end

			local var_8_3 = var_7_0.goodsVO
			local var_8_4 = var_0.getConfig(var_8_3, "effect_args")
			local var_8_5 = {}
			local var_8_6
			local var_8_7

			if var_8_4 == "ship_bag_size" then
				var_3_10005 = arg_6_0.player
				var_8_7 = var_8_7.getMaxShipBagExcludeGuild(var_3_10005)
				Player = var_3_10004

				if var_3_10004.MAX_SHIP_BAG <= var_8_7 then
					pg = var_8_7
					var_3_10005 = var_8_7.TipsMgr.GetInstance()
					var_8_7 = var_8_7.ShowTips
					i18n = var_3_10006

					var_8_7(var_3_10005, var_3_10006("charge_ship_bag_max"))

					return
				end

				var_8_7 = {
					count = 1
				}
				DROP_TYPE_ITEM = var_3_10004
				var_8_7.type = var_3_10004
				Goods = var_3_10004
				var_8_7.id = var_3_10004.SHIP_BAG_SIZE_ITEM
				var_8_6 = var_8_7.id
			elseif var_8_4 == "equip_bag_size" then
				var_3_10005 = arg_6_0.player
				var_8_7 = var_8_7.getMaxEquipmentBagExcludeGuild(var_3_10005)
				Player = var_3_10004

				if var_3_10004.MAX_EQUIP_BAG <= var_8_7 then
					pg = var_8_7
					var_3_10005 = var_8_7.TipsMgr.GetInstance()
					var_8_7 = var_8_7.ShowTips
					i18n = var_3_10006

					var_8_7(var_3_10005, var_3_10006("charge_equip_bag_max"))

					return
				end

				var_8_7 = {
					count = 1
				}
				DROP_TYPE_ITEM = var_3_10004
				var_8_7.type = var_3_10004
				Goods = var_3_10004
				var_8_7.id = var_3_10004.EQUIP_BAG_SIZE_ITEM
				var_8_6 = var_8_7.id
			elseif var_8_4 == "commander_bag_size" then
				var_8_7 = arg_6_0.player.commanderBagMax
				Player = var_3_10004

				if var_3_10004.MAX_COMMANDER_BAG <= var_8_7 then
					pg = var_8_7
					var_3_10005 = var_8_7.TipsMgr.GetInstance()
					var_8_7 = var_8_7.ShowTips
					i18n = var_3_10006

					var_8_7(var_3_10005, var_3_10006("charge_commander_bag_max"))

					return
				end

				var_8_7 = {
					count = 1
				}
				DROP_TYPE_ITEM = var_3_10004
				var_8_7.type = var_3_10004
				Goods = var_3_10004
				var_8_7.id = var_3_10004.COMMANDER_BAG_SIZE_ITEM
				var_8_6 = var_8_7.id
			elseif var_8_4 == "spweapon_bag_size" then
				getProxy = var_8_7
				EquipmentProxy = var_3_10005

				local var_8_8 = var_8_7(var_3_10005)

				var_8_7 = var_8_7.GetSpWeaponCapacity(var_8_8)
				EquipmentProxy = var_3_10004

				if var_3_10004.MAX_SPWEAPON_BAG <= var_8_7 then
					pg = var_8_7

					local var_8_9 = var_8_7.TipsMgr.GetInstance()

					var_8_7 = var_8_7.ShowTips
					i18n = var_3_10006

					var_8_7(var_8_9, var_3_10006("charge_equip_bag_max"))

					return
				end

				var_8_7 = {
					count = 1
				}
				DROP_TYPE_ITEM = var_4
				var_8_7.type = var_4
				Goods = var_4
				var_8_7.id = var_4.SPWEAPON_BAG_SIZE_ITEM
				var_8_6 = var_8_7.id
			else
				var_8_7 = {}

				local var_8_10 = var_7_0.goodsVO

				var_8_7.id = var_4.getConfig(var_8_10, "effect_args")[1]

				local var_8_11 = var_7_0.goodsVO

				var_8_7.type = var_4.getConfig(var_8_11, "type")

				local var_8_12 = var_7_0.goodsVO

				var_8_7.count = var_4.getConfig(var_8_12, "num")
				var_8_5 = var_8_7

				local var_8_13 = var_7_0.goodsVO

				var_8_7 = var_8_7.getConfig(var_8_13, "type")
				DROP_TYPE_RESOURCE = var_4

				if var_8_7 == var_4 then
					id2ItemId = var_8_7
					var_8_6 = var_8_7(var_8_5.id)
				else
					var_8_6 = var_8_5.id
				end
			end

			ChargeConst = var_8_7

			local var_8_14 = var_8_7.getGroupLimit
			local var_8_15 = arg_6_0.normalGroupList
			local var_8_16 = var_7_0.goodsVO
			local var_8_17 = var_8_14(var_8_15, var_6.getConfig(var_8_16, "group"))
			local var_8_18 = var_7_0.goodsVO

			if var_4.IsGroupSale(var_8_18) then
				i18n = var_4

				local var_8_19

				if not var_4("gem_shop_xinzhi_tip", var_8_17) then
					var_8_19 = ""
				end

				pg = var_8_15

				local var_8_20 = var_8_15.MsgboxMgr.GetInstance()
				local var_8_21 = var_5.ShowMsgBox
				local var_8_22 = {
					yesText = "text_buy"
				}

				MSGBOX_TYPE_SINGLE_ITEM = var_9
				var_8_22.type = var_9
				var_8_22.drop = var_8_5
				var_8_22.subIntro = var_8_19

				function var_8_22.onYes()
					if var_8_6 then
						local var_9_0 = var_7_0.goodsVO
						local var_9_1 = var_0.GetPrice(var_9_0)

						Item = var_4_10001

						local var_9_2 = var_4_10001.New({
							id = var_8_6
						})
						local var_9_3 = var_1.getConfig(var_9_2, "name")

						pg = var_9_0

						local var_9_4 = var_9_0.MsgboxMgr.GetInstance()
						local var_9_5 = var_2.ShowMsgBox
						local var_9_6 = {}

						i18n = var_4_10006
						var_9_6.content = var_4_10006("charge_scene_buy_confirm", var_9_1, var_9_3)

						function var_9_6.onYes()
							local var_10_0 = arg_6_0
							local var_10_1 = var_0.emit

							NewShopMainMediator = var_5_10003

							var_10_1(var_10_0, var_5_10003.BUY_ITEM, var_7_0.goodsVO.id, 1)

							return
						end

						var_9_5(var_9_4, var_9_6)
					end

					return
				end

				var_8_21(var_8_20, var_8_22)

				return
			end
		end)

		arg_6_0.cardTable[arg_7_0] = var_7_0

		return
	end

	local function var_6_1(arg_11_0, arg_11_1)
		local var_11_0

		if not arg_6_0.cardTable[arg_11_1] then
			var_6_0(arg_11_1)

			var_11_0 = arg_6_0.cardTable[arg_11_1]
		end

		local var_11_1 = arg_6_0.filterList[arg_11_0 + 1]

		var_11_0:update(var_11_1)
		var_11_0:setLevelMask(arg_6_0.player.level)

		ChargeConst = var_4

		local var_11_2 = var_4.getGroupLimit(arg_6_0.normalGroupList, var_11_1:getConfig("group"))

		var_11_0:setGroupMask(var_11_2)

		return
	end

	arg_6_0.lScrollRect.onInitItem = var_6_0
	arg_6_0.lScrollRect.onUpdateItem = var_6_1

	return
end

function var_0_1.updateScrollRect(arg_12_0)
	arg_12_0.filterList = arg_12_0:getFilterList()
	arg_12_0.lScrollRect.enabled = true

	local var_12_0 = arg_12_0.lScrollRect

	var_1.SetTotalCount(var_12_0, #arg_12_0.filterList, arg_12_0.lScrollRect.value)

	return
end

function var_0_1.updateToggleList(arg_13_0)
	local var_13_0 = arg_13_0.uiToggleList

	var_1.align(var_13_0, #arg_13_0.packageSortList)

	return
end

function var_0_1.initToggleList(arg_14_0)
	UIItemList = var_1_10001

	local var_14_0 = var_1_10001.New
	local var_14_1 = arg_14_0._tf
	local var_14_2 = var_3.Find(var_14_1, "toggleGroup")
	local var_14_3 = arg_14_0._tf

	arg_14_0.uiToggleList = var_14_0(var_14_2, var_4.Find(var_14_3, "toggleGroup/Toggle"))

	local var_14_4 = arg_14_0.uiToggleList

	var_1.make(var_14_4, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		local var_15_0

		if arg_15_0 == var_2_10003.EventInit then
			var_15_0 = arg_14_0.packageSortList[arg_15_1 + 1]
			setText = var_4
			var_2_10008 = arg_15_2

			local var_15_1 = arg_15_2.Find(var_2_10008, "selected/Label")

			i18n = var_2_10007
			string = var_9

			var_4(var_15_1, var_2_10007(var_9.format("shop_package_sort_%s", var_15_0)))

			setText = var_4
			var_2_10008 = arg_15_2

			local var_15_2 = arg_15_2.Find(var_2_10008, "selected/enText")

			i18n = var_7
			string = var_9

			var_4(var_15_2, var_7(var_9.format("shop_package_sort_en_%s", var_15_0)))

			setText = var_4
			var_2_10008 = arg_15_2

			local var_15_3 = arg_15_2.Find(var_2_10008, "unselected/Label")

			i18n = var_7
			string = var_9

			var_4(var_15_3, var_7(var_9.format("shop_package_sort_%s", var_15_0)))

			setActive = var_4
			var_2_10008 = arg_15_2

			var_4(arg_15_2.Find(var_2_10008, "unselected"), true)

			setActive = var_4
			var_2_10008 = arg_15_2

			var_4(arg_15_2.Find(var_2_10008, "selected"), false)
		else
			UIItemList = var_15_0

			if arg_15_0 == var_15_0.EventUpdate then
				onButton = var_3

				local var_15_4 = arg_14_0
				local var_15_5 = arg_15_2

				local function var_15_6()
					local var_16_0 = arg_14_0.packageSortList[arg_15_1 + 1]

					if arg_14_0.selectedPackageType == var_16_0 then
						return
					end

					setActive = var_1

					local var_16_1 = arg_15_2

					var_1(var_3.Find(var_16_1, "unselected"), false)

					setActive = var_1

					local var_16_2 = arg_15_2

					var_1(var_3.Find(var_16_2, "selected"), true)

					if arg_14_0.prevBtn then
						setActive = var_1

						local var_16_3 = arg_14_0.prevBtn

						var_1(var_3.Find(var_16_3, "unselected"), true)

						setActive = var_1

						local var_16_4 = arg_14_0.prevBtn

						var_1(var_3.Find(var_16_4, "selected"), false)
					end

					arg_14_0.prevBtn = arg_15_2
					arg_14_0.selectedPackageType = var_16_0

					local var_16_5 = arg_14_0

					var_1.updateScrollRect(var_16_5)

					return
				end

				SFX_PANEL = var_2_10008

				var_3(var_15_4, var_15_5, var_15_6, var_2_10008)
			end
		end

		return
	end)

	return
end

function var_0_1.updateItemGoodsVOList(arg_17_0)
	arg_17_0.itemGoodsVOList = {}
	arg_17_0.packageSortList = {
		0
	}
	pg = var_1

	local var_17_0 = var_1.shop_template

	pairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(var_17_0.all) do
		if var_17_0[iter_17_1].genre == "gem_shop" then
			ChargeConst = var_1_10008

			local var_17_1, var_17_2

			var_1_10008, var_17_1, var_17_2 = var_1_10008.getGoodsLimitInfo(iter_17_1)

			local var_17_3 = false

			if var_1_10007.effect_args == "ship_bag_size" and var_17_1 and var_17_2 then
				local var_17_4 = arg_17_0.player

				if var_17_1 <= var_1_10013.getMaxShipBagExcludeGuild(var_17_4) and var_1_10013 <= var_17_2 then
					var_17_3 = true
				end
			elseif var_12 == "equip_bag_max" and var_17_1 and var_17_2 then
				local var_17_5 = arg_17_0.player

				if var_17_1 <= var_1_10013.getMaxEquipmentBag(var_17_5) and var_1_10013 <= var_17_2 then
					var_17_3 = true
				end
			elseif var_12 == "commander_bag_size" and var_17_1 and var_17_2 then
				if var_17_1 <= arg_17_0.player.commanderBagMax and var_1_10013 <= var_17_2 then
					var_17_3 = true
				end
			else
				var_17_3 = true
			end

			if var_17_3 == true then
				Goods = var_1_10013
				var_1_10013 = var_1_10013.Create

				local var_17_6 = {
					count = 0,
					shop_id = iter_17_1
				}

				Goods = var_1_10016
				var_1_10013 = var_1_10013(var_17_6, var_1_10016.TYPE_MILITARY)
				table = var_1_10014

				var_1_10014.insert(arg_17_0.itemGoodsVOList, var_1_10013)
			end
		end
	end

	for iter_17_2 = #arg_17_0.itemGoodsVOList, 1, -1 do
		local var_17_7 = arg_17_0.itemGoodsVOList[iter_17_2]

		ChargeConst = var_1_10007
		var_1_10007 = var_1_10007.getGroupLimit(arg_17_0.normalGroupList, var_17_7:getConfig("group"))

		if not var_17_7:IsShowWhenGroupSale(var_1_10007) then
			table = var_1_10008

			var_1_10008.remove(arg_17_0.itemGoodsVOList, iter_17_2)
		end
	end

	ipairs = var_2

	for iter_17_3, iter_17_4 in var_2(arg_17_0.itemGoodsVOList) do
		local var_17_8 = var_17_0[iter_17_4.id].package_sort_id

		table = var_1_10008

		if not var_1_10008.contains(arg_17_0.packageSortList, var_17_8) then
			table = var_1_10008

			var_1_10008.insert(arg_17_0.packageSortList, var_17_8)
		end
	end

	table = var_2

	var_2.sort(arg_17_0.packageSortList, function(arg_18_0, arg_18_1)
		return arg_18_0 < arg_18_1
	end)

	return
end

function var_0_1.sortItemGoodsVOList(arg_19_0)
	table = var_1_10001

	var_1_10001.sort(arg_19_0.itemGoodsVOList, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:isLevelLimit(arg_19_0.player.level) and 1 or 0
		local var_20_1 = arg_20_1:isLevelLimit(arg_19_0.player.level) and 1 or 0

		if arg_20_0:getConfig("order") == arg_20_1:getConfig("order") then
			if var_20_0 == var_20_1 then
				return arg_20_0.id > arg_20_1.id
			end

			return var_20_0 < var_20_1
		else
			return var_4 < var_5
		end

		return
	end)

	return
end

function var_0_1.getFilterList(arg_21_0)
	if arg_21_0.selectedPackageType == 0 then
		return arg_21_0.itemGoodsVOList
	end

	local var_21_0 = {}

	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.itemGoodsVOList) do
		if iter_21_1:getConfig("package_sort_id") == arg_21_0.selectedPackageType then
			table = var_7

			var_7.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_1.updateGoodsData(arg_22_0)
	arg_22_0.firstChargeIds = arg_22_0.contextData.firstChargeIds
	arg_22_0.chargedList = arg_22_0.contextData.chargedList
	arg_22_0.normalList = arg_22_0.contextData.normalList
	arg_22_0.normalGroupList = arg_22_0.contextData.normalGroupList

	return
end

function var_0_1.setGoodData(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0.firstChargeIds = arg_23_1
	arg_23_0.chargedList = arg_23_2
	arg_23_0.normalList = arg_23_3
	arg_23_0.normalGroupList = arg_23_4

	return
end

function var_0_1.updateData(arg_24_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_24_0 = var_1_10001(var_1_10003)

	arg_24_0.player = var_1.getData(var_24_0)

	arg_24_0:updateItemGoodsVOList()
	arg_24_0:sortItemGoodsVOList()

	return
end

function var_0_1.blurView(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.OverlayPanel
	local var_25_2 = arg_25_0._tf
	local var_25_3 = {}
	local var_25_4 = {}
	local var_25_5 = arg_25_0._tf

	var_25_4[1] = var_7.Find(var_25_5, "bg")
	var_25_3.pbList = var_25_4

	var_25_1(var_25_0, var_25_2, var_25_3)

	return
end

function var_0_1.unBlurView(arg_26_0)
	arg_26_0:UnOverlayPanel(arg_26_0._tf, arg_26_0._parentTf)

	return
end

function var_0_1.IsSupplyShop(arg_27_0)
	return false
end

function var_0_1.reUpdateAll(arg_28_0)
	arg_28_0:updateData()
	arg_28_0:updateScrollRect()

	return
end

function var_0_1.ShowPanel(arg_29_0, arg_29_1)
	setActive = var_1_10002

	var_1_10002(arg_29_0._go, arg_29_1)

	return
end

return var_0_1
