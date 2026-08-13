class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandShopLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SixthAnniversaryIslandShopUI"
end

function var_0_1.setShop(arg_2_0, arg_2_1)
	arg_2_0.shop = arg_2_1

	local var_2_0 = arg_2_1

	arg_2_0.goodsList = arg_2_1.getSortGoods(var_2_0)
	getProxy = var_2
	ActivityProxy = var_2_0

	local var_2_1 = var_2(var_2_0)

	arg_2_0.activity = var_2.getActivityById(var_2_1, arg_2_1.activityId)

	return
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.player = arg_3_1
	setText = var_1_10002

	local var_3_0 = arg_3_0.rtRes
	local var_3_1 = var_3.Find(var_3_0, "Text")
	local var_3_2 = arg_3_0.player
	local var_3_3

	if not var_4.getResById(var_3_2, 350) then
		var_3_3 = 0
	end

	var_1_10002(var_3_1, var_3_3)

	return
end

function var_0_1.init(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_1.Find(var_4_1, "main")

	setText = var_4_1

	local var_4_3 = var_4_2
	local var_4_4 = var_4_2.Find(var_4_3, "time/Text")

	i18n = var_4_3

	var_4_1(var_4_4, var_4_3("islandshop_tips1"))

	arg_4_0.rtTime = var_4_2:Find("time/Text_2")
	arg_4_0.rtRes = var_4_2:Find("tpl")

	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_2.Find(var_4_5, "main/view/content")

	UIItemList = var_4_5
	arg_4_0.goodsItemList = var_4_5.New(var_4_6, var_4_6:Find("goods"))

	local var_4_7 = arg_4_0.goodsItemList

	var_3.make(var_4_7, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0.goodsCardDic

			var_5_0[arg_4_0.goodsList[arg_5_1].id] = arg_5_2
			onButton = var_5_0

			local var_5_1 = arg_4_0
			local var_5_2 = arg_5_2

			local function var_5_3()
				local var_6_0 = arg_4_0
				local var_6_1 = var_0.emit

				SixthAnniversaryIslandShopMediator = var_3_10002

				var_6_1(var_6_0, var_3_10002.OPEN_GOODS_WINDOW, arg_4_0.goodsList[arg_5_1])

				return
			end

			SFX_PANEL = var_2_10007

			var_5_0(var_5_1, var_5_2, var_5_3, var_2_10007)

			local var_5_4 = arg_4_0

			var_3.updateGoodsCard(var_5_4, arg_5_2, arg_4_0.goodsList[arg_5_1])
		end

		return
	end)

	onButton = var_3

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0._tf
	local var_4_10 = var_5.Find(var_4_9, "bg")

	local function var_4_11()
		local var_7_0 = arg_4_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_4_8, var_4_10, var_4_11, var_7)

	onButton = var_3

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0._tf
	local var_4_14 = var_5.Find(var_4_13, "main/btn_back")

	local function var_4_15()
		local var_8_0 = arg_4_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_4_12, var_4_14, var_4_15, var_7)

	return
end

function var_0_1.updateGoodsCard(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2
	local var_9_1 = arg_9_2.CheckCntLimit(var_9_0)

	setActive = var_9_0

	var_9_0(arg_9_1:Find("mask"), not var_9_1)

	local var_9_2, var_9_3

	if var_9_1 then
		::label_9_0::

		var_9_2 = arg_9_2
		var_9_3 = not arg_9_2.CheckArgLimit(var_9_2)
	end

	setGray = var_9_2

	var_9_2(arg_9_1, var_9_3)

	local var_9_4 = arg_9_2
	local var_9_5 = arg_9_2.GetConsume(var_9_4)

	setActive = var_9_4

	var_9_4(arg_9_1:Find("btn_unable"), var_9_5:getOwnedCount() < var_9_5.count)

	setButtonEnabled = var_9_4

	var_9_4(arg_9_1, var_9_1)

	local var_9_6 = {
		type = arg_9_2:getConfig("commodity_type"),
		id = arg_9_2:getConfig("commodity_id"),
		count = arg_9_2:getConfig("num")
	}

	updateDrop = var_7

	var_7(arg_9_1:Find("icon/IconTpl"), var_9_6)

	onNextTick = var_7

	var_7(function()
		changeToScrollText = var_2_10000

		local var_10_0 = arg_9_1
		local var_10_1 = var_1.Find(var_10_0, "Text")
		local var_10_2 = var_9_6

		var_2_10000(var_10_1, var_2.getConfig(var_10_2, "name"))

		return
	end)

	GetImageSpriteFromAtlasAsync = var_7
	Drop = var_8

	local var_9_7 = var_8.New({
		type = arg_9_2:getConfig("resource_category"),
		id = arg_9_2:getConfig("resource_type")
	})

	var_7(var_8.getIcon(var_9_7), "", arg_9_1:Find("res_icon"))

	setText = var_7

	var_7(arg_9_1:Find("btn_pay/cost"), arg_9_2:getConfig("resource_num"))

	setText = var_7

	var_7(arg_9_1:Find("btn_unable/cost"), arg_9_2:getConfig("resource_num"))

	local var_9_8 = arg_9_2

	if arg_9_2.getConfig(var_9_8, "num_limit") == 0 then
		setText = var_9_8

		local var_9_9 = arg_9_1
		local var_9_10 = arg_9_1.Find(var_9_9, "limit")

		i18n = var_9_9

		var_9_8(var_9_10, var_9_9("common_no_limit"))
	else
		setText = var_9_8

		local var_9_11 = arg_9_1
		local var_9_12 = arg_9_1.Find(var_9_11, "limit")

		i18n = var_9_11

		local var_9_13 = var_9_11("islandshop_tips2")

		math = var_11

		var_9_8(var_9_12, var_9_13 .. var_11.max(arg_9_2:GetPurchasableCnt(), 0) .. "/" .. var_7)
	end

	return
end

function var_0_1.refreshGoodsCard(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.updateGoodsCard
	local var_11_2 = arg_11_0.goodsCardDic[arg_11_1]
	local var_11_3 = arg_11_0.shop

	var_11_1(var_11_0, var_11_2, var_5.getGoodsById(var_11_3, arg_11_1))

	return
end

function var_0_1.didEnter(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()

	Timer = var_1_10002
	arg_12_0.timer = var_1_10002.New(function()
		local var_13_0 = arg_12_0
		local var_13_3

		if not arg_12_0.delta or not (arg_12_0.delta - 1) then
			local var_13_1 = arg_12_0.activity.stopTime
			local var_13_2 = var_12_0

			var_13_3 = var_13_1 - var_2_10002.GetServerTime(var_13_2)
		end

		var_13_0.delta = var_13_3
		string = var_13_0

		local var_13_4 = var_13_0.format
		local var_13_5 = "%d"

		i18n = var_2_10002

		local var_13_6 = var_2_10002("word_date")
		local var_13_7 = "%d"

		i18n = var_2_10004

		local var_13_8 = var_13_5 .. var_13_6 .. var_13_7 .. var_2_10004("word_hour")
		local var_13_9 = var_12_0
		local var_13_10 = var_13_4(var_13_8, var_2.parseTimeFrom(var_13_9, arg_12_0.delta))

		if arg_12_0.strTime ~= var_13_10 then
			setText = var_1

			var_1(arg_12_0.rtTime, var_13_10)
		end

		return
	end, 1)

	arg_12_0.timer.func()

	local var_12_1 = arg_12_0.timer

	var_2.Start(var_12_1)

	arg_12_0.goodsCardDic = {}

	local var_12_2 = arg_12_0.goodsItemList

	var_2.align(var_12_2, #arg_12_0.goodsList)

	return
end

function var_0_1.willExit(arg_14_0)
	local var_14_0 = arg_14_0.timer

	var_1.Stop(var_14_0)

	pg = var_1

	local var_14_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_1, arg_14_0._tf)

	return
end

return var_0_1
