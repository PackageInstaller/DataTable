-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/model/DrawingItemData.lua

module("logic.extensions.housebackpack.model.DrawingItemData", package.seeall)

local M = class("DrawingItemData", ItemData)

function M:ctor(params)
	M.super.ctor(self, params)
end

function M:setUuid(uuid)
	self._uuid = uuid
end

function M:getId()
	return self._itemInfo.id
end

function M:getIsShowBag()
	return true
end

return M
