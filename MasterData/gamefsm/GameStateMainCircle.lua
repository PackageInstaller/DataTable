-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateMainCircle.lua

local GameState = require("GameFsm/GameState")
local ResClanBattleLayer = require("ClientData/ResClanBattleLayer")
local ResScene = require("ClientData/ResScene")
local DragUtils = Framework.Drag.DragUtils
local CameraManager = Framework.CameraSystem.CameraManager
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local EventConst = require("EventConst")
local GameObject = UnityEngine.GameObject
local LuaToolkit = Framework.Tools.LuaToolkit
local DeviceHelper = require("Helper/DeviceHelper")
local GameSettings = require("Helper/GameSettings")
local DoLoadWaitCircleBattle = require("System/Load/DoLoadWaitCircleBattle")
local SCREEN_RATIO = DeviceHelper.curWidth / DeviceHelper.curHeight
local CAMERA_MODE = {
	FAR = 1,
	NORMAL = 2
}
local CAMERA_CONFIG = {
	[CAMERA_MODE.FAR] = {
		angle = 0,
		height = 55,
		fov = 26
	},
	[CAMERA_MODE.NORMAL] = {
		fov = 26,
		height = 17
	}
}
local BOUNDS = {
	RIGHT = -29.03,
	DOWN = 17.63,
	LEFT = 29.09,
	UP = -13.2
}
local strClassName = "GameStateMainCircle"
local GameStateMainCircle = Class(strClassName, GameState)

function GameStateMainCircle:ctor(name)
	self.sceneNo = self:getSuitableSceneNo()
	self._waitLoadFinishPhase = DoLoadWaitCircleBattle(self)
	self.slotOnSceneUnload = Slot(self.onSceneUnload, self)
	self.xAngle = 36

	EventCenter.addEventListener(EventConst.SCENE_UNLOAD, self.slotOnSceneUnload)
end

function GameStateMainCircle:destroy(...)
	GameStateMainCircle.super.destroy(self)
	EventCenter.removeEventListener(EventConst.SCENE_UNLOAD, self.slotOnSceneUnload)
end

function GameStateMainCircle:onSceneUnload(sceneNo)
	if self.sceneNo == sceneNo then
		self:clear()

		if self.cameraCenterPointGo then
			UnityEngine.Object.Destroy(self.cameraCenterPointGo)

			self.cameraCenterPointGo = nil
		end
	end
end

function GameStateMainCircle:changeScene(sceneNo, finishCB)
	self.isChangeScene = true

	LoadManager.clear()
	SceneManager.addLoadScene(sceneNo)

	self.sceneNo = self:getSuitableSceneNo()

	local function func(...)
		self:onSceneLoaded()
		self:onLoadEnded()
		finishCB()
	end

	LoadManager.start(func)
end

function GameStateMainCircle:getSuitableSceneNo(sceneNo)
	local layer = 1

	if CircleControlCenter.inited then
		layer = CircleControlCenter.getShowLayer()
	elseif CurAvatar and CurAvatar.myCircle then
		layer = CurAvatar.myCircle:getCurBattleLayer()
	end

	local layerData = ResClanBattleLayer[layer]

	if layerData then
		return layerData.scene_id
	end

	return ResClanBattleMisc[1].scenes[1]
end

function GameStateMainCircle:onEnter(preStateName)
	self.sceneNo = self:getSuitableSceneNo()
	self.preStateName = preStateName

	GameStateMainCircle.super.onEnter(self, preStateName)

	if self.preStateName == Const.STATE_MAIN_CIRCLE or self.preStateName == nil and self.parent.preStateName == Const.STATE_BATTLE then
		-- block empty
	else
		LoadManager.addLoadPhase(self._waitLoadFinishPhase)
	end
end

function GameStateMainCircle:onExit(nextStateName)
	GameSettings.resetShadowDistance("CircleBattle")
	GameStateMainCircle.super.onExit(self, nextStateName)
end

function GameStateMainCircle:clear(...)
	if CircleControlCenter.inited then
		CircleControlCenter.destroy()

		if not self.isChangeScene then
			CurAvatar:tryCallCircleBattleRpc("clanBattleExit")
		end
	end
end

function GameStateMainCircle:onSceneLoaded()
	GameStateMainCircle.super.onSceneLoaded(self)

	self.sceneInfo = ResScene[self.sceneNo]
	self.gridAngle = self.sceneInfo.dir or 0
	self.gridDirection = math.rad(self.gridAngle)
	self.leftDir = Vector3(-math.cos(self.gridDirection), 0, -math.sin(self.gridDirection))
	self.upDir = Vector3(-self.leftDir.z, 0, self.leftDir.x)

	local centerPoint = self.sceneInfo.origin_point

	self.centerPoint = Vector3(centerPoint[1], centerPoint[2], centerPoint[3])
	self.nodeTransform = CameraManager.GetControlNodeTransform(CameraModeManager.mainCamera)

	CameraModeManager.setMainStageMode()

	self.nodeTransform.rotation = Quaternion.Euler(self.xAngle, -180, 0)

	if not self.isChangeScene and (self.preStateName == Const.STATE_MAIN_CIRCLE or self.preStateName == nil and self.parent.preStateName == Const.STATE_BATTLE) then
		-- block empty
	else
		CircleControlCenter.init()
		self:changeToFarMode(0)

		self.isPlayCG = false

		local actObj = CurAvatar:getCircleBattleActivity()

		if actObj and actObj.actData then
			local result = actObj.actData:isTodayRecord("EnterCG")

			if not result then
				actObj.actData:setTodayRecord("EnterCG")

				self.isPlayCG = true

				local function callBack(...)
					UIManager.getUI("circleBattleLoadingDlg", true):setData(Slot(self.onFirstCgOver, self))
				end

				local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

				playerDlg:playVideo("Videos/video_ghz.mp4", nil, callBack, true)

				return
			end
		end
	end
end

function GameStateMainCircle:onFirstCgOver()
	self:changeToNearMode()
end

function GameStateMainCircle:onLoadEnded()
	if not self.isChangeScene and (self.preStateName == Const.STATE_MAIN_CIRCLE or self.preStateName == nil and self.parent.preStateName == Const.STATE_BATTLE) then
		self.triggerNear = true
		self.triggerHalfNear = true

		CircleControlCenter.focusOnMe(0)
	else
		CircleControlCenter.postInit()

		if not self.isPlayCG then
			self:changeToNearMode()
		end
	end

	local isActValid = true
	local actObj = CurAvatar:getCircleBattleActivity()

	if actObj then
		if actObj:inCloseState() then
			isActValid = false

			actObj.actData.onStateClose()
		end
	else
		isActValid = false

		local ActivityDataCircleBattle = require("Avatar/AvatarMixins/OpActivity/ActivityDataCircleBattle")

		ActivityDataCircleBattle.onStateClose()
	end

	self:setShadowConfig()
	GameStateMainCircle.super.onLoadEnded(self)

	self.isChangeScene = nil
end

function GameStateMainCircle:setShadowConfig(...)
	GameSettings.setShadowDistance(Const.CIRCLE_BATTLE_SCENE_SHADOW_DIS, "CircleBattle")
end

function GameStateMainCircle:checkBossPos(...)
	local bossWorldPos = CircleControlCenter.isNeedShowBossPos()
	local ui = UIManager.getUI("circleBattleMainDlg", nil, false)

	if not ui then
		return
	end

	if bossWorldPos then
		local ret = CameraManager.GetScreenPos(bossWorldPos)

		if ret.x < 0 or ret.x > DeviceHelper.curWidth or ret.y < 0 or ret.y > DeviceHelper.curHeight then
			local bossUIPos = LuaToolkit.WorldTo2DCameraPos(bossWorldPos)

			ui:checkShowBossPos(true, bossUIPos)
		else
			ui:checkShowBossPos(false)
		end
	else
		ui:checkShowBossPos(false)
	end
end

function GameStateMainCircle:onDrag(offset)
	if not self:isOprateEnable() then
		return
	end

	local vec = Vector3(offset.x, 0, offset.y) * self:getDragRatio()
	local angle = self.nodeTransform.eulerAngles
	local x = -math.cos(math.rad(angle.y)) * vec.x
	local z = math.sin(math.rad(angle.y)) * vec.x
	local z1 = -math.cos(math.rad(angle.y)) * vec.z
	local x1 = -math.sin(math.rad(angle.y)) * vec.z
	local prePos = self.nodeTransform.position
	local _pos = prePos + Vector3(x + x1, 0, z + z1)
	local centerPos = self:_getCameraCenterPos(_pos)

	if centerPos.x > BOUNDS.LEFT or centerPos.x < BOUNDS.RIGHT then
		_pos.x = prePos.x
	end

	if centerPos.z > BOUNDS.DOWN or centerPos.z < BOUNDS.UP then
		_pos.z = prePos.z
	end

	self.nodeTransform.position = _pos

	self:checkBossPos()
end

function GameStateMainCircle:getDragRatio(...)
	return math.tan(math.rad(self.fov * 0.5)) * (self:_getCameraCenterDis() / (DeviceHelper.curHeight * 0.5)) * 1700
end

function GameStateMainCircle:getPosAndFovStartValue(...)
	local pos = self.nodeTransform.position

	return Vector4(pos.x, pos.y, pos.z, CameraManager.CameraGrp:GetNowFov())
end

function GameStateMainCircle:onPinch(delta)
	self.pinchFlag = true
end

function GameStateMainCircle:_pinchCallBack(x, y, z, fov)
	CameraManager.CameraGrp:SetFov(fov, 0)

	self.fov = fov
end

function GameStateMainCircle:_moveCallBack(isAngleChange, x, y, z, fov)
	CameraManager.CameraGrp:SetFov(fov, 0)

	self.fov = fov

	if self.nodeTransform then
		self.nodeTransform.position = Vector3(x, y, z)
	end

	if isAngleChange then
		-- block empty
	end

	if y - CircleControlCenter.getRootPos().y <= CAMERA_CONFIG[CAMERA_MODE.NORMAL].height + 8 then
		self:_onCameraHalfNearFinish()
	end

	if y - CircleControlCenter.getRootPos().y <= CAMERA_CONFIG[CAMERA_MODE.NORMAL].height + 0.5 then
		self:_onCameraNearFinish()
	end
end

function GameStateMainCircle:onDragEnd(delta)
	if delta == nil or self.pinchFlag then
		return
	end

	self.coMoveSlow = coroutine.start(self.coMoveSlowFunc, self, delta)
end

function GameStateMainCircle:onRotateAround(delta)
	self.rotating = true

	if self.nodeTransform then
		local rotateCenterPos = self:_getCameraCenterPos()

		self.nodeTransform:RotateAround(rotateCenterPos, Vector3(0, 1, 0), delta.x)
	end
end

function GameStateMainCircle:onTouchEnd(...)
	self.pinchFlag = false
end

function GameStateMainCircle:onDoubleMove(delta)
	if self.nodeTransform then
		local vec = self.nodeTransform.eulerAngles

		vec.x = math.cos(math.rad(vec.y))
		vec.z = -math.sin(math.rad(vec.y))
		vec.y = 0

		self.nodeTransform:RotateAround(Vector3.zero, vec, delta.y * 10)
	end
end

function GameStateMainCircle:checkShowHighModel(...)
	local tranPos = self.nodeTransform.position
	local models = CircleControlCenter.getAllLodModels()
	local cameraDis = self:_getCameraCenterDis()
	local width = math.tan(math.rad(self.fov * 0.5)) * cameraDis
	local centerPos = self:_getCameraCenterPos()
	local proPos = Vector3(tranPos.x, 0, tranPos.z)
	local cameraProAngle = math.deg(math.atan(width * SCREEN_RATIO / Vector3.Distance(centerPos, proPos)))

	for i, model in ipairs(models) do
		local pos = model:getPos()
		local v1 = pos - proPos
		local v2 = centerPos - proPos
		local angleH = Vector3.Angle(v1, v2)
		local angleV = Vector3.Angle(centerPos - tranPos, pos - tranPos)

		if angleH < cameraProAngle then
			local ratio = 1 + (1 - math.abs(angleH - cameraProAngle) / cameraProAngle) * 0.95

			if angleV < self.fov * 0.5 * ratio then
				-- block empty
			end
		end
	end
end

function GameStateMainCircle:_getCameraCenterPos(fakePos)
	local v0 = fakePos or self.nodeTransform.position
	local v1 = Vector3(v0.x, 0, v0.z)
	local angle = 180 - self.nodeTransform.eulerAngles.y
	local length = (v0.y - CircleControlCenter.getRootPos().y) * math.tan(math.rad(90 - self.nodeTransform.eulerAngles.x))
	local centerPos = Vector3(v1.x + math.sin(math.rad(angle)) * length, CircleControlCenter.getRootPos().y, v1.z - math.cos(math.rad(angle)) * length)

	return centerPos
end

function GameStateMainCircle:focusOnPos(pos, duration, cameraMode)
	cameraMode = cameraMode or CAMERA_MODE.NORMAL

	local info = CAMERA_CONFIG[cameraMode]
	local vec
	local cb = Functor(self._moveCallBack, self, false)

	if self.cameraMode == nil or self.cameraMode ~= cameraMode then
		vec = self:_getFinalCameraPos(info.height, pos)
	else
		vec = self:_getFinalCameraPosNoAngleHeightChange(pos)
	end

	vec.w = info.fov

	local startValue = self:getPosAndFovStartValue()

	CameraManager.CameraGrp:SetFullPosAndFov(startValue, vec, duration, cb, Const.TWEEN_EASE.InOutSine)

	self.cameraMode = cameraMode
end

function GameStateMainCircle:_getFinalCameraPosNoAngleHeightChange(lookPos)
	local curLookPos = self:_getCameraCenterPos()
	local offset = curLookPos - lookPos

	offset.y = 0

	local vec = self.nodeTransform.position - offset

	return vec
end

function GameStateMainCircle:_getFinalCameraPos(cameraHeight, lookPos)
	local xAngle = self.nodeTransform.eulerAngles.x
	local length = cameraHeight * math.tan(math.rad(90 - xAngle))
	local z = lookPos.z + length
	local pos = CircleControlCenter.getRootPos()

	return Vector3(lookPos.x, pos.y + cameraHeight, z)
end

function GameStateMainCircle:_getCameraCenterDis(...)
	local tranPos = self.nodeTransform.position

	return (tranPos.y - CircleControlCenter.getRootPos().y) / math.cos(math.rad(90 - self.nodeTransform.eulerAngles.x))
end

function GameStateMainCircle:isFarMode(...)
	return self:notRealNear()
end

function GameStateMainCircle:isInHalfNear(...)
	if not self.nodeTransform then
		return true
	end

	return self.nodeTransform.position.y - CircleControlCenter.getRootPos().y < CAMERA_CONFIG[CAMERA_MODE.NORMAL].height + 8
end

function GameStateMainCircle:notRealNear(...)
	if not self.nodeTransform then
		return false
	end

	return self.nodeTransform.position.y - CircleControlCenter.getRootPos().y > CAMERA_CONFIG[CAMERA_MODE.NORMAL].height + 0.5
end

function GameStateMainCircle:isOprateEnable(...)
	if self:isFarMode() or CircleControlCenter.isShowPlaying() then
		return false
	end

	return true
end

function GameStateMainCircle:changeToFarMode(duration)
	self:focusOnPos(CircleControlCenter.getRootPos(), duration or Const.CIRCLE_BATTLE_ZOOM_DURATION, CAMERA_MODE.FAR)
	CircleControlCenter.onCameraFar()
end

function GameStateMainCircle:changeToNearMode(...)
	self.triggerNear = true
	self.triggerHalfNear = true

	if CurAvatar.checkFocusMarkGridLayer and CurAvatar.checkFocusMarkGridIndex then
		if CurAvatar.myCircle:checkCanFocusMarkGrid(CurAvatar.checkFocusMarkGridLayer, CurAvatar.checkFocusMarkGridIndex, true) then
			CircleControlCenter.focusOnIndex(CurAvatar.checkFocusMarkGridIndex, Const.CIRCLE_BATTLE_ZOOM_DURATION)
		else
			CircleControlCenter.focusOnMe(Const.CIRCLE_BATTLE_ZOOM_DURATION)
		end

		CurAvatar.checkFocusMarkGridLayer = nil
		CurAvatar.checkFocusMarkGridIndex = nil
	else
		CircleControlCenter.focusOnMe(Const.CIRCLE_BATTLE_ZOOM_DURATION)
	end
end

function GameStateMainCircle:_onCameraHalfNearFinish(...)
	if self.triggerHalfNear then
		CircleControlCenter.onCameraHalfNear()
	end

	self.triggerHalfNear = nil
end

function GameStateMainCircle:_onCameraNearFinish(...)
	if self.triggerNear then
		CircleControlCenter.onCameraNear()
	end

	self.triggerNear = nil
end

function GameStateMainCircle:lookEndShow(duration)
	if not self.cameraCenterPointGo then
		self.cameraCenterPointGo = GameObject("CameraCenterPoint")
	end

	self.cameraCenterPointGo.transform.position = Vector3(25.5, 8.7, 1.84)

	CameraModeManager.setBattleMode()
	CameraManager.SetTarget(self.cameraCenterPointGo, true, 0)
	CameraManager.SetCameraDist(CameraModeManager.battleCamera, 15, 20)
	CameraManager.SetCameraRotation(1, duration or 1.5, 36, 90, 0, 20)
end

function GameStateMainCircle:backToNormalShow(time)
	CameraModeManager.setMainStageMode(time or 1.5)
end

function GameStateMainCircle:lookEndShowAni1(...)
	local cameraPath = "Camera/CameraCurvy/CircleBattle/" .. "anim_Cam_ghz.anim"

	CameraManager.PlayCameraAnimator(cameraPath, nil, nil, 2, 0, 0)
	CameraModeManager.setAnimatorMode(0)

	return 2
end

function GameStateMainCircle.lookEndShowAni2(...)
	local cameraPath = "Camera/CameraCurvy/CircleBattle/" .. "anim_Cam_ghz01.anim"

	CameraManager.PlayCameraAnimator(cameraPath, nil, nil, 1, 0, 0)

	return 1
end

function GameStateMainCircle.onCameraAnimatorOver2(...)
	return
end

function GameStateMainCircle:coMoveSlowFunc(delta)
	delta.x = delta.x * DeviceHelper.curWidth
	delta.y = delta.y * DeviceHelper.curHeight

	local damping = self:getDragRatio() * 100

	while not self.stopCameraMove do
		if math.abs(delta.x) < 0.1 and math.abs(delta.y) < 0.1 then
			break
		else
			delta = delta * 0.87

			self:onDrag(Vector3(delta.x / damping, 0, -delta.y / damping))
		end

		coroutine.step()
	end

	coroutine.stop(self.coMoveSlow)

	self.stopCameraMove = false
	self.coMoveSlow = nil
end

return GameStateMainCircle
