-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/boardmodel/BattleBoardModel.lua

module("logic.battle.battleflow.component.boardmodel.BattleBoardModel", package.seeall)

local BattleBoardModel = class("BattleBoardModel", IBattleFlowComp)

function BattleBoardModel:onInit()
	self._activeBoardMO = false
end

function BattleBoardModel:onStart()
	self._activeBoardMO = false
end

function BattleBoardModel:onClear()
	self:_clearActiveBoardMO()
end

function BattleBoardModel:onUndoReset()
	if self._activeBoardMO then
		self._activeBoardMO:internal_ClearData()
	end
end

function BattleBoardModel:setActiveBoardCode(checkerBoardCode)
	self:_clearActiveBoardMO()

	self._activeBoardMO = CheckerBoardMO:createInstance(checkerBoardCode)
end

function BattleBoardModel:getActiveBoardMO()
	return self._activeBoardMO
end

function BattleBoardModel:getBoardCellMO(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	return self._activeBoardMO:getCellMO(x, z)
end

function BattleBoardModel:getBoardCellMOByCoordinates(x, z)
	return self._activeBoardMO:getCellMO(x, z)
end

function BattleBoardModel:isValideCoordinates(x, z)
	return self._activeBoardMO:isValideCoordinates(x, z)
end

function BattleBoardModel:isActiveCoordinates(x, z)
	return self._activeBoardMO:isActiveCoordinates(x, z)
end

function BattleBoardModel:isUnitCanSetToUnionIndex(unit, unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	return self:_isUnitCanSetToCoordinates(unit, x, z)
end

function BattleBoardModel:setUnitToUnionIndex(unit, unionIndex, isForecast)
	if not self:_safeCheckUnit(unit) then
		return
	end

	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	self:_unlinkUnit(unit)
	self:_linkUnit(unit, x, z)

	if not isForecast then
		BattleDispatcher:dispatchEvent(BattleEventType.OnPosChangedTriggered, unit.property:getEntityId())
	end
end

function BattleBoardModel:exchangeUnitToUnionIndex(unit, unionIndex)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local oldUnit = unitMgr:getUnitOnUnionIndex(unionIndex)

	if oldUnit then
		self:removeUnit(unit)
		self:setUnitToUnionIndex(oldUnit, unitUnionIndex)
	end

	self:setUnitToUnionIndex(unit, unionIndex)
end

function BattleBoardModel:removeUnit(unit)
	self:_unlinkUnit(unit)
end

function BattleBoardModel:_safeCheckUnit(unit)
	if not BattleUnitUtil.isAlive(unit) then
		if BattleLog.enableError then
			BattleLog.error("Cannot change position of a dead unit.")
		end

		return false
	end

	return true
end

function BattleBoardModel:_unlinkUnit(unit)
	local transform = unit.transform
	local x, z = transform:getCoordinates()

	if self:isValideCoordinates(x, z) then
		if transform:isComposite() then
			local vertices = transform:getVertices()

			for _, vertex in pairs(vertices) do
				local vertexX, vertexZ = transform:transformCoordinates(vertex:getXZ())
				local vertexCellMO = self:getBoardCellMOByCoordinates(vertexX, vertexZ)

				vertexCellMO:resetOwnerEntityId()
			end
		else
			local cellMO = self:getBoardCellMOByCoordinates(x, z)

			cellMO:resetOwnerEntityId()
		end

		transform:resetCoordinates()
	end
end

function BattleBoardModel:_linkUnit(unit, x, z)
	local entityId = unit.property:getEntityId()
	local transform = unit.transform

	transform:setCoordinates(x, z)

	if transform:isComposite() then
		local vertices = transform:getVertices()

		for _, vertex in pairs(vertices) do
			local vertexX, vertexZ = transform:transformCoordinates(vertex:getXZ())
			local vertexCellMO = self:getBoardCellMOByCoordinates(vertexX, vertexZ)

			vertexCellMO:setOwnerEntityId(entityId)
		end
	else
		local cellMO = self:getBoardCellMOByCoordinates(x, z)

		cellMO:setOwnerEntityId(entityId)
	end
end

function BattleBoardModel:_isUnitCanSetToCoordinates(unit, x, z)
	local cellMO = self:getBoardCellMOByCoordinates(x, z)

	if not cellMO:isEnable() then
		return false
	end

	local entityId = unit.property:getEntityId()
	local transform = unit.transform

	if transform:isComposite() then
		local vertices = transform:getVertices()

		for _, vertex in pairs(vertices) do
			local vertexX, vertexZ = transform:transformCoordinates(vertex:getXZ())
			local vertexCellMO = self:getBoardCellMOByCoordinates(vertexX, vertexZ)

			if vertexCellMO:hasOwner() and not vertexCellMO:isEqualOwnerEntityId(entityId) then
				return false
			end

			local cellType = self:_getCellType(vertexCellMO)
			local terrainCO = TerrainConfig.instance:getTerrainCO(cellType)

			if not TerrainCOUtil.isTerrainEnableForUnit(terrainCO, unit) then
				return false
			end
		end

		return true
	else
		local cellMO = self:getBoardCellMOByCoordinates(x, z)
		local cellType = self:_getCellType(cellMO)
		local terrainCO = TerrainConfig.instance:getTerrainCO(cellType)

		if not TerrainCOUtil.isTerrainEnableForUnit(terrainCO, unit) then
			return false
		end

		return not cellMO:hasOwner()
	end
end

function BattleBoardModel:_getCellType(cellMO)
	return TerrainCOUtil.getTerrainType(cellMO)
end

function BattleBoardModel:_clearActiveBoardMO()
	if self._activeBoardMO then
		self._activeBoardMO:returnSelf()

		self._activeBoardMO = false
	end
end

return BattleBoardModel
