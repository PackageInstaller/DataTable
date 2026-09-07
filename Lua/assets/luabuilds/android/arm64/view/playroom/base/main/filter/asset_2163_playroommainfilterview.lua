local PlayRoomMainFilterView = class("PlayRoomMainFilterView", import("view.base.BasePanel"))

function PlayRoomMainFilterView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1.gameObject

	PlayRoomMainFilterView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)

	self.contextData = arg_1_3

	self:InitData()
	self:Init()

	return
end

function PlayRoomMainFilterView:InitData()
	self.filterData = {
		{
			type = PlayRoomConst.ROOM_FILTER_TYPE.SORT,
			titleText = i18n("match_ui_room_filtertitle1"),
			btnList = {
				{
					text = PlayRoomConst.SORT_TEXT[PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM],
					clickBtn = function()
						self.contextData.selectedRoomSortType = PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomSortType == PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM
					end
				},
				{
					text = PlayRoomConst.SORT_TEXT[PlayRoomConst.ROOM_SORT_TYPE.ROOM_CREATE_TIME],
					clickBtn = function()
						self.contextData.selectedRoomSortType = PlayRoomConst.ROOM_SORT_TYPE.ROOM_CREATE_TIME

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomSortType == PlayRoomConst.ROOM_SORT_TYPE.ROOM_CREATE_TIME
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
						self.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.ALL

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomType == PlayRoomConst.PLAY_ROOM_TYPE.ALL
					end
				},
				{
					text = i18n("match_ui_room_filter5"),
					clickBtn = function()
						self.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.COMMON

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomType == PlayRoomConst.PLAY_ROOM_TYPE.COMMON
					end
				},
				{
					text = i18n("match_ui_room_filter6"),
					clickBtn = function()
						self.contextData.selectedRoomType = PlayRoomConst.PLAY_ROOM_TYPE.PERSON

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomType == PlayRoomConst.PLAY_ROOM_TYPE.PERSON
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
						self.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.ALL

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomState == PlayRoomConst.PLAY_ROOM_STATE.ALL
					end
				},
				{
					text = i18n("match_ui_room_filter8"),
					clickBtn = function()
						self.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.WAIT

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomState == PlayRoomConst.PLAY_ROOM_STATE.WAIT
					end
				},
				{
					text = i18n("match_ui_room_filter9"),
					clickBtn = function()
						self.contextData.selectedRoomState = PlayRoomConst.PLAY_ROOM_STATE.PLAYING

						self:emit(PlayRoomMainScene.ON_CLICK_ITEM_BTN)

						return
					end,
					selected = function()
						return self.contextData.selectedRoomState == PlayRoomConst.PLAY_ROOM_STATE.PLAYING
					end
				}
			}
		}
	}

	return
end

function PlayRoomMainFilterView:Init()
	self.panelList = {}

	for iter_19_0, iter_19_1 in pairs(self.filterData) do
		self.panelList[iter_19_0] = PlayRoomMainFilterPanel.New(Object.Instantiate(self.uiSortPanel, self.uiMainPanel), self)

		self.panelList[iter_19_0]:didEnter(iter_19_1, self.contextData)
	end

	onButton(self, self.uiCloseBtn, function()
		self:Show(false)

		return
	end)
	setActive(self._go, false)

	return
end

function PlayRoomMainFilterView:willExit()
	for iter_21_0, iter_21_1 in ipairs(self.panelList) do
		iter_21_1:willExit()
	end

	self.panelList = nil

	self:detach()

	return
end

function PlayRoomMainFilterView:Show(arg_22_1)
	if arg_22_1 then
		self:RefreshUI()
	end

	setActive(self._go, arg_22_1)

	return
end

function PlayRoomMainFilterView:RefreshUI()
	for iter_23_0, iter_23_1 in ipairs(self.panelList) do
		iter_23_1:RefreshUI()
	end

	return
end

return PlayRoomMainFilterView
