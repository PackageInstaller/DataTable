-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/data/HeroItemData.lua

module("logic.extensions.characterdepot.data.HeroItemData", package.seeall)

local M = class("HeroItemData", ItemBaseData)

function M:ctor(params)
	M.super.ctor(self, params)

	self._itemInfo = CharacterConfig.instance:getCfgInfoByID(params.itemId)
	self._heroInfo = PastInfoConfig.instance:getCharacterInfo(params.itemId)
end

function M:getType()
	local itemId = self:getItemId()
	local type, subType = ItemUtil.getItemTypeByItemId(itemId)

	return type
end

function M:getSubType()
	local itemId = self:getItemId()
	local type, subType = ItemUtil.getItemTypeByItemId(itemId)

	return subType
end

function M:getModelId()
	return self._itemInfo.modelId
end

function M:getName()
	return self._heroInfo.name or ""
end

return M
