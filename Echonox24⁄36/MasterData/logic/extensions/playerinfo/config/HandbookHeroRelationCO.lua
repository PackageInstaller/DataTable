-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/config/HandbookHeroRelationCO.lua

module("logic.extensions.playerinfo.config.HandbookHeroRelationCO", package.seeall)

local M = class("HandbookHeroRelationCO")

function M:ctor(heroId, cfgMap)
	self._heroId = heroId
	self._relationCfgLstMap = {}

	for targetHeroId, cfgLst in pairs(cfgMap or {}) do
		if #cfgLst > 1 then
			table.sort(cfgLst, function(cfgA, cfgB)
				return cfgA.priority > cfgB.priority
			end)
		end

		self._relationCfgLstMap[targetHeroId] = cfgLst
	end

	self:update()
end

function M:update()
	self._relations = {}
	self._relationsCount = 0

	for targetHeroId, cfgLst in pairs(self._relationCfgLstMap) do
		local activeCfg

		for index, cfg in ipairs(cfgLst) do
			local isUnLock = GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.HeroRelation, cfg.id)

			if isUnLock then
				activeCfg = cfg

				break
			end
		end

		if activeCfg then
			self._relationsCount = self._relationsCount + 1
			self._relations[targetHeroId] = activeCfg
		end
	end
end

function M:getHeroId()
	return self._heroId
end

function M:getRelationsCount()
	return self._relationsCount
end

function M:getHeroRelations()
	return self._relations or {}
end

function M:getHeroRelationsIds()
	local t = {}
	local r = self:getHeroRelations()

	for targetHeroId, cfg in pairs(r) do
		table.insert(t, cfg.id)
	end

	return t
end

function M:getHeroRelation(targetHeroId)
	local relations = self:getHeroRelations()

	return relations[targetHeroId]
end

function M:getTargetHeroRelationCfgLst(targetHeroId)
	return self._relationCfgLstMap[targetHeroId] or {}
end

function M:getTargetHeroRelationCfgIdsLst(targetHeroId)
	local cfgLst = self:getTargetHeroRelationCfgLst(targetHeroId)
	local ids = {}

	for _, cfg in ipairs(cfgLst or {}) do
		table.insert(ids, cfg.id)
	end

	return ids
end

return M
