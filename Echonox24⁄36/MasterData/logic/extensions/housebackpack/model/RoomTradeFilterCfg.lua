-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/model/RoomTradeFilterCfg.lua

module("logic.extensions.housebackpack.model.RoomTradeFilterCfg", package.seeall)

local M = class("RoomTradeFilterCfg", BackpackBaseFilterCfg)

function M:ctor()
	M.super.ctor(self)

	self._filterType = nil
end

function M:reset()
	self._filterType = CommEnum.RoomTradeMaterialFilterType.All
end

function M:setFilterType(filterType)
	self._filterType = filterType
end

function M:getFilterType()
	return self._filterType
end

function M:updateCfg(cfg)
	self:setFilterType(cfg:getFilterType())
end

function M:doFilter(list)
	return list
end

function M:filterOneItem(itemData)
	return true
end

return M
