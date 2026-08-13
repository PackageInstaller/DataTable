class = var_0_10000

local var_0_0 = "InstagramFetchCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getActivityById(var_1_1, var_1_0.activity_id)

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11202, {
		cmd = 6,
		activity_id = var_1_0.activity_id,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_2.data1_list
			math = var_2_10002

			local var_2_1 = var_2_10002.floor(#arg_2_0.number)

			for iter_2_0 = 1, var_2_1 do
				var_2_10007 = var_1_2.data1_list
				var_2_10007[iter_2_0] = arg_2_0.number[iter_2_0]
			end

			local var_2_2 = var_0
			local var_2_3 = var_3.RegisterRequestTime
			local var_2_4 = var_1_0.activity_id

			pg = var_2_10007

			local var_2_5 = var_2_10007.TimeMgr.GetInstance()

			var_2_3(var_2_2, var_2_4, var_7.GetServerTime(var_2_5))

			local var_2_6 = var_0

			var_3.updateActivity(var_2_6, var_1_2)
		else
			pg = var_2_0

			local var_2_7 = var_2_0.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_8(var_2_7, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
