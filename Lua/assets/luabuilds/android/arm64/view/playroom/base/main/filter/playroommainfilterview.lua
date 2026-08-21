local var_0_0 = class("PlayRoomMainFilterView", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)

	arg_1_0.contextData = arg_1_3

	arg_1_0:InitData()
	arg_1_0:Init()

	return
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.filterData = {
		{
			type = PlayRoomConst.ROOM_FILTER_TYPE.SORT,
			titleText = i18n("match_ui_room_filtertitle1"),
			btnList = {
				{
					text = PlayRoomConst.SORT_TEXT[PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM],
					clickBtn = function()
						arg_2_0.contextData.selectedRoomSortType = PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomSortType == PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM
					end
				},
				{
					text = PlayRoomConst.SORT_TEXT[PlayRoomConst.ROOM_SORT_TYPE.ROOM_CREATE_TIME],
					clickBtn = function()
						arg_2_0.contextData.selectedRoomSortType = PlayRoomConst.ROOM_SORT_TYPE.ROOM_CREATE_TIME

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomSortType == PlayRoomConst.ROOM_SORT_TYPE.ROOM_CREATE_TIME
					end
				}
			}
		},
		{
			type = PlayRoomConst.ROOM_FILTER_TYPE.ROOM,
			titleText = i18n("match_ui_room_filtertitle2"),
			btnList = {
				{
					text = i18n("match_ui_room_filter4"),
					clickBtn = function()
						arg_2_0.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.ALL

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomType == PlayRoomConst.PLAY_ROOM_TYPE.ALL
					end
				},
				{
					text = i18n("match_ui_room_filter5"),
					clickBtn = function()
						arg_2_0.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.COMMON

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomType == PlayRoomConst.PLAY_ROOM_TYPE.COMMON
					end
				},
				{
					text = i18n("match_ui_room_filter6"),
					clickBtn = function()
						arg_2_0.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.PERSON

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomType == PlayRoomConst.PLAY_ROOM_TYPE.PERSON
					end
				}
			}
		},
		{
			type = PlayRoomConst.ROOM_FILTER_TYPE.STATE,
			titleText = i18n("match_ui_room_filtertitle3"),
			btnList = {
				{
					text = i18n("match_ui_room_filter7"),
					clickBtn = function()
						arg_2_0.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.ALL

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomState == PlayRoomConst.PLAY_ROOM_STATE.ALL
					end
				},
				{
					text = i18n("match_ui_room_filter8"),
					clickBtn = function()
						arg_2_0.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.WAIT

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomState == PlayRoomConst.PLAY_ROOM_STATE.WAIT
					end
				},
				{
					text = i18n("match_ui_room_filter9"),
					clickBtn = function()
						arg_2_0.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.PLAYING

						arg_2_0:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return arg_2_0.contextData.selectedRoomState == PlayRoomConst.PLAY_ROOM_STATE.PLAYING
					end
				}
			}
		}
	}

	return
end

function var_0_0.Init(arg_19_0)
	arg_19_0.panelList = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0.filterData) do
		arg_19_0.panelList[iter_19_0] = PlayRoomMainFilterPanel.New(Object.Instantiate(arg_19_0.uiSortPanel, arg_19_0.uiMainPanel), arg_19_0)

		arg_19_0.panelList[iter_19_0]:didEnter(iter_19_1, arg_19_0.contextData)
	end

	onButton(arg_19_0, arg_19_0.uiCloseBtn, function()
		arg_19_0:Show(false)

		return
	end)
	setActive(arg_19_0._go, false)

	return
end

function var_0_0.willExit(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.panelList) do
		iter_21_1:willExit()
	end

	arg_21_0.panelList = nil

	arg_21_0:detach()

	return
end

function var_0_0.Show(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0:RefreshUI()
	end

	setActive(arg_22_0._go, arg_22_1)

	return
end

function var_0_0.RefreshUI(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.panelList) do
		iter_23_1:RefreshUI()
	end

	return
end

return var_0_0
