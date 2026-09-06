-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFBuffBase.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFBuffBase", package.seeall)

local AQAFBuffBase = class("AQAFBuffBase")

function AQAFBuffBase:ctor(name)
	self.buffName = name
	self.buffCfgId = 0
	self.triggerStage = 0
	self._layerCount = 0
	self._layerLimit = 1
	self._isAdded = false
end

function AQAFBuffBase:initData(unit, buffCfgId, triggerStage, data)
	self._unit = unit
	self.buffCfgId = buffCfgId
	self.triggerStage = triggerStage
	self.data = data
	self._conditionType = data.conditionType
	self._conditionParam = data.conditionParam

	if data.___TriggerParam then
		self._tiggerParam = data.___TriggerParam
	else
		data.___TriggerParam = string.split(data.TriggerParam, "#")
		self._tiggerParam = data.___TriggerParam
	end

	self._layerCount = 0
	self._layerLimit = math.max(1, checknumber(data.triggerCount))

	self:_clearLast()
end

function AQAFBuffBase:_clearLast()
	self._target = nil
	self._lastHitId = -1
	self._dammage = 0
end

function AQAFBuffBase:addLayerCount()
	self._layerCount = self._layerCount + 1
	self._layerCount = math.min(self._layerLimit, self._layerCount)
end

function AQAFBuffBase:setCover()
	self._isAdded = true
end

function AQAFBuffBase:onUpdate()
	return
end

function AQAFBuffBase:onAdd(unit)
	self._addedTime = ServerTime.now()

	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id

	if not self._isAdded then
		self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_CREATE)
	end

	self._isAdded = true
end

function AQAFBuffBase:onHit(unit)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_HIT)
end

function AQAFBuffBase:onBeHit(unit)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_BEHIT)
end

function AQAFBuffBase:onCrit(unit)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_CRIT)
end

function AQAFBuffBase:onAttack(unit)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_ATTACK)
end

function AQAFBuffBase:onBeforeCauseDamage(unit)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_BF)
end

function AQAFBuffBase:onBeforeDammage(unit, dammage)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id
	self._dammage = dammage

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_DAMAGE_BF)
end

function AQAFBuffBase:onAfterDammage(unit, dammage)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id
	self._dammage = dammage

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_DAMAGE_AF)
end

function AQAFBuffBase:onAfterCauseDamage(unit, damage)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id
	self._dammage = damage

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_CAUSE_DAMAGE_AF)
end

function AQAFBuffBase:onSelfDead(unit)
	self:_clearLast()

	self._target = unit
	self._lastHitId = unit.id

	self:checkStageAndDone(AQAFBuffMgr.TRIGGER_STAGE_DEAD)
end

function AQAFBuffBase:checkStageAndDone(stage)
	if self.triggerStage == stage and self:_checkCondition() then
		self:onBuffTrigger()
	end
end

function AQAFBuffBase:onRemove(unit)
	self:_clearLast()
end

function AQAFBuffBase:onBuffTrigger()
	return
end

function AQAFBuffBase:_checkCondition()
	if self._conditionType == nil then
		return true
	elseif self._conditionType == "" then
		return true
	elseif self._conditionType == "isTargetBoss" then
		return AQAFBuffMgr.instance:checkUnitIsBoss(self._target, self._conditionParam)
	elseif self._conditionType == "check_target_state" then
		return self._target:hasState(self._conditionParam)
	elseif self._conditionType == "check_trigger_limit" then
		return self._layerCount == self._layerLimit
	elseif self._conditionType == "check_player_hp" then
		return AQAFBuffMgr.instance:checkPlayerHp(self._conditionParam)
	elseif self._conditionType == "check_target_type" then
		return AQAFBuffMgr.instance:checkTargetType(self._conditionParam)
	elseif self._conditionType == "check_target_atk_type" then
		return AQAFBuffMgr.instance:checkTargetAtkType(self._conditionParam)
	end
end

return AQAFBuffBase
