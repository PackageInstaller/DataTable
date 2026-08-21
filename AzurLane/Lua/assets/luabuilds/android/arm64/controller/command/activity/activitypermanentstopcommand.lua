local var_0_0 = class("ActivityPermanentStopCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(11208, {
		typ = 2,
		activity_id = var_1_0.activity_id
	}, 11209, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(ActivityPermanentProxy):StopNowActivity(var_0)

			if getProxy(ActivityProxy):RawGetActivityById(var_0) then
				getProxy(ActivityProxy):deleteActivityById(var_0)
			end

			arg_1_0:sendNotification(GAME.ACTIVITY_PERMANENT_STOP_DONE, {
				activity_id = var_0
			})
			existCall(var_1_1)
		else
			warning("error permanent")
		end

		return
	end)

	return
end

return var_0_0
