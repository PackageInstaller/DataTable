class = var_0_10000

local var_0_0 = "GetShipConfirmCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_1_0, 12045, {
		type = 0
	}, 12046, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getData(var_2_10003)

			var_2_0.buildShipNotification = {}

			var_1:updatePlayer(var_2_0)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_2(var_2_1, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
