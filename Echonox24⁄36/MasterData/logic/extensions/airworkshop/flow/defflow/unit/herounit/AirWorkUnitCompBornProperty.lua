-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkUnitCompBornProperty.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkUnitCompBornProperty", package.seeall)

local M = class("AirWorkUnitCompBornProperty", BattleUnitCompBase)

function M:onInit()
	return
end

function M:onReset()
	self:onInit()
end

function M:onDestroy()
	self:onInit()
end

function M:setUnitMO(no)
	self._bornMO = no

	self:setEntityId(self._bornMO:getEntityId())
end

function M:getUnitMO()
	return self._bornMO
end

function M:setUnionIndex(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local cellNO = self._bornMO:getBornCell()

	cellNO.cell.x = x
	cellNO.cell.z = z
end

function M:getUnionIndex(unionIndex)
	return self._bornMO:getUnionIndex()
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:getEntityId()
	return self._entityId
end

function M:getName()
	return self._name
end

function M:getMonsterType()
	return BattleEnum.MonsterType.NORMAL
end

function M:getUnitType()
	return AirWorkShopEnum.UnitType.BornPoint
end

function M:getTabType()
	return AirWorkShopEnum.TabEnum.BornPoint
end

return M
