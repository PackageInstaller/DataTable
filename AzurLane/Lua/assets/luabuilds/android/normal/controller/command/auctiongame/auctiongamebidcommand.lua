class = var_0_10000

local var_0_0 = "AuctionGameBidCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 23405, {
		price = var_1_1
	}, 23406, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			AuctionGameProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.FinishBid(var_2_0, var_1_1)

			local var_2_1 = arg_1_0
			local var_2_2 = var_1.sendNotification

			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.AUCTION_GAME_BID_DONE, var_1_1)
		else
			local var_2_4

			if arg_2_0.result == 12 then
				local var_2_3 = arg_1_0

				var_2_4 = var_2_4.sendNotification
				GAME = var_2_10003

				var_2_4(var_2_3, var_2_10003.AUCTION_GAME_KICK)
			else
				pg = var_2_4

				local var_2_5 = var_2_4.TipsMgr.GetInstance()
				local var_2_6 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_6(var_2_5, var_2_10003("", arg_2_0.result))
			end
		end

		return
	end, false)

	return
end

return var_0_1
