-- @FileName:   BigHostel_Model_4516_4_h.lua
-- @Description:   大宿舍庭院艾丽西亚模型
-- @Author: ZDH
-- @Date:   2025-04-21 18:17:45
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostel_Model_4516_4_h', Class.impl(bigHostel.BigHostelBaseModel))

--允许切换场景的状态
Idle_State =
{
    gs.Animator.StringToHash("showStart_stand1"),
    gs.Animator.StringToHash("showStart_stand2"),
    gs.Animator.StringToHash("showStart_stand3"),
    gs.Animator.StringToHash("ganqing_stand"),
    gs.Animator.StringToHash("ganqing_stand_copy"),
    gs.Animator.StringToHash("qiuqiang_stand"),
    gs.Animator.StringToHash("chuanghu_stand"),
    gs.Animator.StringToHash("louti_stand"),
}

--允许注视鼠标的动画
LookAtAniState =
{
    --回弹相机才允许注视的动画
    cameraReset_state =
    {
        gs.Animator.StringToHash("showStart_stand1"),
        gs.Animator.StringToHash("showStart_stand3"),
        gs.Animator.StringToHash("chuanghu_stand"),
        gs.Animator.StringToHash("louti_stand"),
    },
    --不回弹相机才允许注视的动画
    cameraFree_state =
    {
        gs.Animator.StringToHash("showStart_stand1"),
        gs.Animator.StringToHash("showStart_stand3"),
        gs.Animator.StringToHash("chuanghu_stand"),
        gs.Animator.StringToHash("louti_stand"),
        gs.Animator.StringToHash("qiuqiang_stand"),
        gs.Animator.StringToHash("qiuqiang_bo"),
    }

}

--状态对应的待机trigger
Idle_StateTrigger =
{
    [gs.Animator.StringToHash("showStart")] = "idle_1",
    [gs.Animator.StringToHash("showStart_stand1")] = "idle_1",
    [gs.Animator.StringToHash("showStart_stand2")] = "idle_1",
    [gs.Animator.StringToHash("showStart_stand3")] = "idle_1",
    [gs.Animator.StringToHash("showStart_show1")] = "idle_1",
    [gs.Animator.StringToHash("showStart_show2")] = "idle_1",
    [gs.Animator.StringToHash("showStart_show3")] = "idle_1",

    [gs.Animator.StringToHash("showStart_leave")] = "idle_2",
    [gs.Animator.StringToHash("ganqing_enter")] = "idle_2",
    [gs.Animator.StringToHash("ganqing_stand")] = "idle_2",
    [gs.Animator.StringToHash("ganqing_show")] = "idle_2",
    [gs.Animator.StringToHash("ganqing_twist_1")] = "idle_2",

    [gs.Animator.StringToHash("ganqing_leave")] = "idle_3",
    [gs.Animator.StringToHash("qiuqiang_enter")] = "idle_3",
    [gs.Animator.StringToHash("qiuqiang_stand")] = "idle_3",
    [gs.Animator.StringToHash("qiuqiang_show")] = "idle_3",
    [gs.Animator.StringToHash("qiuqiang_bo")] = "idle_3",
    [gs.Animator.StringToHash("qiuqiang_twist")] = "idle_3",

    [gs.Animator.StringToHash("qiuqiang_leave")] = "idle_4",
    [gs.Animator.StringToHash("chuanghu_enter")] = "idle_4",
    [gs.Animator.StringToHash("chuanghu_stand")] = "idle_4",
    [gs.Animator.StringToHash("chuanghu_show")] = "idle_4",
    [gs.Animator.StringToHash("chuanghu_twist")] = "idle_4",

    [gs.Animator.StringToHash("chuanghu_leave")] = "idle_5",
    [gs.Animator.StringToHash("louti_enter")] = "idle_5",
    [gs.Animator.StringToHash("louti_stand")] = "idle_5",
    [gs.Animator.StringToHash("louti_show")] = "idle_5",
    [gs.Animator.StringToHash("louti_twist_tui")] = "idle_5",
    [gs.Animator.StringToHash("louti_twist_xiong")] = "idle_5",

    [gs.Animator.StringToHash("louti_leave")] = "idle_1",
}

--状态对应的音效
ActionSound_list =
{
    [gs.Animator.StringToHash("showStart")] = {{res = "4516/sfx_role_4516_4_h_01.prefab", layback = 0}},
    [gs.Animator.StringToHash("showStart_show3")] = {{res = "4516/sfx_role_4516_4_h_02.prefab", layback = 0}},
    [gs.Animator.StringToHash("showStart_leave")] = {{res = "4516/sfx_role_4516_4_h_03.prefab", layback = 3650}},
    [gs.Animator.StringToHash("ganqing_enter")] = {{res = "4516/sfx_role_4516_4_h_04.prefab", layback = 2900}},
    [gs.Animator.StringToHash("qiuqiang_enter")] = {{res = "4516/sfx_role_4516_4_h_05.prefab", layback = 3250}},
    [gs.Animator.StringToHash("qiuqiang_twist")] = {{res = "4516/sfx_role_4516_4_h_06.prefab", layback = 0}},
    [gs.Animator.StringToHash("qiuqiang_show")] = {{res = "4516/sfx_role_4516_4_h_07.prefab", layback = 0}},
    [gs.Animator.StringToHash("chuanghu_enter")] = {{res = "4516/sfx_role_4516_4_h_08.prefab", layback = 0}},
    [gs.Animator.StringToHash("chuanghu_show")] = {{res = "4516/sfx_role_4516_4_h_09.prefab", layback = 0}},
    [gs.Animator.StringToHash("louti_enter")] = {{res = "4516/sfx_role_4516_4_h_10.prefab", layback = 0}},
}

--需要添加自由相机的动作及参数
FreeCamera_AniState =
{
    -- 动作名、相机聚焦点、默认距离、最小距离、最大距离、横向最小角度、横向最大角度、纵向最小角度、纵向最大角度
    [gs.Animator.StringToHash("ganqing_stand")] = {lookNode = "Look_node", minDistance = 0.467, maxDistance = 1.48, minimumX = -90, maximumX = 100, minimumY = 10, maximumY = 100},
    [gs.Animator.StringToHash("qiuqiang_stand")] = {lookNode = "Look_node", minDistance = 0.81, maxDistance = 3.65, minimumX = 0, maximumX = 0, minimumY = -17, maximumY = 90},
    [gs.Animator.StringToHash("qiuqiang_bo")] = {lookNode = "Look_node", minDistance = 0.81, maxDistance = 3.65, minimumX = 0, maximumX = 0, minimumY = -17, maximumY = 90},
    [gs.Animator.StringToHash("chuanghu_stand")] = {lookNode = "Look_node", minDistance = 0.766, maxDistance = 5.6, minimumX = 0, maximumX = 0, minimumY = -10, maximumY = 80},
    [gs.Animator.StringToHash("louti_stand")] = {lookNode = "Look_node", minDistance = 1, maxDistance = 2.7, minimumX = 50, maximumX = 140, minimumY = 340, maximumY = 450},
}

---长按屏幕或者空格生成轮盘切换的场景（空为不支持该功能）
Scene_IconList =
{
    [1] = "bigHostel_sceneIcon_01",
    [2] = "bigHostel_sceneIcon_02",
    [3] = "bigHostel_sceneIcon_03",
    [4] = "bigHostel_sceneIcon_04",
    [5] = "bigHostel_sceneIcon_05",
}

-- --头部注视角度限制(纵向/横向为0表示不做限制)
-- LimitLookAngle = {minVertical = 0, maxVertical = 0, minHorizontal = 0, maxHorizontal = 0}

--注视鼠标的最大权重 (为 0  不开启注视鼠标)
Max_LookWeight = 1
--头部注视权重
LookAt_HeadWeight = 0.8
--眼部注视权重
LookAt_eyeWeight = 1

--眼球向上的BlendShape权重最大值
maxEyeUpBlendShapeWeight = 80
--眼球向下的BlendShape权重最大值
maxEyeDownBlendShapeWeight = 80
--眼球向左和向右的BlendShape权重最大值
maxEyeLeftRightBlendShapeWeight = 60

--注视鼠标的速度
LookAtSpeed = 3

-- 设置模型
function setPrefab(self, data, prefabGo, finishCall)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
    end

    if self.m_callBackOuntSn then
        LoopManager:removeFrameByIndex(self.m_callBackOuntSn)
        self.m_callBackOuntSn = nil
    end

    self.m_heroTid = data.heroTid
    self.m_modelId = "4516_4_h"
    self.m_finishCall = finishCall

    self.sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()

    local function _loadAysnModeCall(go)
        if go then
            self.m_model = go
            -- logAll(gs.Time.time, "女模加载完成----")
            local function loadAysnChildMode(child_go)
                self.m_childModel = child_go
                self.m_childModelTrans = self.m_childModel.transform
                self.m_childModelTrans.position = gs.VEC3_ZERO

                self.m_childAni = self.m_childModel:GetComponent(ty.Animator)

                self.m_childHeadTrans = gs.GameObject.Find("Bip001 Head001").transform
                self.m_childModelMaterials = child_go:GetComponent(ty.ModelMaterials)

                if self.m_qiuqianAni == nil or gs.GoUtil.IsCompNull(self.m_qiuqianAni) then
                    local qiuqian = gs.GameObject.Find("modelqiuqian")
                    self.m_qiuqianAni = qiuqian:GetComponent(ty.Animator)
                end

                -- logAll(gs.Time.time, "男模加载完成----")

                self:loadFinish()
            end

            local prefabPath = UrlManager:getBigHostelPrefabPath("7118_h")
            self.m_childLoadSn = gs.ResMgr:LoadGOAysn(prefabPath, loadAysnChildMode)
        end

        self.m_loadSn = nil
    end

    _loadAysnModeCall(prefabGo)
end

--删除
function destroy(self)
    super.destroy(self)

    self.m_startMousePos = nil
    self.m_showTime = nil

    self.m_qiuqianAni = nil

    self.m_qqInteractiveCount = nil
    self.m_cbInteractiveCount = nil
    self.m_ltInteractiveCount = nil

    self.m_gqState = nil

    self.m_gqColliderlist = nil

    self:removeFreeGqCollider()
    self:resumeSceneBgm()
end

function loadFinish(self)
    super.loadFinish(self)

end

function addEventListener(self)
    super.addEventListener(self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_DISABLEFREECAMERARESET, self.onFreeCamereResetState, self)
end

function removeEventListener(self)
    super.removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_DISABLEFREECAMERARESET, self.onFreeCamereResetState, self)
end

function onFreeCamereResetState(self, value)
    if value == false and self.m_curBodyShortHash == gs.Animator.StringToHash("qiuqiang_bo") then
        self:setInt("interactive", 0)
    end
end

function onSwitchIdle(self)
    if self.m_curBodyShortHash ~= gs.Animator.StringToHash("qiuqiang_bo") then
        super.onSwitchIdle(self)
    end
end

function onFrameEventCall(self, param)
    super.onFrameEventCall(self, param)

    -- "OTHERPLAYANI,E4,down"
    -- "OTHERPLAYANI,E4,up"

    local params = string.split(param, ",")
    if params[1] == "OTHERPLAYANI" then
        local anima_node = gs.GameObject.Find(params[2])
        if anima_node ~= nil and not gs.GoUtil.IsGoNull(anima_node) then
            local node_ani = anima_node:GetComponent(ty.Animator)
            if node_ani ~= nil and not gs.GoUtil.IsCompNull(node_ani) then
                node_ani:SetTrigger(params[3])

                if params[3] == "down" then
                    LoopManager:setFrameout(1, nil, function ()
                        AudioManager:playSoundEffect(string.format("arts/audio/UI/3Ddorm/ui_3Ddorm_piano_%s.prefab", params[2]))
                    end)
                end
            end
        end
    end
end

function initFrameEventCall(self)
    super.initFrameEventCall(self)

    local child_aniCall = self.m_childModel:GetComponent(ty.AnimatCall)
    if not child_aniCall or gs.GoUtil.IsCompNull(child_aniCall) then
        return
    end

    local function frameEventCall (strParame)
        self:onFrameEventCall(strParame)
    end
    child_aniCall:SetSimpleFrameEventCall(frameEventCall)
end

function onAnimaBodyStateSwitch(self, stateHash)
    super.onAnimaBodyStateSwitch(self, stateHash)

    ------------------------第一阶段----------------------------------------

    --戒指拿出来
    if stateHash == gs.Animator.StringToHash("showStart_stand1") then
        local function onPointUp()
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            self:removeBoxColliderEventByName("Bip001 L Finger31")
        end

        self:addBoxColliderEventByName("Bip001 L Finger31", gs.Vector3(0.1, 0.1, 0.1), nil, nil, onPointUp)
    else
        self:removeBoxColliderEventByName("Bip001 L Finger31")
    end

    -----戴戒指
    if stateHash == gs.Animator.StringToHash("showStart_stand2") then
        self:setLayerWeight("showStart_show2", 1)

        local function onPointDown()
            self.m_startMousePos = gs.Input.mousePosition
            self.m_showTime = 0

            self.m_lianshiFrame = LoopManager:addFrame(1, 0, self, self.onStartShow2Frame)
        end

        local function onPointUp()
            self.m_startMousePos = nil

            if self.m_showTime < 0.6 then

            else
                self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
                self:setLayerWeight("showStart_show2", 0)
            end

            LoopManager:removeFrameByIndex(self.m_lianshiFrame)
            self.m_lianshiFrame = nil
        end

        self:addBoxColliderEventByName("Bip001 L Finger32", gs.Vector3(0.1, 0.1, 0.1), nil, onPointDown, onPointUp)
    else
        self:removeBoxColliderEventByName("Bip001 L Finger32")
        self:setLayerWeight("showStart_show2", 0)
        self.m_showTime = 0
        self:setFloat("startshow2_time", self.m_showTime)
    end

    -------------IK拖拽手环----------
    if stateHash == gs.Animator.StringToHash("showStart_stand3") then
        local drag_bones =
        {
            BigHostelConst.FullBodyBipedEffector.LeftHand,
        }

        local function dragCall(drag_pos)
            if self.m_curBodyShortHash ~= gs.Animator.StringToHash("showStart_stand3") then
                if drag_pos == gs.VEC3_ZERO then
                    self:recoverIKDragVo("showStart_stand3_hand")
                end
            end
        end

        local function dragUp(drag_pos)
            if drag_pos.z <= -0.1 then
                self:setTrigger("switch")

                gs.GameObject.Destroy(self:getIKDragVo("showStart_stand3_hand").boxCollider)

                GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, {key = "showStart_stand3_hand"})
            end
        end

        local limit = {min_x = 0.05, max_x = 0.02, min_y = 0.05, max_y = 0.01, min_z = 0.15, max_z = 0.05}
        self:addIKDragVo("showStart_stand3_hand", self.m_FBBIK.references.leftHand.gameObject, {x = 0.1, y = 0.1, z = 0.1}, self.m_DragQuadDic["start_stand3_LHand"], drag_bones, nil, dragCall, dragUp, limit, 8)
    end

    if stateHash ~= gs.Animator.StringToHash("showStart_stand3") and stateHash ~= gs.Animator.StringToHash("showStart_leave") then
        self:recoverIKDragVo("showStart_stand3_hand")
    end

    ------------------------第二阶段----------------------------------------
    --按下第一个钢琴键
    if stateHash == gs.Animator.StringToHash("ganqing_stand") then
        self:addGqCollider()
    end

    if stateHash ~= gs.Animator.StringToHash("ganqing_stand") then
        self:removeBoxColliderEventByName("modelGq")
        self:removeFreeGqCollider()
    end

    if stateHash == gs.Animator.StringToHash("ganqing_show") then
        self.m_bgmAudio = AudioManager:playOtherMusic("arts/audio/music/music_3Ddorm_3.prefab", false)
    end

    if stateHash == gs.Animator.StringToHash("ganqing_show") or
        (stateHash ~= gs.Animator.StringToHash("ganqing_stand") and stateHash ~= gs.Animator.StringToHash("ganqing_twist_1") and stateHash ~= gs.Animator.StringToHash("ganqing_twist_Empty")) then
        self:removeGqCollider()
    end

    if stateHash ~= gs.Animator.StringToHash("ganqing_show") and stateHash ~= gs.Animator.StringToHash("ganqing_stand") and stateHash ~= gs.Animator.StringToHash("ganqing_twist_1") then
        self:resumeSceneBgm(true)
    end

    ------------------------第三阶段---------------------------
    if stateHash == gs.Animator.StringToHash("qiuqiang_enter") or stateHash == gs.Animator.StringToHash("qiuqiang_leave")or
        stateHash == gs.Animator.StringToHash("qiuqiang_show")or stateHash == gs.Animator.StringToHash("qiuqiang_stand")or
        stateHash == gs.Animator.StringToHash("qiuqiang_bo")or stateHash == gs.Animator.StringToHash("qiuqiang_twist") then

        if self.m_qiuqianAni == nil or gs.GoUtil.IsCompNull(self.m_qiuqianAni) then
            local qiuqian = gs.GameObject.Find("modelqiuqian")
            self.m_qiuqianAni = qiuqian:GetComponent(ty.Animator)
        end
        self.m_qiuqianAni:Play(stateHash, 0)
    else
        if self.m_qiuqianAni ~= nil and not gs.GoUtil.IsCompNull(self.m_qiuqianAni) then
            self.m_qiuqianAni:Play("Empty")
            self.m_qiuqianAni = nil
        end
    end

    --推秋千
    if stateHash == gs.Animator.StringToHash("qiuqiang_stand") then
        self:setInt("interactive", 0)

        if not self.m_qqInteractiveCount then
            self.m_qqInteractiveCount = 0
        end

        local function onPointUp_1()
            self:setInt("interactive", 1)
            self.m_qqInteractiveCount = self.m_qqInteractiveCount + 1

            if self.m_qqInteractiveCount >= 2 then
                self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            end

            self:removeBoxColliderEventByName("Bip001 Spine2")
        end

        self:addBoxColliderEventByName("Bip001 Spine2", gs.Vector3(0.3, 0.3, 0.3), gs.Vector3(-0.08, 0, 0), nil, onPointUp_1)

        local function onPointUp_2()
            self:setInt("interactive", 2)
        end

        self:addBoxColliderEventByName("Bip001 R Hand", gs.Vector3(0.1, 0.1, 0.1), gs.Vector3(-0.08, 0, 0), nil, onPointUp_2)
    elseif stateHash == gs.Animator.StringToHash("qiuqiang_bo") then
        local function onPointUp_2()
            self:setInt("interactive", 0)
        end

        self:addBoxColliderEventByName("Bip001 Spine2", gs.Vector3(0.3, 0.3, 0.3), nil, nil, onPointUp_2)
    elseif stateHash ~= gs.Animator.StringToHash("qiuqiang_stand") and stateHash ~= gs.Animator.StringToHash("qiuqiang_twist") then
        -- if self.m_qqInteractiveCount and self.m_qqInteractiveCount >= 2 then
        --     self:resetTrigger(BigHostelConst.BaseAnimatorParams.Show)
        -- end

        self.m_qqInteractiveCount = nil
    end

    if stateHash ~= gs.Animator.StringToHash("qiuqiang_stand") then
        self:removeBoxColliderEventByName("Bip001 R Hand")
    end

    if stateHash ~= gs.Animator.StringToHash("qiuqiang_stand") and stateHash ~= gs.Animator.StringToHash("qiuqiang_bo") then
        self:removeBoxColliderEventByName("Bip001 Spine2")
    end

    ------------------------第四阶段---------------------------
    if stateHash == gs.Animator.StringToHash("chuanghu_stand") then
        self:setInt("interactive", 0)

        if not self.m_cbInteractiveCount then
            self.m_cbInteractiveCount = 0
        end

        local function onPointDown()
        end

        local function onPointUp()
            self:setInt("interactive", 1)
            self.m_cbInteractiveCount = self.m_cbInteractiveCount + 1

            if self.m_cbInteractiveCount >= 3 then
                self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            end

            self:removeBoxColliderEventByName("Bone001_r")
        end

        self:addBoxColliderEventByName("Bone001_r", gs.Vector3(0.12, 0.12, 0.12), nil, onPointDown, onPointUp)

        --IK拖拽屁股
        local drag_bones =
        {
            BigHostelConst.FullBodyBipedEffector.LeftThigh,
            BigHostelConst.FullBodyBipedEffector.RightThigh,
        }

        local down = false
        local function dragDown_1()
            down = true
        end

        local function dragCall_1(drag_pos, drag_offset)
            if down and (drag_offset.y ~= 0 or drag_offset.z ~= 0) then
                self:setInt("tun", 1)
            end
        end

        local function dragUp_1(drag_pos)
            self:setInt("tun", 0)
            down = false
        end

        local limit_1 = {min_x = 0, max_x = 0, min_y = 0.04, max_y = 0, min_z = 0.07, max_z = 0.03}
        self:addIKDragVo("chuangbian_stand_Pelvs", self.m_FBBIK.references.pelvis.gameObject, {x = 0.2, y = 0.2, z = 0.2}, self.m_DragQuadDic["chuangbian_stand_Pelvs"], drag_bones, dragDown_1, dragCall_1, dragUp_1, limit_1, 8, 8)

        --IK摸头
        local function dragDown_2()
            self:lockLookAt(true)
            self:lookAtWeightLerp(1, 0, 1, 0)
            self:setInt("shy", 1)
        end

        local function dragCall_2(drag_pos)
            local lookAtPosition = gs.Vector3(1.9, 7.4, -12.8) + drag_pos
            self:lookAtPosition(lookAtPosition, 10)
        end

        local function dragUp_2(drag_pos)
            self:lockLookAt(false)
            self:setInt("shy", 0)
        end

        self:addIKDragVo("chuangbian_stand_Head", self.m_FBBIK.references.head.gameObject, {x = 0.2, y = 0.2, z = 0.2}, self.m_DragQuadDic["chuangbian_stand_Head"], nil, dragDown_2, dragCall_2, dragUp_2, nil, 100)
    elseif stateHash ~= gs.Animator.StringToHash("chuanghu_stand") and stateHash ~= gs.Animator.StringToHash("chuanghu_twist") then
        self.m_cbInteractiveCount = nil
    end

    if stateHash ~= gs.Animator.StringToHash("chuanghu_stand") then
        self:recoverIKDragVo("chuangbian_stand_Pelvs")
        self:recoverIKDragVo("chuangbian_stand_Head")
    end

    ------------------------第五阶段---------------------------
    if stateHash == gs.Animator.StringToHash("louti_stand") then
        self:setInt("interactive", 0)

        if not self.m_ltInteractiveCount then
            self.m_ltInteractiveCount = 0
        end

        local function onPointDown()
        end

        local function onPointUp()
            self:setInt("interactive", 2)
            self.m_ltInteractiveCount = self.m_ltInteractiveCount + 1

            if self.m_ltInteractiveCount >= 2 then
                self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            end

            self:removeBoxColliderEventByName("Bone001_r")
        end

        self:addBoxColliderEventByName("Bone001_r", gs.Vector3(0.3, 0.3, 0.3), nil, onPointDown, onPointUp)

        ------点击右腿
        local function onPointDown()
        end

        local function onPointUp()
            self:setInt("interactive", 1)
            self.m_ltInteractiveCount = self.m_ltInteractiveCount + 1

            if self.m_ltInteractiveCount >= 2 then
                self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            end

            self:removeBoxColliderEventByName("Bip001 R Calf")
        end

        self:addBoxColliderEventByName("Bip001 R Calf", gs.Vector3(0.36, 0.1, 0.1), gs.Vector3(-0.18, 0, 0), onPointDown, onPointUp)

        -------------拖动右腿
        local drag_bones =
        {
            BigHostelConst.FullBodyBipedEffector.RightFoot,
        }

        local limit = {min_x = 0.05, max_x = 0.09, min_y = 0, max_y = 0.05, min_z = 0.2, max_z = 0.4}
        self:addIKDragVo("louti_stand_R_Foot", self.m_FBBIK.references.rightFoot.gameObject, {x = 0.1, y = 0.1, z = 0.1}, self.m_DragQuadDic["louti_stand_R_Foot"], drag_bones, nil, nil, nil, limit, 8, 5)
    else
        self:removeBoxColliderEventByName("Bip001 R Calf")
        self:recoverIKDragVo("louti_stand_R_Foot")
    end

    if stateHash ~= gs.Animator.StringToHash("louti_stand") and stateHash ~= gs.Animator.StringToHash("louti_twist_tui")and stateHash ~= gs.Animator.StringToHash("louti_twist_xiong") then
        self.m_ltInteractiveCount = nil
    end

    if stateHash ~= gs.Animator.StringToHash("louti_stand") and stateHash ~= gs.Animator.StringToHash("chuanghu_stand") then
        self:removeBoxColliderEventByName("Bone001_r")
    end
end

function onFreeGq(self)
    self:removeGqCollider()
    self:removeBoxColliderEventByName("modelGq")

    self.m_modelTrans:Find("4516_4_h").gameObject:SetActive(false)
    self.m_modelTrans:Find("4516_4_h_Face").gameObject:SetActive(false)
    self.m_childModelTrans:Find("7118_h_Body").gameObject:SetActive(false)

    self:lockFreeCamera(true)

    self:initCameraNode()
    self:closeFreeCamera()

    local camera_moveX = gs.TransQuick:GetRotationY(self.sceneCameraTrans)
    local camera_moveY = gs.TransQuick:GetRotationX(self.sceneCameraTrans)

    local lookTrans = gs.GameObject.Find("Gq_node").transform
    self.m_freeCamera:moveToAngleTween(lookTrans.position, {x = 75, y = 0, z = 0}, 0.85, function ()
        self:stopMusic()

        self:openFreeCamera({lookNode = "Gq_node", minDistance = 0.3, maxDistance = 1.4}, true)

        local free_bai_bone = gs.GameObject.Find("free_bai_bone").transform
        for i = 0, free_bai_bone.childCount - 1 do
            local node = free_bai_bone:GetChild(i)

            local function onPointUp(go)
                local node_ani = go:GetComponent(ty.Animator)
                if node_ani ~= nil and not gs.GoUtil.IsCompNull(node_ani) then
                    node_ani:SetTrigger("up")
                end
            end

            local function onPointDown(go)
                local node_ani = go:GetComponent(ty.Animator)
                if node_ani ~= nil and not gs.GoUtil.IsCompNull(node_ani) then
                    node_ani:SetTrigger("down")
                    LoopManager:setFrameout(1, nil, function ()
                        AudioManager:playSoundEffect(string.format("arts/audio/UI/3Ddorm/ui_3Ddorm_piano_%s.prefab", go.name))
                    end)
                end
            end

            self:addFreeGqCollider(node.gameObject, gs.Vector3(0.028, 0.08, 0.03), gs.Vector3(0, -0.12, 0), onPointDown, onPointUp)
        end

        local free_hei_bone = gs.GameObject.Find("free_hei_bone").transform
        for i = 0, free_hei_bone.childCount - 1 do
            local node = free_hei_bone:GetChild(i)

            local function onPointUp()
                local node_ani = node:GetComponent(ty.Animator)
                if node_ani ~= nil and not gs.GoUtil.IsCompNull(node_ani) then
                    node_ani:SetTrigger("up")
                end
            end

            local function onPointDown()
                local node_ani = node:GetComponent(ty.Animator)
                if node_ani ~= nil and not gs.GoUtil.IsCompNull(node_ani) then
                    node_ani:SetTrigger("down")
                    LoopManager:setFrameout(1, nil, function ()
                        AudioManager:playSoundEffect(string.format("arts/audio/UI/3Ddorm/ui_3Ddorm_piano_%s.prefab", node.name))
                    end)
                end
            end

            self:addFreeGqCollider(node.gameObject, gs.Vector3(0.02, 0.1, 0.03), gs.Vector3(0, -0.05, 0), onPointDown, onPointUp)
        end

        local function gqPointUp()
            self:removeBoxColliderEventByName("modelGq")
            self:removeFreeGqCollider()

            self:closeFreeCamera()

            local param = self.FreeCamera_AniState[gs.Animator.StringToHash("ganqing_stand")]
            local lookTrans = gs.GameObject.Find(param.lookNode).transform

            self.m_freeCamera:moveToAngleTween(lookTrans.position, {x = camera_moveY, y = camera_moveX, z = 0}, self.m_freeCamera.distance, function ()
                self:addGqCollider()
                self:resumeSceneBgm(true)

                self:lockFreeCamera(false)
                self:checkFreeCamera()

            end)
        end
        self:addBoxColliderEventByName("modelGq", gs.Vector3(1.6, 0.26, 0.1), gs.Vector3(0, 0.93, 0.26), nil, gqPointUp)
    end)
end

function addFreeGqCollider(self, go, size, center, pointDown, pointUp)
    if not self.m_freeColliders then
        self.m_freeColliders = {}
    end

    if gs.Application.isEditor then
        bigHostel.BigHostelGoCollider = require("game/bigHostel/manager/BigHostelGoCollider")
    end

    local goCollider = bigHostel.BigHostelGoCollider:create(go, size, center, pointDown, pointUp)
    table.insert(self.m_freeColliders, goCollider)
end

function removeFreeGqCollider(self)
    if self.m_freeColliders then
        for _, collider in pairs(self.m_freeColliders) do
            collider:recover()
        end
        self.m_freeColliders = nil
    end

    if self.m_modelTrans then
        self.m_modelTrans:Find("4516_4_h").gameObject:SetActive(true)
        self.m_modelTrans:Find("4516_4_h_Face").gameObject:SetActive(true)
    end

    if self.m_childModelTrans then
        self.m_childModelTrans:Find("7118_h_Body").gameObject:SetActive(true)
    end
end

function removeGqCollider(self)
    self:removeBoxColliderEventByName("B4")
    self:removeBoxColliderEventByName("E5")

    self.m_gqState = nil
end

function addGqCollider(self)
    self.m_onFreeGq = false
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SWITCH_ANISTATE)

    local function addTwoInteract()
        if self.m_onFreeGq then
            return
        end

        local function onPointUp()
            self:setInt("interactive", 2)

            LoopManager:setFrameout(22, nil, function ()
                self:setInt("interactive", 0)
            end)

            self.m_gqState = self.m_gqState + 1

            self:removeBoxColliderEventByName("E5")

            self:stopMusic()
        end

        self:addBoxColliderEventByName("E5", gs.Vector3(0.028, 0.08, 0.03), gs.Vector3(0, -0.12, 0.01), nil, onPointUp, 0)
    end

    local timeOutSn = nil

    if self.m_gqState == nil then
        self:resumeSceneBgm(true)

        local function onPointUp()
            self:setInt("interactive", 1)

            timeOutSn = LoopManager:setFrameout(22, nil, function ()
                self:setInt("interactive", 0)
                addTwoInteract()
            end)

            self.m_gqState = 1

            self:removeBoxColliderEventByName("B4")

            self:stopMusic()
        end

        self:addBoxColliderEventByName("B4", gs.Vector3(0.028, 0.08, 0.03), gs.Vector3(0, -0.12, 0.01), nil, onPointUp, 0)

    else
        if self.m_gqState >= 4 then
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
        else
            addTwoInteract()
        end
    end

    self:removeBoxColliderEventByName("modelGq")

    local function gqPointUp()
        self:onFreeGq()
        self.m_onFreeGq = true
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SWITCH_ANISTATE)
    end
    self:addBoxColliderEventByName("modelGq", gs.Vector3(1.6, 0.26, 0.1), gs.Vector3(0, 0.93, 0.26), nil, gqPointUp, -1)
end

function stopMusic(self)
    AudioManager:pauseMusicByFade(0)
end

function resumeSceneBgm(self, tween)
    if tween then
        if self.m_bgmAudio ~= nil then
            self.m_bgmAudio:pauseByFade(1, function ()
                AudioManager:stopAudioSound(self.m_bgmAudio)
                self.m_bgmAudio = nil

                AudioManager:resumeMusicByFade(1)
            end)
        else
            AudioManager:resumeMusicByFade(0)
        end

    else
        if self.m_bgmAudio ~= nil then
            AudioManager:stopAudioSound(self.m_bgmAudio)
            self.m_bgmAudio = nil
        end

        AudioManager:resumeMusicByFade(0)
    end
end

function onStartShow2Frame(self)
    if self.m_startMousePos ~= nil then
        local curVal = (gs.Input.mousePosition.x - self.m_startMousePos.x) / 50
        self.m_showTime = gs.Mathf.Lerp(self.m_showTime, curVal, gs.Time.deltaTime)

        self.m_showTime = math.min(self.m_showTime, 1)
        self.m_showTime = math.max(self.m_showTime, 0)

        self:setFloat("startshow2_time", self.m_showTime)
    end
end

function onFrame(self)
    super.onFrame(self)

    local value = 100
    if self.m_curBodyShortHash ~= gs.Animator.StringToHash("qiuqiang_stand") then
        local distance = math.abs(gs.Vector3.Distance(self.sceneCameraTrans.position, self.m_childHeadTrans.position))
        if distance <= 0.745 then
            value = -1
        end
    else
        value = -1
    end

    if self.m_childModelMaterials ~= nil then
        self.m_childModelMaterials.DissolveValue2 = value
        self.m_childModelMaterials.DissolveValue3 = value
        self.m_childModelMaterials.DissolveValue4 = value
    end
end

function canSwitch(self)
    if self.m_onFreeGq == true then
        return false
    end

    for _, stateHash in pairs(self.Idle_State) do
        if self.m_curFaceShortHash == stateHash or self.m_curBodyShortHash == stateHash then
            return true
        end
    end

    return false
end

function canDisableFreeCameraReset(self)
    if self.m_onFreeGq == true then
        return false
    end

    return super.canDisableFreeCameraReset(self)
end

function setParent(self, parent)
    if self.m_parentTrans == parent then
        return
    end

    self.m_parentTrans = parent

    if self.m_modelTrans then
        gs.TransQuick:SetParentOrg(self.m_modelTrans, self.m_parentTrans)
    end

    if self.m_childModelTrans then
        gs.TransQuick:SetParentOrg(self.m_childModelTrans, self.m_parentTrans)
    end
end

function getLayIndex(self, layer_name)
    local layer_list = {
        ["body"] = 0,
        ["face"] = 1,
        ["showStart_show2"] = 2,
    }
    return layer_list[layer_name]
end

-- function playAnim(self, anim_name, time)
--     if not self.m_ani then return end

--     self.m_ani:Play(gs.Animator.StringToHash(anim_name), 0, time)
--     self.m_childAni:Play(gs.Animator.StringToHash(anim_name), 0, time)
-- end

function playHash(self, layerName, stateHash)
    if not self.m_ani then return end

    local layer = 0
    if layerName ~= nil then
        layer = self:getLayIndex(layerName)
    end

    self.m_ani:Play(stateHash, layer)
    self.m_childAni:Play(stateHash, layer)

    if self.m_qiuqianAni ~= nil and not gs.GoUtil.IsCompNull(self.m_qiuqianAni) then
        if self:aniHashState(self.m_qiuqianAni, stateHash) then
            self.m_qiuqianAni:Play(stateHash, 0)
        end
    end
end

function setLayerWeight(self, layer_name, weight)
    if not self.m_ani then return end

    local layer = self:getLayIndex(layer_name)
    self.m_ani:SetLayerWeight(layer, weight)

    if self.m_childAni then
        self.m_childAni:SetLayerWeight(layer, weight)
    end
end

function resetTrigger(self, key)
    if not self.m_ani then return end

    self.m_ani:ResetTrigger(key)

    self.m_childAni:ResetTrigger(key)

    if self.m_qiuqianAni ~= nil and not gs.GoUtil.IsCompNull(self.m_qiuqianAni) then
        self.m_qiuqianAni:ResetTrigger(key)
    end
end

function set_trigger(self, key)
    if not self.m_ani then return end

    self.m_ani:SetTrigger(key)
    self.m_childAni:SetTrigger(key)

    if self.m_qiuqianAni ~= nil and not gs.GoUtil.IsCompNull(self.m_qiuqianAni) then
        self.m_qiuqianAni:SetTrigger(key)
    end
end

function setBool(self, key, value)
    if not self.m_ani then return end

    self.m_ani:SetBool(key, value)
    self.m_childAni:SetBool(key, value)
end

function setFloat(self, key, value)
    if not self.m_ani then return end

    self.m_ani:SetFloat(key, value)
    self.m_childAni:SetFloat(key, value)
end

function setInt(self, key, value)
    if not self.m_ani then return end

    self.m_ani:SetInteger(key, value)
    self.m_childAni:SetInteger(key, value)

    if self.m_qiuqianAni ~= nil and not gs.GoUtil.IsCompNull(self.m_qiuqianAni) then
        self.m_qiuqianAni:SetInteger(key, value)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
