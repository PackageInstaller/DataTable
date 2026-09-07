local NotificationProxy = class("NotificationProxy", import(".NetProxy"))

NotificationProxy.FRIEND_REQUEST_ADDED = "note friend request added"
NotificationProxy.FRIEND_REQUEST_REMOVED = "note friend request removed"

function NotificationProxy:register()
	self:on(50000, function(arg_2_0)
		self.data = {
			requests = {}
		}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.request_list) do
			local var_2_0 = ChatMsg.New(ChatConst.ChannelFriend, {
				player = Player.New(iter_2_1.player),
				content = iter_2_1.content,
				timestamp = iter_2_1.timestamp
			})

			var_2_0:display("request loaded")

			self.data.requests[var_2_0.player.id] = var_2_0
		end

		return
	end)
	self:on(50005, function(arg_3_0)
		local var_3_0 = ChatMsg.New(ChatConst.ChannelFriend, {
			player = Player.New(arg_3_0.msg.player),
			content = arg_3_0.msg.content,
			timestamp = arg_3_0.msg.timestamp
		})

		if not self.data.requests[var_3_0.player.id] then
			self.data.requests[var_3_0.player.id] = var_3_0

			var_3_0:display("new friend")

			if not getProxy(FriendProxy):isInBlackList(var_3_0.player.id) then
				self:sendNotification(NotificationProxy.FRIEND_REQUEST_ADDED, var_3_0:clone())
			end
		end

		return
	end)

	return
end

function NotificationProxy:getRequests()
	local var_4_0 = {}
	local var_4_1 = getProxy(FriendProxy)

	for iter_4_0, iter_4_1 in pairs(self.data.requests or {}) do
		if not var_4_1:isInBlackList(iter_4_0) then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function NotificationProxy:removeRequest(arg_5_1)
	if self.data.requests[arg_5_1] then
		self.data.requests[arg_5_1]:display("removed")

		self.data.requests[arg_5_1] = nil

		self:sendNotification(NotificationProxy.FRIEND_REQUEST_REMOVED, self.data.requests[arg_5_1])
	end

	return
end

function NotificationProxy:removeAllRequest()
	for iter_6_0, iter_6_1 in pairs(self.data.requests) do
		self:removeRequest(iter_6_0)
	end

	return
end

function NotificationProxy:getRequestCount()
	return #self:getRequests()
end

function NotificationProxy:getUnreadCount()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(self.data.requests or {}) do
		var_8_0 = var_8_0 + 1
	end

	return var_8_0
end

function NotificationProxy:RawgetAllMessages()
	local var_9_0 = {}

	_.each(getProxy(ChatProxy):getRawData(), function(arg_10_0)
		table.insert(var_9_0, arg_10_0)

		return
	end)

	local var_9_1 = getProxy(GuildProxy)

	if var_9_1:getRawData() then
		_.each(var_9_1:getChatMsgs(), function(arg_11_0)
			table.insert(var_9_0, arg_11_0)

			return
		end)
	end

	_.each(getProxy(FriendProxy):getCacheMsgList(), function(arg_12_0)
		table.insert(var_9_0, arg_12_0)

		return
	end)

	return var_9_0
end

function NotificationProxy:getAllMessages()
	local var_13_0 = getProxy(FriendProxy)

	return _((self:RawgetAllMessages())):chain():filter(function(arg_14_0)
		return not var_13_0:isInBlackList(arg_14_0.playerId)
	end):sort(function(arg_15_0, arg_15_1)
		return arg_15_0.timestamp < arg_15_1.timestamp
	end):value()
end

return NotificationProxy
