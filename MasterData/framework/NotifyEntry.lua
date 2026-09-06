-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/notify/NotifyEntry.lua

module("framework.notify.NotifyEntry", package.seeall)

local NotifyEntry = class("NotifyEntry")

function NotifyEntry._poolCreateFunc()
	return NotifyEntry.New()
end

function NotifyEntry._poolDisposeFunc(entryObj)
	return
end

function NotifyEntry._poolResetFunc(entryObj)
	entryObj:reset()
end

function NotifyEntry.initPool()
	NotifyEntry._pool = ObjectPool.New(10, NotifyEntry._poolCreateFunc, NotifyEntry._poolDisposeFunc, NotifyEntry._poolResetFunc)
end

function NotifyEntry.getPool()
	return NotifyEntry._pool
end

function NotifyEntry:ctor()
	self:reset()
end

function NotifyEntry:reset()
	self.name = 0
	self.handler = nil
	self.handlerObj = nil
	self.status = NotifyStatus.Idle
	self.priority = NotifyPriority.Low
	self.isRemoveAllHandler = nil
end

return NotifyEntry
