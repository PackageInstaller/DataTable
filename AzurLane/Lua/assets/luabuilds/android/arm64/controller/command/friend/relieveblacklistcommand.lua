local var_0_0 = class("RelieveBlackListCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(FriendProxy)

	if not getProxy(FriendProxy):getBlackPlayerById(var_1_0) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(50107, {
		id = var_1_0
	}, 50108, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:relieveBlackListById(var_1_0)
			arg_1_0:sendNotification(GAME.FRIEND_RELIEVE_BLACKLIST_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_relieveblacklist_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("friend_relieveblacklist", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
