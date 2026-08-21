local var_0_0 = class("AuctionGameMainRightView", import("view.base.BasePanel"))

var_0_0.FORFEIT_DONE = "AuctionGameMainRightView::FORFEIT_DONE"
var_0_0.PLAYER_OPT_STATE_UPDATE = "AuctionGameMainRightView::PLAYER_OPT_STATE_UPDATE"
var_0_0.POP_EVENT_LAYER = "AuctionGameMainRightView::POP_EVENT_LAYER"
var_0_0.EVENT_SELECTED = "AuctionGameMainRightView::EVENT_SELECTED"
var_0_0.SHOW_EMOJI = "AuctionGameMainRightView::SHOW_EMOJI"
var_0_0.SWITCH_EMOJI = "AuctionGameMainRightView::SWITCH_EMOJI"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	arg_1_0.infoView = AuctionGameMainRightInfoView.New(arg_1_0.uiInfoPanel, arg_1_2)

	return
end

function var_0_0.Init(arg_2_0)
	setText(arg_2_0.uiCurrencyTitleText, i18n("auction_main_pt"))
	setText(arg_2_0.uiEventBtnText, i18n("auction_main_select_event"))

	arg_2_0.bidEventCom = GetComponent(arg_2_0.uiBidAnimationTf, typeof(DftAniEvent))

	arg_2_0.bidEventCom:SetEndEvent(function()
		arg_2_0.startBid = false

		arg_2_0:OnPopBidLayer()

		return
	end)
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_4_0)
		if not IsNil(arg_2_0.uiCurrencyIcon) then
			arg_2_0.uiCurrencyIcon.sprite = arg_4_0
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.uiEventBtn, function()
		arg_2_0:OnPopEventLayer()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiForfeitGreyBtn, function()
		if getProxy(AuctionGameProxy):GetAuctionState() >= AuctionGameConst.AUCTION_PHASE.WAIT_OVER then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_cannot_forfeit"))

			return
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiForfeitBtn, function()
		if getProxy(AuctionGameProxy):GetForfeit() then
			return
		end

		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_game_forfeit_tip"),
				comformCallback = function()
					local var_8_0 = getProxy(AuctionGameProxy)
					local var_8_1 = pg.TimeMgr.GetInstance():GetServerTime() - var_8_0:GetTimestamp()

					var_8_1 = var_8_0:GetAuctionState() == AuctionGameConst.AUCTION_PHASE.BID and pg.gameset.auction_bid_time.key_value + var_8_1 or pg.gameset.auction_event_choose_time.key_value + var_8_1

					pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionBid(var_8_0:GetAuctionID(), var_8_0:GetRound(), var_8_1, 0, 1))
					arg_2_0:emit(AuctionGameMainMediator.FORFEIT)

					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiBidBtn, function()
		if arg_2_0.startBid == true then
			return
		end

		if arg_2_0.waitBid then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_wait_bid_phase"))

			return
		end

		if arg_2_0.bided then
			return
		end

		arg_2_0.startBid = true

		quickPlayAnimation(arg_2_0.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:emit(PlayRoomCommonMediator.PLAY_ROOM_MATCH_STOP)
		arg_2_0:emit(AuctionGameMainMediator.EXIT)

		return
	end, SOUND_BACK)

	arg_2_0.playerViewList = {}

	local var_2_0 = getProxy(AuctionGameProxy):GetPlayerList()

	for iter_2_0 = 1, #var_2_0 do
		arg_2_0.playerViewList[iter_2_0] = AuctionGameMainRightPlayerInfo.New(arg_2_0[string.format("uiPlayerTf%s", iter_2_0)], arg_2_0._parentClass)
	end

	for iter_2_1 = #var_2_0 + 1, 4 do
		setActive(arg_2_0[string.format("uiPlayerTf%s", iter_2_1)], false)
	end

	setText(arg_2_0.uiFilterPersonalEventText, i18n("auction_show_personal_event"))
	setText(arg_2_0.uiFilterCommonEventText, i18n("auction_show_common_event"))
	setActive(arg_2_0.uiFilterPanelTf, false)
	onButton(arg_2_0, arg_2_0.uiFilterBtn, function()
		setActive(arg_2_0.uiFilterPanelTf, true)
		arg_2_0:emit(AuctionGameMainScene.SHOW_FILTER_EVENT, arg_2_0.uiFilterPanelTf)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiFilterPersonalEventBtn, function()
		arg_2_0.filterPersonalFlag = not arg_2_0.filterPersonalFlag

		arg_2_0:RefreshFilterPersonalEvent()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiFilterCommonEventBtn, function()
		arg_2_0.filterCommonFlag = not arg_2_0.filterCommonFlag

		arg_2_0:RefreshFilterCommonEvent()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_14_0)
	arg_14_0.filterPersonalFlag = true
	arg_14_0.filterCommonFlag = true

	arg_14_0.infoView:didEnter()
	arg_14_0.infoView:RefreshUI(arg_14_0.filterPersonalFlag, arg_14_0.filterCommonFlag)

	local var_14_0 = getProxy(AuctionGameProxy):GetPlayerList()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.playerViewList) do
		iter_14_1:didEnter(var_14_0[iter_14_0])
	end

	arg_14_0.eventList = {
		arg_14_0:bind(var_0_0.FORFEIT_DONE, handler(arg_14_0, arg_14_0.OnRefreshForfeit)),
		arg_14_0:bind(var_0_0.PLAYER_OPT_STATE_UPDATE, handler(arg_14_0, arg_14_0.OnRefreshPlayerState)),
		arg_14_0:bind(var_0_0.POP_EVENT_LAYER, handler(arg_14_0, arg_14_0.OnPopEventLayer)),
		arg_14_0:bind(var_0_0.EVENT_SELECTED, handler(arg_14_0, arg_14_0.OnEventSelected)),
		arg_14_0:bind(var_0_0.SHOW_EMOJI, handler(arg_14_0, arg_14_0.OnShowEmoji)),
		arg_14_0:bind(var_0_0.SWITCH_EMOJI, handler(arg_14_0, arg_14_0.OnSwitchEmoji))
	}

	setText(arg_14_0.uiCurrencyText, StringHelper.ForamtNumber(AuctionGameTools.GetCurrencyCnt()))

	local var_14_1 = getProxy(AuctionGameProxy)

	if var_14_1.personalEventSelectedID == 0 and #var_14_1.personalEventList > 0 then
		arg_14_0:OnPopEventLayer()
	end

	return
end

function var_0_0.RefreshRound(arg_15_0)
	arg_15_0.startBid = false

	setActive(arg_15_0.uiBidCompleteGo, false)
	setActive(arg_15_0.uiBidBtn, true)

	if arg_15_0.forfeit then
		setActive(arg_15_0.uiForfeitBtn, false)
		setActive(arg_15_0.uiForfeitGreyGo, true)
	else
		setActive(arg_15_0.uiForfeitBtn, true)
		setActive(arg_15_0.uiForfeitGreyGo, false)
	end

	arg_15_0.bided = false
	arg_15_0.waitBid = true

	arg_15_0:RefreshEventTip()
	arg_15_0.infoView:RefreshUI(arg_15_0.filterPersonalFlag, arg_15_0.filterCommonFlag)

	return
end

function var_0_0.StartBid(arg_16_0)
	arg_16_0.bided = false
	arg_16_0.waitBid = false

	arg_16_0:RefreshEventTip()

	return
end

function var_0_0.RefreshEventTip(arg_17_0)
	local var_17_0 = getProxy(AuctionGameProxy)

	setActive(arg_17_0.uiEventTipGo, var_17_0:GetPersonalEventSelectedID() == 0)

	return
end

function var_0_0.RefreshBidDone(arg_18_0, arg_18_1)
	setActive(arg_18_0.uiBidCompleteGo, true)
	setActive(arg_18_0.uiBidBtn, false)
	setActive(arg_18_0.uiForfeitBtn, false)
	setActive(arg_18_0.uiForfeitGreyGo, true)

	arg_18_0.bided = true

	setText(arg_18_0.uiBidCompleteText, i18n("auction_main_bid_price") .. StringHelper.ForamtNumber(arg_18_1))

	return
end

function var_0_0.OnRefreshForfeit(arg_19_0)
	arg_19_0.forfeit = true

	setActive(arg_19_0.uiCloseBtn, true)
	setActive(arg_19_0.uiBidBtn, false)
	setActive(arg_19_0.uiForfeitBtn, false)
	setActive(arg_19_0.uiForfeitGreyGo, true)

	return
end

function var_0_0.OnRefreshPlayerState(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.playerViewList) do
		iter_20_1:RefreshUI()
	end

	return
end

function var_0_0.OnPopBidLayer(arg_21_0)
	arg_21_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainBidLayer,
		mediator = AuctionGameMainBidMediator
	}))

	return
end

function var_0_0.OnPopEventLayer(arg_22_0)
	arg_22_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainEventLayer,
		mediator = AuctionGameMainEventMediator
	}))

	return
end

function var_0_0.OnEventSelected(arg_23_0)
	arg_23_0:RefreshEventTip()
	arg_23_0.infoView:RefreshUI(arg_23_0.filterPersonalFlag, arg_23_0.filterCommonFlag)

	return
end

function var_0_0.OnShowEmoji(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in ipairs((getProxy(AuctionGameProxy):GetPlayerList())) do
		arg_24_0.playerViewList[iter_24_0]:ShowEmoji(arg_24_2.userID, arg_24_2.emojiID)
	end

	return
end

function var_0_0.OnSwitchEmoji(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs((getProxy(AuctionGameProxy):GetPlayerList())) do
		arg_25_0.playerViewList[iter_25_0]:RefreshEmojiBtn()
	end

	return
end

function var_0_0.RefreshFilterPersonalEvent(arg_26_0)
	setActive(arg_26_0.uiFilterPersonalEventSelectedGo, arg_26_0.filterPersonalFlag)
	arg_26_0.infoView:RefreshUI(arg_26_0.filterPersonalFlag, arg_26_0.filterCommonFlag)

	return
end

function var_0_0.RefreshFilterCommonEvent(arg_27_0)
	setActive(arg_27_0.uiFilterCommonEventSelectedGo, arg_27_0.filterCommonFlag)
	arg_27_0.infoView:RefreshUI(arg_27_0.filterPersonalFlag, arg_27_0.filterCommonFlag)

	return
end

function var_0_0.willExit(arg_28_0)
	arg_28_0.bidEventCom:SetEndEvent(nil)

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.eventList) do
		arg_28_0:disconnect(iter_28_1)
	end

	arg_28_0.eventList = nil

	arg_28_0.infoView:willExit()

	arg_28_0.infoView = nil

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.playerViewList) do
		iter_28_3:willExit()
	end

	arg_28_0.playerViewList = nil

	arg_28_0:detach()

	return
end

return var_0_0
