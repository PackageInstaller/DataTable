class = var_0_10000

local var_0_0 = "AuctionGameGetReliefCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 23426, {
		arg = 1
	}, 23427, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getActivityByType

			ActivityConst = var_2_10005

			local var_2_1 = var_2_0(var_2_10004, var_2_10005.ACTIVITY_TYPE_AUCTION_GAME)
			local var_2_2 = var_2.getConfig(var_2_1, "config_client").itemID

			PlayerConst = var_2_10004
			var_2_10004 = var_2_10004.GetTranAwards

			local var_2_3 = {}
			local var_2_4 = {}
			local var_2_5 = {}
			local var_2_6 = {}

			DROP_TYPE_VITEM = var_2_10010
			var_2_6.type = var_2_10010
			var_2_6.id = var_2_2
			pg = var_2_10010
			var_2_6.number = var_2_10010.gameset.auction_relief_payment.key_value
			var_2_5[1] = var_2_6
			var_2_4.award_list = var_2_5
			var_2_10004 = var_2_10004(var_2_3, var_2_4)
			getProxy = var_2_1
			AuctionGameBaseProxy = var_2_4

			local var_2_7 = var_2_1(var_2_4)

			var_5.AddReliefCnt(var_2_7)

			pg = var_6

			local var_2_8 = var_6.m02
			local var_2_9 = var_6.sendNotification

			GAME = var_2_6

			var_2_9(var_2_8, var_2_6.AUCTION_GAME_GET_RELIEF_DONE, var_2_10004)
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_11(var_2_10, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
