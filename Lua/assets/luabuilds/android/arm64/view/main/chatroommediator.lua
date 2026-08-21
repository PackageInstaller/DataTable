local var_0_0 = class("ChatRoomMediator", import("..base.ContextMediator"))

var_0_0.SEND_FRIEND_MSG = "ChatRoomMediator:SEND_FRIEND_MSG"
var_0_0.FETCH_FRIEND_MSG = "ChatRoomMediator:FETCH_FRIEND_MSG"
var_0_0.CLEAR_UNREADCOUNT = "ChatRoomMediator:CLEAR_UNREADCOUNT"
var_0_0.OPEN_EMOJI = "ChatRoomMediator:OPEN_EMOJI"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	arg_1_0.viewComponent:setFriendVO(arg_1_0.contextData.friendVO)

	arg_1_0.friendProxy = getProxy(FriendProxy)

	arg_1_0:bind(var_0_0.SEND_FRIEND_MSG, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.FRIEND_SEND_MSG, {
			playerId = arg_2_1,
			msg = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.FETCH_FRIEND_MSG, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.FRIEND_FETCH_MSG, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.CLEAR_UNREADCOUNT, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0.friendProxy:getFriend(arg_4_1)

		if var_4_0:hasUnreadMsg() then
			var_4_0:resetUnreadCount()
			arg_1_0.friendProxy:updateFriend(var_4_0)
		end

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EMOJI, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = EmojiLayer,
			mediator = EmojiMediator,
			data = {
				callback = arg_5_2,
				pos = arg_5_1,
				groupName = arg_1_0.viewComponent:getGroupName(),
				emojiIconCallback = function(arg_6_0)
					arg_1_0.viewComponent:insertEmojiToInputText(arg_6_0)

					return
				end
			}
		}))

		return
	end)
	arg_1_0.viewComponent:setFriends((arg_1_0.friendProxy:getAllFriends()))
	arg_1_0.viewComponent:setCacheMsgs((arg_1_0.friendProxy:getAllCacheMsg()))

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		FriendProxy.FRIEND_NEW_MSG,
		FriendProxy.FRIEND_UPDATED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == FriendProxy.FRIEND_NEW_MSG then
		arg_8_0.viewComponent:setCacheMsgs(arg_8_0.friendProxy:getAllCacheMsg())
		arg_8_0.viewComponent:appendMsg(var_8_1)
	elseif var_8_0 == FriendProxy.FRIEND_UPDATED then
		arg_8_0.viewComponent:updateFriendVO(var_8_1)
	end

	return
end

return var_0_0
