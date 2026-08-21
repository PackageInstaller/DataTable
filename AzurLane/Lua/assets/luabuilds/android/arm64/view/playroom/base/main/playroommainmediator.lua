local var_0_0 = class("PlayRoomMainMediator", import("view.base.ContextMediator"))

var_0_0.REFRESH_ROOM_LIST = "PlayRoomMainMediator:REFRESH_ROOM_LIST"
var_0_0.CREATE_ROOM = "PlayRoomMainMediator:CREATE_ROOM"
var_0_0.JOIN_ROOM = "PlayRoomMainMediator:JOIN_ROOM"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.REFRESH_ROOM_LIST, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_REFRESH_ROOM)

		return
	end)
	arg_1_0:bind(var_0_0.CREATE_ROOM, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.JOIN_ROOM, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.PLAY_ROOM_JOIN_ROOM, arg_4_1)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_5_0)
	arg_5_0.handleDic = {
		[GAME.PLAY_ROOM_REFRESH_ROOM_DONE] = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1:getName()
			local var_6_1 = arg_6_1:getBody()

			arg_6_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.PLAY_ROOM_CREATE_ROOM_DONE] = function(arg_7_0, arg_7_1)
			arg_7_0.viewComponent:OnCreateRoomOver()
			arg_7_0:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)

			return
		end,
		[GAME.PLAY_ROOM_JOIN_ROOM_DONE] = function(arg_8_0, arg_8_1)
			arg_8_0:sendNotification(CheaterTavernEvent.PLAY_ROOM_LOAD_ROOM_SCENE, IslandCheaterTavernConst.SceneRoomType.CustomRoom)

			return
		end,
		[GAME.PLAY_ROOM_JOIN_ROOM_QUICK_FAIL] = function(arg_9_0, arg_9_1)
			arg_9_0.viewComponent:OnQuickRoomFail()

			return
		end,
		[GAME.PLAY_ROOM_ALL_LOAD_OVER] = function(arg_10_0, arg_10_1)
			arg_10_0.viewComponent:closeView()

			return
		end
	}

	return
end

function var_0_0.remove(arg_11_0)
	return
end

return var_0_0
