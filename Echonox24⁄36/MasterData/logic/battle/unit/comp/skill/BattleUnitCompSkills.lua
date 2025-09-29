-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/skill/BattleUnitCompSkills.lua

module("logic.battle.unit.comp.skill.BattleUnitCompSkills", package.seeall)

local BattleUnitCompSkills = class("BattleUnitCompSkills", BattleUnitCompBase)
local kEmptyNormalSkill = EmptyNormalSkillMO.New()
local kPurpose2SkillMOClass = {}

kPurpose2SkillMOClass[BattleEnum.SkillPurpose.WEAK_POINT] = WeakPointSkillMO

local kCategory2ForbiddenStateKeys = {}

kCategory2ForbiddenStateKeys[BattleEnum.SkillCategory.NORMAL] = {
	BattleEnum.State.CANNOT_NORMAL_ATTACK
}
kCategory2ForbiddenStateKeys[BattleEnum.SkillCategory.SPECIAL] = {
	BattleEnum.State.SILENT
}
kCategory2ForbiddenStateKeys[BattleEnum.SkillCategory.TRUMP] = {
	BattleEnum.State.SILENT
}

function BattleUnitCompSkills:onInit()
	self._property = self._unit.property
	self._activeSkillList = {}
	self._inactiveSkillList = {}
	self._skillStatus = BattleEnum.SkillStatus.Normal
	self._tagEnhances = {}
end

function BattleUnitCompSkills:onReset()
	for _, skillMO in pairs(self._activeSkillList) do
		skillMO:returnSelf()
	end

	BattleTableUtil.clearTable(self._activeSkillList)

	for _, skillMO in pairs(self._inactiveSkillList) do
		skillMO:returnSelf()
	end

	BattleTableUtil.clearTable(self._inactiveSkillList)
	BattleTableUtil.clearTable(self._tagEnhances)
end

function BattleUnitCompSkills:onDestroy()
	self:onReset()
end

function BattleUnitCompSkills:getSkillStatus()
	return self._skillStatus
end

function BattleUnitCompSkills:setSkillStatus(status)
	self._skillStatus = status
end

function BattleUnitCompSkills:getSanityConsume()
	return self._skillStatus == BattleEnum.SkillStatus.Strenthening and 1 or 0
end

function BattleUnitCompSkills:getActiveSkillById(skillId)
	return self:_findSkillBySkillId(self._activeSkillList, skillId) or self:_findSkillBySkillId(self._inactiveSkillList, skillId)
end

function BattleUnitCompSkills:addSkill(skillCode, skillCd, enhanceCodes, sourceType, sourceEntityId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)
	local skillCO = skillCOWrapper:getSkillCO()
	local skillMOClass = kPurpose2SkillMOClass[skillCOWrapper:getSkillEffectType(self:getSkillStatus())] or ActiveSkillMO
	local skillMO = skillMOClass:createInstance(skillCO)

	skillMO:setCd(skillCd)
	skillMO:setEnhanceCodes(enhanceCodes)
	skillMO:setSource(sourceType or BattleExtension_pb.SkillSourceType.OTHER, sourceEntityId)
	skillMO:onAdded(self._unit)
	table.insert(self._activeSkillList, skillMO)
	self:_checkClientStatus(skillMO, true)
end

function BattleUnitCompSkills:addSkillFromSkillInfo(skillInfo)
	self:addSkill(skillInfo.skillCode, skillInfo.skillCd, skillInfo.enhanceCodes, skillInfo.skillSourceType, skillInfo.skillSourceEntityId)
end

function BattleUnitCompSkills:_checkClientStatus(skillMO, isAdd)
	local moveAudio = skillMO:getMoveAudio()

	if moveAudio then
		self._unit.property:setRunAudio(isAdd and moveAudio or string.format("skill_%d_run", self._unit.property:getModelCode()))
	end

	local deadPeformLost = skillMO:getDeadPerformLost()

	if deadPeformLost then
		self._unit.property:setDeadPerformLost(isAdd and deadPeformLost or false)
	end
end

function BattleUnitCompSkills:removeSkill(skillCode)
	local skillMO = self:_findSkillBySkillId(self._activeSkillList, skillCode)

	if skillMO then
		self:_checkClientStatus(skillMO, false)
		table.removebyvalue(self._activeSkillList, skillMO)
		table.insert(self._inactiveSkillList, skillMO)
	end
end

function BattleUnitCompSkills:getNormalSkill()
	local normalSkill = self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.NORMAL)

	return normalSkill or kEmptyNormalSkill
end

function BattleUnitCompSkills:getSpecialSkill()
	return self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.SPECIAL)
end

function BattleUnitCompSkills:getTrumpSkill()
	return self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.TRUMP)
end

function BattleUnitCompSkills:getTalentSkill()
	return self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.TALENT)
end

function BattleUnitCompSkills:getEchoSkill()
	return self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.ECHO)
end

function BattleUnitCompSkills:getDeputySkill()
	return self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.DEPUTY)
end

function BattleUnitCompSkills:getEquipmentSkill()
	return self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.EQUIPMENT)
end

function BattleUnitCompSkills:getExtraSkill()
	return self:_findSkillByCategory(self._activeSkillList, BattleEnum.SkillCategory.EXTRA)
end

function BattleUnitCompSkills:getWeakPointSkill()
	return self:_findSkillByPurpose(self._activeSkillList, BattleEnum.SkillPurpose.WEAK_POINT)
end

function BattleUnitCompSkills:getActiveSkillList()
	return self._activeSkillList
end

function BattleUnitCompSkills:findEnableDamageSkill()
	local skillMO = self:getNormalSkill()

	if self:_isEnableDamageSkill(skillMO) then
		return skillMO
	end

	skillMO = self:getSpecialSkill()

	if self:_isEnableDamageSkill(skillMO) then
		return skillMO
	end

	skillMO = self:getTrumpSkill()

	if self:_isEnableDamageSkill(skillMO) then
		return skillMO
	end

	return self:getNormalSkill()
end

function BattleUnitCompSkills:_isEnableDamageSkill(skillMO)
	return skillMO and self:isSkillEnable(skillMO:getSkillId()) and skillMO:getPurpose() == BattleEnum.SkillPurpose.DAMAGE
end

function BattleUnitCompSkills:isSkillEnable(skillId)
	local skillMO = self:getActiveSkillById(skillId)

	if not skillMO then
		return false
	end

	if skillMO:hasCd() then
		return false
	end

	local isForbidden = BattleUnitUtil.isForbiddenSkill(skillMO)

	if isForbidden then
		return false
	end

	local stateKeys = kCategory2ForbiddenStateKeys[skillMO:getCategory()]

	if not stateKeys then
		return true
	end

	for _, stateKey in ipairs(stateKeys) do
		if self._property:isStateActive(stateKey) then
			return false
		end
	end

	return true
end

function BattleUnitCompSkills:isSkillUnlock(skillId)
	local skillMO = self:getActiveSkillById(skillId)

	if not skillMO then
		return false
	end

	local stateKeys = kCategory2ForbiddenStateKeys[skillMO:getCategory()]

	if not stateKeys then
		return true
	end

	for _, stateKey in ipairs(stateKeys) do
		if self._property:isStateActive(stateKey) then
			return false
		end
	end

	return true
end

function BattleUnitCompSkills:_findSkillByCategory(skillList, category)
	for _, skillMO in pairs(skillList) do
		if skillMO:getCategory() == category then
			return skillMO
		end
	end

	return false
end

function BattleUnitCompSkills:_findSkillByPurpose(skillList, purpose)
	for _, skillMO in pairs(skillList) do
		if skillMO:getPurpose() == purpose then
			return skillMO
		end
	end

	return false
end

function BattleUnitCompSkills:_findSkillBySkillId(skillList, skillId)
	for _, skillMO in pairs(skillList) do
		if skillMO:getSkillId() == skillId then
			return skillMO
		end
	end

	return false
end

function BattleUnitCompSkills:generateSkillReleaseShape(skillId)
	local skillMO = self:getActiveSkillById(skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if ActiveSkillCOUtil.isReleaseTypeSniping(skillCOWrapper, self:getSkillStatus()) then
		return BattleSkillAssist.generateSnipeSkillShape(self._unit, skillMO)
	else
		return BattleShapeUtil.createShapeByTypeAndRange(BattleEnum.Shape.Rhombus, skillMO:getReleaseDistance())
	end
end

function BattleUnitCompSkills:addTagEnhances(tagEnhances)
	if tagEnhances then
		for i, tagEnhanceNO in ipairs(tagEnhances) do
			local tagFiledKey = string.format("%s_%s", tagEnhanceNO.tag, tagEnhanceNO.field)

			if not self._tagEnhances[tagFiledKey] then
				self._tagEnhances[tagFiledKey] = {}
			end

			for i, context in ipairs(tagEnhanceNO.contexts) do
				self._tagEnhances[tagFiledKey][context.id] = context
			end
		end
	end
end

function BattleUnitCompSkills:removeTagEnhances(tagEnhances)
	if tagEnhances then
		for i, tagEnhanceNO in ipairs(tagEnhances) do
			local tagFiledKey = string.format("%s_%s", tagEnhanceNO.tag, tagEnhanceNO.field)

			if self._tagEnhances[tagFiledKey] then
				for i, context in ipairs(tagEnhanceNO.contexts) do
					self._tagEnhances[tagFiledKey][context.id] = false
				end
			end
		end
	end
end

function BattleUnitCompSkills:getSkillTagEnhances()
	return self._tagEnhances
end

return BattleUnitCompSkills
