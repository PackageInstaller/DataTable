class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandShopWindowLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SixthAnniversaryIslandGoodsWindow"
end

function var_0_1.setGoods(arg_2_0, arg_2_1)
	arg_2_0.goods = arg_2_1

	local var_2_0 = arg_2_1

	arg_2_0.singleCost = arg_2_1.getConfig(var_2_0, "resource_num")
	math = var_2

	local var_2_1 = var_2.floor

	Drop = var_2_0

	local var_2_2 = var_2_0.New({
		type = arg_2_1:getConfig("resource_category"),
		id = arg_2_1:getConfig("resource_type")
	})

	arg_2_0.max = var_2_1(var_3.getOwnedCount(var_2_2) / arg_2_0.singleCost)

	if arg_2_1:getConfig("num_limit") ~= 0 then
		math = var_2

		local var_2_3 = var_2.min
		local var_2_4 = arg_2_0.max

		math = var_4
		arg_2_0.max = var_2_3(var_2_4, var_4.max(arg_2_1:GetPurchasableCnt(), 0))
	end

	return
end

function var_0_1.init(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_1.Find(var_3_1, "content/calc")

	setText = var_3_1

	local var_3_3 = var_3_2
	local var_3_4 = var_3_2.Find(var_3_3, "cost/Text")

	i18n = var_3_3

	var_3_1(var_3_4, var_3_3("islandshop_tips3"))

	arg_3_0.rtCost = var_3_2:Find("cost/number")
	arg_3_0.rtCount = var_3_2:Find("dashboard/view/Text")
	onButton = var_2

	local var_3_5 = arg_3_0
	local var_3_6 = var_3_2:Find("dashboard/minus_10")

	local function var_3_7()
		local var_4_0 = arg_3_0

		var_0.updateCount(var_4_0, -10)

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_5, var_3_6, var_3_7, var_6)

	onButton = var_2

	local var_3_8 = arg_3_0
	local var_3_9 = var_3_2:Find("dashboard/plus_10")

	local function var_3_10()
		local var_5_0 = arg_3_0

		var_0.updateCount(var_5_0, 10)

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_8, var_3_9, var_3_10, var_6)

	onButton = var_2

	local var_3_11 = arg_3_0
	local var_3_12 = var_3_2:Find("dashboard/view/minus")

	local function var_3_13()
		local var_6_0 = arg_3_0

		var_0.updateCount(var_6_0, -1)

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_11, var_3_12, var_3_13, var_6)

	onButton = var_2

	local var_3_14 = arg_3_0
	local var_3_15 = var_3_2:Find("dashboard/view/plus")

	local function var_3_16()
		local var_7_0 = arg_3_0

		var_0.updateCount(var_7_0, 1)

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_14, var_3_15, var_3_16, var_6)

	onButton = var_2

	local var_3_17 = arg_3_0
	local var_3_18 = var_3_2:Find("dashboard/plus_max")

	local function var_3_19()
		local var_8_0 = arg_3_0

		var_0.updateCount(var_8_0, arg_3_0.max - arg_3_0.count)

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_17, var_3_18, var_3_19, var_6)

	onButton = var_2

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0._tf
	local var_3_22 = var_4.Find(var_3_21, "bg")

	local function var_3_23()
		local var_9_0 = arg_3_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_6

	var_2(var_3_20, var_3_22, var_3_23, var_6)

	onButton = var_2

	local var_3_24 = arg_3_0
	local var_3_25 = arg_3_0._tf
	local var_3_26 = var_4.Find(var_3_25, "content/bottom/btn_cancel")

	local function var_3_27()
		local var_10_0 = arg_3_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_CANCEL = var_6

	var_2(var_3_24, var_3_26, var_3_27, var_6)

	onButton = var_2

	local var_3_28 = arg_3_0
	local var_3_29 = arg_3_0._tf
	local var_3_30 = var_4.Find(var_3_29, "content/bottom/btn_confirm")

	local function var_3_31()
		if arg_3_0.count > arg_3_0.max then
			pg = var_0

			local var_11_0 = var_0.TipsMgr.GetInstance()
			local var_11_1 = var_0.ShowTips

			i18n = var_2_10002

			local var_11_2 = "islandshop_tips4"

			Drop = var_2_10004

			local var_11_3 = var_2_10004.New
			local var_11_4 = {}
			local var_11_5 = arg_3_0.goods

			var_11_4.type = var_6.getConfig(var_11_5, "resource_category")

			local var_11_6 = arg_3_0.goods

			var_11_4.id = var_6.getConfig(var_11_6, "resource_type")

			local var_11_7 = var_11_3(var_11_4)

			var_11_1(var_11_0, var_2_10002(var_11_2, var_4.getName(var_11_7)))

			return
		end

		local var_11_8 = arg_3_0
		local var_11_9 = var_0.emit

		SixthAnniversaryIslandShopWindowMediator = var_2_10002

		var_11_9(var_11_8, var_2_10002.SHOPPING_CONFIRM, arg_3_0.count)

		return
	end

	SFX_CANCEL = var_6

	var_2(var_3_28, var_3_30, var_3_31, var_6)

	return
end

function var_0_1.updateCount(arg_12_0, arg_12_1)
	math = var_1_10002

	local var_12_0 = var_1_10002.clamp
	local var_12_1 = arg_12_0.count + arg_12_1
	local var_12_2 = 1

	math = var_1_10005
	arg_12_0.count = var_12_0(var_12_1, var_12_2, var_1_10005.max(arg_12_0.max, 1))
	setText = var_2

	var_2(arg_12_0.rtCount, arg_12_0.count)

	setText = var_2

	var_2(arg_12_0.rtCost, arg_12_0.count * arg_12_0.singleCost)

	return
end

function var_0_1.didEnter(arg_13_0)
	local var_13_0 = arg_13_0.goods
	local var_13_1 = {
		type = var_13_0:getConfig("commodity_type"),
		id = var_13_0:getConfig("commodity_id"),
		count = var_13_0:getConfig("num")
	}
	local var_13_2 = arg_13_0._tf
	local var_13_3 = var_3.Find(var_13_2, "content/main")

	updateDrop = var_13_2

	var_13_2(var_13_3:Find("icon/IconTpl"), var_13_1)

	local var_13_4, var_13_5 = var_13_1:getOwnedCount()

	setActive = var_6

	var_6(var_13_3:Find("owner"), var_13_5)

	if var_13_5 then
		setText = var_6

		local var_13_6 = var_13_3
		local var_13_7 = var_13_3.Find(var_13_6, "owner")

		i18n = var_13_6

		var_6(var_13_7, var_13_6("word_own1") .. var_13_4)
	end

	setText = var_6

	var_6(var_13_3:Find("line/name"), var_13_1:getConfig("name"))

	setText = var_6

	local var_13_8 = var_13_3
	local var_13_9 = var_13_3.Find(var_13_8, "line/content/Text")

	string = var_13_8

	local var_13_10 = var_13_8.gsub
	local var_13_11

	if not var_13_1.desc then
		var_13_11 = var_13_1:getConfig("desc")
	end

	var_6(var_13_9, var_13_10(var_13_11, "<[^>]+>", ""))

	GetImageSpriteFromAtlasAsync = var_6
	Drop = var_13_9

	local var_13_12 = var_13_9.New({
		type = var_13_0:getConfig("resource_category"),
		id = var_13_0:getConfig("resource_type")
	})
	local var_13_13 = var_7.getIcon(var_13_12)
	local var_13_14 = ""
	local var_13_15 = arg_13_0._tf

	var_6(var_13_13, var_13_14, var_9.Find(var_13_15, "content/calc/cost/icon"))

	arg_13_0.count = 1

	arg_13_0:updateCount(0)

	return
end

function var_0_1.willExit(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf)

	return
end

return var_0_1
