local AuctionGamePreorderBoxCommand = class("AuctionGamePreorderBoxCommand", pm.SimpleCommand)

function AuctionGamePreorderBoxCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23420, {
		arg = 1
	}, 23421, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(AuctionGameBaseProxy)

			var_2_0:SetOrderTimestamp(arg_2_0.timestamp)
			var_2_0:AddGold(AuctionGameTools.GetPreorderCurrentyCnt() * -1)
			self:sendNotification(GAME.AUCTION_GAME_PREORDER_BOX_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return AuctionGamePreorderBoxCommand
