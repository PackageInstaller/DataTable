class = var_0_10000

local var_0_0 = "GameRoomExchangeCoinCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().times
	local var_1_1 = var_2.price

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 26124, {
		times = var_1_0
	}, 26125, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = arg_1_0
			pg = var_2_10002
			var_2_0.coinMax = var_2_10002.gameset.game_coin_max.key_value
			var_2_0 = arg_1_0
			getProxy = var_2
			GameRoomProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)
			var_2_0.myCoinCount = var_2.getCoin(var_2_10003)

			if arg_1_0.coinMax - arg_1_0.myCoinCount < var_1_0 then
				var_1_0 = var_2_0
			end

			id2res = var_2
			GameRoomProxy = var_2_10003

			local var_2_1 = var_2(var_2_10003.coin_res_id)

			getProxy = var_2_10003
			GameRoomProxy = var_2_10004

			local var_2_2 = var_2_10003(var_2_10004)

			var_2_10003.setPayCoinCount(var_2_2, var_1_0)

			getProxy = var_2_10003
			PlayerProxy = var_2_2

			local var_2_3 = var_2_10003(var_2_2)
			local var_2_4 = var_2_10003.getRawData(var_2_3)
			local var_2_5 = var_2_10003.addResources
			local var_2_6 = {}
			local var_2_7

			if not var_1_0 then
				var_2_7 = 0
			end

			var_2_6[var_2_1] = var_2_7

			var_2_5(var_2_4, var_2_6)

			local var_2_8 = var_2_10003
			local var_2_9 = var_2_10003.consume
			local var_2_10 = {}
			local var_2_11

			if not var_1_1 then
				var_2_11 = 0
			end

			var_2_10.gold = var_2_11

			var_2_9(var_2_8, var_2_10)

			getProxy = var_2_9
			PlayerProxy = var_2_8

			local var_2_12 = var_2_9(var_2_8)

			var_4.updatePlayer(var_2_12, var_2_10003)

			pg = var_4

			local var_2_13 = var_4.player_resource

			GameRoomProxy = var_2_12

			local var_2_14 = var_2_13[var_2_12.coin_res_id].itemid
			local var_2_15 = {}
			local var_2_16 = {
				id = var_2_14
			}

			DROP_TYPE_ITEM = var_2_11
			var_2_16.type = var_2_11
			var_2_16.count = var_1_0
			var_2_15[1] = var_2_16
			pg = var_2_16

			local var_2_17 = var_2_16.m02
			local var_2_18 = var_6.sendNotification

			GAME = var_2_10008

			var_2_18(var_2_17, var_2_10008.GAME_ROOM_AWARD_DONE, var_2_15)
		else
			pg = var_2_0

			local var_2_19 = var_2_0.TipsMgr.GetInstance()
			local var_2_20 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_20(var_2_19, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
