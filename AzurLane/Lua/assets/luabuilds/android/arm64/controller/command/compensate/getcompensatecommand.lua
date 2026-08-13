class = var_0_10000

local var_0_0 = "GetCompensateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 30102, {
		type = 0
	}, 30103, function(arg_2_0)
		underscore = var_2_10001

		local var_2_0 = var_2_10001.map(arg_2_0.time_reward_list, function(arg_3_0)
			CompensateData = var_3_10001

			return var_3_10001.New(arg_3_0)
		end)

		getProxy = var_2_10002
		CompensateProxy = var_4

		local var_2_1 = var_2_10002(var_4)

		var_2.RefreshRewardList(var_2_1, var_2_0)

		existCall = var_2

		var_2(var_1_1)

		return
	end)

	return
end

return var_0_1
