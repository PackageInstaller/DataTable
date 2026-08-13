class = var_0_10000

local var_0_0 = "Dorm3dTouchView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtIKUI = var_1.Find(var_1_0, "UI/ik")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtTouchGamePanel = var_1.Find(var_1_1, "ExtraScreen/TouchGame")
	setActive = var_1

	local var_1_2 = arg_1_0.rtIKUI

	var_1(var_2.Find(var_1_2, "btn_back_heartbeat"), false)

	setActive = var_1

	var_1(arg_1_0.rtTouchGamePanel, false)

	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.rtIKUI
	local var_1_5 = var_3.Find(var_1_4, "btn_back")

	local function var_1_6()
		local var_2_0 = {}
		local var_2_1 = arg_1_0
		local var_2_2 = var_1.emit

		RoomIKSystem = var_2_10003

		var_2_2(var_2_1, var_2_10003.CONSUME_IK_SPECIAL_CALL, var_2_0)

		if not var_2_0.consumed then
			local var_2_3 = arg_1_0
			local var_2_4 = var_1.emit

			RoomTouchSystem = var_3

			var_2_4(var_2_3, var_3.EXIT_TOUCH_MODE)
		end

		return
	end

	SFX_DORM_BACK = var_5

	var_1(var_1_3, var_1_5, var_1_6, var_5)

	onButton = var_1

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.rtIKUI
	local var_1_9 = var_3.Find(var_1_8, "btn_back_heartbeat")

	local function var_1_10()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		RoomTouchSystem = var_2_10002

		var_3_1(var_3_0, var_2_10002.EXIT_HEARTBEAT_MODE)

		return
	end

	SFX_DORM_BACK = var_5

	var_1(var_1_7, var_1_9, var_1_10, var_5)

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.bind

	RoomTouchSystem = var_1_9

	var_1_12(var_1_11, var_1_9.UPDATE_TOUCH_PANEL, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_1_0

		var_4.UpdateTouchPanel(var_4_0, arg_4_1, arg_4_2, arg_4_3)

		return
	end)

	local var_1_13 = arg_1_0
	local var_1_14 = arg_1_0.bind

	RoomTouchSystem = var_3

	var_1_14(var_1_13, var_3.UPDATE_TOUCH_COUNT, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0

		var_2.UpdateTouchCount(var_5_0, arg_5_1)

		return
	end)

	local var_1_15 = arg_1_0
	local var_1_16 = arg_1_0.bind

	RoomTouchSystem = var_3

	var_1_16(var_1_15, var_3.UPDATE_TOUCH_LEVEL, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0

		var_2.UpdateTouchLevel(var_6_0, arg_6_1)

		return
	end)

	local var_1_17 = arg_1_0
	local var_1_18 = arg_1_0.bind

	RoomTouchSystem = var_3

	var_1_18(var_1_17, var_3.UPDATE_TOUCH_DISPLAY, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0

		var_3.UpdateTouchLevel(var_7_0, arg_7_1)

		local var_7_1 = arg_1_0

		var_3.UpdateTouchCount(var_7_1, arg_7_2)

		return
	end)

	return
end

function var_0_1.UpdateTouchPanel(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 then
		setActive = var_1_10004

		var_1_10004(arg_8_0.rtTouchGamePanel, true)

		quickPlayAnimation = var_1_10004

		var_1_10004(arg_8_0.rtTouchGamePanel, "anim_dorm3d_touch_in")

		quickPlayAnimation = var_1_10004

		local var_8_0 = arg_8_0.rtTouchGamePanel

		var_1_10004(var_5.Find(var_8_0, "slider/icon"), "anim_dorm3d_touch_icon")

		existCall = var_1_10004

		var_1_10004(arg_8_3)
	elseif arg_8_2 then
		quickPlayAnimation = var_1_10004

		var_1_10004(arg_8_0.rtTouchGamePanel, "anim_dorm3d_touch_out")

		onDelayTick = var_1_10004

		var_1_10004(function()
			setActive = var_2_10000

			var_2_10000(arg_8_0.rtTouchGamePanel, false)

			existCall = var_2_10000

			var_2_10000(arg_8_3)

			return
		end, 0.5)
	else
		setActive = var_1_10004

		var_1_10004(arg_8_0.rtTouchGamePanel, false)

		existCall = var_1_10004

		var_1_10004(arg_8_3)
	end

	return
end

function var_0_1.UpdateTouchLevel(arg_10_0, arg_10_1)
	arg_10_0.touchLevel = arg_10_1
	setActive = var_1_10002

	local var_10_0 = arg_10_0.rtTouchGamePanel

	var_1_10002(var_3.Find(var_10_0, "effect_bg"), arg_10_1 == 2)

	setActive = var_1_10002

	local var_10_1 = arg_10_0.rtTouchGamePanel

	var_1_10002(var_3.Find(var_10_1, "slider/icon/beating"), arg_10_1 == 2)

	if arg_10_1 == 1 then
		setActive = var_1_10002

		local var_10_2 = arg_10_0.rtIKUI

		var_1_10002(var_3.Find(var_10_2, "btn_back"), true)

		setActive = var_1_10002

		local var_10_3 = arg_10_0.rtIKUI

		var_1_10002(var_3.Find(var_10_3, "btn_back_heartbeat"), false)

		quickPlayAnimation = var_1_10002

		var_1_10002(arg_10_0.rtTouchGamePanel, "anim_dorm3d_touch_change_out")

		quickPlayAnimation = var_1_10002

		local var_10_4 = arg_10_0.rtTouchGamePanel

		var_1_10002(var_3.Find(var_10_4, "slider/icon"), "anim_dorm3d_touch_icon")
	elseif arg_10_1 == 2 then
		setActive = var_1_10002

		local var_10_5 = arg_10_0.rtIKUI

		var_1_10002(var_3.Find(var_10_5, "btn_back"), false)

		setActive = var_1_10002

		local var_10_6 = arg_10_0.rtIKUI

		var_1_10002(var_3.Find(var_10_6, "btn_back_heartbeat"), true)

		quickPlayAnimation = var_1_10002

		var_1_10002(arg_10_0.rtTouchGamePanel, "anim_dorm3d_touch_change")

		quickPlayAnimation = var_1_10002

		local var_10_7 = arg_10_0.rtTouchGamePanel

		var_1_10002(var_3.Find(var_10_7, "slider/icon"), "anim_dorm3d_touch_icon_1")

		pg = var_1_10002

		local var_10_8 = var_1_10002.CriMgr.GetInstance()

		var_2.PlaySE_V3(var_10_8, "ui-dorm_heartbeat")
	end

	return
end

function var_0_1.UpdateTouchCount(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1

	if arg_11_0.touchLevel and arg_11_0.touchLevel > 1 then
		var_11_0 = 200 <= arg_11_1 and 100 or arg_11_1 % 100
	end

	setSlider = var_3

	local var_11_1 = arg_11_0.rtTouchGamePanel

	var_3(var_4.Find(var_11_1, "slider"), 0, 100, var_11_0)

	return
end

return var_0_1
