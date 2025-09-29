-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/additionalterrain/BattleAdditionalTerrainMgr.lua

module("logic.battle.battleflow.component.additionalterrain.BattleAdditionalTerrainMgr", package.seeall)

local BattleAdditionalTerrainMgr = class("BattleAdditionalTerrainMgr", IBattleFlowComp)
local kTempGroups = {}
local kTempGroupCellInfos = {}
local kTempCellInfos = {}
local kTempGroupUnionIndexList = {}
local kTempSplitUnionIndexList = {}

function BattleAdditionalTerrainMgr:onInit()
	self._groupIdGen = 0
	self._groupTable = false
	self._unionIndex2TerrainUnit = false
	self._removingTerrainUnits = {}
end

function BattleAdditionalTerrainMgr:onStart()
	self._boardModel = self.flow.boardModel or false
	self._boardMgr = self.flow.boardMgr or false
	self._groupIdGen = 0
	self._groupTable = {}
	self._unionIndex2TerrainUnit = {}
	self._removingTerrainUnits = {}
end

function BattleAdditionalTerrainMgr:onPreClear()
	if self._removingTerrainUnits then
		BattleTableUtil.clearReusableTable(self._removingTerrainUnits)
		BattleTableUtil.clearReusableTable(self._unionIndex2TerrainUnit)
		BattleTableUtil.clearReusableTable(self._groupTable)
	end
end

function BattleAdditionalTerrainMgr:onClear()
	if self._removingTerrainUnits then
		BattleTableUtil.clearReusableTable(self._removingTerrainUnits)
		BattleTableUtil.clearReusableTable(self._unionIndex2TerrainUnit)
		BattleTableUtil.clearReusableTable(self._groupTable)
	end

	self._groupIdGen = 0
	self._unionIndex2TerrainUnit = false
	self._removingTerrainUnits = false
	self._groupTable = false
	self._boardModel = false
	self._boardMgr = false
end

function BattleAdditionalTerrainMgr:onUndoReset()
	BattleTableUtil.clearReusableTable(self._removingTerrainUnits)
	BattleTableUtil.clearReusableTable(self._unionIndex2TerrainUnit)
	BattleTableUtil.clearReusableTable(self._groupTable)

	self._groupIdGen = 0
end

function BattleAdditionalTerrainMgr:removeDeadUnit(unit)
	table.removebyvalue(self._removingTerrainUnits, unit)
end

function BattleAdditionalTerrainMgr:createTerrainUnits(cellInfos, outNewGroupIds)
	local groupCellInfos = kTempGroupCellInfos

	for _, cellInfo in ipairs(cellInfos) do
		if cellInfo:hasAdditionalTerrain() then
			local additionalTerrainCO = TerrainConfig.instance:getAdditionalTerrainCO(self:_getAdditionalTerrainCode(cellInfo))

			if AdditionalTerrainCOUtil.isGroupTerrain(additionalTerrainCO) then
				table.insert(groupCellInfos, cellInfo)
			else
				self:_createAsNormalTerrain(cellInfo)
			end
		end
	end

	self:_autoDivideAddToGroupTerrain(groupCellInfos, outNewGroupIds)
	BattleTableUtil.clearTable(groupCellInfos)
end

function BattleAdditionalTerrainMgr:removeTerrainUnits(cellInfos)
	local groupCellInfos = kTempGroupCellInfos

	for _, cellInfo in ipairs(cellInfos) do
		if cellInfo:hasAdditionalTerrain() then
			local additionalTerrainCO = TerrainConfig.instance:getAdditionalTerrainCO(self:_getAdditionalTerrainCode(cellInfo))

			if AdditionalTerrainCOUtil.isGroupTerrain(additionalTerrainCO) then
				table.insert(groupCellInfos, cellInfo)
			else
				self:_removeAsNormalTerrain(cellInfo.unionIndex)
			end
		end
	end

	self:_autoDivideRemoveFromGroupTerrain(groupCellInfos)
	BattleTableUtil.clearTable(groupCellInfos)
end

function BattleAdditionalTerrainMgr:mergeGroups()
	local groups = kTempGroups

	BattleTableUtil.insertfrommap(groups, self._groupTable)

	if #groups <= 1 then
		return
	end

	local isMerged = false
	local i, j = 1, 1

	while i <= #groups do
		j = i + 1

		local group = groups[i]

		while j <= #groups do
			local srcGroup = groups[j]

			if group.rectangle:internal_merge(srcGroup) then
				isMerged = true

				table.remove(groups, j)
				self:_removeGroupUnit(srcGroup)
				group.rectangle:internal_updatePerformance()
			else
				j = j + 1
			end
		end

		i = i + 1
	end

	BattleTableUtil.clearTable(groups)

	if isMerged then
		self:mergeGroups()
	end
end

function BattleAdditionalTerrainMgr:getGroupUnit(groupId)
	return self._groupTable[groupId]
end

function BattleAdditionalTerrainMgr:_autoDivideAddToGroupTerrain(groupCellInfos, outNewGroupIds)
	if #groupCellInfos <= 0 then
		return
	end

	local sameGroupCellInfos = kTempCellInfos
	local i, j = 1, 1

	while i <= #groupCellInfos do
		local cellInfo = groupCellInfos[i]

		table.insert(sameGroupCellInfos, cellInfo)

		j = i + 1

		while j <= #groupCellInfos do
			local tempCellInfo = groupCellInfos[j]

			if self:_isCellInfoHasSameAdditionalTerrain(cellInfo, tempCellInfo) then
				table.remove(groupCellInfos, j)
				table.insert(sameGroupCellInfos, tempCellInfo)
			else
				j = j + 1
			end
		end

		self:_createAsGroupTerrain(sameGroupCellInfos, outNewGroupIds)
		BattleTableUtil.clearTable(sameGroupCellInfos)

		i = i + 1
	end
end

function BattleAdditionalTerrainMgr:_autoDivideRemoveFromGroupTerrain(groupCellInfos)
	if #groupCellInfos <= 0 then
		return
	end

	local sameGroupCellInfos = kTempCellInfos
	local i, j = 1, 1

	while i <= #groupCellInfos do
		local cellInfo = groupCellInfos[i]

		table.insert(sameGroupCellInfos, cellInfo)

		j = i + 1

		while j <= #groupCellInfos do
			local tempCellInfo = groupCellInfos[j]

			if self:_isCellInfoHasSameAdditionalTerrain(cellInfo, tempCellInfo) then
				table.remove(groupCellInfos, j)
				table.insert(sameGroupCellInfos, tempCellInfo)
			else
				j = j + 1
			end
		end

		self:_removeAsGroupTerrain(sameGroupCellInfos)
		BattleTableUtil.clearTable(sameGroupCellInfos)

		i = i + 1
	end
end

function BattleAdditionalTerrainMgr:_createAsNormalTerrain(cellInfo)
	local unionIndex = cellInfo.unionIndex

	self:_removeAsNormalTerrain(unionIndex)

	local terrainMO = CheckerBoardAdditionalTerrainMO:createFromAdditionalTerrainInfo(cellInfo.additionalTerrainInfo)

	self:_addTerrainLogical(unionIndex, terrainMO)

	local unit = BattleUnitGenerator.createAdditionalTerrain(terrainMO:getCode())

	if unit then
		local position = self._boardMgr:getCellPosition(unionIndex)

		unit.transform:setCoordinates(BoardIndexConverter.unionIndexToCoordinates(unionIndex))
		unit.mover:setPosDirectly(position.x, position.z)

		self._unionIndex2TerrainUnit[unionIndex] = unit
	end
end

function BattleAdditionalTerrainMgr:_removeAsNormalTerrain(unionIndex)
	self:_removeTerrainLogical(unionIndex)

	local unit = self._unionIndex2TerrainUnit[unionIndex]

	if unit then
		table.insert(self._removingTerrainUnits, unit)

		self._unionIndex2TerrainUnit[unionIndex] = nil

		unit:destroyUnit()
	end
end

function BattleAdditionalTerrainMgr:getAllGroupUnit()
	return self._groupTable
end

function BattleAdditionalTerrainMgr:_createAsGroupTerrain(cellInfos, outNewGroupIds)
	local unionIndexList = kTempGroupUnionIndexList

	for _, cellInfo in ipairs(cellInfos) do
		local unionIndex = cellInfo.unionIndex
		local terrainMO = CheckerBoardAdditionalTerrainMO:createFromAdditionalTerrainInfo(cellInfo.additionalTerrainInfo)

		self:_addTerrainLogical(unionIndex, terrainMO)
		table.insert(unionIndexList, cellInfo.unionIndex)
	end

	local terrainCode = self:_getAdditionalTerrainCode(cellInfos[1])

	self:_buildToGroupUnit(terrainCode, unionIndexList, outNewGroupIds)
	BattleTableUtil.clearTable(unionIndexList)
end

function BattleAdditionalTerrainMgr:_removeAsGroupTerrain(cellInfos)
	local unionIndexList = kTempGroupUnionIndexList

	for _, cellInfo in ipairs(cellInfos) do
		local unionIndex = cellInfo.unionIndex

		self:_removeTerrainLogical(unionIndex)
		table.insert(unionIndexList, cellInfo.unionIndex)
	end

	local terrainCode = self:_getAdditionalTerrainCode(cellInfos[1])

	self:_removeFromGroupUnit(terrainCode, unionIndexList)
	BattleTableUtil.clearTable(unionIndexList)
end

function BattleAdditionalTerrainMgr:_buildToGroupUnit(terrainCode, unionIndexList, outNewGroupIds)
	if #unionIndexList <= 0 then
		return
	end

	local unionIndex = table.remove(unionIndexList)
	local gid = self:_genNextGroupId()
	local unit = BattleUnitGenerator.createAdditionalTerrain(terrainCode)

	unit.id = gid
	unit.terrainCode = terrainCode

	unit.rectangle:setOriginalUnionIndex(unionIndex)

	self._groupTable[gid] = unit

	if outNewGroupIds then
		table.insert(outNewGroupIds, gid)
	end

	unit.rectangle:internal_tryMergeInGroup(unionIndexList)
	unit.rectangle:internal_updatePerformance()
	self:_buildToGroupUnit(terrainCode, unionIndexList, outNewGroupIds)
end

function BattleAdditionalTerrainMgr:_removeFromGroupUnit(terrainCode, unionIndexList)
	local dirtyGroups = kTempGroups

	for _, unionIndex in ipairs(unionIndexList) do
		for _, group in pairs(self._groupTable) do
			if group.terrainCode == terrainCode and group.rectangle:internal_containsUnionIndex(unionIndex) then
				BattleTableUtil.insertunique(dirtyGroups, group)
			end
		end
	end

	local splitUnionIndexList = kTempSplitUnionIndexList

	for _, group in ipairs(dirtyGroups) do
		group.rectangle:internal_splitToUnionIndexList(splitUnionIndexList)
		self:_removeGroupUnit(group)
	end

	BattleTableUtil.clearTable(dirtyGroups)

	for _, unionIndex in ipairs(unionIndexList) do
		table.removebyvalue(splitUnionIndexList, unionIndex)
	end

	self:_buildToGroupUnit(terrainCode, splitUnionIndexList)
	self:mergeGroups()
	BattleTableUtil.clearTable(splitUnionIndexList)
end

function BattleAdditionalTerrainMgr:_removeGroupUnit(group)
	table.insert(self._removingTerrainUnits, group)

	self._groupTable[group.id] = nil

	group:destroyUnit()
end

function BattleAdditionalTerrainMgr:_genNextGroupId()
	self._groupIdGen = self._groupIdGen + 1

	return self._groupIdGen
end

function BattleAdditionalTerrainMgr:_addTerrainLogical(unionIndex, terrainMO)
	local cellMO = self._boardModel:getBoardCellMO(unionIndex)

	cellMO:setAdditionalTerrainMO(terrainMO)
end

function BattleAdditionalTerrainMgr:_removeTerrainLogical(unionIndex)
	local cellMO = self._boardModel:getBoardCellMO(unionIndex)

	cellMO:removeAdditionalTerrainMO()
end

function BattleAdditionalTerrainMgr:_getAdditionalTerrainCode(cellInfo)
	return cellInfo.additionalTerrainInfo.code
end

function BattleAdditionalTerrainMgr:_isCellInfoHasSameAdditionalTerrain(cellInfoA, cellInfoB)
	if cellInfoA:hasAdditionalTerrain() and cellInfoB:hasAdditionalTerrain() then
		return cellInfoA.additionalTerrainInfo.code == cellInfoB.additionalTerrainInfo.code
	end

	return false
end

return BattleAdditionalTerrainMgr
