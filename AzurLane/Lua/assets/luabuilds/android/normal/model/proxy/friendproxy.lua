class = var_0_10000

local var_0_0 = "FriendProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.FRIEND_ADDED = "FriendProxy friend added"
var_0_1.FRIEND_REMOVED = "FriendProxy friend removed"
var_0_1.FRIEND_NEW_MSG = "FriendProxy friend new msg"
var_0_1.FRIEND_UPDATED = "FriendProxy friend updated"
var_0_1.RELIEVE_BLACKLIST = "FriendProxy relieve blacklist"
var_0_1.ADD_INTO_BLACKLIST = "FriendProxy add into blacklist"
var_0_1.BLACK_LIST_UPDATED = "FriendProxy black list updated"

function var_0_1.register(arg_1_0)
	arg_1_0:on(50000, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.data = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.friend_list) do
			Friend = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_1)
			arg_1_0.data[var_2_10006.id] = {
				player = var_2_10006,
				cacheMsgs = {}
			}
		end

		return
	end)
	arg_1_0:on(50008, function(arg_3_0)
		Friend = var_2_10001

		local var_3_0 = var_2_10001.New(arg_3_0.player)

		if not arg_1_0.data[var_3_0.id] then
			local var_3_1 = arg_1_0

			var_2.addFriend(var_3_1, var_3_0)
		else
			local var_3_2 = arg_1_0

			var_2.updateFriend(var_3_2, var_3_0)
		end

		return
	end)
	arg_1_0:on(50013, function(arg_4_0)
		local var_4_0 = arg_1_0

		var_1.removeFriend(var_4_0, arg_4_0.id)

		return
	end)
	arg_1_0:on(50104, function(arg_5_0)
		ChatMsg = var_2_10001

		local var_5_0 = var_2_10001.New

		ChatConst = var_2_10002

		local var_5_1 = var_2_10002.ChannelFriend
		local var_5_2 = {}

		Player = var_2_10004
		var_5_2.player = var_2_10004.New(arg_5_0.msg.player)
		var_5_2.content = arg_5_0.msg.content
		var_5_2.timestamp = arg_5_0.msg.timestamp

		local var_5_3 = var_5_0(var_5_1, var_5_2)
		local var_5_4 = arg_1_0

		var_2.addChatMsg(var_5_4, var_5_3.playerId, var_5_3)

		local var_5_5 = arg_1_0
		local var_5_6 = var_2.getFriend(var_5_5, var_5_3.playerId)

		var_2.increaseUnreadCount(var_5_6)

		local var_5_7 = arg_1_0

		var_3.updateFriend(var_5_7, var_2)

		return
	end)

	return
end

function var_0_1.removeFriend(arg_6_0, arg_6_1)
	if arg_6_0.data[arg_6_1] then
		var_1_10003 = arg_6_0.data
		var_1_10003[arg_6_1] = nil

		arg_6_0:sendNotification(var_0_1.FRIEND_REMOVED, var_2.player)
	else
		print = var_1_10003

		var_1_10003("不存在的好友: " .. arg_6_1)
	end

	return
end

function var_0_1.getAllFriends(arg_7_0)
	local var_7_0 = {}

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.data) do
		table = var_1_10007

		var_1_10007.insert(var_7_0, iter_7_1.player)
	end

	Clone = var_2

	return var_2(var_7_0)
end

function var_0_1.getAllCacheMsg(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.data) do
		var_8_0[iter_8_1.player.id] = iter_8_1.cacheMsgs
	end

	Clone = var_2

	return var_2(var_8_0)
end

function var_0_1.getCacheMsgList(arg_9_0)
	local var_9_0 = {}

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.data) do
		underscore = var_1_10007

		var_1_10007.each(iter_9_1.cacheMsgs, function(arg_10_0)
			table = var_2_10001

			var_2_10001.insert(var_9_0, arg_10_0)

			return
		end)
	end

	return var_9_0
end

function var_0_1.getFriend(arg_11_0, arg_11_1)
	if arg_11_0.data[arg_11_1] then
		local var_11_0 = arg_11_0.data[arg_11_1].player

		return var_3.clone(var_11_0), var_2.cacheMsgs
	end

	return
end

function var_0_1.addChatMsg(arg_12_0, arg_12_1, arg_12_2)
	assert = var_1_10003
	isa = var_1_10004

	local var_12_0 = arg_12_2

	ChatMsg = var_1_10006

	var_1_10003(var_1_10004(var_12_0, var_1_10006), "should be an instance of ChatMsg")

	if arg_12_0.data[arg_12_1] then
		wordVer = var_3

		local var_12_1, var_12_2 = var_3(arg_12_2.content, {
			isReplace = true
		})
		local var_12_3

		string = var_1_10006

		local var_12_4 = var_1_10006.gsub
		local var_12_5 = var_12_2

		ChatConst = var_1_10008

		var_12_4(var_12_5, var_1_10008.EmojiCodeMatch, function(arg_13_0)
			tonumber = var_2_10001
			var_12_3 = var_2_10001(arg_13_0)

			return
		end)

		if var_12_3 then
			pg = var_12_4

			if var_12_4.emoji_template[var_12_3] then
				var_12_2 = var_6.desc
			else
				var_12_3 = nil
			end
		end

		arg_12_2.content = var_12_2
		arg_12_2.emojiId = var_12_3

		local var_12_6 = arg_12_0.data[arg_12_1]

		table = var_12_5

		var_12_5.insert(var_12_6.cacheMsgs, arg_12_2)
		arg_12_2:display("added")
		arg_12_0:sendNotification(var_0_1.FRIEND_NEW_MSG, arg_12_2)
	end

	return
end

function var_0_1.addFriend(arg_14_0, arg_14_1)
	assert = var_1_10002

	var_1_10002(not arg_14_0.data[arg_14_1.id], "friend already eixst" .. arg_14_1.id)
	arg_14_1:display("added")

	arg_14_0.data[arg_14_1.id] = {
		player = arg_14_1,
		cacheMsgs = {}
	}

	arg_14_0:sendNotification(var_0_1.FRIEND_ADDED, arg_14_1:clone())

	return
end

function var_0_1.updateFriend(arg_15_0, arg_15_1)
	assert = var_1_10002

	var_1_10002(arg_15_0.data[arg_15_1.id], "friend should eixst" .. arg_15_1.id)

	arg_15_0.data[arg_15_1.id].player = arg_15_1

	arg_15_0:sendNotification(var_0_1.FRIEND_UPDATED, arg_15_1:clone())

	return
end

function var_0_1.isFriend(arg_16_0, arg_16_1)
	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.data) do
		if iter_16_0 == arg_16_1 then
			return true
		end
	end

	return false
end

function var_0_1.getFriendCount(arg_17_0)
	table = var_1_10001

	local var_17_0 = var_1_10001.getCount
	local var_17_1

	if not arg_17_0.data then
		var_17_1 = {}
	end

	return var_17_0(var_17_1)
end

function var_0_1.getNewMsgCount(arg_18_0)
	local var_18_0 = 0

	pairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.data) do
		if iter_18_1.player.unreadCount > 0 then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_1.setBlackList(arg_19_0, arg_19_1)
	arg_19_0.blackList = arg_19_1

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.sendNotification
	local var_19_2 = var_0_1.BLACK_LIST_UPDATED

	Clone = var_1_10005

	var_19_1(var_19_0, var_19_2, var_1_10005(arg_19_1))

	return
end

function var_0_1.getBlackList(arg_20_0)
	Clone = var_1_10001

	return var_1_10001(arg_20_0.blackList)
end

function var_0_1.relieveBlackListById(arg_21_0, arg_21_1)
	assert = var_1_10002

	var_1_10002(arg_21_0.blackList[arg_21_1], "friend should eixst>>" .. arg_21_1)

	arg_21_0.blackList[arg_21_1] = nil

	arg_21_0:sendNotification(var_0_1.RELIEVE_BLACKLIST, arg_21_1)

	return
end

function var_0_1.getBlackPlayerById(arg_22_0, arg_22_1)
	local var_22_0

	if arg_22_0.blackList then
		Clone = var_22_0
		var_22_0 = var_22_0(arg_22_0.blackList[arg_22_1])
	end

	return var_22_0
end

function var_0_1.addIntoBlackList(arg_23_0, arg_23_1)
	if arg_23_0.blackList then
		arg_23_0.blackList[arg_23_1.id] = arg_23_1

		local var_23_0 = arg_23_0
		local var_23_1 = arg_23_0.sendNotification
		local var_23_2 = var_0_1.ADD_INTO_BLACKLIST

		Clone = var_1_10005

		var_23_1(var_23_0, var_23_2, var_1_10005(arg_23_1))
	end

	return
end

function var_0_1.isInBlackList(arg_24_0, arg_24_1)
	if arg_24_0.blackList then
		return arg_24_0.blackList[arg_24_1]
	end

	return
end

return var_0_1
