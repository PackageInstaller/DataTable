-- chunkname: @framework/core/pool/LuaObjPool.lua

module("framework.core.pool.LuaObjPool", package.seeall)

local LuaObjPool = class("LuaObjPool")

function LuaObjPool:ctor(maxCount, newFunc, releaseFunc, resetFunc)
	self._maxCount = maxCount
	self._newFunc = newFunc
	self._releaseFunc = releaseFunc
	self._resetFunc = resetFunc

	if maxCount == nil or newFunc == nil or releaseFunc == nil or resetFunc == nil then
		logError("LuaObjPool, 对象池构造，所有参数都不能为nil")
	end

	if self._maxCount == 0 then
		self._maxCount = 32
	end

	self._cacheList = {}
end

function LuaObjPool:getObject()
	local curCount = #self._cacheList

	if curCount < 1 then
		return self._newFunc()
	else
		return table.remove(self._cacheList)
	end
end

function LuaObjPool:putObject(luaObj)
	local curCount = #self._cacheList

	self._resetFunc(luaObj)

	if curCount >= self._maxCount then
		self._releaseFunc(luaObj)
	elseif not tabletool.indexOf(self._cacheList, luaObj) then
		table.insert(self._cacheList, luaObj)
	end
end

function LuaObjPool:dispose()
	local curCount = #self._cacheList

	if curCount == 0 then
		return
	end

	local luaObj

	for idx = 1, curCount do
		self._releaseFunc(self._cacheList[idx])

		self._cacheList[idx] = nil
	end
end

return LuaObjPool
