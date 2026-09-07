local AuctionGameMainRightView = class("AuctionGameMainRightView", import("view.base.BasePanel"))

AuctionGameMainRightView.FORFEIT_DONE = "AuctionGameMainRightView::FORFEIT_DONE"
AuctionGameMainRightView.PLAYER_OPT_STATE_UPDATE = "AuctionGameMainRightView::PLAYER_OPT_STATE_UPDATE"
AuctionGameMainRightView.POP_EVENT_LAYER = "AuctionGameMainRightView::POP_EVENT_LAYER"
AuctionGameMainRightView.EVENT_SELECTED = "AuctionGameMainRightView::EVENT_SELECTED"
AuctionGameMainRightView.SHOW_EMOJI = "AuctionGameMainRightView::SHOW_EMOJI"
AuctionGameMainRightView.SWITCH_EMOJI = "AuctionGameMainRightView::SWITCH_EMOJI"

function AuctionGameMainRightView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainRightView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	self.infoView = AuctionGameMainRightInfoView.New(self.uiInfoPanel, arg_1_2)

	return
end

function AuctionGameMainRightView:Init()
	setText(self.uiCurrencyTitleText, i18n("auction_main_pt"))
	setText(self.uiEventBtnText, i18n("auction_main_select_event"))

	self.bidEventCom = GetComponent(self.uiBidAnimationTf, typeof(DftAniEvent))

	self.bidEventCom:SetEndEvent(function()
		self.startBid = false

		self:OnPopBidLayer()

		return
	end)
	LoadSpriteAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):getConfig("config_client").itemID
	}):getIcon(), function(arg_4_0)
		if not IsNil(self.uiCurrencyIcon) then
			self.uiCurrencyIcon.sprite = arg_4_0
		end

		return
	end)
	onButton(self, self.uiEventBtn, function()
		self:OnPopEventLayer()

		return
	end, SFX_PANEL)
	onButton(self, self.uiForfeitGreyBtn, function()
		if getProxy(AuctionGameProxy):GetAuctionState() >= AuctionGameConst.AUCTION_PHASE.WAIT_OVER then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_cannot_forfeit"))

			return
		end

		return
	end, SFX_PANEL)
	onButton(self, self.uiForfeitBtn, function()
		if getProxy(AuctionGameProxy):GetForfeit() then
			return
		end

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_game_forfeit_tip"),
				comformCallback = function()
					local var_8_0 = getProxy(AuctionGameProxy)
					local var_8_1 = pg.TimeMgr.GetInstance():GetServerTime() - var_8_0:GetTimestamp()

					var_8_1 = var_8_0:GetAuctionState() == AuctionGameConst.AUCTION_PHASE.BID and pg.gameset.auction_bid_time.key_value + var_8_1 or pg.gameset.auction_event_choose_time.key_value + var_8_1

					pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionBid(var_8_0:GetAuctionID(), var_8_0:GetRound(), var_8_1, 0, 1))
					self:emit(AuctionGameMainMediator.FORFEIT)

					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiBidBtn, function()
		if self.startBid == true then
			return
		end

		if self.waitBid then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_wait_bid_phase"))

			return
		end

		if self.bided then
			return
		end

		self.startBid = true

		quickPlayAnimation(self.uiBidAnimationTf, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end, SFX_PANEL)
	onButton(self, self.uiCloseBtn, function()
		self:emit(PlayRoomCommonMediator.PLAY_ROOM_MATCH_STOP)
		self:emit(AuctionGameMainMediator.EXIT)

		return
	end, SOUND_BACK)

	self.playerViewList = {}

	local var_2_0 = getProxy(AuctionGameProxy):GetPlayerList()

	for iter_2_0 = 1, #var_2_0 do
		self.playerViewList[iter_2_0] = AuctionGameMainRightPlayerInfo.New(self[string.format("uiPlayerTf%s", iter_2_0)], self._parentClass)
	end

	for iter_2_1 = #var_2_0 + 1, 4 do
		setActive(self[string.format("uiPlayerTf%s", iter_2_1)], false)
	end

	setText(self.uiFilterPersonalEventText, i18n("auction_show_personal_event"))
	setText(self.uiFilterCommonEventText, i18n("auction_show_common_event"))
	setActive(self.uiFilterPanelTf, false)
	onButton(self, self.uiFilterBtn, function()
		setActive(self.uiFilterPanelTf, true)
		self:emit(AuctionGameMainScene.SHOW_FILTER_EVENT, self.uiFilterPanelTf)

		return
	end, SFX_PANEL)
	onButton(self, self.uiFilterPersonalEventBtn, function()
		self.filterPersonalFlag = not self.filterPersonalFlag

		self:RefreshFilterPersonalEvent()

		return
	end, SFX_PANEL)
	onButton(self, self.uiFilterCommonEventBtn, function()
		self.filterCommonFlag = not self.filterCommonFlag

		self:RefreshFilterCommonEvent()

		return
	end, SFX_PANEL)

	return
end

function AuctionGameMainRightView:didEnter()
	self.filterPersonalFlag = true
	self.filterCommonFlag = true

	self.infoView:didEnter()
	self.infoView:RefreshUI(self.filterPersonalFlag, self.filterCommonFlag)

	local var_14_0 = getProxy(AuctionGameProxy):GetPlayerList()

	for iter_14_0, iter_14_1 in ipairs(self.playerViewList) do
		iter_14_1:didEnter(var_14_0[iter_14_0])
	end

	self.eventList = {
		self:bind(AuctionGameMainRightView.FORFEIT_DONE, handler(self, self.OnRefreshForfeit)),
		self:bind(AuctionGameMainRightView.PLAYER_OPT_STATE_UPDATE, handler(self, self.OnRefreshPlayerState)),
		self:bind(AuctionGameMainRightView.POP_EVENT_LAYER, handler(self, self.OnPopEventLayer)),
		self:bind(AuctionGameMainRightView.EVENT_SELECTED, handler(self, self.OnEventSelected)),
		self:bind(AuctionGameMainRightView.SHOW_EMOJI, handler(self, self.OnShowEmoji)),
		self:bind(AuctionGameMainRightView.SWITCH_EMOJI, handler(self, self.OnSwitchEmoji))
	}

	setText(self.uiCurrencyText, StringHelper.ForamtNumber(AuctionGameTools.GetCurrencyCnt()))

	local var_14_1 = getProxy(AuctionGameProxy)

	if var_14_1.personalEventSelectedID == 0 and #var_14_1.personalEventList > 0 then
		self:OnPopEventLayer()
	end

	return
end

function AuctionGameMainRightView:RefreshRound()
	self.startBid = false

	setActive(self.uiBidCompleteGo, false)
	setActive(self.uiBidBtn, true)

	if self.forfeit then
		setActive(self.uiForfeitBtn, false)
		setActive(self.uiForfeitGreyGo, true)
	else
		setActive(self.uiForfeitBtn, true)
		setActive(self.uiForfeitGreyGo, false)
	end

	self.bided = false
	self.waitBid = true

	self:RefreshEventTip()
	self.infoView:RefreshUI(self.filterPersonalFlag, self.filterCommonFlag)

	return
end

function AuctionGameMainRightView:StartBid()
	self.bided = false
	self.waitBid = false

	self:RefreshEventTip()

	return
end

function AuctionGameMainRightView:RefreshEventTip()
	setActive(self.uiEventTipGo, getProxy(AuctionGameProxy):GetPersonalEventSelectedID() == 0)

	return
end

function AuctionGameMainRightView:RefreshBidDone(arg_18_1)
	setActive(self.uiBidCompleteGo, true)
	setActive(self.uiBidBtn, false)
	setActive(self.uiForfeitBtn, false)
	setActive(self.uiForfeitGreyGo, true)

	self.bided = true

	setText(self.uiBidCompleteText, i18n("auction_main_bid_price") .. StringHelper.ForamtNumber(arg_18_1))

	return
end

function AuctionGameMainRightView:OnRefreshForfeit()
	self.forfeit = true

	setActive(self.uiCloseBtn, true)
	setActive(self.uiBidBtn, false)
	setActive(self.uiForfeitBtn, false)
	setActive(self.uiForfeitGreyGo, true)

	return
end

function AuctionGameMainRightView:OnRefreshPlayerState()
	for iter_20_0, iter_20_1 in ipairs(self.playerViewList) do
		iter_20_1:RefreshUI()
	end

	return
end

function AuctionGameMainRightView:OnPopBidLayer()
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainBidLayer,
		mediator = AuctionGameMainBidMediator
	}))

	return
end

function AuctionGameMainRightView:OnPopEventLayer()
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = AuctionGameMainEventLayer,
		mediator = AuctionGameMainEventMediator
	}))

	return
end

function AuctionGameMainRightView:OnEventSelected()
	self:RefreshEventTip()
	self.infoView:RefreshUI(self.filterPersonalFlag, self.filterCommonFlag)

	return
end

function AuctionGameMainRightView:OnShowEmoji(arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in ipairs((getProxy(AuctionGameProxy):GetPlayerList())) do
		self.playerViewList[iter_24_0]:ShowEmoji(arg_24_2.userID, arg_24_2.emojiID)
	end

	return
end

function AuctionGameMainRightView:OnSwitchEmoji()
	for iter_25_0, iter_25_1 in ipairs((getProxy(AuctionGameProxy):GetPlayerList())) do
		self.playerViewList[iter_25_0]:RefreshEmojiBtn()
	end

	return
end

function AuctionGameMainRightView:RefreshFilterPersonalEvent()
	setActive(self.uiFilterPersonalEventSelectedGo, self.filterPersonalFlag)
	self.infoView:RefreshUI(self.filterPersonalFlag, self.filterCommonFlag)

	return
end

function AuctionGameMainRightView:RefreshFilterCommonEvent()
	setActive(self.uiFilterCommonEventSelectedGo, self.filterCommonFlag)
	self.infoView:RefreshUI(self.filterPersonalFlag, self.filterCommonFlag)

	return
end

function AuctionGameMainRightView:willExit()
	self.bidEventCom:SetEndEvent(nil)

	for iter_28_0, iter_28_1 in ipairs(self.eventList) do
		self:disconnect(iter_28_1)
	end

	self.eventList = nil

	self.infoView:willExit()

	self.infoView = nil

	for iter_28_2, iter_28_3 in ipairs(self.playerViewList) do
		iter_28_3:willExit()
	end

	self.playerViewList = nil

	self:detach()

	return
end

return AuctionGameMainRightView
