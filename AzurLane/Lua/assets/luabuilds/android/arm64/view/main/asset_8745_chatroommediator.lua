class = var_0_10000

local var_0_0 = "ChatRoomMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.SEND_FRIEND_MSG = "ChatRoomMediator:SEND_FRIEND_MSG"
var_0_1.FETCH_FRIEND_MSG = "ChatRoomMediator:FETCH_FRIEND_MSG"
var_0_1.CLEAR_UNREADCOUNT = "ChatRoomMediator:CLEAR_UNREADCOUNT"
var_0_1.OPEN_EMOJI = "ChatRoomMediator:OPEN_EMOJI"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)

	local var_1_3 = arg_1_0.contextData.friendVO
	local var_1_4 = arg_1_0.viewComponent

	var_4.setFriendVO(var_1_4, var_1_3)

	getProxy = var_4
	FriendProxy = var_1_4
	arg_1_0.friendProxy = var_4(var_1_4)

	local var_1_5 = arg_1_0.friendProxy
	local var_1_6 = var_4.getAllFriends(var_1_5)
	local var_1_7 = arg_1_0.friendProxy
	local var_1_8 = var_5.getAllCacheMsg(var_1_7)

	arg_1_0:bind(var_0_1.SEND_FRIEND_MSG, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.FRIEND_SEND_MSG, {
			playerId = arg_2_1,
			msg = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.FETCH_FRIEND_MSG, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.FRIEND_FETCH_MSG, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.CLEAR_UNREADCOUNT, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0.friendProxy
		local var_4_1 = var_2.getFriend(var_4_0, arg_4_1)

		if var_2.hasUnreadMsg(var_4_1) then
			var_2:resetUnreadCount()

			local var_4_2 = arg_1_0.friendProxy

			var_3.updateFriend(var_4_2, var_2)
		end

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EMOJI, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_5_2 = var_2_10006.New
		local var_5_3 = {}

		EmojiLayer = var_2_10009
		var_5_3.viewComponent = var_2_10009
		EmojiMediator = var_2_10009
		var_5_3.mediator = var_2_10009

		local var_5_4 = {
			callback = arg_5_2,
			pos = arg_5_1
		}
		local var_5_5 = arg_1_0.viewComponent

		var_5_4.groupName = var_10.getGroupName(var_5_5)

		function var_5_4.emojiIconCallback(arg_6_0)
			local var_6_0 = arg_1_0.viewComponent

			var_1.insertEmojiToInputText(var_6_0, arg_6_0)

			return
		end

		var_5_3.data = var_5_4

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	local var_1_9 = arg_1_0.viewComponent

	var_6.setFriends(var_1_9, var_1_6)

	local var_1_10 = arg_1_0.viewComponent

	var_6.setCacheMsgs(var_1_10, var_1_8)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	FriendProxy = var_1_10002
	var_7_0[1] = var_1_10002.FRIEND_NEW_MSG
	FriendProxy = var_2
	var_7_0[2] = var_2.FRIEND_UPDATED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	FriendProxy = var_8_0

	local var_8_4

	if var_8_1 == var_8_0.FRIEND_NEW_MSG then
		local var_8_3 = arg_8_0.viewComponent

		var_8_4 = var_8_4.setCacheMsgs

		local var_8_5 = arg_8_0.friendProxy

		var_8_4(var_8_3, var_7.getAllCacheMsg(var_8_5))

		local var_8_6 = arg_8_0.viewComponent

		var_8_4.appendMsg(var_8_6, var_8_2)
	else
		FriendProxy = var_8_4

		if var_8_1 == var_8_4.FRIEND_UPDATED then
			local var_8_7 = arg_8_0.viewComponent

			var_4.updateFriendVO(var_8_7, var_8_2)
		end
	end

	return
end

return var_0_1
