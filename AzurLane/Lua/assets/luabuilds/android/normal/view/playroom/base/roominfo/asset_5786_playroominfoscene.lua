class = var_0_10000

local var_0_0 = "PlayRoomInfoScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "IslandPlayRoomInfoUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:InitData()

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.OnClickCloseBtn(var_3_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiViewerBtn

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		PlayRoomInfoMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_CLICK_VIEWER)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiReadyBtn

	local function var_2_8()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		PlayRoomInfoMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_CLICK_READY, {
			arg = 1
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_6, var_2_7, var_2_8, var_1_10005)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.uiCancelReadyBtn

	local function var_2_11()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		PlayRoomInfoMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_CLICK_READY, {
			arg = 0
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_9, var_2_10, var_2_11, var_1_10005)

	onButton = var_1

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.uiStartBtn

	local function var_2_14()
		PlayRoomTools = var_2_10000

		if not var_2_10000.CanStartGame() then
			return
		end

		local var_7_0 = {}

		PlayRoomTools = var_2_10001

		if not var_2_10001.IsPlayerFull() then
			table = var_1

			var_1.insert(var_7_0, function(arg_8_0)
				pg = var_3_10001

				local var_8_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_8_1 = var_1.ShowMsgBox
				local var_8_2 = {}

				i18n = var_3_10004
				var_8_2.content = var_3_10004("island_bar_quick_addbot")
				var_8_2.onYes = arg_8_0

				var_8_1(var_8_0, var_8_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_7_0, function()
			local var_9_0 = arg_2_0
			local var_9_1 = var_0.emit

			PlayRoomInfoMediator = var_3_10002

			var_9_1(var_9_0, var_3_10002.ON_CLICK_START_GAME)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_12, var_2_13, var_2_14, var_1_10005)

	onButton = var_1

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.uiRoomSwitchBtn

	local function var_2_17()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		i18n = var_2_10003
		var_10_2.content = var_2_10003("play_room_switch_tip")

		function var_10_2.onYes()
			local var_11_0 = arg_2_0
			local var_11_1 = var_0.emit

			PlayRoomInfoMediator = var_3_10002

			var_11_1(var_11_0, var_3_10002.ON_SWITCH_ROOM_TYPE)

			return
		end

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_15, var_2_16, var_2_17, var_1_10005)

	onButton = var_1

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.uiSenderPanel

	local function var_2_20()
		local var_12_0 = arg_2_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10002

		local var_12_2 = var_2_10002.ON_ADD_SUBLAYER

		Context = var_2_10003

		local var_12_3 = var_2_10003.New
		local var_12_4 = {}

		PlayRoomNotificationLayer = var_2_10005
		var_12_4.viewComponent = var_2_10005
		PlayRoomNotificationMediator = var_2_10005
		var_12_4.mediator = var_2_10005
		var_12_4.data = {
			inRoom = true
		}

		var_12_1(var_12_0, var_12_2, var_12_3(var_12_4))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_18, var_2_19, var_2_20, var_1_10005)

	onButton = var_1

	local var_2_21 = arg_2_0
	local var_2_22 = arg_2_0.uiAcceptBtn

	local function var_2_23()
		local var_13_0 = arg_2_0
		local var_13_1 = var_0.emit

		PlayRoomInfoMediator = var_2_10002

		var_13_1(var_13_0, var_2_10002.ON_MATCH_CLICK_READY, {
			arg = 1
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_21, var_2_22, var_2_23, var_1_10005)

	onButton = var_1

	local var_2_24 = arg_2_0
	local var_2_25 = arg_2_0.uiCopyBtn

	local function var_2_26()
		local var_14_0 = arg_2_0.playRoomProxy
		local var_14_1 = var_0.GetRoomData(var_14_0).teamList

		UniPasteBoard = var_2_10003

		var_2_10003.SetClipBoardString(var_14_1[1])

		pg = var_3

		local var_14_2 = var_3.TipsMgr.GetInstance()
		local var_14_3 = var_3.ShowTips

		i18n = var_2_10005

		var_14_3(var_14_2, var_2_10005("friend_id_copy_ok"))

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_24, var_2_25, var_2_26, var_1_10005)

	arg_2_0.playerItemList = {}
	getProxy = var_1
	PlayRoomProxy = var_2_24

	local var_2_27 = var_1(var_2_24)

	if var_1.GetRoomData(var_2_27) then
		var_2_27 = 1
		PlayRoomTools = var_2_26

		for iter_2_0 = var_2_27, var_2_26.GetMaxTeamCnt(var_2.gameType) do
			local var_2_28 = arg_2_0.playerItemList

			PlayRoomInfoPlayerItem = var_1_10008
			var_1_10008 = var_1_10008.New
			Object = var_1_10009
			var_2_28[iter_2_0] = var_1_10008(var_1_10009.Instantiate(arg_2_0.uiPlayerItem, arg_2_0.uiPlayerPanel), arg_2_0)
		end
	end

	setText = var_2_27

	local var_2_29 = arg_2_0.uiReadyText

	i18n = var_1_10005

	var_2_27(var_2_29, var_1_10005("match_ui_room_ready1"))

	setText = var_2_27

	local var_2_30 = arg_2_0.uiCancelReadyText

	i18n = var_5

	var_2_27(var_2_30, var_5("match_ui_room_ready2"))

	setText = var_2_27

	local var_2_31 = arg_2_0.uiStartText

	i18n = var_5

	var_2_27(var_2_31, var_5("match_ui_room_startgame"))

	setText = var_2_27

	local var_2_32 = arg_2_0.uiAcceptText

	i18n = var_5

	var_2_27(var_2_32, var_5("match_ui_accept"))

	setText = var_2_27

	local var_2_33 = arg_2_0.uiMatchText

	i18n = var_5

	var_2_27(var_2_33, var_5("match_ui_matching"))

	setText = var_2_27

	local var_2_34 = arg_2_0.uiLoadText

	i18n = var_5

	var_2_27(var_2_34, var_5("match_ui_matching_loading"))

	return
end

function var_0_1.InitData(arg_15_0)
	arg_15_0.sceneRoomType = arg_15_0.contextData.sceneRoomType

	return
end

function var_0_1.didEnter(arg_16_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10002
	arg_16_0.playRoomProxy = var_1_10001(var_1_10002)

	local var_16_0 = arg_16_0.playRoomProxy

	if var_1.GetRoomData(var_16_0) == nil then
		local var_16_1 = arg_16_0.uiCloseBtn.onClick

		var_2.Invoke(var_16_1)

		return
	end

	local var_16_2 = arg_16_0

	arg_16_0.InitUIDisplay(var_16_2)

	local var_16_3 = arg_16_0.sceneRoomType

	IslandCheaterTavernConst = var_16_2

	local var_16_4

	if var_16_3 == var_16_2.SceneRoomType.CustomRoom then
		var_16_4 = arg_16_0

		arg_16_0.RefreshUI(var_16_4)
	else
		local var_16_5 = arg_16_0.sceneRoomType

		IslandCheaterTavernConst = var_16_4

		if var_16_5 == var_16_4.SceneRoomType.MatchInfoRoom then
			arg_16_0:RefreshMatchInfoUI()
		else
			arg_16_0:RefreshLoadInfoUI()
		end
	end

	arg_16_0:RefreshMessage()

	return
end

function var_0_1.InitUIDisplay(arg_17_0)
	local var_17_0 = arg_17_0.sceneRoomType

	IslandCheaterTavernConst = var_1_10002

	local var_17_1 = var_17_0 == var_1_10002.SceneRoomType.CustomRoom

	setActive = var_2

	var_2(arg_17_0.uiImage_2, var_17_1)

	setActive = var_2

	var_2(arg_17_0.uiAcceptPanel, not var_17_1)

	setActive = var_2

	var_2(arg_17_0.uiSenderPanel, var_17_1)

	setActive = var_2

	var_2(arg_17_0.uiBtnList, var_17_1)

	setActive = var_2

	var_2(arg_17_0.uiViewerBtn, false)

	setActive = var_2

	var_2(arg_17_0.uiloadPanel, false)

	arg_17_0.isLoading = false

	local var_17_2 = arg_17_0.sceneRoomType

	IslandCheaterTavernConst = var_3

	if var_17_2 == var_3.SceneRoomType.CustomRoom then
		-- block empty
	else
		local var_17_3 = arg_17_0.sceneRoomType

		IslandCheaterTavernConst = var_3

		if var_17_3 == var_3.SceneRoomType.MatchInfoRoom then
			setText = var_17_3

			local var_17_4 = arg_17_0.uiTitleText

			i18n = var_4

			var_17_3(var_17_4, var_4("match_ui_point_match"))
		end
	end

	return
end

function var_0_1.willExit(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.playerItemList) do
		iter_18_1:willExit()
	end

	arg_18_0.playerItemList = nil

	arg_18_0:StopLeanTween()
	arg_18_0:StopLoadLeanTween()

	return
end

function var_0_1.RefreshUI(arg_19_0)
	local var_19_0 = arg_19_0.playRoomProxy
	local var_19_1 = var_1.GetRoomData(var_19_0).roomType
	local var_19_2 = var_2.playerDataList
	local var_19_3 = var_2.teamList

	PlayRoomTools = var_1_10006

	local var_19_4 = var_1_10006.GetHostID()

	PlayRoomConst = var_1_10007

	if var_19_1 == var_1_10007.PLAY_ROOM_TYPE.PERSON then
		setText = var_7

		local var_19_5 = arg_19_0.uiTitleText

		i18n = var_1_10009

		var_7(var_19_5, var_1_10009("match_ui_room_filter6"))
	else
		setText = var_7

		local var_19_6 = arg_19_0.uiTitleText

		i18n = var_1_10009

		var_7(var_19_6, var_1_10009("match_ui_room_filter5"))
	end

	setText = var_7

	var_7(arg_19_0.uiIdText, var_19_4)

	setText = var_7

	local var_19_7 = arg_19_0.uiViewerText

	i18n = var_9

	local var_19_8 = "play_room_viewer_tip"
	local var_19_9 = #var_2.viewerList

	PlayRoomTools = var_1_10012

	var_7(var_19_7, var_9(var_19_8, var_19_9, var_1_10012.GetMaxViewerCnt(var_2.gameType)))

	getProxy = var_7
	PlayerProxy = var_19_7

	local var_19_10 = var_7(var_19_7)
	local var_19_11 = var_19_4 == var_7.getPlayerId(var_19_10)

	setActive = var_9

	var_9(arg_19_0.uiStartBtn, var_19_11)

	setActive = var_9

	var_9(arg_19_0.uiRoomSwitchBtn, var_19_11)

	PlayRoomTools = var_9

	local var_19_12 = var_9.IsViewer()

	setActive = var_10

	var_10(arg_19_0.uiBtnList, not var_19_12)

	if not var_19_12 then
		table = var_10

		local var_19_13 = var_10.contains(var_2.readyList, var_7)

		setActive = var_11

		var_11(arg_19_0.uiReadyBtn, not var_19_13 and not var_19_11)

		setActive = var_11

		var_11(arg_19_0.uiCancelReadyBtn, var_19_13 and not var_19_11)
	end

	arg_19_0:RefreshPlayerList()

	setGray = var_10

	local var_19_14 = arg_19_0.uiStartBtn

	PlayRoomTools = var_12

	var_10(var_19_14, not var_12.CanStartGame(), true)

	return
end

function var_0_1.RefreshPlayerList(arg_20_0)
	local var_20_0 = arg_20_0.playRoomProxy
	local var_20_1 = var_1.GetRoomData(var_20_0).teamPosList

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_20_2 = var_1_10004(var_1_10005)
	local var_20_3 = var_4.getPlayerId(var_20_2)

	ipairs = var_20_2

	for iter_20_0, iter_20_1 in var_20_2(arg_20_0.playerItemList) do
		if var_20_1[iter_20_0] then
			local var_20_4 = var_20_1[iter_20_0][1]

			table = var_1_10011
			var_1_10011 = var_1_10011.contains(var_2.readyList, var_20_3)

			local var_20_5 = iter_20_1
			local var_20_6 = iter_20_1.didEnter
			local var_20_7 = var_2.playerDataList[var_20_4]

			PlayRoomTools = var_1_10015

			var_20_6(var_20_5, var_20_7, var_1_10015.GetHostID(), arg_20_0.sceneRoomType, var_1_10011)
		end
	end

	return
end

function var_0_1.OnClickCloseBtn(arg_21_0)
	if arg_21_0.isLoading then
		return
	end

	local var_21_0 = arg_21_0.sceneRoomType

	IslandCheaterTavernConst = var_1_10002

	if var_21_0 == var_1_10002.SceneRoomType.MatchInfoRoom then
		local var_21_1 = arg_21_0
		local var_21_2 = arg_21_0.emit

		PlayRoomInfoMediator = var_1_10003

		var_21_2(var_21_1, var_1_10003.ON_MATCH_CLICK_READY, {
			arg = 0
		})
	end

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_0.emit

	PlayRoomInfoMediator = var_1_10003

	var_21_4(var_21_3, var_1_10003.ON_CLICK_CLOSE, {
		sceneRoomType = arg_21_0.sceneRoomType
	})

	return
end

function var_0_1.closeView(arg_22_0)
	arg_22_0.contextData.onClose()

	return
end

function var_0_1.RefreshMatchInfoUI(arg_23_0)
	arg_23_0:RefreshMatchInfoPlayerList()

	local var_23_0 = arg_23_0.playRoomProxy

	if not var_1.GetMatchRoomData(var_23_0) then
		return
	end

	getProxy = var_23_0
	PlayerProxy = var_1_10004

	local var_23_1 = var_23_0(var_1_10004)
	local var_23_2 = var_3.getPlayerId(var_23_1)

	table = var_23_1

	local var_23_4

	if var_23_1.contains(var_2.readyList, var_23_2) then
		arg_23_0:StopLeanTween()
		arg_23_0:ShowTimePanel(false)
	else
		arg_23_0:ShowTimePanel(true)

		local var_23_3 = arg_23_0

		var_23_4 = arg_23_0.StartLeanTween
		pg = var_7

		local var_23_5 = var_7.TimeMgr.GetInstance()
		local var_23_6 = var_7.GetServerTime(var_23_5)
		local var_23_7 = arg_23_0.playRoomProxy

		var_23_4(var_23_3, var_23_6, var_8.GetMatchRoomData(var_23_7).endTimestamp)
	end

	setActive = var_23_4

	var_23_4(arg_23_0.uiRoomSwitchBtn, false)

	return
end

function var_0_1.RefreshMatchInfoPlayerList(arg_24_0)
	local var_24_0 = arg_24_0.playRoomProxy

	if not var_1.GetMatchRoomData(var_24_0) then
		return
	end

	local var_24_1 = var_2.teamPosList

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_24_2 = var_1_10004(var_1_10005)
	local var_24_3 = var_4.getPlayerId(var_24_2)

	ipairs = var_24_2

	for iter_24_0, iter_24_1 in var_24_2(arg_24_0.playerItemList) do
		local var_24_4 = var_24_1[iter_24_0][1]

		table = var_1_10011
		var_1_10011 = var_1_10011.contains(var_2.readyList, var_24_3)

		iter_24_1:didEnter(var_2.playerDataList[var_24_4], nil, arg_24_0.sceneRoomType, var_1_10011)
	end

	return
end

function var_0_1.StartLeanTween(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:StopLeanTween()

	if arg_25_2 <= arg_25_1 then
		return
	end

	LeanTween = var_3

	local var_25_0 = var_3.value
	local var_25_1 = arg_25_0._go
	local var_25_2 = arg_25_2 - arg_25_1

	pg = var_1_10006

	local var_25_3 = var_25_0(var_25_1, var_25_2 / var_1_10006.gameset.match_refuseCD.key_value, 0, arg_25_2 - arg_25_1)
	local var_25_4 = var_3.setOnUpdate

	System = var_5

	local var_25_5 = var_25_4(var_25_3, var_5.Action_float(function(arg_26_0)
		local var_26_0 = arg_25_0.uiSlider

		var_26_0.value = arg_26_0
		pg = var_26_0

		local var_26_1 = var_26_0.TimeMgr.GetInstance()
		local var_26_2 = var_1.GetServerTime(var_26_1)
		local var_26_3 = arg_25_2 - var_26_2

		setText = var_2_10003

		local var_26_4 = arg_25_0.uiTimeText

		string = var_2_10005

		local var_26_5 = var_2_10005.format
		local var_26_6 = "%02d:%02d"

		math = var_2_10007

		var_2_10003(var_26_4, var_26_5(var_26_6, var_2_10007.floor(var_26_3 / 60), var_26_3 % 60))

		return
	end))
	local var_25_6 = var_3.setOnComplete

	System = var_5

	var_25_6(var_25_5, var_5.Action(function()
		local var_27_0 = arg_25_0

		var_0.OnClickCloseBtn(var_27_0)

		local var_27_1 = arg_25_0

		var_0.StopLeanTween(var_27_1)

		return
	end))

	return
end

function var_0_1.StopLeanTween(arg_28_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_28_0._go)

	return
end

function var_0_1.StartLoadLeanTween(arg_29_0, arg_29_1)
	arg_29_0:StopLoadLeanTween()

	LeanTween = var_2

	local var_29_0 = var_2.value(arg_29_0._go, 0, 1, arg_29_1)
	local var_29_1 = var_2.setOnUpdate

	System = var_4

	local var_29_2 = var_29_1(var_29_0, var_4.Action_float(function(arg_30_0)
		local var_30_0 = arg_29_0.uiLoadSlider

		var_30_0.value = arg_30_0
		ipairs = var_30_0

		for iter_30_0, iter_30_1 in var_30_0(arg_29_0.playerItemList) do
			iter_30_1:RefreshSelfLoad(arg_30_0 * 100)
		end

		return
	end))
	local var_29_3 = var_2.setOnComplete

	System = var_4

	var_29_3(var_29_2, var_4.Action(function()
		local var_31_0 = arg_29_0

		var_0.StopLoadLeanTween(var_31_0)

		return
	end))

	return
end

function var_0_1.StopLoadLeanTween(arg_32_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_32_0._go)

	return
end

function var_0_1.ShowTimePanel(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_0.uiAcceptPanel, arg_33_1)

	return
end

function var_0_1.RefreshLoadInfoUI(arg_34_0)
	local var_34_0 = arg_34_0.playRoomProxy

	if not var_1.GetGameLoadData(var_34_0) then
		return
	end

	local var_34_1 = var_2.teamPosList

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_34_2 = var_1_10004(var_1_10005)
	local var_34_3 = var_4.getPlayerId(var_34_2)

	table = var_34_2

	local var_34_4 = var_34_2.contains(var_2.readyList, var_34_3)

	ipairs = var_6

	for iter_34_0, iter_34_1 in var_6(arg_34_0.playerItemList) do
		local var_34_5 = var_34_1[iter_34_0][1]

		iter_34_1:didEnter(var_2.playerDataList[var_34_5], nil, arg_34_0.sceneRoomType, var_34_4, var_2.loadList[var_34_5])
	end

	setActive = var_6

	var_6(arg_34_0.uiSenderPanel, false)

	setActive = var_6

	var_6(arg_34_0.uiBtnList, false)
	arg_34_0:StartLoadLeanTween(2)

	return
end

function var_0_1.EnterLoadInfoUI(arg_35_0)
	local var_35_0 = arg_35_0.uiLoadSlider

	var_35_0.value = 0
	setActive = var_35_0

	var_35_0(arg_35_0.uiloadPanel, true)

	arg_35_0.isLoading = true

	arg_35_0:RefreshLoadInfoUI()

	return
end

function var_0_1.RefreshMessage(arg_36_0)
	local var_36_0 = arg_36_0

	arg_36_0.GetMessages(var_36_0)

	local var_36_1 = arg_36_0.displays

	setActive = var_36_0

	var_36_0(arg_36_0.uiChatItemGo, #var_36_1 > 0)

	if #var_36_1 <= 0 then
		return
	end

	local var_36_2 = var_36_1[#var_36_1]
	local var_36_3 = arg_36_0.uiChannelImage

	GetSpriteFromAtlas = var_4

	local var_36_4 = "channel"

	ChatConst = var_1_10006
	var_36_3.sprite = var_4(var_36_4, var_1_10006.GetChannelSprite(var_36_2.type) .. "_mel")

	local var_36_5 = arg_36_0.uiChatText
	local var_36_6 = var_3.GetComponent(var_36_5, "RichText")
	local var_36_7 = var_36_2.type

	ChatConst = var_5

	if var_36_7 == var_5.ChannelPublic then
		var_36_6.supportRichText = true
		ChatProxy = var_4

		var_4.InjectPublic(var_36_6, var_36_2, true)
	elseif var_36_2:IsWorldBossNotify() then
		var_36_6.supportRichText = true

		local var_36_8 = var_36_2.args.playerName
		local var_36_9 = var_36_2.args.bossName

		GetPerceptualSize = var_6

		local var_36_10 = var_6(var_36_8 .. var_36_9) - 18
		local var_36_11

		if 0 < var_36_10 then
			GetPerceptualSize = var_36_11
			var_36_11 = var_36_11(var_36_9) - var_36_10
			shortenString = var_9
			var_36_9 = var_9(var_36_9, var_36_11)
		end

		i18n = var_36_11
		var_36_6.text = var_36_11("ad_4", var_36_2.args.supportType, var_36_8, var_36_9, var_36_2.args.level)
	else
		var_36_6.supportRichText = var_36_2.emojiId ~= nil
		var_36_6.text = arg_36_0:MatchEmoji(var_36_6, var_36_2)
	end

	return
end

function var_0_1.MatchEmoji(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = false
	local var_37_1 = arg_37_2.player.name .. ": " .. arg_37_2.content
	local var_37_2 = false

	string = var_6

	local var_37_3 = var_6.gmatch
	local var_37_4 = var_37_1

	ChatConst = var_1_10008

	for iter_37_0 in var_37_3(var_37_4, var_1_10008.EmojiIconCodeMatch) do
		table = var_1_10011
		var_1_10011 = var_1_10011.contains
		pg = var_1_10012
		var_1_10012 = var_1_10012.emoji_small_template.all
		tonumber = var_1_10013

		if var_1_10011(var_1_10012, var_1_10013(iter_37_0)) then
			var_37_2 = true
			pg = var_1_10011
			var_1_10011 = var_1_10011.emoji_small_template
			tonumber = var_1_10012
			var_1_10011 = var_1_10011[var_1_10012(iter_37_0)]
			LoadSprite = var_1_10012
			var_1_10012 = var_1_10012("emoji/" .. var_1_10011.pic .. "_small", nil)

			arg_37_1:AddSprite(iter_37_0, var_1_10012)
		end
	end

	if not arg_37_2.emojiId then
		if var_37_2 then
			shortenString = var_7

			if not var_7(var_37_1, 16) then
				::label_37_0::

				shortenString = var_7
				var_37_1 = var_7(var_37_1, 20)
			end

			string = var_7

			local var_37_5 = var_7.gsub
			local var_37_6 = var_37_1

			ChatConst = var_9

			return (var_37_5(var_37_6, var_9.EmojiIconCodeMatch, function(arg_38_0)
				table = var_2_10001

				local var_38_0 = var_2_10001.contains

				pg = var_2_10002

				local var_38_1 = var_2_10002.emoji_small_template.all

				tonumber = var_2_10003

				if var_38_0(var_38_1, var_2_10003(arg_38_0)) then
					string = var_1

					return var_1.format("<icon name=%s w=0.7 h=0.7/>", arg_38_0)
				end

				return
			end))
		end
	end
end

function var_0_1.GetMessages(arg_39_0)
	arg_39_0.displays = {}
	getProxy = var_1
	ChatProxy = var_1_10002

	local var_39_0 = var_1(var_1_10002)

	_ = var_1_10002

	var_1_10002.each(var_39_0:getRawData(), function(arg_40_0)
		local var_40_0 = arg_39_0

		var_1.InsertMsg(var_40_0, arg_39_0.displays, arg_40_0)

		return
	end)

	getProxy = var_2
	GuildProxy = var_3

	local var_39_1 = var_2(var_3)

	if var_2.getRawData(var_39_1) then
		_ = var_3

		var_3.each(var_2:getChatMsgs(), function(arg_41_0)
			local var_41_0 = arg_39_0

			var_1.InsertMsg(var_41_0, arg_39_0.displays, arg_41_0)

			return
		end)
	end

	getProxy = var_3
	FriendProxy = var_39_1

	local var_39_2 = var_3(var_39_1)

	_ = var_39_1

	var_39_1.each(var_39_2:getCacheMsgList(), function(arg_42_0)
		local var_42_0 = arg_39_0

		var_1.InsertMsg(var_42_0, arg_39_0.displays, arg_42_0)

		return
	end)

	_ = var_4

	local var_39_3 = var_4.each

	getProxy = var_5
	PlayRoomProxy = var_6

	local var_39_4 = var_5(var_6)

	var_39_3(var_5.GetChatMsgs(var_39_4), function(arg_43_0)
		local var_43_0 = arg_39_0

		var_1.InsertMsg(var_43_0, arg_39_0.displays, arg_43_0)

		return
	end)

	table = var_39_3

	var_39_3.sort(arg_39_0.displays, function(arg_44_0, arg_44_1)
		return arg_44_0.timestamp < arg_44_1.timestamp
	end)

	return
end

function var_0_1.InsertMsg(arg_45_0, arg_45_1, arg_45_2)
	getProxy = var_1_10003
	FriendProxy = var_1_10004

	local var_45_0 = var_1_10003(var_1_10004)

	if var_3.isInBlackList(var_45_0, arg_45_2.playerId) then
		return
	end

	if arg_45_2.player and arg_45_2.content then
		table = var_3

		var_3.insert(arg_45_1, arg_45_2)
	end

	return
end

function var_0_1.onBackPressed(arg_46_0)
	arg_46_0:OnClickCloseBtn()

	return
end

return var_0_1
