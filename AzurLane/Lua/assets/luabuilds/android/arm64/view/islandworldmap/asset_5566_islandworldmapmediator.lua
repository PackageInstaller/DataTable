class = var_0_10000

local var_0_0 = "IslandWorldMapMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GO_ISLAND = "IslandWorldMapMediator:GO_ISLAND"

function var_0_1.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_1.bindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.GO_ISLAND, function(arg_3_0, arg_3_1, arg_3_2)
		pg = var_2_10003

		local var_3_0 = var_2_10003.m02
		local var_3_1 = var_3.sendNotification

		ISLAND_EVT = var_2_10006

		var_3_1(var_3_0, var_2_10006.SWITCH_SCENE, {
			mapId = arg_3_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	if var_5_1 == var_5_0.BEGIN_STAGE_DONE then
		-- block empty
	end

	return
end

return var_0_1
