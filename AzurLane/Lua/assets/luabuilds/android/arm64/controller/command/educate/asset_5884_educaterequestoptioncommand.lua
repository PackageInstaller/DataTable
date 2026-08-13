class = var_0_10000

local var_0_0 = "EducateRequestOptionCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 27045, {
		type = 1
	}, 27046, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			EducateProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)

			var_2_2.initRandomOpts(var_2_0, arg_2_0.opts)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.EDUCATE_REQUEST_OPTION_DONE)

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("educate request option data error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
