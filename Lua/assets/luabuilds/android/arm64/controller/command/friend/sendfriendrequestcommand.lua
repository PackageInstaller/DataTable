local var_0_0 = class("SendFriendRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id

	if wordVer(var_1_0.msg) > 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_msg_forbid"))

		return
	end

	if getProxy(PlayerProxy):getData().id == var_1_0.id then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dont_add_self"))

		return
	end

	local var_1_2 = getProxy(FriendProxy)

	if var_1_2:isFriend(var_1_0.id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_already_add"))

		return
	end

	if var_1_2:getFriendCount() == MAX_FRIEND_COUNT then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_max_count"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(50003, {
		id = var_1_0.id,
		content = var_1_0.msg
	}, 50004, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.FRIEND_SEND_REQUEST_DONE, var_1_1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_sendFriendRequest_success"))
		elseif arg_2_0.result == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_sendFriendRequest_success"))
		elseif arg_2_0.result == 9 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("add_friend_fail_tip9"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("friend_sendFriendRequest", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
