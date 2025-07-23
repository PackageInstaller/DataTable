module('game.covenant.utils.CovemamtMainCamera', Class.impl())

function initCamera(self)
    self.mSceneCamera = gs.CameraMgr:GetSceneCamera()

    self.mRotatePos = self.mSceneCamera.transform.parent.parent.gameObject.transform
    self.isDown = false
    self.lastPos = {}
    self.lastPos.x = 0
    self.lastPos.y = 0

    self.xSpeed = 0.01
    self.zSpeed = 0.01
    self.isMoving = false

    self.touch1 = nil
    self.touch2 = nil

    -- 限制Y轴的旋转
    self.mClampRotateY = 20
    -- 限制Z轴的移动
    self.mClampPositionZ = 2
    -- 取X值的比例
    self.mYScale = 0.1
    -- 移动Z值的比例
    self.mZScale = 0.2

    self.canClick = true

    self.currentPos1 = {
        x = 0,
        y = 0,
        z = 0
    }
    self.currentPos2 = {
        x = 0,
        y = 0,
        z = 0
    }
    self.oldPos1 = {
        x = 0,
        y = 0,
        z = 0
    }
    self.oldPos2 = {
        x = 0,
        y = 0,
        z = 0
    }

    local w, h = ScreenUtil:getScreenSize(nil)
    if (w / h > 2.07) then
        self.mSceneCamera.fieldOfView = 42
    else
        self.mSceneCamera.fieldOfView = 60
    end
end

function getCamera(self)
    return self.mSceneCamera
end

function setIsMoving(self, isMoving)
    self.isMoving = isMoving
    self.isDown = false
    self.lastPos.x = 0
    self.lastPos.y = 0
    -- self.canClick = true
end

function setMouseDown(self)
    if self.isDown == false then
        self.loopSn = LoopManager:addFrame(0, 0, self, self.onLoopEvent)
        self.isDown = true
    end
end

function setMouseUp(self)
    self.isDown = false

    if self.canClick then
        local function useRay()
            self.isCanRay = covenant.CovenantMainSceneController:canUseRay()
            if self.isCanRay then
                covenant.CovenantMainSceneController:clickEvent()
            end
        end

        if gs.Application.isMobilePlatform then
            if gs.Input.touchCount == 1 then
                useRay()
            end
        else
            useRay()
        end
    end

    if gs.Application.isMobilePlatform then
        if gs.Input.touchCount == 1 then
            self.canClick = true
            self.lastPos.x = 0
            self.lastPos.y = 0
        
            if self.loopSn then
                LoopManager:removeFrameByIndex(self.loopSn)
                self.loopSn = nil
            end
        end    
    else
        self.canClick = true
        self.lastPos.x = 0
        self.lastPos.y = 0
    
        if self.loopSn then
            LoopManager:removeFrameByIndex(self.loopSn)
            self.loopSn = nil
        end  
    end
end

function setOnScroll(self)

    if self.isMoving then
        return
    end

    if (gs.Input.GetAxis("Mouse ScrollWheel") < 0) then
        self.mSceneCamera.fieldOfView = self.mSceneCamera.fieldOfView - 1
    end

    if (gs.Input.GetAxis("Mouse ScrollWheel") > 0) then
        self.mSceneCamera.fieldOfView = self.mSceneCamera.fieldOfView + 1
    end

    self:clampFOV()

    covenant.CovenantMainSceneController:updateUI()
end

function destoryCamera(self)
    self.mSceneCamera = nil
end

function setRunUpdate(self, isRun)
    self.isRunUpdate = isRun
end

function onLoopEvent(self)

    if self.isDown == false or self.isMoving then
        return
    end

    if gs.Application.isMobilePlatform then
        if gs.Input.touchCount == 2 then
            self.touch1 = gs.Input.GetTouch(0)
            self.touch2 = gs.Input.GetTouch(1)

            self.currentPos1.x = gs.TransQuick:GetTouchPosition_X(self.touch1)
            self.currentPos1.y = gs.TransQuick:GetTouchPosition_Y(self.touch1)
            self.currentPos1.z = 0

            self.currentPos2.x = gs.TransQuick:GetTouchPosition_X(self.touch2)
            self.currentPos2.y = gs.TransQuick:GetTouchPosition_Y(self.touch2)
            self.currentPos2.z = 0

            if self.oldPos1.x ~= 0 and self.oldPos1.y ~= 0 and self.oldPos2.x ~= 0 and self.oldPos2.y ~= 0 then

                local currentTouchDis = (gs.Vector3(self.currentPos1.x, self.currentPos1.y, self.currentPos1.z) -
                                            gs.Vector3(self.currentPos2.x, self.currentPos2.y, self.currentPos2.z)).magnitude
                local oldTouchDis = (gs.Vector3(self.oldPos1.x, self.oldPos1.y, self.oldPos1.z) -
                                        gs.Vector3(self.oldPos2.x, self.oldPos2.y, self.oldPos2.z)).magnitude
                if currentTouchDis > oldTouchDis then
                    self.mSceneCamera.fieldOfView = self.mSceneCamera.fieldOfView - 1
                end

                if currentTouchDis < oldTouchDis then
                    self.mSceneCamera.fieldOfView = self.mSceneCamera.fieldOfView + 1
                end
                self.canClick = false
            end

            self.oldPos1.x = self.currentPos1.x
            self.oldPos1.y = self.currentPos1.y
            self.oldPos1.z = self.currentPos1.z

            self.oldPos2.x = self.currentPos2.x
            self.oldPos2.y = self.currentPos2.y
            self.oldPos2.z = self.currentPos2.z
        else
            self.oldPos1 = {
                x = 0,
                y = 0,
                z = 0
            }
            self.oldPos2 = {
                x = 0,
                y = 0,
                z = 0
            }
        end
    end

    self:clampFOV()

    if (self.lastPos.x ~= 0 and self.lastPos.y ~= 0) then
        if math.abs(self.lastPos.x - gs.UnityEngineUtil.GetMousePosX()) ~= 0 then
            self.canClick = false
        end
        gs.TransQuick:Rotate(self.mRotatePos, 0, (self.lastPos.x - gs.UnityEngineUtil.GetMousePosX()) * -self.mYScale, 0)
        self:clampRotate()
    end

    covenant.CovenantMainSceneController:updateUI()

    self.lastPos.x = gs.UnityEngineUtil.GetMousePosX()
    self.lastPos.y = gs.UnityEngineUtil.GetMousePosY()

end

function clampFOV(self)
    self.mSceneCamera.fieldOfView = gs.Mathf.Clamp(self.mSceneCamera.fieldOfView, 40, 60)
end

function clampPos(self)
    local clampX = self.mSceneCamera.transform.position.x
    local clampY = self.mSceneCamera.transform.position.y
    local clampZ = gs.Mathf.Clamp(self.mSceneCamera.transform.position.z, -self.mClampPositionZ, self.mClampPositionZ)
    gs.TransQuick:Pos(self.mSceneCamera.transform, clampX, clampY, clampZ)
end

function clampRotate(self)
    local rotateX = self.mRotatePos.rotation.eulerAngles.x
    local rotateY
    if self.mRotatePos.rotation.eulerAngles.y < 180 then
        rotateY = math.min(self.mRotatePos.rotation.eulerAngles.y, self.mClampRotateY)
    else
        rotateY = gs.Mathf.Clamp(self.mRotatePos.rotation.eulerAngles.y, 360 - self.mClampRotateY, 360)
    end

    local rotateZ = self.mRotatePos.rotation.eulerAngles.z

    gs.TransQuick:SetRotation(self.mRotatePos, rotateX, rotateY, rotateZ)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
