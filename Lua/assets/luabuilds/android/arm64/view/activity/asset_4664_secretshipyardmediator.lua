local SecretShipyardMediator = class("SecretShipyardMediator", import("..base.ContextMediator"))

SecretShipyardMediator.GO_MINI_GAME = "go minigame"
SecretShipyardMediator.SUBMIT_TASK = "submit task"
SecretShipyardMediator.TASK_GO = "task go"

function SecretShipyardMediator:register()
	self:bind(SecretShipyardMediator.GO_MINI_GAME, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GO_MINI_GAME, arg_2_1)

		return
	end)
	self:bind(SecretShipyardMediator.SUBMIT_TASK, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1)

		return
	end)
	self:bind(SecretShipyardMediator.TASK_GO, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function SecretShipyardMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function SecretShipyardMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody(), function()
			self.viewComponent:updateTaskLayers()

			return
		end)
	elseif var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		self.viewComponent:updateTaskLayers()
	end

	return
end

return SecretShipyardMediator
