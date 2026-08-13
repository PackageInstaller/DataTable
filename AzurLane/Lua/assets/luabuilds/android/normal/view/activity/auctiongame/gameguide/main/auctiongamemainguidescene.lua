import = var_0_10000

local var_0_0 = var_0_10000("view.activity.AuctionGame.game.main.AuctionGameMainScene")

class = AuctionGameMainScene

local var_0_1 = "AuctionGameMainGuideScene"

AuctionGameMainScene = var_0_10002

local var_0_2 = var_0(var_0_1, var_0_10002)

function var_0_2.init(arg_1_0)
	AuctionGameTools = var_1_10001

	var_1_10001.GuideInitPlayerList()
	var_0_2.super.init(arg_1_0)

	return
end

function var_0_2.didEnter(arg_2_0)
	var_0_2.super.didEnter(arg_2_0)

	pg = var_1

	local var_2_0 = var_1.NewStoryMgr.GetInstance()

	if not var_1.IsPlayed(var_2_0, "AUCTION_GUIDE_2") then
		AuctionGameTools = var_1

		var_1.GuideRound1()

		pg = var_1

		local var_2_1 = var_1.SystemGuideMgr.GetInstance()

		var_1.PlayByGuideId(var_2_1, "AUCTION_GUIDE_2", nil, function()
			pg = var_2_10000

			local var_3_0 = var_2_10000.SystemGuideMgr.GetInstance()

			var_0.PlayByGuideId(var_3_0, "AUCTION_GUIDE_5")

			return
		end)
	else
		SetParent = var_1

		local var_2_2 = arg_2_0.uiTopPanel

		pg = var_3

		var_1(var_2_2, var_3.UIMgr.GetInstance().OverlayMain)

		AuctionGameTools = var_1

		var_1.GuideSkipToRound2()

		pg = var_1

		local var_2_3 = var_1.SystemGuideMgr.GetInstance()

		var_1.PlayByGuideId(var_2_3, "AUCTION_GUIDE_6", {
			0
		})
	end

	return
end

function var_0_2.InitRightView(arg_4_0)
	AuctionGameMainRightGuideView = var_1_10001
	arg_4_0.rightPanelView = var_1_10001.New(arg_4_0.uiRightPanel, arg_4_0)

	return
end

function var_0_2.RefreshReadyPanel(arg_5_0)
	return
end

function var_0_2.OnStartRoundOver(arg_6_0)
	local var_6_0 = arg_6_0

	arg_6_0.AddRoundOverTimer(var_6_0)

	getProxy = var_1
	AuctionGameProxy = var_6_0

	local var_6_1 = var_1(var_6_0)

	if var_1.GetRound(var_6_1) == 1 then
		pg = var_2
		var_6_1 = var_2.SystemGuideMgr.GetInstance()

		var_2.PlayByGuideId(var_6_1, "AUCTION_GUIDE_6", {
			1
		})
	end

	getProxy = var_2
	AuctionGameProxy = var_6_1

	local var_6_2 = var_2(var_6_1)
	local var_6_3 = var_2.GetTimestamp(var_6_2)

	pg = var_6_2

	local var_6_4 = var_6_2.TimeMgr.GetInstance()

	if var_6_3 - var_3.GetServerTime(var_6_4) > 0 then
		local var_6_5 = arg_6_0
		local var_6_6 = arg_6_0.emit

		BaseUI = var_1_10006

		local var_6_7 = var_1_10006.ON_ADD_SUBLAYER

		Context = var_1_10007

		local var_6_8 = var_1_10007.New
		local var_6_9 = {}

		AuctionGameMainRoundOverLayer = var_1_10009
		var_6_9.viewComponent = var_1_10009
		AuctionGameMainRoundOverMediator = var_1_10009
		var_6_9.mediator = var_1_10009

		var_6_6(var_6_5, var_6_7, var_6_8(var_6_9))
	end

	return
end

function var_0_2.AddTimer(arg_7_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1 = var_1.GetTimestamp(var_7_0)

	pg = var_7_0

	local var_7_2 = var_7_0.TimeMgr.GetInstance()
	local var_7_3 = var_7_1 - var_3.GetServerTime(var_7_2)

	setText = var_7_2

	var_7_2(arg_7_0.uiCdText, var_7_3 .. "<size=30>s</size>")

	return
end

function var_0_2.AddRoundOverTimer(arg_8_0)
	arg_8_0:StopTimer()

	Timer = var_1
	arg_8_0.timer = var_1.New(function()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10001

		local var_9_0 = var_2_10000(var_2_10001)
		local var_9_1 = var_0.GetTimestamp(var_9_0)

		pg = var_9_0

		local var_9_2 = var_9_0.TimeMgr.GetInstance()

		if var_9_1 - var_2.GetServerTime(var_9_2) < 0 then
			local var_9_3 = arg_8_0

			var_3.StopTimer(var_9_3)

			if var_0:GetRound() == 1 then
				pg = var_3

				local var_9_4 = var_3.NewGuideMgr.GetInstance()

				var_3.NextStep(var_9_4)

				AuctionGameTools = var_3

				var_3.GuideRound2()
			else
				pg = var_3

				local var_9_5 = var_3.NewGuideMgr.GetInstance()

				var_3.NextStep(var_9_5)

				AuctionGameTools = var_3

				var_3.GuideSettlement()
			end

			return
		end

		setText = var_3

		var_3(arg_8_0.uiCdText, var_2 .. "<size=30>s</size>")

		return
	end, 0.5, -1)

	local var_8_0 = arg_8_0.timer

	var_1.Start(var_8_0)
	arg_8_0.timer.func()

	return
end

function var_0_2.StopTimer(arg_10_0)
	if arg_10_0.timer then
		local var_10_0 = arg_10_0.timer

		var_1.Stop(var_10_0)

		arg_10_0.timer = nil
	end

	return
end

return var_0_2
