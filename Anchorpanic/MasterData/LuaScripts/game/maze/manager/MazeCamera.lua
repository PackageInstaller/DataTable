module('maze.MazeCamera', Class.impl("lib.event.EventDispatcher"))

CAMERA_UPDATE = "CAMERA_UPDATE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

function getCameraMaxHeight(self)
    if(not self.mCameraMaxHeight)then
        self.mCameraMaxHeight = self:__caculateCameraMaxHeight(0)
    end
    return self.mCameraMaxHeight
end

function getCameraMinHeight(self)
    return self.mCameraMinHeight
end

function getCameraCurHeight(self)
    return self.mCameraHeight
end

function __initData(self)
    -- 相机视野大小
    self.mCameraFiledOfView = nil
    -- 相机最大高度
    self.mCameraMaxHeight = nil
    -- 相机最小高度
    self.mCameraMinHeight = 3

    -- 迷宫配置数据
    self.mMazeConfigVo = nil
    -- 迷宫动态层的水平旋转角度：y
    self.mLayerDynamicAngle = nil
    -- 相机层级 transform
    self.mLayerCameraTrans = nil
    -- 场景显示相机 transform
    self.mSceneCameraTrans = nil
    -- 场景显示相机
    self.mSceneCamera = nil
    -- 场景相机与地板的垂直距离
    self.mDistance_90 = nil
    -- 射线相机 transform
    self.mRayCameraTrans = nil
    -- 射线相机
    self.mRayCamera = nil
    -- 射线目标 transform
    self.mRayTragetTrans = nil
    -- 相机的俯视角度：x
    self.mCameraLookDownAngle = nil
    -- 相机的高度
    self.mCameraHeight = nil

    -- 零向量
    self.mZero = math.Vector3(0, 0, 0)
    -- Lerp
    self.mVector3Lerp = gs.Vector3.Lerp
    -- 最大的缓动时间
    self.mMaxSmoothTime = 10
    -- 当前已缓动时间
    self.mCurSmoothTime = 0
    -- 当前缓动速度
    self.mCurVelocity = nil
    -- 记录当前场景相机旧坐标，用于计算拖动差值
    self.mOldSceneCameraLPos = nil
    -- 记录当前拖拽点击旧坐标，用于计算拖动差值
    self.mOldLayerCameraLPos = nil
    -- 当前场景相机坐标
    self.mCurSceneCameraLPos = nil
end

function startCameraAction(self, finishCall)
    if(self.mSceneCamera and not gs.GoUtil.IsCompNull(self.mSceneCamera) and self.mRayCamera and not gs.GoUtil.IsCompNull(self.mRayCamera))then
        if(self.mCameraFiledOfView)then
            local speed = 0.45
            local startFiledOfView = self.mCameraFiledOfView + 7
            local function _onFrameHandler()
                startFiledOfView = math.max(startFiledOfView - speed, self:getCameraFiledOfView())
                self:setCameraFiledOfView(startFiledOfView)
                if(startFiledOfView <= self:getCameraFiledOfView())then
                    LoopManager:removeFrame(self, _onFrameHandler)
                    if(finishCall)then
                        finishCall()
                    end
                end
            end
            LoopManager:addFrame(1, 0, self, _onFrameHandler)
            return
        end
        return
    end
    if(finishCall)then
        finishCall()
    end
end

function setCameraFiledOfView(self, filedOfView)
    if self.mSceneCamera or gs.GoUtil.IsCompNull(self.mSceneCamera) then 
        return 
    end

    self.mSceneCamera.fieldOfView = filedOfView
    self.mRayCamera.fieldOfView = filedOfView
end

function getCameraFiledOfView(self)
    return self.mCameraFiledOfView or 50
end

-- 设置战斗中摄像机照射中心的初始位置
function setData(self, mazeConfigVo, sceneCameraTrans, cameraLookDownAngle, cameraHeight, layerDynamicAngle)
    self.mMazeConfigVo = mazeConfigVo
    self.mLayerDynamicAngle = layerDynamicAngle
    self.mLayerCameraTrans = maze.MazeSceneThingManager:getLayer(maze.LAYER_CAMERA)
    self.mSceneCameraTrans = sceneCameraTrans
    self.mSceneCamera = self.mSceneCameraTrans:GetComponent(ty.Camera)
    self.mRayCameraTrans = self.mLayerCameraTrans:Find("CameraRayDrag").transform
    self.mRayCamera = self.mRayCameraTrans:GetComponent(ty.Camera)
    self.mRayTragetTrans = maze.MazeSceneThingManager:getLayer(maze.LAYER_RAY_DRAG)
    self.mCameraLookDownAngle = cameraLookDownAngle

    self.mCameraFiledOfView = self.mSceneCamera.fieldOfView
    self:setCameraFiledOfView(self.mCameraFiledOfView)

    self:__initLayerAngle()
    self:__initCamera()
    self:setCameraHeight(cameraHeight)
end

function __initLayerAngle(self)
    -- 动态层水平旋转角度
    gs.TransQuick:SetLRotation(maze.MazeSceneThingManager:getLayer(maze.LAYER_DYNAMIC_SCALE), 0, self.mLayerDynamicAngle, 0)
    -- 根据动态层的水平旋转角度获取动态层的最小外接矩形大小
    local mazeSizeW, mazeSizeH = self.mMazeConfigVo:getMapSize()
    self.mOutSideRectSizeX, self.mOutSideRectSizeY = self:__getOutSideRectSize(mazeSizeW, mazeSizeH, self.mLayerDynamicAngle)
end

function __initCamera(self)
    self.mCameraHeight = self:getCameraMaxHeight()
    
    gs.TransQuick:LPos(self.mSceneCameraTrans, 0, self.mCameraHeight, 0)
    gs.TransQuick:SetLRotation(self.mSceneCameraTrans, self.mCameraLookDownAngle, 0, 0)

    gs.TransQuick:LPos(self.mRayCameraTrans, 0, self.mCameraHeight, 0)
    gs.TransQuick:SetLRotation(self.mRayCameraTrans, self.mCameraLookDownAngle, 0, 0)

    self:__caculateCameraRange()
end

-- 计算场景相机保证全视野范围下（最小外接矩形大小范围）的最大高度
function __caculateCameraMaxHeight(self)
    -- 相对场景相机从上往下俯视90°时（90°时相机正对地板）的增量角度
    local deltaAngle = math.abs(90 - self.mCameraLookDownAngle)
    -- 场景相机视口四棱锥角度数
    local viewAngle = self.mSceneCamera.fieldOfView
    local halfViewAngle = viewAngle * 0.5
    -- 相机在地板上的都设点z坐标偏移值
    -- local offsetZ = math.tan(math.rad(deltaAngle - halfViewAngle)) * maxHeight
    -- 相机垂直于地板法线和最大视野点形成角度为 deltaAngle + halfViewAngle，列举以下方程式
    -- math.tan(math.rad(deltaAngle + halfViewAngle)) = (offsetZ + self.mOutSideRectSizeY) / maxHeight
    -- 换算得以下公式
    local maxHeight =  self.mOutSideRectSizeY / (math.tan(math.rad(deltaAngle + halfViewAngle)) - math.tan(math.rad(deltaAngle - halfViewAngle)))
    -- 相机以格子层底部为标准，需要返回高度+格子厚度
    return maxHeight + self.mRayTragetTrans.localPosition.y
end

-- 计算场景相机的移动范围（不超过最小外接矩形大小界限）
function __caculateCameraRange(self)
    -- 场景相机与tile层的垂直距离
    local plane = gs.Plane(self.mRayTragetTrans.up, self.mRayTragetTrans.position)
    self.mDistance_90 = plane:GetDistanceToPoint(self.mSceneCameraTrans.position)
    -- 相对场景相机从上往下俯视90°时（90°时相机正对地板）的增量角度
    local deltaAngle = math.abs(90 - self.mCameraLookDownAngle)
    -- 场景相机视口四棱锥角度数
    local viewAngle = self.mSceneCamera.fieldOfView
    local halfViewAngle = viewAngle * 0.5
    -- 场景相机视口四棱锥的等腰三角形的腰长
    local waistLen = self.mDistance_90 / math.cos(math.rad(deltaAngle - halfViewAngle))
    -- 场景相机视口四棱锥的底部四边形的半高
    local bottomHalfH = math.sin(math.rad(halfViewAngle)) * waistLen
    -- 场景相机视口四棱锥的底部四边形的半宽
    local bottomHalfW = bottomHalfH * self.mSceneCamera.aspect
    self.mCameraInnerLeftX = bottomHalfW
    self.mCameraInnerRightX = bottomHalfW
    if(self.mCameraLookDownAngle < 90)then
        -- 向前俯视
        self.mCameraInnerTopY = math.tan(math.rad(halfViewAngle + deltaAngle)) * self.mDistance_90
        self.mCameraInnerBottomY = math.tan(math.rad(halfViewAngle - deltaAngle)) * self.mDistance_90
    else
        -- 向后俯视
        self.mCameraInnerTopY = math.tan(math.rad(halfViewAngle - deltaAngle)) * self.mDistance_90
        self.mCameraInnerBottomY = math.tan(math.rad(halfViewAngle + deltaAngle)) * self.mDistance_90
    end
    -- self:__updateSceneCameraLPos(false, nil)
end

-- 获取相机指定距离视口矩形半宽半高
function __getSceneCameraCorners(self, sceneCamera, distance)
    -- 一半相机角弧度
    local halfFOV = math.rad(sceneCamera.fieldOfView * 0.5)
    local cameraViewHalfH = math.tan(halfFOV) * distance
    local cameraViewHalfW = cameraViewHalfH * sceneCamera.aspect
    return cameraViewHalfW, cameraViewHalfH
end

-- 根据矩形大小获取旋转角度后的最小外接矩形大小
function __getOutSideRectSize(self, sourceRectW, sourceRectH, angle)
    -- 这里只关注外接矩形大小，角度统一取正数
    angle = math.abs(angle)
    local outSideRectW = sourceRectW * math.cos(math.rad(angle)) + sourceRectH * math.cos(math.pi / 2 - math.rad(angle))
    local outSideRectH = sourceRectW * math.sin(math.rad(angle)) + sourceRectH * math.sin(math.pi / 2 - math.rad(angle))
    return outSideRectW, outSideRectH
end

-- 获取相机视野范围四边自定义偏移值（在地板旋转指定角度之后）
function __getCustomOffset(self)
    return 0, 0, 2.5, 0
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

function hideRay(self)
    self.mRayTragetTrans.gameObject:SetActive(false)
end

function showRay(self)
    self.mRayTragetTrans.gameObject:SetActive(true)
end

-- 设置相机本地高度
function setCameraHeight(self, cameraHeight, isTween, finishCall)
    if(cameraHeight)then
        cameraHeight = math.min(cameraHeight, self:getCameraMaxHeight())
        cameraHeight = math.max(cameraHeight, self:getCameraMinHeight())
    else
        cameraHeight = self:getCameraMaxHeight()
    end
    self.mCameraHeight = cameraHeight
    gs.TransQuick:LPosY(self.mSceneCameraTrans, self.mCameraHeight)
    gs.TransQuick:LPosY(self.mRayCameraTrans, self.mCameraHeight)
    self.mCurSceneCameraLPos = self.mSceneCameraTrans.localPosition
    self:__caculateCameraRange()
    self:__updateSceneCameraLPos(isTween, finishCall)

    if(self.mOldLayerCameraLPos)then
        self.mOldSceneCameraLPos = self.mSceneCameraTrans.localPosition
        self.mOldLayerCameraLPos = self:__getLayerCameraLPos()
    end
end

-- 根据行列设置相机本地坐标
function setRowCol(self, targetRow, targetCol, isTween, finishCall)
    local layoutType = self.mMazeConfigVo:getLayoutType()
    local tileHalfH = self.mMazeConfigVo:getTileHalfH()
    local tileSideLen = self.mMazeConfigVo:getTileSideLen()
    local mazeSizeW, mazeSizeH = self.mMazeConfigVo:getMapSize()
    local tileX, tileY = maze.getTilePosByRowCol(mazeSizeW, mazeSizeH, layoutType, targetRow, targetCol, tileSideLen, tileHalfH)
    maze.MazeCamera:setLPos(tileX, tileY, isTween, finishCall)
    return tileX, tileY
end

-- 设置相机本地坐标
function setLPos(self, lPosX, lPosY, isTween, finishCall)
    self:__resetSmoothUpdate()
    if(not self.mTempConvertPos)then
        self.mTempConvertPos = math.Vector3(0, 0, 0)
    end
    self.mTempConvertPos = self.mSceneCameraTrans.localPosition
    self.mTempConvertPos.x = lPosX
    self.mTempConvertPos.z = lPosY
    -- 将格子层局部坐标转为世界坐标
    local worldPos = maze.MazeSceneThingManager:getLayer(maze.LAYER_TILE):TransformPoint(self.mTempConvertPos)
    -- 将格子层世界坐标转为外接最小矩形本地坐标
    local rectLPos = self.mLayerCameraTrans:InverseTransformPoint(worldPos)
    -- 高度不变
    rectLPos.y = self.mTempConvertPos.y
    -- 将外接最小矩形本地坐标做相机视口偏移
    rectLPos.z = rectLPos.z - math.tan(math.rad(math.abs(90 - self.mCameraLookDownAngle))) * self.mDistance_90
    self.mCurSceneCameraLPos = rectLPos
    self:__updateSceneCameraLPos(isTween, finishCall)
    return rectLPos.x, rectLPos.z
end

function dragPointDown(self)
    self:stopMove()
    self.mOldSceneCameraLPos = self.mSceneCameraTrans.localPosition
    self.mOldLayerCameraLPos = self:__getLayerCameraLPos()
end

function dragUpdate(self)
    if(self.mOldLayerCameraLPos)then
        local deltaLPos = self.mOldLayerCameraLPos - self:__getLayerCameraLPos()
        local nowSceneCameraLPos = self.mOldSceneCameraLPos + deltaLPos
        if(self.mCurSceneCameraLPos)then
            self.mCurVelocity = nowSceneCameraLPos - self.mCurSceneCameraLPos
        end
        self.mCurSceneCameraLPos = nowSceneCameraLPos
        self:__updateSceneCameraLPos(false, nil)
    end
end

function dragPointUp(self)
    self:__addSmoothFrameSn()
    self.mOldSceneCameraLPos = nil
    self.mOldLayerCameraLPos = nil
end

function __onSmoothUpdateFrameHandler(self)
    if(not self.mCurVelocity)then
        self:__resetSmoothUpdate()
    elseif(math.abs(maze.getFormatNum(self.mCurVelocity.x)) <= 0.01 and math.abs(maze.getFormatNum(self.mCurVelocity.y)) <= 0.01 and math.abs(maze.getFormatNum(self.mCurVelocity.z)) <= 0.01)then -- 坐标是否已达到
        self:__resetSmoothUpdate()
    elseif (self.mCurSmoothTime <= self.mMaxSmoothTime)then
        self.mCurSceneCameraLPos = self.mCurSceneCameraLPos + self.mCurVelocity
        self.mCurVelocity = self.mVector3Lerp(self.mCurVelocity, self.mZero, self.mCurSmoothTime)
        -- 阻尼1
        -- self.mCurSmoothTime = self.mCurSmoothTime + gs.Time.smoothDeltaTime
        -- 阻尼2（实践起来更顺滑）
        self.mCurSmoothTime = 0.05
        self:__updateSceneCameraLPos(false, nil)
    else
        self:__resetSmoothUpdate()
    end
end

-- 重置缓冲移动
function __resetSmoothUpdate(self)
    self:__removeSmoothFrameSn()
    self.mCurSmoothTime = 0
    self.mCurVelocity = nil
end

function __updateSceneCameraLPos(self, isTween, finishCall)
    self.mLPosFinishCall = finishCall
    -- 是否已经设置过坐标
    if(self.mCurSceneCameraLPos)then
        -- -- 自定义微调扩大一点范围
        -- local xLeft, xRight, yTop, yBottom = self:__getCustomOffset()
        -- -- 限制相机四边范围，保证相机视野处在地图的外接最小矩形的内围中
        -- if((self.mCameraInnerRightX + self.mCameraInnerLeftX) <= self.mOutSideRectSizeX)then
        --     self.mCurSceneCameraLPos.x = math.min(self.mCurSceneCameraLPos.x, self.mOutSideRectSizeX / 2 - self.mCameraInnerRightX + xLeft)
        --     self.mCurSceneCameraLPos.x = math.max(self.mCurSceneCameraLPos.x, -self.mOutSideRectSizeX / 2 + self.mCameraInnerLeftX + xRight)
        -- else
        --     self.mCurSceneCameraLPos.x = 0
        -- end
        -- -- if((self.mCameraInnerTopY + self.mCameraInnerBottomY) <= self.mOutSideRectSizeY)then
        --     self.mCurSceneCameraLPos.z = math.min(self.mCurSceneCameraLPos.z, self.mOutSideRectSizeY / 2 - self.mCameraInnerTopY + yTop)
        --     self.mCurSceneCameraLPos.z = math.max(self.mCurSceneCameraLPos.z, -self.mOutSideRectSizeY / 2 + self.mCameraInnerBottomY + yBottom)
        -- -- else
        -- --     self.mCurSceneCameraLPos.z = 0 - math.tan(math.rad(math.abs(90 - self.mCameraLookDownAngle))) * self.mDistance_90
        -- -- end
        
        -- 美术要能看到玩家在中心点，此处视角范围写死为最大外接矩形的四个角在中心点
        self.mCurSceneCameraLPos.x = math.min(self.mCurSceneCameraLPos.x, self.mOutSideRectSizeX / 2)
        self.mCurSceneCameraLPos.x = math.max(self.mCurSceneCameraLPos.x, -self.mOutSideRectSizeX / 2)
        self.mCurSceneCameraLPos.z = math.min(self.mCurSceneCameraLPos.z, self.mOutSideRectSizeY / 2 - 3)
        self.mCurSceneCameraLPos.z = math.max(self.mCurSceneCameraLPos.z, -self.mOutSideRectSizeY / 2 - 3.5)

        local call = function ()
            if(self.mLPosFinishCall)then
                self.mLPosFinishCall()
                self.mLPosFinishCall = nil
            end
        end

        -- 设置场景相机坐标
        if(isTween)then
            self:stopMove()

            self.tweener = TweenFactory:move2Lpos(self.mSceneCameraTrans, self.mCurSceneCameraLPos, 0.5, gs.DT.Ease.OutQuart, call)
            self.tweener:OnUpdate(function() self:dispatchEvent(CAMERA_UPDATE) end)
            self.tweener:OnKill(call)
        else
            gs.TransQuick:LPos(self.mSceneCameraTrans, self.mCurSceneCameraLPos)
            self:dispatchEvent(CAMERA_UPDATE)
            call()
        end
    end
end

function __addSmoothFrameSn(self)
    if(self.mSmoothFrameSn == nil)then
        self.mSmoothFrameSn = LoopManager:addFrame(1, 0, self, self.__onSmoothUpdateFrameHandler)
    end
end

function __removeSmoothFrameSn(self)
    if (self.mSmoothFrameSn) then
        LoopManager:removeFrameByIndex(self.mSmoothFrameSn)
        self.mSmoothFrameSn = nil
    end
end

function __removeTweener(self)
    if(self.tweener)then
        self.tweener:Kill()
        self.tweener = nil
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
            if(transform.name == self.mRayTragetTrans.name)then
                local localPos = self.mLayerCameraTrans:InverseTransformPoint(hitInfo.point)
                return localPos
            end
        end
    end
end

-- 停止相机的移动
function stopMove(self)
    self:__removeTweener()
    self:__resetSmoothUpdate()
end

function reset(self)
    self:__removeTweener()
    self:__removeSmoothFrameSn()
    self:__initData()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
