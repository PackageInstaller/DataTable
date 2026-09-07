local PlayRoomCheatBarEntranceScene = class("PlayRoomCheatBarEntranceScene", import("view.base.BaseUI"))

function PlayRoomCheatBarEntranceScene:getUIName()
	return "IslandCheatBarEntranceUI"
end

function PlayRoomCheatBarEntranceScene:init()
	setText(self.uiPointTipsText, i18n("match_ui_point"))
	setText(self.uiRoomText, i18n("match_ui_room_list"))
	setText(self.uiMatchText, i18n("match_ui_point_match"))
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SPX_PANEL)
	onButton(self, self.uiRoomBtn, function()
		if getProxy(PlayRoomProxy):GetMatchFlag() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("match_ui_matching2"))

			return
		end

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomMainScene,
			mediator = PlayRoomMainMediator,
			data = {
				gameType = self:GetGameType()
			}
		}))

		return
	end, SPX_PANEL)
	onButton(self, self.uiMatchBtn, function()
		local var_5_0 = getProxy(PlayRoomProxy)

		if var_5_0:GetMatchFlag() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("match_ui_matching2"))

			return
		end

		local var_5_1 = var_5_0:GetMatchCD()

		if var_5_1 > pg.TimeMgr.GetInstance():GetServerTime() then
			PlayRoomTools.ShowPunishementBox(var_5_1)

			return
		end

		self:emit(PlayRoomEntranceMediator.ON_CLICK_MATCH, {
			type = PlayRoomConst.PLAY_ROOM_TYPE.MATCH,
			gameType = self:GetGameType()
		})

		return
	end, SPX_PANEL)
	onButton(self, self.uiRankBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomRankScene,
			mediator = PlayRoomRankMediator,
			data = {
				gameType = self:GetGameType()
			}
		}))

		return
	end, SPX_PANEL)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_bar.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiSwitchBtn, function()
		self:emit(PlayRoomEntranceMediator.ON_CLICK_CHANGE_CHARACTER)

		return
	end, SPX_PANEL)

	return
end

function PlayRoomCheatBarEntranceScene:didEnter()
	setText(self.uiPointText, PlayRoomTools.GetPtScrore(self:GetGameType()))
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(self:GetGameType()), "", self.uiPointImage, true)

	if self.contextData.params and self.contextData.params.skipInit then
		self.contextData.params.skipInit = false
	else
		self:emit(PlayRoomEntranceMediator.REFRESH_ROOM_INFO)
	end

	local var_9_0 = getProxy(PlayerProxy):getRawData().id

	if PlayerPrefs.GetInt("barHelp" .. var_9_0, 0) == 0 then
		PlayerPrefs.SetInt("barHelp" .. var_9_0, 1)
		triggerButton(self.uiHelpBtn)
	end

	setActive(self.uiSwitchBtn, not getProxy(PlayRoomProxy):GetMatchFlag())

	return
end

function PlayRoomCheatBarEntranceScene:willExit()
	return
end

function PlayRoomCheatBarEntranceScene:GetGameType()
	return PlayRoomConst.GAME_TYPE.CHEATER_TAVERN
end

function PlayRoomCheatBarEntranceScene:OnStartMatch()
	setActive(self.uiSwitchBtn, false)

	return
end

function PlayRoomCheatBarEntranceScene:OnStopMatch()
	setActive(self.uiSwitchBtn, true)

	return
end

function PlayRoomCheatBarEntranceScene:closeView()
	self.contextData.onClose()

	return
end

function PlayRoomCheatBarEntranceScene:onBackPressed()
	self:closeView()

	return
end

return PlayRoomCheatBarEntranceScene
