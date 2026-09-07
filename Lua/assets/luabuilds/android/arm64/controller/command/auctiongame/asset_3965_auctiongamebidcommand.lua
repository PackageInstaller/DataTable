local AuctionGameBidCommand = class("AuctionGameBidCommand", pm.SimpleCommand)

function AuctionGameBidCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23405, {
		price = var_1_0
	}, 23406, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(AuctionGameProxy):FinishBid(var_1_0)
			self:sendNotification(GAME.AUCTION_GAME_BID_DONE, var_1_0)
		elseif arg_2_0.result == 12 then
			self:sendNotification(GAME.AUCTION_GAME_KICK)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return AuctionGameBidCommand
