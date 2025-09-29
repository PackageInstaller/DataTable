-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompSkillAreaWarning.lua

module("logic.battle.unit.comp.BattleUnitCompSkillAreaWarning", package.seeall)

local BattleUnitCompSkillAreaWarning = class("BattleUnitCompSkillAreaWarning", BattleUnitCompBase)
local kMaxWarningHeight = 5

function BattleUnitCompSkillAreaWarning:onInit()
	self._cacheObjects = {}
	self._goSkillWarningList = {}
	self._shape = false
end

function BattleUnitCompSkillAreaWarning:onReset()
	self._aoeId = 0

	self:_clearFollowUnit()
	self:_clearSkillArea()
	self:_clearCaches()
end

function BattleUnitCompSkillAreaWarning:onDestroy()
	self:onReset()
end

function BattleUnitCompSkillAreaWarning:showFixedSkillArea(aoeId, shapeWithRoot, skillCode)
	self:_clearFollowUnit()

	self._aoeId = aoeId
	self._skillCode = skillCode

	self:_setShapeByShapeWithRootNO(shapeWithRoot)

	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(shapeWithRoot.root.x, shapeWithRoot.root.z)

	self:_showFixedSkillArea(unionIndex, BattleConst.DelayZeroPointFive)
end

function BattleUnitCompSkillAreaWarning:showFollowUnitSkillArea(aoeId, shapeWithRoot, skillCode, unit)
	self:_clearFollowUnit()

	self._aoeId = aoeId
	self._followUnit = unit
	self._skillCode = skillCode

	self:_setShapeByShapeWithRootNO(shapeWithRoot)
	self:_setUnitEvent(true)
	self:_showFixedSkillArea(BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates()), BattleConst.DelayZeroPointFive)
end

function BattleUnitCompSkillAreaWarning:showFollowUnitSkillAreaClient(aoeId, shape, skillCode, unit)
	self:_clearFollowUnit()

	self._aoeId = aoeId
	self._followUnit = unit
	self._skillCode = skillCode

	self:_setShape(shape)
	self:_setUnitEvent(true)
	self:_showFixedSkillArea(BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates()), BattleConst.DelayZeroPointFive)
end

function BattleUnitCompSkillAreaWarning:updateSkillArea(aoeId, shapeWithRoot)
	if self._aoeId ~= aoeId then
		return
	end

	self:_clearSkillArea()
	self:_setShapeByShapeWithRootNO(shapeWithRoot)

	local unionIndex = 0

	if self._followUnit then
		unionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._followUnit.transform:getCoordinates())
	else
		unionIndex = BoardIndexConverter.coordinatesToUnionIndex(shapeWithRoot.root.x, shapeWithRoot.root.z)
	end

	self:_showFixedSkillArea(unionIndex)
end

function BattleUnitCompSkillAreaWarning:clearSkillArea()
	self._aoeId = 0

	self:_clearFollowUnit()
	self:_clearSkillArea()
end

function BattleUnitCompSkillAreaWarning:getSkillId()
	return self._skillCode
end

function BattleUnitCompSkillAreaWarning:_setShapeByShapeWithRootNO(shapeWithRootNO)
	local shape = BattleShapeUtil.createByServerShapeNO(shapeWithRootNO.shape)

	self:_setShape(shape)
end

function BattleUnitCompSkillAreaWarning:_setShape(shape)
	self:_clearShape()

	self._shape = shape
end

function BattleUnitCompSkillAreaWarning:_clearShape()
	if self._shape then
		self._shape:returnSelf()

		self._shape = false
	end
end

function BattleUnitCompSkillAreaWarning:_clearFollowUnit()
	self:_setUnitEvent(false)
	self:_clearShape()

	self._followUnit = false
	self._skillCode = false
end

function BattleUnitCompSkillAreaWarning:_setUnitEvent(add)
	if not self._followUnit then
		return
	end

	if add then
		self._followUnit:addInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
		BattleDispatcher:addEventListener(BattleEventType.OnEntityDead, self._onPosChanged, self)
	else
		self._followUnit:removeInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityDead, self._onPosChanged, self)
	end
end

function BattleUnitCompSkillAreaWarning:_onPosChanged()
	self:_clearSkillWarning()

	local boardMgr = BattleMgr.instance:getBoardMgr()
	local x, z = self._followUnit.mover:getPos()
	local unionIndex = boardMgr:worldPosition2UnionIndex(x, 0, z)

	if unionIndex and unionIndex >= 0 then
		self:_showFixedSkillArea(unionIndex)
	end
end

function BattleUnitCompSkillAreaWarning:_showFixedSkillArea(unionIndex, duration)
	self:_showSkillArea(unionIndex, duration)
end

function BattleUnitCompSkillAreaWarning:_showSkillArea(centerUnionIndex, duration)
	local shape = self._shape

	if shape:getType() == BattleEnum.Shape.WholeBattleBoard then
		return
	end

	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._unit.transform:getCoordinates())
	local outRectangleList = BattleTableUtil.getTempList()

	BattleShapeUtil.calculateBoundingRectangleList(outRectangleList, shape, centerUnionIndex, unitUnionIndex)

	for _, rectangle in ipairs(outRectangleList) do
		local fromUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(rectangle:getMinx(), rectangle:getMinz())
		local toUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(rectangle:getMaxx(), rectangle:getMaxz())

		self:_createWarningGameObject(fromUnionIndex, toUnionIndex)
	end

	BattleTableUtil.clearReusableTable(outRectangleList)
	BattleTableUtil.releaseTempList(outRectangleList)
end

function BattleUnitCompSkillAreaWarning:_getNearestActiveUnionIndex(unionIndex)
	local boardModel = BattleMgr.instance:getBoardModel()
	local checkerBoardMO = boardModel:getActiveBoardMO()
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

	if not checkerBoardMO:isValideCoordinates(x, z) then
		x, z = checkerBoardMO:getNearestActiveXZ(x, z)

		return BoardIndexConverter.coordinatesToUnionIndex(x, z)
	else
		return unionIndex
	end
end

function BattleUnitCompSkillAreaWarning:_createWarningGameObject(fromUnionIndex, toUnionIndex)
	fromUnionIndex = self:_getNearestActiveUnionIndex(fromUnionIndex)
	toUnionIndex = self:_getNearestActiveUnionIndex(toUnionIndex)

	local x1, z1 = BoardIndexConverter.unionIndexToCoordinates(fromUnionIndex)
	local x2, z2 = BoardIndexConverter.unionIndexToCoordinates(toUnionIndex)

	if x2 < x1 then
		x1, x2 = BattleMathUtil.swap(x1, x2)
	end

	if z2 < z1 then
		z1, z2 = BattleMathUtil.swap(z1, z2)
	end

	local goSkillWarning = self:_getOrCreateWarningGameObject()
	local boundingBox = SpaceX.FilledBoundingBox.Get(goSkillWarning)

	boundingBox:Clear()

	for x = x1, x2 do
		for z = z1, z2 do
			boundingBox:AddVertex(x, z)
		end
	end

	boundingBox:Rebuild()
end

function BattleUnitCompSkillAreaWarning:_getOrCreateWarningGameObject()
	local goSkillWarning = table.remove(self._cacheObjects)

	if not goSkillWarning then
		local resMgr = BattleMgr.instance:getResourceMgr()

		goSkillWarning = resMgr:getInst(BattleResourceName.SkillWarningSign)

		local boardModel = BattleMgr.instance:getBoardModel()
		local boardMO = boardModel:getActiveBoardMO()
		local position = boardMO:getInitPosition()

		Astral.TransformUtil.SetPos(goSkillWarning.transform, position.x, BattleConst.YOffsetDangerArea, position.z)
		BattleGameObjectRootUtil.addToSignsRoot(goSkillWarning)
	else
		goutil.setActive(goSkillWarning, true)
	end

	table.insert(self._goSkillWarningList, goSkillWarning)

	return goSkillWarning
end

function BattleUnitCompSkillAreaWarning:_clearSkillArea()
	self:_clearSkillWarning()
	self:_clearShape()
end

function BattleUnitCompSkillAreaWarning:_clearSkillWarning()
	for _, goInst in ipairs(self._goSkillWarningList) do
		goutil.setActive(goInst, false)
	end

	BattleTableUtil.insertto(self._cacheObjects, self._goSkillWarningList)
	BattleTableUtil.clearTable(self._goSkillWarningList)
end

function BattleUnitCompSkillAreaWarning:_clearCaches()
	for _, goInst in ipairs(self._cacheObjects) do
		goutil.destroy(goInst)
	end

	BattleTableUtil.clearTable(self._cacheObjects)
end

return BattleUnitCompSkillAreaWarning
