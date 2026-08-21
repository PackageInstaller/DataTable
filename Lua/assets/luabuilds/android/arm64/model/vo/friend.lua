local var_0_0 = class("Friend", import(".Player"))

var_0_0.ONLINE = 1
var_0_0.OFFLINE = 0

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.shipCount = arg_1_1.ship_count or 0
	arg_1_0.collectionCount = arg_1_1.collection_count or 0
	arg_1_0.online = arg_1_1.online or 1
	arg_1_0.preOnLineTime = arg_1_1.pre_online_time or 0
	arg_1_0.requestMsg = arg_1_1.request_msg or ""
	arg_1_0.score = arg_1_0.score + SeasonInfo.INIT_POINT
	arg_1_0.unreadCount = 0

	return
end

function var_0_0.increaseUnreadCount(arg_2_0)
	arg_2_0.unreadCount = arg_2_0.unreadCount + 1

	return
end

function var_0_0.resetUnreadCount(arg_3_0)
	arg_3_0.unreadCount = 0

	return
end

function var_0_0.isOnline(arg_4_0)
	return arg_4_0.online == var_0_0.ONLINE
end

function var_0_0.hasUnreadMsg(arg_5_0)
	return arg_5_0.unreadCount > 0
end

function var_0_0.GetManifesto(arg_6_0)
	if getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() then
		return ""
	else
		return var_0_0.super.GetManifesto(arg_6_0)
	end

	return
end

return var_0_0
