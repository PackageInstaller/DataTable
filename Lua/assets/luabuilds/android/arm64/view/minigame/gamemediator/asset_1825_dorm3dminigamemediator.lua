local Dorm3dMiniGameMediator = class("Dorm3dMiniGameMediator", import("view.base.ContextMediator"))

Dorm3dMiniGameMediator.GAME_OPERATION = "Dorm3dMiniGameMediator:GAME_OPERATION"
Dorm3dMiniGameMediator.OPERATION = "Dorm3dMiniGameMediator:OPERATION"

function Dorm3dMiniGameMediator:register()
	self:bind(Dorm3dMiniGameMediator.GAME_OPERATION, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(Dorm3dMiniGameMediator.OPERATION, arg_2_1)

		return
	end)

	return
end

function Dorm3dMiniGameMediator:listNotificationInterests()
	return {}
end

function Dorm3dMiniGameMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return Dorm3dMiniGameMediator
