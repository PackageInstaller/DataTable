local SummerFeastMediator = class("SummerFeastMediator", import("..TemplateMV.BackHillMediatorTemplate"))

function SummerFeastMediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE
	}
end

function SummerFeastMediator:handleNotification(arg_2_1)
	local var_2_0 = arg_2_1:getBody()

	if arg_2_1:getName() == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_3_0)
				if #var_2_0.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_2_0.awards, arg_3_0)
				else
					arg_3_0()
				end

				return
			end,
			function(arg_4_0)
				self.viewComponent:UpdateView()

				return
			end
		})
	end

	return
end

return SummerFeastMediator
