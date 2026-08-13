class = var_0_10000

local var_0_0 = "GameRoomFirstCoinCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	print = var_1_10003

	var_1_10003("")

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 26128, {
		type = 0
	}, 26129, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			GameRoomProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_2_1.setFirstEnter(var_2_0)

			var_2_1 = arg_1_0
			pg = var_2_10002
			var_2_1.coinMax = var_2_10002.gameset.game_coin_max.key_value
			var_2_1 = arg_1_0
			getProxy = var_2
			GameRoomProxy = var_2_10004
			var_2_10004 = var_2(var_2_10004)
			var_2_1.myCoinCount = var_2.getCoin(var_2_10004)
			var_2_1 = arg_1_0.coinMax - arg_1_0.myCoinCount
			pg = var_2

			local var_2_2

			if var_2_1 < var_2.gameset.game_coin_initial.key_value then
				var_2_2 = var_2_1
			end

			id2res = var_2_0
			GameRoomProxy = var_2_10005

			local var_2_3 = var_2_0(var_2_10005.coin_res_id)

			getProxy = var_2_10004
			PlayerProxy = var_2_10006

			local var_2_4 = var_2_10004(var_2_10006)
			local var_2_5 = var_2_10004.getRawData(var_2_4)

			var_2_10004.addResources(var_2_5, {
				[var_2_3] = var_2_2 or 0
			})

			pg = var_2_10004
			var_2_10004 = var_2_10004.player_resource
			GameRoomProxy = var_5
			var_2_10004 = var_2_10004[var_5.coin_res_id].itemid

			local var_2_6 = {}
			local var_2_7 = {
				id = var_2_10004
			}

			DROP_TYPE_ITEM = var_7
			var_2_7.type = var_7
			var_2_7.count = var_2_2
			var_2_6[1] = var_2_7
			pg = var_2_7

			local var_2_8 = var_2_7.m02
			local var_2_9 = var_6.sendNotification

			GAME = var_2_10009

			var_2_9(var_2_8, var_2_10009.ROOM_FIRST_COIN_DONE, var_2_6)
		else
			pg = var_2_1

			local var_2_10 = var_2_1.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_11(var_2_10, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
