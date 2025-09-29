-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/model/ChamberEntryCO.lua

module("logic.extensions.chamber.model.ChamberEntryCO", package.seeall)

local M = class("ChamberEntryCO")

function M:ctor(cfg)
	self._cfg = cfg
	self._slot = nil
	self._count = nil
end

function M:getId()
	return self._cfg.id
end

function M:getLv()
	return self._cfg.lv
end

function M:getName()
	return self._cfg.name
end

function M:getDesc()
	return self._cfg.description
end

function M:getPN()
	return self._cfg.pn
end

function M:isPositive()
	return self._cfg.pn == 1
end

function M:getProgress()
	local progress = -1

	if self._cfg.program == "DungeonDropCount" then
		local list = string.split(self._cfg.param, "#")

		progress = tonumber(list[1])
	end

	return progress
end

function M:isSkillAdd()
	return self._cfg.pn == 0
end

function M:getSkillId()
	return checkint(self._cfg.param)
end

function M:setCount(count)
	self._count = count
end

function M:getCount()
	local total = self:getProgress()

	if total > 0 then
		return math.min(total, checknumber(self._count))
	end

	return checknumber(self._count)
end

return M
