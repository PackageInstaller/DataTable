-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/CollectionRankMO.lua

module("logic.extensions.rank.model.CollectionRankMO", package.seeall)

local M = class("CollectionRankMO", RankBaseMO)

function M:ctor()
	M.super.ctor(self)

	self._ratio = nil
end

function M:updateData(rankId, data)
	M.super.updateData(self, rankId, data)

	local collectionData = data.collect

	self:setcollectionData(collectionData)
end

function M:setcollectionData(collectionData)
	if not collectionData then
		return
	end

	self._ratio = collectionData.ratio
end

function M:getRatio()
	return self._ratio
end

function M:clear()
	M.super.clear(self)

	self._ratio = nil
end

return M
