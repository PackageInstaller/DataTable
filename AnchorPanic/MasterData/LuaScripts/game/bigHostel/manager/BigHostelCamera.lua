-- @FileName:   BigHostelCamera.lua
-- @Description:   宿舍自由相机
-- @Author: ZDH
-- @Date:   2023-11-29 17:33:37
-- @Copyright:   (LY) 2023 雷焰网络

module('game.bigHostel.utils.BigHostelCamera', Class.impl())

--可以调参数
cameraSpeedAtte = 0.08--速度衰减值
speedAddFloat = 20 --开始滑动的阻尼递增值

scaleFactor = 2 --缩放速度

minCameraSpeed = 10 --最大速度
maxCameraSpeed = 130 --最小速度

function ctor(self)
    self.sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
    self.sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()

    self.isCanOperate = false
    -- self.m_rayHitDic = {}
end

function initData(self)
    self.cameraSpeed = {x = 0, y = 0}
    self.dir = {x = 0, y = 0}

    self.clickPos = {x = 0, y = 0} --按下屏幕最开的位置
    self.currentPos = {x = 0, y = 0} --当前拖动屏幕的位置

    self.oldPosition1 = {x = 0, y = 0, z = 0} --双指缩放  上一次手指1的位置
    self.oldPosition2 = {x = 0, y = 0, z = 0} --双指缩放  上一次手指2的位置
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDOWN, self.onMouseDown, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEUP, self.onMouseUp, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG, self.onDrag, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG_END, self.onEndDrag, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDOWN, self.onMouseDown, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEUP, self.onMouseUp, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG, self.onDrag, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG_END, self.onEndDrag, self)
end

function setOperateParam(self, center_trans, param, init_distance, angle, distance)
    if center_trans == nil then
        return
    end

    self.isCanOperate = true

    self.center_trans = center_trans

    self.minDistance = param.minDistance
    self.maxDistance = param.maxDistance

    self.minimumX = param.minimumX
    self.maximumX = param.maximumX
    self.minimumY = param.minimumY
    self.maximumY = param.maximumY

    if distance then
        self.distance = distance
    else
        if init_distance == true then
            self.distance = gs.Vector3.Distance(self.sceneCameraTrans.position, self.center_trans.position)
        end
    end

    self.mInitCamera_moveX = gs.TransQuick:GetRotationY(self.sceneCameraTrans)
    self.mInitCamera_moveY = gs.TransQuick:GetRotationX(self.sceneCameraTrans)
    self.mInitCamera_moveZ = gs.TransQuick:GetRotationZ(self.sceneCameraTrans)

    if angle then
        self:moveToAngle(angle)
        self:initData()

        self.mCamera_moveX = angle.y
        self.mCamera_moveY = angle.x
    else
        self:resetCamera()
    end

    self:addEventListener()
end

function close(self)
    self.mInitCamera_moveX = nil
    self.mInitCamera_moveY = nil
    self.mInitCamera_moveZ = nil

    self.oldPosition1 = nil
    self.oldPosition2 = nil

    self:removeEventListener()

    self.isCanOperate = false
end

--按下屏幕
function onMouseDown(self, EventData)
    self.clickPos.x = EventData.position.x
    self.clickPos.y = EventData.position.y

    self.dragMove = false
end

--屏幕松开
function onMouseUp(self)
    self.dragMove = false
end

--滑动
function onDrag(self, EventData)
    self.currentPos.x = EventData.position.x
    self.currentPos.y = EventData.position.y

    self.dragMove = true
end

--结束滑动
function onEndDrag(self)
    self.dragMove = false
end

--移动端镜头更新滑动
function onMobilePlatformCameraSlowMove(self)
    if gs.Input.touchCount == 1 then
        self:updateCamera()

    elseif gs.Input.touchCount == 2 and (gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved or gs.Input.GetTouch(1).phase == gs.TouchPhase.Moved) then
        self:onMobilePlatformCameraScale()
        -- elseif math.abs(self.cameraSpeed.x) > 0 or math.abs(self.cameraSpeed.y) > 0 then
        --     self:updateCamera()
    end
end

--移动端镜头缩放
function onMobilePlatformCameraScale(self)
    self.touch_1 = gs.Input.GetTouch(0)
    self.touch_2 = gs.Input.GetTouch(1)
    if table.empty(self.oldPosition1) or table.empty(self.oldPosition2) then
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
end

--镜头操作帧更新
function onCameraSlowMove(self)
    if not self.isCanOperate then
        return
    end

    if gs.Application.isMobilePlatform then
        self:onMobilePlatformCameraSlowMove()
    else
        if self.minDistance and self.maxDistance then
            self.distance = self.distance - gs.Input.GetAxis("Mouse ScrollWheel") * self.scaleFactor * gs.Time.deltaTime * 100
            self.distance = gs.Mathf.Clamp(self.distance, self.minDistance, self.maxDistance)
        end

        -- logAll(self.distance, "当前镜头的远近距离：")

        self:updateCamera()
    end

    gs.TransQuick:MoveTowardsrotation(self.sceneCameraTrans, self.mCamera_moveY, self.mCamera_moveX, self.mInitCamera_moveZ, 0.1)
    gs.TransQuick:LerpCenterRadiusPos(self.sceneCameraTrans, self.mCamera_moveX, self.mCamera_moveY, self.mInitCamera_moveZ, self.distance, self.center_trans.position.x, self.center_trans.position.y, self.center_trans.position.z)

    if self.dragMove then
        return self.sceneCameraTrans.position
    end
end

--更新镜头旋转 速度阻尼为0时 返回true
function updateCamera(self)
    if self.minimumX == nil or self.maximumX == nil or self.minimumY == nil or self.maximumY == nil then
        return
    end

    if self.dragMove then
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
        if abs >= 1 then
            self.cameraSpeed.x = gs.Mathf.Lerp(self.cameraSpeed.x, self.cameraSpeed.x + (abs * gs.Time.deltaTime * self.speedAddFloat * self.dir.x), 1)
            self.cameraSpeed.x = self:getCameraSpeed(self.dir.x, self.cameraSpeed.x)
        end

        abs = math.abs(self.currentPos.y - self.clickPos.y)
        if abs >= 1 then
            self.cameraSpeed.y = gs.Mathf.Lerp(self.cameraSpeed.y, self.cameraSpeed.y + (abs * gs.Time.deltaTime * self.speedAddFloat * self.dir.y), 1)
            self.cameraSpeed.y = self:getCameraSpeed(self.dir.y, self.cameraSpeed.y)
        end

        self.clickPos.x = self.currentPos.x
        self.clickPos.y = self.currentPos.y

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

        -- logAll(self.mCamera_moveX, "当前镜头的X角度：")
        -- logAll(self.mCamera_moveY, "当前镜头的Y角度：")
    else
        if bigHostel.BigHostelManager:getDisableFreeCameraReset() == false then
            self:resetCamera()
        end
    end

    -- self:rayHitCollider()
end

--转向某个角度
function moveToAngleTween(self, centerPos, angle, distance, finishCall)
    local tweener_angle = self.sceneCameraTrans:DORotate(gs.Vector3(angle.x, angle.y, angle.z), 1)
    tweener_angle:SetEase(gs.DT.Ease.OutQuint)
    tweener_angle.onUpdate = function()
        gs.TransQuick:SetCenterRadiusPos(self.sceneCameraTrans, gs.TransQuick:GetRotationY(self.sceneCameraTrans), gs.TransQuick:GetRotationX(self.sceneCameraTrans), 0, distance, centerPos.x, centerPos.y, centerPos.z)
    end

    tweener_angle.onComplete = function ()
        if finishCall then
            finishCall()
        end
    end

    if self.mSequence then
        self.mSequence:Kill()
        self.mSequence = nil
    end

    self.mSequence = gs.DT.DOTween.Sequence()

    self.mSequence:Append(tweener_angle)
    self.mSequence:Play()
end

---立即转向
function moveToAngle(self, angle)
    self.sceneCameraTrans.rotation = gs.Quaternion.Euler(gs.Vector3(angle.x, angle.y, 0))
    gs.TransQuick:SetCenterRadiusPos(self.sceneCameraTrans, angle.y, angle.x, 0, self.distance, self.center_trans.position.x, self.center_trans.position.y, self.center_trans.position.z)
end

-- function rayHitCollider(self)
--     --一圈点加中心点
--     local screenPointList =
--     {
--         gs.Vector3(gs.Screen.width * (1 / 4), gs.Screen.height * (1 / 4), 0),
--         gs.Vector3(gs.Screen.width * (1 / 2), gs.Screen.height * (1 / 2), 0),
--         gs.Vector3(gs.Screen.width * (2 / 4), gs.Screen.height * (2 / 4), 0),
--         gs.Vector3(gs.Screen.width * (1 / 2), gs.Screen.height * (2 / 4), 0),
--         gs.Vector3(gs.Screen.width * (2 / 4), gs.Screen.height * (2 / 4), 0),
--         gs.Vector3(gs.Screen.width * (2 / 4), gs.Screen.height * (1 / 2), 0),
--         gs.Vector3(gs.Screen.width * (2 / 4), gs.Screen.height * (1 / 4), 0),
--         gs.Vector3(gs.Screen.width * (1 / 2), gs.Screen.height * (1 / 4), 0),
--         gs.Vector3(gs.Screen.width * (1 / 2), gs.Screen.height * (1 / 2), 0), --中心
--     }

--     local hit_dic = {}
--     for i = 1, #screenPointList do
--         local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(self.sceneCamera, screenPointList[i], "Building", 500)
--         if hitInfo and hitInfo.collider then
--             hit_dic[hitInfo.collider.gameObject.name] = hitInfo.collider
--         end
--     end

--     if self.m_rayHitDic then
--         -- for collider_name, collider in pairs(self.m_rayHitDic) do
--         --     if hit_dic[collider_name] == nil then
--         --         collider.gameObject:SetActive(true)
--         --     end
--         -- end

--         self.m_rayHitDic = {}

--         for collider_name, collider in pairs(hit_dic) do
--             collider.gameObject:SetActive(false)
--             self.m_rayHitDic[collider_name] = collider
--         end

--     end
-- end

--默认镜头
function resetCamera(self)
    self.mCamera_moveX = self.mInitCamera_moveX
    self.mCamera_moveY = self.mInitCamera_moveY

    self:initData()
end

--获取最大最小速度
function getCameraSpeed(self, dir, curSpeed)
    if dir == 1 then
        return gs.Mathf.Clamp(curSpeed, self.minCameraSpeed, self.maxCameraSpeed)
    elseif dir == -1 then
        return gs.Mathf.Clamp(curSpeed, self.maxCameraSpeed * -1, self.minCameraSpeed * -1)
    end
end

function destroy(self)
    self.sceneCameraTrans = nil
    self.sceneCamera = nil
    -- self.m_rayHitDic = nil

    self.cameraSpeed = nil
    self.dir = nil
    self.distance = nil

    self.mCamera_moveX = nil
    self.mCamera_moveY = nil
    self.posDiff_x = nil
    self.posDiff_y = nil

    self.clickPos = nil
    self.currentPos = nil

    self.oldPosition1 = nil
    self.oldPosition2 = nil

    self.mInitCamera_moveX = nil
    self.mInitCamera_moveY = nil

    self.dragMove = nil

    self.isCanOperate = nil

    self:removeEventListener()
end

return _M
