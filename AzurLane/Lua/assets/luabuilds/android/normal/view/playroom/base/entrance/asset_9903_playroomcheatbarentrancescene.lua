class = var_0_10000

local var_0_0 = "PlayRoomCheatBarEntranceScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCheatBarEntranceUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiPointTipsText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("match_ui_point"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiRoomText

	i18n = var_3

	var_1_10001(var_2_1, var_3("match_ui_room_list"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.uiMatchText

	i18n = var_3

	var_1_10001(var_2_2, var_3("match_ui_point_match"))

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiCloseBtn

	local function var_2_5()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SPX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiRoomBtn

	local function var_2_8()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)

		if var_0.GetMatchFlag(var_4_0) then
			pg = var_0

			local var_4_1 = var_0.TipsMgr.GetInstance()
			local var_4_2 = var_0.ShowTips

			i18n = var_2_10002

			var_4_2(var_4_1, var_2_10002("match_ui_matching2"))

			return
		end

		local var_4_3 = arg_2_0
		local var_4_4 = var_0.emit

		BaseUI = var_2_10002

		local var_4_5 = var_2_10002.ON_ADD_SUBLAYER

		Context = var_2_10003

		local var_4_6 = var_2_10003.New
		local var_4_7 = {}

		PlayRoomMainScene = var_2_10005
		var_4_7.viewComponent = var_2_10005
		PlayRoomMainMediator = var_2_10005
		var_4_7.mediator = var_2_10005

		local var_4_8 = {}
		local var_4_9 = arg_2_0

		var_4_8.gameType = var_6.GetGameType(var_4_9)
		var_4_7.data = var_4_8

		var_4_4(var_4_3, var_4_5, var_4_6(var_4_7))

		return
	end

	SPX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	onButton = var_1_10001

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.uiMatchBtn

	local function var_2_11()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_5_0 = var_2_10000(var_2_10001)

		if var_0.GetMatchFlag(var_5_0) then
			pg = var_1

			local var_5_1 = var_1.TipsMgr.GetInstance()
			local var_5_2 = var_1.ShowTips

			i18n = var_2_10003

			var_5_2(var_5_1, var_2_10003("match_ui_matching2"))

			return
		end

		local var_5_3 = var_0
		local var_5_4 = var_0.GetMatchCD(var_5_3)

		pg = var_5_3

		local var_5_5 = var_5_3.TimeMgr.GetInstance()

		if var_5_4 > var_2.GetServerTime(var_5_5) then
			PlayRoomTools = var_5_5

			var_5_5.ShowPunishementBox(var_5_4)

			return
		end

		local var_5_6 = arg_2_0
		local var_5_7 = var_3.emit

		PlayRoomEntranceMediator = var_2_10005

		local var_5_8 = var_2_10005.ON_CLICK_MATCH
		local var_5_9 = {}

		PlayRoomConst = var_2_10007
		var_5_9.type = var_2_10007.PLAY_ROOM_TYPE.MATCH

		local var_5_10 = arg_2_0

		var_5_9.gameType = var_7.GetGameType(var_5_10)

		var_5_7(var_5_6, var_5_8, var_5_9)

		return
	end

	SPX_PANEL = var_1_10005

	var_1_10001(var_2_9, var_2_10, var_2_11, var_1_10005)

	onButton = var_1_10001

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.uiRankBtn

	local function var_2_14()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		local var_6_2 = var_2_10002.ON_ADD_SUBLAYER

		Context = var_2_10003

		local var_6_3 = var_2_10003.New
		local var_6_4 = {}

		PlayRoomRankScene = var_2_10005
		var_6_4.viewComponent = var_2_10005
		PlayRoomRankMediator = var_2_10005
		var_6_4.mediator = var_2_10005

		local var_6_5 = {}
		local var_6_6 = arg_2_0

		var_6_5.gameType = var_6.GetGameType(var_6_6)
		var_6_4.data = var_6_5

		var_6_1(var_6_0, var_6_2, var_6_3(var_6_4))

		return
	end

	SPX_PANEL = var_1_10005

	var_1_10001(var_2_12, var_2_13, var_2_14, var_1_10005)

	onButton = var_1_10001

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.uiHelpBtn

	local function var_2_17()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_7_2.type = var_2_10003
		pg = var_2_10003
		var_7_2.helps = var_2_10003.gametip.island_help_bar.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_15, var_2_16, var_2_17, var_1_10005)

	onButton = var_1_10001

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.uiSwitchBtn

	local function var_2_20()
		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		PlayRoomEntranceMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_CLICK_CHANGE_CHARACTER)

		return
	end

	SPX_PANEL = var_1_10005

	var_1_10001(var_2_18, var_2_19, var_2_20, var_1_10005)

	return
end

function var_0_1.didEnter(arg_9_0)
	setText = var_1_10001

	local var_9_0 = arg_9_0.uiPointText

	PlayRoomTools = var_1_10003

	var_1_10001(var_9_0, var_1_10003.GetPtScrore(arg_9_0:GetGameType()))

	PlayRoomTools = var_1_10001

	local var_9_1 = var_1_10001.GetPtScoreIcon(arg_9_0:GetGameType())

	GetImageSpriteFromAtlasAsync = var_2

	var_2("Island/IslandCheaterTavernIcon/" .. var_9_1, "", arg_9_0.uiPointImage, true)

	local var_9_2, var_9_3

	if arg_9_0.contextData.params and arg_9_0.contextData.params.skipInit then
		var_9_2 = arg_9_0.contextData.params
		var_9_2.skipInit = false
	else
		var_9_3 = arg_9_0
		var_9_2 = arg_9_0.emit
		PlayRoomEntranceMediator = var_4

		var_9_2(var_9_3, var_4.REFRESH_ROOM_INFO)
	end

	getProxy = var_9_2
	PlayerProxy = var_9_3

	local var_9_4 = var_9_2(var_9_3)
	local var_9_5 = var_2.getRawData(var_9_4).id

	PlayerPrefs = var_9_4

	if var_9_4.GetInt("barHelp" .. var_9_5, 0) == 0 then
		PlayerPrefs = var_3

		var_3.SetInt("barHelp" .. var_9_5, 1)

		triggerButton = var_3

		var_3(arg_9_0.uiHelpBtn)
	end

	getProxy = var_3
	PlayRoomProxy = var_4

	local var_9_6 = var_3(var_4)
	local var_9_7 = var_3.GetMatchFlag(var_9_6)

	setActive = var_9_6

	var_9_6(arg_9_0.uiSwitchBtn, not var_9_7)

	return
end

function var_0_1.willExit(arg_10_0)
	return
end

function var_0_1.GetGameType(arg_11_0)
	PlayRoomConst = var_1_10001

	return var_1_10001.GAME_TYPE.CHEATER_TAVERN
end

function var_0_1.OnStartMatch(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.uiSwitchBtn, false)

	return
end

function var_0_1.OnStopMatch(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0.uiSwitchBtn, true)

	return
end

function var_0_1.closeView(arg_14_0)
	arg_14_0.contextData.onClose()

	return
end

function var_0_1.onBackPressed(arg_15_0)
	arg_15_0:closeView()

	return
end

return var_0_1
