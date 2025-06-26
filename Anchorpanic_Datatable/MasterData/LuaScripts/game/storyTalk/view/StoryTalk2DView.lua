module("game.storyTalk.view.StoryTalk2DView", Class.impl())

local PositionType = {
    Left = 1,
    Middle = 2,
    Right = 3
}

function initData(self, sceneViewGo, createPrefabRootGo)
    self.mSceneViewGo = sceneViewGo
    local sceneViewChildGos, sceneViewChildTrans = GoUtil.GetChildHash(self.mSceneViewGo)
    self.mSceneLCenterTrans = self:getChildTrans(sceneViewChildTrans, "LenterCenter")
    self.mSceneRCenterTrans = self:getChildTrans(sceneViewChildTrans, "RenterCenter")
    self.mSceneCenterTrans = self:getChildTrans(sceneViewChildTrans, "Center")

    self.mStoryBGComponent = self:getChildGO(sceneViewChildGos, "BG"):GetComponent(ty.StoryBGComponent)

    self.mRoot = createPrefabRootGo
    self.mRootTrans = self.mRoot.transform

    self.postProcessing = sceneViewGo.transform:Find("RenderCamera"):GetComponent(ty.PostProcessing) -- 这是需要的
    self.mStory2DViewGo = AssetLoader.GetGO(UrlManager:getUIPrefabPath('storyTalk/Story2DView.prefab'))

    self.mStory2DViewGo.transform:SetParent(self.mRootTrans)
    self.m_childGos, self.m2DViewChildTrans = GoUtil.GetChildHash(self.mStory2DViewGo)

    self.mUILCenterTrans = self:getChildTrans(self.m2DViewChildTrans, "LCenter")
    self.mUIRCenterTrans = self:getChildTrans(self.m2DViewChildTrans, "RCenter")
    self.mUICenterTrans = self:getChildTrans(self.m2DViewChildTrans, "Center")
    -- self.mUILLCenterTrans = self:getChildTrans(self.m2DViewChildTrans, "LLCenter")
    -- self.mUIRRCenterTrans = self:getChildTrans(self.m2DViewChildTrans, "RRCenter")


    self.mStory2DViewGo:SetActive(false)
    self.mDataDic = {}
end

-- 设置剧情id 和 id段
function setOptData(self, storyId, id)
    self.storyId = storyId
    self.id = id
end

function getChildTrans(self, goTrans, transName)
    return goTrans[transName]
end

-- 获取子物品的gameObject
function getChildGO(self, childGos, goName)
    if not goName then
        error('goName is nil', 2)
    end
    if childGos then
        return childGos[goName]
    end
    return nil
end

-- 获取角色模型的位置信息
function getModelLocationTrans(self, isVideoCall, modelLocation)
    if modelLocation == storyTalk.PosType.Left then
        return self.mUILCenterTrans
    elseif modelLocation == storyTalk.PosType.Center then
        return self.mUICenterTrans
    elseif modelLocation == storyTalk.PosType.Right then
        return self.mUIRCenterTrans
    else
        logError("getModelLocationTrans : modelLocation is wrong, modelLocation : " .. tostring(modelLocation))
        return self.mUICenterTrans
    end
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

function destroy(self)
    self:clearModel()
    if self.shakeSn then
        LoopManager:clearTimeout(self.shakeSn)
    end

    if self.mRoot then
        gs.GameObject.Destroy(self.mRoot)
        self.mRoot = nil
        self.mRootTrans = nil

        self.mUILCenterTrans = nil
        self.mUIRCenterTrans = nil
        self.mUICenterTrans = nil
        -- self.mUILLCenterTrans = nil
        -- self.mUIRRCenterTrans = nil

        self.mSceneLCenterTrans = nil
        self.mSceneRCenterTrans = nil
        self.mSceneCenterTrans = nil
    end
end

function setDataDic(self, newLocation, liveView, data, trans, modelID, charactorType, isVideoCall, isBright, modelEffect)
    self.mDataDic[newLocation] = {
        liveView = liveView,
        data = data,
        modelLocation = newLocation,
        enterTrans = trans,
        modelID = modelID,
        charactorType = charactorType,
        isVideoCall = isVideoCall,
        isBright = isBright,
        modelEffect = modelEffect,
    }
end

function clearModel(self)
    for k, v in pairs(self.mDataDic) do
        self:removeModel(k)
    end
    self.mDataDic = {}
end

-- 处理贴图模型的变更
function texturesChange(self, curData)
    local function initPos()
        local tbl = {}
        -- 1,3代表3个位置
        for i = 1, 3 do
            tbl[i] = {
                data = nil,
                offset = nil,
                isBright = nil,
            }
        end
        return tbl
    end

    -- 根据modelID，从旧dic获取modelID数据结构
    local function getSameModelFromOldDic(newModel, oldDataDic)
        local model = nil
        if newModel.data then
            for pos = 1, 3 do
                local oldModel = oldDataDic[pos]
                if oldModel and newModel.data[2] == oldModel.modelID then
                    model = oldModel
                end
            end
        end
        return model
    end

    self.mStory2DViewGo:SetActive(true)

    local datas = curData.model_tid
    local offsets = curData.model_pos
    local update_model = curData.update_model
    local effects = curData.model_show_effect
    if not effects then
        effects = {}
        for i = 1, #datas do
            effects[i] = nil
        end
    end

    local newDic = initPos()
    for i = 1, #datas do
        local brightFlag = nil
        if update_model then
            brightFlag = update_model[i][2]
        end
        newDic[datas[i][1]] = { -- [i][1]就是位置信息modelLocation
            data = datas[i],    -- 六个参数
            offset = offsets[i],
            isBright = brightFlag,
            modelEffect = effects[i]
        }
    end

    -- 获取需要删除/修改位置/不变的model
    for pos = 1, 3 do
        local hv = newDic[pos] -- 基准

        if hv.data ~= nil then
            local dv = getSameModelFromOldDic(hv, self.mDataDic) -- 已存在模型数据
            if not dv then                                       -- mDic是否存在模型，不存在就直接加
                if self.mDataDic[pos] then                       -- 虽然没有相同的，但是位置上有，也删除
                    self:removeModel(pos)
                end
                self:addModel(hv)
            else -- 存在就判断
                -- 先判断modelID，不一致的话直接删掉旧的，加新的
                if hv.data[2] ~= dv.modelID then
                    self:removeModel(pos)
                    self:addModel(hv)
                else -- 只有modelID一致的情况下，才执行更新操作
                    self:updateModel(dv, hv)
                end
            end
        else
            if self.mDataDic[pos] then
                self:removeModel(pos)
            end
        end
    end


    self:updateAllModel()

    self:canPlayTimeLine()
end

function viewEventUpdate(self, list)
    local eventType = tonumber(list[0])
    local modelID = list[1]
    local animationClipID = list[2]
    local animationFaceTime = tonumber(list[3])

    if eventType == storyTalk.PlotType.animationTexture2D then
        for i = 1, 3 do
            local v = self.mDataDic[i]
            if v then
                if v.modelID == modelID then
                    -- print("modelID : " .. modelID .. "  面部表情修改：" .. animationClipID)
                    v.liveView:faceChange(animationClipID)
                end
            end
        end
    end
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

function addModel(self, modelData)
    local modelLocation = modelData.data[1]
    local modelID = modelData.data[2]
    local charactorType = modelData.data[3]
    local isVideoCall = modelData.data[4]
    local facePosX = modelData.data[5]
    local facePosY = modelData.data[6]
    local modelOffset = modelData.offset -- 角色偏移值
    local isBright = modelData.isBright
    local modelShowEffect = modelData.modelEffect


    local liveView = UI.new(storyTalk.StoryTalk2DLiveView)

    local enterTrans = self:getModelLocationTrans(isVideoCall, modelLocation)

    -- 加载，初始化位置信息
    local go = self.mStory2DViewGo

    liveView:initData(go, modelID, modelLocation, enterTrans, charactorType, isVideoCall, facePosX,
        facePosY, modelOffset, isBright, modelShowEffect)

    if self.mDataDic[modelLocation] ~= nil then
        self:removeModel(modelLocation)
    end

    self:setDataDic(modelLocation, liveView, modelData.data, enterTrans, modelID, charactorType, isVideoCall, isBright,
        modelShowEffect)
end

function updateModel(self, oldData, newData)
    local oldLocation = oldData.modelLocation
    local newLocation = newData.data[1]
    local isVideoCall = newData.data[4]
    local isBright = newData.isBright
    local newEnterTrans = self:getModelLocationTrans(isVideoCall, newLocation)
    oldData.liveView:updateModel(newEnterTrans, newData)

    -- 更新mDataDic
    -- 如果mDataDic 原有的位置和新的位置不一样，则需要把新位置上原有的model清除掉
    if oldLocation ~= newLocation and self.mDataDic[newLocation] ~= nil then
        self:removeModel(newLocation)
        self.mDataDic[oldLocation] = nil -- 由于是角色位置变了，以前的位置要置空（但不能删，因为newLocation在用）
    end

    self:setDataDic(newLocation, oldData.liveView, newData.data, newEnterTrans, oldData.modelID,
        oldData.charactorType, isVideoCall, isBright, oldData.modelEffect)
end

function removeModel(self, modelLocation)
    if self.mDataDic[modelLocation] then
        local data = self.mDataDic[modelLocation]

        if data.liveView then
            data.liveView:destroy()
        else
            -- print("值为空, modelLocation" .. tostring(modelLocation))
        end
        self.mDataDic[modelLocation] = nil
    end
end

function updateAllModel(self)
    local leftData = self.mDataDic[PositionType.Left]
    local middleData = self.mDataDic[PositionType.Middle]
    local rightData = self.mDataDic[PositionType.Right]

    if leftData and rightData and not middleData then -- 左右
        local leftTrans = self:getModelLocationTrans(leftData.isVideoCall, PositionType.Left)
        local rightTrans = self:getModelLocationTrans(rightData.isVideoCall, PositionType.Right)

        leftData.liveView:updateModel(leftTrans, leftData)
        rightData.liveView:updateModel(rightTrans, rightData)
    elseif middleData and rightData and not leftData then -- 中右
        local leftTrans = self:getModelLocationTrans(middleData.isVideoCall, PositionType.Left)
        local rightTrans = self:getModelLocationTrans(rightData.isVideoCall, PositionType.Right)

        middleData.liveView:updateModel(leftTrans, middleData)
        rightData.liveView:updateModel(rightTrans, rightData)
    end
end

-- 通知编辑器开始播放动画
function canPlayTimeLine(self)
    cusLog("通知播放:--" .. self.storyId .. "|id:" .. self.id)
    self.mStoryBGComponent:StartPlayTimeLine(self.storyId, self.id)
end

return _M
