class = var_0_10000

local var_0_0 = "IslandSeasonShopPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonShopPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "content")

	arg_2_0.lockTF = var_1.Find(var_2_1, "view/lock")
	setText = var_2

	local var_2_2 = var_1:Find("view/content/tpl/sellOut/Text")

	i18n = var_5

	var_2(var_2_2, var_5("common_sale_out"))

	local var_2_3 = var_1:Find("res/Text")
	local var_2_4 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_2_0.resCntTxt = var_2_4(var_2_3, var_5(var_7))
	UIItemList = var_2
	arg_2_0.goodUIList = var_2.New(var_1:Find("view/content"), var_1:Find("view/content/tpl"))

	local var_2_5 = var_1:Find("toggles")

	UIItemList = var_2_0
	arg_2_0.togglesUIList = var_2_0.New(var_2_5, var_2_5:Find("tpl"))

	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0.contextData.season

	arg_3_0.shopIds = var_1.getConfig(var_3_0, "shop_id")

	local var_3_1 = arg_3_0.togglesUIList

	var_1.make(var_3_1, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventInit then
			local function var_4_0()
				setActive = var_3_10000

				local var_5_0 = arg_4_2
				local var_5_1 = var_2.Find(var_5_0, "red")

				IslandSeasonRedDotHelper = var_3_10003

				var_3_10000(var_5_1, var_3_10003.TipShopShowPhase(arg_4_1 + 1))

				return
			end

			arg_4_2.name = arg_4_1 + 1
			setText = var_4

			local var_4_1 = arg_4_2:Find("unsel/Text")

			i18n = var_2_10007

			var_4(var_4_1, var_2_10007("island_season_shop_stage" .. arg_4_1 + 1))

			setText = var_4

			local var_4_2 = arg_4_2:Find("sel/Text")

			i18n = var_7

			var_4(var_4_2, var_7("island_season_shop_stage" .. arg_4_1 + 1))

			onToggle = var_4

			local var_4_3 = arg_3_0
			local var_4_4 = arg_4_2

			local function var_4_5(arg_6_0)
				if arg_6_0 then
					arg_3_0.showPhase = arg_4_1 + 1

					local var_6_0 = arg_3_0

					var_1.Flush(var_6_0)
					var_4_0()
				end

				return
			end

			SFX_PANEL = var_9

			var_4(var_4_3, var_4_4, var_4_5, var_9)
			var_4_0()
		end

		return
	end)

	local var_3_2 = arg_3_0.togglesUIList

	var_1.align(var_3_2, #arg_3_0.shopIds)

	local var_3_3 = arg_3_0.goodUIList

	var_1.make(var_3_3, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_3_0

			var_3.UpdateGood(var_7_0, arg_7_1, arg_7_2)
		end

		return
	end)

	return
end

function var_0_1.Show(arg_8_0)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.showPhase = 1
	triggerToggle = var_1

	local var_8_0 = arg_8_0.togglesUIList.container

	var_1(var_3.GetChild(var_8_0, 0), true)

	IslandGuideChecker = var_1

	var_1.CheckGuide("ISLAND_GUIDE_18")

	return
end

function var_0_1.UpdateGood(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2.name = arg_9_0.displaysGoods[arg_9_1 + 1].id
	IslandShopPage = var_4

	var_4.StaticUpdateCommodityTpl(arg_9_2, var_3)

	setActive = var_4

	local var_9_0 = arg_9_2:Find("notInTime")
	local var_9_1 = arg_9_0.displayShop

	var_4(var_9_0, not var_7.IsInTime(var_9_1))

	isActive = var_4

	if not var_4(arg_9_2:Find("sellOut")) then
		isActive = var_4

		if not var_4(arg_9_2:Find("hold")) then
			isActive = var_4

			if var_4(arg_9_2:Find("notInTime")) then
				removeOnButton = var_4

				var_4(arg_9_2)
			else
				onButton = var_4

				local var_9_2 = arg_9_0
				local var_9_3 = arg_9_2

				local function var_9_4()
					arg_9_0.contextData.openBuyLayer(arg_9_0.displayShop.id, var_0)

					return
				end

				SFX_PANEL = var_9

				var_4(var_9_2, var_9_3, var_9_4, var_9)
			end

			return
		end
	end
end

function var_0_1.Flush(arg_11_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.GetIsland(var_11_0)

	arg_11_0.inventoryAgency = var_1.GetInventoryAgency(var_11_1)
	getProxy = var_1
	IslandProxy = var_11_1

	local var_11_2 = var_1(var_11_1)
	local var_11_3 = var_1.GetIsland(var_11_2)
	local var_11_4 = var_1.GetShopAgency(var_11_3)

	arg_11_0.shops = var_1.GetSeasonShops(var_11_4)

	local var_11_5 = arg_11_0.shopIds
	local var_11_6

	if not arg_11_0.showPhase then
		var_11_6 = 1
	end

	local var_11_7 = var_11_5[var_11_6]

	arg_11_0.displayShop = arg_11_0.shops[var_11_7]
	IslandSeasonRedDotHelper = var_2

	var_2.UpdateEnterShopPhase(arg_11_0.showPhase)

	local var_11_8 = arg_11_0
	local var_11_9 = arg_11_0.emit

	IslandSeasonPage = var_1_10005

	local var_11_10 = var_1_10005.UPDATE_REDDOT

	IslandSeasonPage = var_1_10006

	var_11_9(var_11_8, var_11_10, var_1_10006.PAGE_SHOP)

	pg = var_11_9

	local var_11_11 = var_11_9.TimeMgr.GetInstance()
	local var_11_12 = arg_11_0.displayShop
	local var_11_13 = var_3.GetExistTime(var_11_12)
	local var_11_14 = var_11_11:inTime(var_11_13)

	setActive = var_11_12

	var_11_12(arg_11_0.lockTF, not var_11_14)

	if not var_11_14 then
		local var_11_15 = var_11_11:DescDateFromConfig(var_11_13[1])
		local var_11_16 = "~"

		var_1_10009 = var_11_11

		local var_11_17 = var_11_15 .. var_11_16 .. var_11_11.DescDateFromConfig(var_1_10009, var_11_13[2])

		setText = var_11_16

		local var_11_18 = arg_11_0.lockTF

		var_11_16(var_8.Find(var_11_18, "layout/Text"), var_11_17)
	end

	local var_11_19 = arg_11_0.displayShop

	arg_11_0.displaysGoods = var_5.GetCommodities(var_11_19)
	IslandShopPage = var_5

	var_5.SortShopCommodities(arg_11_0.displaysGoods)

	local var_11_20 = arg_11_0.goodUIList

	var_5.align(var_11_20, #arg_11_0.displaysGoods)

	setActive = var_5

	local var_11_21 = arg_11_0.lockTF
	local var_11_22 = arg_11_0.displayShop

	var_5(var_11_21, not var_8.IsInTime(var_11_22))

	local var_11_23 = arg_11_0.resCntTxt
	local var_11_24 = arg_11_0.inventoryAgency
	local var_11_25 = var_6.GetOwnCount

	IslandItem = var_1_10009
	var_11_23.text = var_11_25(var_11_24, var_1_10009.GOLD_ID)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
