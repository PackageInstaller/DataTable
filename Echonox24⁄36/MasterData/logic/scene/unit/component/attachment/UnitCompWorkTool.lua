-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/attachment/UnitCompWorkTool.lua

module("logic.scene.unit.component.attachment.UnitCompWorkTool", package.seeall)

local M = class("UnitCompWorkTool", UnitComponentBase)
local ModelName = HouseEnum.ModelName
local ToolOffsetPos = {
	[ModelName.ToolComputer] = {
		z = 0.7,
		x = 0,
		y = 0.9
	},
	[ModelName.ToolBook] = {
		z = 0.7,
		x = 0,
		y = 0.9
	}
}
local ContainerRootName = "WorkToolRoot"

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = nil
	self._goModelInst = nil
	self._goInstContainer = nil
	self._workPoint = nil
end

function M:onInit()
	M.super.onInit(self)

	self._resLoader = SingleResLoader.New()
	self._resTimer = SchedulerCtrl.New(self._startLoadWorkTool, self)
	self._workPoint = Vector3.New()
end

function M:onReset()
	if self._resLoader then
		self._resLoader:clear()
	end

	if self._goInstContainer then
		goutil.destroy(self._goInstContainer)

		self._goInstContainer = false
	end

	self._resTimer:stop()

	self._goModelInst = nil
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._resTimer:clear()

	self._resTimer = nil

	if self._goInstContainer then
		goutil.destroy(self._goInstContainer)
	end

	self._goModelInst = nil
	self._goInstContainer = nil

	if self._resLoader then
		self._resLoader:clear()
	end

	self._resLoader = nil
end

function M:createWorkTool(delayTime, workPoint)
	self._workPoint = workPoint

	if not self._goModelInst then
		if delayTime then
			self._resTimer:restart(delayTime, false)
		else
			self:_startLoadWorkTool()
		end
	end
end

function M:_startLoadWorkTool()
	local workType = self._unit.scheduleModel:getWorkType()
	local url = GameUrl.getHouseMeshModelUrl(HouseEnum.WorkType2ToolUrl[workType])

	if self._resLoader:getResource() and self._resLoader:isSameResource(url) then
		self:_onResLoaded()
	else
		self._resLoader:load(url, self._onResLoaded, self)
	end
end

function M:_onResLoaded()
	if self._goModelInst then
		return
	end

	self._goModelInst = self._resLoader:getResInstance()
	self._goInstContainer = goutil.create(string.format("WorkTool_%s", self._unit.heroId), false)

	goutil.setActive(self._goInstContainer, false)

	local parentGo = self:_getContainerRoot()

	goutil.addChildToParent(self._goInstContainer, parentGo)
	goutil.addChildToParent(self._goModelInst, self._goInstContainer)

	local rotaX, rotaY, rotaZ = self._unit.navMeshMover:getRotationWithDir(-self._workPoint.rot.y)

	Astral.TransformUtil.SetLocalRotation(self._goInstContainer.transform, rotaX, rotaY, rotaZ)

	local workType = self._unit.scheduleModel:getWorkType()
	local offset = ToolOffsetPos[HouseEnum.WorkType2ToolUrl[workType]]
	local unitGo = self._unit.navMesh:getNavMeshGo()
	local offf = unitGo.transform.localRotation * Vector3.New(offset.x, offset.y, offset.z)
	local toolOffset = unitGo.transform.position + offf

	Astral.TransformUtil.SetPos(self._goInstContainer.transform, toolOffset.x, toolOffset.y, toolOffset.z)
	goutil.setActive(self._goInstContainer, true)
end

function M:removeWorkTool()
	self._resTimer:stop()
	self:_onRealRemove()
end

function M:_onRealRemove()
	if self._goInstContainer then
		goutil.destroy(self._goInstContainer)
	end

	self._goModelInst = nil
	self._goInstContainer = nil
end

function M:_getToolPosByOffset(offsetX, offsetY)
	local unitPosX, unitPosY, unitPosZ = self._unit.navMesh:getNavMeshGoPos()
	local roomId = self._unit.navMesh:getCurZoneId()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)
	local angle = roomCO.angle
	local posX, posY = HouseSceneUtil.getPosByScreenOffset(unitPosX, unitPosY, angle, offsetX, offsetY)

	return posX, posY
end

function M:_getContainerRoot()
	local sceneContainer = SceneMgr.instance:getCurScene():getContainer()
	local goContainer = goutil.findChild(sceneContainer, ContainerRootName)

	if not goContainer then
		goContainer = goutil.create(ContainerRootName, false)

		goutil.addChildToParent(goContainer, sceneContainer)
	end

	return goContainer
end

return M
