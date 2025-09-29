-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/factory/UnitFactory.lua

module("logic.scene.factory.UnitFactory", package.seeall)

local M = class("UnitFactory", UnitFactoryBase)
local unitId = 0

function M:ctor(scene)
	M.super.ctor(self, scene)

	self._unitTagMap = {}
	self._unitRoot = false
	self._elevatorUnits = {}
end

function M:addUnit(unit)
	goutil.addChildToParent(unit.go, self._container)

	local tag = unit:getTag()
	local sameUnits = self._units[tag]

	if not sameUnits then
		sameUnits = {}
		self._units[tag] = sameUnits
	end

	sameUnits[unit.id] = unit
end

function M:removeUnit(unitTag, id)
	local sameUnits = self._units[unitTag]

	if sameUnits then
		local unit = sameUnits[id]

		if unit then
			sameUnits[id] = nil

			unit:returnSelf()
		end
	end
end

function M:removeAll()
	for k, v in pairs(self._units) do
		local sameUnits = v

		for k2, unit in pairs(sameUnits) do
			unit:returnSelf()

			sameUnits[k2] = nil
		end
	end
end

function M:onInit()
	M.super.onInit(self)
	self:registerUnitTagCls(UnitTag.Player, {
		unitCls = UnitPlayer,
		creator = self._createUnitPlayer
	})
	self:registerUnitTagCls(UnitTag.MainPlayer, {
		unitCls = UnitMainPlayer,
		creator = self._createUnitMainPlayer
	})
	self:registerUnitTagCls(UnitTag.Npc, {
		unitCls = UnitHouseRobot,
		creator = self._createUnitHouseRobot
	})
	self:registerUnitTagCls(UnitTag.ElevatorNpc, {
		unitCls = ElevatorLevel,
		creator = self._createUnitElevator
	})
end

function M:registerUnitTagCls(unitTag, createInfo)
	self._unitTagMap[unitTag] = createInfo
end

function M:createUnit(unitTag, entityInfo)
	local createInfo = self._unitTagMap[unitTag]

	if createInfo then
		local unit = createInfo.creator(self, unitTag, entityInfo, createInfo.unitCls)

		if unitTag == UnitTag.ElevatorNpc then
			self:addElevatorUnit(unit)
		else
			self:addUnit(unit)
		end

		return unit
	end
end

function M:_createBaseUnit(unitTag, entityInfo, cls)
	local goName = unitTag .. "_" .. entityInfo.entityCode
	local unit = cls:createInstance(goName, entityInfo.x or -48.95, entityInfo.y or -28.37, entityInfo.z or -24.47)

	unitId = unitId + 1
	unit.id = unitId

	return unit
end

function M:_createUnitPlayer(unitTag, entityInfo, unitCls)
	local unit = self:_createBaseUnit(unitTag, entityInfo, unitCls)

	unit.heroId = entityInfo.entityCode

	local url, modelCO = HouseSceneUtil.getNormalMeshUrl(entityInfo.entityCode)

	unit.meshModel:setBody(url)
	unit.uiFollow:setPerspectiveArgs(12, 0.35, 1.5)
	unit.uiFollow:setPerspectiveEnable(true)
	unit.progressBar:refreshMood()
	unit.namebar:showByData()
	unit.navMesh:setNeedResetNavMesh(true)
	unit.navMesh:setAgentSpeed(CommEnum.NavMeshAgentSpeed.HeroWalk)
	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMeshMover:initStatus()
	unit.ai:buildAI(HouseEnum.AI.Default)
	unit.ai:tryStart()

	return unit
end

function M:_createUnitMainPlayer(unitTag, entityInfo, unitCls)
	local unit = self:_createBaseUnit(unitTag, entityInfo, unitCls)

	unit.mountRoot:setAvatarRootPos(0, 0.5, 0)

	local modelCO = ModelConfig.instance:getModelConfig(entityInfo.entityCode)

	unit.meshModel:setBody(GameUrl.getHouseMeshModelUrl(modelCO.houseResName))
	unit.navMesh:setUpdateUpAxis(false)

	if self._scene.setMainPlayer then
		self._scene:setMainPlayer(unit)
	end

	return unit
end

function M:_createUnitHouseRobot(unitTag, entityInfo, unitCls)
	local unit = self:_createBaseUnit(unitTag, entityInfo, unitCls)

	unit.mountRoot:setAvatarRootPos(0, 0.5, 0)
	unit.meshModel:setBody(GameUrl.getHouseMeshModelUrl("110001_luojiji1hao"))
	unit.navMesh:setNeedResetNavMesh(true)

	return unit
end

function M:addElevatorUnit(unit)
	self._elevatorUnits[unit.id] = unit
end

function M:getElevatorUnit(id)
	return self._elevatorUnits[id]
end

function M:createAllElevatorUnit()
	local elevatorCOs = HouseConfig.instance:getConfigList(ConfigName.Elevator)

	for _, elevatorCO in ipairs(elevatorCOs) do
		self:createUnit(UnitTag.ElevatorNpc, {
			entityCode = elevatorCO.id,
			configInfo = elevatorCO
		})
	end
end

function M:_createUnitElevator(unitTag, entityInfo)
	local unit = false
	local cls
	local elevatorCO = entityInfo.configInfo
	local type = elevatorCO.type or 0

	if type == SceneEnum.Elevator.Level then
		cls = ElevatorLevel
	elseif type == SceneEnum.Elevator.Lobby then
		cls = ElevatorLobby
	end

	if cls and elevatorCO and not string.nilorempty(elevatorCO.rootPath) then
		local goUnit = goutil.findChild(self._scene.stage:getHouseRootGo(), elevatorCO.rootPath)

		if goUnit then
			unit = Astral.LuaComponentContainer.Add(goUnit, cls)
			unit.id = elevatorCO.id

			unit:setConfig(elevatorCO)
		else
			printWarn("找不到电梯节点，路径：", elevatorCO.rootPath)
		end
	end

	return unit
end

function M:removeAllElevator()
	for k2, unit in pairs(self._elevatorUnits) do
		unit:clear()
		Astral.LuaComponentContainer.Remove(unit.go, ElevatorLevel)
		Astral.LuaComponentContainer.Remove(unit.go, ElevatorLobby)
	end

	self._elevatorUnits = {}
end

return M
