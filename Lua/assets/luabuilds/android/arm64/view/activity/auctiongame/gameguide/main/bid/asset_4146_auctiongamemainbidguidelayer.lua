AuctionGameMainBidLayer = import("view.activity.AuctionGame.game.main.bid.AuctionGameMainBidLayer")

local AuctionGameMainBidGuideLayer = class("AuctionGameMainBidGuideLayer", AuctionGameMainBidLayer)

function AuctionGameMainBidGuideLayer:init()
	AuctionGameMainBidGuideLayer.super.init(self)
	onButton(self, self.uiCloseBtn, function()
		return
	end, SOUND_BACK)
	onButton(self, self.uiBidBtn, function()
		if self.startBid == true then
			return
		end

		local var_3_0 = self.inputNum

		if self.bided then
			return
		end

		local var_3_1 = getProxy(AuctionGameProxy)

		if var_3_1:GetAuctionState() ~= AuctionGameConst.AUCTION_PHASE.BID then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_wait_bid_phase"))
			pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_5")

			return
		end

		local var_3_2 = pg.auction_session[var_3_1:GetAuctionID()].bottom_price

		if var_3_0 < var_3_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_min_bid", var_3_2))
			pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_5")

			return
		end

		if var_3_0 > getProxy(AuctionGameBaseProxy).gold then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_exceeds_max_value"))
			pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_5")

			return
		end

		self.startBid = true

		quickPlayAnimation(self.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end, AuctionGameConst.SOUND_EFFECT.BID)

	return
end

function AuctionGameMainBidGuideLayer:didEnter()
	AuctionGameMainBidGuideLayer.super.didEnter(self)

	local var_4_0 = getProxy(AuctionGameProxy):GetRound()

	if var_4_0 == 1 then
		-- block empty
	elseif var_4_0 >= 2 then
		self.inputNum = 100000
	end

	self:RefreshUI()

	return
end

function AuctionGameMainBidGuideLayer:OnClickBidBtn()
	if getProxy(AuctionGameProxy):GetRound() == 1 then
		AuctionGameTools.GuideBided(self.inputNum)
	else
		AuctionGameTools.GuideBided2(self.inputNum)
	end

	return
end

return AuctionGameMainBidGuideLayer
