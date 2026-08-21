local var_0_0 = class("DeleteFriendCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(FriendProxy):getFriend(var_1_0)

	pg.ConnectionMgr.GetInstance():Send(50011, {
		id = var_1_0
	}, 50012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(DormProxy):GetVisitorShip()

			if var_2_0 and var_2_0.name == var_1_1.name then
				getProxy(DormProxy):SetVisitorShip(nil)
			end

			arg_1_0:sendNotification(GAME.FRIEND_DELETE_DONE, var_1_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("friend_deleteFriend", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
