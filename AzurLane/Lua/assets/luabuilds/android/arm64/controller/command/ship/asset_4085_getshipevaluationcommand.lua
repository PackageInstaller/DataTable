class = var_0_10000

local var_0_0 = "GetShipEvaluationCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).shipId

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 31, {
		shipId = var_1_1
	}, 31, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			BayProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getShipById(var_2_10004, var_1_1)
			local var_2_1 = arg_1_0
			local var_2_2 = var_3.sendNotification

			GAME = var_2_10006

			var_2_2(var_2_1, var_2_10006.GET_SHIP_EVALUATION_DONE, var_2_0)
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("get_ship_evaluation", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
