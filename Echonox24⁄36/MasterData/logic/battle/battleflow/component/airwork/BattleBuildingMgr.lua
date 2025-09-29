-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/airwork/BattleBuildingMgr.lua

module("logic.battle.battleflow.component.airwork.BattleBuildingMgr", package.seeall)

local M = class("BattleBuildingMgr", IBattleFlowComp)
local kEmptyTable = {}

function M:onInit()
	self._entityId2Unit = false
	self._unionIndex2HighlandUnit = false
	self._unionIndex2MessageUnit = false
end

function M:onStart()
	self._entityId2Unit = {}
	self._unionIndex2HighlandUnit = {}
	self._unionIndex2MessageUnit = {}
	self._boardMgr = self.flow.boardMgr
end

function M:createUnit(buildMO)
	local unit = AirWorkShopDefSceneUtil.createHighlandByMO(buildMO)

	self._entityId2Unit[unit.property:getEntityId()] = unit

	local position = self._boardMgr:getCellPosition(unit.property:getUnionIndex())

	unit.transform:setCoordinates(BoardIndexConverter.unionIndexToCoordinates(unit.property:getUnionIndex()))
	unit.mover:setPosDirectly(position.x, position.z)

	if unit.property:getTabType() == AirWorkShopEnum.TabEnum.Highland then
		local buildCO = AirWorkShopConfig.instance:getBuildingCO(unit.property:getEntityCode())
		local canFly = buildCO.canFly
		local heightMapProxy = SpaceX.HeightMapProxy
		local x, z = unit.property:getUnitMO():getPosition()

		if unit.transform:isComposite() then
			local vertices = unit.transform:getVertices()

			for _, vertex in pairs(vertices) do
				local vertexX, vertexZ = vertex:getXZ()

				self._unionIndex2HighlandUnit[BoardIndexConverter.coordinatesToUnionIndex(vertexX + x, vertexZ + z)] = unit

				if canFly then
					heightMapProxy.SetCellAdditionalHeight(vertexX + x, vertexZ + z, BattleConst.HighlandHeight)
				end
			end
		else
			self._unionIndex2HighlandUnit[BoardIndexConverter.coordinatesToUnionIndex(x, z)] = unit

			if canFly then
				heightMapProxy.SetCellAdditionalHeight(x, z, BattleConst.HighlandHeight)
			end
		end
	elseif unit.property:getTabType() == AirWorkShopEnum.TabEnum.Message then
		local x, z = unit.property:getUnitMO():getPosition()

		if unit.transform:isComposite() then
			local vertices = unit.transform:getVertices()

			for _, vertex in pairs(vertices) do
				local vertexX, vertexZ = vertex:getXZ()

				self._unionIndex2MessageUnit[BoardIndexConverter.coordinatesToUnionIndex(vertexX + x, vertexZ + z)] = unit
			end
		else
			self._unionIndex2MessageUnit[BoardIndexConverter.coordinatesToUnionIndex(x, z)] = unit
		end
	end

	unit:dispatchCompInitFinish()
end

function M:getHighlandUnitOnUnionIndex(unionIndex)
	if not unionIndex then
		return false
	end

	return self._unionIndex2HighlandUnit[unionIndex]
end

function M:getMessageUnitOnUnionIndex(unionIndex)
	if not unionIndex then
		return false
	end

	return self._unionIndex2MessageUnit[unionIndex]
end

function M:getUnitByEntityCode(entityCode)
	for k, v in pairs(self._entityId2Unit) do
		if v.property:getEntityCode() == entityCode then
			return v
		end
	end
end

function M:getUnit(entityId)
	return self._entityId2Unit[entityId]
end

function M:getAllBuildUnits()
	return self._entityId2Unit
end

function M:onClear()
	if self._entityId2Unit then
		for _, unit in pairs(self._entityId2Unit) do
			AirWorkShopUnitGenerator.destroyUnit(unit)
		end
	end

	BattleTableUtil.clearTable(self._entityId2Unit)
	BattleTableUtil.clearTable(self._unionIndex2HighlandUnit)
	BattleTableUtil.clearTable(self._unionIndex2MessageUnit)
end

return M
