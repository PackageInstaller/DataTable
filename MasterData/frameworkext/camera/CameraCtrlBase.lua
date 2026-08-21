module("frameworkext.camera.CameraCtrlBase", package.seeall)

local var_0_0 = class("CameraCtrlBase")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0._isActive = false
end

function var_0_0.isActive(arg_2_0)
	return arg_2_0._isActive
end

function var_0_0.getGroup(arg_3_0)
	return 0
end

function var_0_0.onActive(arg_4_0)
	arg_4_0._isActive = true
end

function var_0_0.onInactive(arg_5_0)
	arg_5_0._isActive = false
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0._target = nil
end

return var_0_0
