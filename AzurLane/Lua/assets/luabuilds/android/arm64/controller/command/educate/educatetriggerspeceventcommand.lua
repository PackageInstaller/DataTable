local var_0_0 = class("EducateTriggerSpecEventCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback
	local var_1_2 = pg.child_event_special[var_1_0.eventId].type

	pg.ConnectionMgr.GetInstance():Send(27027, {
		spec_events_id = var_1_0.eventId
	}, 27028, function(arg_2_0)
		if arg_2_0.result == 0 then
			EducateHelper.UpdateDropsData(arg_2_0.drops)
			getProxy(EducateProxy):GetEventProxy():AddFinishSpecEvent(var_0)

			if var_1_2 == EducateSpecialEvent.TYPE_BUBBLE_DISCOUNT then
				getProxy(EducateProxy):GetShopProxy():AddDiscountEventById(var_0)
			end

			arg_1_0:sendNotification(GAME.EDUCATE_TRIGGER_SPEC_EVENT_DONE, {
				siteId = var_1_0.siteId,
				id = var_0,
				type = var_1_2,
				drops = arg_2_0.drops,
				cb = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate trigger specEvent error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
