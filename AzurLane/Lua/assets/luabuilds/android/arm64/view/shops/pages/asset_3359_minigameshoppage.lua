class = var_0_10000

local var_0_0 = "MiniGameShopPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShopPage"))

function var_0_1.CanOpen(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	local var_1_0 = var_1_10003.SystemOpenMgr.GetInstance()

	return var_3.isOpenSystem(var_1_0, arg_1_2.level, "GameHallMediator")
end

function var_0_1.CustomInit(arg_2_0)
	MiniGameShopPurchasePanel = var_1_10001
	arg_2_0.purchaseWindow = var_1_10001.New(arg_2_0._tf, arg_2_0.event)
	MiniGameShopMultiWindow = var_1
	arg_2_0.multiWindow = var_1.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.OnSetUp(arg_3_0)
	arg_3_0:RefreshResItemList()
	arg_3_0:RemoveTimer()
	arg_3_0:AddTimer()

	return
end

function var_0_1.Hide(arg_4_0)
	var_0_1.super.Hide(arg_4_0)
	arg_4_0:RemoveTimer()

	return
end

function var_0_1.GetResDataList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = arg_5_0.shop
	local var_5_2 = var_2.GetResList(var_5_1)

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(var_5_2) do
		getProxy = var_1_10008
		GameRoomProxy = var_1_10010
		var_1_10010 = var_1_10008(var_1_10010)
		var_1_10008 = var_1_10008.getTicket(var_1_10010)
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_5_3 = var_5_0
		local var_5_4 = {}

		DROP_TYPE_RESOURCE = var_1_10013
		var_5_4.type = var_1_10013
		var_5_4.resID = iter_5_1
		var_5_4.cnt = var_1_10008

		var_1_10009(var_5_3, var_5_4)
	end

	return var_5_0
end

function var_0_1.OnUpdateAll(arg_6_0)
	arg_6_0:InitCommodities()
	arg_6_0:OnSetUp()

	local var_6_0 = arg_6_0.purchaseWindow

	if var_1.isShowing(var_6_0) then
		local var_6_1 = arg_6_0.purchaseWindow

		var_1.ExecuteAction(var_6_1, "Hide")
	end

	local var_6_2 = arg_6_0.multiWindow

	if var_1.isShowing(var_6_2) then
		local var_6_3 = arg_6_0.multiWindow

		var_1.ExecuteAction(var_6_3, "Hide")
	end

	return
end

function var_0_1.OnUpdateCommodity(arg_7_0, arg_7_1)
	local var_7_0

	pairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.cards) do
		if iter_7_1.goodsVO.id == arg_7_1.id then
			var_7_0 = iter_7_1

			break
		end
	end

	if var_7_0 then
		var_7_0:update(arg_7_1)
	end

	return
end

function var_0_1.RefreshUI(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.tipTextGo, true)

	setActive = var_1_10001

	var_1_10001(arg_8_0.helpBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.resolveBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.refreshBtn, false)

	pg = var_1_10001

	local var_8_0 = var_1_10001.gameset.game_ticket_month.key_value

	getProxy = var_1_10002
	GameRoomProxy = var_4

	local var_8_1 = var_1_10002(var_4)
	local var_8_2 = var_2.getMonthlyTicket(var_8_1)

	setText = var_3

	local var_8_3 = arg_8_0.tipText

	i18n = var_1_10006

	var_3(var_8_3, var_1_10006("game_ticket_current_month") .. var_8_2 .. "/" .. var_8_0)

	return
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	MiniGameGoodsCard = var_1_10002

	local var_9_0 = var_1_10002.New(arg_9_1)

	onButton = var_1_10003

	local var_9_1 = arg_9_0
	local var_9_2 = var_9_0.go

	local function var_9_3()
		local var_10_0 = var_9_0.goodsVO

		if not var_0.CanPurchase(var_10_0) then
			pg = var_0

			local var_10_1 = var_0.TipsMgr.GetInstance()
			local var_10_2 = var_0.ShowTips

			i18n = var_2_10003

			var_10_2(var_10_1, var_2_10003("buy_countLimit"))

			return
		end

		local var_10_3 = arg_9_0

		var_0.OnClickCommodity(var_10_3, var_9_0.goodsVO)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_9_1, var_9_2, var_9_3, var_1_10008)

	arg_9_0.cards[arg_9_1] = var_9_0

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)

		var_11_0 = arg_11_0.cards[arg_11_2]
	end

	local var_11_1 = arg_11_0.displays[arg_11_1 + 1]

	var_11_0:update(var_11_1)

	return
end

function var_0_1.OnClickCommodity(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1

	if var_2.Selectable(var_12_0) then
		local var_12_1 = arg_12_0.purchaseWindow

		var_3.ExecuteAction(var_12_1, "Show", {
			id = var_2.id,
			count = var_2:GetMaxCnt(),
			type = var_2:getConfig("type"),
			price = var_2:getConfig("price"),
			displays = var_2:getConfig("goods"),
			num = var_2:getConfig("num"),
			confirm = function(arg_13_0, arg_13_1)
				local var_13_0 = arg_12_0
				local var_13_1 = var_2.emit

				NewShopMainMediator = var_2_10005

				var_13_1(var_13_0, var_2_10005.ON_MINI_GAME_SHOP_BUY, {
					id = arg_13_0,
					list = arg_13_1
				})

				return
			end
		})
	elseif var_2:getConfig("goods_type") == 1 then
		local var_12_2 = var_2:GetLimit()

		if 1 < var_12_2 then
			local var_12_3 = arg_12_0.multiWindow

			var_4.ExecuteAction(var_12_3, "Show", var_2, function(arg_14_0)
				local var_14_0 = var_0

				if not var_1.CanPurchaseCnt(var_14_0, arg_14_0) then
					pg = var_1
					var_14_0 = var_1.TipsMgr.GetInstance()

					local var_14_1 = var_1.ShowTips

					i18n = var_4

					var_14_1(var_14_0, var_4("buy_countLimit"))

					return
				end

				local var_14_2 = {}
				local var_14_3 = var_0
				local var_14_4 = var_2.getConfig(var_14_3, "goods")[1]

				table = var_14_0

				var_14_0.insert(var_14_2, {
					num = arg_14_0,
					id = var_14_4
				})

				local var_14_5 = arg_12_0
				local var_14_6 = var_3.emit

				NewShopMainMediator = var_6

				var_14_6(var_14_5, var_6.ON_MINI_GAME_SHOP_BUY, {
					id = var_0.id,
					list = var_14_2
				})

				return
			end)
		else
			pg = var_4

			local var_12_4 = var_4.MsgboxMgr.GetInstance()
			local var_12_5 = var_4.ShowMsgBox
			local var_12_6 = {
				yesText = "text_exchange"
			}

			i18n = var_1_10008
			var_12_6.content = var_1_10008("guild_shop_exchange_tip")

			function var_12_6.onYes()
				local var_15_0 = var_0

				if not var_0.CanPurchase(var_15_0) then
					pg = var_0

					local var_15_1 = var_0.TipsMgr.GetInstance()
					local var_15_2 = var_0.ShowTips

					i18n = var_2_10003

					var_15_2(var_15_1, var_2_10003("buy_countLimit"))

					return
				end

				local var_15_3 = {}
				local var_15_4 = var_0
				local var_15_5 = var_1.GetFirstDropId(var_15_4)

				for iter_15_0 = 1, #var_15_5 do
					table = var_2_10006

					var_2_10006.insert(var_15_3, {
						num = 1,
						id = var_15_5[iter_15_0]
					})
				end

				local var_15_6 = arg_12_0
				local var_15_7 = var_2.emit

				NewShopMainMediator = iter_15_0

				var_15_7(var_15_6, iter_15_0.ON_MINI_GAME_SHOP_BUY, {
					id = var_0.id,
					list = var_15_3
				})

				return
			end

			var_12_5(var_12_4, var_12_6)
		end
	end

	return
end

function var_0_1.AddTimer(arg_16_0)
	Timer = var_1_10001
	arg_16_0.timer = var_1_10001.New(function()
		tonumber = var_2_10000
		os = var_2_10002

		local var_17_0 = var_2_10002.date
		local var_17_1 = "%d"

		pg = var_2_10005

		local var_17_2 = var_2_10005.TimeMgr.GetInstance()
		local var_17_3 = var_2_10000(var_17_0(var_17_1, var_5.GetServerTime(var_17_2)))

		if not arg_16_0.flush and arg_16_0.day and arg_16_0.day == var_17_3 then
			local var_17_4 = arg_16_0
			local var_17_5 = var_1.emit

			NewShopMainMediator = var_17_1

			var_17_5(var_17_4, var_17_1.ON_MINI_GAME_SHOP_FLUSH)

			arg_16_0.flush = true
		end

		arg_16_0.day = var_17_3

		return
	end, 1, -1)

	local var_16_0 = arg_16_0.timer

	var_1.Start(var_16_0)

	return
end

function var_0_1.RemoveTimer(arg_18_0)
	if arg_18_0.timer then
		local var_18_0 = arg_18_0.timer

		var_1.Stop(var_18_0)

		arg_18_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_19_0)
	local var_19_0 = arg_19_0.purchaseWindow

	if var_1.isShowing(var_19_0) then
		local var_19_1 = arg_19_0.purchaseWindow

		var_1.ExecuteAction(var_19_1, "Hide")
	end

	local var_19_2 = arg_19_0.multiWindow

	if var_1.isShowing(var_19_2) then
		local var_19_3 = arg_19_0.multiWindow

		var_1.ExecuteAction(var_19_3, "Hide")
	end

	arg_19_0:RemoveTimer()
	var_0_1.super.OnDestroy(arg_19_0)

	return
end

return var_0_1
