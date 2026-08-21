local var_0_0 = class("AuctionGameEventSelectedIDCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(AuctionGameProxy)

	pg.ConnectionMgr.GetInstance():Send(23402, {
		event_id = arg_1_1:getBody()
	}, 23403, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_0:SetPersonalEventSelectedID(var_0)
			var_1_0:UpdateEventEffect(arg_2_0.public_event_effect)
			arg_1_0:sendNotification(GAME.AUCTION_GAME_EVENT_SELECTED_ID_DONE, arg_2_0)
		elseif arg_2_0.result == 12 then
			arg_1_0:sendNotification(GAME.AUCTION_GAME_KICK)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return var_0_0
