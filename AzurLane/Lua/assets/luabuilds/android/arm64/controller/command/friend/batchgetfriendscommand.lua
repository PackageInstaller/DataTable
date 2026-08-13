class = var_0_10000

local var_0_0 = "BatchGetFriendsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = {}
	local var_1_2 = {}

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_2.list) do
		getProxy = var_1_10011
		IslandProxy = var_1_10013
		var_1_10013 = var_1_10011(var_1_10013)

		if not var_1_10011.GetPlayerDataCache(var_1_10013, iter_1_1) then
			table = var_1_10012

			var_1_10012.insert(var_1_2, iter_1_1)
		else
			table = var_1_10012

			var_1_10012.insert(var_1_1, var_1_10011)
		end
	end

	local var_1_4

	if #var_1_2 == 0 then
		var_1_0(var_1_1)

		local var_1_3 = arg_1_0

		var_1_4 = arg_1_0.sendNotification
		GAME = iter_1_0

		var_1_4(var_1_3, iter_1_0.BATCH_GET_FRIEND_DONE)

		return
	end

	pg = var_1_4

	local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 50018, {
		user_id_list = var_1_2
	}, 50019, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.user_list) do
			Friend = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_1)
			table = var_2_10007

			var_2_10007.insert(var_1_1, var_2_10006)

			getProxy = var_2_10007
			IslandProxy = var_9

			local var_2_0 = var_2_10007(var_9)

			var_2_10007.AddPlayerDataCache(var_2_0, var_2_10006)
		end

		var_1_0(var_1_1)

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = iter_2_0

		var_2_2(var_2_1, iter_2_0.BATCH_GET_FRIEND_DONE)

		return
	end)

	return
end

return var_0_1
