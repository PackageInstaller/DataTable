class = var_0_10000

local var_0_0 = "GetBlackListCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 50016, {
		type = 0
	}, 50017, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.black_list) do
			Player = var_2_10007
			var_2_0[var_2_10007.New(iter_2_1).id] = var_2_10007
		end

		getProxy = var_2
		FriendProxy = var_3

		local var_2_1 = var_2(var_3)

		var_2.setBlackList(var_2_1, var_2_0)

		local var_2_2 = arg_1_0
		local var_2_3 = var_3.sendNotification

		GAME = var_5

		var_2_3(var_2_2, var_5.GET_BLACK_LIST_DONE)

		return
	end)

	return
end

return var_0_1
