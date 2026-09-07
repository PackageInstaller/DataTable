local PlayRoomRefreshRankCommand = class("PlayRoomRefreshRankCommand", pm.SimpleCommand)

function PlayRoomRefreshRankCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().gameType

	pg.ConnectionMgr.GetInstance():Send(23025, {
		game_type = var_1_0
	}, 23026, function(arg_2_0)
		getProxy(PlayRoomProxy):UpdateRankData(var_1_0, arg_2_0)
		self:sendNotification(GAME.PLAY_ROOM_REFRESH_RANK_DONE)

		return
	end, false)

	return
end

return PlayRoomRefreshRankCommand
