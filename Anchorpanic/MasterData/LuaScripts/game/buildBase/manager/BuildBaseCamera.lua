--[[
-----------------------------------------------------
@filename       : BuildBaseCamera
@Description    : 建筑基础摄像机
@date           : 2023-5-10 15：32
@Author         : Zhudonghai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.buildBase.BuildBaseCamera', Class.impl())

--可以调参数
cameraSpeedAtte = 0.08--速度衰减值
speedAddFloat = 20 --开始滑动的阻尼递增值

distance = 20 --当前镜头距离中心的距离（初始距离）
maxDistance = 20--最大距离
minDistance = 10--最小距离

minimumY = 5--纵向最小角度
maximumY = 59--纵向最大角度

minimumX = -45--横向向最小角度
maximumX = 45--横向最大角度

scaleFactor = 2 --缩放速度

minCameraSpeed = 10 --最大速度
maxCameraSpeed = 130 --最小速度

cameraTweenFieldOfView = 60 --相机开始进来的视角大小

centerPos = {x = 0, y = 0, z = 0} --中心位置（相机聚焦）

function ctor(self)

end

function initCamera(self)
    self.sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
    self.cameraSpeed = {x = 0, y = 0}
    self.dir = {x = 0, y = 0}

    self.mCamera_moveX = gs.TransQuick:GetRotationY(self.sceneCameraTrans)
    self.mCamera_moveY = gs.TransQuick:GetRotationX(self.sceneCameraTrans)

    self.posDiff_x = 1
    self.posDiff_y = 1

    self.clickPos = {x = 0, y = 0} --按下屏幕最开的位置
    self.currentPos = {x = 0, y = 0} --当前拖动屏幕的位置

    self.oldPosition1 = {x = 0, y = 0, z = 0} --双指缩放  上一次手指1的位置
    self.oldPosition2 = {x = 0, y = 0, z = 0} --双指缩放  上一次手指2的位置

    self.isCanDrag = true

    self:addEventListener()
end

function addEventListener(self)

end

function removeEventListener(self)

end

--一开始进来的镜头拉近
function onStartTween(self)
    gs.TransQuick:Pos(self.sceneCameraTrans, self.sceneCameraTrans.forward * -self.distance)

    ---镜头拉近
    local sceneCamera = self.sceneCameraTrans:GetComponent(ty.Camera)
    local initField = sceneCamera.fieldOfView
    sceneCamera.fieldOfView = self.cameraTweenFieldOfView
    local tweener_FarClip = sceneCamera:DOFieldOfView(initField, 1)
    tweener_FarClip:SetEase(gs.DT.Ease.OutQuint)

    local sequence = gs.DT.DOTween.Sequence()
    sequence:OnUpdate(function()

    end)
    sequence:Append(tweener_FarClip)
    sequence:Play()
end

--按下屏幕
function onMouseDown(self, EventData)
    self:updataDragPos(EventData)

    self.dragMove = false
    self.mouseDown = true
end

--屏幕松开
function onMouseUp(self)
    self.mouseDown = false
    self.dragMove = false
end

--滑动
function onDrag(self, EventData)
    self:updataDragPos(EventData)

    self.dragMove = true
    self.mouseDown = false
end

--结束滑动
function onEndDrag(self)
    self.mouseDown = false
    self.dragMove = false
end

--更新手指 鼠标在屏幕上的位置
function updataDragPos(self, EventData)
    if not self.curDrag_pos then
        self.curDrag_pos = {x = EventData.position.x, y = EventData.position.y}
    else
        self.curDrag_pos.x = EventData.position.x
        self.curDrag_pos.y = EventData.position.y
    end
end

--移动端镜头更新滑动
function onMobilePlatformCameraSlowMove(self)
    local isStop = false
    if gs.Input.touchCount == 1 then
        isStop = self:updateCamera()

        self.m_IsSingleFinger = true
    elseif gs.Input.touchCount == 2 and (gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved or gs.Input.GetTouch(1).phase == gs.TouchPhase.Moved) then
        self:onMobilePlatformCameraScale()

        self:stopRotate()
    elseif math.abs(self.cameraSpeed.x) > 0 or math.abs(self.cameraSpeed.y) > 0 then
        isStop = self:updateCamera()
    end
    return isStop
end

--移动端镜头缩放
function onMobilePlatformCameraScale(self)
    self.touch_1 = gs.Input.GetTouch(0)
    self.touch_2 = gs.Input.GetTouch(1)
    if self.m_IsSingleFinger then
        self.oldPosition1.x = gs.TransQuick:GetTouchPosition_X(self.touch_1)
        self.oldPosition1.y = gs.TransQuick:GetTouchPosition_Y(self.touch_1)
        self.oldPosition1.z = 0

        self.oldPosition2.x = gs.TransQuick:GetTouchPosition_X(self.touch_2)
        self.oldPosition2.y = gs.TransQuick:GetTouchPosition_Y(self.touch_2)
        self.oldPosition2.z = 0
    end

    local tempPosition1 = {}
    tempPosition1.x = gs.TransQuick:GetTouchPosition_X(self.touch_1)
    tempPosition1.y = gs.TransQuick:GetTouchPosition_Y(self.touch_1)
    tempPosition1.z = 0

    local tempPosition2 = {}
    tempPosition2.x = gs.TransQuick:GetTouchPosition_X(self.touch_2)
    tempPosition2.y = gs.TransQuick:GetTouchPosition_Y(self.touch_2)
    tempPosition2.z = 0

    local currentTouchDistance = (gs.Vector3(tempPosition1.x, tempPosition1.y, tempPosition1.z) - gs.Vector3(tempPosition2.x, tempPosition2.y, tempPosition2.z)).magnitude
    local lastTouchDistance = (gs.Vector3(self.oldPosition1.x, self.oldPosition1.y, self.oldPosition1.z) - gs.Vector3(self.oldPosition2.x, self.oldPosition2.y, self.oldPosition2.z)).magnitude

    self.distance = self.distance - (currentTouchDistance - lastTouchDistance) * self.scaleFactor * gs.Time.deltaTime

    self.distance = gs.Mathf.Clamp(self.distance, self.minDistance, self.maxDistance)

    --备份上一次触摸点的位置，用于对比
    self.oldPosition1 = tempPosition1
    self.oldPosition2 = tempPosition2
    self.m_IsSingleFinger = false
end

--镜头操作帧更新
function onCameraSlowMove(self)
    gs.TransQuick:LerpCenterRadiusPos(self.sceneCameraTrans, self.mCamera_moveX, self.mCamera_moveY, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)

    local isStop = false
    if gs.Application.isMobilePlatform then
        isStop = self:onMobilePlatformCameraSlowMove()
    else
        -- if gs.UnityEngineUtil.GetMouseButton(1) == 1 and gs.UnityEngineUtil.GetMouseButton(0) == 0 then
        self.distance = self.distance - gs.Input.GetAxis("Mouse ScrollWheel") * self.scaleFactor * gs.Time.deltaTime * 100
        self.distance = gs.Mathf.Clamp(self.distance, self.minDistance, self.maxDistance)
        -- self:stopRotate()
        -- end
        isStop = self:updateCamera()
    end

    if gs.Application.isMobilePlatform then
        return isStop
    else
        return false
    end
end

--更新镜头旋转 速度阻尼为0时 返回true
function updateCamera(self)
    if self.mouseDown then
        self.clickPos.x = self.curDrag_pos.x
        self.clickPos.y = self.curDrag_pos.y

        if self.sequence ~= nil then
            self.sequence:Kill()
            self.sequence = nil
        end
    end
    if self.dragMove and self.isCanDrag then
        self.currentPos.x = self.curDrag_pos.x
        self.currentPos.y = self.curDrag_pos.y

        -------------方向
        if self.clickPos.x > self.currentPos.x then
            self.dir.x = 1
        elseif self.clickPos.x < self.currentPos.x then
            self.dir.x = -1
        end
        if self.clickPos.y > self.currentPos.y then
            self.dir.y = 1
        elseif self.clickPos.y < self.currentPos.y then
            self.dir.y = -1
        end

        --------------速度
        local abs = math.abs(self.currentPos.x - self.clickPos.x)
        if abs >= self.posDiff_x then
            self.cameraSpeed.x = gs.Mathf.Lerp(self.cameraSpeed.x, self.cameraSpeed.x + (abs * gs.Time.deltaTime * self.speedAddFloat * self.dir.x), 1)
            self.cameraSpeed.x = self:getCameraSpeed(self.dir.x, self.cameraSpeed.x)
        end

        abs = math.abs(self.currentPos.y - self.clickPos.y)
        if abs >= self.posDiff_y then
            self.cameraSpeed.y = gs.Mathf.Lerp(self.cameraSpeed.y, self.cameraSpeed.y + (abs * gs.Time.deltaTime * self.speedAddFloat * self.dir.y), 1)
            self.cameraSpeed.y = self:getCameraSpeed(self.dir.y, self.cameraSpeed.y)
        end
    else
        if math.abs(self.cameraSpeed.x) <= 0.05 and math.abs(self.cameraSpeed.y) <= 0.05 and not self.mouseDown then
            return true
        end
    end

    self.cameraSpeed.x = gs.Mathf.Lerp(self.cameraSpeed.x, 0, self.cameraSpeedAtte)
    self.mCamera_moveX = self.mCamera_moveX - self.cameraSpeed.x * gs.Time.deltaTime * 3

    if self.minimumX ~= 0 or self.maximumX ~= 0 then
        self.mCamera_moveX = gs.Mathf.Clamp(self.mCamera_moveX, self.minimumX, self.maximumX)
    end

    self.cameraSpeed.y = gs.Mathf.Lerp(self.cameraSpeed.y, 0, self.cameraSpeedAtte)
    self.mCamera_moveY = self.mCamera_moveY + self.cameraSpeed.y * gs.Time.deltaTime * 1.5
    if self.minimumY ~= 0 or self.maximumY ~= 0 then
        self.mCamera_moveY = gs.Mathf.Clamp(self.mCamera_moveY, self.minimumY, self.maximumY)
    end

    if math.abs(self.cameraSpeed.x) > 0 or math.abs(self.cameraSpeed.y) > 0 then
        gs.TransQuick:MoveTowardsrotation(self.sceneCameraTrans, self.mCamera_moveY, self.mCamera_moveX, 0, 0.1)
    end

    self.clickPos.x = self.curDrag_pos.x
    self.clickPos.y = self.curDrag_pos.y

    return false
end

--获取最大最小速度
function getCameraSpeed(self, dir, curSpeed)
    if dir == 1 then
        return gs.Mathf.Clamp(curSpeed, self.minCameraSpeed, self.maxCameraSpeed)
    elseif dir == -1 then
        return gs.Mathf.Clamp(curSpeed, self.maxCameraSpeed * -1, self.minCameraSpeed * -1)
    end
end

--停下相机移动
function stopRotate(self)
    ---速度归0 停下镜头旋转
    self.cameraSpeed = {x = 0, y = 0}
    --缓存当前的角度
    self.mCamera_moveX = gs.TransQuick:GetRotationY(self.sceneCameraTrans)
    self.mCamera_moveY = gs.TransQuick:GetRotationX(self.sceneCameraTrans)
end

--开始移动家具
function setCameraDragState(self, val)
    self.isCanDrag = val
end

function destroy(self)
    if self.sequence ~= nil then
        self.sequence:Kill()
        self.sequence = nil
    end

    self.sceneCameraTrans = nil
    self.cameraSpeed = nil
    self.dir = nil

    self.mCamera_moveX = nil
    self.mCamera_moveY = nil
    self.posDiff_x = nil
    self.posDiff_y = nil

    self.clickPos = nil
    self.currentPos = nil

    self:removeEventListener()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
