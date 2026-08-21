local var_0_0 = class("GameRoomFirstCoinCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	print("")
	pg.ConnectionMgr.GetInstance():Send(26128, {
		type = 0
	}, 26129, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(GameRoomProxy):setFirstEnter()

			arg_1_0.coinMax = pg.gameset.game_coin_max.key_value
			arg_1_0.myCoinCount = getProxy(GameRoomProxy):getCoin()

			local var_2_0 = pg.gameset.game_coin_initial.key_value

			if arg_1_0.coinMax - arg_1_0.myCoinCount < pg.gameset.game_coin_initial.key_value then
				var_2_0 = arg_1_0.coinMax - arg_1_0.myCoinCount
			end

			;({})[id2res(GameRoomProxy.coin_res_id)] = var_2_0 or 0

			getProxy(PlayerProxy):getRawData():addResources({})
			pg.m02:sendNotification(GAME.ROOM_FIRST_COIN_DONE, {
				{
					id = pg.player_resource[GameRoomProxy.coin_res_id].itemid,
					type = DROP_TYPE_ITEM,
					count = var_2_0
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
