class = var_0_10000

local var_0_0 = "AuctionGameMatchingReconnectCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 23428, {
		arg = 1
	}, 23429, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.AUCTION_GAME_MATCHING_RECONNECT_DONE, arg_2_0.state)

		return
	end, false)

	return
end

return var_0_1
