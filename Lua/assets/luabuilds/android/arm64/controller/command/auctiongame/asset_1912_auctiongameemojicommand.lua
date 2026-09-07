local AuctionGameEmojiCommand = class("AuctionGameEmojiCommand", pm.SimpleCommand)

function AuctionGameEmojiCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23413, {
		expression_id = arg_1_1:getBody()
	}, 23414, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(AuctionGameProxy):SetSendEmojiTimestamp(pg.TimeMgr.GetInstance():GetServerTime())
			self:sendNotification(GAME.AUCTION_GAME_EMOJI_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return AuctionGameEmojiCommand
