local HoloLiveLinkGameMediator = class("HoloLiveLinkGameMediator", import(".MiniHubMediator"))

function HoloLiveLinkGameMediator:handleNotification(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if arg_1_1:getName() == GAME.SEND_MINI_GAME_OP_DONE and var_1_0.cmd == MiniGameOPCommand.CMD_COMPLETE then
		seriesAsync({
			function(arg_2_0)
				if #var_1_0.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_1_0.awards, arg_2_0)
				else
					arg_2_0()
				end

				return
			end,
			function(arg_3_0)
				self.viewComponent:playStory()

				return
			end
		})
	else
		HoloLiveLinkGameMediator.super.handleNotification(self, arg_1_1)
	end

	return
end

return HoloLiveLinkGameMediator
