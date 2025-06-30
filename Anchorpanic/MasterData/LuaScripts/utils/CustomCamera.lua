module("CustomCamera", Class.impl())

-- 默认设置参数
function resetData(self)
    -- X轴移动速度
    self.x_pos_scale = 1
    -- X轴移动限制
    self.x_pos_clamp = {
        min = -5,
        max = 5
    }
    -- Y轴移动速度
    self.y_pos_scale = 1
    -- Y轴移动限制
    self.y_pos_clamp = {
        min = -5,
        max = 5
    }
    -- FOV缩放速度
    self.fov_scale = 1
    -- FOV缩放限制
    self.fov_scale_clamp = {
        min = 40,
        max = 60
    }

    self.top_bottom_move_enable = true
    self.left_right_move_enable = true
    self.fov_scale_enable = true

    self.canClick = true
    self.isEnable = false
end

function enableCamera(self, isEnable)
    self.isEnable = isEnable
end

-- 是否启用X轴移动 是否启用 移动量 最小值 最大值
function setXPosEnable(self, isEnable, scale, min, max)
    self.left_right_move_enable = isEnable
    self.x_pos_scale = scale
    self.x_pos_clamp = {
        min = min,
        max = max
    }
end

-- 是否启用Y轴移动 是否启用 移动量 最小值 最大值
function setYPosEnable(self, isEnable, scale, min, max)
    self.top_bottom_move_enable = isEnable
    self.y_pos_scale = scale
    self.y_pos_clamp = {
        min = min,
        max = max
    }
end

-- 是否启用FOV缩放 是否启用 移动量 最小值 最大值
function setFOVScaleEnable(self, isEnable, scale, min, max)
    self.fov_scale_enable = isEnable
    self.fov_scale = scale
    self.fov_scale_clamp = {
        min = min,
        max = max
    }
end

-- 添加在帧循环开始和结束的事件
function setLoopEndEvent(self, loopStartEvent, loopEndEvent)
    self.loopStartEvent = loopStartEvent
    self.loopEndEvent = loopEndEvent
end

-- 设置点击的事件
function setClickEvent(self, clickEvent)
    self.clickEvent = clickEvent
end

-- 设置动画循环事件
function setTweenLoopEvent(self, tweenEvent)
    self.tweenEvent = tweenEvent
end

-- 是否按下按钮
function setEnable(self, isDown)
    self.isDown = isDown
    self:changeIsDownEvent()
end

-- 射线碰撞检测
function raycastObject(self, layerName, distance)
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), layerName, distance)
    if hitInfo and hitInfo.collider then
        return hitInfo.collider.gameObject
    else
        return nil
    end
end

-- 获取场景相机
function getSceneCamera(self)
    self.mSceneCamera = gs.CameraMgr:GetSceneCamera()
    self.mSceneCameraTrans = self.mSceneCamera.transform
    self:resetData()
    self:resetCache()
    return self.mSceneCamera
end

-- 重置缓存
function resetCache(self)
    self.mLastPos = {
        x = 0,
        y = 0
    }

    self.mCurrentPos1 = {
        x = 0,
        y = 0
    }
    self.mCurrentPos2 = {
        x = 0,
        y = 0
    }
    self.mOldPos1 = {
        x = 0,
        y = 0
    }
    self.mOldPos2 = {
        x = 0,
        y = 0
    }

    if self.canClick and self.clickEvent and self.isEnable then
        -- 移动平台添加单指判定
        if gs.Application.isMobilePlatform then
            if gs.Input.touchCount == 1 then
                self:clickEvent()
            end
        else
            self:clickEvent()
        end
    end

    self.canClick = true
end

-- 键鼠操作
function setOnScroll(self)
    if self.fov_scale_enable then
        if (gs.Input.GetAxis("Mouse ScrollWheel") < 0) then
            self:scaleFov(false)
        end

        if (gs.Input.GetAxis("Mouse ScrollWheel") > 0) then
            self:scaleFov(true)
        end
    end
end

-- 移动设备上操作
function setOnScrollByMobilePlatform(self)
    if gs.Application.isMobilePlatform then
        if gs.Input.touchCount == 2 then
            self.touch1 = gs.Input.GetTouch(0)
            self.touch2 = gs.Input.GetTouch(1)

            self.mCurrentPos1.x = gs.TransQuick:GetTouchPosition_X(self.touch1)
            self.mCurrentPos1.y = gs.TransQuick:GetTouchPosition_Y(self.touch1)

            self.mCurrentPos2.x = gs.TransQuick:GetTouchPosition_X(self.touch2)
            self.mCurrentPos2.y = gs.TransQuick:GetTouchPosition_Y(self.touch2)

            if self.mOldPos1.x ~= self.mOldPos1.y ~= 0 and self.mOldPos2.x ~= 0 and self.mOldPos2.y ~= 0 then
                local currentTouchDis = (gs.Vector3(self.mCurrentPos1.x, self.mCurrentPos1.y, 0) -
                                            gs.Vector3(self.mCurrentPos2.x, self.mCurrentPos2.y, 0)).magnitude
                local oldTouchDis = (gs.Vector3(self.mOldPos1.x, self.mOldPos1.y, 0) -
                                        gs.Vector3(self.mOldPos2.x, self.mOldPos2.y, 0)).magnitude

                if currentTouchDis ~= oldTouchDis then
                    self:scaleFov(currentTouchDis > oldTouchDis)
                end
            else
                self.mOldPos1.x = self.mCurrentPos1.x
                self.mOldPos1.y = self.mCurrentPos1.y
                self.mOldPos2.x = self.mCurrentPos2.x
                self.mOldPos2.y = self.mCurrentPos2.y
            end
        else -- 少于两个手指
            self.mOldPos1 = {
                x = 0,
                y = 0
            }
            self.mOldPos2 = {
                x = 0,
                y = 0
            }
        end
    end
end

-- 缩放FOV 是否增加
function scaleFov(self, isAdd)
    self.canClick = false
    local needFov = isAdd and self.mSceneCamera.fieldOfView + self.fov_scale or self.mSceneCamera.fieldOfView -
                        self.fov_scale
    if needFov >= self.fov_scale_clamp.min and needFov <= self.fov_scale_clamp.max then
        self.mSceneCamera.fieldOfView = needFov
    end
end

function changeIsDownEvent(self)
    if self.isDown and self.isEnable then
        self.loopSn = LoopManager:addFrame(0, 0, self, self.onLoopEvent)
    else
        LoopManager:removeFrameByIndex(self.loopSn)
        self:resetCache()
    end

end

-- 按下后的帧循环
function onLoopEvent(self)

    -- if self.isTweenY == true or self.isTweenX == true then
    --     if self.tweenEvent then
    --         self:tweenEvent()
    --     end
    -- end

    if self.isEnable == false then
        return
    end

    if self.loopStartEvent then
        self:loopStartEvent()
    end

    -----------------------------------------------------------------
    -- -- 上下平移
    -- if self.top_bottom_move_enable and self.mLastPos.y ~= 0 and gs.UnityEngineUtil.GetMousePosY() ~= self.mLastPos.y then
    --     self:moveToPosY()
    -- end

    -- -- 左右平移
    -- if self.left_right_move_enable and self.mLastPos.x ~= 0 and gs.UnityEngineUtil.GetMousePosX() ~= self.mLastPos.x then
    --     self:moveToPosX()
    -- end

    if (self.top_bottom_move_enable and self.mLastPos.y ~= 0 and gs.UnityEngineUtil.GetMousePosY() ~= self.mLastPos.y) or
        (self.left_right_move_enable and self.mLastPos.x ~= 0 and gs.UnityEngineUtil.GetMousePosX() ~= self.mLastPos.x) then
        self:moveToPos()
    end

    -- fov操作
    if self.fov_scale_enable then
        self:setOnScrollByMobilePlatform()
    end
    -----------------------------------------------------------------
    self.mLastPos.x = gs.UnityEngineUtil.GetMousePosX()
    self.mLastPos.y = gs.UnityEngineUtil.GetMousePosY()

    if self.loopEndEvent then
        self:loopEndEvent()
    end
end

-------------------------------------------位置移动----------------------------------------------------

function moveToPos(self)
    self.canClick = false
    local needX = self.mSceneCameraTrans.localPosition.x + (self.mLastPos.x - gs.UnityEngineUtil.GetMousePosX()) *
                      self.x_pos_scale
    local needY = self.mSceneCameraTrans.localPosition.y + (self.mLastPos.y - gs.UnityEngineUtil.GetMousePosY()) *
                      self.y_pos_scale
    local clampX = gs.Mathf.Clamp(needX, self.x_pos_clamp.min, self.x_pos_clamp.max)
    local clampY = gs.Mathf.Clamp(needY, self.y_pos_clamp.min, self.y_pos_clamp.max)
    local v3 = gs.Vector3(clampX, clampY, self.mSceneCamera.transform.localPosition.z)
    local tween = TweenFactory:move2Lpos(self.mSceneCamera.transform, v3, 0.1, gs.DT.Ease.OutSine)

    tween.onUpdate = function()
        if self.tweenEvent then
            self:tweenEvent()
        end
    end
end

-- function moveToPosY(self)
--     self.canClick = false
--     local needY = self.mSceneCameraTrans.localPosition.y + (self.mLastPos.y - gs.UnityEngineUtil.GetMousePosY()) *
--                       self.y_pos_scale
--     local clampY = gs.Mathf.Clamp(needY, self.y_pos_clamp.min, self.y_pos_clamp.max)
--     -- local needPos = 
--     -- gs.TransQuick:LPos(self.mSceneCamera.transform, self.mSceneCamera.transform.localPosition.x, clampY,
--     --     self.mSceneCamera.transform.localPosition.z)

--     local v3 = gs.Vector3(self.mSceneCamera.transform.localPosition.x, clampY,
--         self.mSceneCamera.transform.localPosition.z)
--         self.isTweenY = true
--     TweenFactory:move2Lpos(self.mSceneCamera.transform, v3, 0.1,gs.DT.Ease.OutSine,function ()
--         self.isTweenY = false
--     end)
-- end

-- function moveToPosX(self)
--     self.canClick = false
--     local needX = self.mSceneCameraTrans.localPosition.x + (self.mLastPos.x - gs.UnityEngineUtil.GetMousePosX()) *
--                       self.x_pos_scale
--     local clampX = gs.Mathf.Clamp(needX, self.x_pos_clamp.min, self.x_pos_clamp.max)
--     -- gs.TransQuick:LPos(self.mSceneCamera.transform, clampX, self.mSceneCamera.transform.localPosition.y,
--     --     self.mSceneCamera.transform.localPosition.z)

--     local v3 = gs.Vector3(clampX, self.mSceneCamera.transform.localPosition.y,
--         self.mSceneCamera.transform.localPosition.z)
--         self.isTweenX = true
--     TweenFactory:move2Lpos(self.mSceneCamera.transform, v3, 0.1,gs.DT.Ease.OutSine,function ()
--         self.isTweenX = false
--     end)
-- end

return _M
