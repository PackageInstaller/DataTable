-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateMainRearHouse.lua

local GameState = require("GameFsm/GameState")
local ResScene = require("ClientData/ResScene")
local UIUtils = require("Framework.UI.UIUtils")
local GameSettings = require("Helper/GameSettings")
local ResRearHouseLockAreaConfig = require("ClientData/ResRearHouseLockAreaConfig")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local DeviceHelper = require("Helper/DeviceHelper")
local DoLoadWaitRearHouse = require("System/Load/DoLoadWaitRearHouse")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local RearHouseModelManager = require("Logic/RearHouse/RearHouseModelManager")
local RearHouseDragWall = require("Logic/RearHouse/RearHouseDragWall")
local RearHouseNewCrystalDlg = require("Logic/SceneUI/RearHouseNewCrystalDlg")
local CameraManager = Framework.CameraSystem.CameraManager
local GameObject = UnityEngine.GameObject
local strClassName = "GameStateMainRearHouse"
local GameStateMainRearHouse = Class(strClassName, GameState)
local UI_OFFSET = Vector2(237 / UIUtils.GetCurDesignWidth(), 200 / UIUtils.GetCurDesignHeight())
local SCREEN_RATIO = DeviceHelper.curWidth / DeviceHelper.curHeight
local MAX_Z = 54.8
local csharpScale = 1

if SCREEN_RATIO < 1.7777777777777777 then
	csharpScale = SCREEN_RATIO / 1.7777777777777777
end

local csharpScaleAll = SCREEN_RATIO / 1.7777777777777777
local DURATION_PERFOV = 0.08
local CAMERA_START_DEFAULT_Y = 15.8
local CAMERA_MODE = {
	{
		fov = 9.3,
		pos = Vector3(27.22, 15.09, 29.885)
	},
	{
		fov = 20,
		pos = Vector3(33.92, 15.87, 42.45)
	},
	{
		fov = 30,
		pos = Vector3(32.445, 15.8, 54.8)
	}
}
local DURATION_CONFIG = {
	f2f = 1.1,
	f2o = 0.8,
	o2f = 0.8
}
local BOUNDS_TYPE = {
	EDIT_ZOOM = 2,
	EDIT_MOVE = 1,
	MAIN_ZOOM = 4,
	MAIN_MOVE = 3
}

function GameStateMainRearHouse:ctor(name)
	self.sceneNo = 7
	self._waitLoadFinishPhase = DoLoadWaitRearHouse(self)
end

function GameStateMainRearHouse:onEnter(preStateName)
	GameStateMainRearHouse.super.onEnter(self, preStateName)
	RearHouseModelManager.init(self)

	self.limitHeight = nil
	self.curCameraMode = 3
	self.isInitIn = true
	self.debugTime = Time.time

	LoadManager.addLoadPhase(self._waitLoadFinishPhase)
end

function GameStateMainRearHouse:onExit(nextStateName)
	self:setCameraOrthographic(false)
	RearHouseDragCenter.destroy()
	RearHouseModelManager.destroy()
	GameSettings.resetShadowDistance("Rear")
	GameStateMainRearHouse.super.onExit(self, nextStateName)

	if self.centerPointGo then
		UnityEngine.Object.Destroy(self.centerPointGo)

		self.centerPointGo = nil
	end

	if self.cameraCenterPointGo then
		UnityEngine.Object.Destroy(self.cameraCenterPointGo)

		self.cameraCenterPointGo = nil
	end

	self.curUI = nil

	if self.newLevelDlg then
		self.newLevelDlg:clear()

		self.newLevelDlg = nil
	end
end

function GameStateMainRearHouse:onSceneLoaded()
	GameStateMainRearHouse.super.onSceneLoaded(self)

	if ResScene[self.sceneNo] and ResScene[self.sceneNo].camera_pos and ResScene[self.sceneNo].camera_rot then
		local pos = ResScene[self.sceneNo].camera_pos
		local rot = ResScene[self.sceneNo].camera_rot
		local fov = ResScene[self.sceneNo].camera_fov or 60

		self.fov = fov

		CameraModeManager.setMainStageMode()

		local transform = CameraManager.GetControlNodeTransform(CameraModeManager.mainCamera)

		if transform then
			transform.position = Vector3(pos[1], pos[2], pos[3])
			transform.rotation = Quaternion.Euler(rot[1], rot[2], rot[3])
			self.nodeTransform = transform
		end

		self:_setCameraFov(fov, 0)
		self:setCameraPostProcess(ResScene[self.sceneNo].camera_post_cue)
	end

	self:init()
end

function GameStateMainRearHouse:setCameraPostProcess(postCue)
	if self.postCue then
		CueManager.releaseCue(nil, self.postCue)
	end

	self.postCue = postCue

	if self.postCue then
		CueManager.playCue(nil, self.postCue)
	end
end

function GameStateMainRearHouse:setRearHouseShadow(...)
	GameSettings.setShadowDistance(50, "Rear")
end

function GameStateMainRearHouse:onLoadEnded()
	GameStateMainRearHouse.super.onLoadEnded(self)
	CameraManager.SetMainCameraEnable(true)
	self:setRearHouseShadow()
	RearHouseDragCenter.createWhenLoadend()
	self:setCameraMode(0, "fof")
	self:checkNewLevelDlg()
end

local mainCamera

function GameStateMainRearHouse:calculateLimitData(...)
	local mainBounds = self:getBoundsByType(BOUNDS_TYPE.MAIN_ZOOM)
	local editBounds = self:getBoundsByType(BOUNDS_TYPE.EDIT_ZOOM)
	local width = mainBounds.leftUpPos.x - mainBounds.rightDownPos.x
	local height = mainBounds.leftUpPos.y - self:getLimitHeight() - mainBounds.rightDownPos.y

	if SCREEN_RATIO > width / height then
		local mainBounds = self:getBoundsByType(BOUNDS_TYPE.MAIN_ZOOM)
		local xOffset = (mainBounds.leftUpPos.x - mainBounds.rightDownPos.x) * 0.5
		local yOffset = xOffset / SCREEN_RATIO
		local distance = yOffset / math.tan(math.rad(CAMERA_MODE[3].fov * 0.5))
		local z = distance + mainBounds.z

		CAMERA_MODE[3].pos.z = math.min(z, MAX_Z)
	else
		local halfHeight = height * 0.5
		local distance = halfHeight / math.tan(math.rad(CAMERA_MODE[3].fov * 0.5))
		local z = distance + mainBounds.z

		CAMERA_MODE[3].pos.z = math.min(z, MAX_Z)
	end

	local centerY = (mainBounds.leftUpPos.x - mainBounds.rightDownPos.x) / 2
	local widthY = centerY - CAMERA_START_DEFAULT_Y

	CAMERA_MODE[3].pos.y = centerY - widthY * csharpScaleAll
	self.fovChangeRaio = (CAMERA_MODE[3].fov - CAMERA_MODE[1].fov) / (CAMERA_MODE[3].pos.z - CAMERA_MODE[1].pos.z)
end

function GameStateMainRearHouse:getLimitHeight(...)
	if self.limitHeight == nil then
		self:refreshLimitHeight()
	end

	return self.limitHeight
end

function GameStateMainRearHouse:refreshLimitHeight(lockIndex)
	local height = 0
	local wallIndex = RearHouseDragCenter.getCurZoneId()

	lockIndex = lockIndex or RearHouseCommon.getCurUnlockWall(wallIndex)

	local idx = lockIndex + 1

	if idx <= 4 then
		idx = 5
	end

	local config = ResRearHouseLockAreaConfig[wallIndex]

	for i = idx, #config do
		height = height + config[i].rows * Const.REARHOUSE_GRID_SIZE
	end

	self.limitHeight = height
end

function GameStateMainRearHouse:tweenPosAndFov(cameraPos, fov, duration)
	fov = fov * csharpScale
	cameraPos.z = fov

	if duration == 0 then
		self:tweenFovCallBack(cameraPos.x, cameraPos.y, cameraPos.z)
	else
		CameraManager.CameraGrp:SetPosAndFov(cameraPos, duration, Slot(self.tweenFovCallBack, self), Const.TWEEN_EASE.InOutSine)
	end
end

local CAMERA_OFFSET_DOWN = -0.8

function GameStateMainRearHouse:checkBounds(cameraPos, fov)
	self.fov = fov or self.fov

	local bounds = self:getBoundsByType(BOUNDS_TYPE.MAIN_MOVE)
	local distance = cameraPos.z - bounds.z
	local yOffset = distance * math.tan(math.rad(self.fov * 0.5))
	local xOffset = SCREEN_RATIO * yOffset
	local left = bounds.leftUpPos.x - xOffset
	local right = bounds.rightDownPos.x + xOffset
	local up = bounds.leftUpPos.y - self:getLimitHeight() - yOffset
	local down = math.max(self:_getDeskOffset(), bounds.rightDownPos.y) + yOffset + CAMERA_OFFSET_DOWN

	cameraPos.x = math.max(math.min(left, cameraPos.x), right)
	cameraPos.y = math.max(math.min(up, cameraPos.y), down)
	self.nodeTransform.position = cameraPos
end

local deskWidth = 9.9
local deskTopY = 8.5

function GameStateMainRearHouse:_getDeskOffset(...)
	return deskTopY - deskWidth * math.tan(math.rad(self.fov * 0.5))
end

function GameStateMainRearHouse:checkBoundsOrtho(cameraPos, fov)
	self.fov = fov or self.fov

	local yOffset = CameraManager.CameraGrp.CameraOrthographicSize
	local xOffset = SCREEN_RATIO * yOffset
	local leftDownRatio = UI_OFFSET
	local bounds = self:getBoundsByType(BOUNDS_TYPE.EDIT_MOVE)
	local left = bounds.leftUpPos.x - xOffset * (1 - 2 * leftDownRatio.x)
	local right = bounds.rightDownPos.x + xOffset
	local up = bounds.leftUpPos.y - self:getLimitHeight() - yOffset
	local down = bounds.rightDownPos.y + yOffset * (1 - 2 * leftDownRatio.y)

	cameraPos.x = math.max(math.min(left, cameraPos.x), right)
	cameraPos.y = math.max(math.min(up, cameraPos.y), down)
	self.nodeTransform.position = cameraPos
end

function GameStateMainRearHouse:initBoundsInfo(...)
	self.bounds = {}

	local bounds
	local boundsInfo = RearHouseDragCenter.getCurWallBoundsInfo()

	for k, v in pairs(BOUNDS_TYPE) do
		if string.find(k, "EDIT") ~= nil then
			bounds = utils.deepcopy(boundsInfo.edit)
		else
			bounds = utils.deepcopy(boundsInfo.main)
		end

		self.bounds[v] = bounds
	end
end

function GameStateMainRearHouse:getCenterX(...)
	local bounds = self:getBoundsByType(BOUNDS_TYPE.MAIN_MOVE)

	return (bounds.leftUpPos.x + bounds.rightDownPos.x) * 0.5
end

function GameStateMainRearHouse:getBoundsByType(typeId)
	return self.bounds[typeId]
end

function GameStateMainRearHouse:getDistance(...)
	local boundsInfo = RearHouseDragCenter.getCurWallBoundsInfo()

	if boundsInfo then
		return self.nodeTransform.position.z - boundsInfo.main.z
	else
		return 0
	end
end

function GameStateMainRearHouse:getCameraFieldWH(...)
	local distance = self:getDistance()
	local height = distance * math.tan(math.rad(self.fov * 0.5))
	local width = SCREEN_RATIO * height

	return width, height
end

function GameStateMainRearHouse:onDrag(delta)
	delta.x = delta.x * DeviceHelper.curWidth
	delta.y = delta.y * DeviceHelper.curHeight

	local ratio = self:getModeRatio()

	delta = delta * ratio

	local pos = self.nodeTransform.position + Vector3(delta.x, -delta.y, 0)

	self:moveCamera(pos)
end

function GameStateMainRearHouse:getModeRatio(...)
	if self.CameraOrthographic then
		local height = CameraManager.CameraGrp.CameraOrthographicSize

		return height * 2 / DeviceHelper.curHeight
	else
		return math.tan(math.rad(self.fov * 0.5)) * (self:getDistance() / (DeviceHelper.curHeight * 0.5))
	end
end

function GameStateMainRearHouse:moveCamera(pos)
	if self.CameraOrthographic then
		self:checkBoundsOrtho(pos)
	else
		self:checkBounds(pos)
	end

	self:checkLoadHigh()
end

function GameStateMainRearHouse:onDragEnd(delta)
	if delta == nil then
		return
	end

	self.coMoveSlow = coroutine.start(self.coMoveSlowFunc, self, delta)
end

function GameStateMainRearHouse:coMoveSlowFunc(delta)
	delta.x = delta.x * DeviceHelper.curWidth
	delta.y = delta.y * DeviceHelper.curHeight

	local damping = self:getModeRatio() * 0.5

	while not self.stopCameraMove do
		if math.abs(delta.x) < 0.1 and math.abs(delta.y) < 0.1 then
			break
		else
			delta = delta * 0.87

			local pos = self.nodeTransform.position + Vector3(delta.x * damping, -delta.y * damping, 0)

			self:moveCamera(pos)
		end

		coroutine.step()
	end

	coroutine.stop(self.coMoveSlow)

	self.stopCameraMove = false
	self.coMoveSlow = nil
end

function GameStateMainRearHouse:sliderValueToCameraZ(v)
	return (self.maxCameraZ - self.minCameraZ) * v + self.minCameraZ
end

function GameStateMainRearHouse:onPinch(delta)
	if self:isInChangeCameraMode() then
		return
	end

	self.totalPinch = self.totalPinch or 0
	self.totalPinch = -delta + self.totalPinch

	self:doPinch(-delta * 10)
end

function GameStateMainRearHouse:onTouchEnd(...)
	local fovOffset = self.fov - CAMERA_MODE[1].fov

	if fovOffset < 0 then
		local minFov = CAMERA_MODE[1].fov

		if self.CameraOrthographic then
			local minSize = math.tan(math.rad(minFov * 0.5)) * self:getDistance()

			self:tweenPosAndFov(self.nodeTransform.position, minFov, 0.5, false)
		else
			self:_setCameraFov(minFov, 0.4)
		end

		self.fov = CAMERA_MODE[1].fov
	end
end

function GameStateMainRearHouse:doPinch(delta)
	local pos = self.nodeTransform.position
	local minZ = CAMERA_MODE[1].pos.z
	local fov

	pos.z = math.max(math.min(CAMERA_MODE[3].pos.z, pos.z + delta), minZ)

	local eRatio = 1

	if pos.z == minZ then
		eRatio = 0.5
	end

	fov = math.min(math.max(CAMERA_MODE[1].fov - 1.5, self.fov + delta * self.fovChangeRaio * eRatio), CAMERA_MODE[3].fov)

	if self.CameraOrthographic == true then
		self.fov = fov

		self:_setCameraFov(fov * 1, 0)

		CameraManager.CameraGrp.CameraOrthographicSize = math.tan(math.rad(self.fov * 0.5)) * self:getDistance()

		self:checkBoundsOrtho(pos)
	else
		self:_setCameraFov(fov, 0)
		self:checkBounds(pos, fov)
	end

	self:checkLoadHigh()
	RearHouseDragCenter.checkLogoBounds()
	RearHouseDragCenter.setSliderValue(self:getSliderValue())
end

function GameStateMainRearHouse:getSliderValue(...)
	local fov = math.min(math.max(CAMERA_MODE[1].fov, self.fov), CAMERA_MODE[3].fov)

	return (fov - CAMERA_MODE[1].fov) / (CAMERA_MODE[3].fov - CAMERA_MODE[1].fov)
end

function GameStateMainRearHouse:setSliderValue(value)
	local fov = (CAMERA_MODE[3].fov - CAMERA_MODE[1].fov) * value + CAMERA_MODE[1].fov
	local delta = (fov - self.fov) / self.fovChangeRaio

	self:doPinch(delta)
end

function GameStateMainRearHouse:getPosByFov(fov)
	local z = (fov - CAMERA_MODE[1].fov) / self.fovChangeRaio + CAMERA_MODE[1].pos.z

	z = math.max(z, CAMERA_MODE[1].pos.z)

	return Vector3(self.nodeTransform.position.x, self.nodeTransform.position.y, z)
end

function GameStateMainRearHouse:getSizeByFov(fov)
	self.nodeTransform.position = self:getPosByFov(fov)

	return math.tan(math.rad(fov * 0.5)) * self:getDistance()
end

function GameStateMainRearHouse:_setCameraFov(fov, duration)
	fov = fov * csharpScale

	CameraManager.CameraGrp:SetFov(fov, duration)
end

function GameStateMainRearHouse:tweenFovCallBack(x, y, fov)
	fov = fov / csharpScale

	self:_setCameraFov(fov, 0)

	local pos = self:getPosByFov(fov)

	pos.x = x
	pos.y = y

	if self.CameraOrthographic then
		CameraManager.CameraGrp.CameraOrthographicSize = self:getSizeByFov(fov)

		self:checkBoundsOrtho(pos, fov)
	else
		self:checkBounds(pos, fov)
	end

	if self.curUI then
		self.curUI:setSliderValue(self:getSliderValue())
	end

	self:checkLoadHigh()
	RearHouseDragCenter.checkLogoBounds()
end

function GameStateMainRearHouse:setCurUI(ui)
	self.curUI = ui

	self.curUI:setSliderValue(self:getSliderValue())
end

function GameStateMainRearHouse:isInChangeCameraMode(...)
	if self.finishCameraTime then
		return os.time() < self.finishCameraTime
	end
end

function GameStateMainRearHouse:setCameraOrthographic(v)
	self.CameraOrthographic = v

	CameraManager.CameraGrp:SetCameraOrthographic(v)

	CameraManager.CameraGrp.CameraOrthographicSize = math.tan(math.rad(self.fov * 0.5)) * self:getDistance()
end

function GameStateMainRearHouse:focusToPos(pos, duration)
	self:setCameraMode(99, "f2f", pos, duration)
end

function GameStateMainRearHouse:setCameraMode(value, changeMode, pos, duration)
	local cameraPos = pos or self.nodeTransform.position

	if self.isInitIn then
		cameraPos.x = CAMERA_MODE[3].pos.x
		cameraPos.y = CAMERA_MODE[3].pos.y
		cameraPos.z = CAMERA_MODE[3].pos.z

		self:tweenPosAndFov(cameraPos, CAMERA_MODE[3].fov, 0)

		self.isInitIn = false
	else
		self.stopCameraMove = true
		self.curCameraMode = math.max(1, math.min(self.curCameraMode + value, #CAMERA_MODE))

		local fov = CAMERA_MODE[self.curCameraMode].fov

		if not duration then
			duration = DURATION_PERFOV * math.abs(self.fov - fov)

			if DURATION_CONFIG[changeMode] then
				duration = DURATION_CONFIG[changeMode]
			end
		end

		self:tweenPosAndFov(cameraPos, fov, duration)

		self.finishCameraTime = os.time() + duration
	end
end

function GameStateMainRearHouse:getCameraToSliderValue(...)
	self.cameraRatio = (self.nodeTransform.position.z - self.minCameraZ) / (self.maxCameraZ - self.minCameraZ)

	return self.cameraRatio
end

function GameStateMainRearHouse:init(...)
	RearHouseDragCenter.start(self)
	self:initCreate()
end

function GameStateMainRearHouse:checkMainDlg(...)
	local ui = UIManager.tryGetUI("rearHouseMainDlg")

	if ui then
		return
	end

	if not self:checkEnterReason() and not ui then
		UIManager.getUI("rearHouseMainDlg", true):show()
	end
end

function GameStateMainRearHouse:initCreate(...)
	RearHouseDragCenter.dataReady()
end

function GameStateMainRearHouse:checkNewLevelDlg()
	self.newLevelDlg = RearHouseNewCrystalDlg()

	self:setInStageRoot(self.newLevelDlg.mObject.transform, "TextRoot")
	self.newLevelDlg:checkSecondUnlock()
end

function GameStateMainRearHouse:checkLoadHigh(...)
	local isCheck = RearHouseModelManager.checkLoadHigh()

	if isCheck == true then
		RearHouseDragCenter.checkLoadHigh()
	end
end

function GameStateMainRearHouse:getCameraPos(...)
	return self.nodeTransform.position
end

function GameStateMainRearHouse:getCameraAreaRowCol(...)
	local pos = self.nodeTransform.position
	local r, c = self:posToRowCol(pos)
	local w, h = self:getCameraFieldWH()
	local hOffset = self:_getCeilNum(h)
	local wOffset = self:_getCeilNum(w)

	return math.max(1, r - hOffset), math.min(RearHouseDragWall.ROW, r + hOffset), math.max(1, c - wOffset), math.min(RearHouseDragWall.COLUMN, c + wOffset)
end

function GameStateMainRearHouse:_getCeilNum(v)
	return math.floor(v / Const.REARHOUSE_GRID_SIZE)
end

function GameStateMainRearHouse:gridIdxToRowColumn(gridIdx)
	local columns = RearHouseDragWall.COLUMN
	local r = math.ceil(gridIdx / columns)
	local c = gridIdx % columns

	c = c == 0 and columns or c

	return r, c
end

function GameStateMainRearHouse:posToRowCol(pos)
	local bounds = self:getBoundsByType(BOUNDS_TYPE.MAIN_MOVE)
	local x = bounds.leftUpPos.x - pos.x
	local y = bounds.leftUpPos.y - pos.y
	local rowIdx = math.ceil(y / Const.REARHOUSE_GRID_SIZE)
	local columnIdx = math.ceil(x / Const.REARHOUSE_GRID_SIZE)

	return rowIdx, columnIdx
end

function GameStateMainRearHouse:changeWall(index, withoutCheck)
	if withoutCheck then
		UIManager.getUI("rearHouseLoadingDlg", true)
	end

	RearHouseDragCenter.changeWall(index, withoutCheck)
	self:initBoundsInfo()
	self:calculateLimitData()
	self:refreshLimitHeight()

	local x = self:getCenterX()
	local focusPos = Vector3(x, 0, 0)

	self:focusToPos(focusPos, 0)

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	local ui = UIManager.getUI("rearHouseVisitMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function GameStateMainRearHouse:setInStageRoot(transform, nodeName)
	if not transform then
		return
	end

	if nodeName then
		local rootGo = UnityEngine.GameObject.Find(nodeName)

		if rootGo then
			transform:SetParent(rootGo.transform)
		end
	else
		local wallIndex = RearHouseDragCenter.getCurZoneId()

		if wallIndex ~= 1 then
			return
		end

		local wall = RearHouseDragCenter.getCurZone()

		if wall then
			local stageRoot = wall:getStageRoot()

			if stageRoot then
				transform:SetParent(stageRoot)
			end
		end
	end

	transform.localPosition = Vector3.zero
	transform.localEulerAngles = Vector3.zero
	transform.localScale = Vector3(1, 1, 1)
end

return GameStateMainRearHouse
