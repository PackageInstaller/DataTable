module('game.storyTalk.view.StoryTalk2DLiveView', Class.impl())

function initData(self, go, modelID, modelLocation, nodeTrans, charactorType, isVideoCall, facePosX, facePosY,
                  modelOffset, isBright, modelShowEffect)
    self.mParentRoot = go
    self.mParentRootTrans = self.mParentRoot.transform
    self.mModelID = modelID
    self.mCharactorType = charactorType
    self.mFacePosX = facePosX
    self.mFacePosY = facePosY
    self.modelOffset = modelOffset
    self.mTweenTime = 0.5
    self.modelShowEffect = modelShowEffect
    self.mStory2DViewShakeObj = go:GetComponent(ty.ShakeObject)


    -- self.mGrayColor = gs.ColorUtil.GetColor("313131FF")
    -- self.mLightColor = gs.ColorUtil.GetColor("D7D2D2FF")

    self:initDataUI(modelID, modelLocation, nodeTrans, facePosX, facePosY, modelOffset, isBright, isVideoCall)

    self:shakeAni()
end

-- 根据屏幕宽高和贴图的宽高调整贴图的位置，保证贴图底部贴近屏幕底部
function adjustViewPosY(self, liveView)
    local offsetY = 0
    if liveView then
        local sw, sh = ScreenUtil:getScreenSize()
        self.mParentRootRectTrans = liveView.transform.parent:GetComponent(ty.RectTransform)
        local liveViewHalfHeight = liveView.Height / 2
        offsetY = liveViewHalfHeight - sh / 2 - self.mParentRootRectTrans.localPosition.y
    end
    return offsetY
end

function initDataUI(self, modelID, modelLocation, nodeTrans, facePosX, facePosY, modelOffset, isBright, isVideoCall)
    self.mRoot = AssetLoader.GetGO(UrlManager:getUIPrefabPath('storyTalk/Story2DLiveViewUI.prefab'))
    self.mRootTrans = self.mRoot.transform
    self.mRootTrans:SetParent(nodeTrans)
    self:resetTransform(self.mRootTrans, modelLocation)
    self.mModelTexImg = self.mRoot:GetComponent(ty.AutoRefImage)
    self.mModelTexImg.material = gs.Material(self.mModelTexImg.material)
    self.mModelTexImg:SetImg(UrlManager:getStoryCharactorUrl(modelID), false)
    -- 设置底图宽高
    self.mModelTexImgRectTrans = self.mRoot:GetComponent(ty.RectTransform)
    self.mModelTexImgRectTrans.sizeDelta = gs.Vector2(self.mModelTexImg.Width, self.mModelTexImg.Height)
    local rectOffset = gs.Vector3(0, self:adjustViewPosY(self.mModelTexImg), 0)
    self.mModelTexImgRectTrans.localPosition = self.mModelTexImgRectTrans.localPosition + rectOffset
    -- 设置锚点

    self.mFaceGo = self.mRootTrans:Find("Face").gameObject
    self.mFaceGoTrans = self.mFaceGo.transform
    self.mFaceGoTrans.localPosition = gs.Vector3(facePosX, facePosY, -1)
    self.mFaceTexImg = self.mFaceGo:GetComponent(ty.AutoRefImage)
    self.mFaceTexImg.material = gs.Material(self.mFaceTexImg.material)
    self.mFaceTexImg:SetImg(UrlManager:getStoryCharactorFaceUrl(modelID, "1"), false)
    self.mFaceTexImgRectTrans = self.mFaceGo:GetComponent(ty.RectTransform)
    self.mFaceTexImgRectTrans.sizeDelta = gs.Vector2(self.mFaceTexImg.Width, self.mFaceTexImg.Height)

    if isBright then
        self:setBrightActive(isBright == 1)
    end
    self:setVideoCall(isVideoCall == 1)

    self:moveTransform(self.mRootTrans, modelOffset)
end

function initDataScene(self, modelID, nodeTrans, facePosX, facePosY, modelOffset)
    self.mCamGo = nodeTrans:Find("RTCam").gameObject
    self.mCamGo:SetActive(true)

    self.mRoot = AssetLoader.GetGO(UrlManager:getUIPrefabPath('storyTalk/Story2DLiveViewScene.prefab'))
    self.mRootTrans = self.mRoot.transform

    -- 获取模型贴图的 SpriteRenderer 组件
    self.mModelTexImg = self.mRoot:GetComponent(ty.SpriteRenderer)
    -- 根据相机设置根节点的 position 和 rotation
    self.mModelTexImg.sprite, self.mModelTexImgWidth, self.mModelTexImgHeight = self:getImgInfo(UrlManager
        :getStoryCharactorUrl(self.mModelID))
    local faceTexSprite, faceTexWidth, faceTexHeight
    faceTexSprite, faceTexWidth, faceTexHeight = self:getImgInfo(UrlManager:getStoryCharactorFaceUrl(modelID, "1"))
    self:setSceneRootTransform(self.mModelTexImg.sprite, self.mModelTexImgWidth, self.mModelTexImgHeight,
        self.mCamGo.transform, facePosX, facePosY, faceTexWidth)
    local rectOffset = gs.Vector3(0, self:adjustViewPosY(self.mModelTexImg), 0)
    self.mModelTexImgRectTrans.localPosition = self.mModelTexImgRectTrans.localPosition + rectOffset

    -- 设置表情相关内容
    self.mFaceGo = self.mRootTrans:Find("Face").gameObject
    self.mFaceGoTrans = self.mFaceGo.transform
    self.mFaceGoTrans.position = gs.Vector3(self.mRootTrans.position.x + facePosX * 0.01,
        self.mRootTrans.position.y + facePosY * 0.01, self.mRootTrans.position.z)
    self.mFaceTexImg = self.mFaceGo:GetComponent(ty.SpriteRenderer)
    self.mFaceTexImg.sprite = faceTexSprite
end

function getChildTrans(self, goTrans, transName)
    return goTrans[transName]
end

function getChildGo(self, go, name)
    if not name then
        error('name is nil', 2)
    end
    if go then
        return go[name]
    end
    return nil
end

function getImgInfo(self, path)
    local sr = AssetLoader.GetAsset(path)
    if sr == nil then
        logError("贴图" .. path .. "不存在")
    end
    return sr, sr.rect.width, sr.rect.height
end

function setPosition(self, lpos)
    self.mRootTrans:SetParent(lpos)
end

function resetTransform(self, goTrans, modelLocation)
    local offsetX = gs.Vector3(3, 0, 0)
    goTrans.localPosition = gs.Vector3(0, 0, 0)
    goTrans.localScale = gs.Vector3.one

    if modelLocation == 1 then
        goTrans.position = goTrans.position - offsetX
    elseif modelLocation == 3 then
        goTrans.position = goTrans.position + offsetX
    end
end

function moveTransform(self, goTrans, modelOffset)
    local offset = gs.Vector3(modelOffset[1], modelOffset[2], modelOffset[3])
    goTrans.localPosition = goTrans.localPosition + offset
end

function setPositionTween(self, lpos, tweenTime, finishCall)
    if not lpos or self.mRootTrans == lpos then return end

    if self.posTweener then
        self.posTweener:Kill()
        self.posTweener = nil
    end
    if self.mRootTrans and lpos then
        self.posTweener = TweenFactory:move2pos(self.mRootTrans, lpos, tweenTime, nil, finishCall)
    end
end

function setPositionTweenTwoPoint(self, oldPos, newPos)
    if not oldPos or not newPos or self.mIsVideoCall then return end

    if self.mRootTrans ~= newPos then
        self.mRootTrans.position = oldPos
        self:setPositionTween(newPos, self.mTweenTime)
    end
end

-- 设置角色的亮暗
function setBrightActive(self, isBright)
    if type(isBright) ~= "boolean" then
        isBright = (isBright == 1)
    end

    if isBright then
        -- self.mModelTexImg.material:SetColor("_AmbientColor", self.mLightColor)
        self.mModelTexImg.material:DisableKeyword("ENABLE_GRAY")
        self.mFaceTexImg.material:DisableKeyword("ENABLE_GRAY")
    else
        -- self.mModelTexImg.material:SetColor("_AmbientColor", self.mGrayColor)
        self.mModelTexImg.material:EnableKeyword("ENABLE_GRAY")
        self.mFaceTexImg.material:EnableKeyword("ENABLE_GRAY")
    end
end

function setVideoCall(self, isVideoCall)
    if isVideoCall == self.mIsVideoCall or isVideoCall == nil then
        return
    end

    if isVideoCall then
        self.mModelTexImg.material:EnableKeyword("ENABLE_VIDEO_CALL")
        self.mFaceTexImg.material:EnableKeyword("ENABLE_VIDEO_CALL")
    else
        self.mModelTexImg.material:DisableKeyword("ENABLE_VIDEO_CALL")
        self.mFaceTexImg.material:DisableKeyword("ENABLE_VIDEO_CALL")
    end
    self.mIsVideoCall = isVideoCall
end

-- 设置角色的展示效果
-- 震动
function shakeAni(self)
    if self.modelShowEffect then
        local shakeTime = self.modelShowEffect[storyTalk.ModelShowEffect.shakeTime]
        local shakeSpeed = self.modelShowEffect[storyTalk.ModelShowEffect.shakeSpeed]
        local lrDistance = self.modelShowEffect[storyTalk.ModelShowEffect.shakeLeftRightDistance]
        local tdDistance = self.modelShowEffect[storyTalk.ModelShowEffect.shakeTopDownDistance]
        if shakeTime == nil or shakeTime == 0 then return end

        -- 自动结束
        if shakeTime > 0 and self.mStory2DViewShakeObj then
            self.mStory2DViewShakeObj:SetShakeVal01(lrDistance, 0, 0)
            self.mStory2DViewShakeObj:StartUp()
            local function stop()
                self:stopShake()
            end
            self.shakeSn = LoopManager:setTimeout(shakeTime / 1000, nil, stop)
        end
    end
end

-- 停止震动
function stopShake(self)
    self.mStory2DViewShakeObj:Stop()
end

-- 更新角色信息
function updateModel(self, newEnterTrans, modelData)
    if not newEnterTrans or not newEnterTrans.position then return end

    local isBright = modelData.isBright
    local isVideoCall = nil
    if modelData.data then
        -- local modelLocation = modelData.data[1]
        -- local modelID = modelData.data[2]
        -- local charactorType = modelData.data[3]
        isVideoCall = (modelData.data[4] == 1)
        -- local facePosX = modelData.data[5]
        -- local facePosY = modelData.data[6]
    end
    self:setVideoCall(isVideoCall)


    -- 更新位置
    local adjustPosY = self:adjustViewPosY(self.mModelTexImg)
    local rectOffset = newEnterTrans:InverseTransformPoint(newEnterTrans.position) +
        gs.Vector3(self.modelOffset[1], self.modelOffset[2] + adjustPosY, self.modelOffset[3])
    local pos = newEnterTrans:TransformPoint(rectOffset)
    self:setBrightActive(isBright)
    self:setPositionTween(pos, self.mTweenTime, function()
        self:shakeAni()
    end)

    if self.mRootTrans ~= nil then
        self.mRootTrans:SetParent(newEnterTrans)
    end
end

function destroy(self)
    self:clearModel()
    if self.shakeSn then
        LoopManager:clearTimeout(self.shakeSn)
    end

    if self.mRoot then
        self:destroyObject(self.mRoot)
        self.mRootTrans = nil
        if self.mCamGo then
            self.mCamGo:SetActive(false)
            self.mCamGo = nil
        end
        -- self:destroyObject(self.mModelTexImg.material)
        -- self:destroyObject(self.mFaceTexImg.material)
    end
end

function destroyObject(self, obj)
    if obj then
        gs.Object.Destroy(obj)
        obj = nil
    end
end

function clearModel()

end

function faceChange(self, animationClipID)
    -- if self.mIsVideoCall then
    --     self.mFaceTexImg.sprite = AssetLoader.GetAsset(UrlManager:getStoryCharactorFaceUrl(self.mModelID, animationClipID))
    -- else
    self.mFaceTexImg:SetImg(UrlManager:getStoryCharactorFaceUrl(self.mModelID, animationClipID), false)
    -- end
end

-- 定义一个函数，用来获取摄像机的视野范围，返回近裁剪面和远裁剪面处的高度和宽度
function getCameraViewSize(self, camera)
    -- 获取摄像机的视角
    local fov = camera.fieldOfView
    -- 获取摄像机的近裁剪面
    local near = camera.nearClipPlane
    -- 获取摄像机的远裁剪面
    local far = camera.farClipPlane
    -- 获取摄像机的宽高比
    local aspect = camera.aspect
    -- 计算摄像机在近裁剪面和远裁剪面处的高度和宽度
    -- local heightNear = 2 * gs.Mathf.Tan(fov * 0.5 * gs.Mathf.Deg2Rad) * near
    -- local widthNear = heightNear * aspect
    -- local heightFar = 2 * gs.Mathf.Tan(fov * 0.5 * gs.Mathf.Deg2Rad) * far
    -- local widthFar = heightFar * aspect

    -- 返回结果
    return fov, aspect, near, far
end

function getScenePosZ(self, fov, imgHalfHeight)
    return imgHalfHeight / gs.Mathf.Tan(fov * 0.5 * gs.Mathf.Deg2Rad)
end

-- 定义一个函数，用来设置根节点的 position 和 rotation
function setSceneRootTransform(self, modelSprite, modelWidth, modelHeight, camTrans, facePosX, facePosY, faceTexWidth)
    -- 获取根节点的 transform 组件
    local rootTrans = self.mRoot.transform
    local camera = self.mCamGo:GetComponent(ty.Camera)
    local fov, aspect, near, far = self:getCameraViewSize(camera)

    -- 计算根节点的 position
    local pixelsPerUnit = 0.01
    local position = gs.Vector3.zero
    local offsetY = (modelHeight - facePosY) * 0.17 -- 手动调整位置，让脸在水平线之上
    -- 脸一般180，脸的比例占框的1/3（竖看） 270 = 180 * 3 / 2
    position.z = self:getScenePosZ(fov, 270) * pixelsPerUnit
    position.y = (-facePosY + offsetY) * pixelsPerUnit
    position.x = -facePosX * pixelsPerUnit

    -- 计算根节点的 rotation


    -- 设置根节点的 position
    rootTrans:SetParent(camTrans)
    rootTrans.localPosition = position


    return modelSprite, modelWidth, modelHeight
end

return _M
