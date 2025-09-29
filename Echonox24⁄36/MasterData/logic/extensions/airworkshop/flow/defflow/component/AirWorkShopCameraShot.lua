-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopCameraShot.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopCameraShot", package.seeall)

local M = class("AirWorkShopCameraShot", IBattleFlowComp)

function M:onInit()
	return
end

function M:onStart()
	self._resMgr = self.flow.resMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._model = self.flow.model or false
	self._groupList = {}
end

function M:onClear()
	self._resMgr = false
	self._boardModel = false
	self._unitMgr = false
	self._nodeArray = false

	table.clear(self._groupList)
end

function M:onEnterDone()
	self._cameraGo = goutil.create("AirSaveCamera")
	self._camera = goutil.addComponentOnce(self._cameraGo, ComponentType.Camera)
	self._camera.fieldOfView = 25

	Astral.TransformUtil.SetPos(self._cameraGo.transform, 28, 15, 32)
	Astral.TransformUtil.SetLocalRotation(self._cameraGo.transform, 45, -145, 0)
end

function M:setForCapture()
	local cameraUnit = VirtualCameraMgr.instance:getActiveCamera()
	local vect = cameraUnit:getPosition()

	Astral.TransformUtil.SetPos(self._cameraGo.transform, vect.x, vect.y, vect.z)

	vect = cameraUnit:getRotation()

	Astral.TransformUtil.SetLocalRotation(self._cameraGo.transform, vect.x, vect.y, vect.z)
end

function M:getCamera()
	return self._camera
end

function M:onClear()
	goutil.destroy(self._cameraGo)
end

return M
