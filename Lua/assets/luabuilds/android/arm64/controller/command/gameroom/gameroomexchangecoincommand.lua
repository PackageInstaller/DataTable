local var_0_0 = class("GameRoomExchangeCoinCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.price

	pg.ConnectionMgr.GetInstance():Send(26124, {
		times = var_1_0.times
	}, 26125, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0.coinMax = pg.gameset.game_coin_max.key_value
			arg_1_0.myCoinCount = getProxy(GameRoomProxy):getCoin()

			if arg_1_0.coinMax - arg_1_0.myCoinCount < var_0 then
				var_0 = arg_1_0.coinMax - arg_1_0.myCoinCount
			end

			local var_2_0 = id2res(GameRoomProxy.coin_res_id)

			getProxy(GameRoomProxy):setPayCoinCount(var_0)

			local var_2_1 = getProxy(PlayerProxy):getRawData()

			;({})[var_2_0] = var_0 or 0

			var_2_1:addResources({})

			;({}).gold = var_1_1 or 0

			var_2_1:consume({})
			getProxy(PlayerProxy):updatePlayer(var_2_1)
			pg.m02:sendNotification(GAME.GAME_ROOM_AWARD_DONE, {
				{
					id = pg.player_resource[GameRoomProxy.coin_res_id].itemid,
					type = DROP_TYPE_ITEM,
					count = var_0
				}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
