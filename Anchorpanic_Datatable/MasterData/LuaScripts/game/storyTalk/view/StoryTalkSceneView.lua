module("game.storyTalk.view.StoryTalkSceneView", Class.impl())


function dtor(self)
    self:Destroy()
end

function Destroy(self)
    if self.effectManager then
        self.effectManager:Stop()
        self.effectManager:RemoveAllClips()
    end
    -- if self.CamController then
    --     gs.Object.Destroy(self.CamController)
    --     self.CamController = nil
    -- end
    -- if self.CamAnimator then
    --     gs.GameObject.Destroy(self.CamAnimator)
    --     self.CamAnimator = nil
    -- end
end

function initData(self, go)
    self.mRoot = go
    self.mRoot.transform:SetParent(GameView.story)
    self.mRootTrans = self.mRoot.transform
    gs.TransQuick:Pos(self.mRootTrans, 0, -50, 2.5)

    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.mRoot)
    self.postProcessing = self:getChildTrans("RenderCamera"):GetComponent(ty.PostProcessing)
    self.effectManager = self:getChildTrans("RenderCamera"):GetComponent(ty.SimpleAnimation)
    self.mLEnterTrans = self:getChildTrans("Lenter")
    self.mREnterTrans = self:getChildTrans("Renter")
    self.mCEnterTrans = self:getChildTrans("Center")

    self.mLCEnterTrans = self:getChildTrans("LenterCenter")
    self.mRCEnterTrans = self:getChildTrans("RenterCenter")

    self.mDataDic = {}
    self.mShowTranValue = { 0, 0, 0 }
    self.mDelayTime = 0 -- 效果的延时时间
    self.url = ""
    self.defTweenTime = 0.5
    self.defPhoneTweenTime = 0
    self.phoneTime = 0
    self.isShow = false
    self.mBG = self:getChildGO("BG")
    self.mStoryBGComponent = self.mBG:GetComponent(ty.StoryBGComponent)

    self.mBGMat = self.mStoryBGComponent:GetComponent(ty.MeshRenderer).material

    gs.GlobalIllumMgr:SetGlobalIllumVisible(false)
    self.starSn = {}

    self.mEffDefPos = self:getChildTrans("EffDefPos")
    self.renderCamera = self:getChildTrans("RenderCamera")
    self.talkSceneLight = self:getChildTrans("talkSceneLight")
    -- 剧情专用的表情 1-10
    self.m_storyAniName = { "eye", "idle_eye", "mouth", "idle_mouth" }
    -- 剧情单独的表情
    self.m_storyOtherName = { "talk_mouth", "talk_mouth_large", "talk_mouth_Medium", "talk_mouth_Samll" }

    --是否是小屏
    self.isSmall = ScreenUtil:isSmallScreen()
end

function hideRenderCamera(self)
    self.renderCamera.gameObject:SetActive(false)
    self.talkSceneLight.gameObject:SetActive(false)
end

function loadAni(self, pos, name)
    if self.mDataDic[pos] == nil and self.mDataDic[pos+1] ~= nil then
        self.mDataDic[pos + 1].liveView:loadClip(gs.Animator.StringToHash(name))
    else
        self.mDataDic[pos].liveView:loadClip(gs.Animator.StringToHash(name))
    end
end

-- 回调C#通知剧情被跳过
function callStorySkip(self)
    self.mStoryBGComponent:ClickedTheSkipButton_LuaCall(self.storyId, self.id)
end

-- function stopAllAudio(self)
--     for _, audioData in pairs(self.mPlayAudioList) do
--         AudioManager:stopAudioSound(audioData)
--     end
--     self.mPlayAudioList = {}
-- end

-- 设置剧情id 和 id段
function setOptData(self, storyId, id)
    self.storyId = storyId
    self.id = id
end

function getChildTrans(self, transName)
    return self.m_childTrans[transName]
end

-- 获取子物品的gameObject
function getChildGO(self, name)
    if not name then
        error('name is nil', 2)
    end
    if self.m_childGos then
        return self.m_childGos[name]
    end
    return nil
end

-- 0关闭 1开启
function setPostEff(self, isActive)
    if isActive == 1 then
        self.postProcessing.Saturation = -60
        self.postProcessing.ColorPaletteToggle = true
    else
        self.postProcessing.Saturation = 0
        self.postProcessing.ColorPaletteToggle = false
    end
end

function setCameraEffect(self, readOnlyData)
    if readOnlyData == nil then
        logError("readOnlyData 为空")
        return nil
    end
    local animClip = AssetLoader.GetAsset(readOnlyData:getPath())

    if animClip ~= nil then
        -- self.effectManager:AddClip(animClip, readOnlyData:getPath())
        -- self.effectManager:Play(readOnlyData:getPath())
    else
        logError("相机特效  " .. readOnlyData:getPath() .. "  为空")
    end

    return animClip
end

function destroyCameraEffect(self, readOnlyData)
    if self.effectManager and readOnlyData then
        self.effectManager:Stop(readOnlyData:getPath())
        self.effectManager:RemoveClip(readOnlyData:getPath())
        AssetLoader.ReleaseAsset(readOnlyData:getPath())
    end
end

-- 震动
function shakeAni(self, shakeTime)
    -- 一直启用
    if shakeTime == -1 then
        self.mStoryBGComponent:SetStart(true, 0.1)
        return
    end

    -- 自动结束
    if shakeTime > 0 then
        self.mStoryBGComponent:SetStart(true, 0.1)
        local function resAni()
            self.mStoryBGComponent:SetStart(false, 0)
        end
        self.shakeSn = LoopManager:setTimeout(shakeTime / 100, nil, resAni)
    end
end

-- 停止震动
function stopShake(self)
    self.mStoryBGComponent:SetStart(false, 0)
end

-- 更换背景图
function changeSceneBG(self, url)
    if self.url ~= url then
        local sprite = gs.ResMgr:Load(url)
        if sprite then
            if sprite.texture then
                self.mBGMat:SetTexture("_MainTex", sprite.texture)
            else
                self.mBGMat:SetTexture("_MainTex", sprite)
            end
        else
            self.mBGMat:SetTexture("_MainTex", nil)
        end
        -- self.mStoryBGComponent:SetAdapt()
        self.url = url

       
        if self.isSmall then
            local index = string.find(url, "arts/ui/bg/story/cg/")
            if index ~=nil then
                self.mStoryBGComponent.state = 2
            else
                self.mStoryBGComponent.state = 1
            end
            self.mStoryBGComponent:SetAdapt()
        end
    end
end

-- 更新背景图
function updateSceneBGBegin(self, curData, flashEff, finishCall)
    local delayTime = 0
    -- 背景图可能为spine，要分开处理
    --如果img后缀是prefab，则用prefab的方式加载
    if string.find(curData.img, "%.prefab") then
        if (self.url ~= curData.img) then
            if self.mSpineView then
                self.mSpineView:updateBG(curData.img)
            else
                self.mSpineView = UI.new(storyTalk.StoryTalkSpineView)
                self.mSpineView:initData(self.mRoot, self.mBG, curData.img)
            end
        end
    else
        if (self.mSpineView) then
            self.mSpineView:destroy()
            self.mSpineView = nil
        end
        local url = curData.img
        local showEffects = curData.page_show_effect
        self:changeSceneBG(url)


        if showEffects then
            local bright = showEffects[storyTalk.PageShowEffect.bright]
            -- local disappearType = showEffects[storyTalk.PageShowEffect.disappearType]
            local appearType = showEffects[storyTalk.PageShowEffect.appearType]
            local splashCount = showEffects[storyTalk.PageShowEffect.splashCount]
            local splashTime = showEffects[storyTalk.PageShowEffect.splashTime]
            -- local shakeTopDownDis = showEffects[storyTalk.PageShowEffect.shakeTopDownDis]
            -- local shakeLeftRightDis = showEffects[storyTalk.PageShowEffect.shakeLeftRightDis]
            -- local shakeTime = showEffects[storyTalk.PageShowEffect.shakeTime]
            local shakeTime = 300

            -- 恢复默认值
            -- self:setBright(bright > 0 and bright or 1) -- 要继承上一帧的亮度，所以不恢复默认值

            -- 背景淡入
            if appearType and appearType ~= storyTalk.DisappearType.None then
                -- 第一帧淡入要设背景亮度为0
                if curData.curTalkId and curData.curTalkId == 1 then
                    self:setBright(0)
                end
                delayTime = delayTime + self:setFadeIn(appearType, bright)
            end

            -- 背景震动/闪烁
            -- 闪屏
            if splashCount > 0 then
                splashTime = splashTime * 0.001 -- 毫秒转为秒
                flashEff.color = gs.COlOR_WHITE
                local halfTime = splashTime / 2
                delayTime = delayTime + splashTime * splashCount
                for i = 0, splashCount - 1 do
                    self.flashTweenBegin = flashEff:DOFadeR(1, halfTime + splashTime * i)
                    local function flashFinishCall()
                        self.flashTweenEnd = flashEff:DOFadeR(0, halfTime)
                    end
                    LoopManager:setTimeout(halfTime + splashTime * i, self, flashFinishCall)
                end
            end
        else -- 恢复默认值
            self:setBright(1)
        end
    end

    if finishCall then
        LoopManager:setTimeout(delayTime, nil, finishCall)
    end
end

-- 结束时更新背景图效果
function updateSceneBGEnd(self, curData, finishCall)
    local showEffects = curData.page_show_effect
    if showEffects then
        local delayTime = 0
        local bright = showEffects[storyTalk.PageShowEffect.bright]
        local disappearType = showEffects[storyTalk.PageShowEffect.disappearType]
        -- 背景淡出
        if disappearType and disappearType ~= storyTalk.DisappearType.None then
            delayTime = self:setFadeOut(disappearType, bright)
        end
        if finishCall then
            LoopManager:setTimeout(delayTime, nil, finishCall)
        end
    else
        if finishCall then
            finishCall()
        end
    end
end

-- 设置背景图亮度
function setBright(self, bright)
    local curBright = 1
    if bright then
        curBright = bright
    end
    self.mBGMat:SetFloat("_Value", curBright) -- 设置明度
end

-- 设置淡入效果
function setFadeIn(self, appearType, bright)
    local delayTime = 0
    if appearType == storyTalk.DisappearType.None then
        return nil
    elseif appearType == storyTalk.DisappearType.FadeMid then
        delayTime = 2
        self.mBGMat:DOFloat(bright, "_Value", delayTime)
    end
    return delayTime
end

-- 设置淡出效果
function setFadeOut(self, disappearType, bright)
    local delayTime = 0

    if disappearType == storyTalk.DisappearType.None then
        return nil
    elseif disappearType == storyTalk.DisappearType.FadeMid then
        delayTime = 2
        self.mBGMat:DOFloat(bright, "_Value", delayTime)
    end
    return delayTime
end

function destroy(self)
    self:clearModel()
    if self.shakeSn then
        LoopManager:clearTimeout(self.shakeSn)
    end

    if self.mRoot then
        gs.GameObject.Destroy(self.mRoot)
        self.mRoot = nil
        self.mRootTrans = nil

        self.mLEnterTrans = nil
        self.mREnterTrans = nil
        self.mCEnterTrans = nil
        self.mLCEnterTrans = nil
        self.mRCEnterTrans = nil
    end

    gs.GlobalIllumMgr:SetGlobalIllumVisible(true)
end

function clearModel(self)
    for k, v in pairs(self.mDataDic) do
        self:removeModel(k)
    end
    self.mDataDic = {}
end

-- 处理模型的变更
function modelsChange(self, datas, offsets)
    local hasPos = {}

    for i = 1, 3 do
        hasPos[i] = {
            data = nil,
            offset = nil
        }
    end

    for i = 1, #datas do
        hasPos[datas[i][1]] = {
            data = datas[i],
            offset = offsets[i]
        }
    end

    -- 先统一执行移除的逻辑
    for k, v in pairs(hasPos) do
        local oldData = self.mDataDic[k]
        -- 之前有数据 但 现在没有了数据
        if oldData then
            if v.data == nil then
                self:removeModel(k)
            else
                if v.data[1] == oldData.modelPos and v.data[2] == oldData.modelID and v.data[3] == oldData.modelType and
                    v.data[4] == 1 == oldData.isPhone then
                    -- cusLog("相同的=======================")
                    if oldData.isPhone and oldData.lastCam then
                        oldData.lastCam:SetActive(false)
                    end

                    local offset = v.offset

                    local v3
                    if offset then
                        v3 = gs.Vector3(offset[1], offset[2], offset[3])
                    else
                        v3 = gs.Vector3(0, 0, 0)
                    end

                    local offsetVo = fight.RoleShowManager:getOffsetData(oldData.modelID, MainCityConst.ROLE_MODE_STORY)
                    if not table.empty(offsetVo) then
                        v3 = gs.Vector3(offset[1] + offsetVo[1], offset[2] + offsetVo[2], offset[3] + offsetVo[3])
                    end

                    if oldData.defOffset ~= v3 then
                        oldData.defOffset = v3
                    end
                    hasPos[v.data[1]] = nil
                else
                    self:removeModel(v.data[1])
                end
            end
        end
    end
    -- 统一执行新增的逻辑
    for k, v in pairs(hasPos) do
        if v.data then
            self:addModel(v.data[1], v.data[2], v.data[3], v.data[4], v.offset)
        end
    end

    self:updateDataPosition()
    self:canPlayTimeLine()
end

function loadEff(self, url, pos)
    self.createGo = AssetLoader.GetGO(url)
    if self.createGo and not gs.GoUtil.IsGoNull(self.createGo) then
        self.createGo.transform:SetParent(self.mEffDefPos, false)
        gs.TransQuick:LPos(self.createGo.transform, pos.x, pos.y, pos.z)
    end
end

function destoryEff(self)
    if self.createGo then
        gs.GameObject.Destroy(self.createGo)
        self.createGo = nil
    end
end

function addModel(self, modelPos, modelID, modelType, isPhone, offset)
    local vo = fight.LivethingVo.new()
    vo:setModelID(modelID)

    local liveView = fight.LiveView.new()

    local preList = {}
    for i = 1, #self.m_storyAniName do
        for j = 1, 10 do
            table.insert(preList, gs.Animator.StringToHash(j .. "_" .. self.m_storyAniName[i]))
        end
    end

    for i = 1, #self.m_storyOtherName do
        table.insert(preList, gs.Animator.StringToHash(self.m_storyOtherName[i]))
    end

    liveView:setPreLoadAnisByHashList(preList)

    liveView:setModeType(MainCityConst.ROLE_MODE_STORY)

    local function _call()
        liveView:setToParent(self.m_rootTrans)
        local enterTrans = nil
        if modelPos == storyTalk.PosType.Left then
            enterTrans = self.mLEnterTrans
        elseif modelPos == storyTalk.PosType.Center then
            enterTrans = self.mCEnterTrans
        elseif modelPos == storyTalk.PosType.Right then
            enterTrans = self.mREnterTrans
        end

        self.mDataDic[modelPos].isLoadFinish = true

        if self.mDataDic[modelPos].isPhone then
            local cam = enterTrans:Find("RTCam").gameObject
            cam:SetActive(true)
            self.mDataDic[modelPos].lastCam = cam
        else
            self:updateModelPower(modelPos, self.mDataDic[modelPos].todoEventValue)
        end
        self.mStoryBGComponent:SetObjectDic(modelPos, liveView.m_model)
        liveView:setPosition(enterTrans.position + self.mDataDic[modelPos].defOffset)
        liveView:setEulerAngles(enterTrans.transform.rotation.eulerAngles)
        liveView:playStartAction()

        self:updateDataPosition()
        self:canPlayTimeLine()
    end

    liveView.m_rootGo.transform:SetParent(self.mRoot.transform)
    local v3 = gs.Vector3(0, 0, 0)
    if offset then
        v3 = gs.Vector3(offset[1], offset[2], offset[3])
    end

    local offsetVo = fight.RoleShowManager:getOffsetData(modelID, MainCityConst.ROLE_MODE_STORY)
    if not table.empty(offsetVo) then
        v3 = gs.Vector3(offset[1] + offsetVo[1], offset[2] + offsetVo[2], offset[3] + offsetVo[3])
    end

    self.mDataDic[modelPos] = {
        vo = vo,
        liveView = liveView,
        defOffset = v3,
        isLoadFinish = false,
        todoEventValue = 1,
        lastCamera = nil,
        modelPos = modelPos,
        modelID = modelID,
        modelType = modelType,
        isPhone = isPhone == 1
    }
    liveView:setModelID(modelType, modelID, true, nil, _call)
end

function removeModel(self, modelPos)
    cusLog("移除.." .. modelPos)
    if self.mDataDic[modelPos] then
        self:updateModelPower(modelPos, 1)
        local data = self.mDataDic[modelPos]
        LuaPoolMgr:poolRecover(data.vo)
        LuaPoolMgr:poolRecover(data.liveView)

        if data.isPhone and data.lastCam then
            data.lastCam:SetActive(false)
        end
        self.mDataDic[modelPos] = nil
    end
end

function powersChange(self, list)
    for i = 1, #list do
        self:updateModelPower(list[i][1], list[i][2])
    end
end

function updateModelPower(self, modelPos, power)
    local value = 1
    if power == 0 then
        value = 0.5
    end

    if self.mDataDic[modelPos].isLoadFinish and self.mDataDic[modelPos].isPhone == false then
        self.mStoryBGComponent:UpdateModelToPower(modelPos, value)
    else
        self.mDataDic[modelPos].todoEventValue = power
    end
end

function updateDataPosition(self)
    local all = true
    for k, v in pairs(self.mDataDic) do
        all = all and v.isLoadFinish
    end

    if all == false then
        return
    end

    local len = table.nums(self.mDataDic)
    local rem = len % 2

    if rem == 1 then
        for key, value in pairs(self.mDataDic) do
            if not value.isLoadFinish then
                return
            end

            local enterTrans
            if key == storyTalk.PosType.Left then
                enterTrans = self.mLEnterTrans
            elseif key == storyTalk.PosType.Center then
                enterTrans = self.mCEnterTrans
            elseif key == storyTalk.PosType.Right then
                enterTrans = self.mREnterTrans
            end

            if value.isPhone then
                local cam = enterTrans:Find("RTCam").gameObject
                cam:SetActive(true)
                enterTrans = enterTrans:Find("RTCam/RTModelPos").transform
                value.lastCam = cam
                self.tweenTime = self.defPhoneTweenTime
            else
                self.tweenTime = self.defTweenTime
            end

            value.liveView:setPositionTween(enterTrans.position + value.defOffset, self.tweenTime)
        end
    else
        local enterTrans
        local maxKey = 0
        for key, value in pairs(self.mDataDic) do
            if maxKey <= key then
                maxKey = key
            end
        end

        for key, value in pairs(self.mDataDic) do
            local enterTrans
            if key == maxKey then
                enterTrans = self.mRCEnterTrans
            else
                enterTrans = self.mLCEnterTrans
            end

            if value.isPhone then
                if value.lastCam then
                    value.lastCam:SetActive(false)
                end

                local cam = enterTrans:Find("RTCam").gameObject
                cam:SetActive(true)
                enterTrans = enterTrans:Find("RTCam/RTModelPos").transform
                value.lastCam = cam
                self.tweenTime = self.defPhoneTweenTime
            else
                self.tweenTime = self.defTweenTime
            end

            value.liveView:setPositionTween(enterTrans.position + value.defOffset, self.tweenTime)
        end
    end
end

-- 通知编辑器开始播放动画
function canPlayTimeLine(self)
    local all = true
    for k, v in pairs(self.mDataDic) do
        all = all and v.isLoadFinish
    end

    if all == false then
        return
    end

    cusLog("通知播放:--" .. self.storyId .. "|id:" .. self.id)
    self.mStoryBGComponent:StartPlayTimeLine(self.storyId, self.id)
end

return _M
