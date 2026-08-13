class = var_0_10000

local var_0_0 = "PlayRoomMainItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2
	bindComponent = var_3

	var_3(arg_1_0, arg_1_0._go)
	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiPersonText

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("match_ui_room_type4"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiFullText

	i18n = var_4

	var_1_10001(var_2_1, var_4("match_ui_room_type3"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.uiPlayingText

	i18n = var_4

	var_1_10001(var_2_2, var_4("match_ui_room_type1"))

	setText = var_1_10001

	local var_2_3 = arg_2_0.uiJoinText

	i18n = var_4

	var_1_10001(var_2_3, var_4("match_ui_room_type2"))

	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1)
	setText = var_1_10002

	local var_3_0 = arg_3_0.uiNameText

	i18n = var_1_10005

	var_1_10002(var_3_0, var_1_10005("match_ui_room_name", arg_3_1.name))

	setActive = var_1_10002

	local var_3_1 = arg_3_0.uiViewerCntText

	PlayRoomConst = var_5

	var_1_10002(var_3_1, not var_5.HIDE_VIEWER)

	setText = var_1_10002

	local var_3_2 = arg_3_0.uiViewerCntText

	i18n = var_5

	local var_3_3 = "play_room_viewer_tip"
	local var_3_4 = arg_3_1.viewerCnt

	PlayRoomTools = var_1_10009

	var_1_10002(var_3_2, var_5(var_3_3, var_3_4, var_1_10009.GetMaxViewerCnt(arg_3_1.gameType)))

	setText = var_1_10002

	local var_3_5 = arg_3_0.uiPlayerCntText

	string = var_5

	local var_3_6 = var_5.format
	local var_3_7 = "%s/%s"
	local var_3_8 = arg_3_1.teamCnt

	PlayRoomTools = var_9

	var_1_10002(var_3_5, var_3_6(var_3_7, var_3_8, var_9.GetMaxTeamCnt(arg_3_1.gameType)))

	local var_3_9 = arg_3_1.roomState

	PlayRoomConst = var_1_10003

	if var_3_9 == var_1_10003.PLAY_ROOM_STATE.WAIT then
		setActive = var_3

		var_3(arg_3_0.uiJoinBtn, true)

		setActive = var_3

		var_3(arg_3_0.uiPersonPanel, false)

		setActive = var_3

		var_3(arg_3_0.uiFullPanel, false)

		setActive = var_3

		var_3(arg_3_0.uiPlayingPanel, false)

		onButton = var_3

		local var_3_10 = arg_3_0
		local var_3_11 = arg_3_0.uiJoinBtn

		local function var_3_12()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			PlayRoomMainMediator = var_2_10003

			var_4_1(var_4_0, var_2_10003.JOIN_ROOM, {
				id = arg_3_1.id,
				gameType = arg_3_0.contextData.gameType
			})

			return
		end

		SFX_PANEL = var_3_8

		var_3(var_3_10, var_3_11, var_3_12, var_3_8)
	end

	local var_3_13 = arg_3_1.roomType

	PlayRoomConst = var_3_5

	if var_3_13 == var_3_5.PLAY_ROOM_TYPE.PERSON then
		setActive = var_3_13

		var_3_13(arg_3_0.uiJoinBtn, false)

		setActive = var_3_13

		var_3_13(arg_3_0.uiPersonPanel, true)

		setActive = var_3_13

		var_3_13(arg_3_0.uiFullPanel, false)

		setActive = var_3_13

		var_3_13(arg_3_0.uiPlayingPanel, false)
	else
		PlayRoomConst = var_3_13

		if var_3_9 == var_3_13.PLAY_ROOM_STATE.FULL then
			setActive = var_3

			var_3(arg_3_0.uiJoinBtn, false)

			setActive = var_3

			var_3(arg_3_0.uiPersonPanel, false)

			setActive = var_3

			var_3(arg_3_0.uiFullPanel, true)

			setActive = var_3

			var_3(arg_3_0.uiPlayingPanel, false)
		else
			PlayRoomConst = var_3

			if var_3_9 == var_3.PLAY_ROOM_STATE.PLAYING then
				setActive = var_3

				var_3(arg_3_0.uiJoinBtn, false)

				setActive = var_3

				var_3(arg_3_0.uiPersonPanel, false)

				setActive = var_3

				var_3(arg_3_0.uiFullPanel, false)

				setActive = var_3

				var_3(arg_3_0.uiPlayingPanel, true)
			end
		end
	end

	return
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:detach()

	return
end

return var_0_1
