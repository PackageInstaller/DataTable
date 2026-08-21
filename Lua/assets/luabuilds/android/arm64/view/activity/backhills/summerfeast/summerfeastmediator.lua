local var_0_0 = class("SummerFeastMediator", import("..TemplateMV.BackHillMediatorTemplate"))

function var_0_0.listNotificationInterests(arg_1_0)
	return {
		GAME.SEND_MINI_GAME_OP_DONE
	}
end

function var_0_0.handleNotification(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getBody()

	if arg_2_1:getName() == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_3_0)
				if #var_2_0.awards > 0 then
					arg_2_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_2_0.awards, arg_3_0)
				else
					arg_3_0()
				end

				return
			end,
			function(arg_4_0)
				arg_2_0.viewComponent:UpdateView()

				return
			end
		})
	end

	return
end

return var_0_0
