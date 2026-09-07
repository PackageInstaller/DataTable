local OtherworldBackHilllMediator = class("OtherworldBackHilllMediator", import("view.base.ContextMediator"))

OtherworldBackHilllMediator.MINI_GAME_OPERATOR = "MINI_GAME_OPERATOR"
OtherworldBackHilllMediator.GO_SCENE = "GO_SCENE"
OtherworldBackHilllMediator.CHANGE_SCENE = "CHANGE_SCENE"
OtherworldBackHilllMediator.GO_SUBLAYER = "GO_SUBLAYER"

function OtherworldBackHilllMediator:register()
	self:BindEvent()

	return
end

function OtherworldBackHilllMediator:BindEvent()
	self:bind(OtherworldBackHilllMediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(OtherworldBackHilllMediator.CHANGE_SCENE, function(arg_4_0, arg_4_1, ...)
		self:sendNotification(GAME.CHANGE_SCENE, arg_4_1, ...)

		return
	end)
	self:bind(OtherworldBackHilllMediator.GO_SUBLAYER, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(arg_5_1, nil, arg_5_2)

		return
	end)
	self:bind(OtherworldBackHilllMediator.MINI_GAME_OPERATOR, function(arg_6_0, ...)
		self:sendNotification(GAME.SEND_MINI_GAME_OP, ...)

		return
	end)

	return
end

function OtherworldBackHilllMediator:listNotificationInterests()
	return {
		GAME.SEND_MINI_GAME_OP_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED
	}
end

function OtherworldBackHilllMediator:handleNotification(arg_8_1)
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
	elseif var_8_0 == PlayerProxy.UPDATED then
		self.viewComponent:UpdateRes()
		self.viewComponent:UpdateView()
	end

	return
end

return OtherworldBackHilllMediator
