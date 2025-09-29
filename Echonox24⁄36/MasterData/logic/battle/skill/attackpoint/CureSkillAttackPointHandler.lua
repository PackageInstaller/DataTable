-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/CureSkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.CureSkillAttackPointHandler", package.seeall)

local CureSkillAttackPointHandler = class("CureSkillAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)

function CureSkillAttackPointHandler:parseEventNO(curedEventNO)
	local handler = CureSkillAttackPointHandler:createInstance()

	handler:setEntityId(curedEventNO.entity)
	handler:setCure(curedEventNO.value)
	handler:setHpIncrement(curedEventNO.hpIncrement)

	return handler
end

function CureSkillAttackPointHandler:ctor()
	self._cureDivider = SkillValueDivider.New()

	self:reset()
end

function CureSkillAttackPointHandler:reset()
	self._entityId = 0
	self._cure = 0
	self._hpIncrement = 0

	self._cureDivider:clear()
end

function CureSkillAttackPointHandler:destroy()
	self:reset()
end

function CureSkillAttackPointHandler:build(context)
	local totalWeight = context:getParam(SkillAttackPointContext.TotalWeight)

	self._cureDivider:setOriginalValueAndWeight(self._cure, totalWeight)
end

function CureSkillAttackPointHandler:handleAttackPoint(context, weight)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find unit[%s]", self._entityId))
		end

		return
	end

	local cure = self._cureDivider:genNextValue(weight)

	unit.property:internal_deltaHp(cure)

	if context:isSoloPerformance() then
		unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
		unit.bubble:showBubble(BattleEnum.BubbleType.NORMAL_RECOVERY, cure, BattleConst.DelayOne)

		if context:isSkipPerformance() then
			unit.effectPlayer:playUniqueEffect(BattleConst.CURE)
		end
	else
		unit.bubble:showPerformanceBubble(BattleEnum.BubbleType.NORMAL_RECOVERY, self._cureDivider:getCurTotalValue())
	end
end

function CureSkillAttackPointHandler:toString()
	return string.format("[cure skill handler entityId = %s,hpIncrement = %s, cure = %s]", self._entityId, self._hpIncrement, self._cure)
end

function CureSkillAttackPointHandler:collectEntityIds(entityIdList)
	table.insert(entityIdList, self._entityId)
end

function CureSkillAttackPointHandler:setEntityId(entityId)
	self._entityId = entityId
end

function CureSkillAttackPointHandler:setCure(cure)
	self._cure = cure

	return self
end

function CureSkillAttackPointHandler:setHpIncrement(hpIncrement)
	self._hpIncrement = hpIncrement

	return self
end

return CureSkillAttackPointHandler
