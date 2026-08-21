local var_0_0 = class("PlayRoomSwitchViewerCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = 0

	if PlayRoomTools.IsViewer() then
		var_1_0 = arg_1_1:getBody().teamIndex
	end

	pg.ConnectionMgr.GetInstance():Send(23009, {
		team_id = var_1_0
	}, 23010, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.PLAY_ROOM_SWITCH_VIEWER_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return var_0_0
