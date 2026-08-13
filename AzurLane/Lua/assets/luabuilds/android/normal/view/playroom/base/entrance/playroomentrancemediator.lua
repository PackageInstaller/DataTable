class = var_0_10000

local var_0_0 = "PlayRoomEntranceMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_CLICK_MATCH = "PlayRoomEntranceMediator:ON_CLICK_MATCH"
var_0_1.REFRESH_ROOM_INFO = "PlayRoomEntranceMediator:REFRESH_ROOM_INFO"
var_0_1.ON_CLICK_CHANGE_CHARACTER = "PlayRoomEntranceMediator:ON_CLICK_CHANGE_CHARACTER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_CLICK_MATCH, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.PLAY_ROOM_CREATE_ROOM, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_ROOM_INFO, function()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10002

		var_3_1(var_3_0, var_2_10002.PLAY_ROOM_REFRESH_ROOM_INFO)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_CHANGE_CHARACTER, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.sendNotification

		CheaterTavernEvent = var_2_10002

		local var_4_2 = var_2_10002.OPEN_SELECT_SHIP

		IslandCheaterTavernConst = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.ChangeDressType.OutRoom)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.PLAY_ROOM_CREATE_ROOM_DONE
	GAME = var_2
	var_5_0[2] = var_2.PLAY_ROOM_START_GAME_DONE
	GAME = var_2
	var_5_0[3] = var_2.PLAY_ROOM_EXIT_MATCH_READY_ROOM
	GAME = var_2
	var_5_0[4] = var_2.PLAY_ROOM_REFRESH_ROOM_INFO_DONE
	GAME = var_2
	var_5_0[5] = var_2.PLAY_ROOM_EXIT_ROOM_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	switch = var_6_1

	local var_6_3 = var_6_0
	local var_6_4 = {}

	GAME = var_1_10007
	var_6_4[var_1_10007.PLAY_ROOM_CREATE_ROOM_DONE] = function()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)
		local var_7_1 = var_0.GetRoomData(var_7_0).roomType

		PlayRoomConst = var_7_0

		if var_7_1 == var_7_0.PLAY_ROOM_TYPE.MATCH then
			local var_7_2 = arg_6_0
			local var_7_3 = var_0.sendNotification

			GAME = var_2_10002

			var_7_3(var_7_2, var_2_10002.PLAY_ROOM_START_GAME)

			local var_7_4 = arg_6_0.viewComponent

			var_0.OnStartMatch(var_7_4)
		end

		return
	end
	GAME = var_7
	var_6_4[var_7.PLAY_ROOM_START_GAME_DONE] = function()
		return
	end
	GAME = var_7
	var_6_4[var_7.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function()
		return
	end
	GAME = var_7
	var_6_4[var_7.PLAY_ROOM_REFRESH_ROOM_INFO_DONE] = function()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_10_0 = var_2_10000(var_2_10001)

		if var_0.GetRoomData(var_10_0) then
			local var_10_1 = var_0.roomState

			PlayRoomConst = var_2_10002

			local var_10_2

			if var_10_1 == var_2_10002.PLAY_ROOM_STATE.PLAYING then
				IslandCheaterTavernRecordTools = var_10_1

				var_10_1.StartGame()

				var_10_2 = arg_6_0

				local var_10_3 = var_1.sendNotification

				GAME = var_2_10003
				var_2_10003 = var_2_10003.PLAY_ROOM_LOAD_MINIGAME_SCENE
				var_2_10004 = {
					isReconecting = true
				}
				IslandConst = var_2_10005
				var_2_10004.mapId = var_2_10005.CheaterTavernMapId

				var_10_3(var_10_2, var_2_10003, var_2_10004)
			else
				local var_10_4 = var_0.roomType

				PlayRoomConst = var_10_2

				if var_10_4 ~= var_10_2.PLAY_ROOM_TYPE.MATCH then
					local var_10_5 = arg_6_0
					local var_10_6 = var_1.sendNotification

					CheaterTavernEvent = var_2_10003

					local var_10_7 = var_2_10003.PLAY_ROOM_LOAD_ROOM_SCENE

					IslandCheaterTavernConst = var_2_10004

					var_10_6(var_10_5, var_10_7, var_2_10004.SceneRoomType.CustomRoom)
				end
			end
		end

		return
	end
	GAME = var_7
	var_6_4[var_7.PLAY_ROOM_EXIT_ROOM_DONE] = function()
		local var_11_0 = arg_6_0.viewComponent

		var_0.OnStopMatch(var_11_0)

		return
	end

	var_6_1(var_6_3, var_6_4)

	return
end

function var_0_1.remove(arg_12_0)
	return
end

return var_0_1
