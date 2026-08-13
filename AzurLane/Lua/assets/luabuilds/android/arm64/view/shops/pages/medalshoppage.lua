class = var_0_10000

local var_0_0 = "MedalShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MilitaryShopPage"))

function var_0_1.CanOpen(arg_1_0)
	return true
end

function var_0_1.CustomInit(arg_2_0)
	MedalShopPurchasePanel = var_1_10001
	arg_2_0.purchaseWindow = var_1_10001.New(arg_2_0._tf, arg_2_0.parent.event)
	MedalShopMultiWindow = var_1
	arg_2_0.multiWindow = var_1.New(arg_2_0._tf, arg_2_0.parent.event)

	return
end

function var_0_1.UpdateShop(arg_3_0, ...)
	var_0_1.super.UpdateShop(arg_3_0, ...)

	local var_3_0 = arg_3_0.purchaseWindow

	if var_1.isShowing(var_3_0) then
		local var_3_1 = arg_3_0.purchaseWindow

		var_1.ExecuteAction(var_3_1, "Hide")
	end

	local var_3_2 = arg_3_0.multiWindow

	if var_1.isShowing(var_3_2) then
		local var_3_3 = arg_3_0.multiWindow

		var_1.ExecuteAction(var_3_3, "Hide")
	end

	return
end

function var_0_1.OnUpdatePlayer(arg_4_0)
	return
end

function var_0_1.OnUpdateItems(arg_5_0)
	arg_5_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0.shop
	local var_6_2 = var_2.GetResList(var_6_1)

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(var_6_2) do
		local var_6_3
		local var_6_4 = arg_6_0.items

		ITEM_ID_SILVER_HOOK = var_1_10010

		local var_6_5 = not var_6_4[var_1_10010] and 0 or var_1_10010.count

		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_6_6 = var_6_0
		local var_6_7 = {}

		DROP_TYPE_ITEM = var_1_10015
		var_6_7.type = var_1_10015
		var_6_7.resID = iter_6_1
		var_6_7.cnt = var_6_5

		var_1_10011(var_6_6, var_6_7)
	end

	return var_6_0
end

function var_0_1.RefreshUI(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0.tipTextGo, true)

	setActive = var_1_10001

	var_1_10001(arg_7_0.helpBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_7_0.resolveBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_7_0.refreshBtn, false)

	return
end

function var_0_1.OnInitItem(arg_8_0, arg_8_1)
	MedalGoodsCard = var_1_10002

	local var_8_0 = var_1_10002.New(arg_8_1)

	onButton = var_1_10003

	local var_8_1 = arg_8_0
	local var_8_2 = var_8_0.go

	local function var_8_3()
		local var_9_0 = var_8_0.goods

		if not var_0.CanPurchase(var_9_0) then
			pg = var_0

			local var_9_1 = var_0.TipsMgr.GetInstance()
			local var_9_2 = var_0.ShowTips

			i18n = var_2_10003

			var_9_2(var_9_1, var_2_10003("buy_countLimit"))

			return
		end

		local var_9_3 = arg_8_0

		var_0.OnCardClick(var_9_3, var_8_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_8_1, var_8_2, var_8_3, var_1_10008)

	arg_8_0.cards[arg_8_1] = var_8_0

	return
end

function var_0_1.OnCardClick(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.goods

	if var_2.Selectable(var_10_0) then
		local var_10_1 = arg_10_0.purchaseWindow
		local var_10_2 = var_2.ExecuteAction
		local var_10_3 = "Show"

		var_1_10006 = {
			id = arg_10_1.goods.id
		}

		local var_10_4 = arg_10_1.goods

		var_1_10006.count = var_7.GetMaxCnt(var_10_4)

		local var_10_5 = arg_10_1.goods

		var_1_10006.type = var_7.getConfig(var_10_5, "type")

		local var_10_6 = arg_10_1.goods

		var_1_10006.price = var_7.getConfig(var_10_6, "price")

		local var_10_7 = arg_10_1.goods

		var_1_10006.displays = var_7.getConfig(var_10_7, "goods")

		local var_10_8 = arg_10_1.goods

		var_1_10006.num = var_7.getConfig(var_10_8, "num")

		var_10_2(var_10_1, var_10_3, var_1_10006)
	else
		local var_10_9 = arg_10_1.goods

		if var_2.getConfig(var_10_9, "goods_type") == 1 then
			local var_10_10 = arg_10_1.goods

			if var_2.GetLimit(var_10_10) > 1 then
				local var_10_11 = arg_10_0.multiWindow

				var_2.ExecuteAction(var_10_11, "Show", arg_10_1.goods, function(arg_11_0)
					local var_11_0 = arg_10_1.goods

					if not var_1.CanPurchaseCnt(var_11_0, arg_11_0) then
						pg = var_1

						local var_11_1 = var_1.TipsMgr.GetInstance()
						local var_11_2 = var_1.ShowTips

						i18n = var_4

						var_11_2(var_11_1, var_4("buy_countLimit"))

						return
					end

					local var_11_3 = {}
					local var_11_4 = arg_10_1.goods
					local var_11_5 = var_2.getConfig(var_11_4, "goods")[1]

					for iter_11_0 = 1, arg_11_0 do
						table = var_2_10007

						var_2_10007.insert(var_11_3, var_11_5)
					end

					local var_11_6 = arg_10_0
					local var_11_7 = var_3.emit

					NewShopMainMediator = iter_11_0

					var_11_7(var_11_6, iter_11_0.ON_MEDAL_SHOPPING, arg_10_1.goods.id, var_11_3)

					return
				end)

				goto label_10_0
			end
		end

		pg = var_2

		local var_10_12 = var_2.MsgboxMgr.GetInstance()
		local var_10_13 = var_2.ShowMsgBox
		local var_10_14 = {
			yesText = "text_exchange"
		}

		i18n = var_1_10006
		var_10_14.content = var_1_10006("guild_shop_exchange_tip")

		function var_10_14.onYes()
			local var_12_0 = arg_10_1.goods

			if not var_0.CanPurchase(var_12_0) then
				pg = var_0

				local var_12_1 = var_0.TipsMgr.GetInstance()
				local var_12_2 = var_0.ShowTips

				i18n = var_2_10003

				var_12_2(var_12_1, var_2_10003("buy_countLimit"))

				return
			end

			local var_12_3 = arg_10_0
			local var_12_4 = var_0.emit

			NewShopMainMediator = var_2_10003

			local var_12_5 = var_2_10003.ON_MEDAL_SHOPPING
			local var_12_6 = arg_10_1.goods.id
			local var_12_7 = arg_10_1.goods

			var_12_4(var_12_3, var_12_5, var_12_6, var_5.GetFirstDropId(var_12_7))

			return
		end

		var_10_13(var_10_12, var_10_14)
	end

	::label_10_0::

	return
end

function var_0_1.AddTimer(arg_13_0)
	local var_13_0 = arg_13_0.shop.nextTime + 1

	Timer = var_1_10002
	arg_13_0.timer = var_1_10002.New(function()
		local var_14_0 = var_13_0

		pg = var_2_10001

		local var_14_1 = var_2_10001.TimeMgr.GetInstance()

		if var_14_0 - var_1.GetServerTime(var_14_1) <= 0 then
			local var_14_2 = arg_13_0

			var_1.RemoveTimer(var_14_2)

			local var_14_3 = arg_13_0

			var_1.OnTimeOut(var_14_3)
		else
			string = var_1

			local var_14_4 = var_1.format
			local var_14_5 = "%02d"

			math = var_2_10004

			local var_14_6 = var_14_4(var_14_5, 1 + var_2_10004.floor((var_0 - 1) / 0))

			setText = var_2_10002

			local var_14_7 = arg_13_0.tipText

			i18n = var_2_10005

			local var_14_8 = var_2_10005("title_limit_time")

			i18n = var_6

			local var_14_9 = var_6("shops_rest_day")
			local var_14_10 = var_14_6

			i18n = var_8

			var_2_10002(var_14_7, var_14_8 .. var_14_9 .. var_14_10 .. var_8("word_date"))
		end

		return
	end, 1, -1)

	local var_13_1 = arg_13_0.timer

	var_2.Start(var_13_1)
	arg_13_0.timer.func()

	return
end

function var_0_1.OnTimeOut(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.emit

	NewShopMainMediator = var_1_10004

	var_15_1(var_15_0, var_1_10004.REFRESH_MEDAL_SHOP, false)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	var_0_1.super.OnDestroy(arg_16_0)

	local var_16_0 = arg_16_0.purchaseWindow

	var_1.Destroy(var_16_0)

	local var_16_1 = arg_16_0.multiWindow

	var_1.Destroy(var_16_1)

	return
end

return var_0_1
