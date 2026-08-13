class = var_0_10000

local var_0_0 = "GuildShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MilitaryShopPage"))

function var_0_1.CanOpen(arg_1_0)
	return true
end

function var_0_1.CustomInit(arg_2_0)
	GuildShopPurchasePanel = var_1_10001
	arg_2_0.purchaseWindow = var_1_10001.New(arg_2_0._tf, arg_2_0.parent.event)

	return
end

function var_0_1.UpdateShop(arg_3_0, ...)
	var_0_1.super.UpdateShop(arg_3_0, ...)

	local var_3_0 = arg_3_0.purchaseWindow

	if var_1.isShowing(var_3_0) then
		local var_3_1 = arg_3_0.purchaseWindow

		var_1.ExecuteAction(var_3_1, "Hide")
	end

	return
end

function var_0_1.OnUpdatePlayer(arg_4_0)
	arg_4_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = arg_5_0.shop
	local var_5_2 = var_2.GetResList(var_5_1)

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(var_5_2) do
		local var_5_3 = arg_5_0.player
		local var_5_4 = var_8.getResource

		PlayerConst = var_1_10011

		local var_5_5 = var_5_4(var_5_3, var_1_10011.ResGuildCoin)

		table = var_1_10009
		var_1_10009 = var_1_10009.insert
		var_1_10011 = var_5_0

		local var_5_6 = {}

		DROP_TYPE_RESOURCE = var_1_10013
		var_5_6.type = var_1_10013
		var_5_6.resID = iter_5_1
		var_5_6.cnt = var_5_5

		var_1_10009(var_1_10011, var_5_6)
	end

	return var_5_0
end

function var_0_1.OnSetUp(arg_6_0)
	var_0_1.super.OnSetUp(arg_6_0)
	arg_6_0:UpdateRefreshBtn()

	return
end

function var_0_1.UpdateRefreshBtn(arg_7_0)
	setButtonEnabled = var_1_10001

	local var_7_0 = arg_7_0.refreshBtn
	local var_7_1 = arg_7_0.shop

	var_1_10001(var_7_0, var_4.CanRefresh(var_7_1))

	return
end

function var_0_1.RefreshUI(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.tipTextGo, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.helpBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.resolveBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.refreshBtn, true)

	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.refreshBtn

	local function var_8_2()
		local var_9_0 = arg_8_0.shop
		local var_9_1 = var_0.GetResetConsume(var_9_0)

		pg = var_2_10001

		local var_9_2 = var_2_10001.MsgboxMgr.GetInstance()
		local var_9_3 = var_1.ShowMsgBox
		local var_9_4 = {}

		i18n = var_2_10005

		local var_9_5 = "guild_shop_refresh_all_tip"
		local var_9_6 = var_9_1

		i18n = var_2_10009
		var_9_4.content = var_2_10005(var_9_5, var_9_6, var_2_10009("word_guildgold"))

		function var_9_4.onYes()
			local var_10_0 = arg_8_0.player
			local var_10_1 = var_0.getResource

			PlayerConst = var_3_10003

			if var_10_1(var_10_0, var_3_10003.ResGuildCoin) < var_9_1 then
				pg = var_0

				local var_10_2 = var_0.TipsMgr.GetInstance()
				local var_10_3 = var_0.ShowTips

				i18n = var_3

				var_10_3(var_10_2, var_3("common_no_resource"))

				return
			else
				local var_10_4 = arg_8_0
				local var_10_5 = var_0.emit

				NewShopMainMediator = var_3

				var_10_5(var_10_4, var_3.REFRESH_GUILD_SHOP, true)
			end

			return
		end

		var_9_3(var_9_2, var_9_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	setButtonEnabled = var_1_10001

	local var_8_3 = arg_8_0.refreshBtn
	local var_8_4 = arg_8_0.shop

	var_1_10001(var_8_3, var_4.CanRefresh(var_8_4))

	return
end

function var_0_1.OnInitItem(arg_11_0, arg_11_1)
	GuildGoodsCard = var_1_10002

	local var_11_0 = var_1_10002.New(arg_11_1)

	onButton = var_1_10003

	local var_11_1 = arg_11_0
	local var_11_2 = var_11_0.go

	local function var_11_3()
		local var_12_0 = var_11_0.goodsVO

		if not var_0.CanPurchase(var_12_0) then
			pg = var_0

			local var_12_1 = var_0.TipsMgr.GetInstance()
			local var_12_2 = var_0.ShowTips

			i18n = var_2_10003

			var_12_2(var_12_1, var_2_10003("buy_countLimit"))

			return
		end

		local var_12_3 = arg_11_0

		var_0.OnCardClick(var_12_3, var_11_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_11_1, var_11_2, var_11_3, var_1_10008)

	arg_11_0.cards[arg_11_1] = var_11_0

	return
end

function var_0_1.OnCardClick(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.goodsVO
	local var_13_2

	if var_2.Selectable(var_13_0) then
		local var_13_1 = arg_13_0.purchaseWindow

		var_13_2 = var_13_2.ExecuteAction

		local var_13_3 = "Show"

		var_1_10006 = {
			id = arg_13_1.goodsVO.id
		}

		local var_13_4 = arg_13_1.goodsVO

		var_1_10006.count = var_7.GetMaxCnt(var_13_4)

		local var_13_5 = arg_13_1.goodsVO

		var_1_10006.type = var_7.getConfig(var_13_5, "type")

		local var_13_6 = arg_13_1.goodsVO

		var_1_10006.price = var_7.getConfig(var_13_6, "price")

		local var_13_7 = arg_13_1.goodsVO

		var_1_10006.displays = var_7.getConfig(var_13_7, "goods")

		local var_13_8 = arg_13_1.goodsVO

		var_1_10006.num = var_7.getConfig(var_13_8, "num")

		var_13_2(var_13_1, var_13_3, var_1_10006)
	else
		pg = var_13_2

		local var_13_9 = var_13_2.MsgboxMgr.GetInstance()
		local var_13_10 = var_2.ShowMsgBox
		local var_13_11 = {
			yesText = "text_exchange"
		}

		i18n = var_1_10006
		var_13_11.content = var_1_10006("guild_shop_exchange_tip")

		function var_13_11.onYes()
			local var_14_0 = arg_13_1.goodsVO

			if not var_0.CanPurchase(var_14_0) then
				pg = var_0

				local var_14_1 = var_0.TipsMgr.GetInstance()
				local var_14_2 = var_0.ShowTips

				i18n = var_2_10003

				var_14_2(var_14_1, var_2_10003("buy_countLimit"))

				return
			end

			local var_14_3 = arg_13_0
			local var_14_4 = var_0.emit

			NewShopMainMediator = var_2_10003

			local var_14_5 = var_2_10003.ON_GUILD_SHOPPING
			local var_14_6 = arg_13_1.goodsVO.id
			local var_14_7 = arg_13_1.goodsVO

			var_14_4(var_14_3, var_14_5, var_14_6, var_5.GetFirstDropId(var_14_7))

			return
		end

		var_13_10(var_13_9, var_13_11)
	end

	return
end

function var_0_1.OnTimeOut(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.emit

	NewShopMainMediator = var_1_10004

	var_15_1(var_15_0, var_1_10004.REFRESH_GUILD_SHOP, false)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	var_0_1.super.OnDestroy(arg_16_0)

	if arg_16_0.purchaseWindow then
		local var_16_0 = arg_16_0.purchaseWindow

		var_1.Destroy(var_16_0)

		arg_16_0.purchaseWindow = nil
	end

	return
end

return var_0_1
