AuctionGameMainScene = import("view.activity.AuctionGame.game.main.AuctionGameMainScene")

local var_0_0 = class("AuctionGameMainGuideScene", AuctionGameMainScene)

function var_0_0.init(arg_1_0)
	AuctionGameTools.GuideInitPlayerList()
	var_0_0.super.init(arg_1_0)

	return
end

function var_0_0.didEnter(arg_2_0)
	var_0_0.super.didEnter(arg_2_0)

	if not pg.NewStoryMgr.GetInstance():IsPlayed("AUCTION_GUIDE_2") then
		AuctionGameTools.GuideRound1()
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_2", nil, function()
			pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_5")

			return
		end)
	else
		SetParent(arg_2_0.uiTopPanel, pg.UIMgr.GetInstance().OverlayMain)
		AuctionGameTools.GuideSkipToRound2()
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_6", {
			0
		})
	end

	return
end

function var_0_0.InitRightView(arg_4_0)
	arg_4_0.rightPanelView = AuctionGameMainRightGuideView.New(arg_4_0.uiRightPanel, arg_4_0)

	return
end

function var_0_0.RefreshReadyPanel(arg_5_0)
	return
end

function var_0_0.OnStartRoundOver(arg_6_0)
	arg_6_0:AddRoundOverTimer()

	if getProxy(AuctionGameProxy):GetRound() == 1 then
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_6", {
			1
		})
	end

	local var_6_0 = getProxy(AuctionGameProxy)

	if var_6_0:GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime() > 0 then
		arg_6_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainRoundOverLayer,
			mediator = AuctionGameMainRoundOverMediator
		}))
	end

	return
end

function var_0_0.AddTimer(arg_7_0)
	setText(arg_7_0.uiCdText, getProxy(AuctionGameProxy):GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime() .. "<size=30>s</size>")

	return
end

function var_0_0.AddRoundOverTimer(arg_8_0)
	arg_8_0:StopTimer()

	arg_8_0.timer = Timer.New(function()
		local var_9_0 = getProxy(AuctionGameProxy)
		local var_9_1 = var_9_0:GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()

		if var_9_1 < 0 then
			arg_8_0:StopTimer()

			if var_9_0:GetRound() == 1 then
				pg.NewGuideMgr.GetInstance():NextStep()
				AuctionGameTools.GuideRound2()
			else
				pg.NewGuideMgr.GetInstance():NextStep()
				AuctionGameTools.GuideSettlement()
			end

			return
		end

		setText(arg_8_0.uiCdText, var_9_1 .. "<size=30>s</size>")

		return
	end, 0.5, -1)

	arg_8_0.timer:Start()
	arg_8_0.timer.func()

	return
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end

	return
end

return var_0_0
