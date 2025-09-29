-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeMultipleShape.lua

module("logic.battle.datadef.shape.implement.BattleShapeMultipleShape", package.seeall)

local BattleShapeMultipleShape = class("BattleShapeMultipleShape", BattleShapeBase)

function BattleShapeMultipleShape:parseServerShapeNO(multipleShapeNO)
	local offsetShapeNOList = multipleShapeNO.offSetShapes

	for _, offsetShapeNO in ipairs(offsetShapeNOList) do
		local offset = offsetShapeNO.offset
		local shape = offsetShapeNO.shape

		table.insert(self._offsetCoordinateList, Coordinates:createInstance(offset.x, offset.z))
		table.insert(self._offsetShapeList, BattleShapeUtil.createByServerShapeNO(shape))
	end

	local centerShapeNOList = multipleShapeNO.centerShapes

	for _, centerShapeNO in ipairs(centerShapeNOList) do
		local center = centerShapeNO.center
		local shape = centerShapeNO.shape

		table.insert(self._centerCoordinateList, Coordinates:createInstance(center.x, center.z))
		table.insert(self._centerShapeList, BattleShapeUtil.createByServerShapeNO(shape))
	end
end

function BattleShapeMultipleShape:getType()
	return BattleEnum.Shape.MultipleShape
end

function BattleShapeMultipleShape:onInit()
	self._centerShapeList = {}
	self._centerCoordinateList = {}
	self._offsetShapeList = {}
	self._offsetCoordinateList = {}
end

function BattleShapeMultipleShape:onReset()
	BattleTableUtil.clearReusableTable(self._centerShapeList)
	BattleTableUtil.clearReusableTable(self._centerCoordinateList)
	BattleTableUtil.clearReusableTable(self._offsetShapeList)
	BattleTableUtil.clearReusableTable(self._offsetCoordinateList)
end

function BattleShapeMultipleShape:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local subShapeContext = BattleShapeContext:createInstance()

	subShapeContext:copyFrom(shapeContext)

	local centerShapeList = self._centerShapeList
	local centerCoordinateList = self._centerCoordinateList

	for index, shape in ipairs(centerShapeList) do
		local center = centerCoordinateList[index]

		subShapeContext:setShapeUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(center:getXZ()))
		shape:calculateBoundingRectangleList(subShapeContext, outRectangleList)
	end

	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(centerUnionIndex)
	local offsetShapeList = self._offsetShapeList
	local offsetCoordinateList = self._offsetCoordinateList

	for index, shape in ipairs(offsetShapeList) do
		local offset = offsetCoordinateList[index]
		local dx, dz = offset:getXZ()

		subShapeContext:setShapeUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(x + dx, z + dz))
		shape:calculateBoundingRectangleList(subShapeContext, outRectangleList)
	end

	subShapeContext:returnSelf()
end

return BattleShapeMultipleShape
