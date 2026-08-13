class = var_0_10000

local var_0_0 = "PlayRoomMainMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.REFRESH_ROOM_LIST = "PlayRoomMainMediator:REFRESH_ROOM_LIST"
var_0_1.CREATE_ROOM = "PlayRoomMainMediator:CREATE_ROOM"
var_0_1.JOIN_ROOM = "PlayRoomMainMediator:JOIN_ROOM"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.REFRESH_ROOM_LIST, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.PLAY_ROOM_REFRESH_ROOM)

		return
	end)
	arg_1_0:bind(var_0_1.CREATE_ROOM, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.PLAY_ROOM_CREATE_ROOM, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.JOIN_ROOM, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.PLAY_ROOM_JOIN_ROOM, arg_4_1)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[var_1_10002.PLAY_ROOM_REFRESH_ROOM_DONE] = function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_1:getName()
		local var_6_1 = arg_6_1:getBody()
		local var_6_2 = arg_6_0.viewComponent

		var_4.RefreshUI(var_6_2)

		return
	end
	GAME = var_2
	var_5_0[var_2.PLAY_ROOM_CREATE_ROOM_DONE] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.viewComponent

		var_2.OnCreateRoomOver(var_7_0)

		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.sendNotification

		CheaterTavernEvent = var_2_10004

		local var_7_3 = var_2_10004.PLAY_ROOM_LOAD_ROOM_SCENE

		IslandCheaterTavernConst = var_2_10005

		var_7_2(var_7_1, var_7_3, var_2_10005.SceneRoomType.CustomRoom)

		return
	end
	GAME = var_2
	var_5_0[var_2.PLAY_ROOM_JOIN_ROOM_DONE] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.sendNotification

		CheaterTavernEvent = var_2_10004

		local var_8_2 = var_2_10004.PLAY_ROOM_LOAD_ROOM_SCENE

		IslandCheaterTavernConst = var_2_10005

		var_8_1(var_8_0, var_8_2, var_2_10005.SceneRoomType.CustomRoom)

		return
	end
	GAME = var_2
	var_5_0[var_2.PLAY_ROOM_JOIN_ROOM_QUICK_FAIL] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.viewComponent

		var_2.OnQuickRoomFail(var_9_0)

		return
	end
	GAME = var_2
	var_5_0[var_2.PLAY_ROOM_ALL_LOAD_OVER] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0.viewComponent

		var_2.closeView(var_10_0)

		return
	end
	arg_5_0.handleDic = var_5_0

	return
end

function var_0_1.remove(arg_11_0)
	return
end

return var_0_1
