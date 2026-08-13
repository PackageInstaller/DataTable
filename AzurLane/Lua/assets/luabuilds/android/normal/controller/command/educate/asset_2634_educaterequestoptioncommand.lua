class = var_0_10000

local var_0_0 = "EducateRequestOptionCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 27045, {
		type = 1
	}, 27046, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			EducateProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)

			var_2_2.initRandomOpts(var_2_0, arg_2_0.opts)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.EDUCATE_REQUEST_OPTION_DONE)

			if var_1_0 then
				var_1_0()
			end
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("educate request option data error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
