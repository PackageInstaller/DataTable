local var_0_0 = class("PlayRoomMainScene", import("view.base.BaseUI"))

var_0_0.ON_CLICK_ITEM_BTN = "PlayRoomMainScene:ON_CLICK_ITEM_BTN"

function var_0_0.getUIName(arg_1_0)
	return "IslandPlayRoomMainUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0._tf:Find("bg"),
			arg_2_0.uiCreatePanel
		}
	})
	setText(arg_2_0.uiTitleText, i18n("play_room_season"))
	setText(arg_2_0.uiTitleEnText, i18n("play_room_season_en"))
	setText(arg_2_0.uiCreateRoomText, i18n("match_ui_room_create"))
	setText(arg_2_0.uiSearchText, i18n("match_ui_room_search"))

	arg_2_0.uiLScrollView = LuaList.New(arg_2_0, handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiScrollViewTf, PlayRoomMainItem)

	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiCreateRoomBtn, function()
		setActive(arg_2_0.uiCreatePanel, true)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiQuickRoomBtn, function()
		arg_2_0:emit(PlayRoomMainMediator.JOIN_ROOM, {
			id = 0
		})

		return
	end, SFX_PANEL)
	setText(arg_2_0.uiQuickRoomBtn:Find("Text"), i18n("island_bar_quick_game"))
	onButton(arg_2_0, arg_2_0.uiRefreshRoomBtn, function()
		arg_2_0:emit(PlayRoomMainMediator.REFRESH_ROOM_LIST)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiSearchBtn, function()
		if arg_2_0.uiInputField.text == "" then
			return
		end

		arg_2_0.searchList = PlayRoomTools.SearchRoomList(arg_2_0.uiInputField.text)

		arg_2_0:RefreshRoomList()

		return
	end, SFX_PANEL)
	onInputChanged(arg_2_0, arg_2_0.uiInputField, function()
		if arg_2_0.uiInputField.text == "" and arg_2_0.searchList then
			arg_2_0.searchList = nil

			arg_2_0:RefreshRoomList()
		end

		return
	end)
	onButton(arg_2_0, arg_2_0.uiSortBtn, function()
		arg_2_0.selectedAscend = not arg_2_0.selectedAscend

		arg_2_0:RefreshUI()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiFilterBtn, function()
		arg_2_0.filterPanelView:Show(true)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiCommonBtn, function()
		arg_2_0:emit(PlayRoomMainMediator.CREATE_ROOM, {
			type = PlayRoomConst.PLAY_ROOM_TYPE.COMMON,
			gameType = arg_2_0:GetGameType()
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiPersonBtn, function()
		arg_2_0:emit(PlayRoomMainMediator.CREATE_ROOM, {
			type = PlayRoomConst.PLAY_ROOM_TYPE.PERSON,
			gameType = arg_2_0:GetGameType()
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiCloseCreateBtn, function()
		setActive(arg_2_0.uiCreatePanel, false)

		return
	end)

	return
end

function var_0_0.didEnter(arg_14_0)
	arg_14_0:RefreshInputField()

	arg_14_0.contextData.selectedRoomSortType = PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM
	arg_14_0.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.ALL
	arg_14_0.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.ALL
	arg_14_0.selectedAscend = true
	arg_14_0.filterPanelView = PlayRoomMainFilterView.New(arg_14_0.uiFilterPanel, arg_14_0, arg_14_0.contextData)
	arg_14_0.eventList = {
		arg_14_0:bind(var_0_0.ON_CLICK_ITEM_BTN, handler(arg_14_0, arg_14_0.OnRefreshSortBtn))
	}

	arg_14_0:emit(PlayRoomMainMediator.REFRESH_ROOM_LIST)

	return
end

function var_0_0.willExit(arg_15_0)
	arg_15_0:UnOverlayPanel(arg_15_0._tf)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.eventList) do
		arg_15_0:disconnect(iter_15_1)
	end

	arg_15_0.filterPanelView:willExit()

	arg_15_0.filterPanelView = nil

	arg_15_0.uiLScrollView:Dispose()

	arg_15_0.uiLScrollView = nil

	return
end

function var_0_0.GetGameType(arg_16_0)
	return arg_16_0.contextData.gameType
end

function var_0_0.FilterRoomList(arg_17_0, arg_17_1)
	arg_17_1 = PlayRoomTools.FilterRoomType(arg_17_1, arg_17_0.contextData.selectedRoomType)
	arg_17_1 = PlayRoomTools.FilterRoomState(arg_17_1, arg_17_0.contextData.selectedRoomState)
	arg_17_1 = PlayRoomTools.SortRoomList(arg_17_1, arg_17_0.contextData.selectedRoomSortType, arg_17_0.selectedAscend)

	return arg_17_1
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0:RefreshSortText()
	arg_18_0:RefreshSortAscend()
	arg_18_0:RefreshRoomList()

	local var_18_0 = arg_18_0.uiSortArrTf

	var_18_0.localScale = arg_18_0.selectedAscend and Vector2(1, -1, 1) or Vector2(1, 1, 1)

	return
end

function var_0_0.RefreshRoomList(arg_19_0)
	local var_19_0 = arg_19_0.searchList and arg_19_0.searchList or getProxy(PlayRoomProxy):GetPlayRoomList()
	local var_19_1 = arg_19_0:FilterRoomList(var_19_0)

	arg_19_0.sortList = var_19_1

	arg_19_0.uiLScrollView:StartScroll(#var_19_1)
	setActive(arg_19_0.uiEmptyGo, #var_19_1 <= 0)

	return
end

function var_0_0.RefreshInputField(arg_20_0)
	arg_20_0.uiInputField.text = ""

	return
end

function var_0_0.IndexItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:didEnter(arg_21_0.sortList[arg_21_1])

	return
end

function var_0_0.ShowFilterPanel(arg_22_0, arg_22_1)
	arg_22_0.filterPanelView:Show(arg_22_1)

	return
end

function var_0_0.OnRefreshSortBtn(arg_23_0)
	arg_23_0.filterPanelView:RefreshUI()
	arg_23_0:RefreshUI()

	return
end

function var_0_0.RefreshSortText(arg_24_0)
	setText(arg_24_0.uiSortText, PlayRoomConst.SORT_TEXT[arg_24_0.contextData.selectedRoomSortType])

	return
end

function var_0_0.RefreshSortAscend(arg_25_0)
	return
end

function var_0_0.OnCreateRoomOver(arg_26_0)
	setActive(arg_26_0.uiCreatePanel, false)
	arg_26_0:RefreshUI()

	return
end

function var_0_0.OnQuickRoomFail(arg_27_0)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("island_bar_quick_tip"),
		onYes = function()
			triggerButton(arg_27_0.uiCreateRoomBtn)

			return
		end
	})

	return
end

return var_0_0
