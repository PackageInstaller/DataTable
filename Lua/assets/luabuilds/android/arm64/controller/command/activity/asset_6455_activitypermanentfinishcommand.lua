local ActivityPermanentFinishCommand = class("ActivityPermanentFinishCommand", pm.SimpleCommand)

function ActivityPermanentFinishCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id

	pg.ConnectionMgr.GetInstance():Send(11208, {
		typ = 1,
		activity_id = var_1_0
	}, 11209, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(ActivityPermanentProxy):finishNowActivity(var_1_0)
			getProxy(ActivityProxy):deleteActivityById(var_1_0)
			self:sendNotification(GAME.ACTIVITY_PERMANENT_FINISH_DONE, {
				activity_id = var_1_0
			})
		else
			warning("error permanent")
		end

		return
	end)

	return
end

return ActivityPermanentFinishCommand
