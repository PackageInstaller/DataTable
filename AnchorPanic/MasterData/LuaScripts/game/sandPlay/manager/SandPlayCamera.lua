-- @FileName:   SandPlayCamera.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-29 17:33:37
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.utils.SandPlayCamera', Class.impl())

--可以调参数

distance = 13 --当前镜头距离中心的距离（初始距离）
maxDistance = 20--最大距离
minDistance = 2--最小距离

lateDistance = distance

scaleFactor = 2 --缩放速度

angle_x = 36 --相机默认角度
angle_y = 0

oldPosition1 = {x = 0, y = 0, z = 0} --双指缩放  上一次手指1的位置
oldPosition2 = {x = 0, y = 0, z = 0} --双指缩放  上一次手指2的位置

-- cameraTweenFieldOfView = 60 --相机开始进来的视角大小

function ctor(self)

end

function initCamera(self, minDistance, maxDistance, distance, angle_x, angle_y)
    self.distance = distance
    self.minDistance = minDistance
    self.maxDistance = maxDistance
    self.angle_y = angle_y
    self.angle_x = angle_x

    self.sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()

    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
    if not playThing then
        return
    end
    self.mLiveTran = playThing:getTrans()

    self:addEventListener()

    self:lookLive({isForthwith = true})
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.lookLive, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.lookLive, self)
end

-- --一开始进来的镜头拉近
-- function onStartTween(self)
--     gs.TransQuick:Pos(self.sceneCameraTrans, self.sceneCameraTrans.forward * -self.distance)

--     ---镜头拉近
--     local sceneCamera = self.sceneCameraTrans:GetComponent(ty.Camera)
--     local initField = sceneCamera.fieldOfView
--     sceneCamera.fieldOfView = self.cameraTweenFieldOfView
--     local tweener_FarClip = sceneCamera:DOFieldOfView(initField, 1)
--     tweener_FarClip:SetEase(gs.DT.Ease.OutQuint)

--     local sequence = gs.DT.DOTween.Sequence()
--     -- sequence:OnUpdate(function()
--     --     self:updateCameraPos()
--     -- end)
--     sequence:Append(tweener_FarClip)
--     sequence:Play()
-- end

--看向战员，同时锁定相机为跟随战员
function lookLive(self, args)
    if gs.Application.isMobilePlatform then
        if gs.Input.touchCount == 2 and (gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved or gs.Input.GetTouch(1).phase == gs.TouchPhase.Moved) then
            self:onMobilePlatformCameraScale()
        end
    else
        self.distance = self.distance - gs.Input.GetAxis("Mouse ScrollWheel") * self.scaleFactor * gs.Time.deltaTime * 100
        self.distance = gs.Mathf.Clamp(self.distance, self.minDistance, self.maxDistance)
    end

    if self.sceneCameraTrans and not gs.GoUtil.IsTransNull(self.sceneCameraTrans) then
        self.sceneCameraTrans.eulerAngles = gs.Vector3(self.angle_x, self.angle_y, 0)
        self.centerPos = self.mLiveTran.position + gs.Vector3(0, 0.8, 0)
        if args and args.isForthwith then
            gs.TransQuick:SetCenterRadiusPos(self.sceneCameraTrans, self.angle_y, self.angle_x, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)
        else
            gs.TransQuick:LerpCenterRadiusPos(self.sceneCameraTrans, self.angle_y, self.angle_x, 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)
        end
    end

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_CAMERA_REFRESHPOS)
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

function DoTweenAngle(self, val, angle_x, angle_y, time, finishCall)
    if self.distance == val then return end

    time = time or 1

    self.lateDistance = self.distance
    self.distance = val

    local tweener_angle = self.sceneCameraTrans:DORotate(gs.Vector3(angle_x, angle_y, 0), time)
    tweener_angle:SetEase(gs.DT.Ease.OutQuint)
    tweener_angle.onUpdate = function()
        if not self.sceneCameraTrans then return end

        self.centerPos = self.mLiveTran.position + gs.Vector3(0, 0.8, 0)
        gs.TransQuick:SetCenterRadiusPos(self.sceneCameraTrans, gs.TransQuick:GetRotationY(self.sceneCameraTrans), gs.TransQuick:GetRotationX(self.sceneCameraTrans), 0, self.distance, self.centerPos.x, self.centerPos.y, self.centerPos.z)

        GameDispatcher:dispatchEvent(EventName.SANDPLAY_CAMERA_REFRESHPOS)
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

function DoCusTweenAngle(self, posX, posY, posZ, rotX, rotY, rotZ, time, finishCall)
    self:lookLive({isForthwith = false})
    time = time or 1

    local tweener_angle = self.sceneCameraTrans:DORotate(gs.Vector3(rotX, rotY, rotZ), 2)
    tweener_angle:SetEase(gs.DT.Ease.OutQuint)

    local move_tween = self.sceneCameraTrans:DOMove(gs.Vector3(posX, posY, posZ), time)
    tweener_angle:SetEase(gs.DT.Ease.OutQuint)

    tweener_angle.onUpdate = function()
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_CAMERA_REFRESHPOS)
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

function restoreTween(self)
    self:DoTweenAngle(self.lateDistance, self.angle_x, self.angle_y)
end

function destroy(self)
    self:removeEventListener()
end

return _M
