local var_0_0 = class("PlayRoomCheatBarEntranceScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCheatBarEntranceUI"
end

function var_0_0.init(arg_2_0)
	setText(arg_2_0.uiPointTipsText, i18n("match_ui_point"))
	setText(arg_2_0.uiRoomText, i18n("match_ui_room_list"))
	setText(arg_2_0.uiMatchText, i18n("match_ui_point_match"))
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SPX_PANEL)
	onButton(arg_2_0, arg_2_0.uiRoomBtn, function()
		if getProxy(PlayRoomProxy):GetMatchFlag() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("match_ui_matching2"))

			return
		end

		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomMainScene,
			mediator = PlayRoomMainMediator,
			data = {
				gameType = arg_2_0:GetGameType()
			}
		}))

		return
	end, SPX_PANEL)
	onButton(arg_2_0, arg_2_0.uiMatchBtn, function()
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

		arg_2_0:emit(PlayRoomEntranceMediator.ON_CLICK_MATCH, {
			type = PlayRoomConst.PLAY_ROOM_TYPE.MATCH,
			gameType = arg_2_0:GetGameType()
		})

		return
	end, SPX_PANEL)
	onButton(arg_2_0, arg_2_0.uiRankBtn, function()
		arg_2_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomRankScene,
			mediator = PlayRoomRankMediator,
			data = {
				gameType = arg_2_0:GetGameType()
			}
		}))

		return
	end, SPX_PANEL)
	onButton(arg_2_0, arg_2_0.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_bar.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiSwitchBtn, function()
		arg_2_0:emit(PlayRoomEntranceMediator.ON_CLICK_CHANGE_CHARACTER)

		return
	end, SPX_PANEL)

	return
end

function var_0_0.didEnter(arg_9_0)
	setText(arg_9_0.uiPointText, PlayRoomTools.GetPtScrore(arg_9_0:GetGameType()))
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(arg_9_0:GetGameType()), "", arg_9_0.uiPointImage, true)

	if arg_9_0.contextData.params and arg_9_0.contextData.params.skipInit then
		arg_9_0.contextData.params.skipInit = false
	else
		arg_9_0:emit(PlayRoomEntranceMediator.REFRESH_ROOM_INFO)
	end

	local var_9_0 = getProxy(PlayerProxy)
	local var_9_1 = var_9_0:getRawData().id

	if PlayerPrefs.GetInt("barHelp" .. var_9_1, 0) == 0 then
		PlayerPrefs.SetInt("barHelp" .. var_9_1, 1)
		triggerButton(arg_9_0.uiHelpBtn)
	end

	local var_9_2 = getProxy(PlayRoomProxy)

	setActive(arg_9_0.uiSwitchBtn, not var_9_2:GetMatchFlag())

	return
end

function var_0_0.willExit(arg_10_0)
	return
end

function var_0_0.GetGameType(arg_11_0)
	return PlayRoomConst.GAME_TYPE.CHEATER_TAVERN
end

function var_0_0.OnStartMatch(arg_12_0)
	setActive(arg_12_0.uiSwitchBtn, false)

	return
end

function var_0_0.OnStopMatch(arg_13_0)
	setActive(arg_13_0.uiSwitchBtn, true)

	return
end

function var_0_0.closeView(arg_14_0)
	arg_14_0.contextData.onClose()

	return
end

function var_0_0.onBackPressed(arg_15_0)
	arg_15_0:closeView()

	return
end

return var_0_0
