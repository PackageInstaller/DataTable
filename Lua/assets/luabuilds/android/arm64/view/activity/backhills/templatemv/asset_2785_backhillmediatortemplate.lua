local BackHillMediatorTemplate = class("BackHillMediatorTemplate", import("view.base.ContextMediator"))

BackHillMediatorTemplate.MINI_GAME_OPERATOR = "MINI_GAME_OPERATOR"
BackHillMediatorTemplate.GO_SCENE = "GO_SCENE"
BackHillMediatorTemplate.CHANGE_SCENE = "CHANGE_SCENE"
BackHillMediatorTemplate.GO_SUBLAYER = "GO_SUBLAYER"

function BackHillMediatorTemplate:register()
	self:BindEvent()

	return
end

function BackHillMediatorTemplate:BindEvent()
	self:bind(BackHillMediatorTemplate.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(BackHillMediatorTemplate.CHANGE_SCENE, function(arg_4_0, arg_4_1, ...)
		self:sendNotification(GAME.CHANGE_SCENE, arg_4_1, ...)

		return
	end)
	self:bind(BackHillMediatorTemplate.GO_SUBLAYER, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(arg_5_1, nil, arg_5_2)

		return
	end)
	self:bind(BackHillMediatorTemplate.MINI_GAME_OPERATOR, function(arg_6_0, ...)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function BackHillMediatorTemplate:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function BackHillMediatorTemplate:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_9_0)
				if #var_8_1.awards > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards, arg_9_0)
				else
					arg_9_0()
				end

				return
			end,
			function(arg_10_0)
				self.viewComponent:UpdateView()

				return
			end
		})
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:UpdateActivity(var_8_1)
	end

	return
end

return BackHillMediatorTemplate
