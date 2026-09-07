AuctionGameMainScene = import("view.activity.AuctionGame.game.main.AuctionGameMainScene")

local AuctionGameMainGuideScene = class("AuctionGameMainGuideScene", AuctionGameMainScene)

function AuctionGameMainGuideScene:init()
	AuctionGameTools.GuideInitPlayerList()
	AuctionGameMainGuideScene.super.init(self)

	return
end

function AuctionGameMainGuideScene:didEnter()
	AuctionGameMainGuideScene.super.didEnter(self)

	if not pg.NewStoryMgr.GetInstance():IsPlayed("AUCTION_GUIDE_2") then
		AuctionGameTools.GuideRound1()
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_2", nil, function()
			pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_5")

			return
		end)
	else
		SetParent(self.uiTopPanel, pg.UIMgr.GetInstance().OverlayMain)
		AuctionGameTools.GuideSkipToRound2()
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_6", {
			0
		})
	end

	return
end

function AuctionGameMainGuideScene:InitRightView()
	self.rightPanelView = AuctionGameMainRightGuideView.New(self.uiRightPanel, self)

	return
end

function AuctionGameMainGuideScene:RefreshReadyPanel()
	return
end

function AuctionGameMainGuideScene:OnStartRoundOver()
	self:AddRoundOverTimer()

	if getProxy(AuctionGameProxy):GetRound() == 1 then
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_6", {
			1
		})
	end

	if getProxy(AuctionGameProxy):GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime() > 0 then
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainRoundOverLayer,
			mediator = AuctionGameMainRoundOverMediator
		}))
	end

	return
end

function AuctionGameMainGuideScene:AddTimer()
	setText(self.uiCdText, getProxy(AuctionGameProxy):GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime() .. "<size=30>s</size>")

	return
end

function AuctionGameMainGuideScene:AddRoundOverTimer()
	self:StopTimer()

	self.timer = Timer.New(function()
		local var_9_0 = getProxy(AuctionGameProxy)
		local var_9_1 = var_9_0:GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()

		if var_9_1 < 0 then
			self:StopTimer()

			if var_9_0:GetRound() == 1 then
				pg.NewGuideMgr.GetInstance():NextStep()
				AuctionGameTools.GuideRound2()
			else
				pg.NewGuideMgr.GetInstance():NextStep()
				AuctionGameTools.GuideSettlement()
			end

			return
		end

		setText(self.uiCdText, var_9_1 .. "<size=30>s</size>")

		return
	end, 0.5, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function AuctionGameMainGuideScene:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return AuctionGameMainGuideScene
