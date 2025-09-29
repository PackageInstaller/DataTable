-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/Delegate.lua

module("logic.common.entitas.Delegate", package.seeall)

local set = Set
local set_insert = set.insert
local set_remove = set.remove
local M = {}

M.__index = M

function M.__call(t, ...)
	for k, _ in pairs(t._listeners._data) do
		k(...)
	end
end

function M.New()
	local tb = {}

	tb._listeners = set.New()

	return setmetatable(tb, M)
end

function M:add(f)
	assert(set_insert(self._listeners, f))
end

function M:remove(f)
	return set_remove(self._listeners, f)
end

function M:has(f)
	return self._listeners:has(f)
end

return M
