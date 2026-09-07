local GameRoomSuccessCommand = class("GameRoomSuccessCommand", pm.SimpleCommand)

function GameRoomSuccessCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.roomId
	local var_1_2 = var_1_0.times
	local var_1_3 = var_1_0.score

	if getProxy(GameRoomProxy):lastTicketMax() == 0 or getProxy(GameRoomProxy):lastMonthlyTicket() == 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(26126, {
		roomid = var_1_0.roomId,
		times = var_1_0.times,
		score = var_1_0.score
	}, 26127, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(GameRoomProxy):storeGameScore(var_1_1, var_1_3)

			local var_2_0 = getProxy(GameRoomProxy)
			local var_2_1 = var_2_0:lastTicketMax()
			local var_2_2 = {}

			var_2_2[id2res(GameRoomProxy.coin_res_id)] = var_1_2 or 0

			getProxy(PlayerProxy).getRawData(var_2_0):consume(var_2_2)

			local var_2_3 = PlayerConst.addTranDrop(arg_2_0.drop_list)
			local var_2_4 = var_2_3[1].count
			local var_2_5 = getProxy(GameRoomProxy):lastMonthlyTicket()

			if var_2_5 < var_2_3[1].count then
				var_2_4 = var_2_5
			end

			if var_2_1 < var_2_4 then
				var_2_4 = var_2_1
			end

			getProxy(GameRoomProxy):setMonthlyTicket(var_2_4)

			var_2_3[1].count = var_2_4

			if var_2_3[1].count ~= 0 then
				pg.m02:sendNotification(GAME.GAME_ROOM_AWARD_DONE, var_2_3)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GameRoomSuccessCommand
