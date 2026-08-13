class = var_0_10000

local var_0_0 = "GetCompensateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 30102, {
		type = 0
	}, 30103, function(arg_2_0)
		underscore = var_2_10001

		local var_2_0 = var_2_10001.map(arg_2_0.time_reward_list, function(arg_3_0)
			CompensateData = var_3_10001

			return var_3_10001.New(arg_3_0)
		end)

		getProxy = var_2
		CompensateProxy = var_3

		local var_2_1 = var_2(var_3)

		var_2.RefreshRewardList(var_2_1, var_2_0)

		existCall = var_2

		var_2(var_1_0)

		return
	end)

	return
end

return var_0_1
