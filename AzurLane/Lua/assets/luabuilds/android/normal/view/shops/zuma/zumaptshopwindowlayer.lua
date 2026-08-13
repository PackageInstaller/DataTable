class = var_0_10000

local var_0_0 = "ZumaPTShopWindowLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ZumaPTShopWindowUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updateGoodInfoPanel()
	arg_3_0:updateBuyPanelWithNum(1)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0.pageUtil

	var_1.Dispose(var_4_1)

	return
end

function var_0_1.onBackPressed(arg_5_0)
	arg_5_0:closeView()

	return
end

function var_0_1.initData(arg_6_0)
	arg_6_0.actShopVO = arg_6_0.contextData.actShopVO
	arg_6_0.goodVO = arg_6_0.contextData.goodVO

	local var_6_0 = arg_6_0.goodVO

	arg_6_0.perCost = var_1.getConfig(var_6_0, "resource_num")
	math = var_1

	local var_6_1 = var_1.floor

	Drop = var_6_0

	local var_6_2 = var_6_0.New
	local var_6_3 = {}
	local var_6_4 = arg_6_0.goodVO

	var_6_3.type = var_4.getConfig(var_6_4, "resource_category")

	local var_6_5 = arg_6_0.goodVO

	var_6_3.id = var_4.getConfig(var_6_5, "resource_type")

	local var_6_6 = var_6_2(var_6_3)

	arg_6_0.maxBuyCount = var_6_1(var_2.getOwnedCount(var_6_6) / arg_6_0.perCost)

	local var_6_7 = arg_6_0.goodVO

	if var_1.getConfig(var_6_7, "num_limit") ~= 0 then
		math = var_1

		local var_6_8 = var_1.min
		local var_6_9 = arg_6_0.maxBuyCount

		math = var_3

		local var_6_10 = var_3.max
		local var_6_11 = arg_6_0.goodVO

		arg_6_0.maxBuyCount = var_6_8(var_6_9, var_6_10(var_4.GetPurchasableCnt(var_6_11), 0))
	end

	arg_6_0.curBuyCount = 1
	Drop = var_1

	local var_6_12 = var_1.New
	local var_6_13 = {}
	local var_6_14 = arg_6_0.goodVO

	var_6_13.type = var_3.getConfig(var_6_14, "resource_category")

	local var_6_15 = arg_6_0.goodVO

	var_6_13.id = var_3.getConfig(var_6_15, "resource_type")
	arg_6_0.costItemInfo = var_6_12(var_6_13)

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf
	local var_7_2 = var_1.Find(var_7_1, "Panel")
	local var_7_3 = var_1.Find(var_7_2, "Info")

	arg_7_0.nameText = var_2.Find(var_7_3, "Name/Text")
	arg_7_0.descText = var_2:Find("Desc")
	arg_7_0.itemTF = var_2:Find("CommonItemTemplate")
	arg_7_0.countTF = var_2:Find("Count")
	arg_7_0.countText = var_2:Find("Count/Num")

	local var_7_4 = var_2
	local var_7_5

	var_7_5, setText = var_2.Find(var_7_4, "Count/Tip"), var_7_4
	i18n = var_1_10006

	var_7_4(var_7_5, var_1_10006("word_own1"))

	arg_7_0.titleTF = var_1:Find("Title")

	local var_7_6 = var_1:Find("Buy")

	arg_7_0.minusBtn = var_4.Find(var_7_6, "Minus")
	arg_7_0.addBtn = var_4:Find("Add")
	arg_7_0.maxBtn = var_4:Find("Max")
	arg_7_0.buyNumText = var_4:Find("Num")
	arg_7_0.butCountText = var_1:Find("BuyCount/Num")
	arg_7_0.costNumText = var_1:Find("Cost/Num")
	arg_7_0.confirmBtn = var_1:Find("ConfirmBtn")
	arg_7_0.cancelBtn = var_1:Find("CancelBtn")

	return
end

function var_0_1.addListener(arg_8_0)
	local function var_8_0()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	onButton = var_1_10002

	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.bg
	local var_8_3 = var_8_0

	SFX_CANCEL = var_1_10006

	var_1_10002(var_8_1, var_8_2, var_8_3, var_1_10006)

	onButton = var_1_10002

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.cancelBtn
	local var_8_6 = var_8_0

	SFX_CANCEL = var_1_10006

	var_1_10002(var_8_4, var_8_5, var_8_6, var_1_10006)

	onButton = var_1_10002

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0.confirmBtn

	local function var_8_9()
		local var_10_1

		if arg_8_0.curBuyCount > arg_8_0.maxBuyCount then
			pg = var_10_1

			local var_10_0 = var_10_1.TipsMgr.GetInstance()

			var_10_1 = var_10_1.ShowTips
			i18n = var_2_10002

			local var_10_2 = "islandshop_tips4"
			local var_10_3 = arg_8_0.costItemInfo

			var_10_1(var_10_0, var_2_10002(var_10_2, var_4.getName(var_10_3)))

			return
		end

		pg = var_10_1

		local var_10_4 = var_10_1.m02
		local var_10_5 = var_0.sendNotification

		GAME = var_2_10002

		var_10_5(var_10_4, var_2_10002.ISLAND_SHOPPING, {
			shop = arg_8_0.actShopVO,
			arg1 = arg_8_0.goodVO.id,
			arg2 = arg_8_0.curBuyCount
		})

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10002(var_8_7, var_8_8, var_8_9, var_1_10006)

	PageUtil = var_1_10002
	arg_8_0.pageUtil = var_1_10002.New(arg_8_0.minusBtn, arg_8_0.addBtn, arg_8_0.maxBtn, arg_8_0.butCountText)

	local var_8_10 = arg_8_0.pageUtil

	var_2.setNumUpdate(var_8_10, function(arg_11_0)
		local var_11_0 = arg_8_0

		var_1.updateBuyPanelWithNum(var_11_0, arg_11_0)

		return
	end)

	local var_8_11 = arg_8_0.pageUtil

	var_2.setAddNum(var_8_11, 1)

	local var_8_12 = arg_8_0.pageUtil
	local var_8_13 = var_2.setMaxNum

	math = var_4

	var_8_13(var_8_12, var_4.max(arg_8_0.maxBuyCount, 1))

	local var_8_14 = arg_8_0.pageUtil

	var_2.setDefaultNum(var_8_14, 1)

	return
end

function var_0_1.updateGoodInfoPanel(arg_12_0)
	local var_12_0 = arg_12_0.goodVO

	Drop = var_1_10002

	local var_12_1 = var_1_10002.New({
		type = var_12_0:getConfig("commodity_type"),
		id = var_12_0:getConfig("commodity_id"),
		count = var_12_0:getConfig("num")
	})

	updateDrop = var_3

	var_3(arg_12_0.itemTF, var_12_1)

	local var_12_2, var_12_3 = var_12_1:getOwnedCount()

	setActive = var_5

	var_5(arg_12_0.countTF, var_12_3)

	if var_12_3 then
		setText = var_5

		var_5(arg_12_0.countText, var_12_2)
	end

	setText = var_5

	var_5(arg_12_0.nameText, var_12_1:getConfig("name"))

	setText = var_5

	local var_12_4 = arg_12_0.descText

	string = var_7

	local var_12_5 = var_7.gsub
	local var_12_6

	if not var_12_1.desc then
		var_12_6 = var_12_1:getConfig("desc")
	end

	var_5(var_12_4, var_12_5(var_12_6, "<[^>]+>", ""))

	return
end

function var_0_1.updateBuyPanelWithNum(arg_13_0, arg_13_1)
	arg_13_0.curBuyCount = arg_13_1 or 0
	setText = var_2

	var_2(arg_13_0.buyNumText, arg_13_0.curBuyCount)

	setText = var_2

	var_2(arg_13_0.butCountText, arg_13_0.curBuyCount)

	setText = var_2

	var_2(arg_13_0.costNumText, arg_13_0.curBuyCount * arg_13_0.perCost)

	return
end

return var_0_1
