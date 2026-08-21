require "class"

---@class CoveManager:BaseClass
local CoveManager = class("CoveManager")
local CoveRoomManager = require "CoveRoomManager"
local CoveRoleManager = require "CoveRoleManager"
local CoveBuildingManager = require "CoveBuildingManager"
local RoomDoorMgr = require "RoomDoorMgr"
local Random = require "Random"
local EventSystem = UnityEngine.EventSystems.EventSystem
-- local cjson = require "cjson"
local CoveShowMgr = require "CoveShowMgr"
local bit = require("bit")


local smoothValueSize = 0.3 --边界平滑范围 正交相机

local OrthographicSizeMax = 5  --正交相机缩放最小值 视野最小
local OrthographicSizeMin = 10 --正交相机缩放最大值
--local refreshTime = Config.GetConfigInfo("constructionRate") --间隔时间 半小时刷新一次
local focusRoleLightRotation = Quaternion.Euler(10, 115, 0) --家园角色聚焦灯光角度
local focusRoleLightIntensity = 0.85 --家园角色聚焦灯光强度
local scaleIndex = 1.3

function CoveManager:ctor(...)
	-- self._inited = false	--是否初始化过
	LuaLogger.ds("CoveManager ctor")
	---@type Random
	self._random = Random:new(Time.time)
	self._coveScene = nil
	self._roomMgr = CoveRoomManager.instance() --房间管理器 表现
	self._roleMgr = CoveRoleManager.instance() --角色管理器
	self._roomDoorMgr = RoomDoorMgr.instance() --房间门管理器
	self._buildingMgr = CoveBuildingManager.instance() --建筑管理器 功能
	self.homeCharacterShowBase = Config.GetConfigInfo("homeCharacterShowBase") --家园角色同时显示最大数量（初始）

	--self.constructionRateTime = 0	--建筑刷新时间

	self.mouseDownPosition = nil	--鼠标按下位置
	self.mouseDownTime = nil		--鼠标按下时间
	self.isDragging = false			--是否拖拽
	self.isZooming = false			--是否正在缩放
	--当前场景时间
	self.curSceneTime = nil
	---下次更新场景时间
	self.nextUpdateSceneTime = nil
	---当前天气参数ID
	self._weatherParameterId = nil
	---@type HomeWeatherTable
	self.curHomeWeatherCfg = nil
	--家园秒针同步
	self.secondHandSync = 0
	--相机移动的边界
	self.cameraMoveBounds = { xMin = -65, xMax = 55, yMin = -90, yMax = 50 }
	local CameraMoveBounds = Config.GetConfigInfo("CameraMoveBounds")
	if CameraMoveBounds then
		self.cameraMoveBounds = CameraMoveBounds
	end
	-- { xMin = 右下, xMax = 左上, yMin = 右上, yMax = 左下 }
	--默认根节点相机位置高度
	self._defaultCameraHeight = 1.25/5/0.7
	--是否可以缩放相机
	self._canZoomCamera = true
	--相机模式
	self._camMode = 1	--相机模式 1透视 2正交

	---@type boolean 是否激活家园天气变化
	self.homelandEeatherEnabled = true

	local HomeCameraSet = Config.GetConfigInfo("HomeCameraSet")
	self._camZoomMaxZ = HomeCameraSet[1] / 1.3 * scaleIndex
	self._camZoomMinZ = HomeCameraSet[2] / 1.3 * scaleIndex
	self._smoothValueZ = (self._camZoomMaxZ - self._camZoomMinZ) * HomeCameraSet[3]	--边界平滑范围 超出则dotween自动到边界位置内smoothValue 透视相机

	---@type boolean? 场景设置是否开启
	self.sceneSettingIsOpen = nil

	---@type boolean?
	self.lastIsUnlock = nil
	self._cameraFollowRoleId = nil	--相机跟随角色ID

	---@type CheckInitInteractiveObjData[]
	self.interactiveObjTab = nil
end

---实例化
---@return CoveManager CoveManager
function CoveManager.instance()
	if (CoveManager._instance == nil) then
		CoveManager._instance = CoveManager:new()
	end
	return CoveManager._instance
end

function CoveManager:initCove()
	LuaLogger.ds("CoveManager:initCove")
	self._inited = true
	self._coveScene = GameObject.Find("CoveSceneRoot"):GetComponent("CoveScene");

	-- self._CameraObj = GameObject.Find("GameSceneInfo/CameraPos/CameraRotation/Camera")
	-- self._CameraMoveControl = self._CameraObj:GetOrAddComponent(TypeInfo.CameraMoveControl)
	self._Minimap = GameObject.Find("Minimap")
	self._Minimap:SetActive(false)
	--todo,添加self.Homeland，self.GameSceneInfo
	self.Homeland = GameObject.Find("Homeland")
	self.GameSceneInfo = GameObject.Find("GameSceneInfo")
	--self.focusCamera = GameObject.Find("focusCamera"):GetComponent(TypeInfo.Camera)

	--后处理
	self.GlobalVolume = GameObject.Find("Homeland/Global Volume"):GetComponent(typeof(UnityEngine.Rendering.Volume))
	self.OverlayVolume = GameObject.Find("Homeland/overlay Volume"):GetComponent(typeof(UnityEngine.Rendering.Volume))
	self.focusRoleVolume = GameObject.Find("Homeland/focusRoleVolume"):GetComponent(typeof(UnityEngine.Rendering.Volume))
	--灯光
	self.HeroDynamicLight = self._coveScene.dayNightSwitcher.roleLight.gameObject
	--主相机 透视
	self.mainVcamObj = GameObject.Find("GameSceneInfo/CameraRoot/CameraRotateRoot/MainVcam").gameObject
	self.mainVcamVcam = self.mainVcamObj:GetComponent(TypeInfo.CinemachineVirtualCamera)
	self.cameraRoot = GameObject.Find("GameSceneInfo/CameraRoot").gameObject
	self.cameraRotateRoot = GameObject.Find("GameSceneInfo/CameraRoot/CameraRotateRoot").gameObject
	self.coveAudioListener = self.cameraRotateRoot:GetComponent(typeof(UnityEngine.AudioListener))
	--全局部署相机 正交
	self.homeQuickVcamObj = GameObject.Find("GameSceneInfo/HomeQuickVcam").gameObject
	self.homeQuickVcamVcam = self.homeQuickVcamObj:GetComponent(TypeInfo.CinemachineVirtualCamera)
	self.homeQuickVcamObj:SetActive(false)
	--家园功能相机 透视
	self.homeFuncVcamObj = GameObject.Find("GameSceneInfo/CameraRoot2/CameraRotateRoot2/HomeFuncVcam").gameObject
	self.homeFuncVcamVcam = self.homeFuncVcamObj:GetComponent(TypeInfo.CinemachineVirtualCamera)
	self.homeFuncVcamObj:SetActive(false)
	self.homeFuncCameraRoot = GameObject.Find("GameSceneInfo/CameraRoot2").gameObject
	self.homeFuncCameraRotateRoot = GameObject.Find("GameSceneInfo/CameraRoot2/CameraRotateRoot2").gameObject
	--家园入场动画相机 正交
	self.homeInAniVcamObj = GameObject.Find("GameSceneInfo/InAniVcam").gameObject
	self._CameraInAni = self.homeInAniVcamObj:GetComponent(TypeInfo.Animator)
	self._CameraInAniAnimOverCallback = self.homeInAniVcamObj:GetComponent(TypeInfo.AnimOverCallBack)
	self.homeInAniVcamObj:SetActive(false)
	--家园角色聚焦相机 透视
	self.RoleClickCamObj = GameObject.Find("GameSceneInfo/RoleClickCam").gameObject
	self.RoleClickCamVcam = self.RoleClickCamObj:GetComponent(TypeInfo.CinemachineVirtualCamera)
	-- self.RoleClickCamObjRoot = GameObject.Find("GameSceneInfo/CameraRoot3").gameObject
	self.RoleClickCamObj:SetActive(false)
	self.RoleClickCamFov = 30
	self.RoleClickTargetObj = GameObject.Find("GameSceneInfo/RoleClickTarget").gameObject --追踪目标
	self.RoleClickTargetCamObj = GameObject.Find("GameSceneInfo/RoleClickTarget/CamPos").gameObject --追踪目标相机位置
	self.RoleClickTargetGroup = GameObject.Find("GameSceneInfo/RoleClickTarget/targetgroup").gameObject:GetComponent(typeof(Cinemachine.CinemachineTargetGroup)) --追踪目标组
	--透视相机列表
	---@class PerspectiveParam
	---@field obj UnityEngine.GameObject 虚拟相机对象
	---@field vcam Cinemachine.CinemachineVirtualCamera 虚拟相机组件
	---@field posRoot UnityEngine.GameObject 位置根节点
	---@field rotateRoot UnityEngine.GameObject 旋转根节点
	self.perspectiveList = {
		[GE.HomeLandPerspectiveType.Whole] = {
			obj = self.mainVcamObj,
			vcam = self.mainVcamVcam,
			posRoot = self.cameraRoot,
			rotateRoot = self.cameraRotateRoot,
		},
		[GE.HomeLandPerspectiveType.HomeFunc] = {
			obj = self.homeFuncVcamObj,
			vcam = self.homeFuncVcamVcam,
			posRoot = self.homeFuncCameraRoot,
			rotateRoot = self.homeFuncCameraRotateRoot,
		},
	}
	self.cameraObj = GameObject.Find("GameSceneInfo/MainCamera").gameObject
	self.camera = self.cameraObj:GetComponent("Camera")
	UIMgr.SetBaseCamera(self.camera)
	self._cinemachineBrain = self.cameraObj:GetComponent("CinemachineBrain")
	--主相机相关监听
	local CameraRenderCB = self.cameraObj:GetComponent("CameraRenderCB")
	CameraRenderCB.lateUpdateFunc = function ()
		self:FixedUpdate()
	end
	self.camera.enabled = false
	self:ChangeCameraMode(self.mainVcamVcam, self._camMode)
	--默认视野
	self:SetCameraView(self._camZoomMinZ + self._smoothValueZ)
	self:RefreshCameraAngle()
    --设置渲染纹理
    -- if not self.rt then
    --     self.rt = UnityEngine.RenderTexture(1000, 700, 24)
	-- 	LuaLogger.Enabled = true
	-- 	LuaLogger.es(" 创建RenderTexture  depth:" .. tostring(self.rt.depth) .. " format:" .. tostring(self.rt.format).. " depthStencilFormat:".. tostring(self.rt.depthStencilFormat))
    -- end
    --self.focusCamera.targetTexture = self.rt
	local CanvasScaler =  UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler")
	self.screen_width = CanvasScaler.referenceResolution.x
    self.screen_height = CanvasScaler.referenceResolution.y
	self.canvas = GameObject.Find("Homeland/CanvasNew").gameObject
	--家园角色交互相关
	self._clickMenu = nil
	self._clickMenuData = nil
	self._VcamMoveEndCB = nil
	self._activeBlend = nil
	self._homelandRoleTalkData = nil
	self._hiddenObstructionList = {}	--隐藏的遮挡物列表
	--CameraMoveControl
	self._roomMgr:init(self)
	self._roleMgr:init(self)
	self._roomDoorMgr:init(self)
	self._buildingMgr:init(self)
	-- --刷新界面表现
	self:RefreshBuilding()

	self:setCameraMoveable(true)
	self:InitSceneParameters()
	self:InitInteractiveObjects()

	GameMsgMgr:regEvent(GameMsgType.RefreshHomeland, self, self.RefreshHomeland)
	GameMsgMgr:regEvent(GameMsgType.UIDataGroupQueueChange, self, self.OnUIDataGroupQueueChange)
	CovePropsMgr.instance():Init()

end

-------------------相机相关-------------------
--#region

--相机过度转换
---@param Obj UnityEngine.GameObject 虚拟相机对象
---@param isOpen boolean 是否打开该相机
---@param isNeedblend boolean 是否需要过度
---@param blendTime number 过度时间
---@return boolean isAni 是否有动画过度
function CoveManager:ChangeVCam(Obj, isOpen, isNeedblend, blendTime)
	local isAni = false
	if not isNeedblend then
		if self._cinemachineBrain then
			self._cinemachineBrain.m_DefaultBlend = Cinemachine.CinemachineBlendDefinition.New(
				Cinemachine.CinemachineBlendDefinition.Style.Cut, 0)
		end
	else
		local mainVcamO = self:CameraIsOrthographic(self.mainVcamVcam)
		local targetVcamO = self:CameraIsOrthographic(Obj:GetComponent(TypeInfo.CinemachineVirtualCamera))
		--若都为正交相机或都为透视相机 
		if mainVcamO == targetVcamO then
			if self._cinemachineBrain then
				self._cinemachineBrain.m_DefaultBlend = Cinemachine.CinemachineBlendDefinition.New(
					Cinemachine.CinemachineBlendDefinition.Style.EaseInOut, blendTime)
				isAni = true
			end
		end
	end
	Obj:SetActive(isOpen)
	return isAni
end

--拖动相机
function CoveManager:onDraggingCam(currentMousePos)
    if not self._lastMousePosition then
		--拖动相机时取消跟随角色
		self:ClearCameraFollowRoleId()	
        self._lastMousePosition = currentMousePos
        return
    end
    -- 计算世界坐标的移动差值
    local lastWorldPos = self:ScreenToGroundPoint(self._lastMousePosition)
    local currentWorldPos = self:ScreenToGroundPoint(currentMousePos)
    
    if lastWorldPos and currentWorldPos then
        local worldDelta = lastWorldPos - currentWorldPos
		local newPos = self.cameraRoot.transform.position + worldDelta
        self:moveCamera(newPos)
    end

    self._lastMousePosition = currentMousePos
end

-- 将屏幕坐标转换为地面交点
function CoveManager:ScreenToGroundPoint(screenPos)
    if not self.camera then return nil end
    
    local viewportPos = self.camera:ScreenToViewportPoint(screenPos)
    local ray = self.camera:ViewportPointToRay(viewportPos)
    
    -- 修正平面定义
    local groundPlane = Plane.New(Vector3.up, self._defaultCameraHeight)  -- 地面在y=0
    
	local _, rayEnter = groundPlane:Raycast(ray)
	local edgePos = ray:GetPoint(rayEnter)
	return edgePos
end

---视野左右旋转(直接根据最终值旋转)
function CoveManager:refreshViewRotatByFinalValue(value)
	self.cameraRotateRoot.transform.localRotation = Quaternion.Euler(self.cameraRotateRoot.transform.localRotation.eulerAngles.x, value, 0)
	self:RefreshCameraMatrix()
end

---视野上下旋转(直接根据最终值调整)
function CoveManager:refreshViewHeightByFinalValue(value)
	self.cameraRotateRoot.transform.localRotation = Quaternion.Euler(value, self.cameraRotateRoot.transform.localRotation.eulerAngles.y, 0)
	self:RefreshCameraMatrix()
end

---视野旋转(直接根据最终值旋转)
function CoveManager:refreshViewRotationXY(Height, Rotate, tweenTime, callBack)
	if self._viewOrientationTweener then
		self._viewOrientationTweener:Kill(false)
		self._viewOrientationTweener = nil
	end
	if tweenTime then
		self:refreshViewOrientation(Height, Rotate, tweenTime, callBack)
	else
		self:refreshViewRotatByFinalValue(Rotate)
		self:refreshViewHeightByFinalValue(Height)
	end
end

---视野角度调整（高度+旋转，支持Tween）
---@param pitch number? 目标俯仰角（X轴）
---@param yaw number? 目标水平角（Y轴）
---@param tweenTime number? 缓动时间
---@param callBack function? 回调函数
function CoveManager:refreshViewOrientation(pitch, yaw, tweenTime, callBack)
	if not self.cameraRotateRoot then
		return
	end

	local defaultTween = 1
	local duration = tweenTime or defaultTween
	local currentEuler = self.cameraRotateRoot.transform.localRotation.eulerAngles
	local targetEuler = Vector3.New(pitch or currentEuler.x, yaw or currentEuler.y, 0)
	local mainPanel = UIMgr:GetUI("MainPanel")
	if mainPanel then
		mainPanel:HideAll(true, true)
	end
	self._viewOrientationTweener = self.cameraRotateRoot.transform:DOLocalRotate(targetEuler, duration, DG.Tweening.RotateMode.Fast)
		:SetEase(DG.Tweening.Ease.InOutQuad)
		:OnUpdate(function()
			self:RefreshCameraMatrix()
		end)
		:OnComplete(function()
			self._viewOrientationTweener = nil
			self:RefreshCameraMatrix()
			if callBack then
				callBack()
			end
			if mainPanel then
				mainPanel:HideAll(false, true)
			end
		end)
end


---移动视野
function CoveManager:moveCamera(pos)
	-- LuaLogger.ds("moveCamera", pos)
	pos.x = math.max(math.min(pos.x, self.cameraMoveBounds.xMax - 1.5), self.cameraMoveBounds.xMin - 1.5)
	pos.z = math.max(math.min(pos.z, self.cameraMoveBounds.yMax - 1.5), self.cameraMoveBounds.yMin - 1.5)
	pos.y = self._defaultCameraHeight
	self.cameraRoot.transform.position = pos
	self:RefreshCameraMatrix()
end

function CoveManager:rotateVector(vector, angleDegrees)
    local angleRadians = math.rad(angleDegrees)
    local cos = math.cos(angleRadians)
    local sin = math.sin(angleRadians)

    local newX = vector.x * cos - vector.y * sin
    local newY = vector.x * sin + vector.y * cos

    return {x = newX, y = newY}
end

--刷新虚拟相机混合和矩阵生成
function CoveManager:RefreshCameraMatrix()
	-- LuaLogger.ds("BattleShowManager:RefreshCameraMatrix")
	--手动刷新虚拟相机矩阵 修复世界坐标转屏幕坐标延迟1帧显示bug
	self._cinemachineBrain:ManualUpdate()
end

---移动视野到指定地块
---@param type GE.HomeLandPerspectiveType 视角类型
---@param pos UnityEngine.Transform.position 位置
---@param doTweenData table? 缓动数据{ time = int 持续时间 }
---@param callBack function? 回调函数
---@param callBackProgress? number 回调触发进度
---@param isFollowRole boolean 是否为跟随角色
function CoveManager:LookAtPos(type, pos, doTweenData, callBack, callBackProgress, isFollowRole)
	-- LuaLogger.ds("CoveManager:lookAtPos camera", debug.traceback())
	-- LuaLogger.ds("CoveManager:lookAtPos camera", pos, tablex.dump(doTweenData))
	if not isFollowRole then
		--取消跟随角色
		self:ClearCameraFollowRoleId()
	end
	if self.cameraTweener then
		self.cameraTweener:Kill(true)
		self.cameraTweener = nil
	end
	local isTriggered = false
	-- 根据相机角度计算偏移，使目标位于视野中心
	--透视相机列表
	---@type PerspectiveParam
	local param = self.perspectiveList[type]
	local targetCameraPos = self:CalculateCameraFocusPoint(param, pos)
	if targetCameraPos == nil then
		return
	end
	if doTweenData then
		self:setCameraMoveable(false)
		---@type DG.Tweening.Core.TweenerCore_UnityEngine_Vector3_UnityEngine_Vector3_NotExportType
		self.cameraTweener = param.posRoot.transform:DOMove(targetCameraPos, doTweenData.time):SetEase(DG.Tweening.Ease.InOutQuad):OnComplete(function()
			self.cameraTweener = nil
			self:setCameraMoveable(true)
			--默认onComplete触发回调 若提前触发过则不再次触发
			if not isTriggered and callBack then
				isTriggered = true
				callBack()
			end
		end):OnUpdate(function()
			self:RefreshCameraMatrix()
			--有callBackProgress则在指定位置触发回调
			if callBackProgress and not isTriggered then
				local progress = self.cameraTweener.position / self.cameraTweener:Duration()
				if progress >= callBackProgress then
					isTriggered = true
					callBack()
				end
			end
		end)
	else
		param.posRoot.transform.position = targetCameraPos
		self:RefreshCameraMatrix()
		if callBack then
			callBack()
		end
	end
end

-- 简化的偏移计算（适用于大多数情况）
function CoveManager:CalculateCameraFocusPoint(param, targetPos)
    -- 获取相机角度
    local cameraAngle = param.rotateRoot.transform.rotation.eulerAngles
	local direction = self:AngleToDirection(cameraAngle)
    
    
    return self:RayPlaneIntersection(targetPos, direction, self._defaultCameraHeight)
end

-- 将欧拉角转换为方向向量
function CoveManager:AngleToDirection(eulerAngles)
    -- 将角度转换为弧度
    local xRad = eulerAngles.x * Mathf.Deg2Rad
    local yRad = eulerAngles.y * Mathf.Deg2Rad
    local zRad = eulerAngles.z * Mathf.Deg2Rad
    
    -- 计算方向向量（使用Unity的标准旋转顺序）
    local cosX = math.cos(xRad)
    local sinX = math.sin(xRad)
    local cosY = math.cos(yRad)
    local sinY = math.sin(yRad)
    
    local direction = Vector3.New(
        sinY * cosX,
        -sinX,  -- Unity中X旋转是俯仰角，向下为负
        cosY * cosX
    )
    
    return direction.normalized
end

-- 计算射线与水平面的交点
function CoveManager:RayPlaneIntersection(rayOrigin, rayDirection, planeHeight)
    -- 平面法向量 (水平面法向量向上)
    local planeNormal = Vector3.up
    -- 平面上的一点 (任意XZ坐标，Y=目标高度)
    local planePoint = Vector3.New(0, planeHeight, 0)
    
    -- 计算射线与平面的交点
    -- 使用公式: t = ( (planePoint - rayOrigin) · planeNormal ) / (rayDirection · planeNormal)
    local denominator = Vector3.Dot(rayDirection, planeNormal)
    
    -- 如果分母为0，说明射线与平面平行，没有交点
    if math.abs(denominator) < 0.0001 then
        return nil
    end
    
    local numerator = Vector3.Dot(planePoint - rayOrigin, planeNormal)
    local t = numerator / denominator
    
    -- 如果t为负，说明交点在射线起点的后方
    if t < 0 then
        --return nil
    end
    
    -- 计算交点坐标
    local intersection = rayOrigin + rayDirection * t
    return intersection
end

--- 设置是否可以缩放相机
---@param canZoom boolean 是否可以缩放
function CoveManager:SetCanZoomCamera(canZoom)
    self._canZoomCamera = canZoom
end

---处理视野缩放
function CoveManager:handleZoom()
    if self._canZoomCamera == false then
        return
    end
	
	-- 如果正在拖拽，禁止缩放
	if self.isDragging then
		return
	end

    local zoomSpeed = 5

    if Input.touchCount >= 2 then
        -- 双指操控
        local touch1 = Input.GetTouch(0)
        local touch2 = Input.GetTouch(1)

        if touch1.phase == TouchPhase.Began or touch2.phase == TouchPhase.Began then
            self._isInControlZoom = false
            self._lastZoomDistance = nil
			self.isZooming = false
            return  -- 等待下一次帧更新再开始计算
        end

        if touch1.phase == TouchPhase.Moved or touch2.phase == TouchPhase.Moved then
            local currentDistance = UnityEngine.Vector2.Distance(touch1.position, touch2.position)

            if not self._isInControlZoom then
                -- 初始化缩放状态
                self._isInControlZoom = true
                self._lastZoomDistance = currentDistance
				self.isZooming = true
            else
                -- 计算距离变化并应用缩放
                local distanceDelta = currentDistance - self._lastZoomDistance
                self:refreshViewDistance(distanceDelta * zoomSpeed * 0.01, false)
                self._lastZoomDistance = currentDistance
            end
        end

        -- 检查是否有手指结束或取消
        if touch1.phase == TouchPhase.Ended or touch1.phase == TouchPhase.Canceled or 
           touch2.phase == TouchPhase.Ended or touch2.phase == TouchPhase.Canceled then
            self._isInControlZoom = false
            self._lastZoomDistance = nil
			self.isZooming = false
        end
        return
    else
        -- 如果没有双指触摸，重置状态
        self._isInControlZoom = false
        self._lastZoomDistance = nil

        -- 鼠标滚轮控制视野缩放
        local scroll = Input.GetAxis("Mouse ScrollWheel")
		if math.abs(scroll) > 0 then
			self.isZooming = true
			self:refreshViewDistance(scroll * zoomSpeed, false)
		else
			self.isZooming = false
		end
    end
end

---视野缩放(差值缩放)
---@param scaleFactor number 缩放值
---@param isTween boolean 是否缓动
---@param tweenTime number? 缓动时间
function CoveManager:refreshViewDistance(scaleFactor, isTween, tweenTime)
	if not tweenTime then
		tweenTime = 0.3
	end

	if not UICommonUtils.Checkobj(self.mainVcamObj) then
		return
	end

	local iValue = self.mainVcamObj.transform.localPosition.z
	if (math.abs(scaleFactor) > 0) then
		local targetValue = scaleFactor + iValue
		targetValue = math.min(targetValue, self._camZoomMaxZ)
		targetValue = math.max(targetValue, self._camZoomMinZ)
		if targetValue > iValue + 0.01 or targetValue < iValue - 0.01 then
			-- LuaLogger.ds("CoveManager:refreshViewDistance z轴目标值", targetValue)
			if self._viewDistanceTweener then
				-- LuaLogger.ds("CoveManager:refreshViewDistance 停止_viewDistanceTweener")
				self._viewDistanceTweener:Kill(false)
				self._viewDistanceTweener = nil
			end
			if self._OrthographicSizeTweener then
				-- LuaLogger.ds("CoveManager:refreshViewDistance 停止_OrthographicSizeTweener")
				self._OrthographicSizeTweener:Kill(false)
				self._OrthographicSizeTweener = nil
			end
			if (isTween == true) then
				--透视相机
				self._viewDistanceTweener = self.mainVcamObj.transform:DOLocalMoveZ(targetValue, tweenTime)
				self._viewDistanceTweener:SetEase(DG.Tweening.Ease.Linear)
				self._viewDistanceTweener:OnComplete(function ()
					self._viewDistanceTweener:Kill(false)
					self._viewDistanceTweener = nil
				end):OnUpdate(function ()
					self.cameraViewDistance = self.mainVcamObj.transform.localPosition.z
					self:RefreshCameraMatrix()
					if CoveBuildingManager then
						CoveBuildingManager.instance():RefreshBtnScale()
					end
				end)
				--正交相机
				-- if self:CameraIsOrthographic(self.mainVcamVcam) then
					--计算正交相机size
					local sizeRange = OrthographicSizeMin - OrthographicSizeMax
					local t = (targetValue - self._camZoomMaxZ) / (self._camZoomMinZ - self._camZoomMaxZ)
					local newSize = OrthographicSizeMax + sizeRange * t
					local curSize = self.mainVcamVcam.m_Lens.OrthographicSize
					-- LuaLogger.ds("CoveManager:refreshViewDistance 正交相机size原始值", curSize)
					-- LuaLogger.ds("CoveManager:refreshViewDistance 正交相机size目标值", newSize)
					self._OrthographicSizeTweener = DG.Tweening.DOVirtual.Float(curSize, newSize, tweenTime, function(v)
						-- LuaLogger.ds("CoveManager:refreshViewDistance 正交相机size更新值", v)
						self:ChangeVcamOrthographicSize(self.mainVcamVcam, v)
					end)
					-- self._OrthographicSizeTweener:SetEase(DG.Tweening.Ease.Linear)
					self._OrthographicSizeTweener:OnComplete(function ()
						self._OrthographicSizeTweener:Kill(false)
						self._OrthographicSizeTweener = nil
					end)
				-- end
			else
				self:SetCameraView(targetValue)
				--边界平滑处理
				local finalTargetValue = math.min(targetValue, self._camZoomMaxZ - self._smoothValueZ)
				finalTargetValue = math.max(finalTargetValue, self._camZoomMinZ + self._smoothValueZ)
				if (finalTargetValue ~= targetValue) then
					self:refreshViewDistance(finalTargetValue - targetValue, true)
				end
				self:RefreshCameraMatrix()
			end
		end
	end
end

--设置相机视野 正交改OrthographicSize 透视改Z轴位置
function CoveManager:SetCameraView(posZ)
	-- LuaLogger.ds("CoveManager:refreshViewDistance z轴当前值", self.cameraViewDistance)
	--正交相机
	-- if self:CameraIsOrthographic(self.mainVcamVcam) then
		--计算正交相机size
		local sizeRange = OrthographicSizeMin - OrthographicSizeMax
		local t = (posZ - self._camZoomMaxZ) / (self._camZoomMinZ - self._camZoomMaxZ)
		local newSize = OrthographicSizeMax + sizeRange * t
		self:ChangeVcamOrthographicSize(self.mainVcamVcam, newSize)
	-- end
	--透视相机
	self.mainVcamObj.transform.localPosition = Vector3.New(0, 0, posZ)
	self.cameraViewDistance = posZ
	--刷新按钮大小
	if CoveBuildingManager then
		CoveBuildingManager.instance():RefreshBtnScale()
	end
end

--切换相机模式 1透视 2正交
function CoveManager:ChangeCameraMode(vcamera, mode)
	local m_Lens = vcamera.m_Lens
	if mode == 1 then
		m_Lens.ModeOverride = Cinemachine.LensSettings.OverrideModes.Perspective
		vcamera.m_Lens = m_Lens
	elseif mode == 2 then
		m_Lens.ModeOverride = Cinemachine.LensSettings.OverrideModes.Orthographic
		vcamera.m_Lens = m_Lens
	end
end

--轮巡下一个相机模式
function CoveManager:ChangeNextCameraMode()
	self._camMode = self._camMode + 1
	local max = 2
	if self._camMode > max then
		self._camMode = self._camMode - max
	end
	self:ChangeCameraMode(self.mainVcamVcam, self._camMode)
end

--相机是否为正交
function CoveManager:CameraIsOrthographic(vcamera)
	return vcamera.m_Lens.Orthographic 
end

--修改正交相机视野大小
function CoveManager:ChangeVcamOrthographicSize(vcamera, value)
	-- LuaLogger.ds("ChangeVcamOrthographicSize", value)
	local m_Lens = vcamera.m_Lens
	m_Lens.OrthographicSize = value
	vcamera.m_Lens = m_Lens
end

--修改透视相机视野大小
function CoveManager:ChangeVcamFov(vcamera, value)
	--LuaLogger.ds("ChangeVcamFov", value)
	local m_Lens = vcamera.m_Lens
	m_Lens.FieldOfView = value
	vcamera.m_Lens = m_Lens
end

--设置相机追踪角色id
function CoveManager:SetCameraFollowRoleId(roleId)
	--LuaLogger.ds("CoveManager:SetCameraFollowRoleId", roleId)
	self._cameraFollowRoleId = roleId
end

--清空相机追踪角色id
function CoveManager:ClearCameraFollowRoleId()
	--LuaLogger.ds("CoveManager:ClearCameraFollowRoleId")
	self._cameraFollowRoleId = nil
end

--获取相机追踪角色id
function CoveManager:GetCameraFollowRoleId()
	--LuaLogger.ds("CoveManager:GetCameraFollowRoleId")
	return self._cameraFollowRoleId
end

--#endregion
-------------------相机相关-------------------

--- 家园场景显示相关
---@param isSHow boolean 是否显示家园场景
---@param isNotForced boolean 是否非强制切换（已经满足条件则跳过）
function CoveManager:SetHomelandShowOrHide(isSHow, isNotForced)
	print("CoveManager:SetHomelandShowOrHide", isSHow,debug.traceback())
	if isNotForced and self.Homeland and UICommonUtils.Checkobj(self.Homeland) and self.Homeland.activeSelf == isSHow then
		LuaLogger.ds("CoveManager:SetHomelandShowOrHide 已经满足条件，无需切换", isSHow)
		return
	end
	if self.Homeland and UICommonUtils.Checkobj(self.Homeland) then
		self.Homeland:SetActive(isSHow)
		self.camera.enabled = isSHow
		self:SetHomelandAudioListener(isSHow)
		--检测是否需要显示家园入场动画
		if isSHow then
			self:checkInAni()
			--刷新按钮scale
			if CoveBuildingManager then
				CoveBuildingManager.instance():RefreshBtnScale()
			end
		else
			self:ClearCameraFollowRoleId()
		end
		-- 新云影的隐藏
		DUtil.SetCloudShadowsVisible(isSHow)
	else
		DUtil.SetCloudShadowsVisible(false)
	end
	self:SetGameSceneInfoShowOrHide(isSHow)
	self._buildingMgr:changeBtnState(isSHow)
end

function CoveManager:SetHomelandAudioListener(isSHow)
	--切换家园音频监听
	local audioListener = UIMgr.getUIAudioListener()
	if UICommonUtils.Checkobj(audioListener) then
		audioListener.enabled = not isSHow
		self.coveAudioListener.enabled = isSHow
	end
end

function CoveManager:SetHomelandActive(isSHow)
	if not self:getFocusState() then
		return
	end
	self:SetHomelandShowOrHide()
end


function CoveManager:SetGameSceneInfoShowOrHide(isSHow)
	if self.GameSceneInfo and UICommonUtils.Checkobj(self.GameSceneInfo) then
		self.GameSceneInfo:SetActive(isSHow)
	end
	self:OnUIDataGroupQueueChange()


	self:CheckSceneSettingState(isSHow)
end

--检测是否需要播放入场动画
function CoveManager:checkInAni()
	-- if not self._CameraInAni.enabled then
		-- self:PlayInAni()
	-- end
end

--播放入场动画
---@param callback function 入场动画结束回调
function CoveManager:PlayInAni(callback)
	--入场动画结束回调 
	self._CameraInAniAnimOverCallback:SetCallBack(function()
		LuaLogger.ds("家园入场动画结束")
		self:setCameraMoveable(true)
		self:setFocusState(true)
		local mainPanel = UIMgr:GetUI("MainPanel")
		if mainPanel then
			mainPanel:HideAll(false)
		end
		self:ChangeVCam(self.homeInAniVcamObj, false, false, 0)
		if callback then
			callback()
		end
	end)
	self:setCameraMoveable(false)
	self:setFocusState(false)
	local mainPanel = UIMgr:GetUI("MainPanel")
	if mainPanel then
		mainPanel:HideAll(true, true)
	end
	self:ChangeVCam(self.homeInAniVcamObj, true, false, 0)
end

--家园表现刷新
function CoveManager:RefreshHomeland()
	self:RefreshBuilding()
end

--刷新建筑表现
function CoveManager:RefreshBuilding()
	self._buildingMgr:RefreshBuildingDisAll()
end

function CoveManager:OnUIDataGroupQueueChange()
	-- local num = UIMgr:getUIGroupNum(UIGroup.Main)
	-- if num == 0 then
	-- 	self:setCameraMoveable(true)
	-- else
	-- 	self:setCameraMoveable(false)
	-- end

	local mainBase = UIMgr:GetUI("MainPanel")
	if mainBase ~= nil and mainBase:InHome() then
		self:setCameraMoveable(true)
	else
		self:setCameraMoveable(false)
	end

end

function CoveManager:getScene()
	return self._coveScene
end

function CoveManager:getRoomMgr()
	return self._roomMgr
end

function CoveManager:getBuildingMgr()
	return self._buildingMgr
end

function CoveManager:getRoleMgr()
	return self._roleMgr
end

function CoveManager:getRoomDoorMgr()
	return self._roomDoorMgr
end

function CoveManager:getRanom()
	return self._random
end

function CoveManager:getSpawnPoint()
	local index = math.random(0, self._coveScene.spawnPoints.Length - 1)
	return self._coveScene.spawnPoints[index]
end

function CoveManager:getEndPoint()
	local index = math.random(0, self._coveScene.endPoints.Length - 1)
	return self._coveScene.endPoints[index]
end

function CoveManager:getDisPatchPoint()
	return self._coveScene.disPatchPoint
end

function CoveManager:getDisappearPoint()
	return self._coveScene.disappearPoint
end

function CoveManager:clear()
	if not self._roleMgr then
		return
	end
	GameMsgMgr:unRegEvent(GameMsgType.RefreshHomeland, self, self.RefreshHomeland)
	GameMsgMgr:unRegEvent(GameMsgType.UIDataGroupQueueChange, self, self.OnUIDataGroupQueueChange)

	self:SetHomelandAudioListener(false)
	self._inited = false
	self._roleMgr:clear()
	self._roomDoorMgr:clear()
	self._roomMgr:clear()
	self._buildingMgr:clear()
	CoveShowMgr.instance():Clear()
	CoveBattleMgr.instance():Clear()
	CovePropsMgr.instance():Clear()
	self._focusState = false
	self.initSceneSetting = false
	self:ClearCameraFollowRoleId()
	-- if self.rt ~= nil then
	-- 	DUtil.DestroyImmediate(self.rt)
	-- 	self.rt = nil
	-- end
end

-- --家园建筑点击
-- function CoveManager:onclickBuilding(name)
-- 	self._buildingMgr:onClickBuilding(name)
-- end

--设置聚焦状态
function CoveManager:setFocusState(bool)
	self._focusState = bool
	if bool then
		local fightBgm = CoveBattleMgr.instance():GetFightBGM() 
		if fightBgm ~= nil then
			UIMgr:SetBasalBgm(fightBgm)
			UIMgr:PlayBasalBgm()
		end
		
	else
		UIMgr:SetBasalBgm(nil)
		UIMgr:PlayBasalBgm()
	end
end

--获取聚焦状态
function CoveManager:getFocusState()
	return self._focusState
end

--C# FixedUpdate 回调
function CoveManager:FixedUpdate()
	self:CinemaBlendingUpdate()
	if self._buildingMgr then
		self._buildingMgr:FixedUpdate()
	end
	self:followRole()
end

--跟踪角色
function CoveManager:followRole()
	local followRoleId = self._cameraFollowRoleId
	if followRoleId then
		local role = self._roleMgr:getRole(followRoleId)  --TODO: 
		if role and UICommonUtils.Checkobj(role.modelObj) then
			local rolePos = role.modelObj.transform.position
			self:LookAtPos(GE.HomeLandPerspectiveType.Whole, rolePos, nil, nil, nil, true)
		end
	end
end

--虚拟相机动画融合监听
function CoveManager:CinemaBlendingUpdate()
	-- if self._cinemachineBrain.IsBlending then
	-- 	LuaLogger.ds("CoveManager:CinemaBlendingUpdate 混合中")
		 --有回调则监听结束
		if self._VcamMoveEndCB then
			if not self._activeBlend then
				self._activeBlend = self._cinemachineBrain.ActiveBlend
			end
			if self._activeBlend then
				local blendProgress = self._activeBlend.BlendWeight
				-- LuaLogger.ds("CoveManager:CinemaBlendingUpdate 混合进度", blendProgress)
				--结束监听
				if blendProgress >= 1 then
					self._VcamMoveEndCB()
					self._VcamMoveEndCB = nil
					self._activeBlend = nil
				end
			end
		end
	-- end
end

function CoveManager:Update()
	--是否在家园场景
	if not self:getFocusState() then
		return
	end
	if not UICommonUtils.Checkobj(self.Homeland) then
		return
	end

	-- 处理视野缩放
	self:handleZoom()

	--按下
	if Input.GetMouseButtonDown(0) then
		-- 真机:只记录触摸ID,不保存触摸对象
		self._touchId = Input.touchCount > 0 and Input.GetTouch(0).fingerId or -1
		self.mouseDownPosition = Input.touchCount > 0 and Input.GetTouch(0).position or Vector2(UnityEngine.Input.mousePosition.x, UnityEngine.Input.mousePosition.y)
		self.mouseDownTime = UnityEngine.Time.time
		self.isDragging = false
		--是否点击在场景上 而不是在ui上
		self.isDownOnScene = not self:isPointerOverUIObject()
	end

	--按住
	if Input.GetMouseButton(0) and self.mouseDownPosition then
		-- 如果正在缩放,禁止拖拽
		if self.isZooming then
			self.isDragging = false
			self._lastMousePosition = nil
			return
		end
		
		-- 修复:实时获取当前位置
		local currentMousePosition = nil
		if GV.IsEditor then
			currentMousePosition = Vector2(UnityEngine.Input.mousePosition.x, UnityEngine.Input.mousePosition.y)
		else
			-- 真机:根据保存的touchId查找对应的触摸
			if Input.touchCount > 0 and self._touchId then
				for i = 0, Input.touchCount - 1 do
					local touch = Input.GetTouch(i)
					if touch.fingerId == self._touchId then
						currentMousePosition = touch.position
						break
					end
				end
			end
		end
		
		if not currentMousePosition then
			return
		end
		
		local distance = (currentMousePosition - self.mouseDownPosition).magnitude
		if distance > 20 then
			self.isDragging = true
			if self.isDownOnScene and self.cameraAllowMove then
				self:onDraggingCam(currentMousePosition)
			end
		end
	end

	--抬起
	if Input.GetMouseButtonUp(0) then
		--场景点击监听
		if self.isDownOnScene then
			self:SetGameSceneInfoShowOrHide(true)
			local mouseUpTime = UnityEngine.Time.time
			local clickDuration = mouseUpTime - self.mouseDownTime
			
			-- 修复:抬起时获取最终位置
			local currentMousePosition = self.mouseDownPosition
			if GV.IsEditor then
				currentMousePosition = Vector2(UnityEngine.Input.mousePosition.x, UnityEngine.Input.mousePosition.y)
			else
				if Input.touchCount > 0 and self._touchId then
					for i = 0, Input.touchCount - 1 do
						local touch = Input.GetTouch(i)
						if touch.fingerId == self._touchId then
							currentMousePosition = touch.position
							break
						end
					end
				end
			end
			
			local distance = (currentMousePosition - self.mouseDownPosition).magnitude
			
			if self.isDragging then
				-- 拖拽操作
			elseif clickDuration < 0.2 or distance < 20 then
				-- ...existing code... (点击处理逻辑)
				if UICommonUtils.Checkobj(self.cameraObj) then
					local camera = self.cameraObj and self.cameraObj:GetComponent("Camera")
					if not camera or not camera.main then
						return nil
					end
					local ray = camera.main:ScreenPointToRay(currentMousePosition)
					if GV.IsEditor then
						UnityEngine.Debug.DrawRay(ray.origin, ray.direction * 9999, UnityEngine.Color.red, 10)
					end
					local _, hit = UnityEngine.Physics.Raycast(ray, nil, Mathf.Infinity)
					local isRole = false
					if (hit ~= nil) then
						local hitObj = hit.transform.gameObject
						local name = hitObj.name
						LuaLogger.ds("点到了: ", name)
						isRole = self:onClickRole(name, hitObj)
					end
				end
			end
		end

		-- 重置状态
		self.isDragging = false
		self.mouseDownPosition = nil
		self.mouseDownTime = nil
		self.isDownOnScene = false
		self._lastMousePosition = nil
		self._touchId = nil  -- 清空触摸ID
	end
	
	-- self.constructionRateTime = self.constructionRateTime + Time.deltaTime
	-- if self.constructionRateTime >= refreshTime then
	-- 	self.constructionRateTime = 0
	-- 	self:RefreshBuilding()
	-- end

	self:CheckHeroInteractiveDialogue()

	self:UpdateScene()

	--时钟对应家园时间
	self:doTicktack()
end

function CoveManager:onClickRole(name, hitObj)
	if StoryMgr:getIsHomeLandStory() then
		return 
	end
	if string.find(name, "CoveRole") ~= nil then
		local roleCtrl = hitObj:GetComponent("CoveRoleController")
		local roleId = roleCtrl:GetRoleId()
		-- role:DoRoleClickShow()
		self:focusOnRole(roleId)
		return true
	elseif string.find(name, "CoveMonster") ~= nil then
		self:FocusOnMonster(hitObj)
	elseif string.find(name, "CoveBox") ~= nil then
		self:FocusOnBox(hitObj)
	end

	return true
end

--聚焦角色
function CoveManager:focusOnRole(roleId)
	local role = self._roleMgr:getRole(roleId)
	if not role then
		LuaLogger.ds("CoveManager:focusOnRole 查找到了角色id,但是角色不存在 roleId: ", roleId)
		return
	end
	--是否能互动
	if not role:RoleCanTouch() then
		UICommonUtils.PopToast(LocalStrEnum.CommonTipsRoleCanNotTouch)
		return
	end
	if role then
		-- local maxTime
		-- local inTime = 1
		-- local fovStartTime = 0.01
		-- local fovLastTime = 1
		-- local angleStartTime = 0.01
		-- local angleLastTime = 1
		-- --虚拟相机旋转
		-- local targetRotationX = self.RoleClickCamObj.transform.localEulerAngles.x
		-- --LuaLogger.ds("CoveManager:focusOnRole 角色点击相机初始角度", targetRotationX)
		-- local sourceRotationX = self.cameraRotateRoot.transform.localEulerAngles.x
		-- self.RoleClickCamObj.transform.localRotation = Quaternion.Euler(sourceRotationX, 0, 0)
		-- --虚拟相机位置
		-- self.RoleClickCamObjRoot.transform.position = role._roleObj.transform.position + Vector3.New(0, 2.67, 0)
		-- local isAni = self:ChangeVCam(self.RoleClickCamObj, true, true, inTime)
		-- if isAni then
		-- 	maxTime = inTime > fovStartTime + fovLastTime and inTime or fovStartTime + fovLastTime
		-- 	maxTime = maxTime > angleStartTime + angleLastTime and maxTime or angleStartTime + angleLastTime
		-- 	--同步主相机和角色点击相机的fov 实现fov延迟变化效果
		-- 	self:ChangeVcamFov(self.RoleClickCamVcam, self.mainVcamVcam.m_Lens.FieldOfView)
		-- 	DLuaTimer:DoAfter(fovStartTime, function()
		-- 		DG.Tweening.DOVirtual.Float(self.RoleClickCamVcam.m_Lens.FieldOfView, self.RoleClickCamFov, fovLastTime, function(v)
		-- 			self:ChangeVcamFov(self.RoleClickCamVcam, v)
		-- 		end):SetEase(DG.Tweening.Ease.Linear)
		-- 	end)
		-- 	--实现角度延迟变化效果
		-- 	DLuaTimer:DoAfter(angleStartTime, function()
		-- 		DG.Tweening.DOVirtual.Float(sourceRotationX, targetRotationX, angleLastTime, function(v)
		-- 			self.RoleClickCamObj.transform.localRotation = Quaternion.Euler(v, 0, 0)
		-- 		end):SetEase(DG.Tweening.Ease.Linear)
		-- 	end)
		-- end
		role:tempHideOtherRoleUI({})
		local maxTime = 1
		--克隆主相机参数
		self.RoleClickCamObj.transform.rotation = self.mainVcamObj.transform.rotation
		self.RoleClickCamObj.transform.position = self.mainVcamObj.transform.position
		self.RoleClickCamVcam.m_Lens = self.mainVcamVcam.m_Lens
		--切换相机
		self:ChangeVCam(self.RoleClickCamObj, true, false, 0)
		--追踪物体 先移动到角色位置 用于锚定相机位置
		self.RoleClickTargetObj.transform.position = role._roleObj.transform.position + Vector3.New(0, 1.67/5/0.7, 0)
		--相机位移
		local camTargetPos = self.RoleClickTargetCamObj.transform.position
		self.RoleClickCamObj.transform:DOMove(camTargetPos, maxTime):SetEase(DG.Tweening.Ease.InOutQuad)
		--隐藏遮挡物
		self:hideRaycastObstruction(camTargetPos, roleId, true)
		--再重置到当前主相机聚焦位置 跟踪目标位移
		local originPos = self.RoleClickTargetObj.transform.position
		self.RoleClickTargetObj.transform.position = self.cameraRoot.transform.position
		self.RoleClickTargetObj.transform:DOMove(originPos, maxTime):SetEase(DG.Tweening.Ease.InOutQuad)
		-- --target组 实现跟踪缓动效果
		-- self.RoleClickTargetGroup.m_Targets = {}
		-- self.RoleClickTargetGroup:AddMember(role.model.transform, 0, 1)
		-- self.RoleClickTargetGroup:AddMember(self.RoleClickTargetObj.transform, 1, 1)
		-- --target组位置变化
		-- DG.Tweening.DOVirtual.Float(0, 1, maxTime, function(v)
		-- end)
		--后处理变化
		self:DisableHomeLandWeather()
		self.originGlobalV = self.GlobalVolume.weight
		self.originOverlayV = self.OverlayVolume.weight
		DG.Tweening.DOVirtual.Float(0, 1, maxTime, function(v)
			self.GlobalVolume.weight = self.originGlobalV * (1 - v)
			self.OverlayVolume.weight = self.originOverlayV * (1 - v)
			local start = 0.4
			self.focusRoleVolume.weight = 0.4 + (1 - 0.4) * v
		end)
		--灯光角度
		self.originHeroLightRotation = self.HeroDynamicLight.transform.rotation.eulerAngles
		self.HeroDynamicLight.transform:DORotateQuaternion(focusRoleLightRotation, maxTime)
		--灯光强度
		local light = self.HeroDynamicLight.transform:GetComponent(typeof(UnityEngine.Light))
		self.originLightIntensity = light.intensity
		DG.Tweening.DOVirtual.Float(self.originLightIntensity, focusRoleLightIntensity, maxTime, function(v)
			light.intensity = v
		end)
		--fov
		-- local fovStartTime = 0.2
		-- local fovEndTime = 1
		-- DLuaTimer:DoAfter(fovStartTime, function()
		-- 	DG.Tweening.DOVirtual.Float(self.RoleClickCamVcam.m_Lens.FieldOfView, self.RoleClickCamFov, fovEndTime - fovStartTime, function(v)
		-- 		self:ChangeVcamFov(self.RoleClickCamVcam, v)
		-- 	end)
		-- end)
		self:setFocusState(false)
		--角色停止动作
		role:DoRoleClickShow()
		--关ui
		local mainPanel = UIMgr:GetUI("MainPanel")
		if mainPanel then
			mainPanel:HideAll(true, true)
		end
		self:SetHomeUICanvasOpen(false)
		--镜头移动完成后回调
		local CB = function()
			--家园角色交互面板
			LuaLogger.ds("CoveManager:focusOnRole 镜头移动完成")
			self:CreateClickMenu(roleId)
		end
		--cut模式下没有镜头过渡动画 直接回调
		-- if isAni then
			-- self._VcamMoveEndCB = CB
			DLuaTimer:DoAfter(maxTime, function()
				CB()
			end)
		-- else
		-- 	CB()
		-- end
	end
end

function CoveManager:FocusOnMonster(monsterCoveObj)
	local allCoveMap = self._roleMgr:GetAllCoveTab()
	if allCoveMap == nil then
		return
	end
	---@type CoveBase
	local coveBase = nil
	for k, v in pairs(allCoveMap) do
		if v == nil then
			goto continue
		end
		if v.destroyed then
			goto continue
		end
		if v._roleObj == monsterCoveObj then
			coveBase = v
		end
		::continue::
	end
	if coveBase == nil then
		return
	end
	if not coveBase:RoleCanTouch() then
		return
	end
	coveBase:OnClick()
end

---@param coveBoxObj UnityEngine.GameObject
function CoveManager:FocusOnBox(coveBoxObj)
	local coveBoxs = CoveBattleMgr.instance().coveBoxs
	if coveBoxs == nil then
		return
	end
	---@type CoveBox
	local coveBox = nil
	for k, v in pairs(coveBoxs) do
		if v == nil then
			goto continue
		end
		if v.destroyed then
			goto continue
		end
		if v.modelObj == coveBoxObj then
			coveBox = v
		end
		::continue::
	end
	if coveBox == nil then
		return
	end
	coveBox:OnClick()
end

-- 可视化 BoxCast 的盒子（仅在编辑器中生效）
function CoveManager:DebugDrawBoxCast(origin, halfExtents, direction, distance, color, duration)
    if not GV.IsEditor then
        return
    end
    
    duration = duration or 15
    
    -- 计算终点位置
    local targetPos = origin + direction * distance
    
    -- 获取盒子的8个顶点（局部坐标）
    local hx, hy, hz = halfExtents.x, halfExtents.y, halfExtents.z
    local corners = {
        Vector3.New(-hx, -hy, -hz), Vector3.New( hx, -hy, -hz),
        Vector3.New( hx, -hy,  hz), Vector3.New(-hx, -hy,  hz),
        Vector3.New(-hx,  hy, -hz), Vector3.New( hx,  hy, -hz),
        Vector3.New( hx,  hy,  hz), Vector3.New(-hx,  hy,  hz),
    }
    
    -- 绘制起点位置的盒子轮廓
    for i = 1, #corners do
        local p1 = origin + corners[i]
        local p2 = origin + corners[i % 8 + 1]
        UnityEngine.Debug.DrawLine(p1, p2, color, duration)
    end
    
    -- 绘制终点位置的盒子轮廓
    for i = 1, #corners do
        local p1 = targetPos + corners[i]
        local p2 = targetPos + corners[i % 8 + 1]
        UnityEngine.Debug.DrawLine(p1, p2, color, duration)
    end
    
    -- 绘制起点到终点的连接线（8条棱边连线）
    for i = 1, #corners do
        local startCorner = origin + corners[i]
        local endCorner = targetPos + corners[i]
        UnityEngine.Debug.DrawLine(startCorner, endCorner, color, duration)
    end
end

--隐藏遮挡物
---@param pos UnityEngine.Vector3 位置（相机位置）
---@param roleId integer 角色id
---@param isHide boolean 是否隐藏
function CoveManager:hideRaycastObstruction(pos, roleId, isHide)
    if not isHide then
        for _, obj in pairs(self._hiddenObstructionList) do
            if UICommonUtils.Checkobj(obj) then
                obj:SetActive(true)
            end
        end
        self._hiddenObstructionList = {}
    else
        local modelObj = self._roleMgr:getRole(roleId).modelObj
        local capsuleCollider = modelObj:GetComponent("CapsuleCollider")
        if not capsuleCollider then
            LuaLogger.es(modelObj.name .. " 角色胶囊碰撞体丢失 无法隐藏建筑 CoveManager:hideRaycastObstruction")
            return
        end
        
        -- 通过 bounds 获取胶囊体的大小来推算半径
        local bounds = capsuleCollider.bounds
        
        -- -- 或者直接使用固定的盒子大小（更稳定）
        -- local boxRadius = 0.25  -- 固定值，可根据角色大小调整
        local scale = 0.6
        local boxHalfExtents = Vector3.New(bounds.size.x * scale, bounds.size.y * scale, bounds.size.z * scale)
        
        -- 计算方向：从相机位置指向角色中心
        local roleCenter = capsuleCollider.bounds.center
        local direction = roleCenter - pos
        local distance = direction.magnitude
        direction = direction.normalized
        
		--可视化碰撞体
        if GV.IsEditor then
			self:DebugDrawBoxCast(pos, boxHalfExtents, direction, distance, Color.green, 15)
            UnityEngine.Debug.DrawLine(pos, roleCenter, Color.blue, 15)
        end
        
        -- 用 BoxCast 从相机位置向角色中心发射
        local hits = UnityEngine.Physics.BoxCastAll(pos, boxHalfExtents, direction, 
            Quaternion.identity, distance, LayerMask.GetMask("Default", "SceneOutlined2", "SceneOutlined"))
        
        if hits and hits.Length > 0 then
            for i = 0, hits.Length - 1 do
                local hit = hits[i]
                local hitObj = hit.collider.gameObject
                
                -- 跳过角色自身及其子物体
                if hitObj ~= modelObj then
                    LuaLogger.ds("命中遮挡物", hitObj.name)
					hitObj:SetActive(false)
					table.insert(self._hiddenObstructionList, hitObj)
                end
            end
        end
    end
end

--取消聚焦角色
function CoveManager:exitFocus()
	local role = self._roleMgr:getRole(self._clickMenuData.roleId)
	if role then
		-- local maxTime
		-- local inTime = 1
		-- local fovStartTime = 0.1
		-- local fovLastTime = 1
		-- --同步主相机和角色点击相机的fov 实现fov延迟变化效果
		-- local originFov = self.mainVcamVcam.m_Lens.FieldOfView
		-- local isAni = self:ChangeVCam(self.RoleClickCamObj, false, true, 1)
		-- if isAni then
		-- 	maxTime = inTime > fovStartTime + fovLastTime and inTime or fovStartTime + fovLastTime
		-- 	--同步主相机和角色点击相机的fov 实现fov延迟变化效果
		-- 	self:ChangeVcamFov(self.mainVcamVcam, self.RoleClickCamVcam.m_Lens.FieldOfView)
		-- 	DLuaTimer:DoAfter(fovStartTime, function()
		-- 		local start = self.RoleClickCamVcam.m_Lens.FieldOfView
		-- 		DG.Tweening.DOVirtual.Float(start, originFov, fovLastTime, function(v)
		-- 			self:ChangeVcamFov(self.mainVcamVcam, v)
		-- 		end)
		-- 	end)
		-- end
		local maxTime = 1
		--跟踪点位移
		local targetPos = self.cameraRoot.transform.position
		self.RoleClickTargetObj.transform:DOMove(targetPos, maxTime):SetEase(DG.Tweening.Ease.InOutQuad)
		--相机位移
		local camTargetPos = self.mainVcamObj.transform.position
		self.RoleClickCamObj.transform:DOMove(camTargetPos, maxTime):SetEase(DG.Tweening.Ease.InOutQuad)
		--后处理变化
		DG.Tweening.DOVirtual.Float(0, 1, maxTime, function(v)
			self.OverlayVolume.weight = self.originOverlayV * (v)
			self.GlobalVolume.weight = self.originGlobalV * (v)
			self.focusRoleVolume.weight = 1 - v
		end)
		--灯光角度
		self.HeroDynamicLight.transform:DORotate(self.originHeroLightRotation, maxTime)
		--灯光强度
		local light = self.HeroDynamicLight.transform:GetComponent(typeof(UnityEngine.Light))
		local originIntensity = light.intensity
		DG.Tweening.DOVirtual.Float(originIntensity, self.originLightIntensity, maxTime, function(v)
			light.intensity = v
		end)
		--角色退出聚焦模式
		role:exitFocusBehavior()
		--清除家园角色交互面板
		self:clearClickMenu()
		--镜头移动完成后回调
		local CB = function()
			--切换相机
			self:ChangeVCam(self.RoleClickCamObj, false, false, 0)
			self:setFocusState(true)
			local mainPanel = UIMgr:GetUI("MainPanel")
			if mainPanel then
				mainPanel:HideAll(false)
			end
			self:SetHomeUICanvasOpen(true)
			self:hideRaycastObstruction(nil, nil, false)
			self:EnableHomeLandWeather()
			role:ShowAllRoleUI()
		end
		--cut模式下没有镜头过渡动画 直接回调
		-- if isAni then
			DLuaTimer:DoAfter(maxTime, function()
				CB()
			end)
		-- else
			-- CB()
		-- end
	end
end

--创建家园角色交互面板
function CoveManager:CreateClickMenu(roleId)
	-- LuaLogger.ds("CoveManager:CreateClickMenu", roleId)
	self:clearClickMenu()
	--家园角色交互面板数据
	---@class ClickMenuData
	---@field roleId integer 角色id
	---@field roleTalkList table 角色对话列表
	---@field btnList table 按钮列表
	---@field homepart UnityEngine.GameObject 家园部分
	---@field talkpart UnityEngine.GameObject 对话部分
	---@field menuType GE.ClickMenuType 交互菜单类型
	self._clickMenuData = {
		roleId = roleId,
		menuType = GE.ClickMenuType.home,
		btnList = {},	--按钮列表
		-- {
		-- 	menuType = GE.ClickMenuType, 按钮类型
		--  obj = UnityEngine.GameObject 按钮对象
		-- }
		homepart = nil,
		talkpart = nil,
		roleTalkList = {},	--角色话题-对话列表
	}
	local roleTalkSeed = self:getRoleTalkSeed(roleId)
	self._clickMenuData.roleTalkList, self._clickMenuData.urgentList = self:generateTalkData(roleId, roleTalkSeed)
	PoolMgr:Get(Config.PrefabPath.Interaction, function (obj)
		self._clickMenu = obj
		self._clickMenuData.homepart = obj.transform:Find("AdjustRoot/homeParent").gameObject
		self._clickMenuData.talkpart = obj.transform:Find("AdjustRoot/talkParent").gameObject
		self._clickMenuData.emote = obj.transform:Find("AdjustRoot/InteractionEmote").gameObject
		self._clickMenuData.emote:SetActive(false)
		local uiroot = UIMgr:GetUIRootParent()
		obj.transform:SetParent(uiroot.transform, false)
		--初始化页面
		self:createClickMenuBtn()
		--刷新页面
		self:changeMenuByType(GE.ClickMenuType.home)
		--obj:SetActive(true)
	end)
end

---显示角色互动emote
--@param emoteName string 表情名称
function CoveManager:showClickMenuEmote(emoteName)
	local objSpineAnim = self._clickMenuData.emote:GetComponent("SkeletonAnimation")
	objSpineAnim.AnimationState:SetAnimation(1, emoteName, true)
	self._clickMenuData.emote:SetActive(true)
end

--根据类型刷新家园角色交互面板
function CoveManager:changeMenuByType(type)
	self._clickMenuData.menuType = type
	self._clickMenuData.homepart:SetActive(self._clickMenuData.menuType == GE.ClickMenuType.home)
	--self._clickMenuData.talkpart:SetActive(self._clickMenuData.menuType == GE.ClickMenuType.talk)
end

--创建家园角色交互面板按钮
function CoveManager:createClickMenuBtn()
	local btn = self._clickMenu.transform:Find("AdjustRoot/homeParent/homebox").gameObject
	local btn2 = self._clickMenu.transform:Find("AdjustRoot/talkParent/talkbox").gameObject
	local homeParent = self._clickMenu.transform:Find("AdjustRoot/homeParent").gameObject
	local talkParent = self._clickMenu.transform:Find("AdjustRoot/talkParent").gameObject
	btn:SetActive(true)
	btn2:SetActive(true)
	--对话部分
	local temp = {}
	local index = 0
	for _, urgentTopicId in pairs(self._clickMenuData.urgentList) do
		local talkId = self._clickMenuData.roleTalkList[urgentTopicId]
		table.insert(temp, {topicId = urgentTopicId, talkId = talkId})
		self._clickMenuData.roleTalkList[urgentTopicId] = nil
	end
	for topicId, talkId in pairs(self._clickMenuData.roleTalkList) do
		table.insert(temp, {topicId = topicId, talkId = talkId})
	end
	LuaLogger.ds("CoveManager:createClickMenuBtn 最终角色对话列表", tablex.dump(temp))


	local roleId = self._clickMenuData.roleId
	local heroData = Me:getPlayerHero(roleId)
	local aatalkId = 0
	if heroData ~= nil and heroData.interactionInfo ~= nil and heroData.interactionInfo ~= 0 then
		aatalkId = heroData.interactionInfo
	end



	for _, v in pairs(temp) do
		local topicInfo = Config.GetHomeTouchTopicInfo(v.topicId)
		local titleName = topicInfo.topicName
		---@type UnityEngine.GameObject
		local instObj = Instantiate(btn2).gameObject
		instObj.transform:SetParent(talkParent.transform, false)
		--背景
		index = index + 1

		if index%2 == 1 then
			instObj.transform:Find("bg").transform.localEulerAngles = Vector3.New(0, 180, 0)
			---@type UnityEngine.RectTransform
			local rtrs = instObj.transform
		end
		--标题
		instObj.transform:Find("desc"):GetComponent(TypeInfo.TextMeshProUGUI).text = titleName
		---@type UnityEngine.Animation
		local animation = instObj:GetComponent(TypeInfo.Animation)
		local isShow = (aatalkId == 0 or v.talkId == aatalkId)
		local temp = {
			-- menuType = GE.ClickMenuType.talk,
			data = v,
			obj = instObj,
			index = index,
			type = 1,
			animation = animation,
			isShow = isShow
		}
		
		---@type UnityEngine.CanvasGroup
		local canvasGroup = instObj:GetComponent(TypeInfo.CanvasGroup)
		canvasGroup.alpha = isShow and 1 or 0
		animation.enabled = isShow

		---@type ScaleButton
		local btn = instObj:GetComponent(TypeInfo.Button)
		btn.interactable = isShow


		local talkId = v.talkId
		--点击按钮
		local Btn = instObj:GetComponent(TypeInfo.Button)
		Btn.onClick:RemoveAllListeners()
		Btn.onClick:AddListener(function()
			for k1, v1 in pairs(self._clickMenuData.btnList) do
				if v1.data ~= nil then
					local isShow = v1.data.talkId == talkId

					if not isShow and v1.isShow then
						local anima = v1.animation
						anima:Play("talk_open_hide")
					end

					---@type ScaleButton
					local btn = v1.obj:GetComponent(TypeInfo.Button)
					btn.interactable = false
				end
			end

			animation:Play("talk_open_select")
			animation:PlayQueued("talk_open_hide")

			DLuaTimer:DoAfter(1.4, function()
				self:ClickMenuSetActive(false)
				if self._clickMenuData == nil then
					return
				end

				UIMgr:popUICover("CoveStoryPanel", {
			
					roleId = self._clickMenuData.roleId,
					talkId = v.talkId,
					exitCB = function()
						for k1, v1 in pairs(self._clickMenuData.btnList) do
							if v1.data ~= nil then
								local isShow = v1.data.talkId == talkId
								local anima = v1.animation
								anima.enabled = isShow
								---@type UnityEngine.CanvasGroup
								local canvasGroup = v1.obj:GetComponent(TypeInfo.CanvasGroup)
								canvasGroup.alpha = isShow and 1 or 0
								v1.isShow = isShow
								---@type ScaleButton
								local btn = v1.obj:GetComponent(TypeInfo.Button)
								btn.interactable = isShow
							end
						end
						self:ClickMenuSetActive(true)
					end
				})
				self:recordUrgentTalkRead(v.topicId)
			end)



		end)
		table.insert(self._clickMenuData.btnList, temp)
	end
	--退出按钮
	local exitBtn = self._clickMenu.transform:Find("AdjustRoot/talkParent/exit"):GetComponent(TypeInfo.Button)
	exitBtn.onClick:RemoveAllListeners()
	exitBtn.onClick:AddListener(function()
		self:changeMenuByType(GE.ClickMenuType.home)
	end)

	--行为部分
	--打招呼
	local instObj = Instantiate(btn).gameObject
	instObj.transform:SetParent(homeParent.transform, false)
	--图片
	-- local icon = instObj.transform:Find("icon").gameObject
	-- icon:SetActive(true)
	-- AssetManager.Instance:LoadSpriteAsync(string.format(Config.SpritePath.CoveMenuIcon, "01"), function (sprite)
	-- 	if sprite then
	-- 		icon:GetComponent(TypeInfo.Image).sprite = sprite
	-- 		icon:SetActive(true)
	-- 	end
	-- end)
	local temp = {
		-- menuType = GE.ClickMenuType.home,
		obj = instObj
	}
	--点击按钮
	local Btn = instObj:GetComponent(TypeInfo.ScaleButton)
	Btn.onClick:RemoveAllListeners()
	Btn.onClick:AddListener(function()
		--打招呼逻辑
		local roleId = self._clickMenuData.roleId
		local role = self._roleMgr:getRole(roleId)
		if role then
			self._clickMenuData.homepart.gameObject:SetActive(false)
			self._clickMenuData.talkpart.gameObject:SetActive(false)
			role:touchBehavior(function()
				--self:exitFocus()
				self._clickMenuData.homepart.gameObject:SetActive(true)
				self._clickMenuData.talkpart.gameObject:SetActive(true)
				self._clickMenuData.emote:SetActive(false)
			end)
		end
	end)
	table.insert(self._clickMenuData.btnList, temp)

	--聊天
	--[[local instObj = Instantiate(btn).gameObject
	instObj.transform:SetParent(homeParent.transform, false)
	instObj.transform:Find("desc"):GetComponent(TypeInfo.TextMeshProUGUI).text = "聊天"
	--图片
	local icon = instObj.transform:Find("icon").gameObject
	icon:SetActive(false)
	AssetManager.Instance:LoadSpriteAsync(string.format(Config.SpritePath.CoveMenuIcon, "02"), function (sprite)
		if sprite then
			icon:GetComponent(TypeInfo.Image).sprite = sprite
			icon:SetActive(true)
		end
	end)
	local temp = {
		menuType = GE.ClickMenuType.home,
		obj = instObj
	}
	--点击聊天按钮
	local Btn = instObj:GetComponent(TypeInfo.ScaleButton)
	Btn.onClick:RemoveAllListeners()
	Btn.onClick:AddListener(function()
		self:changeMenuByType(GE.ClickMenuType.talk)
	end)
	table.insert(self._clickMenuData.btnList, temp)]]




	--退出按钮
	---@type ScaleButton
	local exitBtn = self._clickMenu.transform:Find("AdjustRoot/homeParent/returnBox"):GetComponent(TypeInfo.ScaleButton)
	exitBtn.onClick:RemoveAllListeners()
	exitBtn.onClick:AddListener(function()
		if self._clickMenuData.menuType == GE.ClickMenuType.talk then
			self:changeMenuByType(GE.ClickMenuType.home)
		else
			self:exitFocus()
		end
		-- self:exitFocus(roleId)
	end)
	exitBtn.transform:SetAsLastSibling()
	btn:SetActive(false)
	btn2:SetActive(false)

	self:ClickMenuSetActive(false)
	self:RandomCoveRoleReplyId( self._clickMenuData.roleId)


	---@type UnityEngine.GameObject
	local taskViewObj = self._clickMenu.transform:Find("AdjustRoot/taskView").gameObject


	---@type UnityEngine.GameObject
	local taskShowBtn = self._clickMenu.transform:Find("AdjustRoot/taskShowBtn").gameObject


	---@type PointerListener
	local c = taskShowBtn:GetComponent(TypeInfo.PointerListener)
	c.onPointerDownEvent = function(obj)
		taskViewObj:SetActive(true)
		self:RefreshInteractionTask()
	end

	c.onPointerUpEvent = function(obj)
		taskViewObj:SetActive(false)
	end
	local trsansform = self._clickMenu.transform
	local taskView = trsansform:Find("AdjustRoot/taskView")
	taskView.gameObject:SetActive(false)

end

---随机英雄默认对话
---@param roleId integer
function CoveManager:RandomCoveRoleReplyId(roleId)
	local cfgs = Config.GetHomeTouchReplyTable()
	if cfgs == nil then
		return
	end

	local curTime = self.curSceneTime
	if curTime == nil then
		return
	end
	local h = curTime / (60 * 60)
	local allWeight = 0
	---@type HomeTouchReplyTable[]
	local replys = {}
	for k, v in pairs(cfgs) do
		if v.character ~= 0 and v.character ~= roleId then
			goto continue
		end
		if v.time ~= nil then
			local success = true
			for i = 1, #v.time do
				local min, max = v.time[i][1], v.time[i][2]
				if h < min or h > max then
					success = false
					break
				end
			end
			if not success then
				goto continue
			end
		end
		if not Me:canOpenFunctionByCfg(v.unlock) then
            goto continue
        end
		allWeight = allWeight + v.weight
		table.insert(replys, v)
		::continue::
	end
	if allWeight == 0 then
		return
	end
	local randomVal = math.random(allWeight)
    local randomId = 0
	local t = 0
    for i = 1, #replys, 1 do
        local cfg = replys[i]
		t = t + cfg.weight
        if t >= randomVal then
            randomId = cfg.id
            break
        end
    end
	if randomId == 0 then
		return
	end
	self:ClickMenuSetActive(false)
	UIMgr:popUICover("CoveStoryPanel", {
		roleId = roleId,
		type = 2,
		talkId = randomId,
		exitCB = function()
			self:ClickMenuSetActive(true)
		end
	})
end
function CoveManager:RefreshInteractionTask()

	---@type UnityEngine.Transform
	local trsansform = self._clickMenu.transform
	local taskView = trsansform:Find("AdjustRoot/taskView")
	if IsNull(taskView) then
		return
	end
	---@type MissionInfo[]
	local taskIds = {}
	local taskList = Me:getMissionList()
	for k, v in pairs(taskList) do
		local taskId = v.id
		local cfg = Config.GetTaskTableInfo(taskId)
		if cfg ~= nil and cfg.taskType == GE.MissionType.HomeLandEvent then
			table.insert(taskIds, v)
		end
	end

	local taskPrefab = trsansform:Find("AdjustRoot/taskView/taskPrefab").gameObject
	taskPrefab:SetActive(false)
	local childCount = taskView.childCount
	for i = 1, #taskIds do
		---@type UnityEngine.GameObject
		local taskObj = nil
		if (i - 1) < childCount then
			taskObj =  taskView:GetChild(i - 1).gameObject
		else
			---@type UnityEngine.GameObject
			taskObj = EngineUtil.Instantiate(taskPrefab)
		end
		taskObj:SetActive(true)
		local taskTrs = taskObj.transform
		local customBoxObj = taskTrs:Find("CustomBox").gameObject
		---@type CustomBox
		local customBox = customBoxObj:AddComponentLua("CustomBox")
		local main = UIMgr:GetUI("MainPanel")
		customBox:setMono(main)
		local obj = {
			gameObject = taskObj,
			transform = taskTrs,
			customBox = customBox,
			nameText = taskTrs:Find("nameText"):GetComponent(TypeInfo.TextMeshProUGUI),
			lineImage = taskTrs.transform:Find("lineImage"):GetComponent(TypeInfo.Text)
		}
	
		local serverData = taskIds[i]
		local cfg = Config.GetTaskTableInfo(taskIds[i].id)
		if cfg == nil then
			return
		end
		local isFinish = serverData.state == GE.MissionState.Received
		local award = cfg.Award[1]

		---@type CustomBox
		local customBox = obj.customBox
		customBox:SetUIData(award, {isGet = isFinish})

		obj.nameText.text = string.format("%s(%s/%s)", cfg.taskName, serverData.progress, cfg.complete[2])
	end
end



--控制家园角色交互面板显示隐藏
function CoveManager:ClickMenuSetActive(bool)
	if self._clickMenu == nil then
		return
	end
	self._clickMenu:SetActive(bool)
	if not bool then
		return		
	end

	local roleId = self._clickMenuData.roleId
	local heroData = Me:getPlayerHero(roleId)
	local aatalkId = 0
	if heroData ~= nil and heroData.interactionInfo ~= nil and heroData.interactionInfo ~= 0 then
		aatalkId = heroData.interactionInfo
	end



	local btnList = self._clickMenuData.btnList
	if btnList == nil then
		return
	end
	aatalkId = 0
	if aatalkId ~= 0 then
		for k, v in pairs(btnList) do
			if v.type == 1 and v.isShow then
				local index = v.index
				---@type UnityEngine.Animation
				local anima = v.animation
				anima:Play("talk_open_idle")
			end
		end
		return
	else
		for k, v in pairs(btnList) do
			if v.type == 1 and v.isShow then
				local index = v.index
				---@type UnityEngine.Animation
				local anima = v.animation
				local clipName = "talk_open_right"
				if index % 2 == 1 then
					clipName = "talk_open_left"
				end
				anima:Play(clipName)
				anima:PlayQueued("talk_open_idle")
			end
		end
	end
end

--清除家园角色交互面板
function CoveManager:clearClickMenu()
	if self._clickMenuData and self._clickMenuData.btnList then
		for k, v in pairs(self._clickMenuData.btnList) do
			PoolMgr.Free(v.obj)
		end
	end
	if self._clickMenu then
		PoolMgr.Free(self._clickMenu)
	end
	
	self._clickMenu = nil
	self._clickMenuData = nil
end

--获取家园角色对话数据
function CoveManager:getHomelandRoleTalkData()
	if not self._homelandRoleTalkData then
		local serverData = ClientData:GetCustomData(GE.CustomDataKey.HomelandRoleTalk)
		self._homelandRoleTalkData = serverData and serverData or {}
	end
	LuaLogger.ds("获取家园角色对话数据", tablex.dump(self._homelandRoleTalkData))
	return self._homelandRoleTalkData
end

--设置家园角色对话数据
function CoveManager:setHomelandRoleTalkData(jsonData)
	LuaLogger.ds("设置家园角色对话数据", tablex.dump(jsonData))
	Me:RecordCustomData({
		[GE.CustomDataKey.HomelandRoleTalk] = jsonData
	})
	self._homelandRoleTalkData = jsonData
end

--记录看过紧急主题数据
function CoveManager:recordUrgentTalkRead(topicId)
	if not topicId then
		return
	end
	local roleId = self._clickMenuData.roleId
	local jsonData = self:getHomelandRoleTalkData()
	local urgentTable = jsonData.urgentTable[roleId] or {}
	if not tablex.contains(urgentTable, topicId) then
		LuaLogger.ds("CoveManager:recordUrgentTalkRead topicId不在紧急列表中", topicId)
		return
	end
	--已阅列表
	if not jsonData.watchedUrgentTable then
		jsonData.watchedUrgentTable = {}
	end
	--检查是否已阅
	for _, v in pairs(jsonData.watchedUrgentTable) do
		if v == topicId then
			return
		end
	end
	--记录已阅
	table.insert(jsonData.watchedUrgentTable, topicId)
	LuaLogger.ds("CoveManager:recordUrgentTalkRead 记录已阅紧急对话id", topicId)
	--剔除紧急列表
	if jsonData.urgentTable and jsonData.urgentTable[roleId] then
		for k, v in pairs(jsonData.urgentTable[roleId]) do
			if v == topicId then
				table.remove(jsonData.urgentTable[roleId], k)
				LuaLogger.ds("CoveManager:recordUrgentTalkRead 剔除紧急对话id", topicId)
				break
			end
		end
	end
	--更新最新数据
	self:setHomelandRoleTalkData(jsonData)
end

--获取角色对话随机种子
---@return integer
function CoveManager:getRoleTalkSeed(roleId)
	
	local jsonData = self:getHomelandRoleTalkData()
	if type(jsonData) == "string" then
		jsonData = Me:jsonDecode(jsonData)
	end
	
	-- {
	-- 	lastRefreshDay = int,
	-- 	talkSeedTable = {
	-- 		[roleId] = int
	-- 	}
	--	urgentTable = {
	--		[roleId] = {int, int, int} --紧急主题id列表
	-- },
	--	watchedUrgentTable = {
	--		int, int, int --已阅主题对话id列表
	-- },
	--初始化
	local defaultData = {
		lastRefreshDay = 0,
		talkSeedTable = {},
		urgentTable = {},
		watchedUrgentTable = {},
	}
	for k, v in pairs(defaultData) do
		if not jsonData[k] then
			jsonData[k] = v
		end
	end
	--判断是否同一天 不是则需要重置随机种子列表
	local curDay = Me.userData.LoginDay
	--新一天
	if jsonData.lastRefreshDay ~= curDay then
		--清空随机种子列表
		jsonData.talkSeedTable = {}
		jsonData.lastRefreshDay = Me.userData.LoginDay
	end
	--刷新随机种子
	local seed = jsonData.talkSeedTable[tostring(roleId)] or nil
	LuaLogger.ds("CoveManager:getRoleTalkSeed 随机种子", seed)
	if not seed then
		local talkSeed = os.time()
		LuaLogger.ds("CoveManager:getRoleTalkSeed 生成新随机种子", talkSeed)
		jsonData.talkSeedTable[tostring(roleId)] = talkSeed
	end
	--检查紧急列表
	--todo检查是否有表里不存在的紧急对话id 有则需要剔除
	--更新最新数据
	self:setHomelandRoleTalkData(jsonData)
	return jsonData.talkSeedTable[tostring(roleId)]
end

--生成角色对话数据
function CoveManager:generateTalkData(roleId, seed)
	local maxTalkNum = 4	--最大对话数量
	local urgentTalkNum = 1	--紧急对话数量
	local talkList = {}
	-- {
-- 		[10101] = {		--句子id
		-- 	str,	--段落id
		-- 	str
		-- },
-- 		[10102] = {		--句子id
		-- 	str,	--段落id
		--  	str
		-- },...
	-- }
	local result = {}
	local urgentList = {}
	--主题列表
	local topicTable = Config.GetHomeTouchTopicInfoByGroupId(roleId)

	local data = self:getHomelandRoleTalkData()
	--处理紧急主题数据
	local isChanged = self:handleUrgentTopic(data, topicTable, roleId)
	LuaLogger.ds("CoveManager:generateTalkData 紧急主题", tablex.dump(data.urgentTable))
	--优先合并紧急主题
	local urgentNum = 0
	for _, topicId in pairs(data.urgentTable[roleId]) do
		if urgentNum >= urgentTalkNum then
			break
		end
		table.insert(result, topicId)
		table.insert(urgentList, topicId)
		--从普通列表剔除
		for k, v in pairs(topicTable) do
			if v.id == topicId then
				topicTable[k] = nil
				break
			end
		end
		urgentNum = urgentNum + 1
	end
	LuaLogger.ds("CoveManager:generateTalkData 处理完紧急主题结果", tablex.dump(result))
	--处理普通主题逻辑
	local normalTalk = self:handleNormalTopic(seed, topicTable, maxTalkNum)
	LuaLogger.ds("CoveManager:generateTalkData 普通主题", tablex.dump(normalTalk))
	local normalNum = 0
	for _, topicId in pairs(normalTalk) do
		if normalNum + urgentNum >= maxTalkNum then
			break
		end
		table.insert(result, topicId)
		normalNum = normalNum + 1
	end
	LuaLogger.ds("CoveManager:generateTalkData 最终结果", tablex.dump(result))
	local finalResult = self:handleWordsData(seed, result, data)
	LuaLogger.ds("CoveManager:generateTalkData 生成对话内容", tablex.dump(finalResult))
	if isChanged then
		--更新最新数据
		self:setHomelandRoleTalkData(data)
	end
	return finalResult, urgentList
end

--生成具体对话内容
--@param data table 本地存储数据
--@param seed int 随机种子
--@param topicIdList int[] 主题列表
function CoveManager:handleWordsData(seed, topicIdList, data)
	local random = Random:new(seed)
	local result = {}
	for _, topicId in ipairs(topicIdList) do
		-- LuaLogger.ds("CoveManager:handleWordsData 处理主题id", topicId)
		local topicInfo = Config.GetHomeTouchTopicInfo(topicId)
		local WordsList = Config.GetHomeTouchWordsInfoByGroupId(topicInfo.wordsGroup)
		local talkId = nil
		--检测是否有紧急对话
		local isurgent = false
		for _, wordsData in pairs(WordsList) do
			if tablex.size(wordsData.forceCondition) > 0 then
				isurgent = self:checkWordsUrgentCondition(WordsList.forceCondition)
				if isurgent then
					break
				end
			end
			if isurgent then
				talkId = wordsData.samePassage
				break
			end
		end
		--紧急对话优先
		if isurgent then
			result[topicId] = talkId
		else
			--普通对话逻辑
			local weightList = {}
			for _, wordsData in pairs(WordsList) do
				--检测触发条件
				local isAdd = self:checkWordsCondition(wordsData.condition)
				--同一段对话会有多条句子 weight只取第一条
				if isAdd and not weightList[wordsData.samePassage] then
					weightList[wordsData.samePassage] = wordsData.weight
				end
			end
			-- LuaLogger.ds("CoveManager:handleWordsData 普通对话权重列表", tablex.dump(weightList))
			local totalWeight = 0
			for _, weight in pairs(weightList) do
				totalWeight = totalWeight + weight
			end
			local randValue = random:range(0, totalWeight)
			local cumulativeWeight = 0
			for talkId, weight in pairs(weightList) do
				cumulativeWeight = cumulativeWeight + weight
				if randValue <= cumulativeWeight then
					result[topicId] = talkId
					break
				end
			end
		end
	end
	return result
end

--处理紧急话题逻辑
--@param data table 本地存储数据
--@param roleId int 角色id
function CoveManager:handleUrgentTopic(data, topicTable, roleId)
	if not data.urgentTable[roleId] then
		data.urgentTable[roleId] = {}	--初始化
	end
	local isChanged = false
	for k, v in pairs(topicTable) do
		--有紧急条件 并且未阅览过 并且未被记录过 则插入紧急列表并且从普通列表剔除
		if not tablex.contains(data.urgentTable[roleId], v.id) then
			if tablex.size(v.forceCondition) > 0 and not tablex.contains(data.watchedUrgentTable, v.id) then
				local isAdd = self:checkUrgentTopicCondition(v.forceCondition)
				if isAdd then
					table.insert(data.urgentTable[roleId], v.id)
					isChanged = true
				end
			end
		end
	end
	return isChanged
end

--处理普通话题逻辑
--@param data table 本地存储数据
function CoveManager:handleNormalTopic(seed, topicTable, maxTalkNum)
	local random = Random:new(seed)
	local weightList = {}
	for k, v in pairs(topicTable) do
		--检测触发条件
		local data = Config.GetHomeTouchTopicInfo(v.id)
		local isAdd = self:checkTopicCondition(data.condition)
		weightList[data.id] = v.weight
	end
	LuaLogger.ds("CoveManager:handleNormalTopic 普通话题权重列表", tablex.dump(weightList))
	local selectedTopics = {}
	for i = 1, maxTalkNum do
		local totalWeight = 0
		for _, weight in pairs(weightList) do
			totalWeight = totalWeight + weight
		end
		if totalWeight == 0 then
			break
		end
		local randValue = random:range(0, totalWeight)
		local cumulativeWeight = 0
		for topicId, weight in pairs(weightList) do
			cumulativeWeight = cumulativeWeight + weight
			if randValue <= cumulativeWeight then
				table.insert(selectedTopics, topicId)
				weightList[topicId] = nil	--剔除已选中的话题
				break
			end
		end
	end
	return selectedTopics
end

--检查紧急主题触发条件
function CoveManager:checkUrgentTopicCondition(forceCondition)
	--todo 枚举
	return self:checkCondition(forceCondition)
end

--检查普通主题触发条件
function CoveManager:checkTopicCondition(forceCondition)
	--todo 枚举
	return self:checkCondition(forceCondition)
end

--检查紧急对话触发条件
function CoveManager:checkWordsUrgentCondition(forceCondition)
	--todo 枚举
	return self:checkCondition(forceCondition)
end

--检查普通对话触发条件
function CoveManager:checkWordsCondition(forceCondition)
	--todo 枚举
	return self:checkCondition(forceCondition)
end

--条件判断
function CoveManager:checkCondition(Condition)
	-- hometouchtopic表中sheet2枚举
	if tablex.size(Condition) == 0 then
		return true
	end
	local conditionNum = tablex.size(Condition)
	local satisfiedNum = 0
	for _, v in pairs(Condition) do
		if v[1] == 1 then
			--通关指定关卡
			local levelData = Me:getLevelDataByid(v[2])
			if levelData and levelData.completeNum > 0 then
				satisfiedNum = satisfiedNum + 1
			end
		elseif v[1] == 2 then
			--获得指定角色
			local roleList = ClientData:GetRoleList()
			for k, v in pairs(roleList) do
				if v.id == v[2] then
					satisfiedNum = satisfiedNum + 1
					break
				end
			end
		elseif v[1] == 3 then
			--获得指定时装
			local skinData = Me:getSkinData(v[2])
			if skinData then
				satisfiedNum = satisfiedNum + 1
			end
		elseif v[1] == 4 then
			--处于某个工作岗位
			local constructionMap = Me:getConstructionMapData()
			for constructId, homeBulidInfo in pairs(constructionMap) do
				if tablex.contains(homeBulidInfo.disposeHeroList, self._clickMenuData.roleId) then
					if constructId == v[2] then
						satisfiedNum = satisfiedNum + 1
					end
				end
			end
		elseif v[1] == 5 then
			--位于某种天气
			if self._weatherParameterId then
				local paramCfg = Config.GetWeatherParameterById(self._weatherParameterId)
				local type = paramCfg and paramCfg.icon
				if type == v[2] then
					satisfiedNum = satisfiedNum + 1
				end
			end
		end
	end
	return satisfiedNum == conditionNum
end


--判断是否点击在ui上
function CoveManager:isPointerOverUIObject()
	if (not EventSystem.current) then
		return false
	end
	local eventDataCurrentPosition = UnityEngine.EventSystems.PointerEventData(EventSystem.current)
	eventDataCurrentPosition.position = Input.mousePosition
	local results = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	EventSystem.current:RaycastAll(eventDataCurrentPosition, results)
	for i = 0, results.Count - 1 do
		local hit = results[i]
		local name = hit.gameObject.name
		--LuaLogger.ds("命中的ui" .. name)
	end
	return results.Count > 0

	-- if (Input.GetMouseButton(0) and EventSystem.current:IsPointerOverGameObject()) then
	-- 	--不需要穿透时，屏蔽场景操作
	-- 	-- print("UIMgr.isScenePassEvent = ", UIMgr.isScenePassEvent)
	-- 	if not UIMgr.isScenePassEvent then
	-- 		return
	-- 	end
	-- end
end

--时钟运动
function CoveManager:doTicktack()
	if self:GetTimeOpenType() ~= 1 then
		return
	end

	local miaozhen = self._coveScene.timeHands[0]
	local fenzhen = self._coveScene.timeHands[1]
	local shizhen = self._coveScene.timeHands[2]
	local time = os.date("*t", os.time())
	local hour = math.floor(self.curSceneTime / (60 * 60))
	local minute = math.floor((self.curSceneTime - hour * 60 * 60) / 60)
	local second = math.floor(self.curSceneTime - hour * 3600 - minute * 60)
	local s = time.sec
	local needSecond = (second + (s - self.secondHandSync)) % 60
	needSecond = needSecond * self:GetTimeSpeed()
	-- 计算秒针的旋转角度
    local secondAngle = needSecond * 6 -- 每秒 6 度 (360 / 60)
    miaozhen.localRotation = Quaternion.Euler(0, 0, secondAngle)

    -- 计算分针的旋转角度
    local minuteAngle = minute * 6 + (s / 60) * 6 -- 每分钟 6 度 + 秒的影响
    fenzhen.localRotation = Quaternion.Euler(0, 0, minuteAngle)

    -- 计算时针的旋转角度
    local hourAngle = (hour % 12) * 30 + (minute / 60) * 30 -- 每小时 30 度 + 分的影响
    shizhen.localRotation = Quaternion.Euler(0, 0, hourAngle)
end

--获取家园指挥室岗位生效技能
function CoveManager:getHomeSignal()
	local skillIdList = {}
	local disposeRoleList = Me:getDisposeRole(GE.CoustructionEnum.CommandRoom)
	for i = 1, 4 do
		local roleId = disposeRoleList[i]
		local curTagEffectType
		if i == 1 then
			curTagEffectType = GE.TagEffectType.battleFlagship
		elseif i == 2 then
			curTagEffectType = GE.TagEffectType.battleObserver
		elseif i == 3 then
			curTagEffectType = GE.TagEffectType.battleReporter
		elseif i == 4 then
			curTagEffectType = GE.TagEffectType.battleCommander
		end
		if roleId and roleId ~= 0 then
			local tagList = Me:getHeroTagList(roleId)
			for _, tagId in ipairs(tagList) do
				---@type SignalTable
				local tagCfg = Config.SignalInfo(tagId)
				if tagCfg.type == GE.TagType.dwelling and tagCfg.useType == curTagEffectType and tagCfg.effect and next(tagCfg.effect) then
					table.insert(skillIdList, tagCfg.effect)
				end
			end
		end
	end
	return skillIdList
end

--设置相机位置到对应的功能图标
---@param funcId integer 功能id
function CoveManager:setCameraPositionByFuncId(funcId)
	-- local needBtn = self._buildingMgr.buildingBtnList[funcId]
	local position = self._buildingMgr.buildingBtnList[funcId].staticPos
	self:LookAtPos(GE.HomeLandPerspectiveType.Whole, position)
end

--设置相机位置到对应的功能图标 带有镜头移动效果
---@param funcId integer 功能id
function CoveManager:setCameraPositionByFuncId11(funcId, callback)
	-- local needBtn = self._buildingMgr.buildingBtnList[funcId]
	local btnPos = self._buildingMgr.buildingBtnList[funcId].staticPos
	self:LookAtPos(GE.HomeLandPerspectiveType.Whole, btnPos, { time = 0.5 }, callback)
end


--设置相机位置到对应的角色位置 带有镜头移动效果
---@param heroId integer 功能id
function CoveManager:setCameraPositionByHeroId(heroId, callback)
	local roleData = self._roleMgr:getRoleDataWithId2(heroId)
	if roleData == nil then
		return
	end
	if roleData.coveRole == nil then
		return
	end
	---@type CoveRole
	local coveRole = roleData.coveRole
	local pos = coveRole:GetPosition()
	if pos == nil then
		return
	end
	self:LookAtPos(GE.HomeLandPerspectiveType.Whole, pos, { time = 0.5 }, callback)
end


--设置相机可移动状态
function CoveManager:setCameraMoveable(isMoveable)
	self.cameraAllowMove = isMoveable
end


--self.curTime = 0  //当前时间 0-24小时的秒数
local OpenType_key = GE.LocalCustomDataKey.SceneSetting_OpenType
local DayTimeType_key = GE.LocalCustomDataKey.SceneSetting_DayTimeType
local TimeScale_key = GE.LocalCustomDataKey.SceneSetting_TimeScale	
local RectifyTime_Key = GE.LocalCustomDataKey.SceneSetting_RectifyTime
local DefaultSceneType_key = GE.LocalCustomDataKey.SceneSetting_DefaultSceneType

---获取 时间流逝开启状态 1开启 2关闭
function CoveManager:GetTimeOpenType()
	if self.timeOpenType == nil then
		self.timeOpenType = MyPrefs:GetInt(OpenType_key, 1)
		if self.timeOpenType == 0 then
			self.timeOpenType = 1
		end
	end
	return self.timeOpenType
end


--- 设置 时间流逝开启状态 1开启 2关闭
function CoveManager:SetTimeOpenType(value, ignoreSetPrefs)
	self.timeOpenType = value
	if not ignoreSetPrefs then
		MyPrefs:SetInt(OpenType_key, value)
	end
	
	---TODO
end

---获取 时间状态 早晨1 傍晚2 晚上3
function CoveManager:GetDayTimeType()
	if self.dayTimeType == nil then
		self.dayTimeType = MyPrefs:GetInt(DayTimeType_key, 1)
	end
	if self.dayTimeType == 0 then
		self.dayTimeType = 1
	end
	return self.dayTimeType
end

---设置 时间状态 早晨1 傍晚2 晚上3
function CoveManager:SetDayTimeType(value, ignoreSetPrefs)
	self.dayTimeType = value
	if not ignoreSetPrefs then
		MyPrefs:SetInt(DayTimeType_key, value)
	end
	if self:GetTimeOpenType() ~= 1 then
		self:SetDayTimeParemeter(value)
	end
end

---获取当前时间缩放
function CoveManager:GetTimeSpeed()
	if self.timeSpeed == nil then
		self.timeSpeed = MyPrefs:GetInt(TimeScale_key, 1)
	end
	return self.timeSpeed
end

---获取默认显示场景类型 1指挥室 2家园
function CoveManager:GetDefaultSceneType(isLoad)
	if isLoad then
		local data = MyPrefs:GetInt(DefaultSceneType_key, 1)
		return data
	end
	if self.defaultSceneType == nil then
		self.defaultSceneType = MyPrefs:GetInt(DefaultSceneType_key, 1)
	end
	return self.defaultSceneType
end

---设置默认显示场景
function CoveManager:SetDefaultSceneType(value)
	self.defaultSceneType = value
	MyPrefs:SetInt(DefaultSceneType_key, value)
end

function CoveManager:SetTempSceneType(value)
	self.defaultSceneType = value
end

---设置当前时间缩放
function CoveManager:SetTimeSpeed(value)
	self.timeSpeed = value
	MyPrefs:SetInt(TimeScale_key, value)

	if self:GetTimeOpenType() == 1 then
		self:SetRectifyTime(self.curSceneTime)
	end
end


---获取 上次校准时间
function CoveManager:GetRectifyTime()
	if self.rectifyTime == nil then
		self.rectifyTime = MyPrefs:GetInt(RectifyTime_Key)
	end
	return self.rectifyTime
end

---设置 校准时间
function CoveManager:SetRectifyTime(value)
	self.rectifyTime = value
	MyPrefs:SetInt(RectifyTime_Key, value)
end



---初始化当前配置
function CoveManager:InitHomeWeaterCfg()
	local curTime = EngineUtil.ServerTime_Seconds()
	curTime = curTime + (Me:getTimeZone() or 8)*3600		--转换成格林威治时间  --服务器时间差了8个小时

	local t = os.date("*t", curTime)

	self.curHomeWeatherCfg = nil
	local weatherCfgs = Config.GetHomeWeatherTable()
	if weatherCfgs == nil then
		return
	end
	---@type HomeWeatherTable[]
	local cfgs = {}
	local c = t.month * 100 + t.day
	for k, v in pairs(weatherCfgs) do
		table.insert(cfgs, v)
	end
	table.sort(cfgs, function(a, b)
		return a.id < b.id
	end)

	for i = 1 , #cfgs do
		local v = cfgs[i]
		local s = v.startTime[1] * 100 + v.startTime[2]
		local e = v.endTime[1] * 100 + v.endTime[2]
		if(c >= s and c <= e) then
			self.curHomeWeatherCfg = v
			break
		end
	end
	
	if self.curHomeWeatherCfg == nil then
		self.curHomeWeatherCfg = cfgs[#cfgs]
	end

end

---设置当前场景光照参数
function CoveManager:InitSceneParameters()
	self:InitHomeWeaterCfg()
	if self.curHomeWeatherCfg == nil then
		return
	end
end


function CoveManager:SetDayTimeParemeter(dayTimeType)
	if self.curHomeWeatherCfg == nil then
		return
	end
	local type = dayTimeType
	local cfgs = {self.curHomeWeatherCfg.daylight, self.curHomeWeatherCfg.dusk, self.curHomeWeatherCfg.night}
	local cfg = cfgs[type]
	if cfg == nil then
		return
	end
	self.curSceneTime = cfg[1]
	self:SetSceneTime(cfg[1])
	--cfg = Config.GetWeatherParameterById(cfg[2])
	--self:SetWeaterParemeter(cfg)
	--self.secondHandSync = os.date("*t", os.time()).sec
	--GameMsgMgr:sendEvent(GameMsgType.UpdateSceneTime, self.curSceneTime)

end

---获取当前当天时间
function CoveManager:GetDaySecond()
	local curTime = EngineUtil.ServerTime_Seconds()
	curTime = curTime + Me:getTimeZone() * 3600		--转换成格林威治时间  --服务器时间差了8个小时

	curTime = Mathf.Floor(curTime)
	curTime = curTime + DLuaUtil.GetTimeZone() * 3600
	curTime = curTime % (24*60*60)

	return curTime
end


local lastUpdateTime = 0
local lastSecondTime = -1

---校准时间
function CoveManager:RectifySceneTime()
	if self.curHomeWeatherCfg == nil then
		return	
	end
	local curTime = self:GetDaySecond()
	self:SetSceneTime(curTime)
	return curTime
end

---当前时间 转时间类型 1早上 2傍晚 3黑夜
function CoveManager:CurTimeToType(curTime)

	if self.curHomeWeatherCfg == nil then
		return 0
	end
	local v1, v2, v3 = self.curHomeWeatherCfg.daylight, self.curHomeWeatherCfg.dusk, self.curHomeWeatherCfg.night
	if curTime >= v1[1] and curTime < v2[1] then 
		return 1
	end

	if curTime >= v2[1] and curTime < v3[1] then
		return 2
	end

	if curTime >= v3[1] or curTime < v1[1] then
		return 3
	end
	return 0
end


local dayParam = {
	"daylight", "dusk", "night",
}
---设置当前时间
function CoveManager:SetSceneTime(curTime)

	if self.curHomeWeatherCfg == nil then
		return	
	end

	local lastTime = 0
	local v1, v2, v3 = self.curHomeWeatherCfg[dayParam[1]], self.curHomeWeatherCfg[dayParam[2]], self.curHomeWeatherCfg[dayParam[3]]
	local cfg = nil
	local dayType = 0
	local startTime = 0
	if curTime >= v1[1] and curTime < v2[1] then 
		cfg = v1
		lastTime = v2[1]
		dayType = 1
		startTime = v1[1]
	end

	if curTime >= v2[1] and curTime < v3[1] then
		cfg = v2
		lastTime = v3[1]
		dayType = 2
		startTime = v2[1]
	end

	if curTime >= v3[1] or curTime < v1[1] then
		cfg = v3
		lastTime = 0   --过0点会刷新数据
		if curTime > v3[1] then
			lastTime = 0
		else
			lastTime = v1[1]
		end
		dayType = 3
		startTime = v3[1]
	end

	local parameterId = cfg[2]

	--判断有无特殊天气
	--如果有特殊天气 更新下次刷新时间
	local serverTime = EngineUtil.ServerTime_Seconds()
	serverTime = serverTime + (Me:getTimeZone() or 8) * 3600		--转换成格林威治时间  --服务器时间差了8个小时
 	---@type std.osdate
    local t = os.date("*t", serverTime)
	
	local serverCfg = Me:GetCurrentSpecialWeatherData(dayType)
	if serverCfg ~= nil and serverCfg.type ~= nil then

		if curTime < startTime + serverCfg.startTime then
			lastTime = startTime + serverCfg.startTime
		elseif curTime >= (startTime + serverCfg.startTime) and curTime < (startTime + serverCfg.startTime + serverCfg.durationTime) then
			lastTime = startTime + serverCfg.startTime + serverCfg.durationTime
			parameterId = serverCfg.type
		end
	end

	self.weatherParamId = parameterId
	local paramCfg = Config.GetWeatherParameterById(parameterId)
	self._weatherParameterId = parameterId
	self:SetWeaterParemeter(paramCfg)
	self.curSceneTime = curTime
	self.nextUpdateSceneTime = lastTime

	lastUpdateTime = Time.realtimeSinceStartup
	lastSecondTime = curTime % 60
	self.secondHandSync = os.date("*t", os.time()).sec
	GameMsgMgr:sendEvent(GameMsgType.UpdateSceneTime, self.curSceneTime)
end


---@param param WeatherParameterTable
function CoveManager:SetWeaterParemeter(param)


	if (not self._inited) and self:getScene() == nil or param == nil then
		return
	end
	if not self.homelandEeatherEnabled then
		return
	end
	local sunDir = Vector3.New(param.angle[1], param.angle[2], param.angle[3])
	local sunLightColor = param.colour
	local sunIntensity = param.illuminance
	local sunShadowStrength = param.shadowStrength
	local roleLightColor = param.roleColour
	local roleIntensity = param.roleIlluminance
	local roleShadowStrength = param.roleShadowStrength
	local volumeType = param.volume
	local showLamp = param.lampOpen
	local effectName = param.effectName
	local cloudOpen = param.cloudOpen
	local t = 0
	local moveTime = 2

	self:getScene():SetSceneParameters(sunDir, sunLightColor, sunIntensity, sunShadowStrength, roleLightColor, roleIntensity, roleShadowStrength, volumeType, showLamp, effectName, cloudOpen, t, moveTime)
end



function CoveManager:UpdateScene()
	if self:GetTimeOpenType() ~= 1 then
		return
	end
	if self.curSceneTime == nil then
		return
	end

	local time = Time.realtimeSinceStartup

	local passTime = (time - lastUpdateTime) * self:GetTimeSpeed()
	local curTime = self.curSceneTime + passTime

	local second = math.floor(curTime) % 60
	if second ~= 0 and passTime < 60 then
		lastSecondTime = second
		return
	end
	
	if lastSecondTime == 0 and passTime < 60 then
		lastSecondTime = second
		return
	end
	lastSecondTime = second

	lastUpdateTime = time

	local isa = false
	if curTime >= 24*60*60 then
		self:InitHomeWeaterCfg()
		curTime = curTime % (24 * 60 *60)
		isa = true
	end
	self.curSceneTime = math.floor(curTime)

	local h = math.floor(self.curSceneTime / (60 * 60))
	local m = math.floor((self.curSceneTime - h * 60 * 60) / 60)
	local s = self.curSceneTime % 60

	self.curSceneTime = self:Repeat(self.curSceneTime, 24 * 60 *60)
	if (self.nextUpdateSceneTime == nil) or 
	(self.nextUpdateSceneTime ~= 0 and self.curSceneTime >= self.nextUpdateSceneTime) or 
	isa 	--过凌晨
	then
		self:SetSceneTime(self.curSceneTime)
	end

	self.secondHandSync = os.date("*t", os.time()).sec
	GameMsgMgr:sendEvent(GameMsgType.UpdateSceneTime, self.curSceneTime)

end


function CoveManager:Repeat(t, len)
	return mathx.clamp(t - math.floor(t / len) * len, 0, len)
end


---开启天气变化
function CoveManager:EnableHomeLandWeather()
	self.homelandEeatherEnabled = true
	self:SetSceneTime(self.curSceneTime)
end

---禁用天气变化
function CoveManager:DisableHomeLandWeather()
	self.homelandEeatherEnabled = false
	self:getScene():SetPlayerFinish()
end

--刷新战斗摄像机角度
function CoveManager:RefreshCameraAngle(isDotween)
	local type = MyPrefs:GetInt(GE.LocalCustomDataKey.CoveCameraAngle, 1)
	local angleData = Config.GetConfigInfo("HomeCameraType")[type]
	local xAngle = angleData[1]
	local yAngle = angleData[2]
	if isDotween then
		self:refreshViewRotationXY(xAngle, yAngle, 1)
	else
		self:refreshViewRotationXY(xAngle, yAngle, 0)
	end
end

--重置相机角度
function CoveManager:ResetCameraAngle(isDotween)
	local defaultType = Config.GetConfigInfo("HomeCameraType")[1]
	local xAngle = defaultType[1]
	local yAngle = defaultType[2]
	if isDotween then
		self:refreshViewRotationXY(xAngle, yAngle, 1)
	else
		self:refreshViewRotationXY(xAngle, yAngle, 0)
	end
end

--设置家园UI开关
function CoveManager:SetHomeUICanvasOpen(isOpen)
	self.canvas:SetActive(isOpen)
	if CoveBuildingManager then
		CoveBuildingManager.instance():SetShowBtnUI(isOpen)
	end
end

---从列表中随机一条数据
---@generic V : { id:integer }
---@param cfgs table<integer, V>|V[] config 表
---@param unlockFun fun(cfg:V):boolean? 检测是否开启方法
---@param weightKey string? 权重的字段名，默认是 "weight"
---@return int?, V?
function CoveManager:getConfigsRandomId(cfgs, unlockFun, weightKey)

	local allWeight = 0
    for _, cfg in pairs(cfgs) do
        if unlockFun == nil or unlockFun(cfg) then
            allWeight = allWeight + cfg.weight
        end
    end
    if allWeight <= 0 then
        return nil
    end
    local random = self:getRanom()
    local rv = random:range(1, allWeight)
    local t = 0
    for _, cfg in pairs(cfgs) do
        if unlockFun == nil or unlockFun(cfg) then
            t = t + cfg.weight
            if t >= rv then
                return cfg.id, cfg
            end
        end
    end
    return nil
end

---天气枚举转换配置的天气枚举
---@enum DayPartConvert 时刻枚举转换 客户端以二进制位数枚举, 配置表 1,2,3,4,5,6 表示上午,下午,晚上, 上下午, 下午和晚上, 以及全天
local DayPartConvert = {
	[2^0] = 1,
	[2^1] = 2,
	[2^2] = 3,
	[2^0 + 2^1] = 4,
	[2^1 + 2^2] = 5,
	[2^0 + 2^1 + 2^2] = 6,
}

---获得天气对话
---@param wds DayWeatherData[]
---@return integer? character, int[][]? dialogs
function CoveManager:GetWeatherDialogue(wds)

	local allComTab = Config.GetAllCompoundData("WeatherReportTable")
	local allCharacters = {}
	for k, v in pairs(allComTab.compound1) do
		table.insert(allCharacters, k)
	end
	if #allCharacters == 0 then
		return
	end
	local index = self:getRanom():range(1, #allCharacters)
	local characterId = allCharacters[index]

	local dialogueCfgs = Config.GetWeatherReportTable(characterId)
	if dialogueCfgs == nil then
		return
	end
	---检索1类型
	---@type int[][]
	local dialogues = {}
	table.insert(dialogues, {})
	---@type WeatherReportTable[]
	local tempCfgs = dialogueCfgs[1]

	local randomId = self:getConfigsRandomId(tempCfgs, function(cfg)
		return true
	end)
	table.insert(dialogues[#dialogues], randomId)
	----

	---检索2类型
	tempCfgs = dialogueCfgs[2]
	---增加每天对话
	for i = 1, #wds do
		table.insert(dialogues, {})
		local randomId = self:getConfigsRandomId(tempCfgs, function(cfg)
			local unlock = self:CheckWeatherDialogueUnlock(cfg.condition, wds[1], i, 0)
			return unlock
		end)
		table.insert(dialogues[#dialogues], randomId)


		local wd = wds[i]
		local dialogs = self:GetWeatherDialogue1(dialogueCfgs, wd, i)

		local ds = dialogues[#dialogues]
		tablex.move(dialogs, 1, #dialogs, #ds + 1, ds)
	end

	----

	---增加结束语  5类型
	table.insert(dialogues, {})
	tempCfgs = dialogueCfgs[5]
    local randomId = self:getConfigsRandomId(tempCfgs, function(cfg)
		local unlock = self:CheckWeatherDialogueUnlock(cfg.condition, wds[1], 1, 0,  wds[2])
		return unlock
	end)
	table.insert(dialogues[#dialogues], randomId)


	local a = 0
	local str = ""
	for i = 1, #dialogues do
		local sss =  ""
		local dlogs = dialogues[i]
		for j = 1, #dlogs do
			local cfg = Config.GetWeatherReportInfo(dlogs[j])
			sss = sss .. cfg.text
		end
		str = str .. sss .. "\n"
	end
	LuaLogger.ds(str)
	return characterId, dialogues
end

---@param dialogueCfgs WeatherReportTable[][]
---@param wd DayWeatherData
---@return int[] dialogs 对话id
function CoveManager:GetWeatherDialogue1(dialogueCfgs, wd, p1)
	---@type int[]
	local dialogues = {}
	local count = 3  ---上午, 下午, 晚上
	local t = 0
	for i = 1, count do
		--t = t + (2^(i-1))
		t = t + (bit.lshift(1, i-1))
		local weatherType = self:GetWeatherTypeByTime(wd, i)
		local nextWeatherType = -1
		if i ~= count then
			nextWeatherType = self:GetWeatherTypeByTime(wd, i + 1)
		end
		if weatherType == nextWeatherType then
			goto continue
		end

		---@type int
		local p2 = DayPartConvert[t]
		local tempCfgs = dialogueCfgs[3]
		local id = self:getConfigsRandomId(tempCfgs, function(cfg)
			local unlock = self:CheckWeatherDialogueUnlock(cfg.condition, wd, p1, p2)
			return unlock
		end)
		table.insert(dialogues, id)

		---写入对话
		local cfgs = dialogueCfgs[4]
		local id = self:getConfigsRandomId(cfgs, function(cfg)
			local unlock = self:CheckWeatherDialogueUnlock(cfg.condition, wd, p1, p2)
			return unlock
		end)
		table.insert(dialogues, id)
		t = 0
		::continue::
	end
	return dialogues
end


---判断天气条件是否激活
---@param unlockTab table
---@param wd DayWeatherData
---@param p1 int 1今天 2明天
---@param dayPartType DayPartType 时段
---@param wd2? DayWeatherData 明天天气
---@return boolean
function CoveManager:CheckWeatherDialogueUnlock(unlockTab, wd, p1, dayPartType, wd2)

	if unlockTab == nil then
		return true
	end
	if #unlockTab == 0 then
		return true
	end

	for i = 1, #unlockTab do
		local tab = unlockTab[i]
		local funType = tab[1]
		if funType == 1 then		---{1,天气枚举,相对关系类型(1大于等于,2小于等于),次数}
			local weatherType = tab[2]
			local ys = tab[3]
			local val = tab[4]
			local curVal = self:GetWeatherTypeCount(wd, weatherType)
			if wd2 ~= nil then
				curVal = curVal + self:GetWeatherTypeCount(wd2, weatherType)
			end
			if ys == 1 then
				if curVal < val then
					return false
				end
			elseif ys == 2 then
				if curVal > val then
					return false
				end
			end
		elseif funType == 2 then ---{2,天气枚举,出现情况(1都出现,2都没出现)}
			local weatherType = tab[2]
			local ys = tab[3]
			local val = self:GetWeatherTypeCount(wd, weatherType)
			if ys == 1 then 	---1都出现
				if val == 0 then
					return false
				end
			elseif ys == 2 then  ----都没出现
				if val ~= 0 then
					return false
				end
			end
		elseif funType == 3 then  ---出现某天气
			local weatherType = tab[2]
			local curVal = self:GetWeatherTypeCount(wd, weatherType, dayPartType)
			if curVal <= 0 then
				return false
			end
		elseif funType == 4 then 		--某时间段
			local val = tab[2]
			if dayPartType ~= val then
				return false
			end
		elseif funType == 5 then  ---某天
			local val = tab[2]
			if p1 ~= val then
				return false
			end
		elseif funType == 6 then ----{6,复合条件中满足几条则通过,{条件1},{条件2}......}
			local count = tab[2]
			local conditions = {}
			tablex.move(tab, 3, #tab, 1, conditions)
			local curVal = 0
			for i = 1, #conditions do
				local isUnlock = self:CheckWeatherDialogueUnlock({conditions[i]}, wd, p1, dayPartType)
				if isUnlock then
					curVal = curVal + 1
				end
			end
			if curVal < count then
				return false
			end
		end
	end
	return true
end

---获得对于天气类型 出现的次数
---@param wds DayWeatherData
---@param weatherType int 天气类型
---@param dayPartType DayPartType? 1上午 2下午 3晚上
---@return int count 天气出现次数
function CoveManager:GetWeatherTypeCount(wds, weatherType, dayPartType)
	if wds == nil then
		return 0
	end
	local dayPartBitType = -1
	for kk, vv in pairs(DayPartConvert) do
		if vv == dayPartType then
			dayPartBitType = kk
			break
		end
	end

	local count = 0
	for k, v in ipairs(wds.dayWeatherData) do
		if dayPartBitType ~= -1 then
			local b = bit.lshift(1, (k - 1))
			local v = bit.band(b, dayPartBitType)
			if v <= 0 then
				goto continue
			end
		end
		local specialWeather = 0
		if v.type ~= nil then
			local id = v.type
			local cfg = Config.GetWeatherParameterById(id)
			if cfg ~= nil then
				specialWeather = cfg.specialWeather
			end
		end
		if specialWeather == weatherType then
			count = count + 1
		end
		::continue::
	end
	return count
end

---获得当前天气对应时间的天气类型
---@param wd DayWeatherData
---@param dayPartType int 1上午, 2下午 3晚上
---@return int weatherType 天气类型 0晴天 1雨天 2阴天 3下雪 
function CoveManager:GetWeatherTypeByTime(wd, dayPartType)
	if wd == nil then
		return 0
	end
	local dayData = wd.dayWeatherData[dayPartType]
	if dayData == nil then
		return 0
	end
	local cfg = Config.GetWeatherParameterById(dayData.type)
	if cfg == nil then
		return 0
	end
	return cfg.specialWeather
end



function CoveManager:CheckFunctionOpen()
	


	self._buildingMgr:CheckFunctionOpen()

	if self.lastIsUnlock == true then
		return
	end
	local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SceneSetting)
    local isUnlock = state ~= GE.FunctionOpenState.Lock

	if self.lastIsUnlock == isUnlock then
		return
	end
	if isUnlock and self.lastIsUnlock == nil then
		self.lastIsUnlock = isUnlock
		return
	end
	self.lastIsUnlock = isUnlock
	if not isUnlock then
		return
	end

	self:SetTimeOpenType(1)
	self:SetTimeSpeed(1)
	local curTime = self:RectifySceneTime()
end

function CoveManager:CheckSceneSettingState(isShow)
	if not isShow then
		return
	end
	if not self._inited then
		return
	end
	if self.initSceneSetting then
		return
	end
	local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SceneSetting)
    local isUnlock = state ~= GE.FunctionOpenState.Lock

	self.initSceneSetting = true
	if isUnlock then
		if self:GetTimeOpenType() ~= 1 then
			local type = self:GetDayTimeType()
			self:SetDayTimeParemeter(type)
		else
			self:RectifySceneTime()
		end
	else
		--- 设置 时间流逝开启状态
		self:SetTimeOpenType(2, true)
		self:SetDayTimeType(3, true)
		self:SetDayTimeParemeter(3)
	end
end

function CoveManager:InitInteractiveObjects()
	local sceneRoot = self:getScene()
	if sceneRoot == nil then
		return
	end
	---@cast sceneRoot CoveScene
	---@class CheckInitInteractiveObjData
	---@field gameObject UnityEngine.GameObject
	---@field x number
	---@field z number
	---@field type int

	---@type CheckInitInteractiveObjData[]
	local tab = {}
	---@type UnityEngine.Transform[]
    local interactiveObjs = sceneRoot.Interactive
    local childCount = interactiveObjs.Length
    local stuff = "Interactive_"
    for i = 0, childCount - 1 do
		local child = interactiveObjs[i]
		if not string.startswith(child.name, stuff) then
			goto continue
		end

		local type = string.sub(child.name, string.len(stuff) + 1)
		type = tonumber(type)
		local data = {
			gameObject = child.gameObject,
			x = child.position.x,
			z = child.position.z,
			type = type,
		}
		table.insert(tab, data)
		::continue::
	end
	self.interactiveObjTab = tab
	---@type {intervalTime:number[], showTime:number[], checkRadius:number}
	self.interactiveDialogueCfg = Config.GetConfigInfo("InteractiveDialogueCfg")
end



function CoveManager:CheckHeroInteractiveDialogue()
	---@type table<int, CoveBase>
	local allHeros = self._roleMgr:GetAllCoveTab()


	---@class CheckCoveRoleData
	---@field id int
	---@field pos Vector3
	---@field coveRole CoveRole

	---@type CheckCoveRoleData[]
	local tab = {}
	local minDisSqr = self.interactiveDialogueCfg.checkRadius
	minDisSqr = minDisSqr * minDisSqr

	for k, v in pairs(allHeros) do
		if v:GetType() ~= CoveType.Player then
			goto continue
		end
		if not v:CanInteractiveDialogue() then
			goto continue
		end
		local pos = v:GetPosition()
		local data = {
			id = v:GetID(),
			coveRole = v,
			x = pos.x,
			z = pos.z,
		}
		table.insert(tab, data)
		::continue::
	end

	local count = #tab
	for i = 1, count do
		local data1 = tab[i]
		local role1 = data1.coveRole
		if not role1:CanInteractiveDialogue() then
			goto continue_i
		end
		local isActive = false
		for j = i + 1, count do
			local data2 = tab[j]
			local role2 = data2.coveRole
			local dx = data1.x - data2.x
        	local dz = data1.z - data2.z
			local sqrDis = dx * dx + dz * dz
			if  sqrDis < minDisSqr and role2:CanInteractiveDialogue() then
				role1:InteractiveDialogue(1)
				role2:InteractiveDialogue(1)
				isActive = true
				break
			end
		end

		if not isActive then
			local interactiveTab = self.interactiveObjTab
			for j = 1, #interactiveTab do
				local data2 = interactiveTab[j]
				local dx = data1.x - data2.x
        		local dz = data1.z - data2.z
				local sqrDis = dx * dx + dz * dz

				local obj = data2.gameObject
				if sqrDis < minDisSqr and obj.activeSelf  then
					role1:InteractiveDialogue(data2.type)
					isActive = true
					break
				end
			end
		end
		::continue_i::
	end
end

return CoveManager