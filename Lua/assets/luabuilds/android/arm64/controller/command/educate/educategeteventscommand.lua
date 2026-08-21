local var_0_0 = class("EducateGetEventsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(27014, {
		type = 0
	}, 27015, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EducateProxy):GetEventProxy():SetHomeEventData(arg_2_0.events)

			if var_1_1 then
				var_1_1()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate trigger specEvent error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
