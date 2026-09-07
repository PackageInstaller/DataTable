local PlayRoomNotificationMediator = class("PlayRoomNotificationMediator", import("..base.ContextMediator"))

PlayRoomNotificationMediator.SEND_CHAT = "PlayRoomNotificationMediator.SEND_CHAT"
PlayRoomNotificationMediator.CHANGE_CHAT_ROOM = "PlayRoomNotificationMediator.CHANGE_CHAT_ROOM"
PlayRoomNotificationMediator.OPEN_FRIEND_INFO = "PlayRoomNotificationMediator.OPEN_FRIEND_INFO"
PlayRoomNotificationMediator.OPEN_EMOJI = "PlayRoomNotificationMediator.OPEN_EMOJI"

function PlayRoomNotificationMediator:register()
	self:bind(PlayRoomNotificationMediator.OPEN_FRIEND_INFO, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self.friendInfoPosition = arg_2_2
		self.friendInfoMsg = arg_2_3

		self:sendNotification(GAME.OPEN_FRIEND_INFO_DONE, arg_2_2)
		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_2_1
		})

		return
	end)
	self:bind(PlayRoomNotificationMediator.CHANGE_CHAT_ROOM, function(arg_3_0, arg_3_1)
		if not arg_3_1 then
			return
		end

		if arg_3_1 <= 0 or arg_3_1 == "" then
			return
		end

		self:sendNotification(GAME.CHANGE_CHAT_ROOM, arg_3_1)

		return
	end)
	self:bind(PlayRoomNotificationMediator.SEND_CHAT, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.PLAY_ROOM_SEND_CHAT, {
			channel = arg_4_1,
			type = self.contextData.inRoom and 1 or 2,
			msg = arg_4_2
		})

		return
	end)
	self:bind(PlayRoomNotificationMediator.OPEN_EMOJI, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			viewComponent = EmojiLayer,
			mediator = EmojiMediator,
			data = arg_5_1
		}))

		return
	end)

	return
end

function PlayRoomNotificationMediator:initNotificationHandleDic()
	self.handleDic = {
		[ChatProxy.NEW_MSG] = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_7_1:getBody()

			arg_7_0.viewComponent:Flush(true)

			return
		end,
		[FriendProxy.FRIEND_NEW_MSG] = function(arg_8_0, arg_8_1)
			local var_8_0 = arg_8_1:getBody()

			arg_8_0.viewComponent:Flush(true)

			return
		end,
		[GuildProxy.NEW_MSG_ADDED] = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_1:getBody()

			arg_9_0.viewComponent:Flush(true)

			return
		end,
		[PlayRoomProxy.CHAT_MSG_UPDATE] = function(arg_10_0, arg_10_1)
			local var_10_0 = arg_10_1:getBody()

			arg_10_0.viewComponent:Flush(true)

			return
		end,
		[GAME.CHANGE_CHAT_ROOM_DONE] = function(arg_11_0, arg_11_1)
			arg_11_0.viewComponent:Flush()

			return
		end
	}

	return
end

return PlayRoomNotificationMediator
