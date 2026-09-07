local Friend = class("Friend", import(".Player"))

Friend.ONLINE = 1
Friend.OFFLINE = 0

function Friend:Ctor(arg_1_1)
	Friend.super.Ctor(self, arg_1_1)

	self.shipCount = arg_1_1.ship_count or 0
	self.collectionCount = arg_1_1.collection_count or 0
	self.online = arg_1_1.online or 1
	self.preOnLineTime = arg_1_1.pre_online_time or 0
	self.requestMsg = arg_1_1.request_msg or ""
	self.score = self.score + SeasonInfo.INIT_POINT
	self.unreadCount = 0

	return
end

function Friend:increaseUnreadCount()
	self.unreadCount = self.unreadCount + 1

	return
end

function Friend:resetUnreadCount()
	self.unreadCount = 0

	return
end

function Friend:isOnline()
	return self.online == Friend.ONLINE
end

function Friend:hasUnreadMsg()
	return self.unreadCount > 0
end

function Friend:GetManifesto()
	if getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() then
		return ""
	else
		return Friend.super.GetManifesto(self)
	end

	return
end

return Friend
