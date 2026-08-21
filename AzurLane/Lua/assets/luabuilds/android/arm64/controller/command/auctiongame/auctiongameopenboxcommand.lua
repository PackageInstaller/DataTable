local var_0_0 = class("AuctionGameOpenBoxCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23422, {
		arg = 1
	}, 23423, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(AuctionGameBaseProxy):UpdateSettlementData(arg_2_0)
			arg_1_0:sendNotification(GAME.AUCTION_GAME_OPEN_BOX_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return var_0_0
