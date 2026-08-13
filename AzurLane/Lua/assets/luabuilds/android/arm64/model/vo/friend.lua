class = var_0_10000

local var_0_0 = "Friend"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Player"))

var_0_1.ONLINE = 1
var_0_1.OFFLINE = 0

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0

	if not arg_1_1.ship_count then
		var_1_0 = 0
	end

	arg_1_0.shipCount = var_1_0

	local var_1_1

	if not arg_1_1.collection_count then
		var_1_1 = 0
	end

	arg_1_0.collectionCount = var_1_1

	local var_1_2

	if not arg_1_1.online then
		var_1_2 = 1
	end

	arg_1_0.online = var_1_2

	local var_1_3

	if not arg_1_1.pre_online_time then
		var_1_3 = 0
	end

	arg_1_0.preOnLineTime = var_1_3

	local var_1_4

	if not arg_1_1.request_msg then
		var_1_4 = ""
	end

	arg_1_0.requestMsg = var_1_4

	local var_1_5 = arg_1_0.score

	SeasonInfo = var_1_10003
	arg_1_0.score = var_1_5 + var_1_10003.INIT_POINT
	arg_1_0.unreadCount = 0

	return
end

function var_0_1.increaseUnreadCount(arg_2_0)
	arg_2_0.unreadCount = arg_2_0.unreadCount + 1

	return
end

function var_0_1.resetUnreadCount(arg_3_0)
	arg_3_0.unreadCount = 0

	return
end

function var_0_1.isOnline(arg_4_0)
	return arg_4_0.online == var_0_1.ONLINE
end

function var_0_1.hasUnreadMsg(arg_5_0)
	return arg_5_0.unreadCount > 0
end

function var_0_1.GetManifesto(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getRawData(var_6_0)

	if var_1.ShouldCheckCustomName(var_6_1) then
		return ""
	else
		return var_0_1.super.GetManifesto(arg_6_0)
	end

	return
end

return var_0_1
