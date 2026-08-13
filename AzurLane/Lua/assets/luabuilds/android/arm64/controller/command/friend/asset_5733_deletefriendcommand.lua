class = var_0_10000

local var_0_0 = "DeleteFriendCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	FriendProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)
	local var_1_3 = var_3.getFriend(var_1_2, var_1_1)

	pg = var_1_0

	local var_1_4 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_4, 50011, {
		id = var_1_1
	}, 50012, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			DormProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			if var_1.GetVisitorShip(var_2_0) and var_1.name == var_1_3.name then
				getProxy = var_2
				DormProxy = var_2_10004
				var_2_10004 = var_2(var_2_10004)

				var_2.SetVisitorShip(var_2_10004, nil)
			end

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_2_10005

			var_2_1(var_2_10004, var_2_10005.FRIEND_DELETE_DONE, var_1_1)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_3(var_2_2, var_2_10004("friend_deleteFriend", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
