-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/pathfinder/BattlePathFinder_private.lua

module("logic.battle.battleflow.component.pathfinder.BattlePathFinder_private", package.seeall)

local BattlePathFinder_private = {}
local BattlePathFinder = BattlePathFinder
local kSearchDirections = {
	Coordinates.New(1, 0),
	Coordinates.New(0, 1),
	Coordinates.New(-1, 0),
	Coordinates.New(0, -1)
}
local INT_MAX = 4294967295
local INT_MIN = -INT_MAX
local MAX_LOOP_COUNT = 200
local tempOpenList = {}

local function sort_on_remain(nodeA, nodeB)
	return nodeA.remain < nodeB.remain
end

local function sort_on_distance(nodeA, nodeB)
	return nodeA.distance > nodeB.distance
end

local function sort_on_remain_distance(nodeA, nodeB)
	if nodeA.remain == nodeB.remain then
		return sort_on_distance(nodeA, nodeB)
	end

	return sort_on_remain(nodeA, nodeB)
end

local function sort_on_distance_priority(nodeA, nodeB)
	if nodeA.distance == nodeB.distance then
		return nodeA.priority < nodeB.priority
	end

	return nodeA.distance > nodeB.distance
end

function BattlePathFinder_private:init()
	return
end

function BattlePathFinder:_buildNodes()
	local boardModel = self._boardModel
	local boardMO = self._boardModel:getActiveBoardMO()
	local pathNodes = self._nodeArray

	pathNodes:setWidthAndHeight(boardMO:getWidth(), boardMO:getHeight())

	for _, cellMO in boardMO:ipairs() do
		local x, z = cellMO:getCoordinates()

		pathNodes:setElement(x, z, CheckerBoardPathNode.New(cellMO))
	end

	for _, node in pathNodes:ipairs() do
		local x, z = node:getCoordinates()

		for _, deltaCoordinates in pairs(kSearchDirections) do
			local dx, dz = deltaCoordinates:getXZ()

			dx = x + dx
			dz = z + dz

			if boardModel:isValideCoordinates(dx, dz) then
				local neighborNode = pathNodes:getElement(dx, dz)

				node:addNeighbor(neighborNode)
			end
		end
	end
end

function BattlePathFinder:_prepareForSignArea(unit)
	for _, node in self._nodeArray:ipairs() do
		node:resetAllState()
		self:_judgeNodeEnable(node, unit)
	end
end

function BattlePathFinder:_signWalkableArea(unit, fromUnionIndex, walkCostMax)
	local openList = tempOpenList

	BattleTableUtil.clearTable(openList)

	local transform = unit.transform
	local fromNode = self._nodeArray:getElement(BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex))

	fromNode.remain = walkCostMax

	table.insert(openList, fromNode)

	while #openList > 0 do
		table.sort(openList, sort_on_remain)
		self:_walkOnNodeForWalkable(table.remove(openList), unit, openList)
	end

	self:_signStopableEdge()
end

function BattlePathFinder:_signStopableEdge()
	for _, node in self._nodeArray:ipairs() do
		if node.isStopable then
			local neighbors = node:getNeighbors()

			for _, neighborNode in pairs(neighbors) do
				if not neighborNode.isStopable then
					node.isStopableEdge = true
				end
			end
		end
	end
end

function BattlePathFinder:_walkOnNodeForWalkable(node, unit, openList)
	node.isClosed = true

	self:_signNodeWalkable(node, unit)
	self:_adjustNodeRemain(node, unit)

	local maxMobility = node.remain
	local neighbors = node:getNeighbors()
	local transform = unit.transform

	for _, neighborNode in pairs(neighbors) do
		if not neighborNode.isClosed and neighborNode.isEnable then
			local remain = maxMobility - self:_calculateConsumeForWalkable(node, neighborNode, transform)

			if remain >= 0 then
				if not neighborNode.fromNode then
					neighborNode.fromNode = node
					neighborNode.remain = remain

					table.insert(openList, neighborNode)
				elseif remain > neighborNode.remain then
					neighborNode.fromNode = node
					neighborNode.remain = remain
				end
			end
		end
	end
end

function BattlePathFinder:_signWalkableAreaForTransportMove(unit, fromUnionIndex, walkCostMax)
	local boardModel = BattleMgr.instance:getBoardModel()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex)

	for dx = -walkCostMax, walkCostMax do
		for dz = -walkCostMax, walkCostMax do
			if walkCostMax >= math.abs(dx) + math.abs(dz) and boardModel:isActiveCoordinates(x + dx, z + dz) then
				local node = self._nodeArray:getElement(x + dx, z + dz)

				if node then
					self:_signNodeWalkable(node, unit)
				end
			end
		end
	end

	self:_signStopableEdge()
end

function BattlePathFinder:_signNodeWalkable(node, unit)
	local boardModel = self._boardModel
	local isStopableOnCell = self:_isStopableOnCell(unit, node:getCoordinates())
	local transform = unit.transform

	if transform:isComposite() then
		local nodeArray = self._nodeArray
		local vertices = transform:getVertices()
		local toCellX, toCellZ = node:getCoordinates()

		for _, vertex in pairs(vertices) do
			local x, z = transform:testTransformCoordinates(toCellX, toCellZ, vertex:getXZ())

			if boardModel:isValideCoordinates(x, z) then
				local pathNode = nodeArray:getElement(x, z)

				if pathNode then
					pathNode.isWalkable = true

					if isStopableOnCell then
						pathNode.isStopable = true
					end
				end
			end
		end
	else
		node.isWalkable = true

		if isStopableOnCell then
			node.isStopable = true
		end
	end
end

function BattlePathFinder:_adjustNodeRemain(node, unit)
	local boardModel = self._boardModel
	local unitMgr = self._unitMgr
	local x, z = node:getCoordinates()
	local cellMO = boardModel:getBoardCellMOByCoordinates(x, z)
	local entityId = unit.property:getEntityId()
	local stateMOList = cellMO:getStateMOList()

	for _, stateMO in ipairs(stateMOList) do
		local tUnit = unitMgr:getUnit(stateMO:getEntityId())

		if BattleCampRelationUtil.areTheyEnemyRelation(tUnit, unit) and stateMO:isTargetState(BattleEnum.CellState.BLOCKED) and not cellMO:isEqualOwnerEntityId(entityId) then
			node.remain = INT_MIN
		end
	end
end

function BattlePathFinder:_isStopableOnCell(unit, toX, toZ)
	local boardModel = self._boardModel
	local transform = unit.transform
	local entityId = unit.property:getEntityId()

	if transform:isComposite() then
		local vertices = transform:getVertices()

		for _, vertex in pairs(vertices) do
			local x, z = transform:testTransformCoordinates(toX, toZ, vertex:getXZ())

			if boardModel:isValideCoordinates(x, z) then
				local cellMO = boardModel:getBoardCellMOByCoordinates(x, z)

				if cellMO:hasOwner() and not cellMO:isEqualOwnerEntityId(entityId) then
					return false
				end
			else
				return false
			end
		end

		return true
	else
		local cellMO = boardModel:getBoardCellMOByCoordinates(toX, toZ)

		return not cellMO:hasOwner() or cellMO:isEqualOwnerEntityId(entityId)
	end
end

function BattlePathFinder:_judgeNodeEnable(pathNode, unit)
	local cellMO = pathNode:getCellMO()
	local terrainCO = TerrainConfig.instance:getTerrainCO(TerrainCOUtil.getTerrainType(cellMO))

	pathNode.consume = TerrainCOUtil.getMobilityConsume(terrainCO, unit)

	if not pathNode.consume then
		printError(pathNode.consume)
	end

	if not cellMO:isEnable() then
		pathNode.isEnable = false

		return
	end

	if not cellMO:hasOwner() then
		pathNode.isEnable = true

		return
	end

	local unitMgr = self._unitMgr
	local model = self._model
	local targetUnit = unitMgr:getUnit(cellMO:getOwnerEntityId())
	local entityCampId = unit.property:getCampId()
	local targetCampId = targetUnit.property:getCampId()
	local relationType = model:getCampRelation(entityCampId, targetCampId)

	if BattleCampRelationUtil.isSameOrFriendRelation(relationType) then
		pathNode.isEnable = true

		return
	end

	pathNode.isEnable = false
end

function BattlePathFinder:_calculateConsumeForWalkable(node, toNode, transform)
	if not transform:isComposite() then
		return toNode.consume
	end

	local boardModel = self._boardModel
	local nodeArray = self._nodeArray
	local toNodeX, toNodeZ = toNode:getCoordinates()
	local vertices = transform:getVertices()
	local maxConsume = toNode.consume

	for _, vertex in pairs(vertices) do
		local x, z = transform:testTransformCoordinates(toNodeX, toNodeZ, vertex:getXZ())

		if not boardModel:isValideCoordinates(x, z) then
			return INT_MAX
		end

		local tempNode = nodeArray:getElement(x, z)

		if not tempNode.isEnable then
			return INT_MAX
		end

		if not transform:containsCoordinates(x, z) then
			maxConsume = math.max(tempNode.consume, maxConsume)
		end
	end

	return maxConsume
end

function BattlePathFinder:_signAttackableArea(unit, skillId)
	for _, node in self._nodeArray:ipairs() do
		node:resetForSignAttackable()
	end

	local isSkillEnable = unit.skill:isSkillEnable(skillId)

	if not isSkillEnable then
		return
	end

	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local shape = unit.skill:generateSkillReleaseShape(skillId)
	local outUnionIndexList = BattleTableUtil.getTempList()
	local outAoeUnionIndexList = BattleTableUtil.getTempList()

	for _, node in self._nodeArray:ipairs() do
		if node.isStopableEdge then
			BattleShapeUtil.calculateCoveredUnionIndexList(outUnionIndexList, shape, node:getUnionIndex(), unitUnionIndex)

			for i, unionIndex in ipairs(outUnionIndexList) do
				local targetNode = self._nodeArray:getElement(BoardIndexConverter.unionIndexToCoordinates(unionIndex))

				if targetNode and not targetNode.isClosed then
					targetNode.isAttackable = true
					targetNode.isClosed = true
				end
			end

			BattleTableUtil.clearTable(outUnionIndexList)
		end

		if node.isWalkable then
			node.isAttackable = true
		end
	end

	shape:returnSelf()
	BattleTableUtil.releaseTempList(outUnionIndexList)
	BattleTableUtil.releaseTempList(outAoeUnionIndexList)
end

function BattlePathFinder:_signTransportableArea(unit, shape, fromUnionIndex)
	for _, node in self._nodeArray:ipairs() do
		node:resetForSignTransportable()
	end

	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local outUnionIndexList = BattleTableUtil.getTempList()

	BattleShapeUtil.calculateCoveredUnionIndexList(outUnionIndexList, shape, fromUnionIndex, unitUnionIndex)

	for i, unionIndex in ipairs(outUnionIndexList) do
		local node = self._nodeArray:getElement(BoardIndexConverter.unionIndexToCoordinates(unionIndex))

		if node then
			node.isTransportable = self._boardModel:isUnitCanSetToUnionIndex(unit, unionIndex)
			node.isTransportableArea = node.isEnable
			node.isClosed = true
		end
	end

	BattleTableUtil.releaseTempList(outUnionIndexList)
end

function BattlePathFinder:_signSelectableArea(shape, fromUnionIndex)
	for _, node in self._nodeArray:ipairs() do
		node:resetForSignSelectable()
	end

	local outUnionIndexList = BattleTableUtil.getTempList()

	BattleShapeUtil.calculateCoveredUnionIndexList(outUnionIndexList, shape, fromUnionIndex, fromUnionIndex)

	for i, unionIndex in ipairs(outUnionIndexList) do
		local node = self._nodeArray:getElement(BoardIndexConverter.unionIndexToCoordinates(unionIndex))

		if node then
			node.isSelectable = true
		end
	end

	BattleTableUtil.releaseTempList(outUnionIndexList)
end

function BattlePathFinder:_signSkillRangeArea(shape, targetUnionIndex, unitUnionIndex)
	for _, node in self._nodeArray:ipairs() do
		node:resetForSignSkillRange()
	end

	local outUnionIndexList = BattleTableUtil.getTempList()

	BattleShapeUtil.calculateCoveredUnionIndexList(outUnionIndexList, shape, targetUnionIndex, unitUnionIndex)

	for i, unionIndex in ipairs(outUnionIndexList) do
		local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
		local node = self._nodeArray:getElement(x, z)

		if node then
			node.isSkillArea = true
		end
	end

	BattleTableUtil.releaseTempList(outUnionIndexList)
end

function BattlePathFinder:_signPrettyPath(unit, fromUnionIndex, currentPathUnionIndexs)
	local transform = unit.transform
	local nodeArray = self._nodeArray
	local fromX, fromZ = BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex)

	for _, node in nodeArray:ipairs() do
		node:resetForPrettyPath()
		node:calculateDistance(fromX, fromZ)
	end

	if currentPathUnionIndexs then
		for index, unionIndex in ipairs(currentPathUnionIndexs) do
			local node = nodeArray:getElement(BoardIndexConverter.unionIndexToCoordinates(unionIndex))

			node.priority = index
		end
	end

	local openList = tempOpenList

	BattleTableUtil.clearTable(openList)

	local node = nodeArray:getElement(fromX, fromZ)

	table.insert(openList, node)

	while #openList > 0 do
		table.sort(openList, sort_on_distance_priority)
		self:_walkOnNodeForPrettyPath(table.remove(openList), openList, unit)
	end
end

function BattlePathFinder:_walkOnNodeForPrettyPath(node, openList, unit)
	node.isClosed = true

	local neighbors = node:getNeighbors()

	for _, neighborNode in pairs(neighbors) do
		if not neighborNode.isClosed and neighborNode.isEnable then
			if not neighborNode.prettyFromNode then
				neighborNode.prettyFromNode = node
				neighborNode.priority = math.max(neighborNode.priority, node.priority)

				table.insert(openList, neighborNode)
			elseif node.priority > neighborNode.priority then
				neighborNode.prettyFromNode = node
				neighborNode.priority = node.priority
			end
		end
	end
end

function BattlePathFinder:_findPrettyPath(toUnionIndex, resultList)
	local toX, toZ = BoardIndexConverter.unionIndexToCoordinates(toUnionIndex)
	local node = self._nodeArray:getElement(toX, toZ)
	local count = MAX_LOOP_COUNT

	while node and count > 0 do
		table.insert(resultList, BoardIndexConverter.coordinatesToUnionIndex(node:getCoordinates()))

		node = node.prettyFromNode
		count = count - 1
	end
end

function BattlePathFinder:_signCanAttackTarget(attacker, fromUnionIndex, targetUnionIndex, skillId)
	for _, node in self._nodeArray:ipairs() do
		node:resetForCanAttackTarget()
	end

	local nodeArray = self._nodeArray
	local openList = tempOpenList

	BattleTableUtil.clearTable(openList)

	local toX, toZ = BoardIndexConverter.unionIndexToCoordinates(targetUnionIndex)
	local targetNode = nodeArray:getElement(toX, toZ)

	targetNode.remain = attackCostMax

	table.insert(openList, targetNode)

	local maxDistance = 0
	local shape = attacker.skill:generateSkillReleaseShape(skillId)

	while #openList > 0 do
		local node = table.remove(openList)

		self:_walkOnNodeForCanAttackTarget(node, openList, shape, targetNode)

		if node.isCanAttackTarget then
			node:calculateManhattanDistance(toX, toZ)

			maxDistance = math.max(maxDistance, node.distance)
		end
	end

	shape:returnSelf()

	local minFromDistance = INT_MAX
	local minNode = false
	local fromX, fromZ = BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex)

	for _, node in self._nodeArray:ipairs() do
		if node.isCanAttackTarget and maxDistance <= node.distance then
			node:calculateDistanceToFrom(fromX, fromZ)

			if minFromDistance >= node.fromDistance then
				minFromDistance = node.fromDistance
				minNode = node
			end
		end
	end

	if minNode then
		minNode.isBestCanAttackTarget = true
	end
end

function BattlePathFinder:_walkOnNodeForCanAttackTarget(node, openList, shape, targetNode)
	node.isClosed = true

	local isInAttackShape = self:_isNodeCanAttackTarget(node, targetNode, shape)

	if isInAttackShape then
		local neighbors = node:getNeighbors()

		for _, neighborNode in pairs(neighbors) do
			if not neighborNode.isClosed then
				table.insert(openList, neighborNode)
			end
		end
	end

	node.isCanAttackTarget = isInAttackShape and node.isStopable
end

function BattlePathFinder:_isNodeCanAttackTarget(node, targetNode, shape)
	local unionIndex = node:getUnionIndex()
	local targetUnionIndex = targetNode:getUnionIndex()

	return BattleShapeUtil.contains(unionIndex, shape, targetUnionIndex, unionIndex)
end

function BattlePathFinder:_findNearestAttackUnionIndexBaseOnSignResult(unit, attackUnionIndex)
	for _, node in self._nodeArray:ipairs() do
		if node.isBestCanAttackTarget then
			return BoardIndexConverter.coordinatesToUnionIndex(node:getCoordinates())
		end
	end
end

function BattlePathFinder:_walkOnNodeForNearestAttackUnionIndex(node, openList, unit)
	node.isClosed = true

	local neighbors = node:getNeighbors()

	for _, neighborNode in pairs(neighbors) do
		if not neighborNode.isClosed and neighborNode.isEnable and not neighborNode.fromNode then
			neighborNode.fromNode = node

			table.insert(openList, neighborNode)
		end
	end
end

function BattlePathFinder:_findPathBaseOnSignResult(unit, fromUnionIndex, toUnionIndex)
	local boardModel = self._boardModel
	local nodeArray = self._nodeArray
	local transform = unit.transform
	local fromX, fromZ = BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex)
	local toX, toZ = BoardIndexConverter.unionIndexToCoordinates(toUnionIndex)

	for _, node in self._nodeArray:ipairs() do
		node:resetForFindPath()
		node:calculateDistance(toX, toZ)
	end

	if unit.property:isStateActive(BattleEnum.State.IGNORE_BARRIER) then
		local nodeFrom = nodeArray:getElement(fromX, fromZ)
		local nodeTo = nodeArray:getElement(fromX, fromZ)

		nodeTo.fromNode = nodeFrom

		return
	end

	local openList = tempOpenList

	BattleTableUtil.clearTable(openList)

	local node = nodeArray:getElement(fromX, fromZ)

	table.insert(openList, node)

	while #openList > 0 do
		table.sort(openList, sort_on_distance)
		self:_walkOnNodeForPath(table.remove(openList), openList, unit)
	end
end

function BattlePathFinder:_walkOnNodeForPath(node, openList, unit)
	node.isClosed = true

	local transform = unit.transform
	local boardModel = self._boardModel
	local neighbors = node:getNeighbors()

	for _, neighborNode in pairs(neighbors) do
		if not neighborNode.isClosed and neighborNode.isEnable and not neighborNode.fromNode then
			neighborNode.fromNode = node

			table.insert(openList, neighborNode)
		end
	end
end

function BattlePathFinder:_findPathToList(toUnionIndex, resultList)
	BattleTableUtil.clearTable(resultList)

	local toX, toZ = BoardIndexConverter.unionIndexToCoordinates(toUnionIndex)
	local node = self._nodeArray:getElement(toX, toZ)
	local count = MAX_LOOP_COUNT

	while node and count > 0 do
		table.insert(resultList, BoardIndexConverter.coordinatesToUnionIndex(node:getCoordinates()))

		node = node.fromNode
		count = count - 1
	end
end

return BattlePathFinder_private
