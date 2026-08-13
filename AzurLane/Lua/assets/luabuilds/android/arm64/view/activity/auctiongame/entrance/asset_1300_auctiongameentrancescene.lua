class = var_0_10000

local var_0_0 = "AuctionGameEntranceScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameEntranceUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiAuctionValueTitleText

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("auction_value"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiAuctionTicketTitleText

	i18n = var_4

	var_1_10001(var_2_1, var_4("auction_ticket"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.uiAuctionMatchingText

	i18n = var_4

	var_1_10001(var_2_2, var_4("auction_matching"))

	setText = var_1_10001

	local var_2_3 = arg_2_0.uiAuctionAssistantText

	i18n = var_4

	var_1_10001(var_2_3, var_4("auction_assistant"))

	setText = var_1_10001

	local var_2_4 = arg_2_0.uiPreorderEndText

	i18n = var_4

	var_1_10001(var_2_4, var_4("auction_activity_closed"))

	setText = var_1_10001

	local var_2_5 = arg_2_0.uiReliefText

	i18n = var_4

	var_1_10001(var_2_5, var_4("auction_relief_tip"))

	GetComponent = var_1_10001

	local var_2_6 = arg_2_0.uiMatchBtn

	typeof = var_4
	DftAniEvent = var_6
	arg_2_0.matchEventCom = var_1_10001(var_2_6, var_4(var_6))

	local var_2_7 = arg_2_0.matchEventCom

	var_1.SetEndEvent(var_2_7, function(arg_3_0)
		arg_2_0.startMatch = false

		local var_3_0 = arg_2_0
		local var_3_1 = var_1.emit

		PlayRoomCommonMediator = var_2_10004

		local var_3_2 = var_2_10004.ON_CLICK_QUICK_MATCH
		local var_3_3 = {}

		pg = var_2_10006
		var_3_3.type = var_2_10006.auction_session[arg_2_0.curSelectedID].game_type

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.uiBackBtn

	local function var_2_10()
		local var_4_0 = arg_2_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SOUND_BACK = var_6

	var_1(var_2_8, var_2_9, var_2_10, var_6)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.uiHelpBtn

	local function var_2_13()
		pg = var_2_10000

		local var_5_0 = var_2_10000.GameTrackerMgr.GetInstance()
		local var_5_1 = var_0.Record

		GameTrackerBuilder = var_2_10003

		var_5_1(var_5_0, var_2_10003.BuildAuctionHelp())

		pg = var_5_1

		local var_5_2 = var_5_1.MsgboxMgr.GetInstance()
		local var_5_3 = var_0.ShowMsgBox
		local var_5_4 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_4.type = var_2_10004
		pg = var_2_10004
		var_5_4.helps = var_2_10004.gametip.auction_help.tip

		var_5_3(var_5_2, var_5_4)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_11, var_2_12, var_2_13, var_6)

	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.uiCollectionBtn

	local function var_2_16()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10003

		local var_6_2 = var_2_10003.ON_ADD_SUBLAYER

		Context = var_2_10004

		local var_6_3 = var_2_10004.New
		local var_6_4 = {}

		AuctionGameCollectionListLayer = var_2_10007
		var_6_4.viewComponent = var_2_10007
		AuctionGameCollectionListMediator = var_2_10007
		var_6_4.mediator = var_2_10007

		var_6_1(var_6_0, var_6_2, var_6_3(var_6_4))

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_14, var_2_15, var_2_16, var_6)

	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.uiTaskBtn

	local function var_2_19()
		if not arg_2_0.quickMatchSuccess and arg_2_0.startQuickMatch == true then
			local var_7_0 = arg_2_0
			local var_7_1 = var_0.emit

			BaseUI = var_2_10003
			var_2_10003 = var_2_10003.ON_ADD_SUBLAYER
			Context = var_2_10004
			var_2_10004 = var_2_10004.New

			local var_7_2 = {}

			AuctionGameMainMsgLayer = var_2_10007
			var_7_2.viewComponent = var_2_10007
			AuctionGameMainMsgMediator = var_2_10007
			var_7_2.mediator = var_2_10007
			var_2_10007 = {}
			i18n = var_2_10008
			var_2_10007.content = var_2_10008("auction_main_match_exit")

			function var_2_10007.comformCallback()
				local var_8_0 = arg_2_0

				var_0.OnClickStopQuickMatch(var_8_0)

				local var_8_1 = arg_2_0
				local var_8_2 = var_0.emit

				BaseUI = var_3_10003

				local var_8_3 = var_3_10003.ON_ADD_SUBLAYER

				Context = var_3_10004

				local var_8_4 = var_3_10004.New
				local var_8_5 = {}

				AuctionGameTaskScene = var_3_10007
				var_8_5.viewComponent = var_3_10007
				AuctionGameTaskMediator = var_3_10007
				var_8_5.mediator = var_3_10007
				var_8_5.data = {}

				var_8_2(var_8_1, var_8_3, var_8_4(var_8_5))

				return
			end

			function var_2_10007.cancelCallback()
				return
			end

			var_7_2.data = var_2_10007

			var_7_1(var_7_0, var_2_10003, var_2_10004(var_7_2))
		else
			local var_7_3 = arg_2_0
			local var_7_4 = var_0.emit

			BaseUI = var_2_10003

			local var_7_5 = var_2_10003.ON_ADD_SUBLAYER

			Context = var_2_10004

			local var_7_6 = var_2_10004.New
			local var_7_7 = {}

			AuctionGameTaskScene = var_2_10007
			var_7_7.viewComponent = var_2_10007
			AuctionGameTaskMediator = var_2_10007
			var_7_7.mediator = var_2_10007
			var_7_7.data = {}

			var_7_4(var_7_3, var_7_5, var_7_6(var_7_7))
		end

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_17, var_2_18, var_2_19, var_6)

	onButton = var_1

	local var_2_20 = arg_2_0
	local var_2_21 = arg_2_0.uiPreorderBtn

	local function var_2_22()
		if arg_2_0.startQuickMatch == true then
			return
		end

		getProxy = var_0
		ActivityProxy = var_2_10002

		local var_10_0 = var_0(var_2_10002)
		local var_10_1 = var_0.getActivityByType

		ActivityConst = var_2_10004

		local var_10_2 = var_10_1(var_10_0, var_2_10004.ACTIVITY_TYPE_AUCTION_GAME)

		var_1.SetPreorderTip(var_10_2)

		local var_10_3 = arg_2_0

		var_2.RefreshPreorderTip(var_10_3)

		getProxy = var_2
		AuctionGameBaseProxy = var_10_3

		local var_10_4 = var_2(var_10_3)

		AuctionGameTools = var_10_0

		local var_10_5 = var_10_0.GetPreorderCurrentyCnt()

		AuctionGameTools = var_10_3

		if var_10_3.GetCurrencyCnt() < var_10_5 then
			pg = var_4

			local var_10_6 = var_4.TipsMgr.GetInstance()
			local var_10_7 = var_4.ShowTips

			i18n = var_2_10007

			var_10_7(var_10_6, var_2_10007("auction_currency_noenough"))

			return
		end

		local var_10_8 = arg_2_0
		local var_10_9 = var_4.emit

		BaseUI = var_2_10007

		local var_10_10 = var_2_10007.ON_ADD_SUBLAYER

		Context = var_2_10008

		local var_10_11 = var_2_10008.New
		local var_10_12 = {}

		AuctionGameMainMsgLayer = var_2_10011
		var_10_12.viewComponent = var_2_10011
		AuctionGameMainMsgMediator = var_2_10011
		var_10_12.mediator = var_2_10011

		local var_10_13 = {}

		i18n = var_2_10012
		var_10_13.content = var_2_10012("auction_preorder_tips", var_10_5)

		function var_10_13.comformCallback()
			local var_11_0 = arg_2_0
			local var_11_1 = var_0.emit

			AuctionGameEntranceMediator = var_3_10003

			var_11_1(var_11_0, var_3_10003.CLICK_PREORDER_BOX)

			return
		end

		function var_10_13.cancelCallback()
			return
		end

		var_10_12.data = var_10_13

		var_10_9(var_10_8, var_10_10, var_10_11(var_10_12))

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_20, var_2_21, var_2_22, var_6)

	onButton = var_1

	local var_2_23 = arg_2_0
	local var_2_24 = arg_2_0.uiOpenPreorderBtn

	local function var_2_25()
		if arg_2_0.startQuickMatch == true then
			return
		end

		getProxy = var_0
		AuctionGameBaseProxy = var_2_10002

		local var_13_0 = var_0(var_2_10002)
		local var_13_1 = var_0.GetPreorderState(var_13_0)
		local var_13_2 = var_0
		local var_13_3 = var_0.GetPreorderTimestamp(var_13_2)

		pg = var_13_0

		local var_13_4 = var_13_0.TimeMgr.GetInstance()
		local var_13_5 = var_3.GetServerTime(var_13_4)

		if var_13_1 == 1 and var_13_5 < var_13_3 then
			pg = var_13_2

			local var_13_6 = var_13_2.TipsMgr.GetInstance()
			local var_13_7 = var_4.ShowTips

			i18n = var_2_10007

			var_13_7(var_13_6, var_2_10007("auction_preorder_tips_1"))

			return
		end

		local var_13_8 = arg_2_0
		local var_13_9 = var_4.emit

		AuctionGameEntranceMediator = var_2_10007

		var_13_9(var_13_8, var_2_10007.CLICK_OPEN_BOX)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_23, var_2_24, var_2_25, var_6)

	onButton = var_1

	local var_2_26 = arg_2_0
	local var_2_27 = arg_2_0.uiMatchBtn

	local function var_2_28()
		if arg_2_0.startMatch == true then
			return
		end

		pg = var_0

		local var_14_0 = var_0.NewStoryMgr.GetInstance()
		local var_14_1

		if not var_0.IsPlayed(var_14_0, "AUCTION_GUIDE_6") then
			pg = var_14_1
			var_14_0 = var_14_1.m02
			var_14_1 = var_14_1.sendNotification
			GAME = var_3

			local var_14_2 = var_3.GO_SCENE

			SCENE = var_2_10004

			var_14_1(var_14_0, var_14_2, var_2_10004.AUCTION_GAME_MAIN_GUIDE)

			return
		end

		getProxy = var_14_1
		AuctionGameBaseProxy = var_14_0

		if var_14_1(var_14_0).serverForbidden == 1 then
			pg = var_1

			local var_14_3 = var_1.TipsMgr.GetInstance()
			local var_14_4 = var_1.ShowTips

			i18n = var_2_10004

			var_14_4(var_14_3, var_2_10004("auction_game_match_forbidden"))

			return
		end

		if var_0.isForbidden == 1 then
			pg = var_1

			local var_14_5 = var_1.TipsMgr.GetInstance()
			local var_14_6 = var_1.ShowTips

			i18n = var_2_10004

			var_14_6(var_14_5, var_2_10004("auction_game_match_forbidden"))

			return
		end

		local var_14_8

		if var_0.inactiveNum == 1 and var_0.isMatchWarning == 0 then
			local var_14_7 = arg_2_0

			var_14_8 = var_14_8.emit
			BaseUI = var_2_10004
			var_2_10004 = var_2_10004.ON_ADD_SUBLAYER
			Context = var_2_10005

			local var_14_9 = var_2_10005.New
			local var_14_10 = {}

			AuctionGameMainMsgLayer = var_2_10008
			var_14_10.viewComponent = var_2_10008
			AuctionGameMainMsgMediator = var_2_10008
			var_14_10.mediator = var_2_10008

			local var_14_11 = {}

			i18n = var_2_10009
			var_14_11.content = var_2_10009("auction_game_match_warning")

			function var_14_11.comformCallback()
				return
			end

			function var_14_11.cancelCallback()
				return
			end

			var_14_10.data = var_14_11

			var_14_8(var_14_7, var_2_10004, var_14_9(var_14_10))

			local var_14_12 = arg_2_0

			var_14_8 = var_14_8.emit
			AuctionGameEntranceMediator = var_2_10004

			var_14_8(var_14_12, var_2_10004.SHOW_WARNING_TIP)
		end

		AuctionGameTools = var_14_8

		local var_14_13 = var_14_8.GetCurrencyCnt()

		pg = var_14_0

		if var_14_13 < var_14_0.auction_session[arg_2_0.lastSelectedID].threshold then
			pg = var_14_13

			local var_14_14 = var_14_13.TipsMgr.GetInstance()
			local var_14_15 = var_1.ShowTips

			i18n = var_2_10004

			var_14_15(var_14_14, var_2_10004("auction_currency_noenough"))

			return
		end

		arg_2_0.curSelectedID = arg_2_0.lastSelectedID

		local var_14_16 = arg_2_0

		var_14_16.startMatch = true
		quickPlayAnimation = var_14_16

		var_14_16(arg_2_0.uiMatchBtn, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end

	AuctionGameConst = var_6

	var_1(var_2_26, var_2_27, var_2_28, var_6.SOUND_EFFECT.START_MATCHING)

	onButton = var_1

	local var_2_29 = arg_2_0
	local var_2_30 = arg_2_0.uiCancelMatchBtn

	local function var_2_31()
		local var_17_0 = arg_2_0

		var_0.OnClickStopQuickMatch(var_17_0)

		return
	end

	AuctionGameConst = var_6

	var_1(var_2_29, var_2_30, var_2_31, var_6.SOUND_EFFECT.CANCEL_MATCHING)

	onButton = var_1

	local var_2_32 = arg_2_0
	local var_2_33 = arg_2_0.uiReliefBtn

	local function var_2_34()
		getProxy = var_2_10000
		AuctionGameBaseProxy = var_2_10002

		local var_18_0 = var_2_10000(var_2_10002)

		pg = var_2_10001

		local var_18_1 = var_2_10001.gameset.auction_relief_payment_count.key_value
		local var_18_2 = arg_2_0
		local var_18_3 = var_2.emit

		BaseUI = var_2_10005

		local var_18_4 = var_2_10005.ON_ADD_SUBLAYER

		Context = var_2_10006

		local var_18_5 = var_2_10006.New
		local var_18_6 = {}

		AuctionGameMainMsgLayer = var_2_10009
		var_18_6.viewComponent = var_2_10009
		AuctionGameMainMsgMediator = var_2_10009
		var_18_6.mediator = var_2_10009

		local var_18_7 = {}

		i18n = var_2_10010
		var_18_7.content = var_2_10010("auction_relief_tip_2", var_18_1 - var_18_0.reliefCnt, var_18_1)

		function var_18_7.comformCallback()
			local var_19_0 = arg_2_0
			local var_19_1 = var_0.emit

			AuctionGameEntranceMediator = var_3_10003

			var_19_1(var_19_0, var_3_10003.CLICK_GET_RELIEF)

			return
		end

		function var_18_7.cancelCallback()
			return
		end

		var_18_6.data = var_18_7

		var_18_3(var_18_2, var_18_4, var_18_5(var_18_6))

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_32, var_2_33, var_2_34, var_6)

	AuctionGameEntrancePaintingPanel = var_1
	arg_2_0.paintingPanelView = var_1.New(arg_2_0.uiLeftPanel, arg_2_0)
	arg_2_0.locationItemList = {}
	ipairs = var_1
	pg = var_3

	for iter_2_0, iter_2_1 in var_1(var_3.auction_session.all) do
		pg = var_6

		if var_6.auction_session[iter_2_1].game_type ~= 0 then
			table = var_7

			local var_2_35 = var_7.insert
			local var_2_36 = arg_2_0.locationItemList

			AuctionGameEntranceLocationItem = var_1_10010
			var_1_10010 = var_1_10010.New
			string = var_1_10012

			var_2_35(var_2_36, var_1_10010(arg_2_0[var_1_10012.format("uiLocationTf%s", #arg_2_0.locationItemList + 1)], arg_2_0, iter_2_1))
		end
	end

	AuctionGamePlayerPanel = var_1
	arg_2_0.playerPanelView = var_1.New(arg_2_0.uiPlayerInfo, arg_2_0)

	return
end

function var_0_1.didEnter(arg_21_0)
	Screen = var_1_10001
	SleepTimeout = var_1_10002
	var_1_10001.sleepTimeout = var_1_10002.NeverSleep

	arg_21_0:OverlayPanel(arg_21_0.uiAdaptTf, {
		pbList = {
			arg_21_0.uiLocationInfoTf
		}
	})

	pg = var_1

	local var_21_0 = var_1.GameTrackerMgr.GetInstance()
	local var_21_1 = var_1.Record

	GameTrackerBuilder = var_4

	var_21_1(var_21_0, var_4.BuildAuctionEnter())
	arg_21_0:OnClickStopQuickMatch()

	local var_21_2 = arg_21_0.paintingPanelView

	var_1.didEnter(var_21_2)

	local var_21_3 = arg_21_0.playerPanelView

	var_1.didEnter(var_21_3)

	AuctionGameTools = var_1
	arg_21_0.lastSelectedID = var_1.GetLastLocationSelectedID()

	local var_21_4 = {}
	local var_21_5 = arg_21_0
	local var_21_6 = arg_21_0.bind

	AuctionGameEntranceLocationItem = var_5

	local var_21_7 = var_5.SELECTED_LOCATION

	handler = var_6
	var_21_4[1] = var_21_6(var_21_5, var_21_7, var_6(arg_21_0, arg_21_0.OnSelectedLocation))
	arg_21_0.eventList = var_21_4

	local var_21_8 = arg_21_0

	arg_21_0.RefreshUI(var_21_8)

	getProxy = var_1
	ActivityProxy = var_21_8

	local var_21_9 = var_1(var_21_8)
	local var_21_10 = var_1.getActivityByType

	ActivityConst = var_21_7

	local var_21_11 = var_21_10(var_21_9, var_21_7.ACTIVITY_TYPE_AUCTION_GAME)

	pg = var_21_8

	local var_21_12 = var_21_8.SystemGuideMgr.GetInstance()

	var_3.PlayByGuideId(var_21_12, "AUCTION_GUIDE_1", {
		var_21_11:GetTaskTip() and 1 or 0
	}, nil, true)

	pg = var_3

	local var_21_13 = var_3.NewStoryMgr.GetInstance()

	if var_3.IsPlayed(var_21_13, "AUCTION_GUIDE_6") then
		pg = var_3

		local var_21_14 = var_3.SystemGuideMgr.GetInstance()

		var_3.PlayByGuideId(var_21_14, "AUCTION_GUIDE_3")
	end

	arg_21_0:RefreshRelief()

	return
end

function var_0_1.RefreshUI(arg_22_0)
	arg_22_0:RefreshLocationList()
	arg_22_0:RefreshPreorderBtn()
	arg_22_0:RefreshTaskTip()
	arg_22_0:RefreshPreorderTip()
	arg_22_0:RefreshOpenPreorderTip()
	arg_22_0:RefreshForbidden()
	arg_22_0:ShowWarning()

	return
end

function var_0_1.OnUpdateCurrency(arg_23_0)
	arg_23_0:RefreshLocationList()
	arg_23_0:RefreshPreorderBtn()

	local var_23_0 = arg_23_0.playerPanelView

	var_1.didEnter(var_23_0)
	arg_23_0:RefreshRelief()
	arg_23_0:RefreshPreorderTip()

	return
end

function var_0_1.OnSelectedLocation(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 == arg_24_0.lastSelectedID then
		return
	end

	if arg_24_0.startQuickMatch == true then
		return
	end

	AuctionGameTools = var_3

	var_3.SetLastLocationSelectedID(arg_24_2)

	arg_24_0.lastSelectedID = arg_24_2

	arg_24_0:RefreshLocationList()

	return
end

function var_0_1.RefreshLocationList(arg_25_0)
	ipairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.locationItemList) do
		iter_25_1:didEnter(arg_25_0.lastSelectedID)
	end

	pg = var_1

	local var_25_0 = var_1.auction_session[arg_25_0.lastSelectedID]

	setText = var_2

	var_2(arg_25_0.uiAuctionValueText, var_25_0.auction_value)

	AuctionGameTools = var_2

	local var_25_1 = var_2.GetCurrencyCnt()
	local var_25_2 = var_25_0.ticket <= var_25_1

	setText = var_3

	local var_25_3 = arg_25_0.uiAuctionTicketText

	string = var_1_10006

	local var_25_4 = var_1_10006.format
	local var_25_5 = "<color=%s>%s</color>"
	local var_25_6 = var_25_2 and "#393a3c" or "#bf5050"

	StringHelper = var_1_10010

	var_3(var_25_3, var_25_4(var_25_5, var_25_6, var_1_10010.ForamtNumberK(var_25_0.ticket)))

	return
end

function var_0_1.FormatMatchDuration(arg_26_0, arg_26_1)
	math = var_1_10002

	local var_26_0 = var_1_10002.max
	local var_26_1 = 0

	math = var_1_10005
	arg_26_1 = var_26_0(var_26_1, var_1_10005.floor(arg_26_1 or 0))
	math = var_2

	local var_26_2 = var_2.floor(arg_26_1 / 60)
	local var_26_3 = arg_26_1 % 60

	string = var_4

	return var_4.format("%02d:%02d", var_26_2, var_26_3)
end

function var_0_1.OnQuickMatch(arg_27_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10003

	local var_27_0 = var_1_10001(var_1_10003)

	var_1.InitGameData(var_27_0, arg_27_0.curSelectedID)

	arg_27_0.startQuickMatch = true
	pg = var_1

	local var_27_1 = var_1.TimeMgr.GetInstance()

	arg_27_0.startTime = var_1.GetServerTime(var_27_1)

	arg_27_0:AddMatchTimer()

	setActive = var_1

	var_1(arg_27_0.uiMatchTimeGo, true)

	setActive = var_1

	var_1(arg_27_0.uiCancelMatchBtn, true)

	setActive = var_1

	var_1(arg_27_0.uiMatchBtn, false)

	pg = var_1

	local var_27_2 = var_1.GameTrackerMgr.GetInstance()
	local var_27_3 = var_1.Record

	GameTrackerBuilder = var_4

	var_27_3(var_27_2, var_4.BuildAuctionMatching(0, 0, arg_27_0.curSelectedID))

	return
end

function var_0_1.OnClickStopQuickMatch(arg_28_0)
	if arg_28_0.startQuickMatch == true then
		pg = var_1

		local var_28_0 = var_1.GameTrackerMgr.GetInstance()
		local var_28_1 = var_1.Record

		GameTrackerBuilder = var_1_10004
		var_1_10004 = var_1_10004.BuildAuctionMatching

		local var_28_2 = 1

		pg = var_1_10007

		local var_28_3 = var_1_10007.TimeMgr.GetInstance()

		var_28_1(var_28_0, var_1_10004(var_28_2, var_7.GetServerTime(var_28_3) - arg_28_0.startTime, arg_28_0.curSelectedID))
	end

	local var_28_4 = arg_28_0
	local var_28_5 = arg_28_0.emit

	PlayRoomCommonMediator = var_1_10004

	var_28_5(var_28_4, var_1_10004.PLAY_ROOM_MATCH_STOP)

	return
end

function var_0_1.OnQuickMatchSuccess(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.GameTrackerMgr.GetInstance()
	local var_29_1 = var_1.Record

	GameTrackerBuilder = var_1_10004

	local var_29_2 = var_1_10004.BuildAuctionMatching
	local var_29_3 = 2

	pg = var_1_10007

	local var_29_4 = var_1_10007.TimeMgr.GetInstance()

	var_29_1(var_29_0, var_29_2(var_29_3, var_7.GetServerTime(var_29_4) - arg_29_0.startTime, arg_29_0.curSelectedID))

	arg_29_0.quickMatchSuccess = true
	getProxy = var_1
	AuctionGameBaseProxy = var_29_0

	local var_29_5 = var_1(var_29_0)
	local var_29_6 = var_1.AddGold

	pg = var_1_10005

	var_29_6(var_29_5, var_1_10005.auction_session[arg_29_0.curSelectedID].ticket * -1)

	local var_29_7 = var_1

	var_1.SetNeedInitFlag(var_29_7, true)

	getProxy = var_2
	ContextProxy = var_29_7

	local var_29_8 = var_2(var_29_7)
	local var_29_9 = var_2.getContextByMediator

	AuctionGameMainMsgMediator = var_5

	local var_29_10

	if var_29_9(var_29_8, var_5) then
		LoadContextCommand = var_29_10
		var_29_10 = var_29_10.RemoveLayerByMediator
		AuctionGameMainMsgMediator = var_29_8

		var_29_10(var_29_8)
	end

	pg = var_29_10

	local var_29_11 = var_29_10.m02
	local var_29_12 = var_2.sendNotification

	GAME = var_5

	local var_29_13 = var_5.GO_SCENE

	SCENE = var_6

	var_29_12(var_29_11, var_29_13, var_6.AUCTION_GAME_MAIN)
	arg_29_0:StopMatchTimer()

	return
end

function var_0_1.OnStopMatch(arg_30_0)
	arg_30_0.startQuickMatch = false

	arg_30_0:StopMatchTimer()

	setActive = var_1

	var_1(arg_30_0.uiMatchTimeGo, false)

	setActive = var_1

	var_1(arg_30_0.uiCancelMatchBtn, false)

	setActive = var_1

	var_1(arg_30_0.uiMatchBtn, true)

	return
end

function var_0_1.IsQuickMatch(arg_31_0)
	return arg_31_0.startQuickMatch
end

function var_0_1.AddMatchTimer(arg_32_0)
	arg_32_0:StopMatchTimer()

	Timer = var_1
	arg_32_0.matchTimer = var_1.New(function()
		pg = var_2_10000

		local var_33_0 = var_2_10000.TimeMgr.GetInstance()
		local var_33_1 = var_0.GetServerTime(var_33_0) - arg_32_0.startTime

		setText = var_1

		local var_33_2 = arg_32_0.uiMatchTimeText
		local var_33_3 = arg_32_0

		var_1(var_33_2, var_4.FormatMatchDuration(var_33_3, var_33_1))

		return
	end, 1, -1)

	local var_32_0 = arg_32_0.matchTimer

	var_1.Start(var_32_0)
	arg_32_0.matchTimer.func()

	return
end

function var_0_1.StopMatchTimer(arg_34_0)
	if arg_34_0.matchTimer then
		local var_34_0 = arg_34_0.matchTimer

		var_1.Stop(var_34_0)

		arg_34_0.matchTimer = nil
	end

	return
end

function var_0_1.RefreshForbidden(arg_35_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10003

	local var_35_0 = var_1_10001(var_1_10003).forbiddenTime

	pg = var_1_10003

	local var_35_1 = var_1_10003.TimeMgr.GetInstance()

	if var_35_0 > var_3.GetServerTime(var_35_1) then
		setActive = var_1_10004

		var_1_10004(arg_35_0.uiForbiddenGo, true)
		arg_35_0:AddForbiddenTimer(var_35_0)
	else
		setActive = var_1_10004

		var_1_10004(arg_35_0.uiForbiddenGo, false)
	end

	return
end

function var_0_1.AddForbiddenTimer(arg_36_0, arg_36_1)
	arg_36_0:StopForbiddenTimer()

	Timer = var_2
	arg_36_0.forbiddenTimer = var_2.New(function()
		pg = var_2_10000

		local var_37_0 = var_2_10000.TimeMgr.GetInstance()

		if var_0.GetServerTime(var_37_0) < arg_36_1 then
			setText = var_1

			local var_37_1 = arg_36_0.uiForbiddenText

			i18n = var_2_10004

			local var_37_2 = "auction_forbidden_tip"
			local var_37_3 = arg_36_0

			var_1(var_37_1, var_2_10004(var_37_2, var_7.FormatPreorderDuration(var_37_3, arg_36_1 - var_0)))
		else
			local var_37_4 = arg_36_0

			var_1.StopForbiddenTimer(var_37_4)

			local var_37_5 = arg_36_0

			var_1.RefreshForbidden(var_37_5)
		end

		return
	end, 1, -1)

	arg_36_0.forbiddenTimer.func()

	local var_36_0 = arg_36_0.forbiddenTimer

	var_2.Start(var_36_0)

	return
end

function var_0_1.StopForbiddenTimer(arg_38_0)
	if arg_38_0.forbiddenTimer then
		local var_38_0 = arg_38_0.forbiddenTimer

		var_1.Stop(var_38_0)

		arg_38_0.forbiddenTimer = nil
	end

	return
end

function var_0_1.RefreshPreorderBtn(arg_39_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10003

	local var_39_0 = var_1_10001(var_1_10003)
	local var_39_1 = var_1.GetPreorderState(var_39_0)
	local var_39_2 = var_1
	local var_39_3 = var_1.GetPreorderTimestamp(var_39_2)

	pg = var_39_0

	local var_39_4 = var_39_0.TimeMgr.GetInstance()
	local var_39_5 = var_4.GetServerTime(var_39_4)

	if var_39_1 == 1 then
		setActive = var_39_2

		var_39_2(arg_39_0.uiPreorderEndGo, false)

		if var_39_5 < var_39_3 then
			setActive = var_39_2

			var_39_2(arg_39_0.uiPreorderBtn, false)

			setActive = var_39_2

			var_39_2(arg_39_0.uiPreorderTimeGo, true)

			setActive = var_39_2

			var_39_2(arg_39_0.uiOpenPreorderBtn, true)

			var_1_10007 = arg_39_0

			arg_39_0.AddPreorderTimer(var_1_10007)
		else
			setActive = var_39_2

			var_39_2(arg_39_0.uiPreorderBtn, false)

			setActive = var_39_2

			var_39_2(arg_39_0.uiPreorderTimeGo, false)

			setActive = var_39_2

			var_39_2(arg_39_0.uiOpenPreorderBtn, true)

			var_1_10007 = arg_39_0

			arg_39_0.StopPreorderTimer(var_1_10007)
		end
	else
		getProxy = var_39_2
		ActivityProxy = var_1_10007

		local var_39_6 = var_39_2(var_1_10007)
		local var_39_7 = var_5.getActivityByType

		ActivityConst = var_1_10009

		local var_39_8 = var_39_7(var_39_6, var_1_10009.ACTIVITY_TYPE_AUCTION_GAME).stopTime

		pg = var_39_6

		local var_39_9 = var_39_6.TimeMgr.GetInstance()
		local var_39_10 = var_8.IsSameDay(var_39_9, var_39_5, var_39_8)

		setActive = var_9

		var_9(arg_39_0.uiPreorderBtn, not var_39_10)

		setActive = var_9

		var_9(arg_39_0.uiPreorderEndGo, var_39_10)

		setActive = var_9

		var_9(arg_39_0.uiPreorderTimeGo, false)

		setActive = var_9

		var_9(arg_39_0.uiOpenPreorderBtn, false)

		AuctionGameTools = var_9

		local var_39_11 = var_9.GetPreorderCurrentyCnt()

		setText = var_39_9

		local var_39_12 = arg_39_0.uiPreorderPriceText

		string = var_1_10013

		local var_39_13 = var_1_10013.format
		local var_39_14 = "<color=%s>%s</color>"

		AuctionGameTools = var_1_10016

		local var_39_15 = var_39_11 > var_1_10016.GetCurrencyCnt() and "#bf5050" or "#ffffff"

		StringHelper = var_1_10017

		var_39_9(var_39_12, var_39_13(var_39_14, var_39_15, var_1_10017.ForamtNumberK(var_39_11)))
	end

	return
end

function var_0_1.AddPreorderTimer(arg_40_0)
	local var_40_0 = arg_40_0

	arg_40_0.StopPreorderTimer(var_40_0)

	getProxy = var_1
	AuctionGameBaseProxy = var_40_0

	local var_40_1 = var_1(var_40_0)
	local var_40_2 = var_1.GetPreorderTimestamp(var_40_1)

	Timer = var_1_10002
	arg_40_0.preorderTimer = var_1_10002.New(function()
		pg = var_2_10000

		local var_41_0 = var_2_10000.TimeMgr.GetInstance()
		local var_41_1 = var_0.GetServerTime(var_41_0)

		if var_40_2 <= var_41_1 then
			local var_41_2 = arg_40_0

			var_1.StopPreorderTimer(var_41_2)

			local var_41_3 = arg_40_0

			var_1.RefreshPreorderBtn(var_41_3)
		else
			setText = var_1

			local var_41_4 = arg_40_0.uiPreorderTimeText
			local var_41_5 = arg_40_0

			var_1(var_41_4, var_4.FormatPreorderDuration(var_41_5, var_40_2 - var_41_1))
		end

		return
	end, 1, -1)

	local var_40_3 = arg_40_0.preorderTimer

	var_2.Start(var_40_3)
	arg_40_0.preorderTimer.func()

	return
end

function var_0_1.FormatPreorderDuration(arg_42_0, arg_42_1)
	math = var_1_10002

	local var_42_0 = var_1_10002.max
	local var_42_1 = 0

	math = var_1_10005
	arg_42_1 = var_42_0(var_42_1, var_1_10005.floor(arg_42_1 or 0))
	math = var_2

	local var_42_2 = var_2.floor(arg_42_1 / 16)

	math = var_1_10003

	local var_42_3 = var_1_10003.floor(arg_42_1 / 60) % 60
	local var_42_4 = arg_42_1 % 60

	string = var_5

	return var_5.format("%02d:%02d:%02d", var_42_2, var_42_3, var_42_4)
end

function var_0_1.StopPreorderTimer(arg_43_0)
	if arg_43_0.preorderTimer then
		local var_43_0 = arg_43_0.preorderTimer

		var_1.Stop(var_43_0)

		arg_43_0.preorderTimer = nil
	end

	return
end

function var_0_1.RefreshTaskTip(arg_44_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_44_0 = var_1_10001(var_1_10003)
	local var_44_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	local var_44_2 = var_44_1(var_44_0, var_1_10005.ACTIVITY_TYPE_AUCTION_GAME)

	setActive = var_1_10003

	var_1_10003(arg_44_0.uiTaskTipGo, var_44_2:GetTaskTip())

	return
end

function var_0_1.RefreshPreorderTip(arg_45_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_45_0 = var_1_10001(var_1_10003)
	local var_45_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	local var_45_2 = var_45_1(var_45_0, var_1_10005.ACTIVITY_TYPE_AUCTION_GAME)

	setActive = var_1_10003

	var_1_10003(arg_45_0.uiPreorderTipGo, var_45_2:GetPreorderTip())

	return
end

function var_0_1.RefreshOpenPreorderTip(arg_46_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_46_0 = var_1_10001(var_1_10003)
	local var_46_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	local var_46_2 = var_46_1(var_46_0, var_1_10005.ACTIVITY_TYPE_AUCTION_GAME)

	setActive = var_1_10003

	var_1_10003(arg_46_0.uiOpenPreorderTipGo, var_46_2:GetOpenPreorderTip())

	return
end

function var_0_1.RefreshLocationTip(arg_47_0)
	ipairs = var_1_10001

	for iter_47_0, iter_47_1 in var_1_10001(arg_47_0.locationItemList) do
		iter_47_1:RefreshState()
	end

	return
end

function var_0_1.RefreshRelief(arg_48_0)
	pg = var_1_10001

	local var_48_0 = var_1_10001.NewGuideMgr.GetInstance()

	if var_1.IsBusy(var_48_0) then
		setActive = var_1

		var_1(arg_48_0.uiReliefBtn, false)

		return
	end

	getProxy = var_1
	AuctionGameBaseProxy = var_48_0

	local var_48_1 = var_1(var_48_0)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_48_2 = var_1_10002(var_1_10004)
	local var_48_3 = var_2.getActivityByType

	ActivityConst = var_1_10006

	local var_48_4 = var_48_3(var_48_2, var_1_10006.ACTIVITY_TYPE_AUCTION_GAME)
	local var_48_5 = var_3.GetReliefTip(var_48_4)

	setActive = var_48_2

	var_48_2(arg_48_0.uiReliefBtn, var_48_5)

	return
end

function var_0_1.ShowWarning(arg_49_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10003

	local var_49_0 = var_1_10001(var_1_10003)

	pg = var_1_10002

	local var_49_1 = var_1_10002.TimeMgr.GetInstance()
	local var_49_2 = var_2.STimeDescC

	pg = var_1_10005

	local var_49_3 = var_1_10005.TimeMgr.GetInstance()
	local var_49_4 = var_49_2(var_49_1, var_5.GetServerTime(var_49_3), "%Y/%m/%d")

	getProxy = var_1_10003
	PlayerProxy = var_5

	local var_49_5 = var_1_10003(var_5)
	local var_49_6 = var_3.getPlayerId(var_49_5)

	PlayerPrefs = var_49_1

	local var_49_7 = var_49_1.GetInt

	string = var_6

	local var_49_8 = var_49_7(var_6.format("AUCTION_GAME_WARNING_%s_%s", var_49_6, var_49_4), 0)
	local var_49_9, var_49_10

	if var_49_0.inactiveNum ~= var_49_8 then
		var_49_9 = arg_49_0
		var_49_10 = arg_49_0.emit
		BaseUI = var_8

		local var_49_11 = var_8.ON_ADD_SUBLAYER

		Context = var_9

		local var_49_12 = var_9.New
		local var_49_13 = {}

		AuctionGameMainMsgLayer = var_1_10012
		var_49_13.viewComponent = var_1_10012
		AuctionGameMainMsgMediator = var_1_10012
		var_49_13.mediator = var_1_10012

		local var_49_14 = {}

		i18n = var_1_10013
		var_49_14.content = var_1_10013("auction_game_punishment", var_49_0.inactiveNum)

		function var_49_14.comformCallback()
			return
		end

		function var_49_14.cancelCallback()
			return
		end

		var_49_13.data = var_49_14

		var_49_10(var_49_9, var_49_11, var_49_12(var_49_13))
	end

	PlayerPrefs = var_49_10

	local var_49_15 = var_49_10.SetInt

	string = var_49_9

	var_49_15(var_49_9.format("AUCTION_GAME_WARNING_%s_%s", var_49_6, var_49_4), var_49_0.inactiveNum)

	return
end

function var_0_1.willExit(arg_52_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_52_0 = var_1_10001(var_1_10003)

	var_1_10002.sleepTimeout, Screen = var_1.GetMainSceneScreenSleepTime(var_52_0), var_1_10002

	arg_52_0:UnOverlayPanel(arg_52_0.uiAdaptTf, arg_52_0._tf)
	arg_52_0:StopMatchTimer()
	arg_52_0:StopPreorderTimer()
	arg_52_0:StopForbiddenTimer()

	local var_52_1 = arg_52_0.matchEventCom

	var_2.SetEndEvent(var_52_1, nil)

	ipairs = var_2

	for iter_52_0, iter_52_1 in var_2(arg_52_0.eventList) do
		arg_52_0:disconnect(iter_52_1)
	end

	arg_52_0.eventList = nil

	local var_52_2 = arg_52_0.paintingPanelView

	var_2.willExit(var_52_2)

	arg_52_0.paintingPanelView = nil
	ipairs = var_2

	for iter_52_2, iter_52_3 in var_2(arg_52_0.locationItemList) do
		iter_52_3:willExit()
	end

	arg_52_0.locationItemList = nil

	local var_52_3 = arg_52_0.playerPanelView

	var_2.willExit(var_52_3)

	arg_52_0.playerPanelView = nil

	return
end

function var_0_1.onBackPressed(arg_53_0)
	if not arg_53_0.quickMatchSuccess and arg_53_0.startQuickMatch == true then
		local var_53_0 = arg_53_0
		local var_53_1 = arg_53_0.emit

		BaseUI = var_1_10004

		local var_53_2 = var_1_10004.ON_ADD_SUBLAYER

		Context = var_1_10005

		local var_53_3 = var_1_10005.New
		local var_53_4 = {}

		AuctionGameMainMsgLayer = var_1_10008
		var_53_4.viewComponent = var_1_10008
		AuctionGameMainMsgMediator = var_1_10008
		var_53_4.mediator = var_1_10008

		local var_53_5 = {}

		i18n = var_1_10009
		var_53_5.content = var_1_10009("auction_main_match_exit")

		function var_53_5.comformCallback()
			local var_54_0 = arg_53_0

			var_0.OnClickStopQuickMatch(var_54_0)
			var_0_1.super.onBackPressed(arg_53_0)

			return
		end

		function var_53_5.cancelCallback()
			return
		end

		var_53_4.data = var_53_5

		var_53_1(var_53_0, var_53_2, var_53_3(var_53_4))
	else
		var_0_1.super.onBackPressed(arg_53_0)
	end

	return
end

return var_0_1
