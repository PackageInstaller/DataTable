local SpringFestival2023Mediator = class("SpringFestival2023Mediator", import("..TemplateMV.BackHillMediatorTemplate"))

SpringFestival2023Mediator.MINI_GAME_OPERATOR = "MINI_GAME_OPERATOR"
SpringFestival2023Mediator.GO_SCENE = "GO_SCENE"
SpringFestival2023Mediator.GO_SUBLAYER = "GO_SUBLAYER"
SpringFestival2023Mediator.PLAY_FIREWORKS = "PLAY_FIREWORKS"

function SpringFestival2023Mediator:register()
	self:BindEvent()

	return
end

function SpringFestival2023Mediator:BindEvent()
	self:bind(SpringFestival2023Mediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(SpringFestival2023Mediator.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	self:bind(SpringFestival2023Mediator.MINI_GAME_OPERATOR, function(arg_5_0, ...)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function SpringFestival2023Mediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		SpringFestival2023Mediator.PLAY_FIREWORKS
	}
end

function SpringFestival2023Mediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_8_0)
				if #var_7_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, arg_8_0)
				else
					arg_8_0()
				end

				return
			end,
			function(arg_9_0)
				self.viewComponent:UpdateView()

				return
			end
		})
	elseif var_7_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:UpdateActivity(var_7_1)
	elseif var_7_0 == SpringFestival2023Mediator.PLAY_FIREWORKS then
		self.viewComponent:PlayFireworks(var_7_1)
	end

	return
end

return SpringFestival2023Mediator
