local var_0_0 = class("DOALinkIslandMediator", import("..TemplateMV.BackHillMediatorTemplate"))

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_2_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_2_0:bind(var_0_0.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		arg_2_0:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	arg_2_0:bind(var_0_0.MINI_GAME_OPERATOR, function(arg_5_0, ...)
		arg_2_0:sendNotification(GAME.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_8_0)
				if #var_7_1.awards > 0 then
					arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, arg_8_0)
				else
					arg_8_0()
				end

				return
			end,
			function(arg_9_0)
				arg_7_0.viewComponent:UpdateView()

				return
			end
		})
	elseif var_7_0 == ActivityProxy.ACTIVITY_UPDATED then
		arg_7_0.viewComponent:UpdateActivity((arg_7_1:getBody()))
	end

	return
end

return var_0_0
