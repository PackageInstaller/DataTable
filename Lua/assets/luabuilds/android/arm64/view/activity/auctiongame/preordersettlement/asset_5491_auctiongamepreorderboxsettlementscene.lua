local AuctionGamePreorderBoxSettlementScene = class("AuctionGamePreorderBoxSettlementScene", import("view.base.BaseUI"))

AuctionGamePreorderBoxSettlementScene.REVEAL_ITEM = "AuctionGameMainSettlementScene::REVEAL_ITEM"
AuctionGamePreorderBoxSettlementScene.REVEAL_OVER = "AuctionGameMainSettlementScene::REVEAL_OVER"

function AuctionGamePreorderBoxSettlementScene:getUIName()
	return "AuctionGamePreorderBoxSettlementUI"
end

function AuctionGamePreorderBoxSettlementScene:init()
	onButton(self, self.uiCloseBtn, function()
		self.storeView:RevealAllItem()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCancelBtn, function()
		self.storeView:RevealAllItem()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.uiRevealBtn, function()
		self.storeView:RevealAllItem()

		return
	end, SFX_PANEL)

	self.storeView = AuctionGamePreorderBoxSettlementStoreView.New(self.uiStorePanel, self)

	setText(self.uiRevealBtnText, i18n("auction_settlement_quick"))
	setText(self.uiStoreHouseTitleText, i18n("auction_settlement_value"))
	setText(self.uiProceedsTitleText, i18n("auction_settlement_revenue"))

	return
end

function AuctionGamePreorderBoxSettlementScene:didEnter()
	self:OverlayPanel(self.uiAdaptTf, {
		pbList = {
			self.uiInfoTf
		}
	})

	local var_6_0 = getProxy(PlayerProxy)
	local var_6_1 = getProxy(PlayerProxy):getData()

	setPaintingPrefabAsync(self.uiPaintingTf, pg.ship_skin_template[900284].painting, "chuanwu", nil, {
		skinID = 900284
	})
	setText(self.uiStoreHouseText, 0)
	setText(self.uiProceedsText, string.format("<color=#B13535>%s</color>", StringHelper.ForamtNumber(-1 * AuctionGameTools.GetPreorderCurrentyCnt())))
	self:RefreshCurrency()

	self.addValue = 0
	self.eventList = {
		self:bind(AuctionGamePreorderBoxSettlementScene.REVEAL_ITEM, handler(self, self.OnRefreshText)),
		self:bind(AuctionGamePreorderBoxSettlementScene.REVEAL_OVER, handler(self, self.OnRefreshOver))
	}

	self.storeView:didEnter()
	setActive(self.uiCloseBtn, false)
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

function AuctionGamePreorderBoxSettlementScene:RefreshCurrency()
	setText(self.uiCurrencyText, StringHelper.ForamtNumber(getProxy(AuctionGameBaseProxy).gold))

	return
end

function AuctionGamePreorderBoxSettlementScene:OnRefreshText(arg_9_1, arg_9_2)
	print("揭示物品: id", arg_9_2.id, "uid:", arg_9_2.uid, "价值:", arg_9_2.price, "当前总价值:", self.addValue + arg_9_2.price)

	self.addValue = self.addValue + arg_9_2.price

	setText(self.uiStoreHouseText, StringHelper.ForamtNumber(self.addValue))

	local var_9_0 = self.addValue - AuctionGameTools.GetPreorderCurrentyCnt()

	setText(self.uiProceedsText, string.format("<color=%s>%s</color>", var_9_0 > 0 and "#03825F" or "#B13535", StringHelper.ForamtNumber(var_9_0)))

	return
end

function AuctionGamePreorderBoxSettlementScene:OnRefreshOver()
	setActive(self.uiCloseBtn, true)
	getProxy(AuctionGameBaseProxy):AddGold(self.addValue)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPreorder(1, self.addValue))
	self:RefreshCurrency()

	return
end

function AuctionGamePreorderBoxSettlementScene:willExit()
	self:UnOverlayPanel(self.uiAdaptTf, self._tf)

	for iter_11_0, iter_11_1 in ipairs(self.eventList) do
		self:disconnect(iter_11_1)
	end

	retPaintingPrefab(self.uiPaintingTf, pg.ship_skin_template[900284].painting)
	self.storeView:willExit()

	self.storeView = nil

	return
end

function AuctionGamePreorderBoxSettlementScene:onBackPressed()
	if isActive(self.uiCloseBtn) then
		AuctionGamePreorderBoxSettlementScene.super.onBackPressed(self)
	end

	return
end

return AuctionGamePreorderBoxSettlementScene
