class = var_0_10000

local var_0_0 = "IslandFindingPathPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBasePerformancePlayer"))

function var_0_1.Play(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		unitId = arg_1_1.object,
		position = arg_1_1.position,
		speed = arg_1_1.speed,
		hide = arg_1_1.hide,
		waitUntilDone = arg_1_1.waitUntilDone,
		index = arg_1_1.index
	}
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.emit

	IslandBaseScene = var_1_10007

	local var_1_3 = var_1_10007.LINK_CORE_EVENT

	IslandProxy = var_1_10008

	var_1_2(var_1_1, var_1_3, var_1_10008.START_PATHFINDER, {
		navData = var_1_0,
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

function var_0_1.SetEndCallback(arg_3_0, arg_3_1)
	arg_3_0.endCallback = arg_3_1

	return
end

return var_0_1
