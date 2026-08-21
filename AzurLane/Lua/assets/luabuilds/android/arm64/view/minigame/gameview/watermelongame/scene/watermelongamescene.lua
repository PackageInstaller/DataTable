local var_0_0 = class("WatermelonGameScene")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0.sceneMask = findTF(arg_1_0._tf, "sceneMask")
	arg_1_0.sceneContainer = findTF(arg_1_0._tf, "sceneMask/sceneContainer")

	arg_1_0:showContainer(false)

	arg_1_0.physicsCtrl = WatermelonCollisionCtrl.New(arg_1_0.contextData, arg_1_0._event)
	arg_1_0.ballCtrl = WatermelonBallCtrl.New(findTF(arg_1_0.sceneContainer, "scene/content/physics_content"), arg_1_0.contextData, arg_1_0._event)

	arg_1_0.physicsCtrl:setGameVo(arg_1_0._gameVo)
	arg_1_0.ballCtrl:setGameVo(arg_1_0._gameVo)
	arg_1_0._event:bind(WatermelonGameEvent.CLICK_DOWN, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0.ballCtrl:dropBall()

		return
	end)
	arg_1_0._event:bind(WatermelonGameEvent.CLICK_MOVE, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0.ballCtrl:moveWorld(arg_3_1)

		return
	end)

	return
end

function var_0_0.start(arg_4_0)
	arg_4_0:showContainer(true)
	arg_4_0.physicsCtrl:start()
	arg_4_0.ballCtrl:start()

	return
end

function var_0_0.step(arg_5_0, arg_5_1)
	arg_5_0.physicsCtrl:step(arg_5_1)
	arg_5_0.ballCtrl:step(arg_5_1)

	return
end

function var_0_0.clear(arg_6_0)
	arg_6_0.physicsCtrl:clear()
	arg_6_0.ballCtrl:clear()

	return
end

function var_0_0.stop(arg_7_0)
	arg_7_0.physicsCtrl:stop()
	arg_7_0.ballCtrl:stop()

	return
end

function var_0_0.resume(arg_8_0)
	arg_8_0.physicsCtrl:resume()
	arg_8_0.ballCtrl:resume()

	return
end

function var_0_0.dispose(arg_9_0)
	arg_9_0.physicsCtrl:dispose()
	arg_9_0.ballCtrl:dispose()

	return
end

function var_0_0.showContainer(arg_10_0, arg_10_1)
	setActive(arg_10_0.sceneMask, arg_10_1)

	return
end

return var_0_0
