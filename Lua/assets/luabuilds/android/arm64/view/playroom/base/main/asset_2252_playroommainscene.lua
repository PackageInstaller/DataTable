local PlayRoomMainScene = class("PlayRoomMainScene", import("view.base.BaseUI"))

PlayRoomMainScene.ON_CLICK_ITEM_BTN = "PlayRoomMainScene:ON_CLICK_ITEM_BTN"

function PlayRoomMainScene:getUIName()
	return "IslandPlayRoomMainUI"
end

function PlayRoomMainScene:init()
	self:OverlayPanel(self._tf, {
		pbList = {
			self._tf:Find("bg"),
			self.uiCreatePanel
		}
	})
	setText(self.uiTitleText, i18n("play_room_season"))
	setText(self.uiTitleEnText, i18n("play_room_season_en"))
	setText(self.uiCreateRoomText, i18n("match_ui_room_create"))
	setText(self.uiSearchText, i18n("match_ui_room_search"))

	self.uiLScrollView = LuaList.New(self, handler(self, self.IndexItem), self.uiScrollViewTf, PlayRoomMainItem)

	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.uiCreateRoomBtn, function()
		setActive(self.uiCreatePanel, true)

		return
	end, SFX_PANEL)
	onButton(self, self.uiQuickRoomBtn, function()
		self:emit(PlayRoomMainMediator.JOIN_ROOM, {
			id = 0
		})

		return
	end, SFX_PANEL)
	setText(self.uiQuickRoomBtn:Find("Text"), i18n("island_bar_quick_game"))
	onButton(self, self.uiRefreshRoomBtn, function()
		self:emit(PlayRoomMainMediator.REFRESH_ROOM_LIST)

		return
	end, SFX_PANEL)
	onButton(self, self.uiSearchBtn, function()
		if self.uiInputField.text == "" then
			return
		end

		self.searchList = PlayRoomTools.SearchRoomList(self.uiInputField.text)

		self:RefreshRoomList()

		return
	end, SFX_PANEL)
	onInputChanged(self, self.uiInputField, function()
		if self.uiInputField.text == "" and self.searchList then
			self.searchList = nil

			self:RefreshRoomList()
		end

		return
	end)
	onButton(self, self.uiSortBtn, function()
		self.selectedAscend = not self.selectedAscend

		self:RefreshUI()

		return
	end, SFX_PANEL)
	onButton(self, self.uiFilterBtn, function()
		self.filterPanelView:Show(true)

		return
	end, SFX_PANEL)
	onButton(self, self.uiCommonBtn, function()
		self:emit(PlayRoomMainMediator.CREATE_ROOM, {
			type = PlayRoomConst.PLAY_ROOM_TYPE.COMMON,
			gameType = self:GetGameType()
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiPersonBtn, function()
		self:emit(PlayRoomMainMediator.CREATE_ROOM, {
			type = PlayRoomConst.PLAY_ROOM_TYPE.PERSON,
			gameType = self:GetGameType()
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiCloseCreateBtn, function()
		setActive(self.uiCreatePanel, false)

		return
	end)

	return
end

function PlayRoomMainScene:didEnter()
	self:RefreshInputField()

	self.contextData.selectedRoomSortType = PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM
	self.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.ALL
	self.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.ALL
	self.selectedAscend = true
	self.filterPanelView = PlayRoomMainFilterView.New(self.uiFilterPanel, self, self.contextData)
	self.eventList = {
		self:bind(PlayRoomMainScene.ON_CLICK_ITEM_BTN, handler(self, self.OnRefreshSortBtn))
	}

	self:emit(PlayRoomMainMediator.REFRESH_ROOM_LIST)

	return
end

function PlayRoomMainScene:willExit()
	self:UnOverlayPanel(self._tf)

	for iter_15_0, iter_15_1 in ipairs(self.eventList) do
		self:disconnect(iter_15_1)
	end

	self.filterPanelView:willExit()

	self.filterPanelView = nil

	self.uiLScrollView:Dispose()

	self.uiLScrollView = nil

	return
end

function PlayRoomMainScene:GetGameType()
	return self.contextData.gameType
end

function PlayRoomMainScene:FilterRoomList(arg_17_1)
	arg_17_1 = PlayRoomTools.FilterRoomType(arg_17_1, self.contextData.selectedRoomType)
	arg_17_1 = PlayRoomTools.FilterRoomState(arg_17_1, self.contextData.selectedRoomState)
	arg_17_1 = PlayRoomTools.SortRoomList(arg_17_1, self.contextData.selectedRoomSortType, self.selectedAscend)

	return arg_17_1
end

function PlayRoomMainScene:RefreshUI()
	self:RefreshSortText()
	self:RefreshSortAscend()
	self:RefreshRoomList()

	self.uiSortArrTf.localScale = self.selectedAscend and Vector2(1, -1, 1) or Vector2(1, 1, 1)

	return
end

function PlayRoomMainScene:RefreshRoomList()
	local var_19_0 = self:FilterRoomList(self.searchList and self.searchList or getProxy(PlayRoomProxy):GetPlayRoomList())

	self.sortList = var_19_0

	self.uiLScrollView:StartScroll(#var_19_0)
	setActive(self.uiEmptyGo, #var_19_0 <= 0)

	return
end

function PlayRoomMainScene:RefreshInputField()
	self.uiInputField.text = ""

	return
end

function PlayRoomMainScene:IndexItem(arg_21_1, arg_21_2)
	arg_21_2:didEnter(self.sortList[arg_21_1])

	return
end

function PlayRoomMainScene:ShowFilterPanel(arg_22_1)
	self.filterPanelView:Show(arg_22_1)

	return
end

function PlayRoomMainScene:OnRefreshSortBtn()
	self.filterPanelView:RefreshUI()
	self:RefreshUI()

	return
end

function PlayRoomMainScene:RefreshSortText()
	setText(self.uiSortText, PlayRoomConst.SORT_TEXT[self.contextData.selectedRoomSortType])

	return
end

function PlayRoomMainScene:RefreshSortAscend()
	return
end

function PlayRoomMainScene:OnCreateRoomOver()
	setActive(self.uiCreatePanel, false)
	self:RefreshUI()

	return
end

function PlayRoomMainScene:OnQuickRoomFail()
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("island_bar_quick_tip"),
		onYes = function()
			triggerButton(self.uiCreateRoomBtn)

			return
		end
	})

	return
end

return PlayRoomMainScene
