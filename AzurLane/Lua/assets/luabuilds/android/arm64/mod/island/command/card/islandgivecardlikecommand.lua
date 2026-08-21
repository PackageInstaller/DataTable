local var_0_0 = class("IslandGiveCardLikeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21334, {
		user_id = var_1_0.userId
	}, 21335, function(arg_2_0)
		if arg_2_0.result == 0 then
			existCall(var_1_1)
			arg_1_0:sendNotification(GAME.ISLAND_GIVE_CARD_LIKE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
