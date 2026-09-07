local PlayRoomSendSceneLoadCompleteCommand = class("PlayRoomSendSceneLoadCompleteCommand", pm.SimpleCommand)

function PlayRoomSendSceneLoadCompleteCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23027, {
		progress = 100
	}, 23028, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return PlayRoomSendSceneLoadCompleteCommand
