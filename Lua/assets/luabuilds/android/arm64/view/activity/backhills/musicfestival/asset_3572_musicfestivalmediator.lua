local MusicFestivalMediator = class("MusicFestivalMediator", import("..TemplateMV.BackHillMediatorTemplate"))

function MusicFestivalMediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		GAME.ACT_INSTAGRAM_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function MusicFestivalMediator:handleNotification(arg_2_1)
	local var_2_0 = arg_2_1:getName()
	local var_2_1 = arg_2_1:getBody()

	if var_2_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_3_0)
				if #var_2_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_2_1.awards, arg_3_0)
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
	elseif var_2_0 == GAME.ACT_INSTAGRAM_OP_DONE or var_2_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:UpdateView()
	end

	return
end

return MusicFestivalMediator
