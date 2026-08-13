class = var_0_10000

local var_0_0 = "IslandGetCardDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.userId

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21326, {
		user_id = var_1_1
	}, 21327, function(arg_2_0)
		IslandCard = var_2_10001

		local var_2_0 = var_2_10001.New(var_1_1, arg_2_0)

		existCall = var_2

		var_2(var_1_0, var_2_0)

		return
	end)

	return
end

return var_0_1
