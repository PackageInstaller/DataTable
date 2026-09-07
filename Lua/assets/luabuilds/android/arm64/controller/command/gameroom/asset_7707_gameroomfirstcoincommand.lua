local GameRoomFirstCoinCommand = class("GameRoomFirstCoinCommand", pm.SimpleCommand)

function GameRoomFirstCoinCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	print("")
	pg.ConnectionMgr.GetInstance():Send(26128, {
		type = 0
	}, 26129, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(GameRoomProxy):setFirstEnter()

			self.coinMax = pg.gameset.game_coin_max.key_value
			self.myCoinCount = getProxy(GameRoomProxy):getCoin()

			local var_2_0 = pg.gameset.game_coin_initial.key_value
			local var_2_1

			if self.coinMax - self.myCoinCount < pg.gameset.game_coin_initial.key_value then
				var_2_0 = self.coinMax - self.myCoinCount
				var_2_1 = {}
			end

			var_2_1[id2res(GameRoomProxy.coin_res_id)] = var_2_0 or 0

			getProxy(PlayerProxy):getRawData():addResources(var_2_1)
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

return GameRoomFirstCoinCommand
