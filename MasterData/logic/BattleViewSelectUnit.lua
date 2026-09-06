-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleViewSelectUnit.lua

module("logic.extensions.guide.view.BattleViewSelectUnit", package.seeall)

local BattleViewSelectUnit = class("BattleViewSelectUnit", ViewComponent)

function BattleViewSelectUnit:buildUI()
	self._camera = self:getGo("Camera"):GetComponent("Camera")

	CameraRectSetter.CalcRect(self._camera)
end

function BattleViewSelectUnit:onEnter()
	BattleViewSelectUnit.super.onEnter(self)

	self._itemTargets = self:getFirstParam()

	self:_initUICameraParams()
	self:_saveUnitsPlayer()
	self:_setUnitsPlayer()
	self:_saveUnitsHUDs()
end

function BattleViewSelectUnit:onExit()
	self:_resumeUnitsPlayer()
	self:_resumeUnitHuds()
	BattleViewSelectUnit.super.onExit(self)
end

function BattleViewSelectUnit:_initUICameraParams()
	local mainCamera

	if self._itemTargets and #self._itemTargets > 0 and (SceneLayer.SkillEffects_Value == self._itemTargets[1].go.layer or SceneLayer.SkillEffects_II_Value == self._itemTargets[1].go.layer) then
		local cameras = AMMirrorCamera.mirrorCameras

		if cameras.Count > 0 then
			for i = 0, cameras.Count - 1 do
				mainCamera = cameras[i]:GetCamera()

				if mainCamera.gameObject.activeSelf then
					break
				end
			end
		end
	end

	if mainCamera == nil then
		mainCamera = GlobalModel.instance.mainCamera
	end

	local posX, posY, posZ = Framework.TransformUtil.GetPos(mainCamera.transform, nil, nil, nil)
	local rotX, rotY, rotZ = Framework.TransformUtil.GetLocalRotation(mainCamera.transform, nil, nil, nil)

	Framework.TransformUtil.SetPos(self._camera.transform, posX, posY, posZ)
	Framework.TransformUtil.SetLocalRotation(self._camera.transform, rotX, rotY, rotZ)

	self._camera.orthographic = mainCamera.orthographic
	self._camera.farClipPlane = mainCamera.farClipPlane
	self._camera.orthographic = mainCamera.orthographic
	self._camera.orthographicSize = mainCamera.orthographicSize
	self._camera.fieldOfView = mainCamera.fieldOfView
end

function BattleViewSelectUnit:_saveUnitsPlayer()
	self._layers = {}

	for i = 1, #self._itemTargets do
		self._layers[self._itemTargets[i]] = self._itemTargets[i].go.layer
	end
end

function BattleViewSelectUnit:_setUnitsPlayer()
	for i = 1, #self._itemTargets do
		Framework.GameObjectUtil.SetLayerRecursively(self._itemTargets[i].go, SceneLayer.UI2_Value)
	end
end

function BattleViewSelectUnit:_resumeUnitsPlayer()
	for i = 1, #self._itemTargets do
		if self._itemTargets[i].go then
			Framework.GameObjectUtil.SetLayerRecursively(self._itemTargets[i].go, self._layers[self._itemTargets[i]])
		end
	end

	self._layers = nil
end

function BattleViewSelectUnit:_saveUnitsHUDs()
	self._huds = {}

	for i = 1, #self._itemTargets do
		local unit = self._itemTargets[i]
		local saveHud = unit.unitUI._goNameBar
		local followTgt = saveHud:GetComponent(ComponentType.UIFollowTarget)

		self._huds[unit] = {
			parent = saveHud.transform.parent,
			gameCamera = followTgt.gameCamera,
			uiCamera = followTgt.uiCamera,
			canvas = followTgt.canvas,
			offsetZ = followTgt.offsetZ
		}
		followTgt.gameCamera = self._camera
		followTgt.uiCamera = GlobalModel.instance.uiCamera
		followTgt.canvas = GlobalModel.instance.uiCanvas
		followTgt.offsetZ = 3600

		local nameBarRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

		saveHud.transform:SetParent(nameBarRoot.transform)
	end
end

function BattleViewSelectUnit:_resumeUnitHuds()
	for i = 1, #self._itemTargets do
		local unit = self._itemTargets[i]
		local config = self._huds[unit]
		local saveHud = unit.unitUI._goNameBar

		if saveHud then
			local followTgt = saveHud:GetComponent(ComponentType.UIFollowTarget)

			followTgt.gameCamera = config.gameCamera
			followTgt.uiCamera = config.uiCamera
			followTgt.canvas = config.canvas
			followTgt.offsetZ = config.offsetZ

			saveHud.transform:SetParent(config.parent)
		end
	end

	self._huds = nil
end

return BattleViewSelectUnit
