local var_0_0 = class("PlayRoomMainItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	bindComponent(arg_1_0, arg_1_0._go)
	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setText(arg_2_0.uiPersonText, i18n("match_ui_room_type4"))
	setText(arg_2_0.uiFullText, i18n("match_ui_room_type3"))
	setText(arg_2_0.uiPlayingText, i18n("match_ui_room_type1"))
	setText(arg_2_0.uiJoinText, i18n("match_ui_room_type2"))

	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1)
	setText(arg_3_0.uiNameText, i18n("match_ui_room_name", arg_3_1.name))
	setActive(arg_3_0.uiViewerCntText, not PlayRoomConst.HIDE_VIEWER)
	setText(arg_3_0.uiViewerCntText, i18n("play_room_viewer_tip", arg_3_1.viewerCnt, PlayRoomTools.GetMaxViewerCnt(arg_3_1.gameType)))
	setText(arg_3_0.uiPlayerCntText, string.format("%s/%s", arg_3_1.teamCnt, PlayRoomTools.GetMaxTeamCnt(arg_3_1.gameType)))

	if arg_3_1.roomState == PlayRoomConst.PLAY_ROOM_STATE.WAIT then
		setActive(arg_3_0.uiJoinBtn, true)
		setActive(arg_3_0.uiPersonPanel, false)
		setActive(arg_3_0.uiFullPanel, false)
		setActive(arg_3_0.uiPlayingPanel, false)
		onButton(arg_3_0, arg_3_0.uiJoinBtn, function()
			arg_3_0:emit(PlayRoomMainMediator.JOIN_ROOM, {
				id = arg_3_1.id,
				gameType = arg_3_0.contextData.gameType
			})

			return
		end, SFX_PANEL)
	end

	if arg_3_1.roomType == PlayRoomConst.PLAY_ROOM_TYPE.PERSON then
		setActive(arg_3_0.uiJoinBtn, false)
		setActive(arg_3_0.uiPersonPanel, true)
		setActive(arg_3_0.uiFullPanel, false)
		setActive(arg_3_0.uiPlayingPanel, false)
	elseif arg_3_1.roomState == PlayRoomConst.PLAY_ROOM_STATE.FULL then
		setActive(arg_3_0.uiJoinBtn, false)
		setActive(arg_3_0.uiPersonPanel, false)
		setActive(arg_3_0.uiFullPanel, true)
		setActive(arg_3_0.uiPlayingPanel, false)
	elseif arg_3_1.roomState == PlayRoomConst.PLAY_ROOM_STATE.PLAYING then
		setActive(arg_3_0.uiJoinBtn, false)
		setActive(arg_3_0.uiPersonPanel, false)
		setActive(arg_3_0.uiFullPanel, false)
		setActive(arg_3_0.uiPlayingPanel, true)
	end

	return
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:detach()

	return
end

return var_0_0
