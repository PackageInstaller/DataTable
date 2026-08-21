local var_0_0 = class("SingleEventTriggerCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_0.actId,
		arg1 = var_1_0.eventId
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ActivityProxy):getActivityById(var_1_0.actId)

			var_2_0:AddFinishEvent(var_1_0.eventId)
			getProxy(ActivityProxy):updateActivity(var_2_0)
			pg.m02:sendNotification(GAME.SINGLE_EVENT_TRIGGER_DONE, {
				activity = var_2_0,
				eventId = var_1_0.eventId,
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Trigger single event failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
