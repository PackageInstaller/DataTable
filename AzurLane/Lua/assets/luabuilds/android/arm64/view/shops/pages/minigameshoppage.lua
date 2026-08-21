local var_0_0 = class("MiniGameShopPage", import(".BaseShopPage"))

function var_0_0.CanOpen(arg_1_0, arg_1_1, arg_1_2)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_1_2.level, "GameHallMediator")
end

function var_0_0.CustomInit(arg_2_0)
	arg_2_0.purchaseWindow = MiniGameShopPurchasePanel.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.multiWindow = MiniGameShopMultiWindow.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_0.OnSetUp(arg_3_0)
	arg_3_0:RefreshResItemList()
	arg_3_0:RemoveTimer()
	arg_3_0:AddTimer()

	return
end

function var_0_0.Hide(arg_4_0)
	var_0_0.super.Hide(arg_4_0)
	arg_4_0:RemoveTimer()

	return
end

function var_0_0.GetResDataList(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs((arg_5_0.shop:GetResList())) do
		local var_5_0 = getProxy(GameRoomProxy)

		table.insert({}, {
			type = DROP_TYPE_RESOURCE,
			resID = iter_5_1,
			cnt = var_5_0:getTicket()
		})
	end

	return {}
end

function var_0_0.OnUpdateAll(arg_6_0)
	arg_6_0:InitCommodities()
	arg_6_0:OnSetUp()

	if arg_6_0.purchaseWindow:isShowing() then
		arg_6_0.purchaseWindow:ExecuteAction("Hide")
	end

	if arg_6_0.multiWindow:isShowing() then
		arg_6_0.multiWindow:ExecuteAction("Hide")
	end

	return
end

function var_0_0.OnUpdateCommodity(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.cards) do
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

function var_0_0.RefreshUI(arg_8_0)
	setActive(arg_8_0.tipTextGo, true)
	setActive(arg_8_0.helpBtn, false)
	setActive(arg_8_0.resolveBtn, false)
	setActive(arg_8_0.refreshBtn, false)
	setText(arg_8_0.tipText, i18n("game_ticket_current_month") .. getProxy(GameRoomProxy):getMonthlyTicket() .. "/" .. pg.gameset.game_ticket_month.key_value)

	return
end

function var_0_0.OnInitItem(arg_9_0, arg_9_1)
	local var_9_0 = MiniGameGoodsCard.New(arg_9_1)

	onButton(arg_9_0, var_9_0.go, function()
		if not var_9_0.goodsVO:CanPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		arg_9_0:OnClickCommodity(var_9_0.goodsVO)

		return
	end, SFX_PANEL)

	arg_9_0.cards[arg_9_1] = var_9_0

	return
end

function var_0_0.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.cards[arg_11_2] then
		arg_11_0:OnInitItem(arg_11_2)
	end

	arg_11_0.cards[arg_11_2]:update(arg_11_0.displays[arg_11_1 + 1])

	return
end

function var_0_0.OnClickCommodity(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1

	if arg_12_1:Selectable() then
		arg_12_0.purchaseWindow:ExecuteAction("Show", {
			id = arg_12_1.id,
			count = arg_12_1:GetMaxCnt(),
			type = arg_12_1:getConfig("type"),
			price = arg_12_1:getConfig("price"),
			displays = arg_12_1:getConfig("goods"),
			num = arg_12_1:getConfig("num"),
			confirm = function(arg_13_0, arg_13_1)
				arg_12_0:emit(NewShopMainMediator.ON_MINI_GAME_SHOP_BUY, {
					id = arg_13_0,
					list = arg_13_1
				})

				return
			end
		})
	elseif arg_12_1:getConfig("goods_type") == 1 then
		if arg_12_1:GetLimit() > 1 then
			arg_12_0.multiWindow:ExecuteAction("Show", arg_12_1, function(arg_14_0)
				if not var_12_0:CanPurchaseCnt(arg_14_0) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

					return
				end

				local var_14_0 = {}

				table.insert({}, {
					num = arg_14_0,
					id = var_12_0:getConfig("goods")[1]
				})
				arg_12_0:emit(NewShopMainMediator.ON_MINI_GAME_SHOP_BUY, {
					id = var_12_0.id,
					list = var_14_0
				})

				return
			end)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				yesText = "text_exchange",
				content = i18n("guild_shop_exchange_tip"),
				onYes = function()
					if not var_12_0:CanPurchase() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

						return
					end

					local var_15_0 = {}
					local var_15_1 = var_12_0:GetFirstDropId()

					for iter_15_0 = 1, #var_15_1 do
						table.insert(var_15_0, {
							num = 1,
							id = var_15_1[iter_15_0]
						})
					end

					arg_12_0:emit(NewShopMainMediator.ON_MINI_GAME_SHOP_BUY, {
						id = var_12_0.id,
						list = var_15_0
					})

					return
				end
			})
		end
	end

	return
end

function var_0_0.AddTimer(arg_16_0)
	arg_16_0.timer = Timer.New(function()
		local var_17_0 = tonumber(os.date("%d", pg.TimeMgr.GetInstance():GetServerTime()))

		if not arg_16_0.flush and arg_16_0.day and arg_16_0.day == var_17_0 then
			arg_16_0:emit(NewShopMainMediator.ON_MINI_GAME_SHOP_FLUSH)

			arg_16_0.flush = true
		end

		arg_16_0.day = var_17_0

		return
	end, 1, -1)

	arg_16_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_18_0)
	if arg_18_0.timer then
		arg_18_0.timer:Stop()

		arg_18_0.timer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_19_0)
	if arg_19_0.purchaseWindow:isShowing() then
		arg_19_0.purchaseWindow:ExecuteAction("Hide")
	end

	if arg_19_0.multiWindow:isShowing() then
		arg_19_0.multiWindow:ExecuteAction("Hide")
	end

	arg_19_0:RemoveTimer()
	var_0_0.super.OnDestroy(arg_19_0)

	return
end

return var_0_0
