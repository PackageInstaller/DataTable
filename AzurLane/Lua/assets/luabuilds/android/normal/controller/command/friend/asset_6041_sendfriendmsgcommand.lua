class = var_0_10000

local var_0_0 = "SendFriendMsgCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().playerId
	local var_1_1 = var_2.msg

	getProxy = var_1_10005
	FriendProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_4

	if not var_5.isFriend(var_1_2, var_1_0) then
		pg = var_1_4

		local var_1_3 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_8

		var_1_4(var_1_3, var_8("friend_sendFriendMsg_error_noFriend"))

		return
	end

	pg = var_1_4

	local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

	var_6.Send(var_1_5, 50105, {
		id = var_1_0,
		content = var_1_1
	}, 50106, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_0

			local var_2_1 = var_2.addChatMsg
			local var_2_2 = var_1_0

			ChatMsg = var_2_10005

			local var_2_3 = var_2_10005.New

			ChatConst = var_2_10006

			local var_2_4 = var_2_10006.ChannelFriend
			local var_2_5 = {
				player = var_2_0:getData(),
				content = var_1_1
			}

			pg = var_8

			local var_2_6 = var_8.TimeMgr.GetInstance()

			var_2_5.timestamp = var_8.GetServerTime(var_2_6)

			var_2_1(var_2_10003, var_2_2, var_2_3(var_2_4, var_2_5))

			var_2_10003 = arg_1_0

			local var_2_7 = var_2.sendNotification

			GAME = var_2_2

			var_2_7(var_2_10003, var_2_2.FRIEND_SEND_MSG_DONE)
		else
			local var_2_9

			if arg_2_0.result == 28 then
				pg = var_2_9

				local var_2_8 = var_2_9.TipsMgr.GetInstance()

				var_2_9 = var_2_9.ShowTips
				i18n = var_2_10003

				var_2_9(var_2_8, var_2_10003("friend_offline"))
			else
				pg = var_2_9

				local var_2_10 = var_2_9.TipsMgr.GetInstance()
				local var_2_11 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_11(var_2_10, var_2_10003("friend_sendFriendMsg", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
