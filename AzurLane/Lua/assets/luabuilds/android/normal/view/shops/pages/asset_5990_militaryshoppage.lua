class = var_0_10000

local var_0_0 = "MilitaryShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseShopPage"))

function var_0_1.GetPaintingCommodityUpdateVoice(arg_1_0)
	return
end

function var_0_1.CanOpen(arg_2_0, arg_2_1, arg_2_2)
	pg = var_1_10003

	local var_2_0 = var_1_10003.SystemOpenMgr.GetInstance()

	return var_3.isOpenSystem(var_2_0, arg_2_2.level, "MilitaryExerciseMediator")
end

function var_0_1.OnUpdatePlayer(arg_3_0)
	arg_3_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = arg_4_0.shop
	local var_4_2 = var_2.GetResList(var_4_1)

	ipairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(var_4_2) do
		local var_4_3 = arg_4_0.player.exploit

		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_4_4 = var_4_0
		local var_4_5 = {}

		DROP_TYPE_RESOURCE = var_1_10012
		var_4_5.type = var_1_10012
		var_4_5.resID = iter_4_1
		var_4_5.cnt = var_4_3

		var_1_10009(var_4_4, var_4_5)
	end

	return var_4_0
end

function var_0_1.OnSetUp(arg_5_0)
	arg_5_0:RemoveTimer()
	arg_5_0:AddTimer()

	return
end

function var_0_1.Hide(arg_6_0)
	var_0_1.super.Hide(arg_6_0)
	arg_6_0:RemoveTimer()

	return
end

function var_0_1.OnUpdateAll(arg_7_0)
	arg_7_0:InitCommodities()
	arg_7_0:OnSetUp()

	return
end

function var_0_1.OnUpdateCommodity(arg_8_0, arg_8_1)
	local var_8_0

	pairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.cards) do
		if iter_8_1.goodsVO.id == arg_8_1.id then
			var_8_0 = iter_8_1

			break
		end
	end

	if var_8_0 then
		var_8_0:update(arg_8_1)
	end

	return
end

function var_0_1.RefreshUI(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.tipTextGo, false)

	setActive = var_1_10001

	var_1_10001(arg_9_0.helpBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_9_0.resolveBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_9_0.refreshBtn, true)

	pg = var_1_10001

	local var_9_0 = var_1_10001.arena_data_shop[1]

	onButton = var_2

	local var_9_1 = arg_9_0
	local var_9_2 = arg_9_0.refreshBtn

	local function var_9_3()
		if arg_9_0.shop.refreshCount - 1 >= #var_9_0.refresh_price then
			pg = var_0

			local var_10_0 = var_0.TipsMgr.GetInstance()
			local var_10_1 = var_0.ShowTips

			i18n = var_2_10002

			var_10_1(var_10_0, var_2_10002("shopStreet_refresh_max_count"))

			return
		end

		local var_10_2

		if not var_9_0.refresh_price[arg_9_0.shop.refreshCount] then
			var_10_2 = var_9_0.refresh_price[#var_9_0.refresh_price]
		end

		pg = var_1

		local var_10_3 = var_1.MsgboxMgr.GetInstance()
		local var_10_4 = var_1.ShowMsgBox
		local var_10_5 = {}

		i18n = var_2_10004

		local var_10_6 = "refresh_shopStreet_question"

		i18n = var_2_10006
		var_10_5.content = var_2_10004(var_10_6, var_2_10006("word_gem_icon"), var_10_2, arg_9_0.shop.refreshCount - 1)

		function var_10_5.onYes()
			local var_11_0 = arg_9_0.player

			if var_0.getTotalGem(var_11_0) < var_10_2 then
				pg = var_0

				local var_11_1 = var_0.TipsMgr.GetInstance()
				local var_11_2 = var_0.ShowTips

				i18n = var_3_10002

				var_11_2(var_11_1, var_3_10002("common_no_resource"))

				return
			else
				local var_11_3 = arg_9_0
				local var_11_4 = var_0.emit

				NewShopMainMediator = var_3_10002

				var_11_4(var_11_3, var_3_10002.REFRESH_MILITARY_SHOP, true)
			end

			return
		end

		var_10_4(var_10_3, var_10_5)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_9_1, var_9_2, var_9_3, var_1_10006)

	setButtonEnabled = var_2

	var_2(arg_9_0.refreshBtn, true)

	return
end

function var_0_1.OnInitItem(arg_12_0, arg_12_1)
	GoodsCard = var_1_10002

	local var_12_0 = var_1_10002.New(arg_12_1)

	onButton = var_3

	local var_12_1 = arg_12_0
	local var_12_2 = var_12_0.go

	local function var_12_3()
		local var_13_0 = var_12_0.goodsVO

		if not var_0.canPurchase(var_13_0) then
			pg = var_0

			local var_13_1 = var_0.TipsMgr.GetInstance()
			local var_13_2 = var_0.ShowTips

			i18n = var_2_10002

			var_13_2(var_13_1, var_2_10002("buy_countLimit"))

			return
		end

		local var_13_3 = arg_12_0

		var_0.OnClickCommodity(var_13_3, var_12_0.goodsVO)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_12_1, var_12_2, var_12_3, var_1_10007)

	arg_12_0.cards[arg_12_1] = var_12_0

	return
end

function var_0_1.OnUpdateItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	if not arg_14_0.cards[arg_14_2] then
		arg_14_0:OnInitItem(arg_14_2)

		var_14_0 = arg_14_0.cards[arg_14_2]
	end

	local var_14_1 = arg_14_0.displays[arg_14_1 + 1]

	var_14_0:update(var_14_1)

	return
end

function var_0_1.OnClickCommodity(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1

	pg = var_1_10003

	local var_15_1 = var_1_10003.MsgboxMgr.GetInstance()
	local var_15_2 = var_3.ShowMsgBox
	local var_15_3 = {
		yesText = "text_exchange"
	}

	MSGBOX_TYPE_SINGLE_ITEM = var_1_10006
	var_15_3.type = var_1_10006
	var_15_3.drop = {
		id = var_15_0:getConfig("effect_args")[1],
		type = var_15_0:getConfig("type")
	}

	function var_15_3.onYes()
		local var_16_0 = arg_15_0
		local var_16_1 = var_0.emit

		NewShopMainMediator = var_2_10002

		var_16_1(var_16_0, var_2_10002.BUY_ITEM, var_15_0.id, 1)

		return
	end

	var_15_2(var_15_1, var_15_3)

	return
end

function var_0_1.AddTimer(arg_17_0)
	local var_17_0 = arg_17_0.shop.nextTime + 1

	Timer = var_1_10002
	arg_17_0.timer = var_1_10002.New(function()
		local var_18_0 = var_17_0

		pg = var_2_10001

		local var_18_1 = var_2_10001.TimeMgr.GetInstance()

		if var_18_0 - var_1.GetServerTime(var_18_1) <= 0 then
			local var_18_2 = arg_17_0

			var_1.RemoveTimer(var_18_2)

			local var_18_3 = arg_17_0

			var_1.OnTimeOut(var_18_3)
		else
			pg = var_1

			local var_18_4 = var_1.TimeMgr.GetInstance()
			local var_18_5 = var_1.DescCDTime(var_18_4, var_0)
			local var_18_6 = arg_17_0.timerText

			i18n = var_3
			var_18_6.text = var_3("shop_refresh_time", var_18_5)
		end

		return
	end, 1, -1)

	local var_17_1 = arg_17_0.timer

	var_2.Start(var_17_1)
	arg_17_0.timer.func()

	return
end

function var_0_1.OnTimeOut(arg_19_0)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.emit

	NewShopMainMediator = var_1_10003

	var_19_1(var_19_0, var_1_10003.REFRESH_MILITARY_SHOP)

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

function var_0_1.OnDestroy(arg_21_0)
	var_0_1.super.OnDestroy(arg_21_0)
	arg_21_0:RemoveTimer()

	return
end

return var_0_1
