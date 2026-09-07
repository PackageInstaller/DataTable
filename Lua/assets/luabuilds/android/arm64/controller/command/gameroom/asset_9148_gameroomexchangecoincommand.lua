local GameRoomExchangeCoinCommand = class("GameRoomExchangeCoinCommand", pm.SimpleCommand)

function GameRoomExchangeCoinCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.times
	local var_1_2 = var_1_0.price

	pg.ConnectionMgr.GetInstance():Send(26124, {
		times = var_1_0.times
	}, 26125, function(arg_2_0)
		if arg_2_0.result == 0 then
			self.coinMax = pg.gameset.game_coin_max.key_value
			self.myCoinCount = getProxy(GameRoomProxy):getCoin()

			if self.coinMax - self.myCoinCount < var_1_1 then
				var_1_1 = self.coinMax - self.myCoinCount
			end

			local var_2_0 = id2res(GameRoomProxy.coin_res_id)

			getProxy(GameRoomProxy):setPayCoinCount(var_1_1)

			local var_2_1 = getProxy(PlayerProxy):getRawData()
			local var_2_2 = {}

			var_2_2[var_2_0] = var_1_1 or 0

			var_2_1:addResources(var_2_2)

			local var_2_3 = {}

			var_2_3.gold = var_1_2 or 0

			var_2_1:consume(var_2_3)
			getProxy(PlayerProxy):updatePlayer(var_2_1)
			pg.m02:sendNotification(GAME.GAME_ROOM_AWARD_DONE, {
				{
					id = pg.player_resource[GameRoomProxy.coin_res_id].itemid,
					type = DROP_TYPE_ITEM,
					count = var_1_1
				}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GameRoomExchangeCoinCommand
