-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeParallelRectangle.lua

module("logic.battle.datadef.shape.implement.BattleShapeParallelRectangle", package.seeall)

local BattleShapeParallelRectangle = class("BattleShapeParallelRectangle", BattleShapeBase)

function BattleShapeParallelRectangle:parseServerShapeNO(parallelRectangleNO)
	self._width = parallelRectangleNO.width
	self._height = parallelRectangleNO.height
	self._offset = parallelRectangleNO.offset
end

function BattleShapeParallelRectangle:parseShapeConfig(shapeConfig)
	self._width = shapeConfig.width
	self._height = shapeConfig.height
	self._offset = shapeConfig.offset
end

function BattleShapeParallelRectangle:getType()
	return BattleEnum.Shape.ParallelRectangle
end

function BattleShapeParallelRectangle:onInit()
	self._width = false
	self._height = false
	self._offset = false
end

function BattleShapeParallelRectangle:onReset()
	self._width = false
	self._height = false
	self._offset = false
end

function BattleShapeParallelRectangle:equals(other)
	return self:getType() == other:getType() and self._width == other._width and self._height == other._height and self._offset == other._offset
end

function BattleShapeParallelRectangle:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local z1 = z + self._offset
	local z2 = z - self._offset
	local halfWidth = (self._width - 1) / 2
	local halfHeight = (self._height - 1) / 2
	local flagTable = BattleTableUtil.getTempList()

	for dx = -halfWidth, halfWidth do
		for dz = -halfHeight, halfHeight do
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z1 + dz)

			if not flagTable[unionIndex] then
				flagTable[unionIndex] = true

				table.insert(outUnionIndexList, unionIndex)
			end

			unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x + dx, z2 + dz)

			if not flagTable[unionIndex] then
				flagTable[unionIndex] = true

				table.insert(outUnionIndexList, unionIndex)
			end
		end
	end
end

function BattleShapeParallelRectangle:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local offset = self._offset
	local halfWidth = checkint((self._width - 1) / 2)
	local halfHeight = checkint((self._height - 1) / 2)
	local zOffsetted = z + offset

	table.insert(outRectangleList, Rectangle:createInstance(x - halfWidth, x + halfWidth, zOffsetted - halfHeight, zOffsetted + halfHeight))

	zOffsetted = z - offset

	table.insert(outRectangleList, Rectangle:createInstance(x - halfWidth, x + halfWidth, zOffsetted - halfHeight, zOffsetted + halfHeight))
end

function BattleShapeParallelRectangle:calculateBoundingCircleRadius(shapeContext)
	local widthOrHeight = math.max(self._width, self._height + self._offset + self._offset)

	return math.ceil(widthOrHeight / 2)
end

return BattleShapeParallelRectangle
