-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/BuffSkillAttackPointHandler.lua

module("logic.battle.skill.attackpoint.BuffSkillAttackPointHandler", package.seeall)

local BuffSkillAttackPointHandler = class("BuffSkillAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)

function BuffSkillAttackPointHandler:parseEventNO(buffTriggeredEventNO)
	local handler = BuffSkillAttackPointHandler:createInstance()

	handler:setEntityId(buffTriggeredEventNO.entity)
	handler:setBuffId(buffTriggeredEventNO.id)
	handler:setBuffCode(buffTriggeredEventNO.code)
	handler:setBuffRound(buffTriggeredEventNO.round)
	handler:setBuffLayer(buffTriggeredEventNO.layer)

	return handler
end

function BuffSkillAttackPointHandler:ctor()
	self:reset()
end

function BuffSkillAttackPointHandler:reset()
	self._entityId = 0
	self._buffId = 0
	self._buffCode = 0
	self._buffRound = 0
	self._buffLayer = 0
	self._isExecuted = false
end

function BuffSkillAttackPointHandler:destroy()
	self:reset()
end

function BuffSkillAttackPointHandler:build(context)
	return
end

function BuffSkillAttackPointHandler:handleAttackPoint(context, attackPointIndex)
	if self._isExecuted then
		return
	end

	self._isExecuted = true

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find unit[%s]", self._entityId))
		end

		return
	end

	BattleBuffUtil.addBuff(unit, self._buffId, self._buffCode, self._buffRound, self._buffLayer)
end

function BuffSkillAttackPointHandler:toString()
	return string.format("[buff skill handler buffId = %s,buffCode = %s,buffRound = %s,buffLayer = %s]", self._buffId, self._buffCode, self._buffRound, self._buffLayer)
end

function BuffSkillAttackPointHandler:collectEntityIds(entityIdList)
	table.insert(entityIdList, self._entityId)
end

function BuffSkillAttackPointHandler:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BuffSkillAttackPointHandler:setBuffId(buffId)
	self._buffId = buffId

	return self
end

function BuffSkillAttackPointHandler:setBuffCode(buffCode)
	self._buffCode = buffCode

	return self
end

function BuffSkillAttackPointHandler:setBuffRound(round)
	self._buffRound = round

	return self
end

function BuffSkillAttackPointHandler:setBuffLayer(layer)
	self._buffLayer = layer

	return self
end

return BuffSkillAttackPointHandler
