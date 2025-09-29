-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonControlMO.lua

module("logic.extensions.dungeon.model.DungeonControlMO", package.seeall)

local M = class("DungeonControlMO", DungeonMOBase)

function M:getLimitCO()
	if self._limitCO == nil then
		self._limitCO = ControlActionConfig.instance:getMonitorDungeonLimitCfg(self:getId())
	end

	return self._limitCO
end

function M:canRecord()
	local limitCO = self:getLimitCO()

	if limitCO and limitCO.canRecord and limitCO.canRecord == 1 then
		return true
	end

	return false
end

function M:getMultiplicityLimit()
	local limitCO = self:getLimitCO()

	return limitCO and limitCO.multiplicityLimit or 1
end

function M:getConsecutiveLimit()
	local limitCO = self:getLimitCO()

	return limitCO and limitCO.consecutive or 0
end

return M
