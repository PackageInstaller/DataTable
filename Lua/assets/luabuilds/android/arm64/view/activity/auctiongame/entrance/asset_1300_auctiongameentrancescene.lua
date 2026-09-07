local AuctionGameEntranceScene = class("AuctionGameEntranceScene", import("view.base.BaseUI"))

function AuctionGameEntranceScene:getUIName()
	return "AuctionGameEntranceUI"
end

function AuctionGameEntranceScene:init()
	setText(self.uiAuctionValueTitleText, i18n("auction_value"))
	setText(self.uiAuctionTicketTitleText, i18n("auction_ticket"))
	setText(self.uiAuctionMatchingText, i18n("auction_matching"))
	setText(self.uiAuctionAssistantText, i18n("auction_assistant"))
	setText(self.uiPreorderEndText, i18n("auction_activity_closed"))
	setText(self.uiReliefText, i18n("auction_relief_tip"))

	self.matchEventCom = GetComponent(self.uiMatchBtn, typeof(DftAniEvent))

	self.matchEventCom:SetEndEvent(function(arg_3_0)
		self.startMatch = false

		self:emit(PlayRoomCommonMediator.ON_CLICK_QUICK_MATCH, {
			type = pg.auction_session[self.curSelectedID].game_type
		})

		return
	end)
	onButton(self, self.uiBackBtn, function()
		self:onBackPressed()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHelpBtn, function()
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionHelp())
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.auction_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiCollectionBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameCollectionListLayer,
			mediator = AuctionGameCollectionListMediator
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiTaskBtn, function()
		if not self.quickMatchSuccess and self.startQuickMatch == true then
			self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
				viewComponent = AuctionGameMainMsgLayer,
				mediator = AuctionGameMainMsgMediator,
				data = {
					content = i18n("auction_main_match_exit"),
					comformCallback = function()
						self:OnClickStopQuickMatch()
						self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
							viewComponent = AuctionGameTaskScene,
							mediator = AuctionGameTaskMediator,
							data = {}
						}))

						return
					end,
					cancelCallback = function()
						return
					end
				}
			}))
		else
			self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
				viewComponent = AuctionGameTaskScene,
				mediator = AuctionGameTaskMediator,
				data = {}
			}))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.uiPreorderBtn, function()
		if self.startQuickMatch == true then
			return
		end

		getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):SetPreorderTip()
		self:RefreshPreorderTip()

		local var_10_0 = getProxy(AuctionGameBaseProxy)
		local var_10_1 = AuctionGameTools.GetPreorderCurrentyCnt()

		if var_10_1 > AuctionGameTools.GetCurrencyCnt() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_currency_noenough"))

			return
		end

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_preorder_tips", var_10_1),
				comformCallback = function()
					self:emit(AuctionGameEntranceMediator.CLICK_PREORDER_BOX)

					return
				end,
				cancelCallback = function()
					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiOpenPreorderBtn, function()
		if self.startQuickMatch == true then
			return
		end

		local var_13_0 = getProxy(AuctionGameBaseProxy)

		if var_13_0:GetPreorderState() == 1 and pg.TimeMgr.GetInstance():GetServerTime() < var_13_0:GetPreorderTimestamp() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_preorder_tips_1"))

			return
		end

		self:emit(AuctionGameEntranceMediator.CLICK_OPEN_BOX)

		return
	end, SFX_PANEL)
	onButton(self, self.uiMatchBtn, function()
		if self.startMatch == true then
			return
		end

		if not pg.NewStoryMgr.GetInstance():IsPlayed("AUCTION_GUIDE_6") then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.AUCTION_GAME_MAIN_GUIDE)

			return
		end

		local var_14_0 = getProxy(AuctionGameBaseProxy)

		if var_14_0.serverForbidden == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_match_forbidden"))

			return
		end

		if var_14_0.isForbidden == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_game_match_forbidden"))

			return
		end

		if var_14_0.inactiveNum == 1 and var_14_0.isMatchWarning == 0 then
			self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
				viewComponent = AuctionGameMainMsgLayer,
				mediator = AuctionGameMainMsgMediator,
				data = {
					content = i18n("auction_game_match_warning"),
					comformCallback = function()
						return
					end,
					cancelCallback = function()
						return
					end
				}
			}))
			self:emit(AuctionGameEntranceMediator.SHOW_WARNING_TIP)
		end

		if AuctionGameTools.GetCurrencyCnt() < pg.auction_session[self.lastSelectedID].threshold then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_currency_noenough"))

			return
		end

		self.curSelectedID = self.lastSelectedID
		self.startMatch = true

		quickPlayAnimation(self.uiMatchBtn, "Anim_AuctionGameEntranceUI_matchBtn_click")

		return
	end, AuctionGameConst.SOUND_EFFECT.START_MATCHING)
	onButton(self, self.uiCancelMatchBtn, function()
		self:OnClickStopQuickMatch()

		return
	end, AuctionGameConst.SOUND_EFFECT.CANCEL_MATCHING)
	onButton(self, self.uiReliefBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_relief_tip_2", pg.gameset.auction_relief_payment_count.key_value - getProxy(AuctionGameBaseProxy).reliefCnt, pg.gameset.auction_relief_payment_count.key_value),
				comformCallback = function()
					self:emit(AuctionGameEntranceMediator.CLICK_GET_RELIEF)

					return
				end,
				cancelCallback = function()
					return
				end
			}
		}))

		return
	end, SFX_PANEL)

	self.paintingPanelView = AuctionGameEntrancePaintingPanel.New(self.uiLeftPanel, self)
	self.locationItemList = {}

	for iter_2_0, iter_2_1 in ipairs(pg.auction_session.all) do
		if pg.auction_session[iter_2_1].game_type ~= 0 then
			table.insert(self.locationItemList, AuctionGameEntranceLocationItem.New(self[string.format("uiLocationTf%s", #self.locationItemList + 1)], self, iter_2_1))
		end
	end

	self.playerPanelView = AuctionGamePlayerPanel.New(self.uiPlayerInfo, self)

	return
end

function AuctionGameEntranceScene:didEnter()
	Screen.sleepTimeout = SleepTimeout.NeverSleep

	self:OverlayPanel(self.uiAdaptTf, {
		pbList = {
			self.uiLocationInfoTf
		}
	})
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionEnter())
	self:OnClickStopQuickMatch()
	self.paintingPanelView:didEnter()
	self.playerPanelView:didEnter()

	self.lastSelectedID = AuctionGameTools.GetLastLocationSelectedID()
	self.eventList = {
		self:bind(AuctionGameEntranceLocationItem.SELECTED_LOCATION, handler(self, self.OnSelectedLocation))
	}

	self:RefreshUI()

	local var_21_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME)

	pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_1", {
		var_21_0:GetTaskTip() and 1 or 0
	}, nil, true)

	if pg.NewStoryMgr.GetInstance():IsPlayed("AUCTION_GUIDE_6") then
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("AUCTION_GUIDE_3")
	end

	self:RefreshRelief()

	return
end

function AuctionGameEntranceScene:RefreshUI()
	self:RefreshLocationList()
	self:RefreshPreorderBtn()
	self:RefreshTaskTip()
	self:RefreshPreorderTip()
	self:RefreshOpenPreorderTip()
	self:RefreshForbidden()
	self:ShowWarning()

	return
end

function AuctionGameEntranceScene:OnUpdateCurrency()
	self:RefreshLocationList()
	self:RefreshPreorderBtn()
	self.playerPanelView:didEnter()
	self:RefreshRelief()
	self:RefreshPreorderTip()

	return
end

function AuctionGameEntranceScene:OnSelectedLocation(arg_24_1, arg_24_2)
	if arg_24_2 == self.lastSelectedID then
		return
	end

	if self.startQuickMatch == true then
		return
	end

	AuctionGameTools.SetLastLocationSelectedID(arg_24_2)

	self.lastSelectedID = arg_24_2

	self:RefreshLocationList()

	return
end

function AuctionGameEntranceScene:RefreshLocationList()
	for iter_25_0, iter_25_1 in ipairs(self.locationItemList) do
		iter_25_1:didEnter(self.lastSelectedID)
	end

	local var_25_0 = pg.auction_session[self.lastSelectedID]

	setText(self.uiAuctionValueText, pg.auction_session[self.lastSelectedID].auction_value)
	setText(self.uiAuctionTicketText, string.format("<color=%s>%s</color>", AuctionGameTools.GetCurrencyCnt() >= var_25_0.ticket and "#393a3c" or "#bf5050", StringHelper.ForamtNumberK(var_25_0.ticket)))

	return
end

function AuctionGameEntranceScene:FormatMatchDuration(arg_26_1)
	arg_26_1 = math.max(0, math.floor(arg_26_1 or 0))

	return string.format("%02d:%02d", math.floor(arg_26_1 / 60), arg_26_1 % 60)
end

function AuctionGameEntranceScene:OnQuickMatch()
	getProxy(AuctionGameProxy):InitGameData(self.curSelectedID)

	self.startQuickMatch = true
	self.startTime = pg.TimeMgr.GetInstance():GetServerTime()

	self:AddMatchTimer()
	setActive(self.uiMatchTimeGo, true)
	setActive(self.uiCancelMatchBtn, true)
	setActive(self.uiMatchBtn, false)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionMatching(0, 0, self.curSelectedID))

	return
end

function AuctionGameEntranceScene:OnClickStopQuickMatch()
	if self.startQuickMatch == true then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionMatching(1, pg.TimeMgr.GetInstance():GetServerTime() - self.startTime, self.curSelectedID))
	end

	self:emit(PlayRoomCommonMediator.PLAY_ROOM_MATCH_STOP)

	return
end

function AuctionGameEntranceScene:OnQuickMatchSuccess()
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionMatching(2, pg.TimeMgr.GetInstance():GetServerTime() - self.startTime, self.curSelectedID))

	self.quickMatchSuccess = true

	local var_29_0 = getProxy(AuctionGameBaseProxy)

	var_29_0:AddGold(pg.auction_session[self.curSelectedID].ticket * -1)
	var_29_0:SetNeedInitFlag(true)

	if getProxy(ContextProxy):getContextByMediator(AuctionGameMainMsgMediator) then
		LoadContextCommand.RemoveLayerByMediator(AuctionGameMainMsgMediator)
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.AUCTION_GAME_MAIN)
	self:StopMatchTimer()

	return
end

function AuctionGameEntranceScene:OnStopMatch()
	self.startQuickMatch = false

	self:StopMatchTimer()
	setActive(self.uiMatchTimeGo, false)
	setActive(self.uiCancelMatchBtn, false)
	setActive(self.uiMatchBtn, true)

	return
end

function AuctionGameEntranceScene:IsQuickMatch()
	return self.startQuickMatch
end

function AuctionGameEntranceScene:AddMatchTimer()
	self:StopMatchTimer()

	self.matchTimer = Timer.New(function()
		setText(self.uiMatchTimeText, self:FormatMatchDuration(pg.TimeMgr.GetInstance():GetServerTime() - self.startTime))

		return
	end, 1, -1)

	self.matchTimer:Start()
	self.matchTimer.func()

	return
end

function AuctionGameEntranceScene:StopMatchTimer()
	if self.matchTimer then
		self.matchTimer:Stop()

		self.matchTimer = nil
	end

	return
end

function AuctionGameEntranceScene:RefreshForbidden()
	local var_35_0 = getProxy(AuctionGameBaseProxy).forbiddenTime

	if var_35_0 > pg.TimeMgr.GetInstance():GetServerTime() then
		setActive(self.uiForbiddenGo, true)
		self:AddForbiddenTimer(var_35_0)
	else
		setActive(self.uiForbiddenGo, false)
	end

	return
end

function AuctionGameEntranceScene:AddForbiddenTimer(arg_36_1)
	self:StopForbiddenTimer()

	self.forbiddenTimer = Timer.New(function()
		local var_37_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if var_37_0 < arg_36_1 then
			setText(self.uiForbiddenText, i18n("auction_forbidden_tip", self:FormatPreorderDuration(arg_36_1 - var_37_0)))
		else
			self:StopForbiddenTimer()
			self:RefreshForbidden()
		end

		return
	end, 1, -1)

	self.forbiddenTimer.func()
	self.forbiddenTimer:Start()

	return
end

function AuctionGameEntranceScene:StopForbiddenTimer()
	if self.forbiddenTimer then
		self.forbiddenTimer:Stop()

		self.forbiddenTimer = nil
	end

	return
end

function AuctionGameEntranceScene:RefreshPreorderBtn()
	local var_39_0 = getProxy(AuctionGameBaseProxy)
	local var_39_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_39_0:GetPreorderState() == 1 then
		setActive(self.uiPreorderEndGo, false)

		if var_39_1 < var_39_0:GetPreorderTimestamp() then
			setActive(self.uiPreorderBtn, false)
			setActive(self.uiPreorderTimeGo, true)
			setActive(self.uiOpenPreorderBtn, true)
			self:AddPreorderTimer()
		else
			setActive(self.uiPreorderBtn, false)
			setActive(self.uiPreorderTimeGo, false)
			setActive(self.uiOpenPreorderBtn, true)
			self:StopPreorderTimer()
		end
	else
		local var_39_2 = pg.TimeMgr.GetInstance():IsSameDay(var_39_1, getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME).stopTime)

		setActive(self.uiPreorderBtn, not var_39_2)
		setActive(self.uiPreorderEndGo, var_39_2)
		setActive(self.uiPreorderTimeGo, false)
		setActive(self.uiOpenPreorderBtn, false)

		local var_39_3 = AuctionGameTools.GetPreorderCurrentyCnt()

		setText(self.uiPreorderPriceText, string.format("<color=%s>%s</color>", var_39_3 > AuctionGameTools.GetCurrencyCnt() and "#bf5050" or "#ffffff", StringHelper.ForamtNumberK(var_39_3)))
	end

	return
end

function AuctionGameEntranceScene:AddPreorderTimer()
	self:StopPreorderTimer()

	local var_40_0 = getProxy(AuctionGameBaseProxy):GetPreorderTimestamp()

	self.preorderTimer = Timer.New(function()
		local var_41_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if var_41_0 >= var_40_0 then
			self:StopPreorderTimer()
			self:RefreshPreorderBtn()
		else
			setText(self.uiPreorderTimeText, self:FormatPreorderDuration(var_40_0 - var_41_0))
		end

		return
	end, 1, -1)

	self.preorderTimer:Start()
	self.preorderTimer.func()

	return
end

function AuctionGameEntranceScene:FormatPreorderDuration(arg_42_1)
	arg_42_1 = math.max(0, math.floor(arg_42_1 or 0))

	return string.format("%02d:%02d:%02d", math.floor(arg_42_1 / 16), math.floor(arg_42_1 / 60) % 60, arg_42_1 % 60)
end

function AuctionGameEntranceScene:StopPreorderTimer()
	if self.preorderTimer then
		self.preorderTimer:Stop()

		self.preorderTimer = nil
	end

	return
end

function AuctionGameEntranceScene:RefreshTaskTip()
	setActive(self.uiTaskTipGo, getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):GetTaskTip())

	return
end

function AuctionGameEntranceScene:RefreshPreorderTip()
	setActive(self.uiPreorderTipGo, getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):GetPreorderTip())

	return
end

function AuctionGameEntranceScene:RefreshOpenPreorderTip()
	setActive(self.uiOpenPreorderTipGo, getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):GetOpenPreorderTip())

	return
end

function AuctionGameEntranceScene:RefreshLocationTip()
	for iter_47_0, iter_47_1 in ipairs(self.locationItemList) do
		iter_47_1:RefreshState()
	end

	return
end

function AuctionGameEntranceScene:RefreshRelief()
	if pg.NewGuideMgr.GetInstance():IsBusy() then
		setActive(self.uiReliefBtn, false)

		return
	end

	local var_48_0 = getProxy(AuctionGameBaseProxy)

	setActive(self.uiReliefBtn, (getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME):GetReliefTip()))

	return
end

function AuctionGameEntranceScene:ShowWarning()
	local var_49_0 = getProxy(AuctionGameBaseProxy)
	local var_49_1 = pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
	local var_49_2 = getProxy(PlayerProxy):getPlayerId()

	if var_49_0.inactiveNum ~= PlayerPrefs.GetInt(string.format("AUCTION_GAME_WARNING_%s_%s", var_49_2, var_49_1), 0) then
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_game_punishment", var_49_0.inactiveNum),
				comformCallback = function()
					return
				end,
				cancelCallback = function()
					return
				end
			}
		}))
	end

	PlayerPrefs.SetInt(string.format("AUCTION_GAME_WARNING_%s_%s", var_49_2, var_49_1), var_49_0.inactiveNum)

	return
end

function AuctionGameEntranceScene:willExit()
	Screen.sleepTimeout = getProxy(SettingsProxy):GetMainSceneScreenSleepTime()

	self:UnOverlayPanel(self.uiAdaptTf, self._tf)
	self:StopMatchTimer()
	self:StopPreorderTimer()
	self:StopForbiddenTimer()
	self.matchEventCom:SetEndEvent(nil)

	for iter_52_0, iter_52_1 in ipairs(self.eventList) do
		self:disconnect(iter_52_1)
	end

	self.eventList = nil

	self.paintingPanelView:willExit()

	self.paintingPanelView = nil

	for iter_52_2, iter_52_3 in ipairs(self.locationItemList) do
		iter_52_3:willExit()
	end

	self.locationItemList = nil

	self.playerPanelView:willExit()

	self.playerPanelView = nil

	return
end

function AuctionGameEntranceScene:onBackPressed()
	if not self.quickMatchSuccess and self.startQuickMatch == true then
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainMsgLayer,
			mediator = AuctionGameMainMsgMediator,
			data = {
				content = i18n("auction_main_match_exit"),
				comformCallback = function()
					self:OnClickStopQuickMatch()
					AuctionGameEntranceScene.super.onBackPressed(self)

					return
				end,
				cancelCallback = function()
					return
				end
			}
		}))
	else
		AuctionGameEntranceScene.super.onBackPressed(self)
	end

	return
end

return AuctionGameEntranceScene
