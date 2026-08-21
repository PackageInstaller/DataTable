local var_0_0 = class("EducateTriggerEventCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(27016, {
		eventid = var_1_0.eventId
	}, 27017, function(arg_2_0)
		if arg_2_0.result == 0 then
			EducateHelper.UpdateDropsData(arg_2_0.drops)
			getProxy(EducateProxy):GetEventProxy():RemoveEvent(var_0)
			arg_1_0:sendNotification(GAME.EDUCATE_TRIGGER_EVENT_DONE, {
				id = var_0,
				drops = arg_2_0.drops,
				cb = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate trigger event error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
