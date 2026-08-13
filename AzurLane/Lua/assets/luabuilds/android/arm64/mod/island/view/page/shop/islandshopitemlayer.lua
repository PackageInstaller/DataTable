class = var_0_10000

local var_0_0 = "IslandShopItemLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShopItemUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.panel = var_1.Find(var_2_0, "panel")

	local var_2_1 = arg_2_0.panel

	arg_2_0.closeBtn = var_1.Find(var_2_1, "closeBtn")

	local var_2_2 = arg_2_0.panel

	arg_2_0.icon = var_1.Find(var_2_2, "icon")

	local var_2_3 = arg_2_0.panel

	arg_2_0.discount = var_1.Find(var_2_3, "discount")

	local var_2_4 = arg_2_0.panel

	arg_2_0.remainTimer = var_1.Find(var_2_4, "remainTimer")

	local var_2_5 = arg_2_0.panel

	arg_2_0.name = var_1.Find(var_2_5, "name")

	local var_2_6 = arg_2_0.panel

	arg_2_0.desc = var_1.Find(var_2_6, "desc")

	local var_2_7 = arg_2_0.panel

	arg_2_0.buyDesc = var_1.Find(var_2_7, "buyDesc")

	local var_2_8 = arg_2_0.panel

	arg_2_0.count = var_1.Find(var_2_8, "count/number_panel/value")

	local var_2_9 = arg_2_0.panel

	arg_2_0.leftBtn = var_1.Find(var_2_9, "count/left")

	local var_2_10 = arg_2_0.panel

	arg_2_0.rightBtn = var_1.Find(var_2_10, "count/right")

	local var_2_11 = arg_2_0.panel

	arg_2_0.minBtn = var_1.Find(var_2_11, "count/min")

	local var_2_12 = arg_2_0.panel

	arg_2_0.maxBtn = var_1.Find(var_2_12, "count/max")
	UIItemList = var_1

	local var_2_13 = var_1.New
	local var_2_14 = arg_2_0.panel
	local var_2_15 = var_3.Find(var_2_14, "itemList/Viewport/Content")
	local var_2_16 = arg_2_0.panel

	arg_2_0.bottomItemList = var_2_13(var_2_15, var_4.Find(var_2_16, "itemList/Viewport/Content/IslandItemTpl"))

	local var_2_17 = arg_2_0.panel

	arg_2_0.buyBtn = var_1.Find(var_2_17, "buyBtn")

	local var_2_18 = arg_2_0.buyBtn

	arg_2_0.consumeIcon = var_1.Find(var_2_18, "consume/icon")

	local var_2_19 = arg_2_0.buyBtn

	arg_2_0.consumeCount = var_1.Find(var_2_19, "consume/count")
	setText = var_1

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "panel/title")

	i18n = var_4

	var_1(var_2_21, var_4("island_3Dshop_buy_confirm"))

	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "panel/buyBtn/text")

	i18n = var_4

	var_1(var_2_23, var_4("island_3Dshop_buy"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_3.Find(var_2_24, "panel/getDesc")

	i18n = var_4

	var_1(var_2_25, var_4("island_3Dshop_buy_tip0"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_4.Find(var_3_4, "bg")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_4

	var_1_10001(var_3_3, var_3_5, var_3_6, var_3_4)

	return
end

function var_0_1.SetUp(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.charaId then
		GetImageSpriteFromAtlasAsync = var_3

		var_3("island/islandshipiconall/" .. arg_6_0.charaId, "", arg_6_0.icon)
	else
		GetImageSpriteFromAtlasAsync = var_3

		var_3(arg_6_2:GetIcon(), "", arg_6_0.icon)
	end

	setText = var_3

	var_3(arg_6_0.name, arg_6_2:GetName())

	setText = var_3

	var_3(arg_6_0.desc, arg_6_2:GetDescription())

	setActive = var_3

	var_3(arg_6_0.discount, arg_6_2:GetDiscount() ~= 0)

	setText = var_3

	local var_6_0 = arg_6_0.discount

	var_3(var_5.Find(var_6_0, "Text"), "-" .. arg_6_2:GetDiscount() .. "%")

	local var_6_1 = arg_6_2
	local var_6_2 = arg_6_2.IsTimeLimitCommodity(var_6_1)

	setActive = var_1_10004

	var_1_10004(arg_6_0.remainTimer, var_6_2)

	if var_6_2 then
		var_1_10004 = arg_6_2:getConfig("time")[2]
		pg = var_6_1

		local var_6_3 = var_6_1.TimeMgr.GetInstance()
		local var_6_4 = var_5.Table2ServerTime(var_6_3, {
			year = var_1_10004[1][1],
			month = var_1_10004[1][2],
			day = var_1_10004[1][3],
			hour = var_1_10004[2][1],
			min = var_1_10004[2][2],
			sec = var_1_10004[2][3]
		})
		local var_6_5 = 0

		arg_6_0:StartTimer(function()
			pg = var_2_10000

			local var_7_0 = var_2_10000.TimeMgr.GetInstance()
			local var_7_1 = var_0.GetServerTime(var_7_0)
			local var_7_3

			if var_6_4 - var_7_1 < var_6_5 then
				pg = var_7_3

				local var_7_2 = var_7_3.TimeMgr.GetInstance()

				var_7_3 = var_7_3.DescCDTime(var_7_2, var_1)
				setText = var_2_10003

				local var_7_4 = arg_6_0.remainTimer

				var_2_10003(var_2_10005.Find(var_7_4, "text"), var_7_3)
			else
				setText = var_7_3

				local var_7_5 = arg_6_0.remainTimer
				local var_7_6 = var_4.Find(var_7_5, "text")

				i18n = var_2_10005

				local var_7_7 = "island_3Dshop_goods_time"

				math = var_2_10008

				var_7_3(var_7_6, var_2_10005(var_7_7, var_2_10008.floor(var_1 / var_6_5)))
			end

			return
		end)
	end

	i18n = var_1_10004

	local var_6_6 = var_1_10004("island_3Dshop_buy_no")
	local var_6_8

	if arg_6_2:GetMaxNum() ~= 0 then
		local var_6_7 = arg_6_2

		var_6_8 = arg_6_2.GetMaxNum(var_6_7) - arg_6_2.purchasedNum

		local var_6_9 = var_6_6

		i18n = var_6_7
		var_6_6 = var_6_9 .. var_6_7("island_3Dshop_last", var_6_8)
	end

	setText = var_6_8

	var_6_8(arg_6_0.buyDesc, var_6_6)

	local var_6_10 = arg_6_2:GetMaxNum() - arg_6_2.purchasedNum

	if arg_6_2:GetMaxNum() == 0 then
		var_6_10 = 999
	end

	local var_6_11 = arg_6_2:GetResourceConsume()
	local var_6_12 = (100 - arg_6_2:GetDiscount()) / 100 * var_6_11[3]
	local var_6_13 = 1
	local var_6_14 = var_6_11[1]
	local var_6_15 = var_6_11[2]

	DROP_TYPE_RESOURCE = var_1_10011

	if var_6_14 == var_1_10011 then
		getProxy = var_1_10011
		PlayerProxy = var_1_10013
		var_1_10013 = var_1_10011(var_1_10013)
		var_1_10011 = var_1_10011.getRawData(var_1_10013)

		if var_6_15 == 1 then
			local var_6_16 = var_1_10011.gold

			math = var_1_10013
			var_6_13 = var_1_10013.floor(var_6_16 / var_6_12)
		elseif var_6_15 == 4 or var_6_15 == 14 then
			local var_6_17 = var_1_10011:getTotalGem()

			math = var_1_10013
			var_6_13 = var_1_10013.floor(var_6_17 / var_6_12)
		end
	else
		DROP_TYPE_ISLAND_ITEM = var_1_10011

		if var_6_14 == var_1_10011 then
			getProxy = var_1_10011
			IslandProxy = var_1_10013

			local var_6_18 = var_1_10011(var_1_10013)
			local var_6_19 = var_1_10011.GetIsland(var_6_18)
			local var_6_20 = var_1_10011.GetInventoryAgency(var_6_19)
			local var_6_21 = var_1_10011.GetOwnCount(var_6_20, var_6_15)

			math = var_6_19
			var_6_13 = var_6_19.floor(var_6_21 / var_6_12)
		end
	end

	math = var_1_10011

	local var_6_22 = var_1_10011.clamp(var_6_13, 1, var_6_10)
	local var_6_23 = arg_6_2
	local var_6_24 = arg_6_2.GetItemsWithPt(var_6_23)

	local function var_6_25(arg_8_0)
		math = var_2_10001
		arg_8_0 = var_2_10001.clamp(arg_8_0, 1, var_6_22)

		local var_8_0 = arg_6_0

		var_8_0.curCount = arg_8_0
		setText = var_8_0

		var_8_0(arg_6_0.count, arg_8_0)

		for iter_8_0 = 1, #arg_6_0.itemsCountTFs do
			local var_8_1 = arg_6_0.itemsCountTFs[iter_8_0]

			setText = var_2_10006

			var_2_10006(var_8_1, var_6_24[iter_8_0][3] * arg_6_0.curCount)
		end

		setText = var_1

		local var_8_2 = arg_6_0.consumeCount

		math = iter_8_0

		var_1(var_8_2, iter_8_0.ceil(var_6_12 * arg_6_0.curCount))

		return
	end

	pressPersistTrigger = var_6_23

	local var_6_26 = arg_6_0.leftBtn
	local var_6_27 = 0.5

	local function var_6_28(arg_9_0)
		var_6_25(arg_6_0.curCount - 1)

		return
	end

	local var_6_29
	local var_6_30 = true
	local var_6_31 = true
	local var_6_32 = 0.1

	SFX_PANEL = var_1_10022

	var_6_23(var_6_26, var_6_27, var_6_28, var_6_29, var_6_30, var_6_31, var_6_32, var_1_10022)

	pressPersistTrigger = var_6_23

	local var_6_33 = arg_6_0.rightBtn
	local var_6_34 = 0.5

	local function var_6_35(arg_10_0)
		var_6_25(arg_6_0.curCount + 1)

		return
	end

	local var_6_36
	local var_6_37 = true
	local var_6_38 = true
	local var_6_39 = 0.1

	SFX_PANEL = var_1_10022

	var_6_23(var_6_33, var_6_34, var_6_35, var_6_36, var_6_37, var_6_38, var_6_39, var_1_10022)

	pressPersistTrigger = var_6_23

	local var_6_40 = arg_6_0.minBtn
	local var_6_41 = 0.5

	local function var_6_42(arg_11_0)
		var_6_25(arg_6_0.curCount - 10)

		return
	end

	local var_6_43
	local var_6_44 = true
	local var_6_45 = true
	local var_6_46 = 0.1

	SFX_PANEL = var_1_10022

	var_6_23(var_6_40, var_6_41, var_6_42, var_6_43, var_6_44, var_6_45, var_6_46, var_1_10022)

	pressPersistTrigger = var_6_23

	local var_6_47 = arg_6_0.maxBtn
	local var_6_48 = 0.5

	local function var_6_49(arg_12_0)
		var_6_25(arg_6_0.curCount + 10)

		return
	end

	local var_6_50
	local var_6_51 = true
	local var_6_52 = true
	local var_6_53 = 0.1

	SFX_PANEL = var_1_10022

	var_6_23(var_6_47, var_6_48, var_6_49, var_6_50, var_6_51, var_6_52, var_6_53, var_1_10022)

	arg_6_0.itemsCountTFs = {}

	local var_6_54 = arg_6_0.bottomItemList

	var_13.make(var_6_54, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_6_24[arg_13_1 + 1]
			local var_13_1 = {
				type = var_13_0[1],
				id = var_13_0[2],
				count = var_13_0[3]
			}

			updateCustomDrop = var_5

			var_5(arg_13_2, var_13_1, {
				style = "island"
			})

			table = var_5

			var_5.insert(arg_6_0.itemsCountTFs, arg_13_2:Find("icon_bg/count_bg/count"))
		end

		return
	end)

	local var_6_55 = arg_6_0.bottomItemList

	var_13.align(var_6_55, #var_6_24)
	var_6_25(1)

	local var_6_56 = var_6_11[1]

	DROP_TYPE_RESOURCE = var_14

	if var_6_56 == var_14 then
		GetImageSpriteFromAtlasAsync = var_6_56
		Drop = var_15

		local var_6_57 = var_15.New({
			type = var_6_11[1],
			id = var_6_11[2]
		})

		var_6_56(var_15.getIcon(var_6_57), "", arg_6_0.consumeIcon)
	else
		var_6_56 = var_6_11[1]
		DROP_TYPE_ISLAND_ITEM = var_14

		if var_6_56 == var_14 then
			GetImageSpriteFromAtlasAsync = var_6_56
			Drop = var_15

			local var_6_58 = var_15.New({
				type = var_6_11[1],
				id = var_6_11[2]
			})

			var_6_56(var_15.getIcon(var_6_58), "", arg_6_0.consumeIcon)
		end
	end

	onButton = var_6_56

	local var_6_59 = arg_6_0
	local var_6_60 = arg_6_0.buyBtn

	local function var_6_61()
		local var_14_0 = {
			{
				key = arg_6_1,
				value1 = arg_6_2.id,
				value2 = arg_6_0.curCount
			}
		}
		local var_14_1 = arg_6_0
		local var_14_2 = var_1.emit

		IslandMediator = var_2_10004

		var_14_2(var_14_1, var_2_10004.BUY_COMMODITY, var_14_0)

		return
	end

	SFX_PANEL = var_6_50

	var_6_56(var_6_59, var_6_60, var_6_61, var_6_50)

	return
end

function var_0_1.AddListeners(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.AddListener

	GAME = var_1_10004

	var_15_1(var_15_0, var_1_10004.ISLAND_SHOP_OP_DONE, arg_15_0.Hide)

	return
end

function var_0_1.RemoveListeners(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.RemoveListener

	GAME = var_1_10004

	var_16_1(var_16_0, var_1_10004.ISLAND_SHOP_OP_DONE, arg_16_0.Hide)

	return
end

function var_0_1.OnShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0:BlurPanel(arg_17_0._tf)

	arg_17_0.shopId = arg_17_1
	arg_17_0.commodity = arg_17_2

	arg_17_0:SetUp(arg_17_1, arg_17_2)

	if arg_17_3 then
		arg_17_0.charaId = arg_17_3
	end

	return
end

function var_0_1.Refresh(arg_18_0)
	arg_18_0:SetUp(arg_18_0.shopId, arg_18_0.commodity)

	return
end

function var_0_1.StartTimer(arg_19_0, arg_19_1)
	Timer = var_1_10002
	arg_19_0.timer = var_1_10002.New(arg_19_1, 1, -1)

	local var_19_0 = arg_19_0.timer

	var_2.Start(var_19_0)

	return
end

function var_0_1.RemoveTimer(arg_20_0)
	if arg_20_0.timer then
		local var_20_0 = arg_20_0.timer

		var_1.Stop(var_20_0)

		arg_20_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_21_0)
	arg_21_0:RemoveTimer()
	arg_21_0:UnOverlayPanel(arg_21_0._tf, arg_21_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_22_0)
	return
end

return var_0_1
