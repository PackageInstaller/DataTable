--[[ 
-----------------------------------------------------
@filename       : MainExploreCamera
@Description    : 主线探索相机
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreCamera', Class.impl("lib.event.EventDispatcher"))

CAMERA_UPDATE = "CAMERA_UPDATE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

function addEventTrigger(self, eventTrigger)
    local function _onBeginDragHandler()
        local eventData = eventTrigger.EventData
        self.mDeltaPosX = eventData.delta.x
        self.mDeltaPosY = eventData.delta.y
    end
    eventTrigger.onBeginDrag:AddListener(_onBeginDragHandler)
    local function _onDragHandler()
        local eventData = eventTrigger.EventData
        self.mDeltaPosX = eventData.delta.x
        self.mDeltaPosY = eventData.delta.y
        self:cameraRotationUpdate(0, self.mDeltaPosX * self.mCameraRate, self.mDeltaPosY * self.mCameraRate)
    end
    eventTrigger.onDrag:AddListener(_onDragHandler)
    local function _onEndDragHandler()
        self.mDeltaPosX = nil
        self.mDeltaPosY = nil
    end
    eventTrigger.onEndDrag:AddListener(_onEndDragHandler)
end

function removeEventTrigger(self, eventTrigger)
    eventTrigger.onBeginDrag:RemoveAllListeners()
    eventTrigger.onDrag:RemoveAllListeners()
    eventTrigger.onEndDrag:RemoveAllListeners()
end

function __initData(self)
    -- 场景显示相机 transform
    self.mSceneCameraTrans = nil
    -- 场景显示相机
    self.mSceneCamera = nil

    -- 相机的旋转速率
    self.mCameraRate = 0.1
    -- 每次旋转相机记录的旋转角度x
    self.mSceneCameraRotateX = nil
    -- 每次旋转相机记录的旋转角度y
    self.mSceneCameraRotateY = nil

    self.mFollowThing = nil
    self.mPositionDampingValue = 0
    self.mRotationDampingValue = 0
    self.mEnableDrag = nil
    self.mIsDraging = nil

    self.mIsUpdate = nil

    self:setPositionDamping(gs.Application.targetFrameRate == 30 and 10 or 0)
end

-- 设置摄像机
function setData(self, sceneCameraTrans, sceneCamera)
    self.mSceneCameraTrans = sceneCameraTrans
    self.mSceneCamera = sceneCamera
    mainExplore.MainExploreCamera:addFrameSn()
end

function setFollow(self, followThing)
    self.mFollowThing = followThing
    self:cameraDistanceUpdate(nil)
    self:cameraRotationUpdate(nil)
    self:cameraPositionUpdate(nil)
end

function setPositionDamping(self, dampingValue)
    self.mPositionDampingValue = dampingValue or 1
end

function setRotationDamping(self, dampingValue)
    self.mRotationDampingValue = dampingValue or 1
end

-- 设置相机是否更新
function setIsUpdate(self, isUpdate)
    self.mIsUpdate = isUpdate
end

-- 设置能否拖动
function setEnableDrag(self, enable)
    self.mEnableDrag = enable
end

function addFrameSn(self)
    if(self.mFrameSn == nil)then
        self.mFrameSn = LoopManager:addFrame(1, 0, self, self.updateFrameSn)
    end
end

function removeFrameSn(self)
    if (self.mFrameSn) then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
end

function updateFrameSn(self, deltaTime)
    if(self.mIsUpdate == nil or self.mIsUpdate == true)then
        if(self.mFollowThing)then
            self:cameraUpdate(deltaTime or 0)
        end
    end
end

-- 相机更新
function cameraUpdate(self, deltaTime)
    local isRotationUpdate = false
    local isDistanceUpdate = false
    local isPositionUpdate = false
    local isMobilePlatform = gs.Application.isMobilePlatform
    if(self.mEnableDrag)then
        if(isMobilePlatform)then
            if(gs.Input.touchCount == 1 and gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved) then
                isPositionUpdate = true
                isRotationUpdate = true
            end
        else
            if(gs.Input.GetMouseButton(0) or gs.Input.GetMouseButton(1) or gs.Input.GetMouseButton(2))then
                isPositionUpdate = true
                isRotationUpdate = true
            end
        end
    else
        if(self.mFollowThing and self.mFollowThing:getBehaviorState() ~= mainExplore.BehaviorState.IDLE)then
            isPositionUpdate = true
        end
    end
    
    local wheelValue = gs.Input.GetAxis("Mouse ScrollWheel")
    if(not isMobilePlatform and wheelValue ~= 0)then
        isDistanceUpdate = true
        isPositionUpdate = true
    end

    -- if(isRotationUpdate)then
    --     if(isMobilePlatform)then
    --         local deltaPosition = gs.Input.GetTouch(0).deltaPosition
    --         self:cameraRotationUpdate(deltaTime, deltaPosition.x, deltaPosition.y)
    --     else
    --         self:cameraRotationUpdate(deltaTime, gs.Input.GetAxis("Mouse X"), gs.Input.GetAxis("Mouse Y"))
    --     end
    -- end
    if(isDistanceUpdate)then
        self:cameraDistanceUpdate(deltaTime, wheelValue)
    end
    -- if(isPositionUpdate)then
        self:cameraPositionUpdate(deltaTime)
    -- end
end

function cameraRotationUpdate(self, deltaTime, deltaX, deltaY)
    if(self.mFollowThing)then
        local sceneCameraTrans = self:getSceneCameraTrans()
        -- 初始化旋转角度
        if(not self.mSceneCameraRotateX)then
            -- self.mSceneCameraRotateX = sceneCameraTrans.eulerAngles.x
            self.mSceneCameraRotateX = 180
        end
        if(not self.mSceneCameraRotateY)then
            -- self.mSceneCameraRotateY = sceneCameraTrans.eulerAngles.y
            self.mSceneCameraRotateY = 0
        end
        local speedX = 1
        local speedY = 1
        local minLimitY = 1
        local maxLimitY = 45
        -- 获取鼠标输入
        self.mSceneCameraRotateX = self.mSceneCameraRotateX + (deltaX or 0) * speedX * 1
        self.mSceneCameraRotateY = self.mSceneCameraRotateY - (deltaY or 0) * speedY * 1
        -- 范围限制
        self.mSceneCameraRotateY = self:clampAngle(self.mSceneCameraRotateY, minLimitY, maxLimitY)
        -- 计算旋转通过Quaternion.Euler()将一个Vector3类型的值转化为一个四元数，进而通过修改Transform.Rotation来实现相同的目的
        local targetRotation = gs.Quaternion.Euler(self.mSceneCameraRotateY, self.mSceneCameraRotateX, 0)
        if (gs.Quaternion.Angle(sceneCameraTrans.rotation, targetRotation) > 1) then
            self.mIsDraging = true
            -- 根据是否插值采取不同的角度计算方式
            if (deltaTime and deltaTime > 0 and self.mRotationDampingValue > 0) then
                sceneCameraTrans.rotation = gs.Quaternion.Lerp(sceneCameraTrans.rotation, targetRotation, deltaTime * self.mRotationDampingValue)
            else
                sceneCameraTrans.rotation = targetRotation
            end
        else
            self.mIsDraging = false
        end
    end
end

function cameraDistanceUpdate(self, deltaTime, wheelValue)
    if(self.mFollowThing)then
        -- 鼠标滚轮缩放
        local zoomSpeed = 1
        local minDistance = 5
        local maxDistance = 10
        if(not self.mDistance)then
            self.mDistance = 7
        end
        self.mDistance = self.mDistance - (wheelValue or 0) * zoomSpeed
        self.mDistance = math.max(minDistance, self.mDistance)
        self.mDistance = math.min(maxDistance, self.mDistance)
    end
end

function cameraPositionUpdate(self, deltaTime)
    if(self.mFollowThing)then
        local sceneCameraTrans = self:getSceneCameraTrans()
        local followPos = self.mFollowThing:getThingVo():getPosition()
        local position = sceneCameraTrans.rotation * gs.Vector3(0, 2, -self.mDistance) + gs.Vector3(followPos.x, followPos.y, followPos.z)
        -- 设置相机的位置
        if (deltaTime and deltaTime > 0 and self.mPositionDampingValue > 0 and not self.mIsDraging) then
            sceneCameraTrans.position = gs.Vector3.Lerp(sceneCameraTrans.position, position, deltaTime * self.mPositionDampingValue)
        else
            sceneCameraTrans.position = position
        end
    end
end

-- 角度限制
function clampAngle(self, angle, min, max)
    if (angle < -360) then 
        angle = angle + 360
    end
    if (angle > 360) then
        angle = angle - 360
    end
    angle = math.max(min, angle)
    angle = math.min(max, angle)
    return angle
end

function getSceneCamera(self)
    return self.mSceneCamera
end

function getSceneCameraTrans(self)
    return self.mSceneCameraTrans
end

function addPhysicsRaycaster(self)
    if (self.mSceneCameraTrans and not gs.GoUtil.IsTransNull(self.mSceneCameraTrans)) then
        gs.GoUtil.AddComponent(self.mSceneCameraTrans.gameObject, ty.PhysicsRaycaster)
    end
end

function removePhysicsRaycaster(self)
    if (self.mSceneCameraTrans and not gs.GoUtil.IsTransNull(self.mSceneCameraTrans)) then
        gs.GoUtil.RemoveComponent(self.mSceneCameraTrans.gameObject, ty.PhysicsRaycaster)
    end
end

function __getLayerCameraLPos(self, screenRayPos)
    local hitInfo = nil
    if(screenRayPos)then
        hitInfo = gs.UnityEngineUtil.RaycastByUICamera(self.mRayCamera, screenRayPos, "", 100)
    else
        hitInfo = gs.UnityEngineUtil.RaycastByUICamera(self.mRayCamera, "", 100)
    end
    if(hitInfo) then
        local transform = hitInfo.transform
        if(transform)then
            if(transform.name ~= "")then
                local localPos = self.mLayerCameraTrans:InverseTransformPoint(hitInfo.point)
                return localPos
            end
        end
    end
end

function reset(self)
    self:removeFrameSn()
    self:__initData()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
