class = var_0_10000

local var_0_0 = "RelieveBlackListCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	FriendProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if not var_3.getBlackPlayerById(var_1_1, var_1_0) then
		return
	end

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 50107, {
		id = var_1_0
	}, 50108, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.relieveBlackListById(var_2_0, var_1_0)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.FRIEND_RELIEVE_BLACKLIST_DONE)

			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_2_10004

			var_2_2(var_2_3, var_2_10004("friend_relieveblacklist_success"))
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_5(var_2_4, var_2_10004("friend_relieveblacklist", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
