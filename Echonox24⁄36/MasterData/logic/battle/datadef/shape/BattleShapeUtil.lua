-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/BattleShapeUtil.lua

module("logic.battle.datadef.shape.BattleShapeUtil", package.seeall)

local BattleShapeUtil = {}
local kShapeType2ShapeClass = {}
local kShapeType2ShapeName = {}
local kGGG = getglobal("_G")

local function genTable()
	local shapeDefine = BattleEnum.Shape

	for shapeName, shapeType in pairs(shapeDefine) do
		local className = string.format("BattleShape%s", shapeName)
		local shapeClass = kGGG[className]

		kShapeType2ShapeName[shapeType] = shapeName
		kShapeType2ShapeClass[shapeType] = shapeClass
	end
end

genTable()

local function createServerShapeNO(shapeType, shapeNO)
	local shapeClass = kShapeType2ShapeClass[shapeType]

	if not shapeClass then
		if BattleLog.enableError then
			BattleLog.error(string.format("BattleShapeUtil::unhandle ShapeNO %s", shapeType))
		end

		return
	end

	local shape = shapeClass:createInstance()

	shape:parseServerShapeNO(shapeNO)

	return shape
end

function BattleShapeUtil.getShapeTypeByShapeNO(shapeNO)
	for descriptor, value in shapeNO:ListFields() do
		return descriptor.number
	end
end

function BattleShapeUtil.createByServerShapeNO(shapeNO)
	for descriptor, value in shapeNO:ListFields() do
		return createServerShapeNO(descriptor.number, value)
	end
end

function BattleShapeUtil.getShapeName(shapeType)
	return kShapeType2ShapeName[shapeType]
end

function BattleShapeUtil.createShape(shapeType, shapeConfig)
	local shapeClass = kShapeType2ShapeClass[shapeType]
	local shape = shapeClass:createInstance()

	if shapeConfig then
		shape:parseShapeConfig(shapeConfig)
	end

	return shape
end

function BattleShapeUtil.createShapeByName(shapeName, shapeConfig)
	local shapeType = BattleEnum.Shape[shapeName]

	return BattleShapeUtil.createShape(shapeType, shapeConfig)
end

function BattleShapeUtil.calculateCoveredUnionIndexList(outUnionIndexList, shape, shapeUnionIndex, ownerUnionIndex)
	local shapeContext = BattleShapeContext:create(shapeUnionIndex, ownerUnionIndex)
	local uncheckUnionIndexList = BattleTableUtil.getTempList()

	shape:calculateCoveredUnionIndexList(shapeContext, uncheckUnionIndexList)
	BattleShapeUtil.validUnionIndexList(uncheckUnionIndexList, outUnionIndexList)
	shapeContext:returnSelf()
end

function BattleShapeUtil.calculateBoundingRectangleList(outRectangleList, shape, shapeUnionIndex, ownerUnionIndex)
	local shapeContext = BattleShapeContext:create(shapeUnionIndex, ownerUnionIndex)

	shape:calculateBoundingRectangleList(shapeContext, outRectangleList)
	BattleShapeUtil.validRectangleList(outRectangleList)
	shapeContext:returnSelf()
end

function BattleShapeUtil.calculateBoundingCircleRadius(shape, shapeUnionIndex, ownerUnionIndex)
	local shapeContext = BattleShapeContext:create(shapeUnionIndex, ownerUnionIndex)
	local boundingCircleRadius = shape:calculateBoundingCircleRadius(shapeContext, outRectangleList)

	shapeContext:returnSelf()

	return boundingCircleRadius
end

function BattleShapeUtil.contains(inputUnionIndex, shape, shapeUnionIndex, ownerUnionIndex)
	local shapeContext = BattleShapeContext:create(shapeUnionIndex, ownerUnionIndex)
	local isContains = shape:contains(shapeContext, inputUnionIndex)

	shapeContext:returnSelf()

	return isContains
end

function BattleShapeUtil.createShapeByTypeAndRange(shapeType, range)
	local fakeShapeConfig = BattleTableUtil.getTempList()

	if shapeType == BattleEnum.Shape.Circle or shapeType == BattleEnum.Shape.Rhombus or shapeType == BattleEnum.Shape.Sector then
		fakeShapeConfig.range = range
	elseif shapeType == BattleEnum.Shape.Line then
		fakeShapeConfig.length = range
	elseif shapeType == BattleEnum.Shape.Point or shapeType == BattleEnum.Shape.Ray or shapeType == BattleEnum.Shape.WholeBattleBoard then
		-- block empty
	elseif BattleLog.enableError then
		BattleLog.error("unhandle shapeType", shapeType)
	end

	local shape = BattleShapeUtil.createShape(shapeType, fakeShapeConfig)

	BattleTableUtil.releaseTempList(fakeShapeConfig)

	return shape
end

function BattleShapeUtil.validUnionIndexList(uncheckUnionIndexList, outUnionIndexList)
	local boardModel = BattleMgr.instance:getBoardModel()

	for _, unionIndex in ipairs(uncheckUnionIndexList) do
		local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

		if boardModel:isActiveCoordinates(x, z) then
			table.insert(outUnionIndexList, unionIndex)
		end
	end
end

function BattleShapeUtil.validRectangleList(uncheckRectangleList)
	local boardModel = BattleMgr.instance:getBoardModel()
	local boardMO = boardModel:getActiveBoardMO()
	local maxWidth = boardMO:getWidth() - 1
	local maxHeight = boardMO:getHeight() - 1

	for _, rectangle in ipairs(uncheckRectangleList) do
		local minx, maxx, minz, maxz = rectangle:getRanges()

		rectangle:setRanges(math.max(minx, 0), math.min(maxx, maxWidth), math.max(minz, 0), math.min(maxz, maxHeight))
	end
end

return BattleShapeUtil
