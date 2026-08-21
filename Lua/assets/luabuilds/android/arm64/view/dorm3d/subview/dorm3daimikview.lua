local var_0_0 = class("Dorm3dAimIKView", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_0.TIP_WAIT_TIME = 5
var_0_0.BIND_DRAG_AREA = "Dorm3dAimIKView.BindDragArea"
var_0_0.SHOW_OR_HIDE = "Dorm3dAimIKView.ShowOrHide"

function var_0_0.Init(arg_1_0)
	arg_1_0.tipTF = arg_1_0._tf:Find("Tips")
	arg_1_0.layer = arg_1_0._tf:Find("ControlLayer")
	arg_1_0.controller = arg_1_0.layer:GetComponent(typeof(SlideController))

	arg_1_0:InitDragEvent()
	arg_1_0:InitHint()
	arg_1_0:Hide()
	arg_1_0:bind(var_0_0.BIND_DRAG_AREA, function(arg_2_0, arg_2_1)
		arg_2_1.dragArea = arg_1_0.layer

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_OR_HIDE, function(arg_3_0, arg_3_1)
		if arg_3_1 then
			arg_1_0:Show()
		else
			arg_1_0:Hide()
		end

		return
	end)

	return
end

function var_0_0.InitDragEvent(arg_4_0)
	arg_4_0.controller:AddBeginDragFunc(function(arg_5_0, arg_5_1)
		setActive(arg_4_0.tipTF, false)
		arg_4_0.timer:Stop()
		arg_4_0:emit(AimIKSystem.ON_BEGIN_DRAG, arg_5_0, arg_5_1)

		return
	end)
	arg_4_0.controller:AddDragFunc(function(arg_6_0, arg_6_1)
		arg_4_0:emit(AimIKSystem.ON_DRAG, arg_6_0, arg_6_1)

		return
	end)
	arg_4_0.controller:AddDragEndFunc(function(arg_7_0, arg_7_1)
		arg_4_0.timer:Start()
		arg_4_0:emit(AimIKSystem.ON_END_DRAG, arg_7_0, arg_7_1)

		return
	end)

	return
end

function var_0_0.InitHint(arg_8_0)
	arg_8_0.time = var_0_0.TIP_WAIT_TIME
	arg_8_0.timer = Timer.New(function()
		if arg_8_0.time <= 0 then
			arg_8_0.time = var_0_0.TIP_WAIT_TIME

			if isActive(arg_8_0.tipTF) == false then
				setActive(arg_8_0.tipTF, true)
				arg_8_0:FlushHint()
			end
		else
			arg_8_0.time = arg_8_0.time - 0.1
		end

		return
	end, 0.1, -1)

	return
end

function var_0_0.FlushHint(arg_10_0)
	arg_10_0:emit(AimIKSystem.GET_TIP_SHOW_INFO, {})
	UIItemList.StaticAlign(arg_10_0.tipTF, arg_10_0.tipTF:GetChild(0), #({})[1], function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_11_1 = arg_11_1 + 1

		setLocalPosition(arg_11_2, LuaHelper.ScreenToLocal(arg_10_0.tipTF, var_0[arg_11_1].pos, pg.UIMgr.GetInstance().uiCameraComp))

		return
	end)

	return
end

function var_0_0.Show(arg_12_0)
	var_0_0.super.Show(arg_12_0)
	arg_12_0.timer:Start()

	return
end

function var_0_0.Hide(arg_13_0)
	var_0_0.super.Hide(arg_13_0)
	arg_13_0.timer:Stop()

	return
end

return var_0_0
