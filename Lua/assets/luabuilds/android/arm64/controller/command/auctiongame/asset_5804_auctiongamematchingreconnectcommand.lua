local AuctionGameMatchingReconnectCommand = class("AuctionGameMatchingReconnectCommand", pm.SimpleCommand)

function AuctionGameMatchingReconnectCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23428, {
		arg = 1
	}, 23429, function(arg_2_0)
		self:sendNotification(GAME.AUCTION_GAME_MATCHING_RECONNECT_DONE, arg_2_0.state)

		return
	end, false)

	return
end

return AuctionGameMatchingReconnectCommand
