local ReversePacmanSelectMediator = class("ReversePacmanSelectMediator", import("view.base.ContextMediator"))

ReversePacmanSelectMediator.GO_SCENE = "ReversePacmanSelectMediator.GO_SCENE"

function ReversePacmanSelectMediator:register()
	self:bind(ReversePacmanSelectMediator.GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)

	return
end

function ReversePacmanSelectMediator:listNotificationInterests()
	return {}
end

function ReversePacmanSelectMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return ReversePacmanSelectMediator
