class = var_0_10000

local var_0_0 = "Dorm3dAimIKView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_1.TIP_WAIT_TIME = 5
var_0_1.BIND_DRAG_AREA = "Dorm3dAimIKView.BindDragArea"
var_0_1.SHOW_OR_HIDE = "Dorm3dAimIKView.ShowOrHide"

function var_0_1.Init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.tipTF = var_1.Find(var_1_0, "Tips")

	local var_1_1 = arg_1_0._tf

	arg_1_0.layer = var_1.Find(var_1_1, "ControlLayer")

	local var_1_2 = arg_1_0.layer
	local var_1_3 = var_1.GetComponent

	typeof = var_3
	SlideController = var_1_10004
	arg_1_0.controller = var_1_3(var_1_2, var_3(var_1_10004))

	arg_1_0:InitDragEvent()
	arg_1_0:InitHint()
	arg_1_0:Hide()
	arg_1_0:bind(var_0_1.BIND_DRAG_AREA, function(arg_2_0, arg_2_1)
		arg_2_1.dragArea = arg_1_0.layer

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_OR_HIDE, function(arg_3_0, arg_3_1)
		if arg_3_1 then
			local var_3_0 = arg_1_0

			var_2.Show(var_3_0)
		else
			local var_3_1 = arg_1_0

			var_2.Hide(var_3_1)
		end

		return
	end)

	return
end

function var_0_1.InitDragEvent(arg_4_0)
	local var_4_0 = arg_4_0.controller

	var_1.AddBeginDragFunc(var_4_0, function(arg_5_0, arg_5_1)
		setActive = var_2_10002

		var_2_10002(arg_4_0.tipTF, false)

		local var_5_0 = arg_4_0.timer

		var_2.Stop(var_5_0)

		local var_5_1 = arg_4_0
		local var_5_2 = var_2.emit

		AimIKSystem = var_4

		var_5_2(var_5_1, var_4.ON_BEGIN_DRAG, arg_5_0, arg_5_1)

		return
	end)

	local var_4_1 = arg_4_0.controller

	var_1.AddDragFunc(var_4_1, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0
		local var_6_1 = var_2.emit

		AimIKSystem = var_2_10004

		var_6_1(var_6_0, var_2_10004.ON_DRAG, arg_6_0, arg_6_1)

		return
	end)

	local var_4_2 = arg_4_0.controller

	var_1.AddDragEndFunc(var_4_2, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_4_0.timer

		var_2.Start(var_7_0)

		local var_7_1 = arg_4_0
		local var_7_2 = var_2.emit

		AimIKSystem = var_2_10004

		var_7_2(var_7_1, var_2_10004.ON_END_DRAG, arg_7_0, arg_7_1)

		return
	end)

	return
end

function var_0_1.InitHint(arg_8_0)
	arg_8_0.time = var_0_1.TIP_WAIT_TIME
	Timer = var_1
	arg_8_0.timer = var_1.New(function()
		if arg_8_0.time <= 0 then
			local var_9_0 = arg_8_0

			var_9_0.time = var_0_1.TIP_WAIT_TIME
			isActive = var_9_0

			if var_9_0(arg_8_0.tipTF) == false then
				setActive = var_0

				var_0(arg_8_0.tipTF, true)

				local var_9_1 = arg_8_0

				var_0.FlushHint(var_9_1)
			end
		else
			arg_8_0.time = arg_8_0.time - 0.1
		end

		return
	end, 0.1, -1)

	return
end

function var_0_1.FlushHint(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.emit

	AimIKSystem = var_1_10004

	var_10_2(var_10_1, var_1_10004.GET_TIP_SHOW_INFO, var_10_0)

	local var_10_3 = var_10_0[1]

	UIItemList = var_10_1

	local var_10_4 = var_10_1.StaticAlign
	local var_10_5 = arg_10_0.tipTF
	local var_10_6 = arg_10_0.tipTF

	var_10_4(var_10_5, var_5.GetChild(var_10_6, 0), #var_10_3, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_11_1 = arg_11_1 + 1
		setLocalPosition = var_3

		local var_11_0 = arg_11_2

		LuaHelper = var_2_10005

		local var_11_1 = var_2_10005.ScreenToLocal
		local var_11_2 = arg_10_0.tipTF
		local var_11_3 = var_10_3[arg_11_1].pos

		pg = var_2_10008

		var_3(var_11_0, var_11_1(var_11_2, var_11_3, var_2_10008.UIMgr.GetInstance().uiCameraComp))

		return
	end)

	return
end

function var_0_1.Show(arg_12_0)
	var_0_1.super.Show(arg_12_0)

	local var_12_0 = arg_12_0.timer

	var_1.Start(var_12_0)

	return
end

function var_0_1.Hide(arg_13_0)
	var_0_1.super.Hide(arg_13_0)

	local var_13_0 = arg_13_0.timer

	var_1.Stop(var_13_0)

	return
end

return var_0_1
