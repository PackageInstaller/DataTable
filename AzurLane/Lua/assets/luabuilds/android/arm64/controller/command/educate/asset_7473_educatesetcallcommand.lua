class = var_0_10000

local var_0_0 = "EducateSetCallCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1

	var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback
	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 27031, {
		name = var_2.name
	}, 27032, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			getProxy = var_2_3
			EducateProxy = var_2_10003

			local var_2_0 = var_2_3(var_2_10003)
			local var_2_1 = var_2_3.GetCharData(var_2_0)

			var_2_3.SetCallName(var_2_1, var_0.name)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10004

			var_2_3(var_2_2, var_2_10004.EDUCATE_SET_CALL_DONE)
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_5(var_2_4, var_2_10004("educate set call name error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
