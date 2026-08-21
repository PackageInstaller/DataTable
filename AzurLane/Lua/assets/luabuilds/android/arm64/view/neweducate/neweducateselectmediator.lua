local var_0_0 = class("NewEducateSelectMediator", import("view.base.ContextMediator"))

var_0_0.GO_SCENE = "NewEducateSelectMediator:GO_SCENE"
var_0_0.GO_SUBLAYER = "NewEducateSelectMediator.GO_SUBLAYER"
var_0_0.SWITCH_DIFFICULTY = "NewEducateSelectMediator.SWITCH_DIFFICULTY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	arg_1_0:bind(var_0_0.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_0.SWITCH_DIFFICULTY, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_REFRESH, {
			id = arg_4_1.id,
			difficulty = arg_4_1.difficulty,
			callback = arg_4_1.callback
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return var_0_0
