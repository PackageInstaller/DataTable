local ChatRoomMediator = class("ChatRoomMediator", import("..base.ContextMediator"))

ChatRoomMediator.SEND_FRIEND_MSG = "ChatRoomMediator:SEND_FRIEND_MSG"
ChatRoomMediator.FETCH_FRIEND_MSG = "ChatRoomMediator:FETCH_FRIEND_MSG"
ChatRoomMediator.CLEAR_UNREADCOUNT = "ChatRoomMediator:CLEAR_UNREADCOUNT"
ChatRoomMediator.OPEN_EMOJI = "ChatRoomMediator:OPEN_EMOJI"

function ChatRoomMediator:register()
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	self.viewComponent:setFriendVO(self.contextData.friendVO)

	self.friendProxy = getProxy(FriendProxy)

	self:bind(ChatRoomMediator.SEND_FRIEND_MSG, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.FRIEND_SEND_MSG, {
			playerId = arg_2_1,
			msg = arg_2_2
		})

		return
	end)
	self:bind(ChatRoomMediator.FETCH_FRIEND_MSG, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.FRIEND_FETCH_MSG, arg_3_1)

		return
	end)
	self:bind(ChatRoomMediator.CLEAR_UNREADCOUNT, function(arg_4_0, arg_4_1)
		local var_4_0 = self.friendProxy:getFriend(arg_4_1)

		if var_4_0:hasUnreadMsg() then
			var_4_0:resetUnreadCount()
			self.friendProxy:updateFriend(var_4_0)
		end

		return
	end)
	self:bind(ChatRoomMediator.OPEN_EMOJI, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(Context.New({
			viewComponent = EmojiLayer,
			mediator = EmojiMediator,
			data = {
				callback = arg_5_2,
				pos = arg_5_1,
				groupName = self.viewComponent:getGroupName(),
				emojiIconCallback = function(arg_6_0)
					self.viewComponent:insertEmojiToInputText(arg_6_0)

					return
				end
			}
		}))

		return
	end)
	self.viewComponent:setFriends((self.friendProxy:getAllFriends()))
	self.viewComponent:setCacheMsgs((self.friendProxy:getAllCacheMsg()))

	return
end

function ChatRoomMediator:listNotificationInterests()
	return {
		FriendProxy.FRIEND_NEW_MSG,
		FriendProxy.FRIEND_UPDATED
	}
end

function ChatRoomMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == FriendProxy.FRIEND_NEW_MSG then
		self.viewComponent:setCacheMsgs(self.friendProxy:getAllCacheMsg())
		self.viewComponent:appendMsg(var_8_1)
	elseif var_8_0 == FriendProxy.FRIEND_UPDATED then
		self.viewComponent:updateFriendVO(var_8_1)
	end

	return
end

return ChatRoomMediator
