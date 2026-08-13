class = var_0_10000

local var_0_0 = "PlayRoomInfoViewerScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "IslandPlayRoomInfoViewerUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.OverlayPanel
	local var_2_2 = arg_2_0._tf
	local var_2_3 = {}
	local var_2_4 = {}
	local var_2_5 = arg_2_0._tf

	var_2_4[1] = var_7.Find(var_2_5, "bg")
	var_2_3.pbList = var_2_4

	var_2_1(var_2_0, var_2_2, var_2_3)

	onButton = var_2_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiCloseBtn

	local function var_2_8()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_PANEL = var_2_4

	var_2_1(var_2_6, var_2_7, var_2_8, var_2_4)

	onButton = var_2_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.uiSwitchBtn

	local function var_2_11()
		PlayRoomTools = var_2_10000

		if var_2_10000.GetUnfullTeamIndex() == nil then
			return
		end

		local var_4_0 = arg_2_0
		local var_4_1 = var_1.emit

		PlayRoomInfoViewerMediator = var_2_10004

		var_4_1(var_4_0, var_2_10004.ON_CLICK_SWITCH, {
			teamIndex = var_0
		})

		return
	end

	SFX_PANEL = var_2_4

	var_2_1(var_2_9, var_2_10, var_2_11, var_2_4)

	LuaList = var_2_1

	local var_2_12 = var_2_1.New
	local var_2_13 = arg_2_0

	handler = var_2_10

	local var_2_14 = var_2_10(arg_2_0, arg_2_0.IndexItem)
	local var_2_15 = arg_2_0.uiList

	PlayRoomInfoViewerItem = var_6
	arg_2_0.uiScrollView = var_2_12(var_2_13, var_2_14, var_2_15, var_6)

	return
end

function var_0_1.didEnter(arg_5_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10003
	arg_5_0.playRoomProxy = var_1_10001(var_1_10003)

	local var_5_0 = arg_5_0.playRoomProxy

	arg_5_0.roomData = var_1.GetRoomData(var_5_0)

	arg_5_0:RefreshUI()

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:UnOverlayPanel(arg_6_0._tf)

	local var_6_0 = arg_6_0.uiScrollView

	var_1.Dispose(var_6_0)

	arg_6_0.uiScrollView = nil

	return
end

function var_0_1.RefreshUI(arg_7_0)
	arg_7_0:RefreshBtn()
	arg_7_0:RefreshPlayerList()

	return
end

function var_0_1.RefreshPlayerList(arg_8_0)
	Clone = var_1_10001
	arg_8_0.viewerList = var_1_10001(arg_8_0.roomData.viewerList)
	getProxy = var_1
	PlayerProxy = var_3

	local var_8_0 = var_1(var_3)
	local var_8_1 = var_1.getPlayerId(var_8_0)

	table = var_1_10002

	var_1_10002.sort(arg_8_0.viewerList, function(arg_9_0, arg_9_1)
		return arg_9_0 == var_8_1
	end)

	local var_8_2 = arg_8_0.uiScrollView

	var_2.StartScroll(var_8_2, #arg_8_0.viewerList)

	return
end

function var_0_1.RefreshBtn(arg_10_0)
	PlayRoomTools = var_1_10001

	if var_1_10001.IsViewer() then
		setText = var_1

		local var_10_0 = arg_10_0.uiBtnText

		i18n = var_1_10004

		var_1(var_10_0, var_1_10004("play_room_switch_viewer"))

		setButtonEnabled = var_1

		local var_10_1 = arg_10_0.uiSwitchBtn

		PlayRoomTools = var_1_10004

		var_1(var_10_1, not var_1_10004.IsPlayerFull())
	else
		setText = var_1

		local var_10_2 = arg_10_0.uiBtnText

		i18n = var_1_10004

		var_1(var_10_2, var_1_10004("play_room_switch_player"))

		setButtonEnabled = var_1

		local var_10_3 = arg_10_0.uiSwitchBtn

		PlayRoomTools = var_4

		var_1(var_10_3, not var_4.IsViewerFull())
	end

	return
end

function var_0_1.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	PlayRoomTools = var_1_10003

	local var_11_0 = var_1_10003.GetHostID()

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_11_1 = var_1_10004(var_1_10006)
	local var_11_2 = var_11_0 == var_4.getPlayerId(var_11_1)
	local var_11_3 = arg_11_0.viewerList[arg_11_1]

	arg_11_2:didEnter(arg_11_0.roomData.playerDataList[var_11_3], var_11_2)

	return
end

return var_0_1
