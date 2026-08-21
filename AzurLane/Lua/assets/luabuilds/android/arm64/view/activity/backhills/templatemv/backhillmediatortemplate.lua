local var_0_0 = class("BackHillMediatorTemplate", import("view.base.ContextMediator"))

var_0_0.MINI_GAME_OPERATOR = "MINI_GAME_OPERATOR"
var_0_0.GO_SCENE = "GO_SCENE"
var_0_0.CHANGE_SCENE = "CHANGE_SCENE"
var_0_0.GO_SUBLAYER = "GO_SUBLAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_2_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_0.CHANGE_SCENE, function(arg_4_0, arg_4_1, ...)
		arg_2_0:sendNotification(GAME.CHANGE_SCENE, arg_4_1, ...)

		return
	end)
	arg_2_0:bind(var_0_0.GO_SUBLAYER, function(arg_5_0, arg_5_1, arg_5_2)
		arg_2_0:addSubLayers(arg_5_1, nil, arg_5_2)

		return
	end)
	arg_2_0:bind(var_0_0.MINI_GAME_OPERATOR, function(arg_6_0, ...)
		arg_2_0:sendNotification(GAME.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_9_0)
				if #var_8_1.awards > 0 then
					arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards, arg_9_0)
				else
					arg_9_0()
				end

				return
			end,
			function(arg_10_0)
				arg_8_0.viewComponent:UpdateView()

				return
			end
		})
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		arg_8_0.viewComponent:UpdateActivity((arg_8_1:getBody()))
	end

	return
end

return var_0_0
