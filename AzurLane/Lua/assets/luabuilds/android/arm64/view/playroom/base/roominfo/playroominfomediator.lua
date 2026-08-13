class = var_0_10000

local var_0_0 = "PlayRoomInfoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_CLICK_VIEWER = "PlayRoomInfoMediator::ON_CLICK_VIEWER"
var_0_1.ON_CLICK_READY = "PlayRoomInfoMediator::ON_CLICK_READY"
var_0_1.ON_CLICK_KICK = "PlayRoomInfoMediator::ON_CLICK_KICK"
var_0_1.ON_CLICK_INVITE = "PlayRoomInfoMediator::ON_CLICK_INVITE"
var_0_1.ON_CLICK_CLOSE = "PlayRoomInfoMediator::ON_CLICK_CLOSE"
var_0_1.ON_CLICK_START_GAME = "PlayRoomInfoMediaotr::ON_CLICK_START_GAME"
var_0_1.ON_CLICK_CHANGE_CHARACTER = "PlayRoomInfoMediaotr::ON_CLICK_CHANGE_CHARACTER"
var_0_1.ON_SWITCH_ROOM_TYPE = "PlayRoomInfoMediator.ON_SWITCH_ROOM_TYPE"
var_0_1.ON_MATCH_CLICK_READY = "PlayRoomInfoMediaotr:ON_MATCH_CLICK_READY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_CLICK_VIEWER, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		PlayRoomInfoViewerMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		PlayRoomInfoViewerScene = var_2_10006
		var_2_3.viewComponent = var_2_10006

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_INVITE, function()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.addSubLayers

		Context = var_2_10003

		local var_3_2 = var_2_10003.New
		local var_3_3 = {}

		PlayRoomInfoInviteMediator = var_2_10006
		var_3_3.mediator = var_2_10006
		PlayRoomInfoInviteScene = var_2_10006
		var_3_3.viewComponent = var_2_10006

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_READY, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.PLAY_ROOM_READY, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_KICK, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.PLAY_ROOM_KICK, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_CLOSE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.PLAY_ROOM_EXIT_ROOM)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_START_GAME, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.PLAY_ROOM_START_GAME)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLICK_CHANGE_CHARACTER, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		CheaterTavernEvent = var_2_10005

		local var_8_2 = var_2_10005.OPEN_SELECT_SHIP

		IslandCheaterTavernConst = var_2_10006

		var_8_1(var_8_0, var_8_2, var_2_10006.ChangeDressType.InRoom)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SWITCH_ROOM_TYPE, function(arg_9_0)
		local var_9_0 = arg_1_0
		local var_9_1 = var_1.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.PLAY_ROOM_SWITCH_ROOM_TYPE)

		return
	end)
	arg_1_0:bind(var_0_1.ON_MATCH_CLICK_READY, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10005

		var_10_1(var_10_0, var_2_10005.PLAY_ROOM_MATCH_READY, arg_10_1)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_11_0)
	local var_11_0 = {}

	GAME = var_1_10002
	var_11_0[var_1_10002.PLAY_ROOM_READY_DONE] = function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0.viewComponent

		var_2.RefreshUI(var_12_0)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_SWITCH_VIEWER_DONE] = function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0.viewComponent

		var_2.RefreshUI(var_13_0)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_KICK_DONE] = function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.viewComponent

		var_2.RefreshUI(var_14_0)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_EXIT_ROOM_DONE] = function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0.viewComponent

		var_2.closeView(var_15_0)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_START_GAME_DONE] = function(arg_16_0, arg_16_1)
		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_REDAY_ROOM_REFRESH] = function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0.viewComponent

		var_2.RefreshUI(var_17_0)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_MATCH_READY_DONE] = function(arg_18_0, arg_18_1)
		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH] = function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0.viewComponent

		var_2.RefreshMatchInfoUI(var_19_0)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_EXIT_MATCH_READY_ROOM] = function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0
		local var_20_1 = arg_20_0.sendNotification

		GAME = var_2_10005

		var_20_1(var_20_0, var_2_10005.PLAY_ROOM_EXIT_ROOM)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_CLOSE_MATCH_READY] = function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_0
		local var_21_1 = arg_21_0.sendNotification

		GAME = var_2_10005

		local var_21_2 = var_2_10005.PLAY_ROOM_LOAD_MINIGAME_SCENE
		local var_21_3 = {}

		IslandConst = var_2_10007
		var_21_3.mapId = var_2_10007.CheaterTavernMapId

		var_21_1(var_21_0, var_21_2, var_21_3)

		local var_21_4 = arg_21_0.viewComponent

		var_2.EnterLoadInfoUI(var_21_4)

		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_ALL_LOAD_OVER] = function(arg_22_0, arg_22_1)
		return
	end
	GAME = var_2
	var_11_0[var_2.PLAY_ROOM_SWITCH_ROOM_TYPE_DONE] = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0.viewComponent

		var_2.RefreshUI(var_23_0)

		return
	end
	ChatProxy = var_2
	var_11_0[var_2.NEW_MSG] = function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0.viewComponent

		var_2.RefreshMessage(var_24_0)

		return
	end
	FriendProxy = var_2
	var_11_0[var_2.FRIEND_NEW_MSG] = function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0.viewComponent

		var_2.RefreshMessage(var_25_0)

		return
	end
	GuildProxy = var_2
	var_11_0[var_2.NEW_MSG_ADDED] = function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0.viewComponent

		var_2.RefreshMessage(var_26_0)

		return
	end
	PlayRoomProxy = var_2
	var_11_0[var_2.CHAT_MSG_UPDATE] = function(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_0.viewComponent

		var_2.RefreshMessage(var_27_0)

		return
	end
	GAME = var_2
	var_11_0[var_2.CHANGE_CHAT_ROOM_DONE] = function(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_0.viewComponent

		var_2.RefreshMessage(var_28_0)

		return
	end
	arg_11_0.handleDic = var_11_0

	return
end

function var_0_1.remove(arg_29_0)
	return
end

return var_0_1
