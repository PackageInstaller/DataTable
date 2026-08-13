class = var_0_10000

local var_0_0 = "PlayRoomCommonMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_CLICK_MATCH = "PlayRoomCommonMediator::ON_CLICK_MATCH"
var_0_1.REFRESH_ROOM_INFO = "PlayRoomCommonMediator::REFRESH_ROOM_INFO"
var_0_1.PLAY_ROOM_MATCH_STOP = "PlayRoomCommonMediator::PLAY_ROOM_MATCH_STOP"
var_0_1.ON_CLICK_READY = "PlayRoomCommonMediator::ON_CLICK_READY"
var_0_1.ON_MATCH_CLICK_READY = "PlayRoomCommonMediator::ON_MATCH_CLICK_READY"
var_0_1.ON_CLICK_QUICK_MATCH = "PlayRoomCommonMediator::ON_CLICK_QUICK_MATCH"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)
	arg_1_0:AppendPlayRoomNotificationHandleDic()

	return
end

function var_0_1.onRegister(arg_2_0)
	var_0_1.super.onRegister(arg_2_0)
	arg_2_0:registerPlayRoom()

	return
end

function var_0_1.AppendPlayRoomNotificationHandleDic(arg_3_0)
	local var_3_0 = arg_3_0:initNotificationHandleDicPlayRoom()

	if arg_3_0.handleDic == nil then
		return
	end

	pairs = var_2

	for iter_3_0, iter_3_1 in var_2(var_3_0) do
		if arg_3_0.handleDic[iter_3_0] == nil then
			arg_3_0.handleDic[iter_3_0] = iter_3_1
		end
	end

	return
end

function var_0_1.registerPlayRoom(arg_4_0)
	arg_4_0:bind(var_0_1.ON_CLICK_MATCH, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.PLAY_ROOM_CREATE_ROOM, arg_5_1)

		return
	end)
	arg_4_0:bind(var_0_1.REFRESH_ROOM_INFO, function(arg_6_0)
		local var_6_0 = arg_4_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.PLAY_ROOM_REFRESH_ROOM_INFO)

		return
	end)
	arg_4_0:bind(var_0_1.PLAY_ROOM_MATCH_STOP, function(arg_7_0)
		local var_7_0 = arg_4_0
		local var_7_1 = var_1.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.PLAY_ROOM_EXIT_ROOM, {
			arg = 0
		})

		return
	end)
	arg_4_0:bind(var_0_1.ON_CLICK_READY, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_4_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10004

		var_8_1(var_8_0, var_2_10004.PLAY_ROOM_READY, arg_8_1)

		return
	end)
	arg_4_0:bind(var_0_1.ON_MATCH_CLICK_READY, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_4_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.PLAY_ROOM_MATCH_READY, arg_9_1)

		return
	end)
	arg_4_0:bind(var_0_1.ON_CLICK_QUICK_MATCH, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_4_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10004

		var_10_1(var_10_0, var_2_10004.PLAY_ROOM_QUICK_MATCH, arg_10_1)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDicPlayRoom(arg_11_0)
	local var_11_0 = {}

	GAME = var_1_10002
	var_11_0[var_1_10002.PLAY_ROOM_CREATE_ROOM_DONE] = function()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_12_0 = var_2_10000(var_2_10001)
		local var_12_1 = var_0.GetRoomData(var_12_0).roomType

		PlayRoomConst = var_12_0

		if var_12_1 == var_12_0.PLAY_ROOM_TYPE.MATCH then
			local var_12_2 = arg_11_0
			local var_12_3 = var_0.sendNotification

			GAME = var_2_10002

			var_12_3(var_12_2, var_2_10002.PLAY_ROOM_START_GAME)

			existCall = var_12_3

			var_12_3(arg_11_0.viewComponent.OnStartMatch, arg_11_0.viewComponent)
		end

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_START_GAME_DONE] = function()
		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function()
		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_READY_DONE] = function(arg_15_0, arg_15_1)
		existCall = var_2_10002

		var_2_10002(arg_15_0.viewComponent.RefreshUI, arg_15_0.viewComponent)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_MATCH_READY_DONE] = function(arg_16_0, arg_16_1)
		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_KICK_DONE] = function(arg_17_0, arg_17_1)
		existCall = var_2_10002

		var_2_10002(arg_17_0.viewComponent.RefreshUI, arg_17_0.viewComponent)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0
		local var_18_1 = arg_18_0.sendNotification

		GAME = var_2_10004

		var_18_1(var_18_0, var_2_10004.PLAY_ROOM_EXIT_ROOM)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_REFRESH_ROOM_INFO_DONE] = function()
		getProxy = var_2_10000
		PlayRoomProxy = var_2_10001

		local var_19_0 = var_2_10000(var_2_10001)

		if var_0.GetRoomData(var_19_0) then
			local var_19_1 = var_0.roomState

			PlayRoomConst = var_2_10002

			local var_19_2

			if var_19_1 == var_2_10002.PLAY_ROOM_STATE.PLAYING then
				IslandCheaterTavernRecordTools = var_19_1

				var_19_1.StartGame()

				var_19_2 = arg_11_0

				local var_19_3 = var_1.sendNotification

				GAME = var_2_10003
				var_2_10003 = var_2_10003.PLAY_ROOM_LOAD_MINIGAME_SCENE
				var_2_10004 = {
					isReconecting = true
				}
				IslandConst = var_2_10005
				var_2_10004.mapId = var_2_10005.CheaterTavernMapId

				var_19_3(var_19_2, var_2_10003, var_2_10004)
			else
				local var_19_4 = var_0.roomType

				PlayRoomConst = var_19_2

				if var_19_4 ~= var_19_2.PLAY_ROOM_TYPE.MATCH then
					local var_19_5 = arg_11_0
					local var_19_6 = var_1.sendNotification

					CheaterTavernEvent = var_2_10003

					local var_19_7 = var_2_10003.PLAY_ROOM_LOAD_ROOM_SCENE

					IslandCheaterTavernConst = var_2_10004

					var_19_6(var_19_5, var_19_7, var_2_10004.SceneRoomType.CustomRoom)
				end
			end
		end

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_EXIT_ROOM_DONE] = function()
		existCall = var_2_10000

		var_2_10000(arg_11_0.viewComponent.OnStopMatch, arg_11_0.viewComponent)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_QUICK_MATCH_DONE] = function()
		existCall = var_2_10000

		var_2_10000(arg_11_0.viewComponent.OnQuickMatch, arg_11_0.viewComponent)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_QUICK_MATCH_SUCCESS] = function()
		existCall = var_2_10000

		var_2_10000(arg_11_0.viewComponent.OnQuickMatchSuccess, arg_11_0.viewComponent)

		return
	end

	return var_11_0
end

return var_0_1
