-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePropertyModifiedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePropertyModifiedCommand", package.seeall)

local BattlePropertyModifiedCommand = class("BattlePropertyModifiedCommand", BattleCommandBase)

function BattlePropertyModifiedCommand:parseServerCommand(cmdParser, attributeModifiedEventNO)
	self:_tryAddSanityRecoverCommand(cmdParser, attributeModifiedEventNO)

	local cmd = BattlePropertyModifiedCommand:createInstance()

	cmd:setEntityId(attributeModifiedEventNO.entity)
	cmd:setPropertyCode(attributeModifiedEventNO.attr)
	cmd:setPropertyValue(BattleMathUtil.removePrecision(attributeModifiedEventNO.value))
	cmd:setPropertyBaseValue(BattleMathUtil.removePrecision(attributeModifiedEventNO.initial))
	cmdParser:addCommand(cmd)
end

function BattlePropertyModifiedCommand:_tryAddSanityRecoverCommand(cmdParser, attributeModifiedEventNO)
	local propertyCode = attributeModifiedEventNO.attr

	if propertyCode == BattleExtension_pb.Attribute.CURRENT_SAN then
		local unitMgr = BattleMgr.instance:getActiveBattleFlow().unitMgr
		local unit = unitMgr:getUnit(attributeModifiedEventNO.entity)
		local deltaValue = BattleMathUtil.removePrecision(attributeModifiedEventNO.value) - unit.property:getAttribute(propertyCode)

		if deltaValue > 0 then
			local cmd = BattleUnitSanityRecoverCommand:createInstance()

			cmd:setEntityId(attributeModifiedEventNO.entity)
			cmd:setRecoverValue(deltaValue)
			cmd:setPropertyValue(BattleMathUtil.removePrecision(attributeModifiedEventNO.value))
			cmd:setPropertyBaseValue(BattleMathUtil.removePrecision(attributeModifiedEventNO.initial))
			cmdParser:addCommand(cmd)
		end
	end
end

function BattlePropertyModifiedCommand:isSpecialPropertyModifiedCommand(eventNO)
	local attributeModifiedEventNO = eventNO.attributeModified

	return attributeModifiedEventNO.attr == BattleExtension_pb.Attribute.CURRENT_SAN
end

function BattlePropertyModifiedCommand:isHpPropertyModifiedCommand(eventNO)
	local attributeModifiedEventNO = eventNO.attributeModified

	return attributeModifiedEventNO.attr == BattleExtension_pb.Attribute.CURRENT_HP
end

function BattlePropertyModifiedCommand:onInit()
	self._entityId = 0
	self._propertyCode = 0
	self._propertyValue = 0
	self._propertyBaseValue = 0
end

function BattlePropertyModifiedCommand:onClear()
	self._entityId = 0
	self._propertyCode = 0
	self._propertyValue = 0
	self._propertyBaseValue = 0
end

function BattlePropertyModifiedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattlePropertyModifiedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	self:_tryShowLowSanityEffect(unit)

	local finished = self:_trySetOperatorStrengthen(unit)

	if finished then
		self:finish(true)

		return
	end

	unit.property:setBaseAttribute(self._propertyCode, self._propertyBaseValue)
	unit.property:setAttribute(self._propertyCode, self._propertyValue)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	GlobalDispatcher:dispatchEvent(EventType.ON_BATTLE_UNIT_PROPERTY_MODIFY, unit.property:getEntityCode())
	self:finish(true)
end

function BattlePropertyModifiedCommand:_trySetOperatorStrengthen(unit)
	if self._propertyCode == BattleExtension_pb.Attribute.CURRENT_SAN then
		local deltaValue = self._propertyValue - unit.property:getAttribute(self._propertyCode)

		if deltaValue < 0 then
			BattleMgr.instance:getUnitOperator():setStrenthening(false)
		else
			return true
		end
	end
end

function BattlePropertyModifiedCommand:_tryShowLowSanityEffect(unit)
	if self._propertyCode == BattleExtension_pb.Attribute.CURRENT_SAN then
		if self._propertyValue < 0 then
			unit.effectPlayer:playLoopEffect(BattleConst.LOW_SANITY)
		else
			unit.effectPlayer:stopLoopEffect(BattleConst.LOW_SANITY)
		end
	end
end

function BattlePropertyModifiedCommand:toString()
	return string.format("[attribute modified command entityId = %s,propertyCode = %s, propertyValue =%s, propertyBaseValue = %s]", self._entityId, self._propertyCode, self._propertyValue, self._propertyBaseValue)
end

function BattlePropertyModifiedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattlePropertyModifiedCommand:setPropertyCode(propertyCode)
	self._propertyCode = propertyCode

	return self
end

function BattlePropertyModifiedCommand:setPropertyValue(propertyValue)
	self._propertyValue = propertyValue

	return self
end

function BattlePropertyModifiedCommand:setPropertyBaseValue(propertyBaseValue)
	self._propertyBaseValue = propertyBaseValue

	return self
end

return BattlePropertyModifiedCommand
