local var_0_0 = class("AuctionGameBidCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23405, {
		price = arg_1_1:getBody()
	}, 23406, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(AuctionGameProxy):FinishBid(var_0)
			arg_1_0:sendNotification(GAME.AUCTION_GAME_BID_DONE, var_0)
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
