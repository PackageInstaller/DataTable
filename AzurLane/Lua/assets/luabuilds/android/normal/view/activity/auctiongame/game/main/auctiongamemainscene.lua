class = var_0_10000

local var_0_0 = "AuctionGameMainScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.SHOW_FILTER_EVENT = "AuctionGameMainScene::SHOW_FILTER_EVENT"

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainUI"
end

function var_0_1.init(arg_2_0)
	AuctionGameMainLeftView = var_1_10001
	arg_2_0.leftPanelView = var_1_10001.New(arg_2_0.uiLeftPanel, arg_2_0)

	arg_2_0:InitRightView()

	setText = var_1

	var_1(arg_2_0.uiCdText, "--")
	arg_2_0:RefreshRoundText(1)

	setText = var_1

	local var_2_0 = arg_2_0.uiCollectionText

	i18n = var_3

	var_1(var_2_0, var_3("auction_main_handbook"))

	setText = var_1

	local var_2_1 = arg_2_0.uiBoardText

	i18n = var_3

	var_1(var_2_1, var_3("auction_main_public_notice"))

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.uiCollectionBtn

	local function var_2_4()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		BaseUI = var_2_10002

		local var_3_2 = var_2_10002.ON_ADD_SUBLAYER

		Context = var_2_10003

		local var_3_3 = var_2_10003.New
		local var_3_4 = {}

		AuctionGameCollectionListLayer = var_2_10005
		var_3_4.viewComponent = var_2_10005
		AuctionGameCollectionListMediator = var_2_10005
		var_3_4.mediator = var_2_10005

		var_3_1(var_3_0, var_3_2, var_3_3(var_3_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_2, var_2_3, var_2_4, var_1_10005)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.uiBoardBtn

	local function var_2_7()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		BaseUI = var_2_10002

		local var_4_2 = var_2_10002.ON_ADD_SUBLAYER

		Context = var_2_10003

		local var_4_3 = var_2_10003.New
		local var_4_4 = {}

		AuctionGameMainNoticeBoardLayer = var_2_10005
		var_4_4.viewComponent = var_2_10005
		AuctionGameMainNoticeBoardMediator = var_2_10005
		var_4_4.mediator = var_2_10005

		var_4_1(var_4_0, var_4_2, var_4_3(var_4_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_5, var_2_6, var_2_7, var_1_10005)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.uiHideBtn

	local function var_2_10()
		local var_5_0 = arg_2_0

		var_0.HideFilterEventPanel(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_8, var_2_9, var_2_10, var_1_10005)

	return
end

function var_0_1.didEnter(arg_6_0)
	Screen = var_1_10001
	SleepTimeout = var_1_10002
	var_1_10001.sleepTimeout = var_1_10002.NeverSleep

	local var_6_0 = arg_6_0.leftPanelView

	var_1.didEnter(var_6_0)

	local var_6_1 = arg_6_0.rightPanelView

	var_1.didEnter(var_6_1)

	getProxy = var_1
	AuctionGameProxy = var_6_1

	local var_6_2 = var_1(var_6_1)

	if var_1.GetRound(var_6_2) < 1 then
		table = var_3

		local var_6_3 = var_3.keyof
		local var_6_4 = var_1
		local var_6_5 = var_1.GetLeaverList(var_6_4)

		getProxy = var_6_4
		PlayerProxy = var_1_10006

		local var_6_6 = var_6_4(var_1_10006)

		if var_6_3(var_6_5, var_5.getPlayerId(var_6_6)) then
			arg_6_0:OnKick()
		else
			arg_6_0:RefreshReadyPanel()
		end
	else
		arg_6_0:RefreshRound()
	end

	local var_6_7 = {}
	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.bind
	local var_6_10 = var_0_1.SHOW_FILTER_EVENT

	handler = var_1_10007
	var_6_7[1] = var_6_9(var_6_8, var_6_10, var_1_10007(arg_6_0, arg_6_0.OnShowFilterEventPanel))
	arg_6_0.eventList = var_6_7

	return
end

function var_0_1.InitRightView(arg_7_0)
	AuctionGameMainRightView = var_1_10001
	arg_7_0.rightPanelView = var_1_10001.New(arg_7_0.uiRightPanel, arg_7_0)

	return
end

function var_0_1.OnStartBid(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.TipsMgr.GetInstance()
	local var_8_1 = var_1.ShowTips

	i18n = var_1_10003

	var_8_1(var_8_0, var_1_10003("auction_game_bid_phase"))

	local var_8_2 = arg_8_0.rightPanelView

	var_1.StartBid(var_8_2)
	arg_8_0:AddTimer()

	return
end

function var_0_1.OnBidDone(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.rightPanelView

	var_2.RefreshBidDone(var_9_0, arg_9_1)

	return
end

function var_0_1.OnStartRoundOver(arg_10_0)
	arg_10_0:HideFilterEventPanel()

	local var_10_0 = arg_10_0

	arg_10_0.AddTimer(var_10_0)

	getProxy = var_1
	AuctionGameProxy = var_10_0

	local var_10_1 = var_1(var_10_0)
	local var_10_2 = var_1.GetTimestamp(var_10_1)

	pg = var_10_1

	local var_10_3 = var_10_1.TimeMgr.GetInstance()

	if var_10_2 - var_2.GetServerTime(var_10_3) > 0 then
		local var_10_4 = arg_10_0
		local var_10_5 = arg_10_0.emit

		BaseUI = var_1_10005

		local var_10_6 = var_1_10005.ON_ADD_SUBLAYER

		Context = var_1_10006

		local var_10_7 = var_1_10006.New
		local var_10_8 = {}

		AuctionGameMainRoundOverLayer = var_1_10008
		var_10_8.viewComponent = var_1_10008
		AuctionGameMainRoundOverMediator = var_1_10008
		var_10_8.mediator = var_1_10008

		var_10_5(var_10_4, var_10_6, var_10_7(var_10_8))
	end

	return
end

function var_0_1.OnKick(arg_11_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)

	pg = var_1_10002

	local var_11_1 = var_1_10002.GameTrackerMgr.GetInstance()
	local var_11_2 = var_2.Record

	GameTrackerBuilder = var_1_10004

	local var_11_3 = var_1_10004.BuildAuctionExit
	local var_11_4 = var_11_0:GetAuctionID()
	local var_11_5 = var_11_0

	var_11_2(var_11_1, var_11_3(var_11_4, var_11_0.GetRound(var_11_5)))

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.emit

	BaseUI = var_4

	local var_11_8 = var_4.ON_ADD_SUBLAYER

	Context = var_11_4

	local var_11_9 = var_11_4.New
	local var_11_10 = {}

	AuctionGameMainMsgLayer = var_11_5
	var_11_10.viewComponent = var_11_5
	AuctionGameMainMsgMediator = var_11_5
	var_11_10.mediator = var_11_5

	local var_11_11 = {}

	i18n = var_1_10008
	var_11_11.content = var_1_10008("auction_game_kick")

	function var_11_11.comformCallback()
		local var_12_0 = arg_11_0

		var_0.closeView(var_12_0)

		return
	end

	function var_11_11.cancelCallback()
		local var_13_0 = arg_11_0

		var_0.closeView(var_13_0)

		return
	end

	var_11_10.data = var_11_11

	var_11_7(var_11_6, var_11_8, var_11_9(var_11_10))

	return
end

function var_0_1.OnReconnection(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	BaseUI = var_1_10003

	local var_14_2 = var_1_10003.ON_ADD_SUBLAYER

	Context = var_1_10004

	local var_14_3 = var_1_10004.New
	local var_14_4 = {}

	AuctionGameMainMsgLayer = var_1_10006
	var_14_4.viewComponent = var_1_10006
	AuctionGameMainMsgMediator = var_1_10006
	var_14_4.mediator = var_1_10006

	local var_14_5 = {}

	i18n = var_1_10007
	var_14_5.content = var_1_10007("auction_network_timeout")

	function var_14_5.comformCallback()
		local var_15_0 = arg_14_0

		var_0.closeView(var_15_0)

		return
	end

	function var_14_5.cancelCallback()
		local var_16_0 = arg_14_0

		var_0.closeView(var_16_0)

		return
	end

	var_14_4.data = var_14_5

	var_14_1(var_14_0, var_14_2, var_14_3(var_14_4))

	return
end

function var_0_1.OnNoBid(arg_17_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)

	pg = var_1_10002

	local var_17_1 = var_1_10002.GameTrackerMgr.GetInstance()
	local var_17_2 = var_2.Record

	GameTrackerBuilder = var_1_10004

	var_17_2(var_17_1, var_1_10004.BuildAuctionFinish(var_17_0:GetAuctionID(), var_17_0:GetRound(), 1))

	local var_17_3 = arg_17_0
	local var_17_4 = arg_17_0.emit

	BaseUI = var_4

	local var_17_5 = var_4.ON_ADD_SUBLAYER

	Context = var_5

	local var_17_6 = var_5.New
	local var_17_7 = {}

	AuctionGameMainMsgLayer = var_7
	var_17_7.viewComponent = var_7
	AuctionGameMainMsgMediator = var_7
	var_17_7.mediator = var_7

	local var_17_8 = {}

	i18n = var_1_10008
	var_17_8.content = var_1_10008("auction_game_nobid_tip")

	function var_17_8.comformCallback()
		local var_18_0 = arg_17_0
		local var_18_1 = var_0.emit

		AuctionGameMainMediator = var_2_10002

		var_18_1(var_18_0, var_2_10002.EXIT)

		return
	end

	function var_17_8.cancelCallback()
		local var_19_0 = arg_17_0
		local var_19_1 = var_0.emit

		AuctionGameMainMediator = var_2_10002

		var_19_1(var_19_0, var_2_10002.EXIT)

		return
	end

	var_17_7.data = var_17_8

	var_17_4(var_17_3, var_17_5, var_17_6(var_17_7))

	return
end

function var_0_1.RefreshReadyPanel(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.emit

	BaseUI = var_1_10003

	local var_20_2 = var_1_10003.ON_ADD_SUBLAYER

	Context = var_1_10004

	local var_20_3 = var_1_10004.New
	local var_20_4 = {}

	AuctionGameMainReadyLayer = var_1_10006
	var_20_4.viewComponent = var_1_10006
	AuctionGameMainReadyMediator = var_1_10006
	var_20_4.mediator = var_1_10006

	var_20_1(var_20_0, var_20_2, var_20_3(var_20_4))

	return
end

function var_0_1.RefreshRound(arg_21_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_21_0 = var_1_10001(var_1_10002)

	if var_1.GetRound(var_21_0) == 1 then
		SetParent = var_21_0

		local var_21_1 = arg_21_0.uiTopPanel

		pg = var_1_10005

		var_21_0(var_21_1, var_1_10005.UIMgr.GetInstance().OverlayMain)
	end

	arg_21_0:RefreshRoundText(var_2)

	local var_21_2 = arg_21_0.leftPanelView

	var_3.RefreshRound(var_21_2)

	local var_21_3 = arg_21_0.rightPanelView

	var_3.RefreshRound(var_21_3)
	arg_21_0:AddTimer()

	return
end

function var_0_1.RefreshRoundText(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0 = var_1_10002.auction_round[arg_22_1]

	LoadSpriteAtlasAsync = var_1_10003

	local var_22_1 = "ui/auctiongameui_atlas"

	string = var_1_10005

	var_1_10003(var_22_1, var_1_10005.format("main_round_%s", arg_22_1), function(arg_23_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_22_0.uiRoundImage) then
			arg_22_0.uiRoundImage.sprite = arg_23_0
		end

		return
	end)

	return
end

function var_0_1.AddTimer(arg_24_0)
	arg_24_0:StopTimer()

	Timer = var_1
	arg_24_0.timer = var_1.New(function()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10001

		local var_25_0 = var_2_10000(var_2_10001)
		local var_25_1 = var_0.GetTimestamp(var_25_0)

		pg = var_25_0

		local var_25_2 = var_25_0.TimeMgr.GetInstance()
		local var_25_3

		if var_25_1 - var_1.GetServerTime(var_25_2) < 0 then
			var_25_3 = 0
			getProxy = var_2
			AuctionGameProxy = var_2_10003
			var_2_10004 = var_2(var_2_10003)

			local var_25_4 = var_2.GetAuctionState(var_2_10004)

			AuctionGameConst = var_2_10004

			if var_25_4 == var_2_10004.AUCTION_PHASE.ROUND_OVER then
				AuctionGameTools = var_25_4

				if var_25_4.IsNoBid() then
					var_2_10004 = arg_24_0

					var_3.StopTimer(var_2_10004)

					var_2_10004 = arg_24_0

					var_3.OnNoBid(var_2_10004)
				end
			end
		end

		local var_25_6

		if var_25_3 < 10 then
			pg = var_25_6

			local var_25_5 = var_25_6.CriMgr.GetInstance()

			var_25_6 = var_25_6.PlaySoundEffect_V3
			AuctionGameConst = var_2_10004

			var_25_6(var_25_5, var_2_10004.SOUND_EFFECT.COUNTDOWN)
		end

		setText = var_25_6

		var_25_6(arg_24_0.uiCdText, var_25_3 .. "<size=30>s</size>")

		return
	end, 1, -1)

	local var_24_0 = arg_24_0.timer

	var_1.Start(var_24_0)
	arg_24_0.timer.func()

	return
end

function var_0_1.StopTimer(arg_26_0)
	if arg_26_0.timer then
		local var_26_0 = arg_26_0.timer

		var_1.Stop(var_26_0)

		arg_26_0.timer = nil
	end

	return
end

function var_0_1.OnShowFilterEventPanel(arg_27_0, arg_27_1, arg_27_2)
	setActive = var_1_10003

	var_1_10003(arg_27_0.uiHideBtn, true)

	setParent = var_1_10003

	var_1_10003(arg_27_2, arg_27_0.uiHideBtn, true)

	setParent = var_1_10003

	local var_27_0 = arg_27_0.uiHideBtn

	pg = var_5

	var_1_10003(var_27_0, var_5.UIMgr.GetInstance().OverlayMain)

	return
end

function var_0_1.HideFilterEventPanel(arg_28_0)
	setActive = var_1_10001

	var_1_10001(arg_28_0.uiHideBtn, false)

	return
end

function var_0_1.willExit(arg_29_0)
	setParent = var_1_10001

	var_1_10001(arg_29_0.uiHideBtn, arg_29_0._tf)

	ipairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.eventList) do
		arg_29_0:disconnect(iter_29_1)
	end

	arg_29_0.eventList = nil
	getProxy = var_1
	SettingsProxy = var_2

	local var_29_0 = var_1(var_2)

	var_29_0.sleepTimeout, Screen = var_1.GetMainSceneScreenSleepTime(var_29_0), var_29_0

	arg_29_0:StopTimer()

	SetParent = var_2

	var_2(arg_29_0.uiTopPanel, arg_29_0._tf)

	local var_29_1 = arg_29_0.leftPanelView

	var_2.willExit(var_29_1)

	arg_29_0.leftPanelView = nil

	local var_29_2 = arg_29_0.rightPanelView

	var_2.willExit(var_29_2)

	arg_29_0.rightPanelView = nil

	return
end

function var_0_1.onBackPressed(arg_30_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_30_0 = var_1_10001(var_1_10002)

	if var_1.GetForfeit(var_30_0) then
		local var_30_1 = arg_30_0
		local var_30_2 = arg_30_0.emit

		PlayRoomCommonMediator = var_1_10004

		var_30_2(var_30_1, var_1_10004.PLAY_ROOM_MATCH_STOP)

		local var_30_3 = arg_30_0
		local var_30_4 = arg_30_0.emit

		AuctionGameMainMediator = var_4

		var_30_4(var_30_3, var_4.EXIT)
	end

	return
end

return var_0_1
