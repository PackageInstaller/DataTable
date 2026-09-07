local EducateTriggerEventCommand = class("EducateTriggerEventCommand", pm.SimpleCommand)

function EducateTriggerEventCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback
	local var_1_2 = var_1_0.eventId

	pg.ConnectionMgr.GetInstance():Send(27016, {
		eventid = var_1_0.eventId
	}, 27017, function(arg_2_0)
		if arg_2_0.result == 0 then
			EducateHelper.UpdateDropsData(arg_2_0.drops)
			getProxy(EducateProxy):GetEventProxy():RemoveEvent(var_1_2)
			self:sendNotification(GAME.EDUCATE_TRIGGER_EVENT_DONE, {
				id = var_1_2,
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

return EducateTriggerEventCommand
