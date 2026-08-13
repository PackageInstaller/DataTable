class = var_0_10000

local var_0_0 = "SendFriendRequestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.msg

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getData(var_1_2)

	wordVer = var_1_10007

	local var_1_4

	if var_1_10007(var_1_1) > 0 then
		pg = var_7
		var_1_4 = var_7.TipsMgr.GetInstance()

		local var_1_5 = var_7.ShowTips

		i18n = var_1_10010

		var_1_5(var_1_4, var_1_10010("friend_msg_forbid"))

		return
	end

	local var_1_6

	if var_1_3.id == var_1_0 then
		pg = var_1_6
		var_1_4 = var_1_6.TipsMgr.GetInstance()
		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10010

		var_1_6(var_1_4, var_1_10010("dont_add_self"))

		return
	end

	getProxy = var_1_6
	FriendProxy = var_1_4

	local var_1_7 = var_1_6(var_1_4)

	if var_7.isFriend(var_1_7, var_1_0) then
		pg = var_8

		local var_1_8 = var_8.TipsMgr.GetInstance()
		local var_1_9 = var_8.ShowTips

		i18n = var_11

		var_1_9(var_1_8, var_11("friend_already_add"))

		return
	end

	local var_1_10 = var_7:getFriendCount()

	MAX_FRIEND_COUNT = var_1_4

	if var_1_10 == var_1_4 then
		pg = var_1_4

		local var_1_11 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10012

		var_1_4(var_1_11, var_1_10012("friend_max_count"))

		return
	end

	pg = var_1_4

	local var_1_12 = var_1_4.ConnectionMgr.GetInstance()

	var_9.Send(var_1_12, 50003, {
		id = var_1_0,
		content = var_1_1
	}, 50004, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0
			local var_2_1 = var_1.sendNotification

			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.FRIEND_SEND_REQUEST_DONE, var_1_0)

			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10004

			var_2_3(var_2_2, var_2_10004("friend_sendFriendRequest_success"))
		elseif arg_2_0.result == 1 then
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10004

			var_2_5(var_2_4, var_2_10004("friend_sendFriendRequest_success"))
		else
			local var_2_7

			if arg_2_0.result == 9 then
				pg = var_2_7

				local var_2_6 = var_2_7.TipsMgr.GetInstance()

				var_2_7 = var_2_7.ShowTips
				i18n = var_2_10004

				var_2_7(var_2_6, var_2_10004("add_friend_fail_tip9"))
			else
				pg = var_2_7

				local var_2_8 = var_2_7.TipsMgr.GetInstance()
				local var_2_9 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_9(var_2_8, var_2_10004("friend_sendFriendRequest", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
