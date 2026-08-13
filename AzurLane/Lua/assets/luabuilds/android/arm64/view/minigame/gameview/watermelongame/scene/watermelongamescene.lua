class = var_0_10000

local var_0_0 = var_0_10000("WatermelonGameScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	findTF = var_1_10004
	arg_1_0.sceneMask = var_1_10004(arg_1_0._tf, "sceneMask")
	findTF = var_4
	arg_1_0.sceneContainer = var_4(arg_1_0._tf, "sceneMask/sceneContainer")

	arg_1_0:showContainer(false)

	WatermelonCollisionCtrl = var_4
	arg_1_0.physicsCtrl = var_4.New(arg_1_0.contextData, arg_1_0._event)
	WatermelonBallCtrl = var_4

	local var_1_0 = var_4.New

	findTF = var_6
	arg_1_0.ballCtrl = var_1_0(var_6(arg_1_0.sceneContainer, "scene/content/physics_content"), arg_1_0.contextData, arg_1_0._event)

	local var_1_1 = arg_1_0.physicsCtrl

	var_4.setGameVo(var_1_1, arg_1_0._gameVo)

	local var_1_2 = arg_1_0.ballCtrl

	var_4.setGameVo(var_1_2, arg_1_0._gameVo)

	local var_1_3 = arg_1_0._event
	local var_1_4 = var_4.bind

	WatermelonGameEvent = var_7

	var_1_4(var_1_3, var_7.CLICK_DOWN, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0.ballCtrl

		var_3.dropBall(var_2_0)

		return
	end)

	local var_1_5 = arg_1_0._event
	local var_1_6 = var_4.bind

	WatermelonGameEvent = var_7

	var_1_6(var_1_5, var_7.CLICK_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0.ballCtrl

		var_3.moveWorld(var_3_0, arg_3_1)

		return
	end)

	return
end

function var_0_0.start(arg_4_0)
	arg_4_0:showContainer(true)

	local var_4_0 = arg_4_0.physicsCtrl

	var_1.start(var_4_0)

	local var_4_1 = arg_4_0.ballCtrl

	var_1.start(var_4_1)

	return
end

function var_0_0.step(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.physicsCtrl

	var_2.step(var_5_0, arg_5_1)

	local var_5_1 = arg_5_0.ballCtrl

	var_2.step(var_5_1, arg_5_1)

	return
end

function var_0_0.clear(arg_6_0)
	local var_6_0 = arg_6_0.physicsCtrl

	var_1.clear(var_6_0)

	local var_6_1 = arg_6_0.ballCtrl

	var_1.clear(var_6_1)

	return
end

function var_0_0.stop(arg_7_0)
	local var_7_0 = arg_7_0.physicsCtrl

	var_1.stop(var_7_0)

	local var_7_1 = arg_7_0.ballCtrl

	var_1.stop(var_7_1)

	return
end

function var_0_0.resume(arg_8_0)
	local var_8_0 = arg_8_0.physicsCtrl

	var_1.resume(var_8_0)

	local var_8_1 = arg_8_0.ballCtrl

	var_1.resume(var_8_1)

	return
end

function var_0_0.dispose(arg_9_0)
	local var_9_0 = arg_9_0.physicsCtrl

	var_1.dispose(var_9_0)

	local var_9_1 = arg_9_0.ballCtrl

	var_1.dispose(var_9_1)

	return
end

function var_0_0.showContainer(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0.sceneMask, arg_10_1)

	return
end

return var_0_0
