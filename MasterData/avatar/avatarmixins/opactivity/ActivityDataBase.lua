-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataBase.lua

local ActivityDataBase = Class("ActivityDataBase")

function ActivityDataBase:ctor(actObject)
	self.actObject = actObject
end

function ActivityDataBase:updateClientData(actId)
	self.actId = actId
end

function ActivityDataBase:updateRoleData(roleData)
	return
end

function ActivityDataBase:updateSystemData(opActivitySystemItem)
	return
end

function ActivityDataBase:updateMgrData(opActivityMgrItem)
	return
end

function ActivityDataBase:isOver()
	return false
end

function ActivityDataBase:checkNew(...)
	return
end

function ActivityDataBase:getLimitId(...)
	return
end

function ActivityDataBase:getlimitIdGroup(...)
	return
end

function ActivityDataBase:onStateChange(opActState)
	return
end

function ActivityDataBase:onServerStateChange(opActState)
	return
end

function ActivityDataBase:registEndEvent()
	if self.doSthWhenEnd == nil then
		return
	end

	local endTime = self:getEndTime()

	if endTime == nil then
		return
	end

	local needTick = endTime - ClientUtils.getServerTime()

	if needTick >= 0 then
		self:unRegistEndEvent()
		ClientTimerManager.startGlobalTimer("activity_" .. self.actObject.actId, needTick, Slot(self.doSthWhenEnd, self))
	end
end

function ActivityDataBase:unRegistEndEvent(...)
	ClientTimerManager.stopGlobalTimer("activity_" .. self.actObject.actId)
end

function ActivityDataBase:getEndTime(...)
	return self.actObject:getStartEndTime()[2]
end

function ActivityDataBase:willEnd()
	return false
end

function ActivityDataBase:willEndCountDown()
	return 0
end

function ActivityDataBase:registerRDEvent(...)
	return
end

function ActivityDataBase:unRegistRDEvent(...)
	return
end

function ActivityDataBase:onMgrDataReady()
	return
end

function ActivityDataBase:destroy()
	return
end

return ActivityDataBase
