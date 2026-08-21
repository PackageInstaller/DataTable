AuctionGameMainBidLayer = import("view.activity.AuctionGame.game.main.bid.AuctionGameMainBidLayer")

local var_0_0 = class("AuctionGameMainBidGuideLayer", AuctionGameMainBidLayer)

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)
	onButton(arg_1_0, arg_1_0.uiCloseBtn, function()
		return
	end, SOUND_BACK)
	onButton(arg_1_0, arg_1_0.uiBidBtn, function()
		if arg_1_0.startBid == true then
			return
		end

		local var_3_0 = arg_1_0.inputNum

		if arg_1_0.bided then
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

		arg_1_0.startBid = true

		quickPlayAnimation(arg_1_0.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end, AuctionGameConst.SOUND_EFFECT.BID)

	return
end

function var_0_0.didEnter(arg_4_0)
	var_0_0.super.didEnter(arg_4_0)

	local var_4_0 = getProxy(AuctionGameProxy):GetRound()

	if var_4_0 == 1 then
		-- block empty
	elseif var_4_0 >= 2 then
		arg_4_0.inputNum = 100000
	end

	arg_4_0:RefreshUI()

	return
end

function var_0_0.OnClickBidBtn(arg_5_0)
	if getProxy(AuctionGameProxy):GetRound() == 1 then
		AuctionGameTools.GuideBided(arg_5_0.inputNum)
	else
		AuctionGameTools.GuideBided2(arg_5_0.inputNum)
	end

	return
end

return var_0_0
