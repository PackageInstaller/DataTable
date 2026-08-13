class = var_0_10000

local var_0_0 = "PlayRoomMainScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.ON_CLICK_ITEM_BTN = "PlayRoomMainScene:ON_CLICK_ITEM_BTN"

function var_0_1.getUIName(arg_1_0)
	return "IslandPlayRoomMainUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.OverlayPanel
	local var_2_2 = arg_2_0._tf
	local var_2_3 = {}
	local var_2_4 = {}
	local var_2_5 = arg_2_0._tf

	var_2_4[1] = var_6.Find(var_2_5, "bg")
	var_2_4[2] = arg_2_0.uiCreatePanel
	var_2_3.pbList = var_2_4

	var_2_1(var_2_0, var_2_2, var_2_3)

	setText = var_2_1

	local var_2_6 = arg_2_0.uiTitleText

	i18n = var_2_2

	var_2_1(var_2_6, var_2_2("play_room_season"))

	setText = var_2_1

	local var_2_7 = arg_2_0.uiTitleEnText

	i18n = var_3

	var_2_1(var_2_7, var_3("play_room_season_en"))

	setText = var_2_1

	local var_2_8 = arg_2_0.uiCreateRoomText

	i18n = var_3

	var_2_1(var_2_8, var_3("match_ui_room_create"))

	setText = var_2_1

	local var_2_9 = arg_2_0.uiSearchText

	i18n = var_3

	var_2_1(var_2_9, var_3("match_ui_room_search"))

	LuaList = var_2_1

	local var_2_10 = var_2_1.New
	local var_2_11 = arg_2_0

	handler = var_3

	local var_2_12 = var_3(arg_2_0, arg_2_0.IndexItem)
	local var_2_13 = arg_2_0.uiScrollViewTf

	PlayRoomMainItem = var_5
	arg_2_0.uiLScrollView = var_2_10(var_2_11, var_2_12, var_2_13, var_5)
	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.uiCloseBtn

	local function var_2_16()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_14, var_2_15, var_2_16, var_5)

	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.uiCreateRoomBtn

	local function var_2_19()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiCreatePanel, true)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_17, var_2_18, var_2_19, var_5)

	onButton = var_1

	local var_2_20 = arg_2_0
	local var_2_21 = arg_2_0.uiQuickRoomBtn

	local function var_2_22()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		PlayRoomMainMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.JOIN_ROOM, {
			id = 0
		})

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_20, var_2_21, var_2_22, var_5)

	setText = var_1

	local var_2_23 = arg_2_0.uiQuickRoomBtn
	local var_2_24 = var_2.Find(var_2_23, "Text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("island_bar_quick_game"))

	onButton = var_1

	local var_2_25 = arg_2_0
	local var_2_26 = arg_2_0.uiRefreshRoomBtn

	local function var_2_27()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		PlayRoomMainMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.REFRESH_ROOM_LIST)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_25, var_2_26, var_2_27, var_5)

	onButton = var_1

	local var_2_28 = arg_2_0
	local var_2_29 = arg_2_0.uiSearchBtn

	local function var_2_30()
		if arg_2_0.uiInputField.text == "" then
			return
		end

		local var_7_0 = arg_2_0

		PlayRoomTools = var_2_10001
		var_7_0.searchList = var_2_10001.SearchRoomList(arg_2_0.uiInputField.text)

		local var_7_1 = arg_2_0

		var_0.RefreshRoomList(var_7_1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_28, var_2_29, var_2_30, var_5)

	onInputChanged = var_1

	var_1(arg_2_0, arg_2_0.uiInputField, function()
		if arg_2_0.uiInputField.text == "" and arg_2_0.searchList then
			arg_2_0.searchList = nil

			local var_8_0 = arg_2_0

			var_1.RefreshRoomList(var_8_0)
		end

		return
	end)

	onButton = var_1

	local var_2_31 = arg_2_0
	local var_2_32 = arg_2_0.uiSortBtn

	local function var_2_33()
		arg_2_0.selectedAscend = not arg_2_0.selectedAscend

		local var_9_0 = arg_2_0

		var_0.RefreshUI(var_9_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_31, var_2_32, var_2_33, var_5)

	onButton = var_1

	local var_2_34 = arg_2_0
	local var_2_35 = arg_2_0.uiFilterBtn

	local function var_2_36()
		local var_10_0 = arg_2_0.filterPanelView

		var_0.Show(var_10_0, true)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_34, var_2_35, var_2_36, var_5)

	onButton = var_1

	local var_2_37 = arg_2_0
	local var_2_38 = arg_2_0.uiCommonBtn

	local function var_2_39()
		local var_11_0 = arg_2_0
		local var_11_1 = var_0.emit

		PlayRoomMainMediator = var_2_10002

		local var_11_2 = var_2_10002.CREATE_ROOM
		local var_11_3 = {}

		PlayRoomConst = var_2_10004
		var_11_3.type = var_2_10004.PLAY_ROOM_TYPE.COMMON

		local var_11_4 = arg_2_0

		var_11_3.gameType = var_4.GetGameType(var_11_4)

		var_11_1(var_11_0, var_11_2, var_11_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_37, var_2_38, var_2_39, var_5)

	onButton = var_1

	local var_2_40 = arg_2_0
	local var_2_41 = arg_2_0.uiPersonBtn

	local function var_2_42()
		local var_12_0 = arg_2_0
		local var_12_1 = var_0.emit

		PlayRoomMainMediator = var_2_10002

		local var_12_2 = var_2_10002.CREATE_ROOM
		local var_12_3 = {}

		PlayRoomConst = var_2_10004
		var_12_3.type = var_2_10004.PLAY_ROOM_TYPE.PERSON

		local var_12_4 = arg_2_0

		var_12_3.gameType = var_4.GetGameType(var_12_4)

		var_12_1(var_12_0, var_12_2, var_12_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_40, var_2_41, var_2_42, var_5)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.uiCloseCreateBtn, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiCreatePanel, false)

		return
	end)

	return
end

function var_0_1.didEnter(arg_14_0)
	local var_14_0 = arg_14_0

	arg_14_0.RefreshInputField(var_14_0)

	local var_14_1 = arg_14_0.contextData

	PlayRoomConst = var_14_0
	var_14_1.selectedRoomSortType = var_14_0.ROOM_SORT_TYPE.ROOM_PLAYER_SUM

	local var_14_2 = arg_14_0.contextData

	PlayRoomConst = var_2
	var_14_2.selectedRoomType = var_2.PLAY_ROOM_TYPE.ALL

	local var_14_3 = arg_14_0.contextData

	PlayRoomConst = var_2
	var_14_3.selectedRoomState = var_2.PLAY_ROOM_STATE.ALL
	arg_14_0.selectedAscend = true
	PlayRoomMainFilterView = var_1
	arg_14_0.filterPanelView = var_1.New(arg_14_0.uiFilterPanel, arg_14_0, arg_14_0.contextData)

	local var_14_4 = {}
	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0.bind
	local var_14_7 = var_0_1.ON_CLICK_ITEM_BTN

	handler = var_1_10005
	var_14_4[1] = var_14_6(var_14_5, var_14_7, var_1_10005(arg_14_0, arg_14_0.OnRefreshSortBtn))
	arg_14_0.eventList = var_14_4

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.emit

	PlayRoomMainMediator = var_14_5

	var_14_9(var_14_8, var_14_5.REFRESH_ROOM_LIST)

	return
end

function var_0_1.willExit(arg_15_0)
	arg_15_0:UnOverlayPanel(arg_15_0._tf)

	ipairs = var_1

	for iter_15_0, iter_15_1 in var_1(arg_15_0.eventList) do
		arg_15_0:disconnect(iter_15_1)
	end

	local var_15_0 = arg_15_0.filterPanelView

	var_1.willExit(var_15_0)

	arg_15_0.filterPanelView = nil

	local var_15_1 = arg_15_0.uiLScrollView

	var_1.Dispose(var_15_1)

	arg_15_0.uiLScrollView = nil

	return
end

function var_0_1.GetGameType(arg_16_0)
	return arg_16_0.contextData.gameType
end

function var_0_1.FilterRoomList(arg_17_0, arg_17_1)
	PlayRoomTools = var_1_10002
	arg_17_1 = var_1_10002.FilterRoomType(arg_17_1, arg_17_0.contextData.selectedRoomType)
	PlayRoomTools = var_2
	arg_17_1 = var_2.FilterRoomState(arg_17_1, arg_17_0.contextData.selectedRoomState)
	PlayRoomTools = var_2

	return (var_2.SortRoomList(arg_17_1, arg_17_0.contextData.selectedRoomSortType, arg_17_0.selectedAscend))
end

function var_0_1.RefreshUI(arg_18_0)
	arg_18_0:RefreshSortText()
	arg_18_0:RefreshSortAscend()
	arg_18_0:RefreshRoomList()

	local var_18_0 = arg_18_0.uiSortArrTf

	if arg_18_0.selectedAscend then
		Vector2 = var_18_1

		local var_18_1

		if not var_18_1(1, -1, 1) then
			Vector2 = var_18_1
			var_18_1 = var_18_1(1, 1, 1)
		end

		var_18_0.localScale = var_18_1

		return
	end
end

function var_0_1.RefreshRoomList(arg_19_0)
	local var_19_0

	if arg_19_0.searchList then
		var_19_0 = arg_19_0.searchList
	else
		getProxy = var_2
		PlayRoomProxy = var_1_10003

		local var_19_1 = var_2(var_1_10003)

		var_19_0 = var_2.GetPlayRoomList(var_19_1)
	end

	arg_19_0.sortList = arg_19_0:FilterRoomList(var_19_0)

	local var_19_2 = arg_19_0.uiLScrollView

	var_2.StartScroll(var_19_2, #var_1)

	setActive = var_2

	var_2(arg_19_0.uiEmptyGo, #var_1 <= 0)

	return
end

function var_0_1.RefreshInputField(arg_20_0)
	arg_20_0.uiInputField.text = ""

	return
end

function var_0_1.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:didEnter(arg_21_0.sortList[arg_21_1])

	return
end

function var_0_1.ShowFilterPanel(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.filterPanelView

	var_2.Show(var_22_0, arg_22_1)

	return
end

function var_0_1.OnRefreshSortBtn(arg_23_0)
	local var_23_0 = arg_23_0.filterPanelView

	var_1.RefreshUI(var_23_0)
	arg_23_0:RefreshUI()

	return
end

function var_0_1.RefreshSortText(arg_24_0)
	setText = var_1_10001

	local var_24_0 = arg_24_0.uiSortText

	PlayRoomConst = var_1_10003

	var_1_10001(var_24_0, var_1_10003.SORT_TEXT[arg_24_0.contextData.selectedRoomSortType])

	return
end

function var_0_1.RefreshSortAscend(arg_25_0)
	return
end

function var_0_1.OnCreateRoomOver(arg_26_0)
	setActive = var_1_10001

	var_1_10001(arg_26_0.uiCreatePanel, false)
	arg_26_0:RefreshUI()

	return
end

function var_0_1.OnQuickRoomFail(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.MsgboxMgr.GetInstance()
	local var_27_1 = var_1.ShowMsgBox
	local var_27_2 = {}

	i18n = var_1_10004
	var_27_2.content = var_1_10004("island_bar_quick_tip")

	function var_27_2.onYes()
		triggerButton = var_2_10000

		var_2_10000(arg_27_0.uiCreateRoomBtn)

		return
	end

	var_27_1(var_27_0, var_27_2)

	return
end

return var_0_1
