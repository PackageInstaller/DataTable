-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/AirCheckerBoardNode.lua

module("logic.extensions.airworkshop.flow.defflow.unit.AirCheckerBoardNode", package.seeall)

local M = class("AirCheckerBoardNode")

function M:ctor(cellMO)
	return
end

function M:reset()
	return
end

function M:calculateManhattanDistance(toX, toZ)
	local x, z = self:getCoordinates()

	self.distance = math.abs(x - toX) + math.abs(z - toZ)
end

function M:calculateDistanceToFrom(fromX, fromZ)
	local x, z = self:getCoordinates()

	self.fromDistance = math.abs(x - fromX) + math.abs(z - fromZ)
end

function M:getNeighbors()
	return self._neighbors
end

function M:getCoordinates()
	return self._cellMO:getCoordinates()
end

function M:getUnionIndex()
	return BoardIndexConverter.coordinatesToUnionIndex(self:getCoordinates())
end

function M:getCellMO()
	return self._cellMO
end

return M
