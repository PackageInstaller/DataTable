local var_0_0 = class("AuctionGamePreorderBoxSettlementScene", import("view.base.BaseUI"))

var_0_0.REVEAL_ITEM = "AuctionGameMainSettlementScene::REVEAL_ITEM"
var_0_0.REVEAL_OVER = "AuctionGameMainSettlementScene::REVEAL_OVER"

function var_0_0.getUIName(arg_1_0)
	return "AuctionGamePreorderBoxSettlementUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0.storeView:RevealAllItem()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiCancelBtn, function()
		arg_2_0.storeView:RevealAllItem()
		arg_2_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiRevealBtn, function()
		arg_2_0.storeView:RevealAllItem()

		return
	end, SFX_PANEL)

	arg_2_0.storeView = AuctionGamePreorderBoxSettlementStoreView.New(arg_2_0.uiStorePanel, arg_2_0)

	setText(arg_2_0.uiRevealBtnText, i18n("auction_settlement_quick"))
	setText(arg_2_0.uiStoreHouseTitleText, i18n("auction_settlement_value"))
	setText(arg_2_0.uiProceedsTitleText, i18n("auction_settlement_revenue"))

	return
end

function var_0_0.didEnter(arg_6_0)
	arg_6_0:OverlayPanel(arg_6_0.uiAdaptTf, {
		pbList = {
			arg_6_0.uiInfoTf
		}
	})

	local var_6_0 = getProxy(PlayerProxy)
	local var_6_1 = getProxy(PlayerProxy):getData()

	setPaintingPrefabAsync(arg_6_0.uiPaintingTf, pg.ship_skin_template[900284].painting, "chuanwu", nil, {
		skinID = 900284
	})
	setText(arg_6_0.uiStoreHouseText, 0)
	setText(arg_6_0.uiProceedsText, string.format("<color=#B13535>%s</color>", StringHelper.ForamtNumber(-1 * AuctionGameTools.GetPreorderCurrentyCnt())))
	arg_6_0:RefreshCurrency()

	arg_6_0.addValue = 0
	arg_6_0.eventList = {
		arg_6_0:bind(var_0_0.REVEAL_ITEM, handler(arg_6_0, arg_6_0.OnRefreshText)),
		arg_6_0:bind(var_0_0.REVEAL_OVER, handler(arg_6_0, arg_6_0.OnRefreshOver))
	}

	arg_6_0.storeView:didEnter()
	setActive(arg_6_0.uiCloseBtn, false)
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_7_0)
		if not IsNil(arg_6_0.uiCurrencyIcon) then
			arg_6_0.uiCurrencyIcon.sprite = arg_7_0
		end

		return
	end)

	return
end

function var_0_0.RefreshCurrency(arg_8_0)
	setText(arg_8_0.uiCurrencyText, StringHelper.ForamtNumber(getProxy(AuctionGameBaseProxy).gold))

	return
end

function var_0_0.OnRefreshText(arg_9_0, arg_9_1, arg_9_2)
	print("揭示物品: id", arg_9_2.id, "uid:", arg_9_2.uid, "价值:", arg_9_2.price, "当前总价值:", arg_9_0.addValue + arg_9_2.price)

	arg_9_0.addValue = arg_9_0.addValue + arg_9_2.price

	setText(arg_9_0.uiStoreHouseText, StringHelper.ForamtNumber(arg_9_0.addValue))

	local var_9_0 = arg_9_0.addValue - AuctionGameTools.GetPreorderCurrentyCnt()

	setText(arg_9_0.uiProceedsText, string.format("<color=%s>%s</color>", var_9_0 > 0 and "#03825F" or "#B13535", StringHelper.ForamtNumber(var_9_0)))

	return
end

function var_0_0.OnRefreshOver(arg_10_0)
	setActive(arg_10_0.uiCloseBtn, true)
	getProxy(AuctionGameBaseProxy):AddGold(arg_10_0.addValue)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPreorder(1, arg_10_0.addValue))
	arg_10_0:RefreshCurrency()

	return
end

function var_0_0.willExit(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0.uiAdaptTf, arg_11_0._tf)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.eventList) do
		arg_11_0:disconnect(iter_11_1)
	end

	retPaintingPrefab(arg_11_0.uiPaintingTf, pg.ship_skin_template[900284].painting)
	arg_11_0.storeView:willExit()

	arg_11_0.storeView = nil

	return
end

function var_0_0.onBackPressed(arg_12_0)
	if isActive(arg_12_0.uiCloseBtn) then
		var_0_0.super.onBackPressed(arg_12_0)
	end

	return
end

return var_0_0
