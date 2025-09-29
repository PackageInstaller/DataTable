-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/AirWorkShopEndlessRankMO.lua

module("logic.extensions.rank.model.AirWorkShopEndlessRankMO", package.seeall)

local M = class("AirWorkShopEndlessRankMO", RankBaseMO)

function M:ctor()
	M.super.ctor(self)

	self._winNum = nil
	self._time = nil
end

function M:updateData(rankId, data)
	M.super.updateData(self, rankId, data)

	local airWorkShopData = data.airEndless

	self:setAirWorkShopData(airWorkShopData)
end

function M:setAirWorkShopData(airWorkShopData)
	if not airWorkShopData then
		return
	end

	self._winNum = airWorkShopData.winNum
	self._time = tonumber(airWorkShopData.time)
end

function M:getWinNum()
	return self._winNum
end

function M:getTime()
	return self._time
end

function M:clear()
	M.super.clear(self)

	self._winNum = nil
	self._time = nil
end

function M:getNickName()
	return self._nickname
end

return M
