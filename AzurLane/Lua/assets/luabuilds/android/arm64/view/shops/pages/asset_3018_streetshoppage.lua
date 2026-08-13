class = var_0_10000

local var_0_0 = "StreetShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShopPage"))

function var_0_1.GenTip(arg_1_0, arg_1_1)
	local var_1_0 = ""

	if #arg_1_1 == 1 then
		local var_1_1 = arg_1_1[1]

		i18n = var_1_10004
		var_1_0 = var_1_10004("shop_street_activity_tip", var_1_1:GetShopTime())
	elseif #arg_1_1 > 1 then
		var_1_0 = arg_1_0:GenTipForMultiAct(arg_1_1)
	end

	return var_1_0
end

function var_0_1.GenTipForMultiAct(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[1]
	local var_2_1 = var_2.getStartTime(var_2_0)
	local var_2_2 = var_2.stopTime

	_ = var_2_0

	local var_2_3 = var_2_0.all(arg_2_1, function(arg_3_0)
		return arg_3_0:getStartTime() == var_2_1
	end)

	_ = var_1_10006

	local var_2_4 = var_1_10006.all(arg_2_1, function(arg_4_0)
		return arg_4_0.stopTime == var_2_2
	end)
	local var_2_5 = var_2

	if not var_2_4 then
		table = var_8

		var_8.sort(arg_2_1, function(arg_5_0, arg_5_1)
			return arg_5_0.stopTime < arg_5_1.stopTime
		end)

		var_2_5 = arg_2_1[1]
	elseif not var_2_3 and var_2_4 then
		table = var_8

		var_8.sort(arg_2_1, function(arg_6_0, arg_6_1)
			return arg_6_0:getStartTime() < arg_6_1:getStartTime()
		end)

		var_2_5 = arg_2_1[1]
	end

	i18n = var_8

	return var_8("shop_street_activity_tip", var_2_5:GetShopTime())
end

function var_0_1.GenHelpContent(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:getConfig("config_data")

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(var_7_0) do
		local var_7_1 = iter_7_1[1]

		pg = var_1_10010
		var_1_10010 = var_1_10010.shop_template[var_7_1].effect_args[1]
		Item = var_1_10011
		var_1_10011 = var_1_10011.getConfigData(var_1_10010).name

		local var_7_2 = arg_7_2:GetShopTime()

		table = var_13

		local var_7_3 = var_13.insert
		local var_7_4 = arg_7_1

		i18n = var_1_10016

		var_7_3(var_7_4, var_1_10016("shop_street_Equipment_skin_box_help", var_1_10011, var_7_2))
	end

	return
end

function var_0_1.OnUpdatePlayer(arg_8_0)
	arg_8_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = arg_9_0.player
	local var_9_2 = var_2.getResource

	PlayerConst = var_1_10005

	local var_9_3 = var_9_2(var_9_1, var_1_10005.ResGold)

	table = var_1_10003

	local var_9_4 = var_1_10003.insert
	local var_9_5 = var_9_0
	local var_9_6 = {}

	DROP_TYPE_RESOURCE = var_1_10007
	var_9_6.type = var_1_10007
	PlayerConst = var_1_10007
	var_9_6.resID = var_1_10007.ResGold
	var_9_6.cnt = var_9_3

	var_9_4(var_9_5, var_9_6)

	return var_9_0
end

function var_0_1.OnSetUp(arg_10_0)
	arg_10_0:RemoveTimer()
	arg_10_0:AddTimer()

	return
end

function var_0_1.Hide(arg_11_0)
	var_0_1.super.Hide(arg_11_0)
	arg_11_0:RemoveTimer()

	return
end

function var_0_1.OnUpdateAll(arg_12_0)
	arg_12_0:InitCommodities()
	arg_12_0:OnSetUp()

	return
end

function var_0_1.OnUpdateCommodity(arg_13_0, arg_13_1)
	local var_13_0

	pairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(arg_13_0.cards) do
		if iter_13_1.goodsVO.id == arg_13_1.id then
			var_13_0 = iter_13_1
		end
	end

	if var_13_0 then
		var_13_0:update(arg_13_1)
	end

	return
end

function var_0_1.RefreshUI(arg_14_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10004

	local var_14_2 = var_14_1(var_14_0, var_1_10004.ACTIVITY_TYPE_SHOP_STREET)

	_ = var_1_10002

	local var_14_3 = var_1_10002.select(var_14_2, function(arg_15_0)
		return arg_15_0 and not arg_15_0:isEnd()
	end)

	setActive = var_14_0

	var_14_0(arg_14_0.tipTextGo, #var_14_3 > 0)

	local var_14_4 = arg_14_0.tipText

	var_14_4.text = arg_14_0:GenTip(var_14_3)
	setActive = var_14_4

	var_14_4(arg_14_0.helpBtn, #var_14_3 > 1)

	arg_14_0.activitys = var_14_3
	setActive = var_14_4

	var_14_4(arg_14_0.helpBtn, false)

	setActive = var_14_4

	var_14_4(arg_14_0.resolveBtn, false)

	setActive = var_14_4

	var_14_4(arg_14_0.refreshBtn, true)

	onButton = var_14_4

	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0.helpBtn

	local function var_14_7()
		local var_16_0 = {}

		table = var_2_10001

		var_2_10001.sort(arg_14_0.activitys, function(arg_17_0, arg_17_1)
			return arg_17_0:getStartTime() < arg_17_1:getStartTime()
		end)

		_ = var_1

		var_1.each(arg_14_0.activitys, function(arg_18_0)
			local var_18_0 = arg_14_0

			var_1.GenHelpContent(var_18_0, var_16_0, arg_18_0)

			return
		end)

		table = var_1

		local var_16_1 = var_1.concat(var_16_0, "\n\n")

		pg = var_2_10002

		local var_16_2 = var_2_10002.MsgboxMgr.GetInstance()

		var_2.ShowMsgBox(var_16_2, {
			content = var_16_1
		})

		return
	end

	SFX_PANEL = var_1_10008

	var_14_4(var_14_5, var_14_6, var_14_7, var_1_10008)

	onButton = var_14_4

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.refreshBtn

	local function var_14_10()
		ShoppingStreet = var_2_10000

		local var_19_0 = var_2_10000.getRiseShopId

		ShopArgs = var_2_10002

		if not var_19_0(var_2_10002.ShoppingStreetUpgrade, arg_14_0.shop.flashCount) then
			pg = var_2_10001

			local var_19_1 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001 = var_2_10001.ShowTips
			i18n = var_2_10004

			var_2_10001(var_19_1, var_2_10004("shopStreet_refresh_max_count"))

			return
		end

		pg = var_2_10001

		local var_19_2 = var_2_10001.shop_template[var_0]

		pg = var_2

		local var_19_3 = var_2.MsgboxMgr.GetInstance()
		local var_19_4 = var_2.ShowMsgBox
		local var_19_5 = {
			yesText = "text_confirm",
			hideNo = false,
			noText = "text_cancel"
		}

		i18n = var_2_10006

		local var_19_6 = "refresh_shopStreet_question"

		i18n = var_2_10009

		local var_19_7 = "word_"

		id2res = var_2_10012
		var_19_5.content = var_2_10006(var_19_6, var_2_10009(var_19_7 .. var_2_10012(var_19_2.resource_type) .. "_icon"), var_19_2.resource_num, arg_14_0.shop.flashCount)

		function var_19_5.onYes()
			local var_20_0 = arg_14_0
			local var_20_1 = var_0.emit

			NewShopMainMediator = var_3_10003

			var_20_1(var_20_0, var_3_10003.REFRESH_STREET_SHOP, var_0)

			return
		end

		var_19_4(var_19_3, var_19_5)

		return
	end

	SFX_PANEL = var_1_10008

	var_14_4(var_14_8, var_14_9, var_14_10, var_1_10008)

	setButtonEnabled = var_14_4

	var_14_4(arg_14_0.refreshBtn, true)

	return
end

function var_0_1.OnInitItem(arg_21_0, arg_21_1)
	GoodsCard = var_1_10002

	local var_21_0 = var_1_10002.New(arg_21_1)

	onButton = var_1_10003

	local var_21_1 = arg_21_0
	local var_21_2 = var_21_0.go

	local function var_21_3()
		local var_22_0 = var_21_0.goodsVO
		local var_22_2

		if not var_0.canPurchase(var_22_0) then
			pg = var_22_2

			local var_22_1 = var_22_2.TipsMgr.GetInstance()

			var_22_2 = var_22_2.ShowTips
			i18n = var_2_10004

			var_22_2(var_22_1, var_2_10004("buy_countLimit"))

			return
		end

		pg = var_22_2

		local var_22_3 = var_22_2.MsgboxMgr.GetInstance()
		local var_22_4 = var_1.ShowMsgBox
		local var_22_5 = {
			yesText = "text_exchange"
		}

		MSGBOX_TYPE_SINGLE_ITEM = var_2_10005
		var_22_5.type = var_2_10005
		var_22_5.drop = {
			id = var_0:getConfig("effect_args")[1],
			type = var_0:getConfig("type"),
			count = var_0:getConfig("num")
		}

		function var_22_5.onYes()
			local var_23_0 = arg_21_0

			var_0.Purchase(var_23_0, var_0)

			return
		end

		var_22_4(var_22_3, var_22_5)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_21_1, var_21_2, var_21_3, var_1_10008)

	arg_21_0.cards[arg_21_1] = var_21_0

	return
end

function var_0_1.OnUpdateItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if not arg_24_0.cards[arg_24_2] then
		arg_24_0:OnInitItem(arg_24_2)

		var_24_0 = arg_24_0.cards[arg_24_2]
	end

	local var_24_1 = arg_24_0.displays[arg_24_1 + 1]

	var_24_0:update(var_24_1)

	return
end

function var_0_1.Purchase(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1

	if arg_25_1.getConfig(var_25_0, "resource_type") == 4 or var_2 == 14 then
		local var_25_1 = arg_25_0.player
		local var_25_2 = var_3.getResById(var_25_1, var_2)

		Item = var_25_0

		local var_25_3 = var_25_0.New({
			id = arg_25_1:getConfig("effect_args")[1]
		})
		local var_25_4 = arg_25_1:getConfig("resource_num") * (arg_25_1.discount / 100)

		pg = var_1_10006

		local var_25_5 = var_1_10006.MsgboxMgr.GetInstance()

		var_1_10006 = var_1_10006.ShowMsgBox

		local var_25_6 = {}

		i18n = var_10
		var_25_6.content = var_10("charge_scene_buy_confirm", var_25_4, var_25_3:getConfig("name"))

		function var_25_6.onYes()
			local var_26_0 = arg_25_0
			local var_26_1 = var_0.emit

			NewShopMainMediator = var_2_10003

			var_26_1(var_26_0, var_2_10003.BUY_ITEM, arg_25_1.id, 1)

			return
		end

		var_1_10006(var_25_5, var_25_6)
	else
		local var_25_7 = arg_25_0
		local var_25_8 = arg_25_0.emit

		NewShopMainMediator = var_1_10006

		var_25_8(var_25_7, var_1_10006.BUY_ITEM, arg_25_1.id, 1)
	end

	return
end

function var_0_1.RemoveTimer(arg_27_0)
	if arg_27_0.timer then
		local var_27_0 = arg_27_0.timer

		var_1.Stop(var_27_0)

		arg_27_0.timer = nil
	end

	return
end

function var_0_1.AddTimer(arg_28_0)
	local var_28_0 = arg_28_0.shop

	Timer = var_1_10002
	arg_28_0.timer = var_1_10002.New(function()
		local var_29_0 = var_28_0
		local var_29_3

		if var_0.isUpdateGoods(var_29_0) then
			local var_29_1 = arg_28_0

			var_29_3.RemoveTimer(var_29_1)

			local var_29_2 = arg_28_0

			var_29_3 = var_29_3.emit
			NewShopMainMediator = var_2_10003

			var_29_3(var_29_2, var_2_10003.REFRESH_STREET_SHOP)
		else
			pg = var_29_3

			local var_29_4 = var_29_3.TimeMgr.GetInstance()
			local var_29_5 = var_0.GetServerTime(var_29_4)
			local var_29_6 = var_28_0.nextFlashTime - var_29_5
			local var_29_7 = arg_28_0.timerText

			i18n = var_2_10003

			local var_29_8 = "shop_refresh_time"

			pg = var_2_10006

			local var_29_9 = var_2_10006.TimeMgr.GetInstance()

			var_29_7.text = var_2_10003(var_29_8, var_6.DescCDTime(var_29_9, var_29_6))
		end

		return
	end, 1, -1)

	local var_28_1 = arg_28_0.timer

	var_2.Start(var_28_1)
	arg_28_0.timer.func()

	return
end

function var_0_1.OnDestroy(arg_30_0)
	arg_30_0:RemoveTimer()
	var_0_1.super.OnDestroy(arg_30_0)

	return
end

return var_0_1
