class = var_0_10000

local var_0_0 = "InstagramFetchCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ActivityProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.getActivityById(var_1_2, var_1_1.activity_id)

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 11202, {
		cmd = 6,
		activity_id = var_1_1.activity_id,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_3.data1_list
			math = var_2_10002

			local var_2_1 = var_2_10002.floor(#arg_2_0.number)

			for iter_2_0 = 1, var_2_1 do
				var_1_3.data1_list[iter_2_0] = arg_2_0.number[iter_2_0]
			end

			local var_2_2 = var_0

			var_2_10003 = var_2_10003.RegisterRequestTime

			local var_2_3 = var_1_1.activity_id

			pg = iter_2_0

			local var_2_4 = iter_2_0.TimeMgr.GetInstance()

			var_2_10003(var_2_2, var_2_3, var_6.GetServerTime(var_2_4))

			local var_2_5 = var_0

			var_2_10003.updateActivity(var_2_5, var_1_3)
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_7(var_2_6, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
