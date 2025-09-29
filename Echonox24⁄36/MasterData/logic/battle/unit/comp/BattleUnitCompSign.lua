-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompSign.lua

module("logic.battle.unit.comp.BattleUnitCompSign", package.seeall)

local BattleUnitCompSign = class("BattleUnitCompSign", BattleUnitCompBase)
local kColorRed = "#FF0000"

function BattleUnitCompSign:onInit()
	self._goSignList = false
	self._goOperatable = false

	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	self:onReuse()
end

function BattleUnitCompSign:onReuse()
	local signRoot = self._unit.mountRoot:getSignRoot()

	Astral.TransformUtil.SetLocalPos(signRoot.transform, 0, BattleConst.YOffsetSign, 0)
end

function BattleUnitCompSign:onReset()
	self:_clearAllSigns()
end

function BattleUnitCompSign:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	self:onReset()
end

function BattleUnitCompSign:rebuildSigns()
	self:_clearAllSigns()
	self:_createCompositeUnitArea()
end

function BattleUnitCompSign:setOperatableSignVisible(visible)
	if visible then
		self._goOperatable = self._goOperatable or self:_createSignGameObject(BattleResourceName.OperatableSign)

		goutil.setActive(self._goOperatable, true)
	elseif self._goOperatable then
		goutil.setActive(self._goOperatable, false)
	end
end

function BattleUnitCompSign:onUpdateTimeScale(timeScale)
	if self._goSignList then
		for _, goSign in pairs(self._goSignList) do
			local effectControl = EffectControl.Get(goSign)

			effectControl:SetPlaySpeed(timeScale)
		end
	end
end

function BattleUnitCompSign:_createSignGameObject(resPath)
	local resMgr = BattleMgr.instance:getResourceMgr()
	local goSign = resMgr:getInst(resPath)

	goutil.addChildToParent(goSign, self._unit.mountRoot:getSignRoot())

	if not self._goSignList then
		self._goSignList = {}
	end

	table.insert(self._goSignList, goSign)

	local effectControl = EffectControl.Get(goSign)

	effectControl:SetPlaySpeed(BattleTime.timeScale)

	return goSign
end

function BattleUnitCompSign:_clearAllSigns()
	if self._goSignList then
		for _, goSign in pairs(self._goSignList) do
			goutil.destroy(goSign)
		end

		BattleTableUtil.clearTable(self._goSignList)
	end

	self._goOperatable = false
end

function BattleUnitCompSign:_createBoundingBox()
	if not self._unit.transform:isComposite() then
		return
	end

	local goBoundingBoxSign = self:_createSignGameObject(BattleResourceName.BoundingBoxSign)
	local boundingBox = SpaceX.BoundingBox.Get(goBoundingBoxSign)
	local vertices = self._unit.transform:getVertices()

	for _, vertex in pairs(vertices) do
		local vertexX, vertexZ = vertex:getXZ()

		boundingBox:AddVertex(vertexX, vertexZ)
	end

	boundingBox:Rebuild()

	local halfSideLength = SpaceX.CheckBoardSetting.GetHalfSideLength()

	Astral.TransformUtil.SetLocalPos(goBoundingBoxSign.transform, -halfSideLength, 0, -halfSideLength)
end

function BattleUnitCompSign:_createCompositeUnitArea()
	if not self._unit.transform:isComposite() then
		return
	end

	local goBoundingBoxSign = self:_createSignGameObject(BattleResourceName.BossArea)
	local rect = self._unit.transform:getRectangle()
	local x, z = rect:getCenterXZ()
	local width = rect:getMaxx() - rect:getMinx() + 1
	local height = rect:getMaxz() - rect:getMinz() + 1
	local sideLength = SpaceX.CheckBoardSetting.GetSideLength()

	Astral.TransformUtil.SetLocalPos(goBoundingBoxSign.transform, x * sideLength, 0, z * sideLength)
	Astral.TransformUtil.SetLocalScale(goBoundingBoxSign.transform, width * sideLength, 0, height * sideLength)
end

function BattleUnitCompSign:_createModelEffects()
	local modelSlotEffect = ModelConfig.instance:getModelSlotEffectConfig(self._unit.property:getModelCode())

	if not modelSlotEffect then
		return
	end

	local isLowModel = self._unit.meshModel:isLowModel()
	local preEffectCodes = isLowModel and modelSlotEffect.highModelBornEffects or modelSlotEffect.bornEffects

	for _, effectCode in ipairs(preEffectCodes) do
		self._unit.effectPlayer:stopLoopEffect(effectCode)
	end

	local effectCodes = isLowModel and modelSlotEffect.bornEffects or modelSlotEffect.highModelBornEffects

	if not effectCodes then
		return
	end

	local avatarRoot = self._unit.mountRoot:getAvatarRoot()

	for _, effectCode in ipairs(effectCodes) do
		local effectUnit = self._unit.effectPlayer:playLoopEffect(effectCode, avatarRoot)

		effectUnit.transform:setLocalPositionXYZ(0, 0, 0)
	end
end

function BattleUnitCompSign:_onMeshModelLoaded()
	self:_createModelEffects()
end

return BattleUnitCompSign
