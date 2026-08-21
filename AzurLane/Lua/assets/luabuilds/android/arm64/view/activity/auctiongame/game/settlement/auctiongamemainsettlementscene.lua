local var_0_0 = class("AuctionGameMainSettlementScene", import("view.base.BaseUI"))

var_0_0.REVEAL_ITEM = "AuctionGameMainSettlementScene::REVEAL_ITEM"
var_0_0.REVEAL_OVER = "AuctionGameMainSettlementScene::REVEAL_OVER"

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainSettlementUI"
end

function var_0_0.init(arg_2_0)
	setText(arg_2_0.uiRevealBtnText, i18n("auction_settlement_quick"))
	setText(arg_2_0.uiNameTitleText, i18n("auction_settlement_name"))
	setText(arg_2_0.uiBidTitleText, i18n("auction_settlement_price"))
	setText(arg_2_0.uiStoreHouseTitleText, i18n("auction_settlement_value"))
	setText(arg_2_0.uiProceedsTitleText, i18n("auction_settlement_revenue"))
	setText(arg_2_0.uiDividendTitleText, i18n("auction_settlement_dividend"))
	setText(arg_2_0.uiSessionTitleText, i18n("auction_settlement_session"))
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0.storeView:RevealAllItem()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiRevealBtn, function()
		arg_2_0.storeView:RevealAllItem()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiShareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.AuctionGame)

		return
	end, SFX_PANEL)

	arg_2_0.storeView = AuctionGameMainSettlementStoreView.New(arg_2_0.uiStorePanel, arg_2_0)

	return
end

function var_0_0.didEnter(arg_6_0)
	arg_6_0:OverlayPanel(arg_6_0.uiAdaptTf, {
		pbList = {
			arg_6_0.uiInfoTf
		}
	})

	local var_6_0 = getProxy(AuctionGameProxy)
	local var_6_1 = var_6_0:GetSettlementData()
	local var_6_2

	for iter_6_0, iter_6_1 in ipairs(var_6_0:GetPlayerList()) do
		if iter_6_1.id == var_6_1.bidUserID then
			var_6_2 = iter_6_1

			break
		end
	end

	arg_6_0.paintingDefaultAngle = arg_6_0.uiPaintingTf.localEulerAngles

	local var_6_3 = Ship.New({
		configId = var_6_2.icon,
		skin_id = var_6_2.skinId
	})

	setPaintingPrefabAsync(arg_6_0.uiPaintingTf, var_6_3:getPainting(), "chuanwu", nil, {
		skinID = var_6_3:getSkinId(),
		rotateZ = arg_6_0.paintingDefaultAngle.z
	})

	arg_6_0.shipVO = var_6_3

	setScrollText(arg_6_0.uiNameText, var_6_2.name)
	setScrollText(arg_6_0.uiSessionText, pg.auction_session[var_6_0:GetAuctionID()].name)
	setText(arg_6_0.uiBidText, StringHelper.ForamtNumber(var_6_1.bidValue))
	setText(arg_6_0.uiStoreHouseText, 0)
	setText(arg_6_0.uiProceedsText, string.format("<color=#B13535>%s</color>", StringHelper.ForamtNumber(-var_6_1.bidValue)))
	setText(arg_6_0.uiDividendText, 0)
	arg_6_0:RefreshCurrency()

	arg_6_0.addValue = 0
	arg_6_0.bidValue = var_6_1.bidValue
	arg_6_0.settlementVO = var_6_1
	arg_6_0.eventList = {
		arg_6_0:bind(var_0_0.REVEAL_ITEM, handler(arg_6_0, arg_6_0.OnRefreshText)),
		arg_6_0:bind(var_0_0.REVEAL_OVER, handler(arg_6_0, arg_6_0.OnRefreshOver))
	}

	arg_6_0.storeView:didEnter()
	setActive(arg_6_0.uiCloseBtn, false)
	setActive(arg_6_0.uiShareBtn, false)
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

	local var_9_0 = getProxy(AuctionGameProxy):GetSettlementData()

	setText(arg_9_0.uiProceedsText, string.format("<color=%s>%s</color>", arg_9_0.addValue - arg_9_0.settlementVO.bidValue > 0 and "#03825F" or "#B13535", StringHelper.ForamtNumber(arg_9_0.addValue - arg_9_0.settlementVO.bidValue)))

	return
end

function var_0_0.OnRefreshOver(arg_10_0)
	setActive(arg_10_0.uiCloseBtn, true)
	setActive(arg_10_0.uiShareBtn, true)

	local var_10_0 = getProxy(AuctionGameProxy)
	local var_10_1 = var_10_0:GetSettlementData()
	local var_10_2 = getProxy(AuctionGameBaseProxy)
	local var_10_3 = var_10_1.proceeds
	local var_10_4 = getProxy(PlayerProxy)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionSettlement(pg.auction_session[var_10_0:GetAuctionID()].name, var_10_1.bidUserID == var_10_4:getPlayerId() and 1 or 0, var_10_1.bidValue, arg_10_0.addValue, var_10_2.gold, var_10_2.gold + var_10_1.proceeds))

	if not pg.NewGuideMgr.GetInstance():IsBusy() then
		var_10_2:AddGold(var_10_3)
	end

	arg_10_0:RefreshCurrency()

	if var_10_1.bidUserID ~= getProxy(PlayerProxy):getPlayerId() then
		setText(arg_10_0.uiDividendText, string.format("<color=%s>%s</color>", var_10_1.proceeds > 0 and "#03825F" or "#B13535", StringHelper.ForamtNumber(var_10_1.proceeds)))
	end

	return
end

function var_0_0.willExit(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0.uiAdaptTf, arg_11_0._tf)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.eventList) do
		arg_11_0:disconnect(iter_11_1)
	end

	retPaintingPrefab(arg_11_0.uiPaintingTf, arg_11_0.shipVO:getPainting())
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
