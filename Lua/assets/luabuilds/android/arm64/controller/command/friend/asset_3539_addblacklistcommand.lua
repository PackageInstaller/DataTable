local AddBlackListCommand = class("AddBlackListCommand", pm.SimpleCommand)

function AddBlackListCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0:isFriend() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_player_is_friend_tip"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(50109, {
		id = var_1_0.id
	}, 50110, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(FriendProxy):addIntoBlackList(var_1_0)
			self:sendNotification(GAME.FRIEND_ADD_BLACKLIST_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_addblacklist_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("friend_addblacklist", arg_2_0.result))
		end

		return
	end)

	return
end

return AddBlackListCommand
