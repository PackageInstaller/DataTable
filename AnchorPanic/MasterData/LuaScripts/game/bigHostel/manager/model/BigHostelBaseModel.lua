-- @FileName:   BigHostelBaseModel.lua
-- @Description:   大宿舍角色模型
-- @Author: ZDH
-- @Date:   2025-04-21 18:17:45
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostelBaseModel', Class.impl())

--允许切换场景的状态
Idle_State = {}

--状态对应的待机trigger
Idle_StateTrigger = {}

--状态对应的音效
ActionSound_list = {}

--注视鼠标的最大权重 (为 0  不开启注视鼠标)
Max_LookWeight = 1
--头部注视权重
LookAt_HeadWeight = 0.5
--眼部注视权重
LookAt_eyeWeight = 0

--视线每偏转1°时眼球BlendShape权重增加的百分点数
eyeBlendShapeWeight = 10
--眼球向上的BlendShape权重最大值
maxEyeUpBlendShapeWeight = 60
--眼球向下的BlendShape权重最大值
maxEyeDownBlendShapeWeight = 60
--眼球向左和向右的BlendShape权重最大值
maxEyeLeftRightBlendShapeWeight = 60
--眼部对应的BlendShape 索引
eyeBlendShapeIndex =
{
    left =
    {
        up = 5,
        down = 3,
        left = 9,
        right = 7,
    },

    right =
    {
        up = 4,
        down = 2,
        left = 8,
        right = 6,
    },
}

--注视鼠标的速度
LookAtSpeed = 5

--头部注视角度限制(纵向/横向为0表示不做限制)
LimitLookAngle = {minVertical = 0, maxVertical = 0, minHorizontal = 0, maxHorizontal = 0}

--允许注视鼠标的动画
LookAtAniState =
{
    cameraReset_state = nil,
    cameraFree_state = nil,
}
--注视鼠标人物前的距离
LookAtDistance = 0.7

--需要添加自由相机的动作及参数
FreeCamera_AniState =
{
    --动作名、相机聚焦点、默认距离、最小距离、最大距离、横向最小角度、横向最大角度、纵向最小角度、纵向最大角度
    -- [gs.Animator.StringToHash("Xidle01_body")] = {lookNode = "Spine_node", distance = 2, minDistance = 2, maxDistance = 10, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
}

---长按屏幕或者空格生成轮盘切换的场景（空为不支持该功能）
Scene_IconList = {}

--动作需要添加的特效
FrameAddEffect = {}

--构造函数
function ctor(self)

    -- 模型材质管理
    self.m_modelMaterials = nil
end

-- 设置模型
function setPrefab(self, data, prefabGo, finishCall)
    self.m_heroTid = data.heroTid
    self.m_modelId = data.model_id
    self.m_finishCall = finishCall

    self.m_model = prefabGo
    self:loadFinish()
end

-- 获取正式模型名(取资源)
function getModelId(self)
    return self.m_modelId
end

--获取当前大宿舍场景中唯一的运行时角色根节点
function getModelTrans(self)
    return self.m_modelTrans
end

--获取双视图绑定根；特殊模型可覆写为只包含展示角色和参考相机的运行时根节点
function getDualViewBindTrans(self)
    return self.m_modelTrans
end

--删除
function destroy(self)
    self:saveMainSceneInfo()
    self:removeEventListener()

    self:clearFrame()

    self.m_heroTid = nil
    self.m_modelId = nil
    self.m_finishCall = nil
    if self.m_model then
        gs.GameObject.Destroy(self.m_model)
        self.m_prefabName = nil
        self.m_model = nil
        self.m_modelTrans = nil

        self.m_camera = nil

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
        self.m_curCvList = nil

        self.m_parentTrans = nil

        self.m_modelBaseNode = nil
        self.m_lightParent = nil

        --IK相关
        self.m_FBBIK = nil
        self.m_lookAtIK = nil

        self.m_lockCheckLookAt = nil

        self.m_curLookAtWeight = nil

        self.m_DragQuadDic = nil

        self.m_canInteract = nil

        self.m_disableFreeCamera = nil
    end

    self.m_mainTempData = nil
    self.m_curSceneHeroData = nil

    self.m_frameAddEffectList = nil

    self:clearComponent()

    self:recoverIKDragVo()

    self:clearEffect()

    --清理自由相机
    if self.m_freeCamera and self.m_freeCamera.destroy then
        self.m_freeCamera:destroy()
        self.m_freeCamera = nil
    end
    self.m_lockFreeCamera = nil

    self:onStopCv()
    self:stopSoundEffect()

    bigHostel.BigHostelManager:disableFreeCameraReset(false)

    GameDispatcher:dispatchEvent(EventName.CLOSE_BIGHOSTEL_BLACKUI)
end

function loadFinish(self)
    self.m_callBackOuntSn = nil

    self.m_modelTrans = self.m_model.transform
    self.m_modelTrans.position = gs.VEC3_ZERO

    --获取场景相机
    self.m_camera = gs.CameraMgr:GetToScreenSceneCamera()
    self.m_defScamera = gs.CameraMgr:GetSceneCamera()
    self.m_effectForPost = self.m_model:GetComponent(ty.EffectForPost)

    --把相机挂到模型身上
    self:initCameraNode()

    --所有材质
    self.m_modelMaterials = self.m_model:GetComponent(ty.ModelMaterials)

    ---动画相关
    self.m_ani = self.m_model:GetComponent(ty.Animator)
    if self.m_ani and not gs.GoUtil.IsCompNull(self.m_ani) then
        if self.m_ani.enabled == false then
            self.m_ani.enabled = true
        end

        self.m_animClipArray = {}
        local animationClips = self.m_ani.runtimeAnimatorController.animationClips
        for i = 0, animationClips.Length - 1 do
            self.m_animClipArray[animationClips[i].name] = animationClips[i]
        end
    end

    --动画帧事件回调组件
    self.m_aniCall = self.m_model:GetComponent(ty.AnimatCall)
    if self.m_aniCall ~= nil and not gs.GoUtil.IsCompNull(self.m_aniCall) then
        self:initFrameEventCall()
    else
        logError("该角色模型未添加 AnimatCall 脚本挂载，请检查！！！")
    end

    --特效容器
    self.m_effectDic = {}

    --动态添加帧事件的字典容器
    self.m_animaEventCallDic = {}

    self.m_frameEventCall = {}
    --动态添加的组件
    self.m_componentDic = {}

    --动态添加入场动画播放完毕的事件，用于通知入场播放完毕，UI做出相应变化
    self:addAnimationClipEvent("showStart", nil, nil, function(_key)
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWSTART_OVER)
    end)

    --添加LookAtIK组件
    if self.Max_LookWeight > 0 then
        self:addLookAtComponent()

        --强行调取一次lookIK的Initiate初始化,避免IK解算器还未初始化完成，动画动了。获取的骨骼数据是错误的
        if self.m_ani.enabled == true then
            self.m_ani.enabled = false
        end

        self.m_lookAtIK.solver:Initiate(self.m_modelTrans)
        self.m_ani.enabled = true
    end

    --获取模型位置挂点
    self.m_modelBaseNode = gs.GameObject.Find("MODEL_NODE").transform
    if self.m_modelBaseNode == nil or gs.GoUtil.IsTransNull(self.m_modelBaseNode) then
        logError("场景节点挂点为空！！！" .. "MODEL_NODE")
        return
    end

    local count = self.m_modelBaseNode.childCount
    if count <= 0 then
        logError("MODEL_NODE 下不存在挂点")
        return
    end

    --获取所有动态开关的灯光
    self.m_lightParent = gs.GameObject.Find("LIGHT").transform
    if self.m_lightParent == nil or gs.GoUtil.IsTransNull(self.m_lightParent) then
        logError("场景节点挂点为空！！！" .. "LIGHT")
        return
    end

    --添加自由旋转相机组件
    if not table.empty(self.FreeCamera_AniState) then
        if gs.Application.isEditor then
            bigHostel.BigHostelCamera = require("game/bigHostel/manager/BigHostelCamera")
        end

        self.m_freeCamera = bigHostel.BigHostelCamera:new()
    end

    self.m_frameAddEffectList = {}

    --添加CV帧事件
    self.m_cvConfig = bigHostel.BigHostelManager:getModelCv(self.m_modelId)
    self.m_curCvList = {}

    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)

    ---IK相关
    self.m_FBBIK = self.m_model:GetComponent(ty.FullBodyBipedIK)
    self.m_finalUtil = self.m_model:GetComponent(ty.FinalIKUtil)
    if self.m_finalUtil and not gs.GoUtil.IsCompNull(self.m_finalUtil) then
        self.m_finalUtil.OnPostUpdate = function ()
            self:onIKPostUpdate()
        end
        self.m_finalUtil:Initiate()
    end

    self.m_IKDargVODic = {}

    local IK_DRAG = gs.GameObject.Find("IK_DRAG")
    if IK_DRAG and not gs.GoUtil.IsGoNull(IK_DRAG) then
        self.m_DragQuadDic = {}

        local quadTran = IK_DRAG.transform
        local childCount = quadTran.childCount
        for i = 0, childCount - 1 do
            local quad = quadTran:GetChild(i).gameObject
            quad:SetActive(false)
            quad.layer = gs.LayerMask.NameToLayer("Event")
            self.m_DragQuadDic[quad.name] = quad
        end
    end

    --打开黑屏组件
    GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_BLACKUI)

    self.m_curSceneHeroData = bigHostel.BigHostelManager:getHostelHero()
    if self.m_curSceneHeroData.main_type == BigHostelConst.SceneUI_Type.MIANUI then
        --检测临时数据
        self.m_mainTempData = bigHostel.BigHostelManager:getMainModelTempData()

        if not table.empty(self.m_mainTempData) then
            local parent = gs.GameObject.Find(self.m_mainTempData.parent_name).transform
            self:setParent(parent)

            for param_name, info in pairs(self.m_mainTempData.ani_parames) do
                if info.type ~= BigHostelConst.Animator_Parame_Type.Trigger then
                    self:setAnimParameValue(info.hash_key, info.type, info.val)
                end
            end

            self:playHash("body", self.m_mainTempData.body_stateHash)
            self:playHash("face", self.m_mainTempData.face_stateHash)
        else
            if bigHostel.BigHostelManager:getMainShowModelId() == self.m_curSceneHeroData.model_id then
                GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.InitIdle)
            else
                bigHostel.BigHostelManager:setMainShowModelId(self.m_curSceneHeroData.model_id)
                GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.Start)
            end
        end
    else
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.Start)
    end

    -----其他事件
    self:addEventListener()

    if self.m_finishCall then
        self.m_finishCall(true, self)
    end
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_LIVE_SETTRIGGER, self.setTrigger, self)
    GameDispatcher:addEventListener(EventName.EVENT_UI_OPEN, self.onUIOpenHandler, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_DISABLEFREECAMERARESET, self.checkLookAtSreen, self)
    GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.onMainUIShow, self)
    GameDispatcher:addEventListener(EventName.HIDE_MAIN_UI, self.saveMainSceneInfo, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_LIVE_SETTRIGGER, self.setTrigger, self)
    GameDispatcher:removeEventListener(EventName.EVENT_UI_OPEN, self.onUIOpenHandler, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_DISABLEFREECAMERARESET, self.checkLookAtSreen, self)
    GameDispatcher:removeEventListener(EventName.SHOW_MAIN_UI, self.onMainUIShow, self)
    GameDispatcher:removeEventListener(EventName.HIDE_MAIN_UI, self.saveMainSceneInfo, self)

end

function onUIOpenHandler(self, args)
    if args.panelName ~= 'game.bigHostel.view.BigHostelSceneUI' and args.panelType == 1 then
        self:onOtherUIOpen()
        bigHostel.BigHostelManager:setIsCanInteract(false)
    else
        bigHostel.BigHostelManager:setIsCanInteract(true)
    end
end

function onMainUIShow(self)
    self:saveMainSceneInfo()
    bigHostel.BigHostelManager:setIsCanInteract(true)
end

function onOtherUIOpen(self)
    if not table.empty(self.m_mainTempData) then
        return
    end

    self:onStopCv()
    self:onSwitchIdle()
    GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
end

function onSwitchIdle(self)
    if self.m_curIdleTrigger then
        local animParames = self:getAllAnimParameInfo()
        for key, info in pairs(animParames) do
            if info.type == BigHostelConst.Animator_Parame_Type.Trigger then
                self:resetTrigger(key)
            end
        end

        self:setTrigger(self.m_curIdleTrigger)
    end
end

--拿到当前动画对应的待机trigger,用于切换回待机
function checkCurIdleState(self)
    local idleStateList = self.Idle_StateTrigger
    for enter_state, idle_trigger in pairs(idleStateList) do
        if self.m_curFaceShortHash == enter_state or self.m_curBodyShortHash == enter_state then
            self.m_curIdleTrigger = idle_trigger
            break
        end
    end
end

function getCurIdle(self)
    return self.m_curIdleTrigger
end

function checkLookAtSreen(self)
    if self.Max_LookWeight <= 0 then
        return
    end

    local canLook = false
    local state_list = nil
    if not bigHostel.BigHostelManager:getDisableFreeCameraReset() then
        state_list = self.LookAtAniState.cameraReset_state
    else
        state_list = self.LookAtAniState.cameraFree_state
    end

    if not table.empty(state_list) then
        for k, ani_state in pairs(state_list) do
            if self.m_curBodyShortHash == ani_state then
                canLook = true
                break
            end
        end
    end

    self:setLookAtSrene(canLook)
end

--内部通过Animator状态更新是否注视鼠标（不可外用）
function setLookAtSrene(self, val)
    if self.m_lookAtSrene == val then
        return
    end

    self.m_lookAtSrene = val or false
end

function onIKPostUpdate(self)
    self:lookAtEye()
end

function onFrame(self)

    --特殊处理两个相机的FOV
    if self.m_effectForPost ~= nil and not gs.GoUtil.IsCompNull(self.m_effectForPost) then
        if self.m_camera.fieldOfView ~= self.m_effectForPost.FOVValue or self.m_defScamera.fieldOfView ~= self.m_effectForPost.FOVValue then
            self.m_camera.fieldOfView = self.m_effectForPost.FOVValue
            self.m_defScamera.fieldOfView = self.m_effectForPost.FOVValue
        end
    end

    if self.m_freeCamera and self.m_disableFreeCamera ~= true then
        local lookPos = self.m_freeCamera:onCameraSlowMove()
        if lookPos then
            self:lookAtPosition(lookPos, self.LookAtSpeed)

            self:lookAtWeightLerp(self.Max_LookWeight, 0, self.LookAt_HeadWeight, self.LookAt_eyeWeight)

            self.m_canInteract = false
        else
            self.m_canInteract = true
        end
    end

    if not self.m_lockCheckLookAt and self.m_canInteract ~= false then --没有锁定注视，允许更新
        if self.m_lookAtSrene then
            -- local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(self.m_camera, "AirWall", 500)
            -- if hitInfo and hitInfo.collider then
            --     if self.m_loolAtPos == nil then
            --         self.m_loolAtPos = hitInfo.point
            --     else
            --         self.m_loolAtPos = gs.Vector3.Lerp(self.m_loolAtPos, hitInfo.point, gs.Time.deltaTime * 5)
            --     end

            --     self:lookAtPosition(self.m_loolAtPos)
            -- end

            local targerNode = self.m_FBBIK.references.head
            local distance = gs.Vector3.Distance(gs.CameraMgr:GetSceneCameraTrans().position, targerNode.position)
            local lookDistance = distance - self.LookAtDistance
            if distance < self.LookAtDistance then
                lookDistance = distance * 0.5
            end

            local lookPos = self.m_camera:ScreenToWorldPoint(gs.Vector3(gs.Input.mousePosition.x, gs.Input.mousePosition.y, lookDistance))
            self:lookAtPosition(lookPos, self.LookAtSpeed)

            self:lookAtWeightLerp(self.Max_LookWeight, 0, self.LookAt_HeadWeight, self.LookAt_eyeWeight)
        else
            self:lookAtWeightLerp(0, 0, 0, 0)
        end
    end

    if self.m_ani ~= nil and not gs.GoUtil.IsCompNull(self.m_ani) then
        local isSave = false

        local shortNameHash = AnimatorUtil.getCurStateHash(self.m_ani, self:getLayIndex("face"))
        if self.m_curFaceShortHash == nil or self.m_curFaceShortHash ~= shortNameHash then
            self.m_curFaceShortHash = shortNameHash
            self:onAnimaFaceStateSwitch(shortNameHash)

            isSave = true
        end

        shortNameHash = AnimatorUtil.getCurStateHash(self.m_ani, self:getLayIndex("body"))
        if self.m_curBodyShortHash == nil or self.m_curBodyShortHash ~= shortNameHash then
            self.m_curBodyShortHash = shortNameHash
            self:onAnimaBodyStateSwitch(shortNameHash)

            isSave = true
        end

        if isSave then
            self:saveMainSceneInfo()
        end
    end
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function onAnimaFaceStateSwitch(self, stateHash)
    self:onStopCv()

    if self.m_cvConfig then
        local cv_dic = self.m_cvConfig:getCVConfig()
        local cv_config = cv_dic[stateHash]
        if cv_config then
            local cv = cv_config[1]
            local cv_count = table.nums(cv_config)
            if cv_count > 1 then
                local function getCv(cv_list, late_cv)
                    local random_index = math.random(1, #cv_list)
                    local random_cv = cv_list[random_index]
                    if self.m_lateCv == nil or random_cv.cv_id ~= self.m_lateCv.cv_id then
                        table.remove(cv_list, random_index)
                        return random_cv
                    else
                        return getCv(cv_list, late_cv)
                    end
                end

                if table.empty(self.m_curCvList[stateHash]) then
                    self.m_curCvList[stateHash] = table.copy(cv_config)
                end

                cv = getCv(self.m_curCvList[stateHash], self.m_lateCv)
                self.m_lateCv = cv
            end

            self:onActionPlayCV(cv.cv_id, cv.voice_layback)
        end
    end

    self:checkCurIdleState()
end

function onAnimaBodyStateSwitch(self, stateHash)
    self:checkCurIdleState()

    self:checkLookAtSreen()

    self:checkFreeCamera(true)

    if stateHash == BigHostelConst.startStateHash then
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWSTART_OVER, true)
    else
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWSTART_OVER, false)
    end

    ---音效添加
    if not table.empty(self.ActionSound_list) then
        self:stopSoundEffect()

        for action_hash, sound_list in pairs(self.ActionSound_list) do
            if stateHash == action_hash then
                local sound = sound_list[1]
                local num = table.nums(sound_list)
                if num > 1 then
                    local index = math.random(1, num)
                    sound = sound_list[index]
                end

                local sound_res = "arts/audio/sfx/" .. sound.res
                self:playSoundEffect(sound_res, sound.layback)
                break
            end
        end
    end

    --添加特效
    if not table.empty(self.FrameAddEffect) then
        for _, effect in pairs(self.m_frameAddEffectList) do
            self:removeEffect(effect.m_snId)
        end
        self.m_frameAddEffectList = {}

        local data = self.FrameAddEffect[self.m_curBodyShortHash]
        if data ~= nil then
            for _, config in pairs(data) do
                local cameraNode = gs.GoUtil.FindNameInChilds(self.m_model.transform, config.node)
                local effect = self:addEffect(string.format("arts/fx/3d/sceneModule/3Dhostel/%s/%s.prefab", self.m_modelId, config.name), cameraNode)
                table.insert(self.m_frameAddEffectList, effect)
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SWITCH_ANISTATE, stateHash)
end

function saveMainSceneInfo(self)
    --存储临时数据，用于主界面展示
    if self.m_curSceneHeroData.main_type == BigHostelConst.SceneUI_Type.MIANUI and bigHostel.BigHostelManager:getMainUIShow() and self.m_curFaceShortHash ~= nil and self.m_curBodyShortHash ~= nil then
        if self.m_parentTrans == nil or gs.GoUtil.IsTransNull(self.m_parentTrans) then
            return
        end

        local tempData =
        {
            model_id = self.m_modelId,
            body_stateHash = self.m_curBodyShortHash,
            face_stateHash = self.m_curFaceShortHash,
            ani_parames = self:getAllAnimParameInfo(),
            parent_name = self.m_parentTrans.name,
            freeCamera_reset = bigHostel.BigHostelManager:getDisableFreeCameraReset(),
        }

        if self.m_freeCamera ~= nil then
            local sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
            local angle = {x = self.m_freeCamera.mCamera_moveY, y = self.m_freeCamera.mCamera_moveX}

            tempData.freeCamera_parames =
            {
                angle_x = angle.x,
                angle_y = angle.y,
                distance = self.m_freeCamera.distance,
            }
        end

        bigHostel.BigHostelManager:setMainModelTempData(tempData)
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
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_ACTION_SHOWLINE, {name = self:getHeroName(), line = cvData.lines})
    end

    self:clearlaybackTimeSn()
    self.m_laybackTimeSn = LoopManager:setTimeout(voice_layback / 1000, self, playCv)
end

function onStopCv(self)
    if self.m_curAudioData then
        AudioManager:stopAudioSound(self.m_curAudioData)
        self.m_curAudioData = nil
    end

    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_ACTION_CLOSELINE)
    self:clearlaybackTimeSn()
end

function clearlaybackTimeSn(self)
    if self.m_laybackTimeSn then
        LoopManager:clearTimeout(self.m_laybackTimeSn)
        self.m_laybackTimeSn = nil
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
        local mat = gs.ResMgr:Load(UrlManager:getBigHostelMatPath(self:getModelId(), matName))
        if mat then
            mat = gs.GameObject.Instantiate(mat)
            table.insert(matList, mat)
        end
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

-----------------------------------------------------接口

function getHeroName(self)
    local heroVo = hero.HeroManager:getHeroVoByTid(self.m_heroTid)
    if heroVo then
        return heroVo:getHeroName()
    else
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.m_heroTid)
        return heroConfigVo.name
    end
    -- return
end
function initCameraNode(self)
    local sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
    local cameraNode = gs.GoUtil.FindNameInChilds(self.m_model.transform, "Camera_node")
    gs.TransQuick:SetParentOrg(sceneCameraTrans, cameraNode)
    sceneCameraTrans.localEulerAngles = gs.Vector3(0, 180, 0)
end

--锁定注视鼠标
function lockLookAt(self, value)
    self.m_lockCheckLookAt = value
end

function getCanInteract(self)
    if self.m_canInteract == nil then
        return true
    end

    return self.m_canInteract
end

function canSwitch(self)
    for _, stateHash in pairs(self.Idle_State) do
        if self.m_curFaceShortHash == stateHash or self.m_curBodyShortHash == stateHash then
            return true
        end
    end

    return false
end

function getBodyShortHash(self)
    return self.m_curBodyShortHash or 0
end

function getFaceShortHash(self)
    return self.m_curFaceShortHash or 0
end

----------------动态添加帧事件 Start----------------
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
----------------动态添加帧事件 End----------------------------------------------------------

----------------监听手动添加的帧事件 Star---------------------------------------------------
function initFrameEventCall(self)
    if not self.m_aniCall then return end

    local function frameEventCall (strParame)
        self:onFrameEventCall(strParame)
    end

    self.m_aniCall:SetSimpleFrameEventCall(frameEventCall)
end

-- "OTHERPLAYANI,E4,down"(OTHERPLAYANI操作场景中模型播放动画,具体使用参考 4516_4_h)
function onFrameEventCall(self, param)
    local params = string.split(param, ",")
    if params[1] == "SHOW_MAINUI" then --显示UI
        GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_SCENEUI)
    elseif params[1] == "HIDE_MIANUI" then--不显示UI
        GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_SCENEUI)
    elseif params[1] == "SHOW_BLACK" then--显示黑屏
        GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_BLACK)
    elseif params[1] == "CLOSE_BLACK" then---不显示黑屏
        GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
    else
        local child_params = string.split(params[1], "_")
        if child_params[1] == "NODE" then --检测设置模型到哪个节点的事件
            local node = self.m_modelBaseNode:Find(params[1])
            if node ~= nil and not gs.GoUtil.IsTransNull(node) then
                self:setParent(node)
            else
                logError("--------------没有这个模型节点" .. params[1])
            end
        elseif child_params[1] == "LIGHT" then--检测灯光设置打开事件
            for i = 1, self.m_lightParent.childCount do
                local node = self.m_lightParent:GetChild(i - 1)
                node.gameObject:SetActive(node.name == param)
            end
        end
    end
end
----------------监听手动添加的帧事件 End---------------------------------------------------

function playHash(self, layerName, stateHash)
    if not self.m_ani then return end

    local layer = 0
    if layerName ~= nil then
        layer = self:getLayIndex(layerName)
    end

    self.m_ani:Play(stateHash, layer)
end

function setLayerWeight(self, layer_name, weight)
    if not self.m_ani then return end

    local layer = self:getLayIndex(layer_name)
    self.m_ani:SetLayerWeight(layer, weight)
end

function setTrigger(self, key)
    if key ~= BigHostelConst.BaseAnimatorParams.Start and key ~= BigHostelConst.BaseAnimatorParams.InitIdle then
        if self.m_curSceneHeroData.main_type == BigHostelConst.SceneUI_Type.TRIAL then
            gs.Message.Show(_TT(50091))
            return
        end
    end

    if key == BigHostelConst.BaseAnimatorParams.Switch then
        if not self:canSwitch() then
            logAll("<color=Yellow>当前状态不允许切换，请检查Idle_State是否有当前状态</color>")
            return
        end
    end

    self:set_trigger(key)
end

function set_trigger(self, key)
    if not self.m_ani then return end

    self.m_ani:SetTrigger(key)
end

function resetTrigger(self, key)
    if not self.m_ani then return end

    self.m_ani:ResetTrigger(key)
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

function getAllAnimParameInfo(self)
    if self.m_ani == nil or gs.GoUtil.IsCompNull(self.m_ani) then
        return
    end

    local params = {}
    local animParame = self.m_ani.parameters
    for i = 0, animParame.Length - 1 do
        local param = animParame[i]
        local val, type = self:getAnimParameValue(param)
        params[param.name] = {val = val, type = type, hash_key = param.nameHash}
    end

    return params
end

function getAnimParameValue(self, param)
    if param.type == gs.AnimatorControllerParameterType.Bool then
        return self.m_ani:GetBool(param.nameHash), BigHostelConst.Animator_Parame_Type.Bool
    elseif param.type == gs.AnimatorControllerParameterType.Int then
        return self.m_ani:GetInteger(param.nameHash), BigHostelConst.Animator_Parame_Type.Int
    elseif param.type == gs.AnimatorControllerParameterType.Float then
        return self.m_ani:GetFloat(param.nameHash), BigHostelConst.Animator_Parame_Type.Float
    elseif param.type == gs.AnimatorControllerParameterType.Trigger then
        return 0, BigHostelConst.Animator_Parame_Type.Trigger
    end
end

function setAnimParameValue(self, nameHash, type, value)
    if self.m_ani == nil or gs.GoUtil.IsCompNull(self.m_ani) then
        return
    end

    if type == BigHostelConst.Animator_Parame_Type.Bool then
        self:setBool(nameHash, value)
    elseif type == BigHostelConst.Animator_Parame_Type.Int then
        self:setInt(nameHash, value)
    elseif type == BigHostelConst.Animator_Parame_Type.Float then
        self:setFloat(nameHash, value)
    elseif type == gs.AnimatorControllerParameterType.Trigger then
        self:setTrigger(nameHash)
    end
end

function getLayIndex(self, layer_name)
    local layer_list = {
        ["body"] = 0,
        ["face"] = 1,
    }
    return layer_list[layer_name]
end

--当前是否存在这个动画状态
function aniHashState(self, animator, stateHash)
    animator = animator or self.m_ani

    if animator == nil or gs.GoUtil.IsCompNull(animator) then
        return false
    end

    -- 将运行时控制器转换为AnimatorController
    local controller = animator.runtimeAnimatorController
    if (controller == nil) then
        return false
    end

    local animationClips = controller.animationClips
    for i = 0, animationClips.Length - 1 do
        if stateHash == gs.Animator.StringToHash(animationClips[i].name) then
            return true
        end
    end
    return false
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

-----------------------------------------------------自由相机
--检测是否开启自由相机
function checkFreeCamera(self, init_distance)
    if table.empty(self.FreeCamera_AniState) then
        return
    end

    if self.m_lockFreeCamera == true then
        return
    end

    --先将动画归位，拿到一次位置之后在切自由相机
    self:initCameraNode()
    self:closeFreeCamera()

    -- --延迟一帧确保已经拿到了数据
    -- if self.m_checkFreeCameraSn then
    --     LoopManager:removeFrameByIndex(self.m_checkFreeCameraSn)
    --     self.m_checkFreeCameraSn = nil
    -- end

    -- self.m_checkFreeCameraSn = LoopManager:setFrameout(1, self, function ()
    -- if self.m_curBodyShortHash ~= gs.Animator.StringToHash("showStart") then
    local param = self.FreeCamera_AniState[self.m_curBodyShortHash]
    if param then
        local angle, distance = nil, nil
        if not table.empty(self.m_mainTempData) then
            if self.m_mainTempData.body_stateHash == self.m_curBodyShortHash then
                if self.m_freeCamera then
                    bigHostel.BigHostelManager:disableFreeCameraReset(self.m_mainTempData.freeCamera_reset, false)

                    if not table.empty(self.m_mainTempData.freeCamera_parames) then
                        angle = {x = self.m_mainTempData.freeCamera_parames.angle_x, y = self.m_mainTempData.freeCamera_parames.angle_y}
                        distance = self.m_mainTempData.freeCamera_parames.distance
                    end
                end
            end

            self.m_mainTempData = nil
        end

        self:openFreeCamera(param, init_distance, angle, distance)
    end
    -- end
    -- end)
end

function openFreeCamera(self, param, init_distance, angle, distance)
    if self.m_freeCamera then
        local lookTrans = gs.GameObject.Find(param.lookNode).transform

        local sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
        sceneCameraTrans:SetParent(lookTrans)

        self.m_freeCamera:setOperateParam(lookTrans, param, init_distance, angle, distance)
    end
end

function closeFreeCamera(self)
    if self.m_freeCamera then
        self.m_freeCamera:close()
    end
end

--是否锁定自由相机不允许切换目标
function lockFreeCamera(self, value)
    self.m_lockFreeCamera = value
end

---禁用相机
function disableFreeCamera(self, value)
    self.m_disableFreeCamera = value
end

function canDisableFreeCameraReset(self)
    for state, _ in pairs(self.FreeCamera_AniState) do
        if self.m_curBodyShortHash == state then
            return true
        end
    end

    return false
end

-----------------------------------------------------IK 相关
function addLookAtComponent(self)
    self.m_lookAtIK = self.m_model:GetComponent(ty.LookAtIK)

    self.m_curLookAtWeight = 0
    self.m_curHeadWeight = 0

    if self.m_lookAtIK.solver.eyes.Length > 0 then
        self.m_eysBone = self.m_lookAtIK.solver.eyes[0].transform

        local skins = self.m_model:GetComponentsInChildren(ty.SkinnedMeshRenderer)
        local skin = nil
        for i = 0, skins.Length - 1 do
            skin = skins[i]
            if string.find(skin.name, "Face") then
                self.m_faceSkin = skin
                break
            end
        end
    end

end

function lookAtPosition(self, position, speed)
    speed = speed or 1

    --限制角度
    if self.LimitLookAngle.minVertical ~= 0 or self.LimitLookAngle.maxVertical ~= 0 or self.LimitLookAngle.minHorizontal ~= 0 or self.LimitLookAngle.maxHorizontal ~= 0 then
        self.distance = gs.Vector3.Distance(position, self.m_lookAtIK.solver.head.transform.position)

        -- 计算从头部到目标的方向
        local lookDirection = position - self.m_lookAtIK.solver.head.transform.position

        -- 将方向转换为局部空间
        local localDirection = self.m_lookAtIK.transform:InverseTransformDirection(lookDirection)

        -- 计算水平和垂直角度
        local horizontalAngle = gs.Mathf.Atan2(localDirection.x, localDirection.z) * gs.Mathf.Rad2Deg
        local verticalAngle = gs.Mathf.Atan2(localDirection.y, gs.Mathf.Sqrt(localDirection.x * localDirection.x + localDirection.z * localDirection.z)) * gs.Mathf.Rad2Deg

        -- 应用角度限制
        if self.LimitLookAngle.minHorizontal ~= 0 or self.LimitLookAngle.maxHorizontal ~= 0 then
            horizontalAngle = gs.Mathf.Clamp(horizontalAngle, self.LimitLookAngle.minHorizontal, self.LimitLookAngle.maxHorizontal)
        end

        if self.LimitLookAngle.minVertical ~= 0 or self.LimitLookAngle.maxVertical ~= 0 then
            verticalAngle = gs.Mathf.Clamp(verticalAngle, self.LimitLookAngle.minVertical, self.LimitLookAngle.maxVertical)
        end

        -- 将受限角度转换回世界空间
        local horizontalRotation = gs.Quaternion.AngleAxis(horizontalAngle, self.m_lookAtIK.transform.up)
        local verticalRotation = gs.Quaternion.AngleAxis(verticalAngle, self.m_lookAtIK.transform.right *- 1)

        local targetRotation = self.m_lookAtIK.transform.rotation * horizontalRotation * verticalRotation

        -- 设置受限的目标位置
        position = self.m_lookAtIK.solver.head.transform.position + targetRotation * self.m_lookAtIK.transform.forward * self.distance
    end

    if self.m_lookAtIK.solver:GetIKPositionWeight() <= 0.1 then
        self.m_loolAtPos = position
    else
        self.m_loolAtPos = gs.Vector3.Lerp(self.m_loolAtPos, position, gs.Time.deltaTime * speed)
    end

    self.m_lookAtIK.solver:SetIKPosition(self.m_loolAtPos)
end

function lookAtWeight(self, weight, bodyWeight, headWeight, eyesWeight, clampWeight, clampWeightHead, clampWeightEyes)
    if not self.m_lookAtIK then
        return
    end

    self.m_curLookAtWeight = weight
    self.m_curHeadWeight = headWeight

    clampWeight = clampWeight or 0.8
    clampWeightHead = clampWeightHead or 0.5
    clampWeightEyes = clampWeightEyes or 0.15

    self.m_lookAtIK.solver:SetLookAtWeight(self.m_curLookAtWeight, bodyWeight, self.m_curHeadWeight, eyesWeight, clampWeight, clampWeightHead, clampWeightEyes)
end

function lookAtWeightLerp(self, weight, bodyWeight, headWeight, eyesWeight, clampWeight, clampWeightHead, clampWeightEyes)
    if not self.m_lookAtIK then
        return
    end

    -- self.m_curLookAtWeight = gs.TransQuick:Mathf_SmoothDamp(self.m_curLookAtWeight, weight, 0.5)
    -- self.m_curHeadWeight = gs.TransQuick:Mathf_SmoothDamp(self.m_curHeadWeight, headWeight, 0.5)

    self.m_curLookAtWeight = gs.Mathf.Lerp(self.m_curLookAtWeight, weight, gs.Time.deltaTime)
    self.m_curHeadWeight = gs.Mathf.Lerp(self.m_curHeadWeight, headWeight, gs.Time.deltaTime)

    clampWeight = clampWeight or 1
    clampWeightHead = clampWeightHead or 0.8
    clampWeightEyes = clampWeightEyes or 0.15

    self.m_lookAtIK.solver:SetLookAtWeight(self.m_curLookAtWeight, bodyWeight, self.m_curHeadWeight, eyesWeight, clampWeight, clampWeightHead, clampWeightEyes)
end

--眼睛注视
function lookAtEye(self)
    if self.m_lookAtIK.solver:GetIKPositionWeight() <= 0.1 then
        return
    end

    if self.m_eysBone == nil then
        return
    end

    for key, blendShape in pairs(self.eyeBlendShapeIndex) do
        -- 通过眼睛骨骼的本地空间旋转角计算BlendShape值
        local horizontal = self.m_eysBone.localEulerAngles.x;
        local vertical = self.m_eysBone.localEulerAngles.z;

        local left_Weight, right_Weight, up_Weight, down_Weight = 0, 0, 0, 0

        -- 计算眼球BlendShape权重
        if horizontal > 180 then
            right_Weight = math.min(self.maxEyeLeftRightBlendShapeWeight, (360 - horizontal) * self.eyeBlendShapeWeight)
        else
            left_Weight = math.min(self.maxEyeLeftRightBlendShapeWeight, horizontal * self.eyeBlendShapeWeight)
        end

        if vertical > 180 then
            down_Weight = math.min(self.maxEyeDownBlendShapeWeight, (360 - vertical) * self.eyeBlendShapeWeight)
        else
            up_Weight = math.min(self.maxEyeUpBlendShapeWeight, vertical * self.eyeBlendShapeWeight)
        end

        -- 设置眼球BlendShape权重
        self.m_faceSkin:SetBlendShapeWeight(blendShape.up, up_Weight)
        self.m_faceSkin:SetBlendShapeWeight(blendShape.down, down_Weight)
        self.m_faceSkin:SetBlendShapeWeight(blendShape.left, left_Weight)
        self.m_faceSkin:SetBlendShapeWeight(blendShape.right, right_Weight)
    end

end

--添加IK肢体拖动Vo
function addIKDragVo(self, key, clickGo, size, raycast_panel, Offet_Bones, point_down, dragCall, point_up, limit, drag_speed, reset_speed, efx_time)
    if gs.Application.isEditor then
        bigHostel.BigHostelIKDragVo = require("game/bigHostel/manager/BigHostelIKDragVo")
    end

    local function onPointDown()
        -- self:lockFreeCamera(true)
        self:disableFreeCamera(true)

        if point_down then
            point_down()
        end
    end

    local function onPointUp(drag_pos)
        -- self:lockFreeCamera(false)
        self:disableFreeCamera(false)

        if point_up then
            point_up(drag_pos)
        end
    end
    if self.m_IKDargVODic[key] == nil then
        self.m_IKDargVODic[key] = bigHostel.BigHostelIKDragVo:create(self.m_FBBIK, clickGo, size, raycast_panel, Offet_Bones, onPointDown, dragCall, onPointUp, limit, drag_speed, reset_speed)
    else
        self.m_IKDargVODic[key]:setData(self.m_FBBIK, clickGo, size, raycast_panel, Offet_Bones, onPointDown, dragCall, onPointUp, limit, drag_speed, reset_speed)
    end

    if efx_time ~= -1 then
        efx_time = efx_time or 3
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, {target = clickGo.transform, key = key, life_time = efx_time})
    end
end

function getIKDragVo(self, key)
    return self.m_IKDargVODic[key]
end

function recoverIKDragVo(self, key)
    if self.m_IKDargVODic == nil then
        return
    end

    if key == nil then
        for _, vo in pairs(self.m_IKDargVODic) do
            vo:recover()
        end

        self.m_IKDargVODic = nil
        return
    end

    if self.m_IKDargVODic[key] then
        self.m_IKDargVODic[key]:recover()
        self.m_IKDargVODic[key] = nil
    end

    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, {key = key})
end

---添加点击事件
function addColliderEventByGo(self, go, center, pointDown, pointUp, efx_time, no_cursor)
    if no_cursor == true then
        go.gameObject.tag = "Door"
    end

    local mouseEvent = go.gameObject:GetComponent(ty.GoMouseEvent)
    if mouseEvent == nil or gs.GoUtil.IsCompNull(mouseEvent) then
        mouseEvent = go.gameObject:AddComponent(ty.GoMouseEvent)
    end

    local isDown = false
    local function onPointDown()
        if self.m_curSceneHeroData.main_type == BigHostelConst.SceneUI_Type.TRIAL then
            gs.Message.Show(_TT(50091))
            return
        end

        if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count > 1 then
            return
        end

        if not bigHostel.BigHostelManager:getIsCanInteract() then
            return
        end

        if bigHostel.BigHostelManager:getDisableFreeCameraReset() == true then
            gs.Message.Show(_TT(84522))
            return
        end

        if pointDown then
            pointDown()
        end

        self:disableFreeCamera(true)

        isDown = true
    end

    local function onPointUp()
        if bigHostel.BigHostelManager:getDisableFreeCameraReset() == true then
            return
        end

        if not isDown then
            return
        end

        if pointUp then
            pointUp()
        end

        self:disableFreeCamera(false)

    end

    mouseEvent:SetCallFun(self, nil, onPointDown, onPointUp, nil)

    local instanceID = mouseEvent:GetInstanceID()
    self.m_componentDic[instanceID] = mouseEvent

    if efx_time ~= -1 then
        efx_time = efx_time or 3
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, {target = go.transform, key = go.name, offset = center, life_time = efx_time})
    else
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, {key = go.name})
    end
end

function addColliderEventByName(self, goName, center, pointDown, pointUp, efx_time, no_cursor)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end
    self:addColliderEventByGo(node, center, pointDown, pointUp, efx_time, no_cursor)
end

function removeColliderEventByGo(self, go)
    local goMouseEvents = go:GetComponents(ty.GoMouseEvent)
    for i = 0, goMouseEvents.Length - 1 do
        goMouseEvents[i].gameObject.tag = "Untagged"

        local instanceID = goMouseEvents[i]:GetInstanceID()
        self:removeComponent(instanceID)
    end

    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, {key = go.name})
end

function removeColliderEventByName(self, goName)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end
    self:removeColliderEventByGo(node)
end

----添加BoxCollider
function addBoxColliderByGo(self, go, size, center, no_cursor)
    if no_cursor == true then
        go.gameObject.tag = "Door"
    end

    local boxCollider = go:GetComponent(ty.BoxCollider)
    if boxCollider == nil or gs.GoUtil.IsCompNull(boxCollider) then
        boxCollider = go:AddComponent(ty.BoxCollider)
    end

    boxCollider.size = size

    if center ~= nil then
        boxCollider.center = center
    end

    local instanceID = boxCollider:GetInstanceID()
    self.m_componentDic[instanceID] = boxCollider

    return instanceID
end

function addBoxColliderByName(self, goName, size, center, no_cursor)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end

    return self:addBoxColliderByGo(node, size, center, no_cursor)
end

function removeBoxColliderByGo(self, go)
    local boxColliders = go:GetComponents(ty.BoxCollider)
    for i = 0, boxColliders.Length - 1 do
        local instanceID = boxColliders[i]:GetInstanceID()
        self:removeComponent(instanceID)
    end
end

function removeBoxColliderByName(self, goName)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end

    self:removeBoxColliderByGo(node)
end

--添加boxCollider点击事件
function addBoxColliderEventByGo(self, go, size, center, pointDown, pointUp, efx_time, no_cursor)
    self:addBoxColliderByGo(go, size, center)
    self:addColliderEventByGo(go, center, pointDown, pointUp, efx_time, no_cursor)
end

function addBoxColliderEventByName(self, goName, size, center, pointDown, pointUp, efx_time, no_cursor)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end
    self:addBoxColliderEventByGo(node, size, center, pointDown, pointUp, efx_time, no_cursor)
end

function removeBoxColliderEventByGo(self, go)
    self:removeBoxColliderByGo(go)
    self:removeColliderEventByGo(go)
end

function removeBoxColliderEventByName(self, goName)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end

    self:removeBoxColliderEventByGo(node)
end

----添加CapsuleCollider
function addCapsuleColliderByGo(self, go, radius, height, center, dir, no_cursor)
    if no_cursor == true then
        go.gameObject.tag = "Door"
    end

    local capsuleCollider = go:GetComponent(ty.CapsuleCollider)
    if capsuleCollider == nil or gs.GoUtil.IsCompNull(capsuleCollider) then
        capsuleCollider = go:AddComponent(ty.CapsuleCollider)
    end

    capsuleCollider.radius = radius
    capsuleCollider.height = height

    if center ~= nil then
        capsuleCollider.center = center
    end

    if capsuleCollider ~= nil then
        capsuleCollider.direction = dir
    end

    local instanceID = capsuleCollider:GetInstanceID()
    self.m_componentDic[instanceID] = capsuleCollider

    return instanceID
end

function addCapsuleColliderByName(self, goName, radius, height, center, dir, no_cursor)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end

    self:addCapsuleColliderByGo(node, radius, height, center, dir, no_cursor)
end

function removeCapsuleColliderByGo(self, go)
    local capsuleColliders = go:GetComponents(ty.CapsuleCollider)
    for i = 0, capsuleColliders.Length - 1 do
        local instanceID = capsuleColliders[i]:GetInstanceID()
        self:removeComponent(instanceID)
    end
end

function removeCapsuleColliderByName(self, goName)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end

    self:removeCapsuleColliderByGo(node)
end

--添加capsuleCollider点击事件
function addCapsuleColliderEventByGo(self, go, radius, height, center, dir, pointDown, pointUp, efx_time, no_cursor)
    self:addCapsuleColliderByGo(go, radius, height, center, dir)
    self:addColliderEventByGo(go, center, pointDown, pointUp, efx_time, no_cursor)
end

function addCapsuleColliderEventByName(self, goName, radius, height, center, dir, pointDown, pointUp, efx_time, no_cursor)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end
    self:addCapsuleColliderEventByGo(node, radius, height, center, dir, pointDown, pointUp, efx_time, no_cursor)
end

function removeCapsuleColliderEventByGo(self, go)
    self:removeCapsuleColliderByGo(go)
    self:removeColliderEventByGo(go)
end

function removeCapsuleColliderEventByName(self, goName)
    local node = gs.GameObject.Find(goName)
    if node == nil or gs.GoUtil.IsGoNull(node) then
        logError("找不到这个物体，请检查！！！" ..goName)
        return
    end

    self:removeCapsuleColliderEventByGo(node)
end

---移除动态添加的组件
function removeComponent(self, instanceID)
    if self.m_componentDic == nil then
        return
    end

    if self.m_componentDic[instanceID] then
        gs.GameObject.Destroy(self.m_componentDic[instanceID])
        self.m_componentDic[instanceID] = nil
    end
end

function clearComponent(self)
    for _, v in pairs(self.m_componentDic) do
        gs.GameObject.Destroy(v)
    end

    self.m_componentDic = nil
end

--添加特效
function addEffect(self, path, parentTrans, life_time, recoverCall)
    local recover_call = nil
    if life_time ~= nil then
        recover_call = function (m_snId)
            self:removeEffect(m_snId)

            if recoverCall then
                recoverCall(m_snId)
            end
        end
    end

    local effect = bigHostel.BigHosteleffect:create(path, parentTrans, life_time, recover_call)
    self.m_effectDic[effect.m_snId] = effect

    return effect
end

function removeEffect(self, id)
    if not self.m_effectDic then
        return
    end

    if self.m_effectDic[id] then
        self.m_effectDic[id]:recover()
        self.m_effectDic[id] = nil
    end
end

function clearEffect(self)
    for _id, effect in pairs(self.m_effectDic) do
        effect:recover()
    end

    self.m_effectDic = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
