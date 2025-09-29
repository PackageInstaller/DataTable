-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/statistics/AirWorkShopStatisticsModel.lua

module("logic.extensions.airworkshop.model.statistics.AirWorkShopStatisticsModel", package.seeall)

local M = class("AirWorkShopStatisticsModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._moMap = {}
end

function M:updateFromServer(id, msg)
	local mo = self:getMapData(id)

	if not mo then
		mo = AirWorkShopStatisticsMo.New()
		self._moMap[id] = mo
	end

	mo:updateFromServer(id, msg)
end

function M:setDataDirty(id, dirty)
	local mo = self:getMapData(id)

	if mo then
		return mo:setDataDirty(dirty)
	end
end

function M:getDataDirty(id)
	local mo = self:getMapData(id)

	if mo then
		return mo:getDataDirty()
	end

	return true
end

function M:getMoMap()
	return self._moMap
end

function M:getMapData(id)
	return self._moMap[id]
end

M.instance = M.New()

return M
