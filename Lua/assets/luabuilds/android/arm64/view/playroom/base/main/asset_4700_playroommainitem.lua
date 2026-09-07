local PlayRoomMainItem = class("PlayRoomMainItem", import("view.base.BasePanel"))

function PlayRoomMainItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2

	bindComponent(self, self._go)
	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomMainItem:Init()
	setText(self.uiPersonText, i18n("match_ui_room_type4"))
	setText(self.uiFullText, i18n("match_ui_room_type3"))
	setText(self.uiPlayingText, i18n("match_ui_room_type1"))
	setText(self.uiJoinText, i18n("match_ui_room_type2"))

	return
end

function PlayRoomMainItem:didEnter(arg_3_1)
	setText(self.uiNameText, i18n("match_ui_room_name", arg_3_1.name))
	setActive(self.uiViewerCntText, not PlayRoomConst.HIDE_VIEWER)
	setText(self.uiViewerCntText, i18n("play_room_viewer_tip", arg_3_1.viewerCnt, PlayRoomTools.GetMaxViewerCnt(arg_3_1.gameType)))
	setText(self.uiPlayerCntText, string.format("%s/%s", arg_3_1.teamCnt, PlayRoomTools.GetMaxTeamCnt(arg_3_1.gameType)))

	if arg_3_1.roomState == PlayRoomConst.PLAY_ROOM_STATE.WAIT then
		setActive(self.uiJoinBtn, true)
		setActive(self.uiPersonPanel, false)
		setActive(self.uiFullPanel, false)
		setActive(self.uiPlayingPanel, false)
		onButton(self, self.uiJoinBtn, function()
			self:emit(PlayRoomMainMediator.JOIN_ROOM, {
				id = arg_3_1.id,
				gameType = self.contextData.gameType
			})

			return
		end, SFX_PANEL)
	end

	if arg_3_1.roomType == PlayRoomConst.PLAY_ROOM_TYPE.PERSON then
		setActive(self.uiJoinBtn, false)
		setActive(self.uiPersonPanel, true)
		setActive(self.uiFullPanel, false)
		setActive(self.uiPlayingPanel, false)
	elseif arg_3_1.roomState == PlayRoomConst.PLAY_ROOM_STATE.FULL then
		setActive(self.uiJoinBtn, false)
		setActive(self.uiPersonPanel, false)
		setActive(self.uiFullPanel, true)
		setActive(self.uiPlayingPanel, false)
	elseif arg_3_1.roomState == PlayRoomConst.PLAY_ROOM_STATE.PLAYING then
		setActive(self.uiJoinBtn, false)
		setActive(self.uiPersonPanel, false)
		setActive(self.uiFullPanel, false)
		setActive(self.uiPlayingPanel, true)
	end

	return
end

function PlayRoomMainItem:willExit()
	self:detach()

	return
end

return PlayRoomMainItem
