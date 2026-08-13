class = var_0_10000

local var_0_0 = "PlayRoomNotificationMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.SEND_CHAT = "PlayRoomNotificationMediator.SEND_CHAT"
var_0_1.CHANGE_CHAT_ROOM = "PlayRoomNotificationMediator.CHANGE_CHAT_ROOM"
var_0_1.OPEN_FRIEND_INFO = "PlayRoomNotificationMediator.OPEN_FRIEND_INFO"
var_0_1.OPEN_EMOJI = "PlayRoomNotificationMediator.OPEN_EMOJI"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_FRIEND_INFO, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0.friendInfoPosition = arg_2_2
		arg_1_0.friendInfoMsg = arg_2_3

		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.OPEN_FRIEND_INFO_DONE, arg_2_2)

		local var_2_2 = arg_1_0
		local var_2_3 = var_4.sendNotification

		GAME = var_6

		local var_2_4 = var_6.FRIEND_SEARCH
		local var_2_5 = {}

		SearchFriendCommand = var_2_10008
		var_2_5.type = var_2_10008.SEARCH_TYPE_RESUME
		var_2_5.keyword = arg_2_1

		var_2_3(var_2_2, var_2_4, var_2_5)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_CHAT_ROOM, function(arg_3_0, arg_3_1)
		if not arg_3_1 then
			return
		end

		if arg_3_1 <= 0 or arg_3_1 == "" then
			return
		end

		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.CHANGE_CHAT_ROOM, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.SEND_CHAT, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.PLAY_ROOM_SEND_CHAT, {
			channel = arg_4_1,
			type = arg_1_0.contextData.inRoom and 1 or 2,
			msg = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EMOJI, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		EmojiLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		EmojiMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		var_5_3.data = arg_5_1

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_6_0)
	local var_6_0 = {}

	ChatProxy = var_1_10002
	var_6_0[var_1_10002.NEW_MSG] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1:getBody()
		local var_7_1 = arg_7_0.viewComponent

		var_3.Flush(var_7_1, true)

		return
	end
	FriendProxy = var_2
	var_6_0[var_2.FRIEND_NEW_MSG] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1:getBody()
		local var_8_1 = arg_8_0.viewComponent

		var_3.Flush(var_8_1, true)

		return
	end
	GuildProxy = var_2
	var_6_0[var_2.NEW_MSG_ADDED] = function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1:getBody()
		local var_9_1 = arg_9_0.viewComponent

		var_3.Flush(var_9_1, true)

		return
	end
	PlayRoomProxy = var_2
	var_6_0[var_2.CHAT_MSG_UPDATE] = function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1:getBody()
		local var_10_1 = arg_10_0.viewComponent

		var_3.Flush(var_10_1, true)

		return
	end
	GAME = var_2
	var_6_0[var_2.CHANGE_CHAT_ROOM_DONE] = function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.viewComponent

		var_2.Flush(var_11_0)

		return
	end
	arg_6_0.handleDic = var_6_0

	return
end

return var_0_1
