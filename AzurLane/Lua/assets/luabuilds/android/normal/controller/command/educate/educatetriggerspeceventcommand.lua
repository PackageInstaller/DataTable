class = var_0_10000

local var_0_0 = "EducateTriggerSpecEventCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.eventId

	pg = var_1_10005

	local var_1_2 = var_1_10005.child_event_special[var_1_1].type

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 27027, {
		spec_events_id = var_1_1
	}, 27028, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			EducateHelper = var_2_2

			var_2_2.UpdateDropsData(arg_2_0.drops)

			getProxy = var_2_2
			EducateProxy = var_2

			local var_2_0 = var_2_2(var_2)
			local var_2_1 = var_2_2.GetEventProxy(var_2_0)

			var_2_2.AddFinishSpecEvent(var_2_1, var_1_1)

			var_2_2 = var_1_2
			EducateSpecialEvent = var_2_1

			if var_2_2 == var_2_1.TYPE_BUBBLE_DISCOUNT then
				getProxy = var_2_2
				EducateProxy = var_2

				local var_2_3 = var_2_2(var_2)
				local var_2_4 = var_2_2.GetShopProxy(var_2_3)

				var_2_2.AddDiscountEventById(var_2_4, var_1_1)
			end

			local var_2_5 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_5, var_2_10003.EDUCATE_TRIGGER_SPEC_EVENT_DONE, {
				siteId = var_0.siteId,
				id = var_1_1,
				type = var_1_2,
				drops = arg_2_0.drops,
				cb = var_1_0
			})
		else
			pg = var_2_2

			local var_2_6 = var_2_2.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_7(var_2_6, var_2_10003("educate trigger specEvent error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
