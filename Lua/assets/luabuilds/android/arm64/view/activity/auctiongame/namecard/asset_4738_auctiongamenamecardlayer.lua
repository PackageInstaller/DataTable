local AuctionGameNameCardLayer = class("AuctionGameNameCardLayer", import("view.base.BaseUI"))

function AuctionGameNameCardLayer:getUIName()
	return "AuctioNGameNameCardUI"
end

function AuctionGameNameCardLayer:init()
	self.ysScreenShoter = self._tf:GetComponent(typeof(YSTool.YSScreenShoter))

	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCopyBtn, function()
		UniPasteBoard.SetClipBoardString(getProxy(PlayerProxy):getPlayerId())
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)
	onButton(self, self.uiShareBtn, function()
		local var_5_0 = getProxy(PlayerProxy)

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNameCard(1, getProxy(PlayerProxy):getData().id))

		return
	end, SFX_PANEL)
	onButton(self, self.uiSaveBtn, function()
		setActive(pg.UIMgr.GetInstance().OverlayEffect, false)
		setActive(self.uiBtnsGo, false)
		self.ysScreenShoter:TakeScreenShotData(tackCallBack, function(arg_7_0)
			setActive(pg.UIMgr.GetInstance().OverlayEffect, true)
			setActive(self.uiBtnsGo, true)
			YSNormalTool.MediaTool.SaveImageWithBytes(arg_7_0, function(arg_8_0, arg_8_1)
				if arg_8_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
				end

				return
			end)

			return
		end)

		local var_6_0 = getProxy(PlayerProxy)

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNameCard(2, getProxy(PlayerProxy):getData().id))

		return
	end, SFX_PANEL)

	self.paintingDefaultAngle = self.uiPaintingTf.localEulerAngles

	setText(self.uiMatchesTitleText, i18n("auction_matches_title"))
	setText(self.uiSuccessCntTitleText, i18n("auction_success_cnt_title"))
	setText(self.uiSuccessRateTitleText, i18n("auction_success_rate_title"))
	setText(self.uiCurrencyTitleText, i18n("auction_currency_title"))
	setText(self.uiTotalProfitTitleText, i18n("auction_total_profit_title"))
	setText(self.uiHighestProfitTitleText, i18n("auction_highest_profit_title"))
	setText(self.uiCollectionTitleText, i18n("auction_collection_type_title"))
	setText(self.uiCollectionPriceTitleText, i18n("auction_collection_price_title"))
	setActive(self.uiShareBtn, false)

	return
end

function AuctionGameNameCardLayer:didEnter()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBg
		}
	})

	local var_9_0 = getProxy(PlayerProxy)
	local var_9_1 = getProxy(PlayerProxy):getRawData()

	setText(self.uiNameText, var_9_1.name)
	setText(self.uiUidText, var_9_1.id)

	local var_9_2 = getProxy(UserProxy):getRawData()

	setScrollText(self.uiServerNameText, (getProxy(ServerProxy):getRawData()[(var_9_2 or nil) and (var_9_2.server or 0)] or nil) and (getProxy(ServerProxy):getRawData()[(var_9_2 or nil) and (var_9_2.server or 0)].name or ""))

	local var_9_5 = getProxy(AuctionGameBaseProxy)

	setText(self.uiMatchesCntText, var_9_5.matchNum)
	setText(self.uiSuccessCntText, var_9_5.bidSuccessCnt)
	setText(self.uiSuccessRateText, string.format("%.2f", var_9_5.totalBidPrice == 0 and 0 or var_9_5.totalCollectionPrice / var_9_5.totalBidPrice))
	setText(self.uiCurrencyText, StringHelper.ForamtNumberK(var_9_5.gold))
	setText(self.uiTotalProfitText, StringHelper.ForamtNumberK(var_9_5.totalProfit))
	setText(self.uiHighestProfitText, StringHelper.ForamtNumberK(var_9_5.highestProfit))
	setText(self.uiCollectionText, string.format("<color=#393a3c>%s/</color>%s", var_9_5.unlockCollectionCnt, #pg.auction_collection.all))
	setText(self.uiCollectionPriceText, StringHelper.ForamtNumberK(var_9_5.totalCollectionPrice))

	self.shipVO = getProxy(BayProxy):GetShipPhantom(var_9_1:GetShipPhantomMarks()[1])

	setPaintingPrefabAsync(self.uiPaintingTf, self.shipVO:getPainting(), "biandui", nil, {
		skinID = self.shipVO:getSkinId(),
		rotateZ = self.paintingDefaultAngle.z
	})
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. self.shipVO:getPainting(), "", self.uiIcon)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNameCard(0, var_9_1.id))

	return
end

function AuctionGameNameCardLayer:willExit()
	retPaintingPrefab(self.uiPaintingTf, self.shipVO:getPainting())
	self:UnOverlayPanel(self._tf)

	return
end

return AuctionGameNameCardLayer
