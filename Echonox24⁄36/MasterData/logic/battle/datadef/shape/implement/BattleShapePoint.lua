-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapePoint.lua

module("logic.battle.datadef.shape.implement.BattleShapePoint", package.seeall)

local BattleShapePoint = class("BattleShapePoint", BattleShapeBase)

function BattleShapePoint:parseServerShapeNO(shapeNO)
	return
end

function BattleShapePoint:parseShapeConfig(shapeConfig)
	return
end

function BattleShapePoint:getType()
	return BattleEnum.Shape.Point
end

function BattleShapePoint:equals(other)
	return self:getType() == other:getType()
end

function BattleShapePoint:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()

	table.insert(outUnionIndexList, centerUnionIndex)
end

function BattleShapePoint:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)

	table.insert(outRectangleList, Rectangle:createInstance(x, x, z, z))
end

function BattleShapePoint:calculateBoundingCircleRadius(shapeContext)
	return 1
end

function BattleShapePoint:contains(shapeContext, inputUnionIndex)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()

	return centerUnionIndex == inputUnionIndex
end

return BattleShapePoint
