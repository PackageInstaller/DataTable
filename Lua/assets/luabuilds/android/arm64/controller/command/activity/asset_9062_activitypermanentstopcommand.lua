local ActivityPermanentStopCommand = class("ActivityPermanentStopCommand", pm.SimpleCommand)

function ActivityPermanentStopCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.activity_id
	local var_1_2 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(11208, {
		typ = 2,
		activity_id = var_1_0.activity_id
	}, 11209, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(ActivityPermanentProxy):StopNowActivity(var_1_1)

			if getProxy(ActivityProxy):RawGetActivityById(var_1_1) then
				getProxy(ActivityProxy):deleteActivityById(var_1_1)
			end

			self:sendNotification(GAME.ACTIVITY_PERMANENT_STOP_DONE, {
				activity_id = var_1_1
			})
			existCall(var_1_2)
		else
			warning("error permanent")
		end

		return
	end)

	return
end

return ActivityPermanentStopCommand
