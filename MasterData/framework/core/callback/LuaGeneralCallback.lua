-- chunkname: @framework/core/callback/LuaGeneralCallback.lua

module("framework.core.callback.LuaGeneralCallback", package.seeall)

local LuaGeneralCallback = class("LuaGeneralCallback")

LuaGeneralCallback._pool = nil

function LuaGeneralCallback.getPool()
	LuaGeneralCallback._pool = LuaGeneralCallback._pool or LuaObjPool.New(32, LuaGeneralCallback._poolNew, LuaGeneralCallback._poolRelease, LuaGeneralCallback._poolReset)

	return LuaGeneralCallback._pool
end

function LuaGeneralCallback._poolNew()
	return LuaGeneralCallback.New()
end

function LuaGeneralCallback._poolRelease(luaObj)
	luaObj:release()
end

function LuaGeneralCallback._poolReset(luaObj)
	luaObj:reset()
end

function LuaGeneralCallback:ctor()
	self.id = 0
	self.callback = nil
	self.hasCbObj = false
	self.cbObjContainer = {}

	setmetatable(self.cbObjContainer, {
		__mode = "v"
	})

	self.cbObjContainer.value = nil
end

function LuaGeneralCallback:setCbObj(cbObj)
	self.hasCbObj = cbObj ~= nil

	if self.hasCbObj then
		self.cbObjContainer.value = cbObj
	end
end

function LuaGeneralCallback:invoke(...)
	if self.hasCbObj and not self.cbObjContainer.value then
		return false
	end

	local args = {
		...
	}

	if not self.hasCbObj then
		self.callback(unpack(args))
	else
		self.callback(self.cbObjContainer.value, unpack(args))
	end

	return true
end

function LuaGeneralCallback:reset()
	self.id = 0
	self.callback = nil
	self.hasCbObj = false
	self.cbObjContainer.value = nil
end

function LuaGeneralCallback:release()
	self:reset()
end

return LuaGeneralCallback
