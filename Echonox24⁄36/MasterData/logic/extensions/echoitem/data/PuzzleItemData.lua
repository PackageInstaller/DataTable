-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/data/PuzzleItemData.lua

module("logic.extensions.echoitem.data.PuzzleItemData", package.seeall)

local M = class("PuzzleItemData", ItemData)

function M:ctor(params)
	M.super.ctor(self, params)

	self._composeCo = ComposeConfig.instance:getConfigById(self._itemInfo.id) or {}

	if not self._composeCo or #self._composeCo == 0 then
		printError(string.format("no config co in t_item_compose id: %s", self._itemInfo.id))
	end
end

function M:getCompoundSoureceId()
	return self._composeCo.sourceId
end

function M:getCompoundTargetId()
	return self._composeCo.targetId
end

function M:getPuzzleCount()
	return self._composeCo.cost
end

function M:getComposeCount()
	return self._composeCo.synthesis
end

function M:getFilterType()
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._composeCo.targetId)

	return itemCo.filterType or PropFilterType.AllFilterType
end

function M:isShowRedPoint()
	return self:getCount() >= self:getPuzzleCount()
end

return M
