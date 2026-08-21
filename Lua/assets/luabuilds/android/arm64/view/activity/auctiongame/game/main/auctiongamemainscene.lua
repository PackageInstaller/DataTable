local var_0_0 = class("AuctionGameMainScene", import("view.base.BaseUI"))

var_0_0.SHOW_FILTER_EVENT = "AuctionGameMainScene::SHOW_FILTER_EVENT"

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.leftPanelView = AuctionGameMainLeftView.New(arg_2_0.uiLeftPanel, arg_2_0)

	arg_2_0:InitRightView()
	setText(arg_2_0.uiCdText, "--")
	arg_2_0:RefreshRoundText(1)
	setText(arg_2_0.uiCollectionText, i18n("auction_main_handbook"))
	setText(arg_2_0.uiBoardText, i18n("auction_main_public_notice"))
	onButton(arg_2_0, arg_2_0.uiCollectionBtn, function()
		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameCollectionListLayer,
			mediator = AuctionGameCollectionListMediator
		}))

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiBoardBtn, function()
		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainNoticeBoardLayer,
			mediator = AuctionGameMainNoticeBoardMediator
		}))

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiHideBtn, function()
		arg_2_0:HideFilterEventPanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_6_0)
	Screen.sleepTimeout = SleepTimeout.NeverSleep

	arg_6_0.leftPanelView:didEnter()
	arg_6_0.rightPanelView:didEnter()

	local var_6_0 = getProxy(AuctionGameProxy)

	if var_6_0:GetRound() < 1 then
		if table.keyof(var_6_0:GetLeaverList(), getProxy(PlayerProxy):getPlayerId()) then
			arg_6_0:OnKick()
		else
			arg_6_0:RefreshReadyPanel()
		end
	else
		arg_6_0:RefreshRound()
	end

	arg_6_0.eventList = {
		arg_6_0:bind(var_0_0.SHOW_FILTER_EVENT, handler(arg_6_0, arg_6_0.OnShowFilterEventPanel))
	}

	return
end

function var_0_0.InitRightView(arg_7_0)
	arg_7_0.rightPanelView = AuctionGameMainRightView.New(arg_7_0.uiRightPanel, arg_7_0)

	return
end

function var_0_0.OnStartBid(arg_8_0)
	pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_bid_phase"))
	arg_8_0.rightPanelView:StartBid()
	arg_8_0:AddTimer()

	return
end

function var_0_0.OnBidDone(arg_9_0, arg_9_1)
	arg_9_0.rightPanelView:RefreshBidDone(arg_9_1)

	return
end

function var_0_0.OnStartRoundOver(arg_10_0)
	arg_10_0:HideFilterEventPanel()
	arg_10_0:AddTimer()

	if getProxy(AuctionGameProxy):GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime() > 0 then
		arg_10_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainRoundOverLayer,
			mediator = AuctionGameMainRoundOverMediator
		}))
	end

	return
end

function var_0_0.OnKick(arg_11_0)
	local var_11_0 = getProxy(AuctionGameProxy)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionExit(var_11_0:GetAuctionID(), var_11_0:GetRound()))
	arg_11_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainMsgLayer,
		mediator = AuctionGameMainMsgMediator,
		data = {
			content = i18n("auction_game_kick"),
			comformCallback = function()
				arg_11_0:closeView()

				return
			end,
			cancelCallback = function()
				arg_11_0:closeView()

				return
			end
		}
	}))

	return
end

function var_0_0.OnReconnection(arg_14_0)
	arg_14_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainMsgLayer,
		mediator = AuctionGameMainMsgMediator,
		data = {
			content = i18n("auction_network_timeout"),
			comformCallback = function()
				arg_14_0:closeView()

				return
			end,
			cancelCallback = function()
				arg_14_0:closeView()

				return
			end
		}
	}))

	return
end

function var_0_0.OnNoBid(arg_17_0)
	local var_17_0 = getProxy(AuctionGameProxy)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionFinish(var_17_0:GetAuctionID(), var_17_0:GetRound(), 1))
	arg_17_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainMsgLayer,
		mediator = AuctionGameMainMsgMediator,
		data = {
			content = i18n("auction_game_nobid_tip"),
			comformCallback = function()
				arg_17_0:emit(AuctionGameMainMediator.EXIT)

				return
			end,
			cancelCallback = function()
				arg_17_0:emit(AuctionGameMainMediator.EXIT)

				return
			end
		}
	}))

	return
end

function var_0_0.RefreshReadyPanel(arg_20_0)
	arg_20_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainReadyLayer,
		mediator = AuctionGameMainReadyMediator
	}))

	return
end

function var_0_0.RefreshRound(arg_21_0)
	local var_21_0 = getProxy(AuctionGameProxy):GetRound()

	if var_21_0 == 1 then
		SetParent(arg_21_0.uiTopPanel, pg.UIMgr.GetInstance().OverlayMain)
	end

	arg_21_0:RefreshRoundText(var_21_0)
	arg_21_0.leftPanelView:RefreshRound()
	arg_21_0.rightPanelView:RefreshRound()
	arg_21_0:AddTimer()

	return
end

function var_0_0.RefreshRoundText(arg_22_0, arg_22_1)
	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_round_%s", arg_22_1), function(arg_23_0)
		if not IsNil(arg_22_0.uiRoundImage) then
			arg_22_0.uiRoundImage.sprite = arg_23_0
		end

		return
	end)

	return
end

function var_0_0.AddTimer(arg_24_0)
	arg_24_0:StopTimer()

	arg_24_0.timer = Timer.New(function()
		local var_25_0 = getProxy(AuctionGameProxy):GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()

		if var_25_0 < 0 then
			var_25_0 = 0

			if getProxy(AuctionGameProxy):GetAuctionState() == AuctionGameConst.AUCTION_PHASE.ROUND_OVER and AuctionGameTools.IsNoBid() then
				arg_24_0:StopTimer()
				arg_24_0:OnNoBid()
			end
		end

		if var_25_0 < 10 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.COUNTDOWN)
		end

		setText(arg_24_0.uiCdText, var_25_0 .. "<size=30>s</size>")

		return
	end, 1, -1)

	arg_24_0.timer:Start()
	arg_24_0.timer.func()

	return
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.timer then
		arg_26_0.timer:Stop()

		arg_26_0.timer = nil
	end

	return
end

function var_0_0.OnShowFilterEventPanel(arg_27_0, arg_27_1, arg_27_2)
	setActive(arg_27_0.uiHideBtn, true)
	setParent(arg_27_2, arg_27_0.uiHideBtn, true)
	setParent(arg_27_0.uiHideBtn, pg.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_0.HideFilterEventPanel(arg_28_0)
	setActive(arg_28_0.uiHideBtn, false)

	return
end

function var_0_0.willExit(arg_29_0)
	setParent(arg_29_0.uiHideBtn, arg_29_0._tf)

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.eventList) do
		arg_29_0:disconnect(iter_29_1)
	end

	arg_29_0.eventList = nil
	Screen.sleepTimeout = getProxy(SettingsProxy):GetMainSceneScreenSleepTime()

	arg_29_0:StopTimer()
	SetParent(arg_29_0.uiTopPanel, arg_29_0._tf)
	arg_29_0.leftPanelView:willExit()

	arg_29_0.leftPanelView = nil

	arg_29_0.rightPanelView:willExit()

	arg_29_0.rightPanelView = nil

	return
end

function var_0_0.onBackPressed(arg_30_0)
	if getProxy(AuctionGameProxy):GetForfeit() then
		arg_30_0:emit(PlayRoomCommonMediator.PLAY_ROOM_MATCH_STOP)
		arg_30_0:emit(AuctionGameMainMediator.EXIT)
	end

	return
end

return var_0_0
