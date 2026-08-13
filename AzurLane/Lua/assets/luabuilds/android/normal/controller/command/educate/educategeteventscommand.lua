class = var_0_10000

local var_0_0 = "EducateGetEventsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 27014, {
		type = 0
	}, 27015, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			EducateProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetEventProxy(var_2_0)

			var_1.SetHomeEventData(var_2_1, arg_2_0.events)

			if var_1_0 then
				var_1_0()
			end
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("educate trigger specEvent error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
