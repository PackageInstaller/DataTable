local SpringFestival2024Mediator = class("SpringFestival2024Mediator", import("view.activity.BackHills.TemplateMV.BackHillMediatorTemplate"))

SpringFestival2024Mediator.MINI_GAME_OPERATOR = "MINI_GAME_OPERATOR"
SpringFestival2024Mediator.GO_SCENE = "GO_SCENE"
SpringFestival2024Mediator.GO_SUBLAYER = "GO_SUBLAYER"

function SpringFestival2024Mediator:register()
	self:BindEvent()

	return
end

function SpringFestival2024Mediator:BindEvent()
	self:bind(SpringFestival2024Mediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(SpringFestival2024Mediator.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	self:bind(SpringFestival2024Mediator.MINI_GAME_OPERATOR, function(arg_5_0, ...)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function SpringFestival2024Mediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function SpringFestival2024Mediator:handleNotification(arg_7_1)
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
	end

	return
end

return SpringFestival2024Mediator
