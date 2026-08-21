local var_0_0 = class("IslandFindingPathPlayer", import(".IslandBasePerformancePlayer"))

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.START_PATHFINDER, {
		navData = {
			unitId = arg_1_1.object,
			position = arg_1_1.position,
			speed = arg_1_1.speed,
			hide = arg_1_1.hide,
			waitUntilDone = arg_1_1.waitUntilDone,
			index = arg_1_1.index
		},
		callback = arg_1_2,
		onEndAction = function()
			if arg_1_0.endCallback then
				arg_1_0.endCallback()
			end

			arg_1_0.endCallback = nil

			return
		end
	})

	return
end

function var_0_0.SetEndCallback(arg_3_0, arg_3_1)
	arg_3_0.endCallback = arg_3_1

	return
end

return var_0_0
