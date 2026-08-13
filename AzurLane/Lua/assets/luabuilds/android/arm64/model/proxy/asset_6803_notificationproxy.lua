class = var_0_10000

local var_0_0 = "NotificationProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.FRIEND_REQUEST_ADDED = "note friend request added"
var_0_1.FRIEND_REQUEST_REMOVED = "note friend request removed"

function var_0_1.register(arg_1_0)
	arg_1_0:on(50000, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.data = {
			requests = {}
		}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.request_list) do
			ChatMsg = var_2_10006
			var_2_10006 = var_2_10006.New
			ChatConst = var_2_10008
			var_2_10008 = var_2_10008.ChannelFriend

			local var_2_1 = {}

			Player = var_2_10010
			var_2_1.player = var_2_10010.New(iter_2_1.player)
			var_2_1.content = iter_2_1.content
			var_2_1.timestamp = iter_2_1.timestamp

			local var_2_2 = var_2_10006(var_2_10008, var_2_1)

			var_2_10006.display(var_2_2, "request loaded")

			arg_1_0.data.requests[var_2_10006.player.id] = var_2_10006
		end

		return
	end)
	arg_1_0:on(50005, function(arg_3_0)
		ChatMsg = var_2_10001

		local var_3_0 = var_2_10001.New

		ChatConst = var_2_10003

		local var_3_1 = var_2_10003.ChannelFriend
		local var_3_2 = {}

		Player = var_2_10005
		var_3_2.player = var_2_10005.New(arg_3_0.msg.player)
		var_3_2.content = arg_3_0.msg.content
		var_3_2.timestamp = arg_3_0.msg.timestamp

		local var_3_3 = var_3_0(var_3_1, var_3_2)

		if not arg_1_0.data.requests[var_3_3.player.id] then
			arg_1_0.data.requests[var_3_3.player.id] = var_3_3

			local var_3_4 = var_3_3

			var_3_3.display(var_3_4, "new friend")

			getProxy = var_2
			FriendProxy = var_3_4

			local var_3_5 = var_2(var_3_4)

			if not var_2.isInBlackList(var_3_5, var_3_3.player.id) then
				local var_3_6 = arg_1_0

				var_3.sendNotification(var_3_6, var_0_1.FRIEND_REQUEST_ADDED, var_3_3:clone())
			end
		end

		return
	end)

	return
end

function var_0_1.getRequests(arg_4_0)
	local var_4_0 = {}

	getProxy = var_1_10002
	FriendProxy = var_1_10004

	local var_4_1 = var_1_10002(var_1_10004)

	pairs = var_1_10003

	local var_4_2

	if not arg_4_0.data.requests then
		var_4_2 = {}
	end

	for iter_4_0, iter_4_1 in var_1_10003(var_4_2) do
		if not var_4_1:isInBlackList(iter_4_0) then
			table = var_8

			var_8.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_1.removeRequest(arg_5_0, arg_5_1)
	if arg_5_0.data.requests[arg_5_1] then
		local var_5_0 = arg_5_0.data.requests[arg_5_1]

		var_2.display(var_5_0, "removed")

		arg_5_0.data.requests[arg_5_1] = nil

		arg_5_0:sendNotification(var_0_1.FRIEND_REQUEST_REMOVED, var_2)
	end

	return
end

function var_0_1.removeAllRequest(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.data.requests) do
		arg_6_0:removeRequest(iter_6_0)
	end

	return
end

function var_0_1.getRequestCount(arg_7_0)
	return #arg_7_0:getRequests()
end

function var_0_1.getUnreadCount(arg_8_0)
	local var_8_0 = 0

	pairs = var_1_10002

	local var_8_1

	if not arg_8_0.data.requests then
		var_8_1 = {}
	end

	for iter_8_0, iter_8_1 in var_1_10002(var_8_1) do
		var_8_0 = var_8_0 + 1
	end

	return var_8_0
end

function var_0_1.RawgetAllMessages(arg_9_0)
	local var_9_0 = {}

	getProxy = var_1_10002
	ChatProxy = var_1_10004

	local var_9_1 = var_1_10002(var_1_10004)

	_ = var_1_10003

	var_1_10003.each(var_9_1:getRawData(), function(arg_10_0)
		table = var_2_10001

		var_2_10001.insert(var_9_0, arg_10_0)

		return
	end)

	getProxy = var_3
	GuildProxy = var_5

	local var_9_2 = var_3(var_5)

	if var_3.getRawData(var_9_2) then
		_ = var_4

		var_4.each(var_3:getChatMsgs(), function(arg_11_0)
			table = var_2_10001

			var_2_10001.insert(var_9_0, arg_11_0)

			return
		end)
	end

	getProxy = var_4
	FriendProxy = var_9_2

	local var_9_3 = var_4(var_9_2)

	_ = var_5

	var_5.each(var_9_3:getCacheMsgList(), function(arg_12_0)
		table = var_2_10001

		var_2_10001.insert(var_9_0, arg_12_0)

		return
	end)

	return var_9_0
end

function var_0_1.getAllMessages(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.RawgetAllMessages(var_13_0)

	getProxy = var_1_10002
	FriendProxy = var_1_10004

	local var_13_2 = var_1_10002(var_1_10004)

	_ = var_13_0

	local var_13_3 = var_13_0(var_13_1)
	local var_13_4 = var_3.chain(var_13_3)
	local var_13_5 = var_3.filter(var_13_4, function(arg_14_0)
		local var_14_0 = var_13_2

		return not var_1.isInBlackList(var_14_0, arg_14_0.playerId)
	end)
	local var_13_6 = var_3.sort(var_13_5, function(arg_15_0, arg_15_1)
		return arg_15_0.timestamp < arg_15_1.timestamp
	end)

	return var_3.value(var_13_6)
end

return var_0_1
