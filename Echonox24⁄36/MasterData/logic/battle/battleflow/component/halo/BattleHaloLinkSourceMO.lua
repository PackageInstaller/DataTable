-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/halo/BattleHaloLinkSourceMO.lua

module("logic.battle.battleflow.component.halo.BattleHaloLinkSourceMO", package.seeall)

local BattleHaloLinkSourceMO = class("BattleHaloLinkSourceMO", AbstractGlobalReusable)

function BattleHaloLinkSourceMO:getCapacity()
	return BattleConst.ObjPoolCapacityMaxx
end

function BattleHaloLinkSourceMO:ctor(entityId)
	self._entityId = 0
	self._fromEntityIds = {}
	self._fromSkillIds = {}

	self:reuse(entityId)
end

function BattleHaloLinkSourceMO:reuse(entityId)
	self._entityId = entityId
end

function BattleHaloLinkSourceMO:reset()
	BattleTableUtil.clearTable(self._fromEntityIds)
	BattleTableUtil.clearTable(self._fromSkillIds)
end

function BattleHaloLinkSourceMO:destroy()
	self:reset()
end

function BattleHaloLinkSourceMO:addLinkSource(fromEntityId, fromSkillId)
	if self:containsLinkSource(fromEntityId, fromSkillId) then
		return
	end

	table.insert(self._fromEntityIds, fromEntityId)
	table.insert(self._fromSkillIds, fromSkillId)
end

function BattleHaloLinkSourceMO:removeLinkSource(fromEntityId, fromSkillId)
	for i, entityId in ipairs(self._fromEntityIds) do
		if entityId == fromEntityId and self._fromSkillIds[i] == fromSkillId then
			table.remove(self._fromEntityIds, i)
			table.remove(self._fromSkillIds, i)

			return
		end
	end
end

function BattleHaloLinkSourceMO:containsLinkSource(fromEntityId, fromSkillId)
	for index, entityId in ipairs(self._fromEntityIds) do
		if entityId == fromEntityId and self._fromSkillIds[index] == fromSkillId then
			return true
		end
	end

	return false
end

function BattleHaloLinkSourceMO:getSourceEntityIds()
	return self._fromEntityIds
end

function BattleHaloLinkSourceMO:getFromSkills()
	return self._fromSkillIds
end

function BattleHaloLinkSourceMO:isEmpty()
	return #self._fromEntityIds <= 0
end

function BattleHaloLinkSourceMO:toString()
	return string.format("link toEntityId = %s, sourceEntityIds = [%s]", self._entityId, BattleTableUtil.arrayToString(self._fromEntityIds))
end

return BattleHaloLinkSourceMO
