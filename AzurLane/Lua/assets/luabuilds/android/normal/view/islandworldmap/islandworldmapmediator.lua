class = var_0_10000

local var_0_0 = "IslandWorldMapMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

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

		ISLAND_EVT = var_2_10005

		var_3_1(var_3_0, var_2_10005.SWITCH_SCENE, {
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
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	if var_5_0 == var_5_1.BEGIN_STAGE_DONE then
		-- block empty
	end

	return
end

return var_0_1
