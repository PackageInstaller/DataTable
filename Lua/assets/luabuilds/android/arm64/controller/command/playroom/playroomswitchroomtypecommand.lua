local var_0_0 = class("PlayRoomSwitchRoomTypeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = getProxy(PlayRoomProxy)
	local var_1_1 = var_1_0.GetRoomData(var_1_9000)

	if PlayRoomTools.GetHostID() ~= getProxy(PlayerProxy).getPlayerId(var_1_0) then
		return
	end

	;({}).type = switch(var_1_1.roomType, {
		[PlayRoomConst.PLAY_ROOM_TYPE.PERSON] = function()
			return PlayRoomConst.PLAY_ROOM_TYPE.COMMON
		end,
		[PlayRoomConst.PLAY_ROOM_TYPE.COMMON] = function()
			return PlayRoomConst.PLAY_ROOM_TYPE.PERSON
		end
	}, function()
		assert(false)

		return
	end)
	;({}).game_type = var_1_1.gameType

	pg.ConnectionMgr.GetInstance():Send(23005, {}, 23006, function(arg_5_0)
		if arg_5_0.result == 0 then
			local var_5_0 = getProxy(PlayRoomProxy)

			var_5_0:UpdateRoomData(arg_5_0.room)
			var_5_0:ClearInviteList()
			var_5_0:ClearInviteRecordList()
			arg_1_0:sendNotification(GAME.PLAY_ROOM_SWITCH_ROOM_TYPE_DONE)
		elseif arg_5_0.result == 19 then
			PlayRoomTools.ShowPunishementBox(arg_5_0.cd)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_5_0.result))
		end

		return
	end)

	return
end

return var_0_0
