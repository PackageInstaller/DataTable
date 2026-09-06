-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/notify/DispatchEntry.lua

module("framework.notify.DispatchEntry", package.seeall)

local DispatchEntry = class("DispatchEntry")

function DispatchEntry._poolCreateFunc()
	return DispatchEntry.New()
end

function DispatchEntry._poolDisposeFunc(entryObj)
	return
end

function DispatchEntry._poolResetFunc(entryObj)
	entryObj:reset()
end

function DispatchEntry.initPool()
	DispatchEntry._pool = ObjectPool.New(10, DispatchEntry._poolCreateFunc, DispatchEntry._poolDisposeFunc, DispatchEntry._poolResetFunc)
end

function DispatchEntry.getPool()
	return DispatchEntry._pool
end

function DispatchEntry:ctor()
	self:reset()
end

function DispatchEntry:reset()
	self.name = 0
	self.message = nil
end

return DispatchEntry
