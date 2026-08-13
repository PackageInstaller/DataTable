class = var_0_10000

local var_0_0 = "PlayRoomSwitchRoomTypeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	PlayRoomProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.GetRoomData(var_1_0)

	PlayRoomTools = var_1_10003

	local var_1_2 = var_1_10003.GetHostID()

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)

	if var_1_2 ~= var_4.getPlayerId(var_1_3) then
		return
	end

	switch = var_1_2

	local var_1_4 = var_1_1.roomType
	local var_1_5 = {}

	PlayRoomConst = var_1_10007
	var_1_5[var_1_10007.PLAY_ROOM_TYPE.PERSON] = function()
		PlayRoomConst = var_2_10000

		return var_2_10000.PLAY_ROOM_TYPE.COMMON
	end
	PlayRoomConst = var_7
	var_1_5[var_7.PLAY_ROOM_TYPE.COMMON] = function()
		PlayRoomConst = var_2_10000

		return var_2_10000.PLAY_ROOM_TYPE.PERSON
	end

	local var_1_6 = var_1_2(var_1_4, var_1_5, function()
		assert = var_2_10000

		var_2_10000(false)

		return
	end)

	pg = var_4

	local var_1_7 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_1_7, 23005, {
		type = var_1_6,
		game_type = var_1_1.gameType
	}, 23006, function(arg_5_0)
		if arg_5_0.result == 0 then
			getProxy = var_1
			PlayRoomProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.UpdateRoomData(var_2_10004, arg_5_0.room)

			var_2_10004 = var_1

			var_1.ClearInviteList(var_2_10004)

			var_2_10004 = var_1

			var_1.ClearInviteRecordList(var_2_10004)

			var_2_10004 = arg_1_0

			local var_5_0 = var_2.sendNotification

			GAME = var_5

			var_5_0(var_2_10004, var_5.PLAY_ROOM_SWITCH_ROOM_TYPE_DONE)
		elseif arg_5_0.result == 19 then
			PlayRoomTools = var_1

			var_1.ShowPunishementBox(arg_5_0.cd)
		else
			pg = var_1

			local var_5_1 = var_1.TipsMgr.GetInstance()
			local var_5_2 = var_1.ShowTips

			errorTip = var_2_10004

			var_5_2(var_5_1, var_2_10004("", arg_5_0.result))
		end

		return
	end)

	return
end

return var_0_1
