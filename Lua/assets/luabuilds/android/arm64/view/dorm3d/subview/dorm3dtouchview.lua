local var_0_0 = class("Dorm3dTouchView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0.rtIKUI = arg_1_0._tf:Find("UI/ik")
	arg_1_0.rtTouchGamePanel = arg_1_0._tf:Find("ExtraScreen/TouchGame")

	setActive(arg_1_0.rtIKUI:Find("btn_back_heartbeat"), false)
	setActive(arg_1_0.rtTouchGamePanel, false)
	onButton(arg_1_0, arg_1_0.rtIKUI:Find("btn_back"), function()
		arg_1_0:emit(RoomIKSystem.CONSUME_IK_SPECIAL_CALL, {})

		if not ({}).consumed then
			arg_1_0:emit(RoomTouchSystem.EXIT_TOUCH_MODE)
		end

		return
	end, SFX_DORM_BACK)
	onButton(arg_1_0, arg_1_0.rtIKUI:Find("btn_back_heartbeat"), function()
		arg_1_0:emit(RoomTouchSystem.EXIT_HEARTBEAT_MODE)

		return
	end, SFX_DORM_BACK)
	arg_1_0:bind(RoomTouchSystem.UPDATE_TOUCH_PANEL, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_1_0:UpdateTouchPanel(arg_4_1, arg_4_2, arg_4_3)

		return
	end)
	arg_1_0:bind(RoomTouchSystem.UPDATE_TOUCH_COUNT, function(arg_5_0, arg_5_1)
		arg_1_0:UpdateTouchCount(arg_5_1)

		return
	end)
	arg_1_0:bind(RoomTouchSystem.UPDATE_TOUCH_LEVEL, function(arg_6_0, arg_6_1)
		arg_1_0:UpdateTouchLevel(arg_6_1)

		return
	end)
	arg_1_0:bind(RoomTouchSystem.UPDATE_TOUCH_DISPLAY, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:UpdateTouchLevel(arg_7_1)
		arg_1_0:UpdateTouchCount(arg_7_2)

		return
	end)

	return
end

function var_0_0.UpdateTouchPanel(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 then
		setActive(arg_8_0.rtTouchGamePanel, true)
		quickPlayAnimation(arg_8_0.rtTouchGamePanel, "anim_dorm3d_touch_in")
		quickPlayAnimation(arg_8_0.rtTouchGamePanel:Find("slider/icon"), "anim_dorm3d_touch_icon")
		existCall(arg_8_3)
	elseif arg_8_2 then
		quickPlayAnimation(arg_8_0.rtTouchGamePanel, "anim_dorm3d_touch_out")
		onDelayTick(function()
			setActive(arg_8_0.rtTouchGamePanel, false)
			existCall(arg_8_3)

			return
		end, 0.5)
	else
		setActive(arg_8_0.rtTouchGamePanel, false)
		existCall(arg_8_3)
	end

	return
end

function var_0_0.UpdateTouchLevel(arg_10_0, arg_10_1)
	arg_10_0.touchLevel = arg_10_1

	setActive(arg_10_0.rtTouchGamePanel:Find("effect_bg"), arg_10_1 == 2)
	setActive(arg_10_0.rtTouchGamePanel:Find("slider/icon/beating"), arg_10_1 == 2)

	if arg_10_1 == 1 then
		setActive(arg_10_0.rtIKUI:Find("btn_back"), true)
		setActive(arg_10_0.rtIKUI:Find("btn_back_heartbeat"), false)
		quickPlayAnimation(arg_10_0.rtTouchGamePanel, "anim_dorm3d_touch_change_out")
		quickPlayAnimation(arg_10_0.rtTouchGamePanel:Find("slider/icon"), "anim_dorm3d_touch_icon")
	elseif arg_10_1 == 2 then
		setActive(arg_10_0.rtIKUI:Find("btn_back"), false)
		setActive(arg_10_0.rtIKUI:Find("btn_back_heartbeat"), true)
		quickPlayAnimation(arg_10_0.rtTouchGamePanel, "anim_dorm3d_touch_change")
		quickPlayAnimation(arg_10_0.rtTouchGamePanel:Find("slider/icon"), "anim_dorm3d_touch_icon_1")
		pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_heartbeat")
	end

	return
end

function var_0_0.UpdateTouchCount(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1

	if arg_11_0.touchLevel and arg_11_0.touchLevel > 1 then
		var_11_0 = arg_11_1 >= 200 and 100 or arg_11_1 % 100
	end

	setSlider(arg_11_0.rtTouchGamePanel:Find("slider"), 0, 100, var_11_0)

	return
end

return var_0_0
