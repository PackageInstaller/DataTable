class = var_0_10000

local var_0_0 = "AuctionGameEventSelectedIDCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	AuctionGameProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)

	pg = var_1_0

	local var_1_3 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 23402, {
		event_id = var_1_1
	}, 23403, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_1.SetPersonalEventSelectedID(var_2_0, var_1_1)

			local var_2_1 = var_1_2

			var_1.UpdateEventEffect(var_2_1, arg_2_0.public_event_effect)

			local var_2_2 = arg_1_0
			local var_2_3 = var_1.sendNotification

			GAME = var_2_10004

			var_2_3(var_2_2, var_2_10004.AUCTION_GAME_EVENT_SELECTED_ID_DONE, arg_2_0)
		else
			local var_2_5

			if arg_2_0.result == 12 then
				local var_2_4 = arg_1_0

				var_2_5 = var_2_5.sendNotification
				GAME = var_2_10004

				var_2_5(var_2_4, var_2_10004.AUCTION_GAME_KICK)
			else
				pg = var_2_5

				local var_2_6 = var_2_5.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				errorTip = var_2_10004

				var_2_7(var_2_6, var_2_10004("", arg_2_0.result))
			end
		end

		return
	end, false)

	return
end

return var_0_1
