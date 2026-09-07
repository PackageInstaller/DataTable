local PlayRoomQuickMatchCommand = class("PlayRoomQuickMatchCommand", pm.SimpleCommand)

function PlayRoomQuickMatchCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23418, {
		type = arg_1_1:getBody().type
	}, 23419, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.PLAY_ROOM_QUICK_MATCH_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return PlayRoomQuickMatchCommand
