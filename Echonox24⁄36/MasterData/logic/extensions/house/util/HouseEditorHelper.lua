-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/util/HouseEditorHelper.lua

module("logic.extensions.house.util.HouseEditorHelper", package.seeall)

local M = class("HouseEditorHelper")
local kUnitRoot = goutil.find("UnitRoot")
local kHeroId1 = 2000022
local kHeroId2 = 2000013
local kFurnHeroIds = {
	2000005,
	2000011,
	2000013,
	2000022,
	2000027,
	2000036
}

function M:ctor()
	self._furnUnitId = 0
	self._heroUnits = {}
	self._needLoadHeros = {}
	self._furnSignVisible = false
end

function M:showPerform(performId)
	self:clearPerformData()

	local performCO = HouseConfig.instance:getPerformCO(performId)

	if performCO then
		local heroId1, heroId2 = performCO:getHeroIds()

		heroId1 = heroId1 > 0 and heroId1 or kHeroId1
		heroId2 = heroId2 > 0 and heroId2 or kHeroId2

		if performCO:getPerformType() == HouseEnum.PerformCtrlType.Single then
			self._needLoadHeros = {
				heroId1
			}

			local unit1 = self:createHero(heroId1)

			self._performCtrl = HouseSinglePerformCtrl.New()

			self._performCtrl:setPerformUnits(unit1)
			self._performCtrl:setEndCallback(self._onFinishFurnPerform, self)

			self._performCtrl._usablePerformCOs = {
				performCO
			}
		else
			self._needLoadHeros = {
				heroId1,
				heroId2
			}

			local unit1 = self:createHero(heroId1, -0.5, 0, 2)
			local unit2 = self:createHero(heroId2, 0.5, 0, 2)

			self._performCtrl = HouseDoublePerformCtrl.New()

			self._performCtrl:setPerformUnits(unit1, unit2)
			self._performCtrl:setEndCallback(self._onFinishFurnPerform, self)

			self._performCtrl._usablePerformCOs = {
				performCO
			}
		end
	end
end

function M:breakCurrPerform()
	if self._performCtrl then
		self._performCtrl:showBreakPerformance()
	end
end

function M:createHero(heroId, x, y, z)
	local unit = self:_createHeroUnit(heroId, x, y, z)

	unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	local entityCO = CharacterConfig.instance:getCfgInfoByID(heroId)
	local modelCO = ModelConfig.instance:getModelConfig(entityCO.modelId)

	unit.meshModel:setBody(GameUrl.getHouseMeshModelUrl(modelCO.houseResName))
	unit.uiFollow:setPerspectiveArgs(12, 0.35, 1.5)
	unit.uiFollow:setPerspectiveEnable(true)
	unit.navMesh:setNeedResetNavMesh(true)
	unit.navMesh:setAgentSpeed(CommEnum.NavMeshAgentSpeed.HeroWalk)
	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMeshMover:initStatus()
	goutil.setActive(unit.go, true)

	return unit
end

function M:_createHeroUnit(heroId, x, y, z)
	local goName = UnitTag.Player .. "_" .. heroId
	local unit = UnitPlayer:createInstance(goName, x or 0, y or 0, z or 2)

	unit.id = heroId
	unit.heroId = heroId

	goutil.addChildToParent(unit.go, kUnitRoot)

	self._heroUnits[heroId] = unit

	return unit
end

function M:_resetHeros()
	for id, unit in pairs(self._heroUnits) do
		unit.navMesh:setNavMeshAgentStatus(false)
		unit.navMeshMover:setStopChangeAngle(true)
		unit.ai:setStop(true)
		goutil.setActive(unit.go, false)
	end
end

function M:_onMeshModelLoaded()
	local hasLoadedAll = true

	for _, id in ipairs(self._needLoadHeros) do
		local unit = self._heroUnits[id]

		if not unit.meshModel:getInst() then
			hasLoadedAll = false
		end
	end

	if hasLoadedAll then
		if self._isFurniturePerform then
			self:_startFurnPerform()
		else
			self:_startPerform()
		end
	end
end

function M:_startPerform()
	if self._isPerforming then
		return
	end

	self._isPerforming = true

	for _, unit in pairs(self._heroUnits) do
		unit.navMesh:setNavMeshAgentStatus(false)
		unit.navMeshMover:setStopChangeAngle(true)
	end

	self._performCtrl._performUnitA.navMeshMover:setDirection(HouseEnum.UnitDirection.Right)

	if self._performCtrl:getCtrlType() == HouseEnum.PerformCtrlType.Double then
		self._performCtrl._performUnitB.navMeshMover:setDirection(HouseEnum.UnitDirection.Left)
	end

	self._performCtrl:showPerformance()
end

function M:clearPerformData()
	self._isPerforming = false

	if self._performCtrl then
		self._performCtrl:clear()
	end

	self._performCtrl = nil

	for _, unit in pairs(self._heroUnits) do
		unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
		unit.meshModel:clear()
		unit:returnSelf()
	end

	table.clear(self._heroUnits)

	self._needLoadHeros = {}

	if self._furnPerformCtrl then
		self._furnPerformCtrl:returnSelf()
	end

	self._furnPerformCtrl = nil

	if self._furnUnit then
		self._furnUnit:returnSelf()
	end

	self._furnUnit = nil
	self._isFurniturePerform = false
	self._furnPerformCO = nil
	self._furnHeroIdList = nil
	self._furnHeroList = nil
end

function M:showFurniturePerform(performId, heroList)
	self:clearPerformData()

	self._isFurniturePerform = true
	self._furnPerformCO = HouseConfig.instance:getFurnPerformCO(performId)
	self._furnHeroIdList = heroList
	self._furnUnit = self:createFurniture(self._furnPerformCO:getFurnitureId())
end

function M:setSignVisible(visible)
	self._furnSignVisible = visible

	self:_refreshFurnSignVisible()
end

function M:_refreshFurnSignVisible()
	if self._furnUnit then
		if self._furnSignVisible then
			self._furnUnit.perform:showSignGOs()
		else
			self._furnUnit.perform:hideSignGOs()
		end
	end
end

function M:createFurniture(furnitureId)
	self._furnUnitId = self._furnUnitId + 1

	local unitName = string.format("Furniture_%s", self._furnUnitId)
	local unit = HouseFurnitureUnit:createInstance(unitName)

	unit.id = self._furnUnitId

	goutil.addChildToParent(unit.go, kUnitRoot)
	unit.model:setFurnitureId(furnitureId)
	unit.model:setAngle(0)

	local y = unit.model:getOperaType() == HouseEnum.FurnitureOperaType.Ceiling and 4.5 or 0

	Astral.TransformUtil.SetLocalPos(unit.go.transform, 0, y, 2)
	unit:addInnerEventListener(UnitActionType.FurnitureLoaded, self._onFurnitureLoaded, self)
	unit.resLoader:loadRes()

	return unit
end

function M:_onFurnitureLoaded()
	self._furnHeroList = {}

	for i = 1, self._furnPerformCO:getTriggerCount() do
		local heroId = self._furnHeroIdList[i] or kFurnHeroIds[i]
		local unit = self:createHero(heroId, i, 0, 2)

		table.insert(self._furnHeroList, unit)
	end

	self:_refreshFurnSignVisible()
end

function M:_startFurnPerform()
	if self._isPerforming then
		return
	end

	self._isPerforming = true

	local idxs = self._furnPerformCO:getTriggerIdxs()
	local dictUnits = {}

	for i, idx in ipairs(idxs) do
		dictUnits[idx] = self._furnHeroList[i]
	end

	self._furnPerformCO:cachePerformDatas(self._furnUnit, dictUnits)

	self._furnPerformCtrl = FurniturePerformCtrl:createInstance()

	self._furnPerformCtrl:showPerformanceImmediate(self._furnPerformCO)
	self._furnPerformCtrl:setEndCallback(self._onFinishFurnPerform, self)
end

function M:_onFinishFurnPerform()
	self:_resetHeros()
end

M.instance = M.New()

return M
