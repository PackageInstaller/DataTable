-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeCircle.lua

module("logic.battle.datadef.shape.implement.BattleShapeCircle", package.seeall)

local BattleShapeCircle = class("BattleShapeCircle", BattleShapeBase)

function BattleShapeCircle:parseServerShapeNO(circleNO)
	self._radius = circleNO.radius
end

function BattleShapeCircle:parseShapeConfig(shapeConfig)
	self._radius = shapeConfig.range
end

function BattleShapeCircle:getType()
	return BattleEnum.Shape.Circle
end

function BattleShapeCircle:getServerName()
	return "circle"
end

function BattleShapeCircle:onInit()
	self._radius = false
end

function BattleShapeCircle:onReset()
	self._radius = false
end

function BattleShapeCircle:equals(other)
	return self:getType() == other:getType() and self._radius == other._radius
end

function BattleShapeCircle:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local radius = self._radius

	if radius <= 0 then
		table.insert(outUnionIndexList, centerUnionIndex)
	else
		local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)

		for dx = -radius, radius do
			for dz = -radius, radius do
				local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z + dz)

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	end
end

function BattleShapeCircle:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local shapeUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(shapeUnionIndex)
	local radius = self._radius
	local rectangle = Rectangle:createInstance(x - radius, x + radius, z - radius, z + radius)

	table.insert(outRectangleList, rectangle)
end

function BattleShapeCircle:calculateBoundingCircleRadius(shapeContext)
	return self._radius
end

function BattleShapeCircle:contains(shapeContext, inputUnionIndex)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local tx, tz = BoardIndexConverter.unionIndexToCoordinates(inputUnionIndex)
	local radius = self._radius

	return radius >= math.abs(tx - x) and radius >= math.abs(tz - z)
end

return BattleShapeCircle
