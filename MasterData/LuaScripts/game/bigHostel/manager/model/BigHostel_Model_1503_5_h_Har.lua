-- @FileName:   BigHostel_Model_1503_5_h_Har.lua
-- @Description: 大宿舍丽丽拉
-- @Author: ZDH
-- @Date:   2025-09-17 17:15:41
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostel_Model_1503_5_h_Har', Class.impl(bigHostel.BigHostelBaseModel))

--允许切换场景的状态
Idle_State =
{
    gs.Animator.StringToHash("LF_stand"),
    gs.Animator.StringToHash("NF_stand"),
    gs.Animator.StringToHash("NF_stand_pose1"),
    gs.Animator.StringToHash("NF_stand_pose2"),
    gs.Animator.StringToHash("NF_stand_pose3"),
    gs.Animator.StringToHash("NF_stand_pose4"),
    -- gs.Animator.StringToHash("NF_stand_pose5"),
    gs.Animator.StringToHash("NF_stand_pose6"),
    gs.Animator.StringToHash("NF_stand_pose7"),
    gs.Animator.StringToHash("NF_stand_pose8"),
    gs.Animator.StringToHash("KT_stand1"),
    gs.Animator.StringToHash("KT_stand2"),
    gs.Animator.StringToHash("KT_stand3"),
    gs.Animator.StringToHash("YS_stand1"),
    gs.Animator.StringToHash("YS_stand2"),
    gs.Animator.StringToHash("YS_stand3"),
    gs.Animator.StringToHash("YS_stand4"),
    gs.Animator.StringToHash("YS_stand5"),
    gs.Animator.StringToHash("YS_stand2_super"),
    gs.Animator.StringToHash("YS_stand3_super"),
    gs.Animator.StringToHash("YS_stand4_super"),
    gs.Animator.StringToHash("YS_stand5_super"),
}

--允许注视鼠标的动画
LookAtAniState =
{
    cameraReset_state =
    {
        gs.Animator.StringToHash("LF_stand"),
        gs.Animator.StringToHash("NF_stand"),
        gs.Animator.StringToHash("NF_stand_pose1"),
        gs.Animator.StringToHash("NF_stand_pose2"),
        gs.Animator.StringToHash("NF_stand_pose3"),
        gs.Animator.StringToHash("NF_stand_pose4"),
        gs.Animator.StringToHash("NF_stand_pose6"),
        gs.Animator.StringToHash("NF_stand_pose7"),
        gs.Animator.StringToHash("NF_stand_pose8"),
        gs.Animator.StringToHash("KT_stand1"),
        gs.Animator.StringToHash("YS_stand2"),
        gs.Animator.StringToHash("YS_stand3"),
        gs.Animator.StringToHash("YS_stand4"),
        gs.Animator.StringToHash("YS_stand5"),
    },
    cameraFree_state =
    {
        gs.Animator.StringToHash("LF_stand"),
        gs.Animator.StringToHash("NF_stand"),
        gs.Animator.StringToHash("NF_stand_pose1"),
        gs.Animator.StringToHash("NF_stand_pose2"),
        gs.Animator.StringToHash("NF_stand_pose3"),
        gs.Animator.StringToHash("NF_stand_pose4"),
        gs.Animator.StringToHash("NF_stand_pose6"),
        gs.Animator.StringToHash("NF_stand_pose7"),
        gs.Animator.StringToHash("NF_stand_pose8"),
        gs.Animator.StringToHash("KT_stand1"),
        gs.Animator.StringToHash("YS_stand2"),
        gs.Animator.StringToHash("YS_stand3"),
        gs.Animator.StringToHash("YS_stand4"),
        gs.Animator.StringToHash("YS_stand5"),
    },
}

--注视鼠标人物前的距离
-- LookAtDistance = 0.5

--状态对应的待机trigger
Idle_StateTrigger =
{
    [gs.Animator.StringToHash("showStart")] = "idle_1",
    [gs.Animator.StringToHash("LF_stand")] = "idle_1",

    [gs.Animator.StringToHash("LF_leave")] = "idle_2",

    [gs.Animator.StringToHash("NF_stand_enter")] = "idle_2",
    [gs.Animator.StringToHash("NF_stand")] = "idle_2",
    [gs.Animator.StringToHash("NF_enter")] = "idle_2",
    [gs.Animator.StringToHash("NF_stand_leave")] = "idle_2",

    [gs.Animator.StringToHash("NF_stand_pose1_enter")] = "idle_11",
    [gs.Animator.StringToHash("NF_stand_pose1")] = "idle_11",
    [gs.Animator.StringToHash("NF_stand_pose1_leave")] = "idle_11",

    [gs.Animator.StringToHash("NF_stand_pose2_enter")] = "idle_12",
    [gs.Animator.StringToHash("NF_stand_pose2")] = "idle_12",
    [gs.Animator.StringToHash("NF_stand_pose2_leave")] = "idle_12",

    [gs.Animator.StringToHash("NF_stand_pose3_enter")] = "idle_13",
    [gs.Animator.StringToHash("NF_stand_pose3")] = "idle_13",
    [gs.Animator.StringToHash("NF_stand_pose3_leave")] = "idle_13",

    [gs.Animator.StringToHash("NF_stand_pose4_enter")] = "idle_14",
    [gs.Animator.StringToHash("NF_stand_pose4")] = "idle_14",
    [gs.Animator.StringToHash("NF_stand_pose4_leave")] = "idle_14",

    -- [gs.Animator.StringToHash("NF_stand_pose5_enter")] = "idle_15",
    -- [gs.Animator.StringToHash("NF_stand_pose5")] = "idle_15",
    -- [gs.Animator.StringToHash("NF_stand_pose5_leave")] = "idle_15",

    [gs.Animator.StringToHash("NF_stand_pose6_enter")] = "idle_16",
    [gs.Animator.StringToHash("NF_stand_pose6")] = "idle_16",
    [gs.Animator.StringToHash("NF_stand_pose6_leave")] = "idle_16",

    [gs.Animator.StringToHash("NF_stand_pose7_enter")] = "idle_17",
    [gs.Animator.StringToHash("NF_stand_pose7")] = "idle_17",
    [gs.Animator.StringToHash("NF_stand_pose7_leave")] = "idle_17",

    [gs.Animator.StringToHash("NF_stand_pose8_enter")] = "idle_18",
    [gs.Animator.StringToHash("NF_stand_pose8")] = "idle_18",
    [gs.Animator.StringToHash("NF_stand_pose8_leave")] = "idle_18",

    [gs.Animator.StringToHash("KT_enter")] = "idle_3",
    [gs.Animator.StringToHash("KT_stand1_enter")] = "idle_3",
    [gs.Animator.StringToHash("KT_stand1")] = "idle_3",

    -- [gs.Animator.StringToHash("KT_stand1_leave")] = "idle_4",
    -- [gs.Animator.StringToHash("KT_stand2")] = "idle_4",

    -- [gs.Animator.StringToHash("KT_stand2_leave")] = "idle_5",
    -- [gs.Animator.StringToHash("KT_stand3")] = "idle_5",

    [gs.Animator.StringToHash("KT_stand3_leave")] = "idle_4",
    [gs.Animator.StringToHash("YS_stand1")] = "idle_4",

    [gs.Animator.StringToHash("YS_stand1_leave")] = "idle_5",
    [gs.Animator.StringToHash("YS_stand2")] = "idle_5",

    [gs.Animator.StringToHash("YS_stand2_leave")] = "idle_6",
    [gs.Animator.StringToHash("YS_stand3")] = "idle_6",

    [gs.Animator.StringToHash("YS_stand3_leave")] = "idle_7",
    [gs.Animator.StringToHash("YS_stand4")] = "idle_7",

    [gs.Animator.StringToHash("YS_stand4_leave")] = "idle_8",
    [gs.Animator.StringToHash("YS_stand5")] = "idle_8",
}

--状态对应的音效
ActionSound_list =
{
    [gs.Animator.StringToHash("showStart")] = {{res = "1503/sfx_role_1503_5_h_01.prefab", layback = 0}},
    [gs.Animator.StringToHash("LF_show")] = {{res = "1503/sfx_role_1503_5_h_02.prefab", layback = 0}},
    [gs.Animator.StringToHash("NF_enter")] = {{res = "1503/sfx_role_1503_5_h_03.prefab", layback = 0}},
    [gs.Animator.StringToHash("KT_enter")] = {{res = "1503/sfx_role_1503_5_h_04.prefab", layback = 0}},

    [gs.Animator.StringToHash("KT_stand1_twist1")] = {{res = "1503/sfx_role_1503_5_h_05.prefab", layback = 0}},
    [gs.Animator.StringToHash("KT_stand1_show")] = {{res = "1503/sfx_role_1503_5_h_07.prefab", layback = 0}},
    [gs.Animator.StringToHash("KT_stand3_show")] = {{res = "1503/sfx_role_1503_5_h_08.prefab", layback = 0}},
    [gs.Animator.StringToHash("YS_enter")] = {{res = "1503/sfx_role_1503_5_h_09.prefab", layback = 0}},
    [gs.Animator.StringToHash("YS_stand5_twist2")] =
    {
        {res = "1503/sfx_role_1503_5_h_14_1.prefab", layback = 0},
        {res = "1503/sfx_role_1503_5_h_14_2.prefab", layback = 0},
        {res = "1503/sfx_role_1503_5_h_14_3.prefab", layback = 0},
        {res = "1503/sfx_role_1503_5_h_14_4.prefab", layback = 0},
    },
    [gs.Animator.StringToHash("YS_stand2_show")] = {{res = "1503/sfx_role_1503_5_h_15.prefab", layback = 0}},
}

--需要添加自由相机的动作及参数
FreeCamera_AniState =
{
    -- 动作名、相机聚焦点、默认距离、最小距离、最大距离、横向最小角度、横向最大角度、纵向最小角度、纵向最大角度
    -- [gs.Animator.StringToHash("NF_stand_pose1")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("NF_stand_pose2")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("NF_stand_pose3")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("NF_stand_pose4")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("NF_stand_pose5")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("NF_stand_pose6")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("NF_stand_pose7")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("NF_stand_pose8")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.5, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("YS_stand2")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.3, minimumX = 0, maximumX = 160, minimumY = 300, maximumY = 400},
    -- [gs.Animator.StringToHash("YS_stand2_super")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.3, minimumX = 0, maximumX = 160, minimumY = 300, maximumY = 400},
    -- [gs.Animator.StringToHash("YS_stand3")] = {lookNode = "Look_node", minDistance = 0.36, maxDistance = 1.44, minimumX = 343, maximumX = 375, minimumY = 6, maximumY = 90},
    -- [gs.Animator.StringToHash("YS_stand3_super")] = {lookNode = "Look_node", minDistance = 0.36, maxDistance = 1.44, minimumX = 343, maximumX = 375, minimumY = 6, maximumY = 90},
    -- [gs.Animator.StringToHash("YS_stand4")] = {lookNode = "Look_node", minDistance = 0.5, maxDistance = 1.44, minimumX = 343, maximumX = 375, minimumY = -10, maximumY = 90},
    -- [gs.Animator.StringToHash("YS_stand4_super")] = {lookNode = "Look_node", minDistance = 0.5, maxDistance = 1.44, minimumX = 343, maximumX = 375, minimumY = -10, maximumY = 90},
    -- [gs.Animator.StringToHash("YS_stand5")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.3, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
    -- [gs.Animator.StringToHash("YS_stand5_super")] = {lookNode = "Look_node", minDistance = 0.78, maxDistance = 1.3, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 0},
}

---长按屏幕或者空格生成轮盘切换的场景（空为不支持该功能）
Scene_IconList =
{
    [1] = "bigHostel_sceneIcon_01",
    [2] = "bigHostel_sceneIcon_02",
    [3] = "bigHostel_sceneIcon_03",
    [4] = "bigHostel_sceneIcon_04",
    [5] = "bigHostel_sceneIcon_05",
    [6] = "bigHostel_sceneIcon_06",
    [7] = "bigHostel_sceneIcon_07",
    [8] = "bigHostel_sceneIcon_08",
    -- [9] = "bigHostel_sceneIcon_09",
    -- [10] = "bigHostel_sceneIcon_10",
}

-- --头部注视角度限制(纵向/横向为0表示不做限制)
-- LimitLookAngle = {minVertical = 0, maxVertical = 0, minHorizontal = 0, maxHorizontal = 0}

--注视鼠标的最大权重 (为 0  不开启注视鼠标)
Max_LookWeight = 1
--头部注视权重
LookAt_HeadWeight = 0.6
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

--删除
function destroy(self)
    super.destroy(self)

    self:clearDgModel()

    self.dg_model = nil

    self:clearDgInteractiveGo()
    self.m_DgState = nil
    self.m_sidePropKey = nil

    if self.m_ysInteractiveVoDic then
        for k, v in pairs(self.m_ysInteractiveVoDic) do
            v:poolRecover()
        end
    end

    self.m_ysInteractiveVoDic = nil

    self.m_bodyMaterial = nil
    self.m_siwaValue = nil
    self.m_curSiwaValue = nil
    self.m_siwaButtonUpTime = nil
    self.m_dragPos = nil
    self.m_startDragPos = nil
    self.drag_offset = nil

    self.m_muyuluGo = nil
    self.m_muyuluInitPos = nil
    self.m_muyululatePos = nil
    self.m_muyuluTargetPos = nil
    self.m_muyuluEgg = nil
    self.m_firemuyulu = nil

    self.m_glassMaterial = nil

    self.m_faceValue = nil
    self.m_faceMaterial = nil

    self:setCursorVisible(true)

    bigHostel.BigHostelManager:setSceneProps(nil)
    bigHostel.BigHostelManager:clearUIComponentShowState()

    self:remove3DAudioListener()
end

function loadFinish(self)
    super.loadFinish(self)

    self:add3DAudioListener()

    self.m_ysInteractiveVoDic = {}

    local bodyGo = gs.GameObject.Find("1503_5_h_Body")
    if bodyGo ~= nil and not gs.GoUtil.IsGoNull(bodyGo) then
        local materials = bodyGo:GetComponent(ty.SkinnedMeshRenderer).materials
        for i = 0, materials.Length do
            if string.find(materials[i].name, "Body") then
                self.m_bodyMaterial = materials[i]
                break
            end
        end

        if self.m_bodyMaterial ~= nil then
            self.m_siwaValue = self.m_bodyMaterial:GetFloat("_AreaFadeValue")
            self.m_curSiwaValue = self.m_siwaValue
        end
    end

    local face_node = gs.GameObject.Find("1503_5_h_Face")
    if face_node and not gs.GoUtil.IsGoNull(face_node) then
        local skinnedMeshRenderer = face_node:GetComponent(ty.SkinnedMeshRenderer)

        for i = 0, skinnedMeshRenderer.materials.Length do
            if string.find(skinnedMeshRenderer.materials[i].name, "Face") then
                self.m_faceMaterial = skinnedMeshRenderer.materials[i]
                self.m_minfaceValue = self.m_faceMaterial:GetFloat("_BlushIntensity")
                self.m_curfaceValue = self.m_minfaceValue
                break
            end
        end
    end

    local glassModel = gs.GameObject.Find("modeBoli")
    if not gs.GoUtil.IsGoNull(glassModel) then
        local renderer = glassModel:GetComponent(ty.MeshRenderer)
        if not gs.GoUtil.IsCompNull(renderer) then
            self.m_glassMaterial = renderer.materials[0]
        end
    end

    if self.m_glassAlphaValue == nil then
        self.m_glassAlphaValue = self.m_glassMaterial:GetFloat("_AlphaFactor")
    end
end

function onMainUIShow(self)
    self:saveMainSceneInfo()
    bigHostel.BigHostelManager:setIsCanInteract(true)

    self:add3DAudioListener()
end

function onOtherUIOpen(self)
    self:onStopCv()
    self:onSwitchIdle()
    GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
    self:remove3DAudioListener()
end

function addEventListener(self)
    super.addEventListener(self)

end

function removeEventListener(self)
    super.removeEventListener(self)

end

function onFrameEventCall(self, param)
    super.onFrameEventCall(self, param)

end

function onAnimaBodyStateSwitch(self, stateHash)
    super.onAnimaBodyStateSwitch(self, stateHash)

    ------------------------------------------------------------分镜1
    if stateHash == gs.Animator.StringToHash("LF_stand") then
        local function onPointUp()
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
        end

        self:addBoxColliderEventByName("Bip001 Head", gs.Vector3(0.1, 0.1, 0.1), nil, nil, onPointUp)
    else
        self:removeBoxColliderEventByName("Bip001 Head")
    end

    ------------------------------------------------------------分镜2
    if stateHash == gs.Animator.StringToHash("NF_enter") then
        self:setInt("enter_2", 1)
    end

    local list =
    {
        gs.Animator.StringToHash("NF_stand"),
        gs.Animator.StringToHash("NF_stand_pose1"),
        gs.Animator.StringToHash("NF_stand_pose2"),
        gs.Animator.StringToHash("NF_stand_pose3"),
        gs.Animator.StringToHash("NF_stand_pose4"),
        -- gs.Animator.StringToHash("NF_stand_pose5"),
        gs.Animator.StringToHash("NF_stand_pose6"),
        gs.Animator.StringToHash("NF_stand_pose7"),
        gs.Animator.StringToHash("NF_stand_pose8"),

    }

    local show = false
    for k, hash in pairs(list) do
        if self.m_curBodyShortHash == hash then
            show = true
            break
        end
    end

    bigHostel.BigHostelManager:setUIComponentShowState({key = "mBtnPos", val = show, call = function ()
        GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_POSEUI)
    end})

    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)

    if stateHash == gs.Animator.StringToHash("NF_stand") then
        self:setInt("nf_pose", 99)
    end

    ------------------------------------------------------------分镜3
    if stateHash == gs.Animator.StringToHash("KT_enter") then
        self:setInt("enter_3", 1)
    end

    if stateHash == gs.Animator.StringToHash("KT_stand1") or stateHash == gs.Animator.StringToHash("KT_enter") or stateHash == gs.Animator.StringToHash("KT_stand1_enter") then
        if self.dg_model == nil or gs.GoUtil.IsTransNull(self.dg_model) then
            local Environment = gs.GameObject.Find("Environment")
            self.dg_model = Environment.transform:Find("interact/modelDG")
            self.dg_model.gameObject:SetActive(true)

            self.m_DGCMColliderList = {}
            local cm_node = self.dg_model:Find("cm_node").transform
            self.m_cmCount = cm_node.childCount
            for i = 0, cm_node.childCount - 1 do
                local cm_model = cm_node:GetChild(i)
                self:addBoxColliderEventByGo(cm_model.gameObject, gs.Vector3(0.05, 0.1, 0.05), nil, nil, nil, -1)
                table.insert(self.m_DGCMColliderList, cm_model.gameObject)
            end

            self.m_DGNyColliderList = {}
            local ny_node = self.dg_model:Find("ny_node").transform

            self.m_nyCount = ny_node.childCount
            for i = 0, ny_node.childCount - 1 do
                local ny_model = ny_node:GetChild(i)
                self:addBoxColliderEventByGo(ny_model.gameObject, gs.Vector3(0.1, 0.1, 0.1), nil, nil, nil, -1)
                table.insert(self.m_DGNyColliderList, ny_model.gameObject)
            end
        end
    end

    if stateHash ~= gs.Animator.StringToHash("KT_stand1")
        and stateHash ~= gs.Animator.StringToHash("KT_stand1_twist1")
        and stateHash ~= gs.Animator.StringToHash("KT_stand1_twist2")
        and stateHash ~= gs.Animator.StringToHash("KT_enter")
        and stateHash ~= gs.Animator.StringToHash("KT_stand1_enter")
        and stateHash ~= gs.Animator.StringToHash("KT_stand1_leave")
        and stateHash ~= gs.Animator.StringToHash("KT_stand1_show") then

        if self.dg_model == nil or gs.GoUtil.IsTransNull(self.dg_model) then
            local Environment = gs.GameObject.Find("Environment")
            self.dg_model = Environment.transform:Find("interact/modelDG")
        end
        if self.dg_model ~= nil and not gs.GoUtil.IsTransNull(self.dg_model) then
            self.dg_model.gameObject:SetActive(false)
            self.dg_model = nil
        end

        self:clearDgModel()
    end

    ------------------------------------------------------------分镜4
    if stateHash == gs.Animator.StringToHash("YS_enter") then
        self:setInt("enter_4", 1)
    end

    if stateHash == gs.Animator.StringToHash("YS_stand1") or stateHash == gs.Animator.StringToHash("YS_stand1_cold")or stateHash == gs.Animator.StringToHash("YS_stand1_hot")or stateHash == gs.Animator.StringToHash("YS_stand1_Keek") then
        bigHostel.BigHostelManager:setUIComponentShowState({key = "1503_5_YS", val = true})
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)
    else
        bigHostel.BigHostelManager:setUIComponentShowState({key = "1503_5_YS", val = false})
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOWUICOMPONENT)

        if self.m_glassAlphaValue ~= nil then
            self.m_glassMaterial:SetFloat("_AlphaFactor", self.m_glassAlphaValue)
        end
    end

    ---二阶段
    if stateHash ~= gs.Animator.StringToHash("YS_stand2_twist") and stateHash ~= gs.Animator.StringToHash("YS_stand2_super") and stateHash ~= gs.Animator.StringToHash("YS_stand2") then
        self:clearYsInteractiveVo("YS_stand2")
    end

    if stateHash == gs.Animator.StringToHash("YS_stand2_twist") then
        if self.m_ysInteractiveVoDic["YS_stand2"] then
            self.m_ysInteractiveVoDic["YS_stand2"]:checkStand()
        end
    end

    -- --岛主推车彩蛋
    -- if stateHash == gs.Animator.StringToHash("YS_stand2") or stateHash == gs.Animator.StringToHash("YS_stand2_super") then
    --     if self.m_muyuluGo == nil or not gs.GoUtil.IsGoNull(self.m_muyuluGo) then
    --         local function onPointDown()
    --             if self.m_DgState == nil then
    --                 self.m_DragQuadDic["Ys_stand2_muyulu"]:SetActive(true)

    --                 self.m_muyululatePos = self.m_muyuluGo.transform.position
    --             end
    --         end

    --         local function onPointUp()
    --             if self.m_DgState == nil then
    --                 self.m_DragQuadDic["Ys_stand2_muyulu"]:SetActive(false)

    --                 self.m_startDragPos = nil
    --                 self.drag_offset = gs.Vector3(0, 0, 0)

    --                 if math.abs(gs.Vector3.Distance(self.m_muyuluTargetPos, self.m_muyuluGo.transform.position)) <= 0.05 then
    --                     self.m_muyuluEgg = true
    --                 end
    --             end
    --         end

    --         self.m_muyuluGo = gs.GameObject.Find("muyulu01")
    --         if self.m_muyuluInitPos == nil then
    --             self.m_muyuluInitPos = self.m_muyuluGo.transform.position
    --         end
    --         self.m_muyululatePos = self.m_muyuluGo.transform.position

    --         local targetGo = gs.GameObject.Find("muyuluCollider")
    --         self.m_muyuluTargetPos = targetGo.transform.position

    --         self:addBoxColliderEventByName("muyulu01", gs.Vector3(0.07, 0.2, 0.07), gs.Vector3(0, 0.1, 0), onPointDown, onPointUp, -1)
    --     end
    -- elseif stateHash ~= gs.Animator.StringToHash("YS_stand2_show") and stateHash ~= gs.Animator.StringToHash("YS_stand2_twist") then
    --     if self.m_muyuluGo ~= nil and not gs.GoUtil.IsGoNull(self.m_muyuluGo) then
    --         self.m_muyuluGo.transform.position = self.m_muyuluInitPos

    --         self.m_muyuluGo = nil
    --         self.m_muyuluInitPos = nil
    --         self.m_muyululatePos = nil

    --         self.m_muyuluTargetPos = nil

    --         self.m_muyuluEgg = nil
    --         self.m_firemuyulu = nil

    --         self:removeBoxColliderEventByName("muyulu01")
    --     end
    -- end

    ---三阶段
    if stateHash ~= gs.Animator.StringToHash("YS_stand3") and stateHash ~= gs.Animator.StringToHash("YS_stand3_twist") and stateHash ~= gs.Animator.StringToHash("YS_stand3_super") then
        self:clearYsInteractiveVo("YS_stand3")
    end

    if stateHash == gs.Animator.StringToHash("YS_stand3_twist") then
        if self.m_ysInteractiveVoDic["YS_stand3"] then
            self.m_ysInteractiveVoDic["YS_stand3"]:checkStand()
        end
    end

    if stateHash == gs.Animator.StringToHash("YS_stand3") then
        --通用拖拽左脚
        local drag_bones =
        {
            BigHostelConst.FullBodyBipedEffector.LeftFoot,
        }

        local limit = {min_x = -0.02, max_x = 0.15, min_z = 0, max_z = 0.02}
        self:addIKDragVo("Ys_stand3_L_Foot", self.m_FBBIK.references.leftFoot.gameObject, {x = 0.1, y = 0.1, z = 0.1}, self.m_DragQuadDic["Ys_stand3_L_Foot"], drag_bones, nil, nil, nil, limit, 8)

        --添加临时拖拽右膝盖
        local function onPointDown()
            if self.m_DgState ~= nil then
                return
            end

            self.m_rightCalfPos = self.m_FBBIK.references.rightCalf.position

            if self.m_tempIKGo == nil or gs.GoUtil.IsGoNull(self.m_tempIKGo) then
                self.m_tempIKGo = gs.GameObject("R CalfBendGoal")
            end
            self.m_tempIKGo.transform.position = self.m_rightCalfPos

            self.m_FBBIK.solver.rightLegChain.bendConstraint.bendGoal = self.m_tempIKGo.transform
            self.m_FBBIK.solver.rightLegChain.bendConstraint.weight = 0.8

            self.m_DragQuadDic["Ys_stand3_R_Calf"]:SetActive(true)
        end

        local function onPointUp()
            if self.m_DgState ~= nil then
                return
            end

            self.m_startDragPos = nil
            self.drag_offset = gs.Vector3(0, 0, 0)

            self.m_DragQuadDic["Ys_stand3_R_Calf"]:SetActive(false)
        end

        self:addBoxColliderEventByName("Bip001 R Calf", gs.Vector3(0.1, 0.1, 0.1), nil, onPointDown, onPointUp)
    else
        self:recoverIKDragVo("Ys_stand3_L_Foot")
        self:removeBoxColliderEventByName("Bip001 R Calf")

        if self.m_tempIKGo and not gs.GoUtil.IsGoNull(self.m_tempIKGo) then
            gs.GameObject.Destroy(self.m_tempIKGo)
            self.m_tempIKGo = nil
        end

        self.m_FBBIK.solver.rightLegChain.bendConstraint.weight = 0
    end

    ---四阶段
    if stateHash ~= gs.Animator.StringToHash("YS_stand4") and stateHash ~= gs.Animator.StringToHash("YS_stand4_twist") and stateHash ~= gs.Animator.StringToHash("YS_stand4_super") then
        self:clearYsInteractiveVo("YS_stand4")
    end

    if stateHash == gs.Animator.StringToHash("YS_stand4_twist") then
        if self.m_ysInteractiveVoDic["YS_stand4"] then
            self.m_ysInteractiveVoDic["YS_stand4"]:checkStand()
        end
    end

    ---五阶段
    if stateHash ~= gs.Animator.StringToHash("YS_stand5") and stateHash ~= gs.Animator.StringToHash("YS_stand5_twist1") and stateHash ~= gs.Animator.StringToHash("YS_stand5_super") then
        self:clearYsInteractiveVo("YS_stand5")
    end

    if stateHash == gs.Animator.StringToHash("YS_stand5_twist1") then
        if self.m_ysInteractiveVoDic["YS_stand5"] then
            self.m_ysInteractiveVoDic["YS_stand5"]:checkStand()
        end
    end

    -----------------------------------------------------------重置交互参数----------------------------------------------------------------------------------
    if stateHash == gs.Animator.StringToHash("KT_stand1_twist1") or stateHash == gs.Animator.StringToHash("KT_stand1_twist2")
        or stateHash == gs.Animator.StringToHash("KT_stand2_twist") or stateHash == gs.Animator.StringToHash("KT_stand3_twist")
        or stateHash == gs.Animator.StringToHash("YS_stand5_twist2") or stateHash == gs.Animator.StringToHash("YS_stand1_cold")
        or stateHash == gs.Animator.StringToHash("YS_stand1_hot") or stateHash == gs.Animator.StringToHash("YS_stand1_Keek") then
        self:setInt("interactive", 0)
    end

    -----------------------------------------------------------给身体添加交互碰撞
    if stateHash == gs.Animator.StringToHash("YS_stand2") or stateHash == gs.Animator.StringToHash("YS_stand2_super") or stateHash == gs.Animator.StringToHash("YS_stand2_twist")
        or stateHash == gs.Animator.StringToHash("YS_stand3") or stateHash == gs.Animator.StringToHash("YS_stand3_super") or stateHash == gs.Animator.StringToHash("YS_stand3_twist")
        or stateHash == gs.Animator.StringToHash("YS_stand4") or stateHash == gs.Animator.StringToHash("YS_stand4_super") or stateHash == gs.Animator.StringToHash("YS_stand4_twist")
        or stateHash == gs.Animator.StringToHash("YS_stand5") or stateHash == gs.Animator.StringToHash("YS_stand5_super") or stateHash == gs.Animator.StringToHash("YS_stand5_twist1") or stateHash == gs.Animator.StringToHash("YS_stand5_twist2") then
        -- self.m_curSiwaValue = self.m_siwaValue

        local function onPointDown()
            if stateHash == gs.Animator.StringToHash("YS_stand5") and self.m_DgState == nil then
                self:setInt("interactive", 3)
            end

            if stateHash == gs.Animator.StringToHash("YS_stand2") or stateHash == gs.Animator.StringToHash("YS_stand2_super") or stateHash == gs.Animator.StringToHash("YS_stand2_twist") then
                if self.m_muyuluEgg and self.m_DgState == 4 then
                    self.m_firemuyulu = true
                end
            end
        end
        self:addCapsuleColliderEventByName("Bip001 Pelvis", 0.13, 0.35, gs.Vector3(0.01, 0, 0), BigHostelConst.CapsuleColliderDic.z, onPointDown, nil, -1)
    else
        self:removeCapsuleColliderEventByName("Bip001 Pelvis")

        -- if self.m_bodyMaterial then
        --     self.m_bodyMaterial:SetFloat("_AreaFadeValue", self.m_siwaValue)
        -- end

        -- self.m_curSiwaValue = nil
    end

    if stateHash == gs.Animator.StringToHash("KT_stand2") or stateHash == gs.Animator.StringToHash("KT_stand2_twist") then
        local function onPointDown()
            if stateHash == gs.Animator.StringToHash("KT_stand2_twist") then
                return
            end

            if self.m_DgState == 1 then
                self:setInt("interactive", 1)
            end
        end
        self:addCapsuleColliderEventByName("Bip001 Spine1", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, -1, true)
    elseif stateHash == gs.Animator.StringToHash("KT_stand3")or stateHash == gs.Animator.StringToHash("KT_stand3_twist") then
        local function onPointDown()
            if stateHash == gs.Animator.StringToHash("KT_stand3_twist") then
                return
            end

            if self.m_DgState == 1 then
                self:setInt("interactive", 1)
            end
        end
        self:addCapsuleColliderEventByName("Bip001 Spine1", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, -1, true)
    elseif stateHash == gs.Animator.StringToHash("YS_stand2") or stateHash == gs.Animator.StringToHash("YS_stand2_super") or stateHash == gs.Animator.StringToHash("YS_stand2_twist") then --浴室二阶段
        local function onPointDown()
            if stateHash == gs.Animator.StringToHash("YS_stand2_twist") then
                return
            end

            if self.m_DgState == 3 or self.m_DgState == 4 or self.m_DgState == 5 then
                local vo = self.m_ysInteractiveVoDic["YS_stand2"]
                if vo == nil then
                    self:createYsInteractiveVo("YS_stand2", 3)
                end
                vo = self.m_ysInteractiveVoDic["YS_stand2"]
                vo:interactive()
                -- vo:clearTimer()

                if self.m_muyuluEgg and self.m_DgState == 4 then
                    self.m_firemuyulu = true
                end

                if self.m_muyuluEgg and self.m_firemuyulu and self.m_DgState == 5 then
                    vo:resetCount()
                    self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
                else
                    self:setInt("interactive", 1)
                end
            end
        end
        self:addCapsuleColliderEventByName("Bip001 Spine1", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, -1, true)
    elseif stateHash == gs.Animator.StringToHash("YS_stand3") or stateHash == gs.Animator.StringToHash("YS_stand3_super") or stateHash == gs.Animator.StringToHash("YS_stand3_twist") then --浴室三阶段
        local function onPointDown()
            if stateHash == gs.Animator.StringToHash("YS_stand3_twist") then
                return
            end

            if self.m_DgState == 3 or self.m_DgState == 4 or self.m_DgState == 5 then
                local vo = self.m_ysInteractiveVoDic["YS_stand3"]
                if vo == nil then
                    self:createYsInteractiveVo("YS_stand3", 3)
                end
                vo = self.m_ysInteractiveVoDic["YS_stand3"]
                vo:interactive()
                -- vo:clearTimer()

                self:setInt("interactive", 1)
            end
        end
        self:addCapsuleColliderEventByName("Bip001 Spine1", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, -1, true)
    elseif stateHash == gs.Animator.StringToHash("YS_stand4") or stateHash == gs.Animator.StringToHash("YS_stand4_super") or stateHash == gs.Animator.StringToHash("YS_stand4_twist") then --浴室四阶段
        local function onPointDown()
            if stateHash == gs.Animator.StringToHash("YS_stand4_twist") then
                return
            end

            if self.m_DgState == 3 or self.m_DgState == 4 or self.m_DgState == 5 then
                local vo = self.m_ysInteractiveVoDic["YS_stand4"]
                if vo == nil then
                    self:createYsInteractiveVo("YS_stand4", 3, 6, 15)
                end
                vo = self.m_ysInteractiveVoDic["YS_stand4"]
                vo:interactive()
                -- vo:clearTimer()

                self:setInt("interactive", 1)
            end
        end
        self:addCapsuleColliderEventByName("Bip001 Spine1", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, -1, true)
    elseif stateHash == gs.Animator.StringToHash("YS_stand5") or stateHash == gs.Animator.StringToHash("YS_stand5_super")
        or stateHash == gs.Animator.StringToHash("YS_stand5_twist1") or stateHash == gs.Animator.StringToHash("YS_stand5_twist2") then --浴室五阶段
        local function onPointDown()
            if stateHash == gs.Animator.StringToHash("YS_stand5_twist1") or stateHash == gs.Animator.StringToHash("YS_stand5_twist2") then
                return
            end

            if self.m_DgState == 3 or self.m_DgState == 4 or self.m_DgState == 5 then
                local vo = self.m_ysInteractiveVoDic["YS_stand5"]
                if vo == nil then
                    self:createYsInteractiveVo("YS_stand5", 3)
                end
                vo = self.m_ysInteractiveVoDic["YS_stand5"]
                vo:interactive()
                -- vo:clearTimer()

                self:setInt("interactive", 1)
            end
        end
        self:addCapsuleColliderEventByName("Bip001 Spine1", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, -1, true)
    else
        self:removeCapsuleColliderEventByName("Bip001 Spine1")
    end

    -----------------------------------------------------------添加侧边道具栏-----------------------------------------------------
    if stateHash == gs.Animator.StringToHash("KT_stand1") or stateHash == gs.Animator.StringToHash("KT_stand1_twist1") or stateHash == gs.Animator.StringToHash("KT_stand1_twist2") then
        local data =
        {
            key = "KT_stand1",
            list =
            {
                [1] =
                {
                    icon = "arts/ui/pack/bigHostel/bigHostel_icon_01.png",
                    state = 1,
                    clickCall = function ()
                        if self.m_DgState ~= 1 then
                            self.m_DgState = 1
                        else
                            self.m_DgState = nil
                        end

                        self:creatDgInteractiveGo()

                        return self.m_DgState
                    end,
                },
                [2] =
                {
                    icon = "arts/ui/pack/bigHostel/bigHostel_icon_02.png",
                    state = 2,
                    clickCall = function ()
                        if self.m_DgState ~= 2 then
                            self.m_DgState = 2
                        else
                            self.m_DgState = nil
                        end

                        self:creatDgInteractiveGo()

                        return self.m_DgState
                    end,
                },
            },
        }
        self:dispatchSideProp(data)
    elseif stateHash == gs.Animator.StringToHash("KT_stand2") or stateHash == gs.Animator.StringToHash("KT_stand2_twist")
        or stateHash == gs.Animator.StringToHash("KT_stand3") or stateHash == gs.Animator.StringToHash("KT_stand3_twist") then
        local data =
        {
            key = "KT_stand2",
            list =
            {
                [1] =
                {
                    icon = "arts/ui/pack/bigHostel/bigHostel_icon_01.png",
                    state = 1,
                    clickCall = function ()
                        if self.m_DgState ~= 1 then
                            self.m_DgState = 1
                        else
                            self.m_DgState = nil
                        end

                        self:creatDgInteractiveGo()

                        return self.m_DgState
                    end,
                },
            },
        }

        if stateHash == gs.Animator.StringToHash("KT_stand3") or stateHash == gs.Animator.StringToHash("KT_stand3_twist") then
            data.key = "KT_stand3"
        end

        self:dispatchSideProp(data)
    elseif stateHash == gs.Animator.StringToHash("YS_stand2") or stateHash == gs.Animator.StringToHash("YS_stand2_twist")or stateHash == gs.Animator.StringToHash("YS_stand2_super")
        or stateHash == gs.Animator.StringToHash("YS_stand3") or stateHash == gs.Animator.StringToHash("YS_stand3_twist") or stateHash == gs.Animator.StringToHash("YS_stand3_super")
        or stateHash == gs.Animator.StringToHash("YS_stand4") or stateHash == gs.Animator.StringToHash("YS_stand4_twist") or stateHash == gs.Animator.StringToHash("YS_stand4_super")
        or stateHash == gs.Animator.StringToHash("YS_stand5") or stateHash == gs.Animator.StringToHash("YS_stand5_twist1") or stateHash == gs.Animator.StringToHash("YS_stand5_super") then
        local data =
        {
            key = "YS_stand2",
            list =
            {
                [1] =
                {
                    icon = "arts/ui/pack/bigHostel/bigHostel_icon_04.png",
                    state = 3,
                    clickCall = function ()
                        if self.m_DgState ~= 3 then
                            self.m_DgState = 3
                        else
                            self.m_DgState = nil
                        end

                        self:creatDgInteractiveGo()

                        return self.m_DgState
                    end,
                },
                [2] =
                {
                    icon = "arts/ui/pack/bigHostel/bigHostel_icon_03.png",
                    state = 4,
                    clickCall = function ()
                        if self.m_DgState ~= 4 then
                            self.m_DgState = 4
                        else
                            self.m_DgState = nil
                        end

                        self:creatDgInteractiveGo()

                        return self.m_DgState
                    end,
                },
                [3] =
                {
                    icon = "arts/ui/pack/bigHostel/bigHostel_icon_05.png",
                    state = 5,
                    clickCall = function ()
                        if self.m_DgState ~= 5 then
                            self.m_DgState = 5
                        else
                            self.m_DgState = nil
                        end

                        self:creatDgInteractiveGo()

                        return self.m_DgState
                    end,
                },
            },
        }

        if stateHash == gs.Animator.StringToHash("YS_stand3") or stateHash == gs.Animator.StringToHash("YS_stand3_twist") or stateHash == gs.Animator.StringToHash("YS_stand3_super") then
            data.key = "YS_stand3"
        elseif stateHash == gs.Animator.StringToHash("YS_stand4") or stateHash == gs.Animator.StringToHash("YS_stand4_twist") or stateHash == gs.Animator.StringToHash("YS_stand4_super") then
            data.key = "YS_stand4"
        elseif stateHash == gs.Animator.StringToHash("YS_stand5") or stateHash == gs.Animator.StringToHash("YS_stand5_twist1") or stateHash == gs.Animator.StringToHash("YS_stand5_super") then
            data.key = "YS_stand5"
        end

        self:dispatchSideProp(data)
    else
        self:clearDgInteractiveGo()
        self.m_DgState = nil

        self.m_sidePropKey = nil

        bigHostel.BigHostelManager:setSceneProps(nil)
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOW_SCENEPROPSLIST)
    end

    -----------------------------------------------------------添加特效---------------------------------
    if self.m_effect then
        self:removeEffect(self.m_effect.m_snId)
    end

    local efx_path = ""
    if stateHash == gs.Animator.StringToHash("KT_stand1_show") then
        efx_path = "fx_KT_stand1_show"
    elseif stateHash == gs.Animator.StringToHash("showStart") then
        efx_path = "fx_showstart"
    elseif stateHash == gs.Animator.StringToHash("YS_stand1_cold") then
        efx_path = "fx_YS_stand1_cold"
    elseif stateHash == gs.Animator.StringToHash("YS_stand1_hot") then
        efx_path = "fx_YS_stand1_hot"
    elseif stateHash == gs.Animator.StringToHash("YS_stand2_show") then
        efx_path = "fx_YS_stand2_show"
    elseif stateHash == gs.Animator.StringToHash("YS_stand4_show") then
        efx_path = "fx_YS_stand4_show"
    elseif stateHash == gs.Animator.StringToHash("LF_enter") then
        efx_path = "fx_LF_enter"
    elseif stateHash == gs.Animator.StringToHash("NF_enter") then
        efx_path = "fx_NF_enter"
    elseif stateHash == gs.Animator.StringToHash("KT_enter") then
        efx_path = "fx_KT_enter"
    elseif stateHash == gs.Animator.StringToHash("KT_stand3_show") then
        efx_path = "fx_KT_stand3_show"
    elseif stateHash == gs.Animator.StringToHash("LF_show") then
        efx_path = "fx_LF_show"
    elseif stateHash == gs.Animator.StringToHash("YS_stand2_super") or stateHash == gs.Animator.StringToHash("YS_stand3_super") or stateHash == gs.Animator.StringToHash("YS_stand4_super")or stateHash == gs.Animator.StringToHash("YS_stand5_super") then
        efx_path = "fx_YS_super"
    end

    if not string.NullOrEmpty(efx_path) then
        local cameraNode = gs.GoUtil.FindNameInChilds(self.m_model.transform, "Camera_node")
        self.m_effect = self:addEffect(string.format("arts/fx/3d/sceneModule/3Dhostel/1503_5_h/%s.prefab", efx_path), cameraNode)
        self.m_effect:setParent(self.m_camera.transform)
    end
end

function createYsInteractiveVo(self, key, switchStandCount, showCount, checkTime)
    local vo = {}
    vo.interactiveCount = 0
    vo.switchStandCount = switchStandCount
    vo.showCount = showCount
    vo.checkTime = checkTime or 5
    vo.interactive = function (_vo)
        _vo.interactiveCount = _vo.interactiveCount + 1

        if _vo.showCount ~= nil then
            if _vo.interactiveCount >= _vo.showCount then
                _vo:resetCount()
                self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            end
        end
    end
    vo.resetCount = function (_vo)
        _vo.interactiveCount = 0
        self:setInt("interactive", 0)
    end
    vo.checkStand = function (_vo)
        if _vo.interactiveCount <= _vo.switchStandCount then
            self:setInt("interactive", 0)
        else
            self:setInt("interactive", 2)

            local interactiveCount = _vo.interactiveCount

            _vo:clearTimer()
            _vo.timerSn = LoopManager:setTimeout(_vo.checkTime, nil, function ()
                if interactiveCount == _vo.interactiveCount then
                    _vo.interactiveCount = 0
                    self:setInt("interactive", 0)
                end
            end)
        end
    end

    vo.clearTimer = function (_vo)
        if _vo.timerSn then
            LoopManager:clearTimeout(_vo.timerSn)
            _vo.timerSn = nil
        end
    end

    vo.poolRecover = function (_vo)
        _vo.interactiveCount = nil
        _vo:clearTimer()
    end

    self.m_ysInteractiveVoDic[key] = vo
end

function clearYsInteractiveVo(self, key)
    if self.m_ysInteractiveVoDic[key] ~= nil then
        self.m_ysInteractiveVoDic[key]:poolRecover()
        self.m_ysInteractiveVoDic[key] = nil
    end
end

--修改玻璃的透明度
function setGlassAlpha(self, val)
    if self.m_glassMaterial ~= nil then
        self.m_glassMaterial:SetFloat("_AlphaFactor", val)
    end

    if val <= 0.5 then
        if self.m_curBodyShortHash ~= gs.Animator.StringToHash("YS_stand1_Keek") then
            self:setInt("interactive", 3)
        end
    end
end

function getGlassAlpha(self)
    if self.m_glassMaterial ~= nil then
        return self.m_glassMaterial:GetFloat("_AlphaFactor")
    end

    return 0
end

--通知侧边道具栏显示隐藏
function dispatchSideProp(self, data)
    if self.m_sidePropKey == data.key then
        return
    end

    self:clearDgInteractiveGo()
    self.m_DgState = nil

    bigHostel.BigHostelManager:setSceneProps(data)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOW_SCENEPROPSLIST)

    self.m_sidePropKey = data.key
end

function clearDgModel(self)
    self:clearNyCollider()
    self:clearCmCollider()

    self.m_cmCount = nil
    self.m_nyCount = nil
end

function clearNyCollider(self)
    if not table.empty(self.m_DGNyColliderList) then
        for _, go in pairs(self.m_DGNyColliderList) do
            self:removeBoxColliderEventByGo(go)
        end

        self.m_DGNyColliderList = nil
    end
end

function clearCmCollider(self)
    if not table.empty(self.m_DGCMColliderList) then
        for _, go in pairs(self.m_DGCMColliderList) do
            self:removeBoxColliderEventByGo(go)
        end

        self.m_DGCMColliderList = nil
    end
end

function checkDGShow1(self)
    if self.m_cmCount <= 0 and self.m_nyCount <= 0 then
        self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
        return true
    end
    return false
end

function creatDgInteractiveGo(self)
    self:clearDgInteractiveGo()

    if self.m_DgState == 1 then--蛋糕裱花
        self.m_interactiveGo = gs.ResMgr:LoadGO("arts/sceneModule/3d_hostel_dynamic/biaohua/modelBH.prefab")
    elseif self.m_DgState == 2 then--蛋糕草莓
        self.m_interactiveGo = gs.ResMgr:LoadGO("arts/sceneModule/3d_hostel_dynamic/caomei/mocelZS_3.prefab")
    elseif self.m_DgState == 3 then --浴室第二阶段花洒
        self.m_interactiveGo = gs.ResMgr:LoadGO("arts/sceneModule/3d_hostel_dynamic/huasha/modelhuasha.prefab")
    elseif self.m_DgState == 4 then --浴室第二阶段沐浴露
        self.m_interactiveGo = gs.ResMgr:LoadGO("arts/sceneModule/3d_hostel_dynamic/muyulu/muyulu.prefab")
    elseif self.m_DgState == 5 then --浴室第二阶段水枪
        self.m_interactiveGo = gs.ResMgr:LoadGO("arts/sceneModule/3d_hostel_dynamic/zishuiqiang/modelZSQ.prefab")
    end

    if self.m_interactiveGo ~= nil and not gs.GoUtil.IsGoNull(self.m_interactiveGo) then
        self.m_interactiveGo.transform.position = self.m_FBBIK.references.spine[1].position + gs.Vector3(0, 0.2, 0)
        self.m_interactiveGo.transform:LookAt(self.m_FBBIK.references.spine[1])
    end
end

function clearDgInteractiveGo(self)
    if self.m_interactiveGo ~= nil and not gs.GoUtil.IsGoNull(self.m_interactiveGo) then
        gs.GameObject.Destroy(self.m_interactiveGo)
        self.m_interactiveGo = nil
    end
end

function onFrame(self)
    super.onFrame(self)

    --脸红功能
    if self.m_faceMaterial then
        if self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand2_super") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand3_super")
            or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand4_super")or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand5_super") then
            self.m_curfaceValue = self.m_curfaceValue + gs.Time.deltaTime
        else
            self.m_curfaceValue = self.m_curfaceValue - gs.Time.deltaTime
        end
        self.m_curfaceValue = gs.Mathf.Clamp(self.m_curfaceValue, self.m_minfaceValue, 1)
        self.m_faceMaterial:SetFloat("_BlushIntensity", self.m_curfaceValue)
    end

    --拖动沐浴露
    if self.m_DragQuadDic["Ys_stand2_muyulu"].activeInHierarchy then
        local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Event", 500)
        if hitInfo and hitInfo.collider then
            if hitInfo.collider.gameObject.name == "Ys_stand2_muyulu" then
                if self.m_startDragPos == nil then
                    self.m_startDragPos = hitInfo.point
                end

                self.drag_offset = hitInfo.point - self.m_startDragPos
                self.m_muyuluGo.transform.position = self.m_muyululatePos + self.drag_offset
            end
        end
    end

    --临时拖拽右膝盖
    if self.m_tempIKGo and not gs.GoUtil.IsGoNull(self.m_tempIKGo) then
        local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Event", 500)
        if hitInfo and hitInfo.collider then
            if hitInfo.collider.gameObject.name == "Ys_stand3_R_Calf" then
                if self.m_startDragPos == nil then
                    self.m_startDragPos = hitInfo.point
                end

                local limit = {min_x = -0.13, max_x = 0, min_y = -0.01, max_y = 0, min_z = 0, max_z = 0.02}

                local offset = hitInfo.point - self.m_startDragPos
                local limit_x = offset.x
                limit_x = gs.Mathf.Clamp(offset.x, limit.min_x, limit.max_x)

                local limit_y = offset.y
                limit_y = gs.Mathf.Clamp(offset.y, limit.min_y, limit.max_y)

                local limit_z = offset.z
                limit_z = gs.Mathf.Clamp(offset.z, limit.min_z, limit.max_z)

                self.drag_offset = gs.Vector3(limit_x, limit_y, limit_z)
            end
        end

        self.m_dragPos = gs.Vector3.Lerp(self.m_dragPos, self.drag_offset, gs.Time.deltaTime * 8)

        if self.m_dragPos ~= gs.VEC3_ZERO then
            self.m_tempIKGo.transform.position = self.m_rightCalfPos + self.m_dragPos
        end

        if self.m_startDragPos == nil then
            self.m_FBBIK.solver.rightLegChain.bendConstraint.weight = self.m_FBBIK.solver.rightLegChain.bendConstraint.weight - gs.Time.deltaTime
        end
    end

    --使用道具处理
    local isRayNy, isRotate = nil, nil
    if self.m_DgState == nil then
        self:setCursorVisible(true)
    else
        --蛋糕的交互
        if self.m_curBodyShortHash == gs.Animator.StringToHash("KT_stand1") or self.m_curBodyShortHash == gs.Animator.StringToHash("KT_stand1_twist1") or self.m_curBodyShortHash == gs.Animator.StringToHash("KT_stand1_twist2") then
            local pos = self.m_camera:ScreenToWorldPoint(gs.Vector3(gs.Input.mousePosition.x, gs.Input.mousePosition.y, 1.3))
            self.m_interactiveGo.transform.position = pos

            if self.m_DgState == 1 then--蛋糕裱花
                self.m_interactiveGo.transform.localEulerAngles = gs.Vector3(40, 50, 0)
            elseif self.m_DgState == 2 then--蛋糕草莓
                self.m_interactiveGo.transform.localEulerAngles = gs.VEC3_ZERO
            end

            if self.m_DgState == 1 then
                if gs.Input.GetMouseButton(0) then
                    ----点奶油
                    local hitInfo_1 = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Physics_Move", 1.4)
                    if (hitInfo_1 ~= nil and hitInfo_1.collider ~= nil) then
                        local animator = hitInfo_1.collider.gameObject:GetComponent(ty.Animator)
                        if not AnimatorUtil.isPlayAni(animator, "NY_up") then
                            animator:Play("NY_up")

                            self.m_nyCount = self.m_nyCount - 1
                            if self.m_nyCount <= 0 then
                                self:setInt("interactive", 2)
                            end

                            self:checkDGShow1()

                            if self.m_nyCount <= 0 then
                                self:clearNyCollider()
                            end
                        end

                        if self.dg_model ~= nil then
                            self.dg_model.localEulerAngles = self.dg_model.localEulerAngles + gs.Vector3(0, 50 * gs.Time.deltaTime, 0)
                        end

                        isRayNy = true
                    end
                end
            elseif self.m_DgState == 2 then
                if gs.Input.GetMouseButtonDown(0) then
                    ----放草莓
                    local hitInfo_1 = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Drag_floor", 3)
                    if (hitInfo_1 ~= nil and hitInfo_1.collider ~= nil) then
                        local animator = hitInfo_1.collider.gameObject:GetComponent(ty.Animator)
                        if not AnimatorUtil.isPlayAni(animator, "CM_up") then
                            animator:Play("CM_up")

                            self.m_cmCount = self.m_cmCount - 1

                            self:setInt("interactive", 1)
                            self:checkDGShow1()

                            if self.m_cmCount <= 0 then
                                self:clearCmCollider()
                            end
                        end
                    end
                end
            end
        else
            local showCursor = true
            if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count <= 1 then
                local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Role", 100)
                if (hitInfo ~= nil and hitInfo.collider ~= nil) then
                    self.m_interactiveGo.transform:LookAt(hitInfo.collider.transform)
                    self.m_interactiveGo.transform.position = hitInfo.point

                    showCursor = false

                    -- ---淋丝袜
                    -- if gs.Input.GetMouseButton(0) then
                    --     if self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand2") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand3") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand4")or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand5") then
                    --         if self.m_DgState == 3 or self.m_DgState == 5 then
                    --             if hitInfo.collider.gameObject.name == "Bip001 Pelvis" then
                    --                 --拿花洒喷丝袜
                    --                 if self.m_bodyMaterial then
                    --                     self.m_curSiwaValue = self.m_curSiwaValue + gs.Time.deltaTime
                    --                     self.m_curSiwaValue = gs.Mathf.Clamp(self.m_curSiwaValue, self.m_siwaValue, 1)

                    --                     self.m_bodyMaterial:SetFloat("_AreaFadeValue", self.m_curSiwaValue)

                    --                     self.m_siwaButtonUpTime = nil
                    --                 end
                    --             end
                    --         end
                    --     end
                    -- end
                end
            end
            self:setCursorVisible(showCursor)
        end

        if gs.Input.GetMouseButtonDown(0) then
            local showEffect = true
            if self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand2") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand2_twist")or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand2_super")
                or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand3") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand3_twist") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand3_super")
                or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand4") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand4_twist") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand4_super")
                or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand5") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand5_twist1") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand5_super") then

                local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Role", 100)
                if (hitInfo == nil or not hitInfo.collider) then
                    showEffect = false
                end
            end

            if showEffect then
                local effect_path = ""
                local audio_path = ""
                if self.m_DgState == 1 then
                    effect_path = "fx_modelBH.prefab"
                    audio_path = "sfx_role_1503_5_h_06"
                elseif self.m_DgState == 3 then
                    effect_path = "fx_huasa.prefab"
                    audio_path = "sfx_role_1503_5_h_11"
                elseif self.m_DgState == 4 then
                    effect_path = "fx_muyulu.prefab"
                    audio_path = "sfx_role_1503_5_h_12"
                elseif self.m_DgState == 5 then
                    effect_path = "fx_modelZSQ.prefab"
                    audio_path = "sfx_role_1503_5_h_13"
                end

                if not string.NullOrEmpty(effect_path) then
                    local parent = self.m_interactiveGo.transform:Find("mesh/fx_node")
                    local effect = self:addEffect("arts/fx/3d/sceneModule/3Dhostel/1503_5_h/" .. effect_path, parent, 3)
                    effect.m_go.transform:SetParent(nil)
                end

                if not string.NullOrEmpty(audio_path) then
                    AudioManager:playSoundEffect("arts/audio/sfx/1503/" .. audio_path .. ".prefab")
                end
            end
        end
    end

    --丝袜恢复
    -- if self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand2") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand3") or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand4")or self.m_curBodyShortHash == gs.Animator.StringToHash("YS_stand5") then
    if not gs.Input.GetMouseButton(0) then
        if not self.m_siwaButtonUpTime then
            self.m_siwaButtonUpTime = gs.Time.time
        else
            if gs.Time.time - self.m_siwaButtonUpTime >= 1 then
                self.m_curSiwaValue = self.m_curSiwaValue - gs.Time.deltaTime
                self.m_curSiwaValue = gs.Mathf.Clamp(self.m_curSiwaValue, self.m_siwaValue, 1)
                self.m_bodyMaterial:SetFloat("_AreaFadeValue", self.m_curSiwaValue)
            end
        end
    end
    -- end

    --旋转蛋糕
    if self.m_curBodyShortHash == gs.Animator.StringToHash("KT_stand1") or self.m_curBodyShortHash == gs.Animator.StringToHash("KT_stand1_twist1") or self.m_curBodyShortHash == gs.Animator.StringToHash("KT_stand1_twist2") then
        if self.dg_model ~= nil and not self.m_disableFreeCamera then
            if gs.Input.GetMouseButton(0) then
                if not isRayNy then
                    if self.m_clickPosX ~= nil then
                        local diff = self.m_clickPosX - gs.Input.mousePosition.x
                        self.dg_model.localEulerAngles = self.dg_model.localEulerAngles + gs.Vector3(0, diff * gs.Time.deltaTime * 5, 0)
                        if diff ~= 0 then
                            self.m_clickPosX = gs.Input.mousePosition.x

                            isRotate = true
                        end
                    end

                    self.m_clickPosX = gs.Input.mousePosition.x
                end
            else
                self.m_clickPosX = nil
            end
        end
    end

    if self.m_curBodyShortHash == gs.Animator.StringToHash("KT_stand1") and (self.m_DgState == 2 or self.m_DgState == 1) then
        self.m_canInteract = false
    else
        if isRayNy == true or isRotate == true then
            self.m_canInteract = false
        else
            self.m_canInteract = true
        end
    end
end

function remove3DAudioListener(self)
    -----特殊处理 AuidoListener 组件
    local launchGo = gs.GameObject.Find("GameLaunch")
    if launchGo and not gs.GoUtil.IsGoNull(launchGo) then
        local AudioListener = launchGo.gameObject:GetComponent(ty.AudioListener)
        if AudioListener == nil or gs.GoUtil.IsCompNull(AudioListener) then
            launchGo:AddComponent(ty.AudioListener)
        end
    end
    gs.GameObject.Destroy(gs.CameraMgr:GetToScreenSceneCamera():GetComponent(ty.AudioListener))
end

function add3DAudioListener(self)
    -----特殊处理 AuidoListener 组件
    local launchGo = gs.GameObject.Find("GameLaunch")
    if launchGo and not gs.GoUtil.IsGoNull(launchGo) then
        gs.GameObject.Destroy(launchGo:GetComponent(ty.AudioListener))
    end

    local AudioListener = self.m_camera.gameObject:GetComponent(ty.AudioListener)
    if AudioListener == nil or gs.GoUtil.IsCompNull(AudioListener) then
        self.m_camera.gameObject:AddComponent(ty.AudioListener)
    end
end

function setCursorVisible(self, value)
    if not gs.ApplicationUtil.IsPC() then
        return
    end

    CS.UnityEngine.Cursor.visible = value
end

function set_trigger(self, key)
    super.set_trigger(self, key)

    if key == BigHostelConst.BaseAnimatorParams.Switch then
        self:setInt("nf_pose", 0)
        self:set_trigger("leave")
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
