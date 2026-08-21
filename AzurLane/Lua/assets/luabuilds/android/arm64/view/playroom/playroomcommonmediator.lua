local var_0_0 = class("PlayRoomCommonMediator", import("view.base.ContextMediator"))

var_0_0.ON_CLICK_MATCH = "PlayRoomCommonMediator::ON_CLICK_MATCH"
var_0_0.REFRESH_ROOM_INFO = "PlayRoomCommonMediator::REFRESH_ROOM_INFO"
var_0_0.PLAY_ROOM_MATCH_STOP = "PlayRoomCommonMediator::PLAY_ROOM_MATCH_STOP"
var_0_0.ON_CLICK_READY = "PlayRoomCommonMediator::ON_CLICK_READY"
var_0_0.ON_MATCH_CLICK_READY = "PlayRoomCommonMediator::ON_MATCH_CLICK_READY"
var_0_0.ON_CLICK_QUICK_MATCH = "PlayRoomCommonMediator::ON_CLICK_QUICK_MATCH"

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)
	arg_1_0:AppendPlayRoomNotificationHandleDic()

	return
end

function var_0_0.onRegister(arg_2_0)
	var_0_0.super.onRegister(arg_2_0)
	arg_2_0:registerPlayRoom()

	return
end

function var_0_0.AppendPlayRoomNotificationHandleDic(arg_3_0)
	if arg_3_0.handleDic == nil then
		return
	end

	for iter_3_0, iter_3_1 in pairs((arg_3_0:initNotificationHandleDicPlayRoom())) do
		if arg_3_0.handleDic[iter_3_0] == nil then
			arg_3_0.handleDic[iter_3_0] = iter_3_1
		end
	end

	return
end

function var_0_0.registerPlayRoom(arg_4_0)
	arg_4_0:bind(var_0_0.ON_CLICK_MATCH, function(arg_5_0, arg_5_1)
		arg_4_0:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM, arg_5_1)

		return
	end)
	arg_4_0:bind(var_0_0.REFRESH_ROOM_INFO, function(arg_6_0)
		arg_4_0:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM_INFO)

		return
	end)
	arg_4_0:bind(var_0_0.PLAY_ROOM_MATCH_STOP, function(arg_7_0)
		arg_4_0:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM, {
			arg = 0
		})

		return
	end)
	arg_4_0:bind(var_0_0.ON_CLICK_READY, function(arg_8_0, arg_8_1)
		arg_4_0:sendNotification(GAME.PLAY_ROOM_READY, arg_8_1)

		return
	end)
	arg_4_0:bind(var_0_0.ON_MATCH_CLICK_READY, function(arg_9_0, arg_9_1)
		arg_4_0:sendNotification(GAME.PLAY_ROOM_MATCH_READY, arg_9_1)

		return
	end)
	arg_4_0:bind(var_0_0.ON_CLICK_QUICK_MATCH, function(arg_10_0, arg_10_1)
		arg_4_0:sendNotification(GAME.PLAY_ROOM_QUICK_MATCH, arg_10_1)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDicPlayRoom(arg_11_0)
	return {
		[GAME.PLAY_ROOM_CREATE_ROOM_DONE] = function()
			if getProxy(PlayRoomProxy):GetRoomData().roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
				arg_11_0:sendNotification(GAME.PLAY_ROOM_START_GAME)
				existCall(arg_11_0.viewComponent.OnStartMatch, arg_11_0.viewComponent)
			end

			return
		end,
		[GAME.PLAY_ROOM_START_GAME_DONE] = function()
			return
		end,
		[GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function()
			return
		end,
		[GAME.PLAY_ROOM_READY_DONE] = function(arg_15_0, arg_15_1)
			existCall(arg_15_0.viewComponent.RefreshUI, arg_15_0.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_MATCH_READY_DONE] = function(arg_16_0, arg_16_1)
			return
		end,
		[GAME.PLAY_ROOM_KICK_DONE] = function(arg_17_0, arg_17_1)
			existCall(arg_17_0.viewComponent.RefreshUI, arg_17_0.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function(arg_18_0, arg_18_1)
			arg_18_0:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM)

			return
		end,
		[GAME.PLAY_ROOM_REFRESH_ROOM_INFO_DONE] = function()
			local var_19_0 = getProxy(PlayRoomProxy):GetRoomData()

			if var_19_0 then
				if var_19_0.roomState == PlayRoomConst.PLAY_ROOM_STATE.PLAYING then
					IslandCheaterTavernRecordTools.StartGame()
					arg_11_0:sendNotification(GAME.PLAY_ROOM_LOAD_MINIGAME_SCENE, {
						isReconecting = true,
						mapId = IslandConst.CheaterTavernMapId
					})
				elseif var_19_0.roomType ~= PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
					arg_11_0:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)
				end
			end

			return
		end,
		[GAME.PLAY_ROOM_EXIT_ROOM_DONE] = function()
			existCall(arg_11_0.viewComponent.OnStopMatch, arg_11_0.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_QUICK_MATCH_DONE] = function()
			existCall(arg_11_0.viewComponent.OnQuickMatch, arg_11_0.viewComponent)

			return
		end,
		[GAME.PLAY_ROOM_QUICK_MATCH_SUCCESS] = function()
			existCall(arg_11_0.viewComponent.OnQuickMatchSuccess, arg_11_0.viewComponent)

			return
		end
	}
end

return var_0_0
