class = var_0_10000

local var_0_0 = "RejectFriendRequestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	NotificationProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_3

	if var_3.getRequestCount(var_1_1) == 0 then
		pg = var_1_3

		local var_1_2 = var_1_3.TipsMgr.GetInstance()

		var_1_3 = var_1_3.ShowTips
		i18n = var_1_10007

		var_1_3(var_1_2, var_1_10007("friend_no_request"))

		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_4.Send(var_1_4, 50009, {
		id = var_1_0
	}, 50010, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			if var_1_0 == 0 then
				local var_2_0 = var_0

				var_2_2.removeAllRequest(var_2_0)

				pg = var_2_2

				local var_2_1 = var_2_2.TipsMgr.GetInstance()

				var_2_2 = var_2_2.ShowTips
				i18n = var_2_10004

				var_2_2(var_2_1, var_2_10004("reject_all_friend_ok"))
			else
				local var_2_3 = var_0

				var_2_2.removeRequest(var_2_3, var_1_0)

				pg = var_2_2

				local var_2_4 = var_2_2.TipsMgr.GetInstance()

				var_2_2 = var_2_2.ShowTips
				i18n = var_2_10004

				var_2_2(var_2_4, var_2_10004("reject_friend_ok"))
			end

			local var_2_5 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_5, var_2_10004.FRIEND_REJECT_REQUEST_DONE, var_1_0)
		else
			pg = var_2_2

			local var_2_6 = var_2_2.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_7(var_2_6, var_2_10004("friend_rejectFriendRequest", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
