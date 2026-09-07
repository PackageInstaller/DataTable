local ActivityBossScoreAwardMediator = class("ActivityBossScoreAwardMediator", import("view.base.ContextMediator"))

function ActivityBossScoreAwardMediator:register()
	return
end

function ActivityBossScoreAwardMediator:listNotificationInterests()
	return {}
end

function ActivityBossScoreAwardMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == nil then
		-- block empty
	end

	return
end

function ActivityBossScoreAwardMediator:remove()
	return
end

return ActivityBossScoreAwardMediator
