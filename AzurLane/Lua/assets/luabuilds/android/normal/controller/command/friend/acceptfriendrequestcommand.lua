class = var_0_10000

local var_0_0 = "AcceptFriendRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	FriendProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.getFriendCount(var_1_2)

	local function var_1_4(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.ConnectionMgr.GetInstance()

		var_1.Send(var_2_0, 50006, {
			id = var_1_1
		}, 50007, function(arg_3_0)
			if arg_3_0.result == 0 then
				getProxy = var_1
				NotificationProxy = var_3_10002
				var_3_10003 = var_1(var_3_10002)

				var_1.removeRequest(var_3_10003, var_1_1)

				if arg_2_0 then
					var_3_10003 = var_0

					var_2.relieveBlackListById(var_3_10003, var_1_1)
				end

				pg = var_2
				var_3_10003 = var_2.TipsMgr.GetInstance()

				local var_3_0 = var_2.ShowTips

				i18n = var_4

				var_3_0(var_3_10003, var_4("friend_add_ok"))

				var_3_10003 = arg_1_0

				local var_3_1 = var_2.sendNotification

				GAME = var_4

				var_3_1(var_3_10003, var_4.FRIEND_ACCEPT_REQUEST_DONE, var_1_1)
			else
				if arg_3_0.result == 6 then
					pg = var_3_3

					local var_3_2 = var_3_3.TipsMgr.GetInstance()
					local var_3_3 = var_3_3.ShowTips

					i18n = var_3_10003

					var_3_3(var_3_2, var_3_10003("friend_max_count_1"))
				end

				pg = var_3_3

				local var_3_4 = var_3_3.TipsMgr.GetInstance()
				local var_3_5 = var_1.ShowTips

				errorTip = var_3_10003

				var_3_5(var_3_4, var_3_10003("friend_acceptFriendRequest", arg_3_0.result))
			end

			return
		end)

		return
	end

	MAX_FRIEND_COUNT = var_1_10006

	if var_1_3 == var_1_10006 then
		pg = var_1_10006

		local var_1_5 = var_1_10006.TipsMgr.GetInstance()
		local var_1_6 = var_6.ShowTips

		i18n = var_1_10008

		var_1_6(var_1_5, var_1_10008("friend_max_count"))

		return
	end

	if var_3:isInBlackList(var_1_1) then
		pg = var_6

		local var_1_7 = var_6.MsgboxMgr.GetInstance()
		local var_1_8 = var_6.ShowMsgBox
		local var_1_9 = {}

		i18n = var_1_10009
		var_1_9.content = var_1_10009("friend_relieve_backlist_tip")

		function var_1_9.onYes()
			var_1_4(true)

			return
		end

		var_1_8(var_1_7, var_1_9)
	else
		var_1_4(false)
	end

	return
end

return var_0_1
