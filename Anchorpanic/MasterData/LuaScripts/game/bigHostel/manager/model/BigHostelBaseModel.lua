-- @FileName:   BigHostelBaseModel.lua
-- @Description:   大宿舍角色模型
-- @Author: ZDH
-- @Date:   2025-04-21 18:17:45
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostelBaseModel', Class.impl())

--允许切换镜头的状态
Can_Switch_State = {}

--状态对应的待机trigger
Idle_StateTrigger = {}

--状态对应的音效
ActionSound_list = {}

--构造函数
function ctor(self)

    -- 模型材质管理
    self.m_modelMaterials = nil
end

-- 设置模型
function setPrefab(self, data, finishCall)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
    end

    if self.m_callBackOuntSn then
        LoopManager:removeFrameByIndex(self.m_callBackOuntSn)
        self.m_callBackOuntSn = nil
    end

    self.m_heroConfigVo = data.heroConfigVo
    self.m_modelId = data.model_id
    self.m_finishCall = finishCall

    local function _loadAysnModeCall(go)
        if go then
            self.m_model = go
            self.m_callBackOuntSn = LoopManager:setFrameout(1, self, self.loadFinish)
        else
            logError("Role Model " .. self.m_prefabName .. "not exist")
            if self.m_finishCall then
                self.m_finishCall(false, self)
            end
        end

        self.m_loadSn = nil
    end

    self.m_prefabName = string.format("arts/character/scene_module/3Dhostel/%s/model%s.prefab", self.m_modelId, self.m_modelId)
    self.m_loadSn = gs.ResMgr:LoadGOAysn(self.m_prefabName, _loadAysnModeCall)
end

-- 获取正式模型名(取资源)
function getModelId(self)
    return self.m_modelId
end

--删除
function destroy(self)
    self:removeEventListener()

    -- if self.m_showblackGo then
    --     self.m_showblackGo:recover()
    --     self.m_showblackGo = nil
    -- end

    -- if self.m_closeblackGo then
    --     self.m_closeblackGo:recover()
    --     self.m_closeblackGo = nil
    -- end

    self:clearFrame()

    if self.m_model then
        gs.GameObject.Destroy(self.m_model)
        self.m_prefabName = nil
        self.m_model = nil
        self.m_modelTrans = nil

        self.m_ani = nil
        self.m_animClipArray = nil
        self.m_aniCall = nil
        self.m_animaEventCallDic = nil
        self.m_curFaceShortHash = nil
        self.m_curBodyShortHash = nil
        self.m_curIdleTrigger = nil
        -- 模型材质管理
        self.m_modelMaterials = nil

        self.m_cvConfig = nil

        self.m_parentTrans = nil
    end

    self:onStopCv()
    self:stopSoundEffect()

    GameDispatcher:dispatchEvent(EventName.CLOSE_BIGHOSTEL_BLACKUI)
end

function loadFinish(self)
    self.m_callBackOuntSn = nil

    self.m_modelTrans = self.m_model.transform
    self.m_modelTrans.position = gs.VEC3_ZERO

    local sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
    local cameraNode = gs.GoUtil.FindNameInChilds(self.m_model.transform, "Camera_node")
    gs.TransQuick:SetParentOrg(sceneCameraTrans, cameraNode)
    sceneCameraTrans.localEulerAngles = gs.Vector3(0, 180, 0)

    self.m_ani = self.m_model:GetComponent(ty.Animator)
    if self.m_ani and not gs.GoUtil.IsCompNull(self.m_ani) then
        self.m_animClipArray = {}
        local animationClips = self.m_ani.runtimeAnimatorController.animationClips
        for i = 0, animationClips.Length - 1 do
            self.m_animClipArray[animationClips[i].name] = animationClips[i]
        end

    end
    self.m_modelMaterials = self.m_model:GetComponent(ty.ModelMaterials)

    self.m_aniCall = self.m_model:GetComponent(ty.AnimatCall)
    if self.m_aniCall ~= nil and not gs.GoUtil.IsCompNull(self.m_aniCall) then
        self.m_animaEventCallDic = {}

        --添加挂点帧监听
        local model_baseNode = gs.GameObject.Find("MODEL_NODE").transform
        if model_baseNode == nil or gs.GoUtil.IsTransNull(model_baseNode) then
            logError("场景节点挂点为空！！！" .. "MODEL_NODE")
            return
        end

        local count = model_baseNode.childCount
        if count <= 0 then
            logError("MODEL_NODE 下不存在挂点")
            return
        end

        for i = 0, count - 1 do
            local node = model_baseNode:GetChild(i)
            local function call()
                self:setParent(node)
            end
            self.m_aniCall:AddFrameEventCall("NODE_" .. (i + 1), call)
        end

        --添加灯光帧监听
        local light_parent = gs.GameObject.Find("LIGHT").transform
        if light_parent == nil or gs.GoUtil.IsTransNull(light_parent) then
            logError("场景节点挂点为空！！！" .. "LIGHT")
            return
        end

        count = light_parent.childCount
        if count <= 0 then
            logError("LIGHT 下不存在挂点")
            return
        end

        for i = 0, count - 1 do
            local function call()
                for j = 0, count - 1 do
                    local node = light_parent:GetChild(j)
                    node.gameObject:SetActive(j == i)
                end
            end
            self.m_aniCall:AddFrameEventCall("LIGHT_" .. (i + 1), call)
        end

        --添加UI帧事件监听
        --显示UI
        local function showMainUI()
            GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_SCENEUI)
        end
        self.m_aniCall:AddFrameEventCall("SHOW_MAINUI", showMainUI)
        --不显示UI
        local function closeMainUI()
            GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_SCENEUI)
        end
        self.m_aniCall:AddFrameEventCall("HIDE_MIANUI", closeMainUI)
        --显示黑屏
        local function showBlack()
            GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_BLACK)
        end
        self.m_aniCall:AddFrameEventCall("SHOW_BLACK", showBlack)
        ---不显示黑屏
        local function closeBlack()
            GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
        end
        self.m_aniCall:AddFrameEventCall("CLOSE_BLACK", closeBlack)
        GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_BLACKUI)

    else
        logError("该角色模型未添加 AnimatCall 脚本挂载，请检查！！！")
    end

    self:addAnimationClipEvent("showStart", nil, nil, function(_key)
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWSTART_OVER)
    end)

    --添加CV帧事件
    self.m_cvConfig = bigHostel.BigHostelManager:getModelCv(self.m_modelId)
    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)

    self:addEventListener()

    if self.m_finishCall then
        self.m_finishCall(true, self)
    end

end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_LIVE_SETTRIGGER, self.setTrigger, self)
    GameDispatcher:addEventListener(EventName.EVENT_UI_OPEN, self.onUIOpenHandler, self)
    -- GameDispatcher:addEventListener(EventName.SHOW_BIGHOSTEL_BLACK, self.onShowBlack, self)
    -- GameDispatcher:addEventListener(EventName.HIDE_BIGHOSTEL_BLACK, self.onCloseBlack, self)

    -- GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.onOtherUIOpen, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_LIVE_SETTRIGGER, self.setTrigger, self)
    GameDispatcher:removeEventListener(EventName.EVENT_UI_OPEN, self.onUIOpenHandler, self)
    -- GameDispatcher:removeEventListener(EventName.SHOW_BIGHOSTEL_BLACK, self.onShowBlack, self)
    -- GameDispatcher:removeEventListener(EventName.HIDE_BIGHOSTEL_BLACK, self.onCloseBlack, self)
    -- GameDispatcher:removeEventListener(EventName.SHOW_MAIN_UI, self.onOtherUIOpen, self)

end

-- function onShowBlack(self)
--     if self.m_closeblackGo then
--         self.m_closeblackGo:setActive(false)
--     end

--     if self.m_showblackGo == nil then
--         local cameraNode = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Camera_node")
--         self.m_showblackGo = bigHostel.BigHosteleffect:create("arts/fx/3d/sceneModule/3Dhostel/fx_show_black.prefab", cameraNode)
--     else
--         self.m_showblackGo:setActive(true)
--     end
-- end

-- function onCloseBlack(self)
--     if self.m_showblackGo then
--         self.m_showblackGo:setActive(false)
--     end

--     if self.m_closeblackGo == nil then
--         local cameraNode = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Camera_node")
--         self.m_closeblackGo = bigHostel.BigHosteleffect:create("arts/fx/3d/sceneModule/3Dhostel/fx_close_black.prefab", cameraNode)
--     else
--         self.m_closeblackGo:setActive(true)
--     end
-- end

function onUIOpenHandler(self, args)
    if args.panelName ~= 'game.bigHostel.view.BigHostelSceneUI' and args.panelType == 1 then
        self:onOtherUIOpen()
    end
end

function onOtherUIOpen(self)
    self:onStopCv()
    self:onSwitchIdle()
    GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
end

function onSwitchIdle(self)
    if self.m_curIdleTrigger then
        self:setTrigger(self.m_curIdleTrigger)
    end
end

function checkCurIdleState(self)
    local idleStateList = self.Idle_StateTrigger
    for enter_state, idle_trigger in pairs(idleStateList) do
        if self.m_curFaceShortHash == enter_state or self.m_curBodyShortHash == enter_state then
            self.m_curIdleTrigger = idle_trigger
            break
        end
    end
end

function onFrame(self)
    if self.m_ani == nil or gs.GoUtil.IsCompNull(self.m_ani) then
        return
    end

    local shortNameHash = self:getCurStateHash("face")
    if self.m_curFaceShortHash == nil or self.m_curFaceShortHash ~= shortNameHash then
        self.m_curFaceShortHash = shortNameHash

        self:onAnimaFaceStateSwitch(shortNameHash)
    end

    shortNameHash = self:getCurStateHash("body")
    if self.m_curBodyShortHash == nil or self.m_curBodyShortHash ~= shortNameHash then
        self.m_curBodyShortHash = shortNameHash

        self:onAnimaBodyStateSwitch(shortNameHash)
    end
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function onAnimaFaceStateSwitch(self, stateHash)
    if self.m_cvConfig then
        local cv_dic = self.m_cvConfig:getCVConfig()
        local cv_config = cv_dic[stateHash]
        if cv_config then
            self:onActionPlayCV(cv_config.cv_id, cv_config.voice_layback)
        else
            self:onStopCv()
        end
    end

    self:checkCurIdleState()
end

function onAnimaBodyStateSwitch(self, stateHash)
    self:checkCurIdleState()

    if stateHash == BigHostelConst.startStateHash then
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWSTART_OVER, true)
    else
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWSTART_OVER, false)
    end

    ---音效添加
    if not table.empty(self.ActionSound_list) then
        self:stopSoundEffect()
        for action_hash, sound in pairs(self.ActionSound_list) do
            if stateHash == action_hash then
                local sound_res = "arts/audio/sfx/" .. sound.res
                self:playSoundEffect(sound_res, sound.layback)
            end
        end
    end
end

function playSoundEffect(self, resPath, layback)
    local function playSound()
        self.m_soundData = AudioManager:playSoundEffect(resPath, false, nil, nil, function ()
            self.m_soundData = nil
        end)
    end

    layback = layback or 0

    self:clearSoundlaybackTimeSn()
    self.m_soundLaybackTimeSn = LoopManager:setTimeout(layback / 1000, self, playSound)
end

function clearSoundlaybackTimeSn(self)
    if self.m_soundLaybackTimeSn then
        LoopManager:clearTimeout(self.m_soundLaybackTimeSn)
        self.m_soundLaybackTimeSn = nil
    end
end

function stopSoundEffect(self)
    if self.m_soundData then
        AudioManager:stopAudioSound(self.m_soundData)
        self.m_soundData = nil
    end

    self:clearSoundlaybackTimeSn()
end

--动作名，cvid,延迟
function onActionPlayCV(self, cv_id, voice_layback)
    local function playCv()
        self.m_curAudioData = AudioManager:playHeroCVOnReplace(cv_id, function()
            self.m_curAudioData = nil
            GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_ACTION_CLOSELINE)
        end)

        local cvData = AudioManager:getCVData(cv_id)
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_ACTION_SHOWLINE, {name = self.m_heroConfigVo.name, line = cvData.lines})
    end

    self:clearlaybackTimeSn()
    self.m_laybackTimeSn = LoopManager:setTimeout(voice_layback / 1000, self, playCv)
end

function onStopCv(self)
    if self.m_curAudioData then
        AudioManager:stopAudioSound(self.m_curAudioData)
        self.m_curAudioData = nil

        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_ACTION_CLOSELINE)
    end

    self:clearlaybackTimeSn()
end

function clearlaybackTimeSn(self)
    if self.m_laybackTimeSn then
        LoopManager:clearTimeout(self.m_laybackTimeSn)
        self.m_laybackTimeSn = nil
    end
end

--frame == nil 自动添加在最末尾
--key 会在前面加上 "anima_name,"
function addAnimationClipEvent(self, anima_name, frame, key, callFun)
    if not self.m_ani then return end

    local ani_clip = self.m_animClipArray[anima_name]
    if ani_clip == nil then
        logError("该模型上未挂载" .. anima_name .. "动画片段，无法添加帧事件。请检查！！！")
        return
    end

    local time = ani_clip.length
    if frame ~= nil then
        time = frame / ani_clip.frameRate
    end

    if key ~= nil then
        key = anima_name .. "," .. key .. "," .. time
    else
        key = anima_name .. "," .. time
    end

    local events = ani_clip.events
    for i = 0, events.Length - 1 do
        local evt = events[i]
        if (evt.functionName == "CallFrameEvent" and evt.stringParameter == key) then
            self:addClipEvent(key, callFun)
            return
        end
    end

    local animationEvent = gs.AnimationEvent()
    animationEvent.time = time
    animationEvent.functionName = "CallFrameEvent"
    animationEvent.stringParameter = key
    ani_clip:AddEvent(animationEvent)

    self:addClipEvent(key, callFun)
end

function addClipEvent(self, key, call)
    if self.m_animaEventCallDic[key] == nil then
        self.m_animaEventCallDic[key] = {}
    end
    table.insert(self.m_animaEventCallDic[key], call)

    local function callFun()
        if not table.empty(self.m_animaEventCallDic[key]) then
            for _, _call in pairs(self.m_animaEventCallDic[key]) do
                _call(key)
            end
        end
    end
    self.m_aniCall:AddFrameEventCall(key, callFun)
end

function setTrigger(self, key)
    if key ~= BigHostelConst.BaseAnimatorParams.Start and key ~= BigHostelConst.BaseAnimatorParams.InitIdle then
        local model_data = bigHostel.BigHostelManager:getHostelHero()
        if model_data.main_type == BigHostelConst.SceneUI_Type.TRIAL then
            gs.Message.Show(_TT(50091))
            return
        end
    end

    if not self.m_ani then return end

    if key == BigHostelConst.BaseAnimatorParams.Switch then
        local canSwitch = false

        local canSwitchStateList = self.Can_Switch_State
        for _, stateHash in pairs(canSwitchStateList) do
            if self.m_curFaceShortHash == stateHash or self.m_curBodyShortHash == stateHash then
                canSwitch = true
                break
            end
        end

        if not canSwitch then
            return
        end
    end

    self.m_ani:SetTrigger(key)
end

function setBool(self, key, value)
    if not self.m_ani then return end

    self.m_ani:SetBool(key, value)
end

function setFloat(self, key, value)
    if not self.m_ani then return end

    self.m_ani:SetFloat(key, value)
end

function setInt(self, key, value)
    if not self.m_ani then return end

    self.m_ani:SetInteger(key, value)
end

function getCurStateHash(self, layer_name)
    if not self.m_ani then return end

    layer_name = layer_name or "body"
    return self.m_ani:GetCurrentAnimatorStateInfo(self:getLayIndex(layer_name)).shortNameHash
end

function getLayIndex(self, layer_name)
    local layer_list = {
        ["body"] = 0,
        ["face"] = 1,
    }
    return layer_list[layer_name]
end

function setParent(self, parent)
    if self.m_parentTrans == parent then
        return
    end

    self.m_parentTrans = parent

    if self.m_modelTrans then
        gs.TransQuick:SetParentOrg(self.m_modelTrans, self.m_parentTrans)
    end
end

-- 外部设置模型材质球变化
function setMaterial(self, pos, mats, dissolves)
    self:updateMaterial(pos, mats, dissolves)
end

-- 设置改变材质
function updateMaterial(self, posList, mats, dissolves)
    if not self.m_modelMaterials or gs.GoUtil.IsCompNull(self.m_modelMaterials) then
        return
    end
    local matList = {}
    for i, matName in ipairs(mats) do
        local mat = gs.ResMgr:Load("arts/character/scene_module/3Dhostel/" .. self:getModelId() .. "/mats/" .. matName .. ".mat")
        mat = gs.GameObject.Instantiate(mat)
        table.insert(matList, mat)
    end

    if not table.empty(matList) then
        self.m_modelMaterials:ChangeMaterial(posList, matList)
    end
    local seed = math.random(0, 1000) / 10000
    local num = math.random(-seed, seed)
    if not table.empty(dissolves) then
        self.m_modelMaterials.DissolveValue0 = dissolves[1] + num
        self.m_modelMaterials.DissolveValue1 = dissolves[2] + num
        self.m_modelMaterials.DissolveValue2 = dissolves[3] + num
        self.m_modelMaterials.DissolveValue3 = dissolves[4] + num
        self.m_modelMaterials.DissolveValue4 = dissolves[5] + num
        self.m_modelMaterials.DissolveValue5 = dissolves[6] + num
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
