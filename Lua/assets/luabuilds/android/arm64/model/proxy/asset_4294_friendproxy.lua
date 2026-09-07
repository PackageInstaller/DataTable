local FriendProxy = class("FriendProxy", import(".NetProxy"))

FriendProxy.FRIEND_ADDED = "FriendProxy friend added"
FriendProxy.FRIEND_REMOVED = "FriendProxy friend removed"
FriendProxy.FRIEND_NEW_MSG = "FriendProxy friend new msg"
FriendProxy.FRIEND_UPDATED = "FriendProxy friend updated"
FriendProxy.RELIEVE_BLACKLIST = "FriendProxy relieve blacklist"
FriendProxy.ADD_INTO_BLACKLIST = "FriendProxy add into blacklist"
FriendProxy.BLACK_LIST_UPDATED = "FriendProxy black list updated"

function FriendProxy:register()
	self:on(50000, function(arg_2_0)
		self.data = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.friend_list) do
			local var_2_0 = Friend.New(iter_2_1)

			self.data[var_2_0.id] = {
				player = var_2_0,
				cacheMsgs = {}
			}
		end

		return
	end)
	self:on(50008, function(arg_3_0)
		local var_3_0 = Friend.New(arg_3_0.player)

		if not self.data[var_3_0.id] then
			self:addFriend(var_3_0)
		else
			self:updateFriend(var_3_0)
		end

		return
	end)
	self:on(50013, function(arg_4_0)
		self:removeFriend(arg_4_0.id)

		return
	end)
	self:on(50104, function(arg_5_0)
		local var_5_0 = ChatMsg.New(ChatConst.ChannelFriend, {
			player = Player.New(arg_5_0.msg.player),
			content = arg_5_0.msg.content,
			timestamp = arg_5_0.msg.timestamp
		})

		self:addChatMsg(var_5_0.playerId, var_5_0)

		local var_5_1 = self:getFriend(var_5_0.playerId)

		var_5_1:increaseUnreadCount()
		self:updateFriend(var_5_1)

		return
	end)

	return
end

function FriendProxy:removeFriend(arg_6_1)
	if self.data[arg_6_1] then
		self.data[arg_6_1] = nil

		self:sendNotification(FriendProxy.FRIEND_REMOVED, self.data[arg_6_1].player)
	else
		print("不存在的好友: " .. arg_6_1)
	end

	return
end

function FriendProxy:getAllFriends()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.data) do
		table.insert(var_7_0, iter_7_1.player)
	end

	return Clone(var_7_0)
end

function FriendProxy:getAllCacheMsg()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.data) do
		var_8_0[iter_8_1.player.id] = iter_8_1.cacheMsgs
	end

	return Clone(var_8_0)
end

function FriendProxy:getCacheMsgList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.data) do
		underscore.each(iter_9_1.cacheMsgs, function(arg_10_0)
			table.insert(var_9_0, arg_10_0)

			return
		end)
	end

	return var_9_0
end

function FriendProxy:getFriend(arg_11_1)
	if self.data[arg_11_1] then
		return self.data[arg_11_1].player:clone(), self.data[arg_11_1].cacheMsgs
	end

	return
end

function FriendProxy:addChatMsg(arg_12_1, arg_12_2)
	assert(isa(arg_12_2, ChatMsg), "should be an instance of ChatMsg")

	if self.data[arg_12_1] then
		local var_12_0, var_12_1 = wordVer(arg_12_2.content, {
			isReplace = true
		})
		local var_12_2

		string.gsub(var_12_1, ChatConst.EmojiCodeMatch, function(arg_13_0)
			var_12_2 = tonumber(arg_13_0)

			return
		end)

		if var_12_2 then
			if pg.emoji_template[var_12_2] then
				var_12_1 = pg.emoji_template[var_12_2].desc
			else
				var_12_2 = nil
			end
		end

		arg_12_2.content = var_12_1
		arg_12_2.emojiId = var_12_2

		table.insert(self.data[arg_12_1].cacheMsgs, arg_12_2)
		arg_12_2:display("added")
		self:sendNotification(FriendProxy.FRIEND_NEW_MSG, arg_12_2)
	end

	return
end

function FriendProxy:addFriend(arg_14_1)
	assert(not self.data[arg_14_1.id], "friend already eixst" .. arg_14_1.id)
	arg_14_1:display("added")

	self.data[arg_14_1.id] = {
		player = arg_14_1,
		cacheMsgs = {}
	}

	self:sendNotification(FriendProxy.FRIEND_ADDED, arg_14_1:clone())

	return
end

function FriendProxy:updateFriend(arg_15_1)
	assert(self.data[arg_15_1.id], "friend should eixst" .. arg_15_1.id)

	self.data[arg_15_1.id].player = arg_15_1

	self:sendNotification(FriendProxy.FRIEND_UPDATED, arg_15_1:clone())

	return
end

function FriendProxy:isFriend(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self.data) do
		if iter_16_0 == arg_16_1 then
			return true
		end
	end

	return false
end

function FriendProxy:getFriendCount()
	return table.getCount(self.data or {})
end

function FriendProxy:getNewMsgCount()
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(self.data) do
		if iter_18_1.player.unreadCount > 0 then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function FriendProxy:setBlackList(arg_19_1)
	self.blackList = arg_19_1

	self:sendNotification(FriendProxy.BLACK_LIST_UPDATED, Clone(arg_19_1))

	return
end

function FriendProxy:getBlackList()
	return Clone(self.blackList)
end

function FriendProxy:relieveBlackListById(arg_21_1)
	assert(self.blackList[arg_21_1], "friend should eixst>>" .. arg_21_1)

	self.blackList[arg_21_1] = nil

	self:sendNotification(FriendProxy.RELIEVE_BLACKLIST, arg_21_1)

	return
end

function FriendProxy:getBlackPlayerById(arg_22_1)
	return self.blackList and Clone(self.blackList[arg_22_1])
end

function FriendProxy:addIntoBlackList(arg_23_1)
	if self.blackList then
		self.blackList[arg_23_1.id] = arg_23_1

		self:sendNotification(FriendProxy.ADD_INTO_BLACKLIST, Clone(arg_23_1))
	end

	return
end

function FriendProxy:isInBlackList(arg_24_1)
	if self.blackList then
		return self.blackList[arg_24_1]
	end

	return
end

return FriendProxy
