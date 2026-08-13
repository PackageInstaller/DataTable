class = var_0_10000

local var_0_0 = "ChangeRandomFlagShipModeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().mode

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 12206, {
		flag = var_1_0
	}, 12207, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.getRawData(var_2_0)

			var_1.UpdateRandomFlagShipMode(var_2_10003, var_1_0)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.CHANGE_RANDOM_SHIP_MODE_DONE)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_3(var_2_2, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
