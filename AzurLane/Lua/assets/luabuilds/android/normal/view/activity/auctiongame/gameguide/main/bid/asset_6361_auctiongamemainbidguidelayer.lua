import = var_0_10000

local var_0_0 = var_0_10000("view.activity.AuctionGame.game.main.bid.AuctionGameMainBidLayer")

class = AuctionGameMainBidLayer

local var_0_1 = "AuctionGameMainBidGuideLayer"

AuctionGameMainBidLayer = var_0_10002

local var_0_2 = var_0(var_0_1, var_0_10002)

function var_0_2.init(arg_1_0)
	var_0_2.super.init(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.uiCloseBtn

	local function var_1_2()
		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_1_0, var_1_1, var_1_2, var_1_10005)

	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.uiBidBtn

	local function var_1_5()
		if arg_1_0.startBid == true then
			return
		end

		local var_3_0 = arg_1_0.inputNum

		if arg_1_0.bided then
			return
		end

		getProxy = var_1
		AuctionGameProxy = var_2_10002

		local var_3_1 = var_1(var_2_10002)
		local var_3_2 = var_1.GetAuctionState(var_3_1)

		AuctionGameConst = var_3_1

		local var_3_4

		if var_3_2 ~= var_3_1.AUCTION_PHASE.BID then
			pg = var_3_4

			local var_3_3 = var_3_4.TipsMgr.GetInstance()

			var_3_4 = var_3_4.ShowTips
			i18n = var_2_10005

			var_3_4(var_3_3, var_2_10005("auction_game_wait_bid_phase"))

			pg = var_3_4

			local var_3_5 = var_3_4.SystemGuideMgr.GetInstance()

			var_3_4.PlayByGuideId(var_3_5, "AUCTION_GUIDE_5")

			return
		end

		pg = var_3_4

		local var_3_6 = var_3_4.auction_session
		local var_3_7 = var_1
		local var_3_8

		if var_3_0 < var_3_6[var_1.GetAuctionID(var_3_7)].bottom_price then
			pg = var_3_8
			var_3_7 = var_3_8.TipsMgr.GetInstance()
			var_3_8 = var_3_8.ShowTips
			i18n = var_2_10006

			var_3_8(var_3_7, var_2_10006("auction_game_min_bid", var_3))

			pg = var_3_8
			var_3_7 = var_3_8.SystemGuideMgr.GetInstance()

			var_3_8.PlayByGuideId(var_3_7, "AUCTION_GUIDE_5")

			return
		end

		getProxy = var_3_8
		AuctionGameBaseProxy = var_3_7

		if var_3_8(var_3_7).gold < var_3_0 then
			pg = var_5

			local var_3_9 = var_5.TipsMgr.GetInstance()
			local var_3_10 = var_5.ShowTips

			i18n = var_2_10007

			var_3_10(var_3_9, var_2_10007("auction_game_exceeds_max_value"))

			pg = var_3_10

			local var_3_11 = var_3_10.SystemGuideMgr.GetInstance()

			var_5.PlayByGuideId(var_3_11, "AUCTION_GUIDE_5")

			return
		end

		local var_3_12 = arg_1_0

		var_3_12.startBid = true
		quickPlayAnimation = var_3_12

		var_3_12(arg_1_0.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end

	AuctionGameConst = var_1_10005

	var_1(var_1_3, var_1_4, var_1_5, var_1_10005.SOUND_EFFECT.BID)

	return
end

function var_0_2.didEnter(arg_4_0)
	var_0_2.super.didEnter(arg_4_0)

	getProxy = var_1
	AuctionGameProxy = var_2

	local var_4_0 = var_1(var_2)

	if var_1.GetRound(var_4_0) == 1 then
		-- block empty
	elseif var_2 >= 2 then
		arg_4_0.inputNum = 100000
	end

	arg_4_0:RefreshUI()

	return
end

function var_0_2.OnClickBidBtn(arg_5_0)
	local var_5_0 = arg_5_0.inputNum

	getProxy = var_1_10002
	AuctionGameProxy = var_1_10003

	local var_5_1 = var_1_10002(var_1_10003)

	if var_2.GetRound(var_5_1) == 1 then
		AuctionGameTools = var_5_1

		var_5_1.GuideBided(var_5_0)
	else
		AuctionGameTools = var_5_1

		var_5_1.GuideBided2(var_5_0)
	end

	return
end

return var_0_2
