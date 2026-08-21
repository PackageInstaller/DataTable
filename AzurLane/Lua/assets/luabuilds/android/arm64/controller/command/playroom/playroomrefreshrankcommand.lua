local var_0_0 = class("PlayRoomRefreshRankCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23025, {
		game_type = arg_1_1:getBody().gameType
	}, 23026, function(arg_2_0)
		getProxy(PlayRoomProxy):UpdateRankData(var_0, arg_2_0)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_REFRESH_RANK_DONE)

		return
	end, false)

	return
end

return var_0_0
