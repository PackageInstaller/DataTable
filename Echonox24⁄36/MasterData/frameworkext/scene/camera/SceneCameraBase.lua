module("frameworkext.scene.camera.SceneCameraBase", package.seeall)

local var_0_0 = class("SceneCameraBase", SceneComponentBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	arg_1_0._follower = arg_1_0:_initCameraFollow()
	arg_1_0._followToArg = arg_1_0._follower.toArg
	arg_1_0._followCurArg = arg_1_0._follower.curArg
end

function var_0_0.getCurArg(arg_2_0)
	return arg_2_0._followCurArg
end

function var_0_0.getToArg(arg_3_0)
	return arg_3_0._followToArg
end

function var_0_0.setAutoFocusTransfrom(arg_4_0, arg_4_1)
	arg_4_0._follower:SetAutoFocusTransfrom(arg_4_1)
end

function var_0_0.clearAutoFocusTransfrom(arg_5_0)
	arg_5_0._follower:ClearAutoFocusTransfrom()
end

function var_0_0.setFocus(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._followToArg:SetFocusPos(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.setYaw(arg_7_0, arg_7_1)
	arg_7_0._followToArg.yawAngle = arg_7_1
end

function var_0_0.setPitch(arg_8_0, arg_8_1)
	arg_8_0._followToArg.pitchAngle = arg_8_1
end

function var_0_0.setDist(arg_9_0, arg_9_1)
	arg_9_0._followToArg.dist = arg_9_1
end

function var_0_0.setFov(arg_10_0, arg_10_1)
	arg_10_0._followToArg.fov = arg_10_1
end

function var_0_0.applyDirectly(arg_11_0)
	arg_11_0._follower:ApplyDirectly()
end

function var_0_0._initCameraFollow(arg_12_0)
	return nil
end

return var_0_0
