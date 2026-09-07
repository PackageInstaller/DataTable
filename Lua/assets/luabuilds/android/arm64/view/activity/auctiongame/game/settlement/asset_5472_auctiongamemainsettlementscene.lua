local AuctionGameMainSettlementScene = class("AuctionGameMainSettlementScene", import("view.base.BaseUI"))

AuctionGameMainSettlementScene.REVEAL_ITEM = "AuctionGameMainSettlementScene::REVEAL_ITEM"
AuctionGameMainSettlementScene.REVEAL_OVER = "AuctionGameMainSettlementScene::REVEAL_OVER"

function AuctionGameMainSettlementScene:getUIName()
	return "AuctionGameMainSettlementUI"
end

function AuctionGameMainSettlementScene:init()
	setText(self.uiRevealBtnText, i18n("auction_settlement_quick"))
	setText(self.uiNameTitleText, i18n("auction_settlement_name"))
	setText(self.uiBidTitleText, i18n("auction_settlement_price"))
	setText(self.uiStoreHouseTitleText, i18n("auction_settlement_value"))
	setText(self.uiProceedsTitleText, i18n("auction_settlement_revenue"))
	setText(self.uiDividendTitleText, i18n("auction_settlement_dividend"))
	setText(self.uiSessionTitleText, i18n("auction_settlement_session"))
	onButton(self, self.uiCloseBtn, function()
		self.storeView:RevealAllItem()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiRevealBtn, function()
		self.storeView:RevealAllItem()

		return
	end, SFX_PANEL)
	onButton(self, self.uiShareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.AuctionGame)

		return
	end, SFX_PANEL)

	self.storeView = AuctionGameMainSettlementStoreView.New(self.uiStorePanel, self)

	return
end

function AuctionGameMainSettlementScene:didEnter()
	self:OverlayPanel(self.uiAdaptTf, {
		pbList = {
			self.uiInfoTf
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

	self.paintingDefaultAngle = self.uiPaintingTf.localEulerAngles

	local var_6_3 = Ship.New({
		configId = var_6_2.icon,
		skin_id = var_6_2.skinId
	})

	setPaintingPrefabAsync(self.uiPaintingTf, var_6_3:getPainting(), "chuanwu", nil, {
		skinID = var_6_3:getSkinId(),
		rotateZ = self.paintingDefaultAngle.z
	})

	self.shipVO = var_6_3

	setScrollText(self.uiNameText, var_6_2.name)
	setScrollText(self.uiSessionText, pg.auction_session[var_6_0:GetAuctionID()].name)
	setText(self.uiBidText, StringHelper.ForamtNumber(var_6_1.bidValue))
	setText(self.uiStoreHouseText, 0)
	setText(self.uiProceedsText, string.format("<color=#B13535>%s</color>", StringHelper.ForamtNumber(-var_6_1.bidValue)))
	setText(self.uiDividendText, 0)
	self:RefreshCurrency()

	self.addValue = 0
	self.bidValue = var_6_1.bidValue
	self.settlementVO = var_6_1
	self.eventList = {
		self:bind(AuctionGameMainSettlementScene.REVEAL_ITEM, handler(self, self.OnRefreshText)),
		self:bind(AuctionGameMainSettlementScene.REVEAL_OVER, handler(self, self.OnRefreshOver))
	}

	self.storeView:didEnter()
	setActive(self.uiCloseBtn, false)
	setActive(self.uiShareBtn, false)
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_7_0)
		if not IsNil(self.uiCurrencyIcon) then
			self.uiCurrencyIcon.sprite = arg_7_0
		end

		return
	end)

	return
end

function AuctionGameMainSettlementScene:RefreshCurrency()
	setText(self.uiCurrencyText, StringHelper.ForamtNumber(getProxy(AuctionGameBaseProxy).gold))

	return
end

function AuctionGameMainSettlementScene:OnRefreshText(arg_9_1, arg_9_2)
	print("揭示物品: id", arg_9_2.id, "uid:", arg_9_2.uid, "价值:", arg_9_2.price, "当前总价值:", self.addValue + arg_9_2.price)

	self.addValue = self.addValue + arg_9_2.price

	setText(self.uiStoreHouseText, StringHelper.ForamtNumber(self.addValue))

	local var_9_0 = getProxy(AuctionGameProxy):GetSettlementData()

	setText(self.uiProceedsText, string.format("<color=%s>%s</color>", self.addValue - self.settlementVO.bidValue > 0 and "#03825F" or "#B13535", StringHelper.ForamtNumber(self.addValue - self.settlementVO.bidValue)))

	return
end

function AuctionGameMainSettlementScene:OnRefreshOver()
	setActive(self.uiCloseBtn, true)
	setActive(self.uiShareBtn, true)

	local var_10_0 = getProxy(AuctionGameProxy)
	local var_10_1 = var_10_0:GetSettlementData()
	local var_10_2 = getProxy(AuctionGameBaseProxy)
	local var_10_3 = var_10_1.proceeds

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionSettlement(pg.auction_session[var_10_0:GetAuctionID()].name, var_10_1.bidUserID == getProxy(PlayerProxy):getPlayerId() and 1 or 0, var_10_1.bidValue, self.addValue, var_10_2.gold, var_10_2.gold + var_10_1.proceeds))

	if not pg.NewGuideMgr.GetInstance():IsBusy() then
		var_10_2:AddGold(var_10_3)
	end

	self:RefreshCurrency()

	if var_10_1.bidUserID ~= getProxy(PlayerProxy):getPlayerId() then
		setText(self.uiDividendText, string.format("<color=%s>%s</color>", var_10_1.proceeds > 0 and "#03825F" or "#B13535", StringHelper.ForamtNumber(var_10_1.proceeds)))
	end

	return
end

function AuctionGameMainSettlementScene:willExit()
	self:UnOverlayPanel(self.uiAdaptTf, self._tf)

	for iter_11_0, iter_11_1 in ipairs(self.eventList) do
		self:disconnect(iter_11_1)
	end

	retPaintingPrefab(self.uiPaintingTf, self.shipVO:getPainting())
	self.storeView:willExit()

	self.storeView = nil

	return
end

function AuctionGameMainSettlementScene:onBackPressed()
	if isActive(self.uiCloseBtn) then
		AuctionGameMainSettlementScene.super.onBackPressed(self)
	end

	return
end

return AuctionGameMainSettlementScene
