-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleDoaminSkillMgr.lua

module("logic.extensions.battle.model.BattleDoaminSkillMgr", package.seeall)

local BattleDoaminSkillMgr = class("BattleDoaminSkillMgr")

function BattleDoaminSkillMgr:ctor()
	return
end

function BattleDoaminSkillMgr:triggedDomainSkill(unit, skillId, skillLevel)
	if self._currDomainSkillUnit then
		self._currDomainSkillUnit.buffList:removeBuffById(UnitCompBuffList.DomainChange)
	end

	self._currDomainSkillUnit = unit
	self._currDomainSkillId = skillId
	self._currDomainSkillLevel = skillLevel
end

function BattleDoaminSkillMgr:removeDomainSkill(unit)
	if self._currDomainSkillUnit == unit then
		self._currDomainSkillUnit = nil
	end
end

function BattleDoaminSkillMgr:isActive(unit, skillId, skillLevel)
	return self._currDomainSkillUnit == unit and skillId == self._currDomainSkillId and skillLevel == self._currDomainSkillLevel
end

function BattleDoaminSkillMgr:getCurrDomainSkill()
	return self._currDomainSkillUnit
end

function BattleDoaminSkillMgr:clear()
	self._currDomainSkillUnit = nil
	self._currDomainSkillId = nil
	self._currDomainSkillLevel = nil
end

function BattleDoaminSkillMgr:getDomainSkillUnits()
	local units = BattleModel.instance:getUnits()

	return self:_getDomainSkills(units)
end

function BattleDoaminSkillMgr:getEnemyDomainSkillUnits()
	local units = BattleModel.instance:getEnemyUnits()

	return self:_getDomainSkills(units)
end

function BattleDoaminSkillMgr:_getDomainSkills(units)
	if not units then
		return
	end

	local domainSkillUnits

	for k, unit in pairs(units) do
		local petCO = PetSkinConfig.instance:getPetSkinCfg(unit.attrs:getOriginSkinId())

		if petCO.domainSkillId ~= 0 then
			domainSkillUnits = domainSkillUnits or {}

			table.insert(domainSkillUnits, unit)
		end
	end

	return domainSkillUnits
end

BattleDoaminSkillMgr.instance = BattleDoaminSkillMgr.New()

return BattleDoaminSkillMgr
