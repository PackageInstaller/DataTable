local var_0_0 = class("RejectFriendRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(NotificationProxy)

	if getProxy(NotificationProxy):getRequestCount() == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_no_request"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(50009, {
		id = arg_1_1:getBody()
	}, 50010, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_0 == 0 then
				var_1_1:removeAllRequest()
				pg.TipsMgr.GetInstance():ShowTips(i18n("reject_all_friend_ok"))
			else
				var_1_1:removeRequest(var_1_0)
				pg.TipsMgr.GetInstance():ShowTips(i18n("reject_friend_ok"))
			end

			arg_1_0:sendNotification(GAME.FRIEND_REJECT_REQUEST_DONE, var_1_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("friend_rejectFriendRequest", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
