local var_0_0 = class("NotificationProxy", import(".NetProxy"))

var_0_0.FRIEND_REQUEST_ADDED = "note friend request added"
var_0_0.FRIEND_REQUEST_REMOVED = "note friend request removed"

function var_0_0.register(arg_1_0)
	arg_1_0:on(50000, function(arg_2_0)
		arg_1_0.data = {
			requests = {}
		}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.request_list) do
			local var_2_0 = ChatMsg.New(ChatConst.ChannelFriend, {
				player = Player.New(iter_2_1.player),
				content = iter_2_1.content,
				timestamp = iter_2_1.timestamp
			})

			var_2_0:display("request loaded")

			arg_1_0.data.requests[var_2_0.player.id] = var_2_0
		end

		return
	end)
	arg_1_0:on(50005, function(arg_3_0)
		local var_3_0 = ChatMsg.New(ChatConst.ChannelFriend, {
			player = Player.New(arg_3_0.msg.player),
			content = arg_3_0.msg.content,
			timestamp = arg_3_0.msg.timestamp
		})

		if not arg_1_0.data.requests[var_3_0.player.id] then
			arg_1_0.data.requests[var_3_0.player.id] = var_3_0

			var_3_0:display("new friend")

			if not getProxy(FriendProxy):isInBlackList(var_3_0.player.id) then
				arg_1_0:sendNotification(var_0_0.FRIEND_REQUEST_ADDED, var_3_0:clone())
			end
		end

		return
	end)

	return
end

function var_0_0.getRequests(arg_4_0)
	local var_4_0 = getProxy(FriendProxy)
	local var_4_1 = arg_4_0.data.requests or {}

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		if not var_4_0:isInBlackList(iter_4_0) then
			table.insert({}, iter_4_1)
		end
	end

	return {}
end

function var_0_0.removeRequest(arg_5_0, arg_5_1)
	if arg_5_0.data.requests[arg_5_1] then
		arg_5_0.data.requests[arg_5_1]:display("removed")

		arg_5_0.data.requests[arg_5_1] = nil

		arg_5_0:sendNotification(var_0_0.FRIEND_REQUEST_REMOVED, arg_5_0.data.requests[arg_5_1])
	end

	return
end

function var_0_0.removeAllRequest(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.data.requests) do
		arg_6_0:removeRequest(iter_6_0)
	end

	return
end

function var_0_0.getRequestCount(arg_7_0)
	return #arg_7_0:getRequests()
end

function var_0_0.getUnreadCount(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = arg_8_0.data.requests or {}

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		var_8_0 = var_8_0 + 1
	end

	return var_8_0
end

function var_0_0.RawgetAllMessages(arg_9_0)
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

	local var_9_2 = getProxy(FriendProxy)

	_.each(var_9_2:getCacheMsgList(), function(arg_12_0)
		table.insert(var_9_0, arg_12_0)

		return
	end)

	return {}
end

function var_0_0.getAllMessages(arg_13_0)
	local var_13_0 = getProxy(FriendProxy)

	return _((arg_13_0:RawgetAllMessages())):chain():filter(function(arg_14_0)
		return not var_13_0:isInBlackList(arg_14_0.playerId)
	end):sort(function(arg_15_0, arg_15_1)
		return arg_15_0.timestamp < arg_15_1.timestamp
	end):value()
end

return var_0_0
