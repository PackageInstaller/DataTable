class = var_0_10000

local var_0_0 = "GameRoomWeekCoinCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 26122, {
		type = 0
	}, 26123, function(arg_2_0)
		local var_2_0
		local var_2_1

		if arg_2_0.result == 0 then
			var_2_1 = arg_1_0
			pg = var_2_10003
			var_2_1.coinMax = var_2_10003.gameset.game_coin_max.key_value
			var_2_1 = arg_1_0
			getProxy = var_3
			GameRoomProxy = var_2_10005
			var_2_10005 = var_3(var_2_10005)
			var_2_1.myCoinCount = var_3.getCoin(var_2_10005)
			var_2_1 = arg_1_0.coinMax - arg_1_0.myCoinCount
			pg = var_3

			local var_2_2

			if var_2_1 < var_3.gameset.game_coin_initial.key_value then
				var_2_2 = var_2_1
			end

			id2res = var_2_10004
			GameRoomProxy = var_2_10006

			local var_2_3 = var_2_10004(var_2_10006.coin_res_id)

			getProxy = var_2_10005
			PlayerProxy = var_2_10007

			local var_2_4 = var_2_10005(var_2_10007)
			local var_2_5 = var_2_10005.getRawData(var_2_4)

			var_2_10005.addResources(var_2_5, {
				[var_2_3] = var_2_2 or 0
			})

			pg = var_2_10005
			var_2_10005 = var_2_10005.player_resource
			GameRoomProxy = var_6
			var_2_10005 = var_2_10005[var_6.coin_res_id].itemid

			local var_2_6 = {}
			local var_2_7 = {
				id = var_2_10005
			}

			DROP_TYPE_ITEM = var_8
			var_2_7.type = var_8
			var_2_7.count = var_2_2
			var_2_6[1] = var_2_7
			getProxy = var_2_7
			GameRoomProxy = var_9

			local var_2_8 = var_2_7(var_9)

			var_7.setWeekly(var_2_8)

			pg = var_7

			local var_2_9 = var_7.m02
			local var_2_10 = var_7.sendNotification

			GAME = var_2_10010

			var_2_10(var_2_9, var_2_10010.GAME_ROOM_AWARD_DONE, var_2_6)
		else
			pg = var_2_1

			local var_2_11 = var_2_1.TipsMgr.GetInstance()
			local var_2_12 = var_2.ShowTips

			ERROR_MESSAGE = var_2_10005

			var_2_12(var_2_11, var_2_10005[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
