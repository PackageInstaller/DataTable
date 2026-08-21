local var_0_0 = class("FriendProxy", import(".NetProxy"))

var_0_0.FRIEND_ADDED = "FriendProxy friend added"
var_0_0.FRIEND_REMOVED = "FriendProxy friend removed"
var_0_0.FRIEND_NEW_MSG = "FriendProxy friend new msg"
var_0_0.FRIEND_UPDATED = "FriendProxy friend updated"
var_0_0.RELIEVE_BLACKLIST = "FriendProxy relieve blacklist"
var_0_0.ADD_INTO_BLACKLIST = "FriendProxy add into blacklist"
var_0_0.BLACK_LIST_UPDATED = "FriendProxy black list updated"

function var_0_0.register(arg_1_0)
	arg_1_0:on(50000, function(arg_2_0)
		arg_1_0.data = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.friend_list) do
			local var_2_0 = Friend.New(iter_2_1)

			arg_1_0.data[var_2_0.id] = {
				player = var_2_0,
				cacheMsgs = {}
			}
		end

		return
	end)
	arg_1_0:on(50008, function(arg_3_0)
		local var_3_0 = Friend.New(arg_3_0.player)

		if not arg_1_0.data[var_3_0.id] then
			arg_1_0:addFriend(var_3_0)
		else
			arg_1_0:updateFriend(var_3_0)
		end

		return
	end)
	arg_1_0:on(50013, function(arg_4_0)
		arg_1_0:removeFriend(arg_4_0.id)

		return
	end)
	arg_1_0:on(50104, function(arg_5_0)
		local var_5_0 = ChatMsg.New(ChatConst.ChannelFriend, {
			player = Player.New(arg_5_0.msg.player),
			content = arg_5_0.msg.content,
			timestamp = arg_5_0.msg.timestamp
		})

		arg_1_0:addChatMsg(var_5_0.playerId, var_5_0)

		local var_5_1 = arg_1_0:getFriend(var_5_0.playerId)

		var_5_1:increaseUnreadCount()
		arg_1_0:updateFriend(var_5_1)

		return
	end)

	return
end

function var_0_0.removeFriend(arg_6_0, arg_6_1)
	if arg_6_0.data[arg_6_1] then
		arg_6_0.data[arg_6_1] = nil

		arg_6_0:sendNotification(var_0_0.FRIEND_REMOVED, arg_6_0.data[arg_6_1].player)
	else
		print("不存在的好友: " .. arg_6_1)
	end

	return
end

function var_0_0.getAllFriends(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.data) do
		table.insert({}, iter_7_1.player)
	end

	return Clone({})
end

function var_0_0.getAllCacheMsg(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.data) do
		({})[iter_8_1.player.id] = iter_8_1.cacheMsgs
	end

	return Clone({})
end

function var_0_0.getCacheMsgList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.data) do
		underscore.each(iter_9_1.cacheMsgs, function(arg_10_0)
			table.insert(var_9_0, arg_10_0)

			return
		end)
	end

	return {}
end

function var_0_0.getFriend(arg_11_0, arg_11_1)
	if arg_11_0.data[arg_11_1] then
		return arg_11_0.data[arg_11_1].player:clone(), arg_11_0.data[arg_11_1].cacheMsgs
	end

	return
end

function var_0_0.addChatMsg(arg_12_0, arg_12_1, arg_12_2)
	assert(isa(arg_12_2, ChatMsg), "should be an instance of ChatMsg")

	if arg_12_0.data[arg_12_1] then
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

		table.insert(arg_12_0.data[arg_12_1].cacheMsgs, arg_12_2)
		arg_12_2:display("added")
		arg_12_0:sendNotification(var_0_0.FRIEND_NEW_MSG, arg_12_2)
	end

	return
end

function var_0_0.addFriend(arg_14_0, arg_14_1)
	assert(not arg_14_0.data[arg_14_1.id], "friend already eixst" .. arg_14_1.id)
	arg_14_1:display("added")

	arg_14_0.data[arg_14_1.id] = {
		player = arg_14_1,
		cacheMsgs = {}
	}

	arg_14_0:sendNotification(var_0_0.FRIEND_ADDED, arg_14_1:clone())

	return
end

function var_0_0.updateFriend(arg_15_0, arg_15_1)
	assert(arg_15_0.data[arg_15_1.id], "friend should eixst" .. arg_15_1.id)

	arg_15_0.data[arg_15_1.id].player = arg_15_1

	arg_15_0:sendNotification(var_0_0.FRIEND_UPDATED, arg_15_1:clone())

	return
end

function var_0_0.isFriend(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.data) do
		if iter_16_0 == arg_16_1 then
			return true
		end
	end

	return false
end

function var_0_0.getFriendCount(arg_17_0)
	local var_17_0 = arg_17_0.data or {}

	return table.getCount(var_17_0)
end

function var_0_0.getNewMsgCount(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_0.data) do
		if iter_18_1.player.unreadCount > 0 then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_0.setBlackList(arg_19_0, arg_19_1)
	arg_19_0.blackList = arg_19_1

	arg_19_0:sendNotification(var_0_0.BLACK_LIST_UPDATED, Clone(arg_19_1))

	return
end

function var_0_0.getBlackList(arg_20_0)
	return Clone(arg_20_0.blackList)
end

function var_0_0.relieveBlackListById(arg_21_0, arg_21_1)
	assert(arg_21_0.blackList[arg_21_1], "friend should eixst>>" .. arg_21_1)

	arg_21_0.blackList[arg_21_1] = nil

	arg_21_0:sendNotification(var_0_0.RELIEVE_BLACKLIST, arg_21_1)

	return
end

function var_0_0.getBlackPlayerById(arg_22_0, arg_22_1)
	return arg_22_0.blackList and Clone(arg_22_0.blackList[arg_22_1])
end

function var_0_0.addIntoBlackList(arg_23_0, arg_23_1)
	if arg_23_0.blackList then
		arg_23_0.blackList[arg_23_1.id] = arg_23_1

		arg_23_0:sendNotification(var_0_0.ADD_INTO_BLACKLIST, Clone(arg_23_1))
	end

	return
end

function var_0_0.isInBlackList(arg_24_0, arg_24_1)
	if arg_24_0.blackList then
		return arg_24_0.blackList[arg_24_1]
	end

	return
end

return var_0_0
