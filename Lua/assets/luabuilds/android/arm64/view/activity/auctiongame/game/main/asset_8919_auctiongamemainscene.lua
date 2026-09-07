local AuctionGameMainScene = class("AuctionGameMainScene", import("view.base.BaseUI"))

AuctionGameMainScene.SHOW_FILTER_EVENT = "AuctionGameMainScene::SHOW_FILTER_EVENT"

function AuctionGameMainScene:getUIName()
	return "AuctionGameMainUI"
end

function AuctionGameMainScene:init()
	self.leftPanelView = AuctionGameMainLeftView.New(self.uiLeftPanel, self)

	self:InitRightView()
	setText(self.uiCdText, "--")
	self:RefreshRoundText(1)
	setText(self.uiCollectionText, i18n("auction_main_handbook"))
	setText(self.uiBoardText, i18n("auction_main_public_notice"))
	onButton(self, self.uiCollectionBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameCollectionListLayer,
			mediator = AuctionGameCollectionListMediator
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiBoardBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainNoticeBoardLayer,
			mediator = AuctionGameMainNoticeBoardMediator
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiHideBtn, function()
		self:HideFilterEventPanel()

		return
	end, SFX_PANEL)

	return
end

function AuctionGameMainScene:didEnter()
	Screen.sleepTimeout = SleepTimeout.NeverSleep

	self.leftPanelView:didEnter()
	self.rightPanelView:didEnter()

	local var_6_0 = getProxy(AuctionGameProxy)

	if var_6_0:GetRound() < 1 then
		if table.keyof(var_6_0:GetLeaverList(), getProxy(PlayerProxy):getPlayerId()) then
			self:OnKick()
		else
			self:RefreshReadyPanel()
		end
	else
		self:RefreshRound()
	end

	self.eventList = {
		self:bind(AuctionGameMainScene.SHOW_FILTER_EVENT, handler(self, self.OnShowFilterEventPanel))
	}

	return
end

function AuctionGameMainScene:InitRightView()
	self.rightPanelView = AuctionGameMainRightView.New(self.uiRightPanel, self)

	return
end

function AuctionGameMainScene:OnStartBid()
	pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_bid_phase"))
	self.rightPanelView:StartBid()
	self:AddTimer()

	return
end

function AuctionGameMainScene:OnBidDone(arg_9_1)
	self.rightPanelView:RefreshBidDone(arg_9_1)

	return
end

function AuctionGameMainScene:OnStartRoundOver()
	self:HideFilterEventPanel()
	self:AddTimer()

	if getProxy(AuctionGameProxy):GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime() > 0 then
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainRoundOverLayer,
			mediator = AuctionGameMainRoundOverMediator
		}))
	end

	return
end

function AuctionGameMainScene:OnKick()
	local var_11_0 = getProxy(AuctionGameProxy)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionExit(var_11_0:GetAuctionID(), var_11_0:GetRound()))
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainMsgLayer,
		mediator = AuctionGameMainMsgMediator,
		data = {
			content = i18n("auction_game_kick"),
			comformCallback = function()
				self:closeView()

				return
			end,
			cancelCallback = function()
				self:closeView()

				return
			end
		}
	}))

	return
end

function AuctionGameMainScene:OnReconnection()
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainMsgLayer,
		mediator = AuctionGameMainMsgMediator,
		data = {
			content = i18n("auction_network_timeout"),
			comformCallback = function()
				self:closeView()

				return
			end,
			cancelCallback = function()
				self:closeView()

				return
			end
		}
	}))

	return
end

function AuctionGameMainScene:OnNoBid()
	local var_17_0 = getProxy(AuctionGameProxy)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionFinish(var_17_0:GetAuctionID(), var_17_0:GetRound(), 1))
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainMsgLayer,
		mediator = AuctionGameMainMsgMediator,
		data = {
			content = i18n("auction_game_nobid_tip"),
			comformCallback = function()
				self:emit(AuctionGameMainMediator.EXIT)

				return
			end,
			cancelCallback = function()
				self:emit(AuctionGameMainMediator.EXIT)

				return
			end
		}
	}))

	return
end

function AuctionGameMainScene:RefreshReadyPanel()
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainReadyLayer,
		mediator = AuctionGameMainReadyMediator
	}))

	return
end

function AuctionGameMainScene:RefreshRound()
	local var_21_0 = getProxy(AuctionGameProxy):GetRound()

	if var_21_0 == 1 then
		SetParent(self.uiTopPanel, pg.UIMgr.GetInstance().OverlayMain)
	end

	self:RefreshRoundText(var_21_0)
	self.leftPanelView:RefreshRound()
	self.rightPanelView:RefreshRound()
	self:AddTimer()

	return
end

function AuctionGameMainScene:RefreshRoundText(arg_22_1)
	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_round_%s", arg_22_1), function(arg_23_0)
		if not IsNil(self.uiRoundImage) then
			self.uiRoundImage.sprite = arg_23_0
		end

		return
	end)

	return
end

function AuctionGameMainScene:AddTimer()
	self:StopTimer()

	self.timer = Timer.New(function()
		local var_25_0 = getProxy(AuctionGameProxy):GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()

		if var_25_0 < 0 then
			var_25_0 = 0

			if getProxy(AuctionGameProxy):GetAuctionState() == AuctionGameConst.AUCTION_PHASE.ROUND_OVER and AuctionGameTools.IsNoBid() then
				self:StopTimer()
				self:OnNoBid()
			end
		end

		if var_25_0 < 10 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.COUNTDOWN)
		end

		setText(self.uiCdText, var_25_0 .. "<size=30>s</size>")

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function AuctionGameMainScene:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function AuctionGameMainScene:OnShowFilterEventPanel(arg_27_1, arg_27_2)
	setActive(self.uiHideBtn, true)
	setParent(arg_27_2, self.uiHideBtn, true)
	setParent(self.uiHideBtn, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function AuctionGameMainScene:HideFilterEventPanel()
	setActive(self.uiHideBtn, false)

	return
end

function AuctionGameMainScene:willExit()
	setParent(self.uiHideBtn, self._tf)

	for iter_29_0, iter_29_1 in ipairs(self.eventList) do
		self:disconnect(iter_29_1)
	end

	self.eventList = nil
	Screen.sleepTimeout = getProxy(SettingsProxy):GetMainSceneScreenSleepTime()

	self:StopTimer()
	SetParent(self.uiTopPanel, self._tf)
	self.leftPanelView:willExit()

	self.leftPanelView = nil

	self.rightPanelView:willExit()

	self.rightPanelView = nil

	return
end

function AuctionGameMainScene:onBackPressed()
	if getProxy(AuctionGameProxy):GetForfeit() then
		self:emit(PlayRoomCommonMediator.PLAY_ROOM_MATCH_STOP)
		self:emit(AuctionGameMainMediator.EXIT)
	end

	return
end

return AuctionGameMainScene
