class = var_0_10000

local var_0_0 = "AuctionGameMainRightView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

var_0_1.FORFEIT_DONE = "AuctionGameMainRightView::FORFEIT_DONE"
var_0_1.PLAYER_OPT_STATE_UPDATE = "AuctionGameMainRightView::PLAYER_OPT_STATE_UPDATE"
var_0_1.POP_EVENT_LAYER = "AuctionGameMainRightView::POP_EVENT_LAYER"
var_0_1.EVENT_SELECTED = "AuctionGameMainRightView::EVENT_SELECTED"
var_0_1.SHOW_EMOJI = "AuctionGameMainRightView::SHOW_EMOJI"
var_0_1.SWITCH_EMOJI = "AuctionGameMainRightView::SWITCH_EMOJI"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	AuctionGameMainRightInfoView = var_3
	arg_1_0.infoView = var_3.New(arg_1_0.uiInfoPanel, arg_1_2)

	return
end

function var_0_1.Init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiCurrencyTitleText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("auction_main_pt"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiEventBtnText

	i18n = var_3

	var_1_10001(var_2_1, var_3("auction_main_select_event"))

	GetComponent = var_1_10001

	local var_2_2 = arg_2_0.uiBidAnimationTf

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.bidEventCom = var_1_10001(var_2_2, var_3(var_4))

	local var_2_3 = arg_2_0.bidEventCom

	var_1.SetEndEvent(var_2_3, function()
		arg_2_0.startBid = false

		local var_3_0 = arg_2_0

		var_0.OnPopBidLayer(var_3_0)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_2_3

	local var_2_4 = var_1(var_2_3)
	local var_2_5 = var_1.getActivityByType

	ActivityConst = var_4

	local var_2_6 = var_2_5(var_2_4, var_4.ACTIVITY_TYPE_AUCTION_GAME)
	local var_2_7 = var_2.getConfig(var_2_6, "config_client").itemID

	LoadSpriteAsync = var_2_6
	Drop = var_5

	local var_2_8 = var_5.New
	local var_2_9 = {}

	DROP_TYPE_VITEM = var_1_10007
	var_2_9.type = var_1_10007
	var_2_9.id = var_2_7

	local var_2_10 = var_2_8(var_2_9)

	var_2_6(var_5.getIcon(var_2_10), function(arg_4_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.uiCurrencyIcon) then
			arg_2_0.uiCurrencyIcon.sprite = arg_4_0
		end

		return
	end)

	onButton = var_2_6

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.uiEventBtn

	local function var_2_13()
		local var_5_0 = arg_2_0

		var_0.OnPopEventLayer(var_5_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_2_6(var_2_11, var_2_12, var_2_13, var_1_10008)

	onButton = var_2_6

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.uiForfeitGreyBtn

	local function var_2_16()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10001

		local var_6_0 = var_2_10000(var_2_10001)
		local var_6_1 = var_0.GetAuctionState(var_6_0)

		AuctionGameConst = var_6_0

		if var_6_0.AUCTION_PHASE.WAIT_OVER <= var_6_1 then
			pg = var_2

			local var_6_2 = var_2.TipsMgr.GetInstance()
			local var_6_3 = var_2.ShowTips

			i18n = var_2_10004

			var_6_3(var_6_2, var_2_10004("auction_game_cannot_forfeit"))

			return
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_2_6(var_2_14, var_2_15, var_2_16, var_1_10008)

	onButton = var_2_6

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.uiForfeitBtn

	local function var_2_19()
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)

		if var_0.GetForfeit(var_7_0) then
			return
		end

		local var_7_1 = arg_2_0
		local var_7_2 = var_1.emit

		BaseUI = var_2_10003

		local var_7_3 = var_2_10003.ON_ADD_SUBLAYER

		Context = var_2_10004

		local var_7_4 = var_2_10004.New
		local var_7_5 = {}

		AuctionGameMainMsgLayer = var_2_10006
		var_7_5.viewComponent = var_2_10006
		AuctionGameMainMsgMediator = var_2_10006
		var_7_5.mediator = var_2_10006

		local var_7_6 = {}

		i18n = var_2_10007
		var_7_6.content = var_2_10007("auction_game_forfeit_tip")

		function var_7_6.comformCallback()
			getProxy = var_3_10000
			AuctionGameProxy = var_3_10001

			local var_8_0 = var_3_10000(var_3_10001)

			pg = var_3_10001

			local var_8_1 = var_3_10001.TimeMgr.GetInstance()
			local var_8_2 = var_1.GetServerTime(var_8_1) - var_8_0:GetTimestamp()
			local var_8_3 = var_8_0
			local var_8_4 = var_8_0.GetAuctionState(var_8_3)

			AuctionGameConst = var_8_3

			if var_8_4 == var_8_3.AUCTION_PHASE.BID then
				pg = var_8_4
				var_8_2 = var_8_4.gameset.auction_bid_time.key_value + var_8_2
			else
				pg = var_8_4
				var_8_2 = var_8_4.gameset.auction_event_choose_time.key_value + var_8_2
			end

			pg = var_8_4

			local var_8_5 = var_8_4.GameTrackerMgr.GetInstance()
			local var_8_6 = var_2.Record

			GameTrackerBuilder = var_3_10004

			var_8_6(var_8_5, var_3_10004.BuildAuctionBid(var_8_0:GetAuctionID(), var_8_0:GetRound(), var_8_2, 0, 1))

			local var_8_7 = arg_2_0
			local var_8_8 = var_2.emit

			AuctionGameMainMediator = var_4

			var_8_8(var_8_7, var_4.FORFEIT)

			return
		end

		var_7_5.data = var_7_6

		var_7_2(var_7_1, var_7_3, var_7_4(var_7_5))

		return
	end

	SFX_PANEL = var_1_10008

	var_2_6(var_2_17, var_2_18, var_2_19, var_1_10008)

	onButton = var_2_6

	local var_2_20 = arg_2_0
	local var_2_21 = arg_2_0.uiBidBtn

	local function var_2_22()
		if arg_2_0.startBid == true then
			return
		end

		if arg_2_0.waitBid then
			pg = var_0

			local var_9_0 = var_0.TipsMgr.GetInstance()
			local var_9_1 = var_0.ShowTips

			i18n = var_2_10002

			var_9_1(var_9_0, var_2_10002("auction_game_wait_bid_phase"))

			return
		end

		if arg_2_0.bided then
			return
		end

		local var_9_2 = arg_2_0

		var_9_2.startBid = true
		quickPlayAnimation = var_9_2

		var_9_2(arg_2_0.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end

	SFX_PANEL = var_1_10008

	var_2_6(var_2_20, var_2_21, var_2_22, var_1_10008)

	onButton = var_2_6

	local var_2_23 = arg_2_0
	local var_2_24 = arg_2_0.uiCloseBtn

	local function var_2_25()
		local var_10_0 = arg_2_0
		local var_10_1 = var_0.emit

		PlayRoomCommonMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.PLAY_ROOM_MATCH_STOP)

		local var_10_2 = arg_2_0
		local var_10_3 = var_0.emit

		AuctionGameMainMediator = var_2

		var_10_3(var_10_2, var_2.EXIT)

		return
	end

	SOUND_BACK = var_1_10008

	var_2_6(var_2_23, var_2_24, var_2_25, var_1_10008)

	arg_2_0.playerViewList = {}
	getProxy = var_4
	AuctionGameProxy = var_2_23

	local var_2_26 = var_4(var_2_23)
	local var_2_27 = var_4.GetPlayerList(var_2_26)

	for iter_2_0 = 1, #var_2_27 do
		var_1_10009 = arg_2_0.playerViewList
		AuctionGameMainRightPlayerInfo = var_1_10010
		var_1_10010 = var_1_10010.New
		string = var_1_10011
		var_1_10009[iter_2_0] = var_1_10010(arg_2_0[var_1_10011.format("uiPlayerTf%s", iter_2_0)], arg_2_0._parentClass)
	end

	for iter_2_1 = #var_2_27 + 1, 4 do
		setActive = var_1_10009
		string = var_1_10010

		var_1_10009(arg_2_0[var_1_10010.format("uiPlayerTf%s", iter_2_1)], false)
	end

	setText = var_5

	local var_2_28 = arg_2_0.uiFilterPersonalEventText

	i18n = var_7

	var_5(var_2_28, var_7("auction_show_personal_event"))

	setText = var_5

	local var_2_29 = arg_2_0.uiFilterCommonEventText

	i18n = var_7

	var_5(var_2_29, var_7("auction_show_common_event"))

	setActive = var_5

	var_5(arg_2_0.uiFilterPanelTf, false)

	onButton = var_5

	local var_2_30 = arg_2_0
	local var_2_31 = arg_2_0.uiFilterBtn

	local function var_2_32()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiFilterPanelTf, true)

		local var_11_0 = arg_2_0
		local var_11_1 = var_0.emit

		AuctionGameMainScene = var_2

		var_11_1(var_11_0, var_2.SHOW_FILTER_EVENT, arg_2_0.uiFilterPanelTf)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_2_30, var_2_31, var_2_32, var_1_10009)

	onButton = var_5

	local var_2_33 = arg_2_0
	local var_2_34 = arg_2_0.uiFilterPersonalEventBtn

	local function var_2_35()
		arg_2_0.filterPersonalFlag = not arg_2_0.filterPersonalFlag

		local var_12_0 = arg_2_0

		var_0.RefreshFilterPersonalEvent(var_12_0)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_2_33, var_2_34, var_2_35, var_1_10009)

	onButton = var_5

	local var_2_36 = arg_2_0
	local var_2_37 = arg_2_0.uiFilterCommonEventBtn

	local function var_2_38()
		arg_2_0.filterCommonFlag = not arg_2_0.filterCommonFlag

		local var_13_0 = arg_2_0

		var_0.RefreshFilterCommonEvent(var_13_0)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_2_36, var_2_37, var_2_38, var_1_10009)

	return
end

function var_0_1.didEnter(arg_14_0)
	arg_14_0.filterPersonalFlag = true
	arg_14_0.filterCommonFlag = true

	local var_14_0 = arg_14_0.infoView

	var_1.didEnter(var_14_0)

	local var_14_1 = arg_14_0.infoView

	var_1.RefreshUI(var_14_1, arg_14_0.filterPersonalFlag, arg_14_0.filterCommonFlag)

	getProxy = var_1
	AuctionGameProxy = var_14_1

	local var_14_2 = var_1(var_14_1)
	local var_14_3 = var_1.GetPlayerList(var_14_2)

	ipairs = var_14_2

	for iter_14_0, iter_14_1 in var_14_2(arg_14_0.playerViewList) do
		iter_14_1:didEnter(var_14_3[iter_14_0])
	end

	local var_14_4 = {}
	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0.bind
	local var_14_7 = var_0_1.FORFEIT_DONE

	handler = iter_14_1
	var_14_4[1] = var_14_6(var_14_5, var_14_7, iter_14_1(arg_14_0, arg_14_0.OnRefreshForfeit))

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.bind
	local var_14_10 = var_0_1.PLAYER_OPT_STATE_UPDATE

	handler = var_6
	var_14_4[2] = var_14_9(var_14_8, var_14_10, var_6(arg_14_0, arg_14_0.OnRefreshPlayerState))

	local var_14_11 = arg_14_0
	local var_14_12 = arg_14_0.bind
	local var_14_13 = var_0_1.POP_EVENT_LAYER

	handler = var_6
	var_14_4[3] = var_14_12(var_14_11, var_14_13, var_6(arg_14_0, arg_14_0.OnPopEventLayer))

	local var_14_14 = arg_14_0
	local var_14_15 = arg_14_0.bind
	local var_14_16 = var_0_1.EVENT_SELECTED

	handler = var_6
	var_14_4[4] = var_14_15(var_14_14, var_14_16, var_6(arg_14_0, arg_14_0.OnEventSelected))

	local var_14_17 = arg_14_0
	local var_14_18 = arg_14_0.bind
	local var_14_19 = var_0_1.SHOW_EMOJI

	handler = var_6
	var_14_4[5] = var_14_18(var_14_17, var_14_19, var_6(arg_14_0, arg_14_0.OnShowEmoji))

	local var_14_20 = arg_14_0
	local var_14_21 = arg_14_0.bind
	local var_14_22 = var_0_1.SWITCH_EMOJI

	handler = var_6
	var_14_4[6] = var_14_21(var_14_20, var_14_22, var_6(arg_14_0, arg_14_0.OnSwitchEmoji))
	arg_14_0.eventList = var_14_4
	setText = var_14_4

	local var_14_23 = arg_14_0.uiCurrencyText

	StringHelper = var_14_20

	local var_14_24 = var_14_20.ForamtNumber

	AuctionGameTools = var_14_22

	var_14_4(var_14_23, var_14_24(var_14_22.GetCurrencyCnt()))

	getProxy = var_14_4
	AuctionGameProxy = var_14_23

	if var_14_4(var_14_23).personalEventSelectedID == 0 and #var_2.personalEventList > 0 then
		arg_14_0:OnPopEventLayer()
	end

	return
end

function var_0_1.RefreshRound(arg_15_0)
	arg_15_0.startBid = false
	setActive = var_1

	var_1(arg_15_0.uiBidCompleteGo, false)

	setActive = var_1

	var_1(arg_15_0.uiBidBtn, true)

	if arg_15_0.forfeit then
		setActive = var_1

		var_1(arg_15_0.uiForfeitBtn, false)

		setActive = var_1

		var_1(arg_15_0.uiForfeitGreyGo, true)
	else
		setActive = var_1

		var_1(arg_15_0.uiForfeitBtn, true)

		setActive = var_1

		var_1(arg_15_0.uiForfeitGreyGo, false)
	end

	arg_15_0.bided = false
	arg_15_0.waitBid = true

	arg_15_0:RefreshEventTip()

	local var_15_0 = arg_15_0.infoView

	var_1.RefreshUI(var_15_0, arg_15_0.filterPersonalFlag, arg_15_0.filterCommonFlag)

	return
end

function var_0_1.StartBid(arg_16_0)
	arg_16_0.bided = false
	arg_16_0.waitBid = false

	arg_16_0:RefreshEventTip()

	return
end

function var_0_1.RefreshEventTip(arg_17_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)

	setActive = var_1_10002

	var_1_10002(arg_17_0.uiEventTipGo, var_17_0:GetPersonalEventSelectedID() == 0)

	return
end

function var_0_1.RefreshBidDone(arg_18_0, arg_18_1)
	setActive = var_1_10002

	var_1_10002(arg_18_0.uiBidCompleteGo, true)

	setActive = var_1_10002

	var_1_10002(arg_18_0.uiBidBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_18_0.uiForfeitBtn, false)

	setActive = var_1_10002

	var_1_10002(arg_18_0.uiForfeitGreyGo, true)

	arg_18_0.bided = true
	setText = var_2

	local var_18_0 = arg_18_0.uiBidCompleteText

	i18n = var_4

	local var_18_1 = var_4("auction_main_bid_price")

	StringHelper = var_5

	var_2(var_18_0, var_18_1 .. var_5.ForamtNumber(arg_18_1))

	return
end

function var_0_1.OnRefreshForfeit(arg_19_0)
	arg_19_0.forfeit = true
	setActive = var_1

	var_1(arg_19_0.uiCloseBtn, true)

	setActive = var_1

	var_1(arg_19_0.uiBidBtn, false)

	setActive = var_1

	var_1(arg_19_0.uiForfeitBtn, false)

	setActive = var_1

	var_1(arg_19_0.uiForfeitGreyGo, true)

	return
end

function var_0_1.OnRefreshPlayerState(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.playerViewList) do
		iter_20_1:RefreshUI()
	end

	return
end

function var_0_1.OnPopBidLayer(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.emit

	BaseUI = var_1_10003

	local var_21_2 = var_1_10003.ON_ADD_SUBLAYER

	Context = var_1_10004

	local var_21_3 = var_1_10004.New
	local var_21_4 = {}

	AuctionGameMainBidLayer = var_1_10006
	var_21_4.viewComponent = var_1_10006
	AuctionGameMainBidMediator = var_1_10006
	var_21_4.mediator = var_1_10006

	var_21_1(var_21_0, var_21_2, var_21_3(var_21_4))

	return
end

function var_0_1.OnPopEventLayer(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.emit

	BaseUI = var_1_10003

	local var_22_2 = var_1_10003.ON_ADD_SUBLAYER

	Context = var_1_10004

	local var_22_3 = var_1_10004.New
	local var_22_4 = {}

	AuctionGameMainEventLayer = var_1_10006
	var_22_4.viewComponent = var_1_10006
	AuctionGameMainEventMediator = var_1_10006
	var_22_4.mediator = var_1_10006

	var_22_1(var_22_0, var_22_2, var_22_3(var_22_4))

	return
end

function var_0_1.OnEventSelected(arg_23_0)
	arg_23_0:RefreshEventTip()

	local var_23_0 = arg_23_0.infoView

	var_1.RefreshUI(var_23_0, arg_23_0.filterPersonalFlag, arg_23_0.filterCommonFlag)

	return
end

function var_0_1.OnShowEmoji(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2.userID

	getProxy = var_1_10004
	AuctionGameProxy = var_1_10005

	local var_24_1 = var_1_10004(var_1_10005)
	local var_24_2 = var_4.GetPlayerList(var_24_1)

	ipairs = var_24_1

	for iter_24_0, iter_24_1 in var_24_1(var_24_2) do
		local var_24_3 = arg_24_0.playerViewList[iter_24_0]

		var_10.ShowEmoji(var_24_3, var_24_0, arg_24_2.emojiID)
	end

	return
end

function var_0_1.OnSwitchEmoji(arg_25_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)
	local var_25_1 = var_1.GetPlayerList(var_25_0)

	ipairs = var_25_0

	for iter_25_0, iter_25_1 in var_25_0(var_25_1) do
		local var_25_2 = arg_25_0.playerViewList[iter_25_0]

		var_7.RefreshEmojiBtn(var_25_2)
	end

	return
end

function var_0_1.RefreshFilterPersonalEvent(arg_26_0)
	setActive = var_1_10001

	var_1_10001(arg_26_0.uiFilterPersonalEventSelectedGo, arg_26_0.filterPersonalFlag)

	local var_26_0 = arg_26_0.infoView

	var_1.RefreshUI(var_26_0, arg_26_0.filterPersonalFlag, arg_26_0.filterCommonFlag)

	return
end

function var_0_1.RefreshFilterCommonEvent(arg_27_0)
	setActive = var_1_10001

	var_1_10001(arg_27_0.uiFilterCommonEventSelectedGo, arg_27_0.filterCommonFlag)

	local var_27_0 = arg_27_0.infoView

	var_1.RefreshUI(var_27_0, arg_27_0.filterPersonalFlag, arg_27_0.filterCommonFlag)

	return
end

function var_0_1.willExit(arg_28_0)
	local var_28_0 = arg_28_0.bidEventCom

	var_1.SetEndEvent(var_28_0, nil)

	ipairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0.eventList) do
		arg_28_0:disconnect(iter_28_1)
	end

	arg_28_0.eventList = nil

	local var_28_1 = arg_28_0.infoView

	var_1.willExit(var_28_1)

	arg_28_0.infoView = nil
	ipairs = var_1

	for iter_28_2, iter_28_3 in var_1(arg_28_0.playerViewList) do
		iter_28_3:willExit()
	end

	arg_28_0.playerViewList = nil

	arg_28_0:detach()

	return
end

return var_0_1
