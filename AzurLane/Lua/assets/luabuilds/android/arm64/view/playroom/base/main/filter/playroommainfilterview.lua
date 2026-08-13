class = var_0_10000

local var_0_0 = "PlayRoomMainFilterView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)

	arg_1_0.contextData = arg_1_3

	arg_1_0:InitData()
	arg_1_0:Init()

	return
end

function var_0_1.InitData(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	PlayRoomConst = var_1_10003
	var_2_1.type = var_1_10003.ROOM_FILTER_TYPE.SORT
	i18n = var_3
	var_2_1.titleText = var_3("match_ui_room_filtertitle1")

	local var_2_2 = {}
	local var_2_3 = {}

	PlayRoomConst = var_5

	local var_2_4 = var_5.SORT_TEXT

	PlayRoomConst = var_1_10006
	var_2_3.text = var_2_4[var_1_10006.ROOM_SORT_TYPE.ROOM_PLAYER_SUM]

	function var_2_3.clickBtn()
		local var_3_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_3_0.selectedRoomSortType = var_2_10001.ROOM_SORT_TYPE.ROOM_PLAYER_SUM

		local var_3_1 = arg_2_0
		local var_3_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_3_2(var_3_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_3.selected()
		local var_4_0 = arg_2_0.contextData.selectedRoomSortType

		PlayRoomConst = var_2_10001

		return var_4_0 == var_2_10001.ROOM_SORT_TYPE.ROOM_PLAYER_SUM
	end

	var_2_2[1] = var_2_3

	local var_2_5 = {}

	PlayRoomConst = var_5

	local var_2_6 = var_5.SORT_TEXT

	PlayRoomConst = var_6
	var_2_5.text = var_2_6[var_6.ROOM_SORT_TYPE.ROOM_CREATE_TIME]

	function var_2_5.clickBtn()
		local var_5_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_5_0.selectedRoomSortType = var_2_10001.ROOM_SORT_TYPE.ROOM_CREATE_TIME

		local var_5_1 = arg_2_0
		local var_5_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_5_2(var_5_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_5.selected()
		local var_6_0 = arg_2_0.contextData.selectedRoomSortType

		PlayRoomConst = var_2_10001

		return var_6_0 == var_2_10001.ROOM_SORT_TYPE.ROOM_CREATE_TIME
	end

	var_2_2[2] = var_2_5
	var_2_1.btnList = var_2_2
	var_2_0[1] = var_2_1

	local var_2_7 = {}

	PlayRoomConst = var_2_2
	var_2_7.type = var_2_2.ROOM_FILTER_TYPE.ROOM
	i18n = var_3
	var_2_7.titleText = var_3("match_ui_room_filtertitle2")

	local var_2_8 = {}
	local var_2_9 = {}

	i18n = var_5
	var_2_9.text = var_5("match_ui_room_filter4")

	function var_2_9.clickBtn()
		local var_7_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_7_0.selectedRoomType = var_2_10001.PLAY_ROOM_TYPE.ALL

		local var_7_1 = arg_2_0
		local var_7_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_7_2(var_7_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_9.selected()
		local var_8_0 = arg_2_0.contextData.selectedRoomType

		PlayRoomConst = var_2_10001

		return var_8_0 == var_2_10001.PLAY_ROOM_TYPE.ALL
	end

	var_2_8[1] = var_2_9

	local var_2_10 = {}

	i18n = var_5
	var_2_10.text = var_5("match_ui_room_filter5")

	function var_2_10.clickBtn()
		local var_9_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_9_0.selectedRoomType = var_2_10001.PLAY_ROOM_TYPE.COMMON

		local var_9_1 = arg_2_0
		local var_9_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_9_2(var_9_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_10.selected()
		local var_10_0 = arg_2_0.contextData.selectedRoomType

		PlayRoomConst = var_2_10001

		return var_10_0 == var_2_10001.PLAY_ROOM_TYPE.COMMON
	end

	var_2_8[2] = var_2_10

	local var_2_11 = {}

	i18n = var_5
	var_2_11.text = var_5("match_ui_room_filter6")

	function var_2_11.clickBtn()
		local var_11_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_11_0.selectedRoomType = var_2_10001.PLAY_ROOM_TYPE.PERSON

		local var_11_1 = arg_2_0
		local var_11_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_11_2(var_11_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_11.selected()
		local var_12_0 = arg_2_0.contextData.selectedRoomType

		PlayRoomConst = var_2_10001

		return var_12_0 == var_2_10001.PLAY_ROOM_TYPE.PERSON
	end

	var_2_8[3] = var_2_11
	var_2_7.btnList = var_2_8
	var_2_0[2] = var_2_7

	local var_2_12 = {}

	PlayRoomConst = var_2_8
	var_2_12.type = var_2_8.ROOM_FILTER_TYPE.STATE
	i18n = var_3
	var_2_12.titleText = var_3("match_ui_room_filtertitle3")

	local var_2_13 = {}
	local var_2_14 = {}

	i18n = var_5
	var_2_14.text = var_5("match_ui_room_filter7")

	function var_2_14.clickBtn()
		local var_13_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_13_0.selectedRoomState = var_2_10001.PLAY_ROOM_STATE.ALL

		local var_13_1 = arg_2_0
		local var_13_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_13_2(var_13_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_14.selected()
		local var_14_0 = arg_2_0.contextData.selectedRoomState

		PlayRoomConst = var_2_10001

		return var_14_0 == var_2_10001.PLAY_ROOM_STATE.ALL
	end

	var_2_13[1] = var_2_14

	local var_2_15 = {}

	i18n = var_5
	var_2_15.text = var_5("match_ui_room_filter8")

	function var_2_15.clickBtn()
		local var_15_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_15_0.selectedRoomState = var_2_10001.PLAY_ROOM_STATE.WAIT

		local var_15_1 = arg_2_0
		local var_15_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_15_2(var_15_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_15.selected()
		local var_16_0 = arg_2_0.contextData.selectedRoomState

		PlayRoomConst = var_2_10001

		return var_16_0 == var_2_10001.PLAY_ROOM_STATE.WAIT
	end

	var_2_13[2] = var_2_15

	local var_2_16 = {}

	i18n = var_5
	var_2_16.text = var_5("match_ui_room_filter9")

	function var_2_16.clickBtn()
		local var_17_0 = arg_2_0.contextData

		PlayRoomConst = var_2_10001
		var_17_0.selectedRoomState = var_2_10001.PLAY_ROOM_STATE.PLAYING

		local var_17_1 = arg_2_0
		local var_17_2 = var_0.emit

		PlayRoomMainScene = var_2_10003

		var_17_2(var_17_1, var_2_10003.ON_CLICK_ITEM_BTN)

		return
	end

	function var_2_16.selected()
		local var_18_0 = arg_2_0.contextData.selectedRoomState

		PlayRoomConst = var_2_10001

		return var_18_0 == var_2_10001.PLAY_ROOM_STATE.PLAYING
	end

	var_2_13[3] = var_2_16
	var_2_12.btnList = var_2_13
	var_2_0[3] = var_2_12
	arg_2_0.filterData = var_2_0

	return
end

function var_0_1.Init(arg_19_0)
	arg_19_0.panelList = {}
	pairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0.filterData) do
		local var_19_0 = arg_19_0.panelList

		PlayRoomMainFilterPanel = var_1_10007
		var_1_10007 = var_1_10007.New
		Object = var_1_10009
		var_19_0[iter_19_0] = var_1_10007(var_1_10009.Instantiate(arg_19_0.uiSortPanel, arg_19_0.uiMainPanel), arg_19_0)

		local var_19_1 = arg_19_0.panelList[iter_19_0]

		var_6.didEnter(var_19_1, iter_19_1, arg_19_0.contextData)
	end

	onButton = var_1

	var_1(arg_19_0, arg_19_0.uiCloseBtn, function()
		local var_20_0 = arg_19_0

		var_0.Show(var_20_0, false)

		return
	end)

	setActive = var_1

	var_1(arg_19_0._go, false)

	return
end

function var_0_1.willExit(arg_21_0)
	ipairs = var_1_10001

	for iter_21_0, iter_21_1 in var_1_10001(arg_21_0.panelList) do
		iter_21_1:willExit()
	end

	arg_21_0.panelList = nil

	arg_21_0:detach()

	return
end

function var_0_1.Show(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0:RefreshUI()
	end

	setActive = var_1_10002

	var_1_10002(arg_22_0._go, arg_22_1)

	return
end

function var_0_1.RefreshUI(arg_23_0)
	ipairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0.panelList) do
		iter_23_1:RefreshUI()
	end

	return
end

return var_0_1
