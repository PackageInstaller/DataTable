local PlayRoomSwitchViewerCommand = class("PlayRoomSwitchViewerCommand", pm.SimpleCommand)

function PlayRoomSwitchViewerCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23009, {
		team_id = (PlayRoomTools.IsViewer() or nil) and arg_1_1:getBody().teamIndex
	}, 23010, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.PLAY_ROOM_SWITCH_VIEWER_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return PlayRoomSwitchViewerCommand
