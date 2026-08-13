class = var_0_10000

local var_0_0 = "NewEducateSelectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GO_SCENE = "NewEducateSelectMediator:GO_SCENE"
var_0_1.GO_SUBLAYER = "NewEducateSelectMediator.GO_SUBLAYER"
var_0_1.SWITCH_DIFFICULTY = "NewEducateSelectMediator.SWITCH_DIFFICULTY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_1.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0

		var_3.addSubLayers(var_3_0, arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.SWITCH_DIFFICULTY, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.NEW_EDUCATE_REFRESH, {
			id = arg_4_1.id,
			difficulty = arg_4_1.difficulty,
			callback = arg_4_1.callback
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return var_0_1
