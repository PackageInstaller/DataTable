-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/MainLineRankMO.lua

module("logic.extensions.rank.model.MainLineRankMO", package.seeall)

local M = class("MainLineRankMO", RankBaseMO)

function M:ctor()
	M.super.ctor(self)

	self._dungeonId = nil
	self._round = nil
	self._step = nil
	self._heros = nil
end

function M:updateData(rankId, data)
	M.super.updateData(self, rankId, data)

	local mainLineData = data.dungeon

	self:setMainLineData(mainLineData)
end

function M:setMainLineData(mainLineData)
	if not mainLineData then
		return
	end

	self._dungeonId = mainLineData.dungeonId
	self._round = mainLineData.round
	self._step = mainLineData.step
	self._heros = mainLineData.heros
end

function M:getProgress()
	local dungeonCfg = DungeonConfig.instance:getDungeonCfgById(self._dungeonId)

	return dungeonCfg and dungeonCfg.index
end

function M:getRound()
	return self._round
end

function M:getStep()
	return self._step
end

function M:getTeam()
	return self._heros
end

function M:clear()
	M.super.clear(self)

	self._dungeonId = nil
	self._round = nil
	self._step = nil
	self._heros = nil
end

return M
