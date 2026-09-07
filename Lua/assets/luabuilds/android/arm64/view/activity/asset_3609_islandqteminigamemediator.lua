local IslandQTEMiniGameMediator = class("IslandQTEMiniGameMediator", import("..base.ContextMediator"))

IslandQTEMiniGameMediator.GAME_FINISH = "IslandQTEMiniGameMediator.GAME_FINISH"

function IslandQTEMiniGameMediator:register()
	self:bind(IslandQTEMiniGameMediator.GAME_FINISH, function(arg_2_0, arg_2_1)
		self.contextData.finishCallback(arg_2_1 or 0)

		return
	end)

	return
end

function IslandQTEMiniGameMediator:listNotificationInterests()
	return {}
end

function IslandQTEMiniGameMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return IslandQTEMiniGameMediator
