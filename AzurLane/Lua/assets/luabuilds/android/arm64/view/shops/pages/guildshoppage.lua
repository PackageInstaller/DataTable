local var_0_0 = class("GuildShopPage", import(".MilitaryShopPage"))

function var_0_0.CanOpen(arg_1_0)
	return true
end

function var_0_0.CustomInit(arg_2_0)
	arg_2_0.purchaseWindow = GuildShopPurchasePanel.New(arg_2_0._tf, arg_2_0.parent.event)

	return
end

function var_0_0.UpdateShop(arg_3_0, ...)
	var_0_0.super.UpdateShop(arg_3_0, ...)

	if arg_3_0.purchaseWindow:isShowing() then
		arg_3_0.purchaseWindow:ExecuteAction("Hide")
	end

	return
end

function var_0_0.OnUpdatePlayer(arg_4_0)
	arg_4_0:RefreshResItemList()

	return
end

function var_0_0.GetResDataList(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs((arg_5_0.shop:GetResList())) do
		table.insert({}, {
			type = DROP_TYPE_RESOURCE,
			resID = iter_5_1,
			cnt = arg_5_0.player:getResource(PlayerConst.ResGuildCoin)
		})
	end

	return {}
end

function var_0_0.OnSetUp(arg_6_0)
	var_0_0.super.OnSetUp(arg_6_0)
	arg_6_0:UpdateRefreshBtn()

	return
end

function var_0_0.UpdateRefreshBtn(arg_7_0)
	setButtonEnabled(arg_7_0.refreshBtn, arg_7_0.shop:CanRefresh())

	return
end

function var_0_0.RefreshUI(arg_8_0)
	setActive(arg_8_0.tipTextGo, false)
	setActive(arg_8_0.helpBtn, false)
	setActive(arg_8_0.resolveBtn, false)
	setActive(arg_8_0.refreshBtn, true)
	onButton(arg_8_0, arg_8_0.refreshBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_shop_refresh_all_tip", arg_8_0.shop:GetResetConsume(), i18n("word_guildgold")),
			onYes = function()
				if arg_8_0.player:getResource(PlayerConst.ResGuildCoin) < var_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

					return
				else
					arg_8_0:emit(NewShopMainMediator.REFRESH_GUILD_SHOP, true)
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	setButtonEnabled(arg_8_0.refreshBtn, arg_8_0.shop:CanRefresh())

	return
end

function var_0_0.OnInitItem(arg_11_0, arg_11_1)
	local var_11_0 = GuildGoodsCard.New(arg_11_1)

	onButton(arg_11_0, var_11_0.go, function()
		if not var_11_0.goodsVO:CanPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		arg_11_0:OnCardClick(var_11_0)

		return
	end, SFX_PANEL)

	arg_11_0.cards[arg_11_1] = var_11_0

	return
end

function var_0_0.OnCardClick(arg_13_0, arg_13_1)
	if arg_13_1.goodsVO:Selectable() then
		arg_13_0.purchaseWindow:ExecuteAction("Show", {
			id = arg_13_1.goodsVO.id,
			count = arg_13_1.goodsVO:GetMaxCnt(),
			type = arg_13_1.goodsVO:getConfig("type"),
			price = arg_13_1.goodsVO:getConfig("price"),
			displays = arg_13_1.goodsVO:getConfig("goods"),
			num = arg_13_1.goodsVO:getConfig("num")
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_exchange",
			content = i18n("guild_shop_exchange_tip"),
			onYes = function()
				if not arg_13_1.goodsVO:CanPurchase() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

					return
				end

				arg_13_0:emit(NewShopMainMediator.ON_GUILD_SHOPPING, arg_13_1.goodsVO.id, arg_13_1.goodsVO:GetFirstDropId())

				return
			end
		})
	end

	return
end

function var_0_0.OnTimeOut(arg_15_0)
	arg_15_0:emit(NewShopMainMediator.REFRESH_GUILD_SHOP, false)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	var_0_0.super.OnDestroy(arg_16_0)

	if arg_16_0.purchaseWindow then
		arg_16_0.purchaseWindow:Destroy()

		arg_16_0.purchaseWindow = nil
	end

	return
end

return var_0_0
