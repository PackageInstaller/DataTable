class = var_0_10000

local var_0_0 = "FetchNpcShipActivityCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if var_4.getActivityById(var_1_2, var_2.activity_id).data1 > 0 then
		existCall = var_5

		var_5(var_1_1)

		return
	end

	pg = var_5

	local var_1_3 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11202, {
		cmd = 1,
		arg1 = 0,
		arg2 = 0,
		activity_id = var_2.activity_id,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.GetTranAwards(var_0, arg_2_0)
			getProxy = var_2_10002
			BayProxy = var_4

			local var_2_1 = var_2_10002(var_4)
			local var_2_2 = var_2.getActivityNPCShipByActId(var_2_1, var_0.id)

			var_2_10003 = var_0
			var_2_10003.data1 = 1
			var_2_10003 = var_0
			var_2_10003.data2 = var_2_2
			getProxy = var_2_10003
			ActivityProxy = var_5

			local var_2_3 = var_2_10003(var_5)

			var_2_10003.updateActivity(var_2_3, var_0)

			local var_2_4 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_6

			var_2_10003(var_2_4, var_6.FETCH_NPC_SHIP_ACTIVITY_DONE, {
				items = var_2_0,
				callback = var_1_1
			})
		else
			originalPrint = var_2_0
			errorTip = var_2_10003

			var_2_0(var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
