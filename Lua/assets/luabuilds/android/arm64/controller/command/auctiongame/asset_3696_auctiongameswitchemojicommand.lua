local AuctionGameSwitchEmojiCommand = class("AuctionGameSwitchEmojiCommand", pm.SimpleCommand)

function AuctionGameSwitchEmojiCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(AuctionGameProxy)
	local var_1_2 = var_1_1:GetSwitchEmojiFlag() == 0 and 1 or 0

	pg.ConnectionMgr.GetInstance():Send(23416, {
		switch = var_1_2
	}, 23417, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:SetSwitchEmojiFlag(var_1_2)
			self:sendNotification(GAME.AUCTION_GAME_SWITCH_EMOJI_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return AuctionGameSwitchEmojiCommand
