local var_0_0 = class("ActivityPermanentFinishCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(11208, {
		typ = 1,
		activity_id = arg_1_1:getBody().activity_id
	}, 11209, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(ActivityPermanentProxy):finishNowActivity(var_0)
			getProxy(ActivityProxy):deleteActivityById(var_0)
			arg_1_0:sendNotification(GAME.ACTIVITY_PERMANENT_FINISH_DONE, {
				activity_id = var_0
			})
		else
			warning("error permanent")
		end

		return
	end)

	return
end

return var_0_0
