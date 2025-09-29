-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/model/BackpackBaseFilterCfg.lua

module("logic.extensions.backpack.model.BackpackBaseFilterCfg", package.seeall)

local M = class("BackpackBaseFilterCfg")

function M:ctor()
	self._UID = UIDUtil.getUID()
end

function M:reset()
	return
end

function M:equal(cfg)
	return cfg and cfg:getId() == self._UID
end

function M:getId()
	return self._UID
end

function M:setIsDecomposing()
	return
end

function M:getIsDecomposing()
	return false
end

function M:setIsExtracting()
	return
end

function M:getIsExtracting()
	return false
end

function M:updateCfg(cfg)
	return
end

function M:doFilter(list)
	local res = {}

	for _, itemData in ipairs(list) do
		if self:filterOneItem(itemData) then
			table.insert(res, itemData)
		end
	end

	return res
end

function M:filterOneItem(itemData)
	return itemData and itemData:getIsShowBag()
end

return M
