local SingleEventRefreshCommand = class("SingleEventRefreshCommand", pm.SimpleCommand)

function SingleEventRefreshCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 2,
		activity_id = var_1_0.actId
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy):getActivityById(var_1_0.actId)

			var_2_0:SetDailyEventIds(arg_2_0.number)
			getProxy(ActivityProxy):updateActivity(var_2_0)
			pg.m02:sendNotification(GAME.SINGLE_EVENT_REFRESH_DONE, {
				activity = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Refresh single event failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return SingleEventRefreshCommand
