-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/skill/ActiveSkillMO.lua

module("logic.battle.unit.comp.skill.ActiveSkillMO", package.seeall)

local ActiveSkillMO = class("ActiveSkillMO", AbstractGlobalReusable)

function ActiveSkillMO:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function ActiveSkillMO:ctor(activeSkillCO)
	self._enhanceMO = false
	self._cd = false

	self:reuse(activeSkillCO)
end

function ActiveSkillMO:reuse(activeSkillCO)
	self._skillCO = activeSkillCO
	self._cd = false
	self._sourceType = false
	self._sourceEntityId = false
	self._skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._skillCO.code)
	self._enhanceMO = SkillEnhanceMO.New()

	self._enhanceMO:reset()
	self._enhanceMO:setSkillCode(self:getSkillId())
end

function ActiveSkillMO:reset()
	self._enhanceMO:clear()

	self._cd = false
	self._skillCO = false
	self._unit = false
end

function ActiveSkillMO:destroy()
	self._skillCO = nil
	self._cd = false
	self._enhanceMO = false
	self._unit = false
end

function ActiveSkillMO:onAdded(unit)
	self._unit = unit
end

function ActiveSkillMO:setEnhanceCodes(enhanceCodes)
	self._enhanceMO:addSkillEnhanceCodes(enhanceCodes)
	self._enhanceMO:rebuild()
end

function ActiveSkillMO:setSource(sourceType, sourceEntityId)
	self._sourceType = sourceType
	self._sourceEntityId = sourceEntityId
end

function ActiveSkillMO:getSkillCOWrapper()
	return self._skillCOWrapper
end

function ActiveSkillMO:getEnhanceCodes()
	return self._enhanceMO:getAllSkillEnhanceCode(self:_getSkillStatus())
end

function ActiveSkillMO:getSkillCO()
	return self._skillCO
end

function ActiveSkillMO:getSkillId()
	return self._skillCO.code
end

function ActiveSkillMO:getSourceType()
	return self._sourceType
end

function ActiveSkillMO:getSourceEntityId()
	return self._sourceEntityId
end

function ActiveSkillMO:isAddEnhanced()
	return self._enhanceMO:isAddEnhanced()
end

function ActiveSkillMO:getReleaseDistance()
	return self._enhanceMO:getReleaseDistance(self:_getSkillStatus())
end

function ActiveSkillMO:getTransportDistance()
	return self._enhanceMO:getTransportDistance(self:_getSkillStatus())
end

function ActiveSkillMO:getSecondSelectSelectableTarget()
	return self._enhanceMO:getSecondSelectSelectableTarget(self:_getSkillStatus())
end

function ActiveSkillMO:getMoveAudio()
	return self._enhanceMO:getMoveAudio(self:_getSkillStatus())
end

function ActiveSkillMO:getDeadPerformLost()
	return self._enhanceMO:getDeadPerformLost(self:_getSkillStatus())
end

function ActiveSkillMO:generateSkillRangeShape()
	return self._enhanceMO:generateSkillRangeShape(self:_getSkillStatus())
end

function ActiveSkillMO:getMultiAOEShape()
	return self._enhanceMO:getMultiAOEShape(self:_getSkillStatus())
end

function ActiveSkillMO:generateAoeShape()
	return self._enhanceMO:generateAoeShape(self:_getSkillStatus())
end

function ActiveSkillMO:getHaloShapeAndRange()
	return self._enhanceMO:getHaloShapeAndRange(self:_getSkillStatus())
end

function ActiveSkillMO:getSelectableTarget()
	return self._skillCOWrapper:getSelectableTarget(self:_getSkillStatus())
end

function ActiveSkillMO:getPurpose()
	return self._skillCOWrapper:getSkillEffectType(self:_getSkillStatus())
end

function ActiveSkillMO:getCategory()
	return self._skillCOWrapper:getSkillType(self:_getSkillStatus())
end

function ActiveSkillMO:isPassiveSkill()
	return ActiveSkillCOUtil.isPassive(self._skillCOWrapper, self:_getSkillStatus())
end

function ActiveSkillMO:isPassiveByPurpose()
	return ActiveSkillCOUtil.isPassiveByPurpose(self._skillCOWrapper, self:_getSkillStatus())
end

function ActiveSkillMO:getAoeType()
	return self._skillCOWrapper:getAoeType(self:_getSkillStatus())
end

function ActiveSkillMO:isNormalSkill()
	local category = self:getCategory()

	return category == BattleEnum.SkillCategory.NORMAL
end

function ActiveSkillMO:isTrumpSkill()
	local category = self:getCategory()

	return category == BattleEnum.SkillCategory.TRUMP
end

function ActiveSkillMO:isCarrySkill()
	local category = self:getCategory()

	return category == BattleEnum.SkillCategory.ECHO or category == BattleEnum.SkillCategory.DEPUTY or category == BattleEnum.SkillCategory.EQUIPMENT
end

function ActiveSkillMO:getAnimState()
	return self._skillCOWrapper:getMainAnimState(self:_getSkillStatus())
end

function ActiveSkillMO:getSpecialAttackedCode()
	return self._skillCOWrapper:getSpecialAttackedCode(self:_getSkillStatus())
end

function ActiveSkillMO:getAnimType()
	return self._skillCOWrapper:getPerformanceAnimType(self:_getSkillStatus())
end

function ActiveSkillMO:hasCd()
	return self._cd and self._cd > 0 and true or false
end

function ActiveSkillMO:getCd()
	return self._cd
end

function ActiveSkillMO:setCd(cd)
	self._cd = cd
end

function ActiveSkillMO:isValid()
	return true
end

function ActiveSkillMO:_getSkillStatus()
	return self._skillCOWrapper:getValidSkillStatus(self._unit.skill:getSkillStatus())
end

return ActiveSkillMO
