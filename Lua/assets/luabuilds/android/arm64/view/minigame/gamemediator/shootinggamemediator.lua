local var_0_0 = class("ShootingGameMediator", import(".MiniHubMediator"))

function var_0_0.handleNotification(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if arg_1_1:getName() == GAME.SEND_MINI_GAME_OP_DONE and var_1_0.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_1_1 = {
			function(arg_2_0)
				if #var_1_0.awards > 0 then
					arg_1_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_1_0.awards, arg_2_0)
				else
					arg_2_0()
				end

				return
			end,
			function(arg_3_0)
				arg_1_0.viewComponent:OnGetAwardDone(var_1_0)
				arg_3_0()

				return
			end
		}

		arg_1_0.viewComponent:updateAfterFinish()
		arg_1_0.viewComponent:showResultPanel(var_1_0.awards, function()
			seriesAsync(var_1_1)
			arg_1_0.viewComponent:OnSendMiniGameOPDone(var_1_0)

			return
		end)
	else
		var_0_0.super.handleNotification(arg_1_0, arg_1_1)
	end

	return
end

return var_0_0
