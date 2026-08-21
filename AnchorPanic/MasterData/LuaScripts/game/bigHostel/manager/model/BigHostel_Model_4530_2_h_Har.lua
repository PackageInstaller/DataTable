-- @FileName:   BigHostel_Model_4530_2_h_Har.lua
-- @Description:   大宿舍红叶模型
-- @Author: ZDH
-- @Date:   2025-04-21 18:17:45
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostel_Model_4530_2_h_Har', Class.impl(bigHostel.BigHostelBaseModel))

--允许切换场景的状态
Idle_State = {

    gs.Animator.StringToHash("WT_idle01"),
    gs.Animator.StringToHash("WT_idle02"),
    -- gs.Animator.StringToHash("HYS_idle"),

    gs.Animator.StringToHash("SZT_idle01"),
    gs.Animator.StringToHash("SZT_idle02"),

    gs.Animator.StringToHash("XQS_idle01"),
    gs.Animator.StringToHash("XQS_idle02"),
    gs.Animator.StringToHash("XQS_idle03"),
}

--允许注视鼠标的动画
LookAtAniState =
{
    cameraReset_state =
    {
        gs.Animator.StringToHash("SZT_idle01"),
        gs.Animator.StringToHash("SZT_idle02"),
        gs.Animator.StringToHash("WT_idle01"),
        gs.Animator.StringToHash("WT_idle02"),
        gs.Animator.StringToHash("XQS_idle01"),
        gs.Animator.StringToHash("XQS_idle02"),
        gs.Animator.StringToHash("XQS_idle03"),
    },
    cameraFree_state =
    {
        gs.Animator.StringToHash("SZT_idle01"),
        gs.Animator.StringToHash("SZT_idle02"),
        gs.Animator.StringToHash("WT_idle01"),
        gs.Animator.StringToHash("WT_idle02"),
        gs.Animator.StringToHash("XQS_idle01"),
        gs.Animator.StringToHash("XQS_idle02"),
        gs.Animator.StringToHash("XQS_idle03"),
    },
}
--注视鼠标人物前的距离
LookAtDistance = 0.5

--状态对应的待机trigger
Idle_StateTrigger = {
    [gs.Animator.StringToHash("showStart")] = "idle_1",
    [gs.Animator.StringToHash("WT_enter")] = "idle_1",
    [gs.Animator.StringToHash("WT_idle01")] = "idle_1",
    [gs.Animator.StringToHash("WT_idle02")] = "idle_1",
    [gs.Animator.StringToHash("WT_show")] = "idle_1",
    [gs.Animator.StringToHash("WT_twist01")] = "idle_1",
    [gs.Animator.StringToHash("WT_twist02")] = "idle_1",

    [gs.Animator.StringToHash("WT_leave01")] = "idle_2",
    [gs.Animator.StringToHash("WT_leave02")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_enter01")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_enter02")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_idle")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_show")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_twist01")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_twist02")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_twist03")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_twist04")] = "idle_2",
    -- [gs.Animator.StringToHash("HYS_twist05")] = "idle_2",

    -- [gs.Animator.StringToHash("HYS_leave")] = "idle_3",
    [gs.Animator.StringToHash("SZT_enter01")] = "idle_2",
    [gs.Animator.StringToHash("SZT_enter02")] = "idle_2",
    [gs.Animator.StringToHash("SZT_enter03")] = "idle_2",
    [gs.Animator.StringToHash("SZT_idle01")] = "idle_2",
    [gs.Animator.StringToHash("SZT_idle02")] = "idle_2",
    [gs.Animator.StringToHash("SZT_show01")] = "idle_2",
    [gs.Animator.StringToHash("SZT_show02")] = "idle_2",
    [gs.Animator.StringToHash("SZT_twist01")] = "idle_2",
    [gs.Animator.StringToHash("SZT_twist02")] = "idle_2",
    [gs.Animator.StringToHash("SZT_twist03")] = "idle_2",
    [gs.Animator.StringToHash("SZT_twist04")] = "idle_2",

    [gs.Animator.StringToHash("SZT_leave01")] = "idle_3",
    [gs.Animator.StringToHash("SZT_leave02")] = "idle_3",
    [gs.Animator.StringToHash("SZT_leave03")] = "idle_3",
    [gs.Animator.StringToHash("XQS_enter01")] = "idle_3",
    [gs.Animator.StringToHash("XQS_enter02")] = "idle_3",
    [gs.Animator.StringToHash("XQS_idle01")] = "idle_3",
    [gs.Animator.StringToHash("XQS_idle02")] = "idle_3",
    [gs.Animator.StringToHash("XQS_idle03")] = "idle_3",
    [gs.Animator.StringToHash("XQS_show")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist01")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist02")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist02_01")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist03")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist04")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist04_01")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist05")] = "idle_3",
    [gs.Animator.StringToHash("XQS_twist06")] = "idle_3",

    [gs.Animator.StringToHash("XQS_leave02")] = "idle_1",
    [gs.Animator.StringToHash("XQS_leave02")] = "idle_1",
    [gs.Animator.StringToHash("XQS_leave01")] = "idle_1",
}

--状态对应的音效
ActionSound_list = {
    [gs.Animator.StringToHash("showStart")] = {{res = "4530/sfx_role_4530_2_h_01.prefab", layback = 0}},
    [gs.Animator.StringToHash("WT_twist01")] = {{res = "4530/sfx_role_4530_2_h_02.prefab", layback = 0}},
    [gs.Animator.StringToHash("WT_twist02")] = {{res = "4530/sfx_role_4530_2_h_03.prefab", layback = 0}},
    [gs.Animator.StringToHash("WT_show")] = {{res = "4530/sfx_role_4530_2_h_04.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("HYS_enter01")] = {{res = "4530/sfx_role_4530_2_h_05.prefab", layback = 0}},
    -- [gs.Animator.StringToHash("HYS_show")] = {{res = "4530/sfx_role_4530_2_h_06.prefab", layback = 0}},
    [gs.Animator.StringToHash("SZT_enter01")] = {{res = "4530/sfx_role_4530_2_h_07.prefab", layback = 0}},
    [gs.Animator.StringToHash("SZT_show01")] = {{res = "4530/sfx_role_4530_2_h_08.prefab", layback = 0}},
    [gs.Animator.StringToHash("SZT_show02")] = {{res = "4530/sfx_role_4530_2_h_09.prefab", layback = 0}},
    [gs.Animator.StringToHash("XQS_twist02_01")] = {{res = "4530/sfx_role_4530_2_h_11.prefab", layback = 0}},
    [gs.Animator.StringToHash("XQS_twist02")] = {{res = "4530/sfx_role_4530_2_h_11.prefab", layback = 0}},
    [gs.Animator.StringToHash("XQS_twist04")] = {{res = "4530/sfx_role_4530_2_h_12.prefab", layback = 3216}},
    -- [gs.Animator.StringToHash("XQS_show")] = {{res = "4530/sfx_role_4530_2_h_13.prefab", layback = 0}},
    [gs.Animator.StringToHash("XQS_enter01")] = {{res = "4530/sfx_role_4530_2_h_14.prefab", layback = 0}},
}

--需要添加自由相机的动作及参数
FreeCamera_AniState =
{
    -- 动作名、相机聚焦点、默认距离、最小距离、最大距离、横向最小角度、横向最大角度、纵向最小角度、纵向最大角度
    -- [gs.Animator.StringToHash("HYS_idle")] = {lookNode = "Look_node", minDistance = 0.9, maxDistance = 1.5, minimumX = 250, maximumX = 320, minimumY = 0, maximumY = 70},
    -- [gs.Animator.StringToHash("SZT_idle01")] = {lookNode = "Look_node", minDistance = 1.2, maxDistance = 1.8, minimumX = 60, maximumX = 100, minimumY = 320, maximumY = 340},
    -- [gs.Animator.StringToHash("SZT_idle02")] = {lookNode = "Look_node", minDistance = 0.5, maxDistance = 1.2, minimumX = 70, maximumX = 150, minimumY = 0, maximumY = 75},
    -- [gs.Animator.StringToHash("WT_idle01")] = {lookNode = "Look_node", minDistance = 0.437, maxDistance = 1.3, minimumX = 180, maximumX = 400, minimumY = 11, maximumY = 90},
    -- [gs.Animator.StringToHash("WT_idle02")] = {lookNode = "Look_node", minDistance = 0.437, maxDistance = 1.3, minimumX = 180, maximumX = 400, minimumY = 0, maximumY = 90},
    -- [gs.Animator.StringToHash("XQS_idle01")] = {lookNode = "Look_node", minDistance = 0, maxDistance = 10, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 60},
    -- [gs.Animator.StringToHash("XQS_idle02")] = {lookNode = "Look_node", minDistance = 0, maxDistance = 10, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 60},
    -- [gs.Animator.StringToHash("XQS_idle03")] = {lookNode = "Look_node", minDistance = 0, maxDistance = 10, minimumX = 0, maximumX = 0, minimumY = 0, maximumY = 60},
}

Scene_IconList =
{
    [1] = "bigHostel_sceneIcon_01",
    [2] = "bigHostel_sceneIcon_02",
    [3] = "bigHostel_sceneIcon_03",
    -- [4] = "bigHostel_sceneIcon_04",
}

--注视鼠标的最大权重 (为 0  不开启注视鼠标)
Max_LookWeight = 1
--头部注视权重
LookAt_HeadWeight = 0.5
--眼部注视权重
LookAt_eyeWeight = 1

--注视鼠标的速度
LookAtSpeed = 3

-- --头部注视角度限制(纵向/横向为0表示不做限制)
--LimitLookAngle = {minVertical = 30, maxVertical = 45, minHorizontal = 0, maxHorizontal = 0}

--动作需要添加的特效
FrameAddEffect =
{
    [gs.Animator.StringToHash("showStart")] =
    {
        {name = "fx_showStart", node = "[RESOLUTION_CAMERA]"},
    },

    [gs.Animator.StringToHash("WT_twist01")] =
    {
        {name = "fx_WT_twist01_beizi", node = "Root_node"},
    },

    [gs.Animator.StringToHash("WT_twist02")] =
    {
        {name = "fx_WT_twist02_beizi", node = "Root_node"},
    },

    [gs.Animator.StringToHash("WT_show")] =
    {
        {name = "fx_WT_show", node = "[RESOLUTION_CAMERA]"},
        {name = "fx_WT_show_beizi", node = "Root_node"},
    },
    -- [gs.Animator.StringToHash("HYS_enter01")] =
    -- {
    --     {name = "fx_HYS_enter01", node = "[RESOLUTION_CAMERA]"},
    -- },
    -- [gs.Animator.StringToHash("HYS_show")] =
    -- {
    --     {name = "fx_HYS_show", node = "[RESOLUTION_CAMERA]"},
    -- },
    [gs.Animator.StringToHash("SZT_enter01")] =
    {
        {name = "fx_SZT_enter01", node = "[RESOLUTION_CAMERA]"},
    },
    -- [gs.Animator.StringToHash("SZT_show01")] =
    -- {
    --     {name = "fx_SZT_show01", node = "[RESOLUTION_CAMERA]"},
    -- },
    -- [gs.Animator.StringToHash("SZT_show02")] =
    -- {
    --     {name = "fx_SZT_show02", node = "[RESOLUTION_CAMERA]"},
    -- },

    [gs.Animator.StringToHash("XQS_enter01")] =
    {
        {name = "fx_XQS_enter01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("XQS_twist01")] =
    {
        {name = "fx_XQS_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("XQS_twist03")] =
    {
        {name = "fx_XQS_twist01", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("XQS_twist05")] =
    {
        {name = "fx_XQS_twist01", node = "[RESOLUTION_CAMERA]"},
    },

    [gs.Animator.StringToHash("XQS_twist02")] =
    {
        {name = "fx_XQS_twist02", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("XQS_twist04")] =
    {
        {name = "fx_XQS_twist02", node = "[RESOLUTION_CAMERA]"},
    },
    [gs.Animator.StringToHash("XQS_twist06")] =
    {
        {name = "fx_XQS_twist02", node = "[RESOLUTION_CAMERA]"},
    },

    -- [gs.Animator.StringToHash("XQS_show")] =
    -- {
    --     {name = "fx_XQS_show", node = "[RESOLUTION_CAMERA]"},
    -- },
}

--删除
function destroy(self)
    super.destroy(self)

    self.m_lastPhysicsAni = nil
    self.m_tictactoeAIDiff = nil
    self.m_chessIndex = nil

    self.m_boardNode = nil
    self.boardDic = nil

    self.m_WTTwistCount = nil

    self:clearPropGo()
    bigHostel.BigHostelManager:setSceneProps(nil)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOW_SCENEPROPSLIST)

    self.m_lateClickTime = nil
    self.m_SZT01Twist01 = nil
    self.m_SZT01Twist02 = nil

    self.m_SZT02Twist01 = nil
    self.m_SZT02Twist02 = nil
    self.m_SZT02hitType = nil

    -- self:clearHYSModel()
end

function loadFinish(self)
    self.m_faceValue = 0

    super.loadFinish(self)

    local node = gs.GameObject.Find("4530_2_h_Face")
    if node and not gs.GoUtil.IsGoNull(node) then
        local skinnedMeshRenderer = node:GetComponent(ty.SkinnedMeshRenderer)

        for i = 0, skinnedMeshRenderer.materials.Length - 1 do
            if string.find(skinnedMeshRenderer.materials[i].name, "Face") then
                self.m_faceMaterial = skinnedMeshRenderer.materials[i]
                break
            end
        end
    end
end

function addEventListener(self)
    super.addEventListener(self)

end

function removeEventListener(self)
    super.removeEventListener(self)

end

function onOtherUIOpen(self)
    super.onOtherUIOpen(self)

    self.m_tictactoeAIDiff = nil
    self.m_chessIndex = nil
end

function onSwitchIdle(self)
    super.onSwitchIdle(self)

end

function onAnimaBodyStateSwitch(self, stateHash)
    super.onAnimaBodyStateSwitch(self, stateHash)

    -------------------第一分镜
    if stateHash == gs.Animator.StringToHash("WT_idle01") then
        local function onPointDown()
            if self.m_WTTwistCount == nil then
                self.m_WTTwistCount = 0
            end
            self.m_WTTwistCount = self.m_WTTwistCount + 1

            if self.m_WTTwistCount < 3 then
                self:setInt("twist", 1)
            else
                self:setInt("twist", 2)
            end
        end

        self:setInt("twist", 0)

        self:addBoxColliderEventByName("ld105_01_chapan01 (2)", gs.Vector3(0.8, 0.2, 0.5), gs.Vector3(0, 0, 0), onPointDown, onPointUp)
    elseif stateHash == gs.Animator.StringToHash("WT_idle02") then
        local function onPointDown()
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            self.m_WTTwistCount = nil
        end

        self:addBoxColliderEventByName("ld105_01_chapan01 (2)", gs.Vector3(0.8, 0.2, 0.5), gs.Vector3(0, 0, 0), onPointDown, onPointUp)
    else
        self:removeCapsuleColliderEventByName("ld105_01_chapan01 (2)")
    end

    --制空
    if stateHash ~= gs.Animator.StringToHash("WT_idle01") and stateHash ~= gs.Animator.StringToHash("WT_idle02") and
        stateHash ~= gs.Animator.StringToHash("WT_twist01") and stateHash ~= gs.Animator.StringToHash("WT_twist02") and
        stateHash ~= gs.Animator.StringToHash("WT_show") then
        self.m_WTTwistCount = nil
    end

    -------------------第二分镜
    -- if stateHash == gs.Animator.StringToHash("HYS_enter01") then
    --     self:setInt("enter_HYS", 1)
    -- end

    -- if stateHash == gs.Animator.StringToHash("HYS_idle") then
    --     if not self.m_HYSModel then
    --         self.m_HYSModel = {}

    --         local str = {"HL01", "SL01", "SL02", "SL03", "SL04"}
    --         for _, modelName in pairs(str) do
    --             local go = gs.ResMgr:LoadGO(string.format("arts/sceneModule/3d_hostel_dynamic/%s/model%s.prefab", modelName, modelName))
    --             local parent = gs.GameObject.Find(modelName)
    --             if parent ~= nil and go ~= nil then
    --                 gs.TransQuick:SetParentOrg(go.transform, parent.transform)
    --                 go.transform:Find("mesh").gameObject:SetActive(false)
    --                 go.transform:Find(modelName).gameObject:SetActive(false)

    --                 self.m_HYSModel[modelName] = go
    --             end
    --         end
    --     end

    --     if self.m_twistHysDic == nil then
    --         self.m_twistHysDic = {}
    --     end

    --     local function onPointDown_01()
    --         self:onClickHYSTwist(2)
    --         self:showHYSModel("HL01")
    --     end
    --     self:addCapsuleColliderEventByName("Bip001 Pelvis", 0.1, 0.3, nil, BigHostelConst.CapsuleColliderDic.z, onPointDown_01)

    --     local function onPointDown_02()
    --         self:onClickHYSTwist(1)
    --         self:showHYSModel("SL04")
    --     end
    --     self:addCapsuleColliderEventByName("Bip001 L Thigh", 0.08, 0.4, gs.Vector3(-0.18, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown_02)

    --     local function onPointDown_03()
    --         self:onClickHYSTwist(3)
    --         self:showHYSModel("SL03")
    --     end
    --     self:addCapsuleColliderEventByName("Bip001 R Thigh", 0.08, 0.4, gs.Vector3(-0.18, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown_03)

    --     local function onPointDown_04()
    --         self:onClickHYSTwist(5)
    --         self:showHYSModel("SL02")
    --     end
    --     self:addCapsuleColliderEventByName("Bone001_l", 0.06, 0.25, nil, BigHostelConst.CapsuleColliderDic.x, onPointDown_04)

    --     local function onPointDown_04()
    --         self:onClickHYSTwist(4)
    --         self:showHYSModel("SL01")
    --     end
    --     self:addCapsuleColliderEventByName("Bone001_r", 0.06, 0.25, nil, BigHostelConst.CapsuleColliderDic.x, onPointDown_04)

    --     self:setInt("twist", 0)
    -- else
    --     self:removeCapsuleColliderEventByName("Bip001 Pelvis")
    --     self:removeCapsuleColliderEventByName("Bip001 L Thigh")
    --     self:removeCapsuleColliderEventByName("Bip001 R Thigh")
    --     self:removeCapsuleColliderEventByName("Bone001_l")
    --     self:removeCapsuleColliderEventByName("Bone001_r")
    -- end

    -- if stateHash ~= gs.Animator.StringToHash("HYS_idle") and
    --     stateHash ~= gs.Animator.StringToHash("HYS_leave") and
    --     stateHash ~= gs.Animator.StringToHash("HYS_show") and
    --     stateHash ~= gs.Animator.StringToHash("HYS_twist01") and
    --     stateHash ~= gs.Animator.StringToHash("HYS_twist02") and
    --     stateHash ~= gs.Animator.StringToHash("HYS_twist03") and
    --     stateHash ~= gs.Animator.StringToHash("HYS_twist04") and
    --     stateHash ~= gs.Animator.StringToHash("HYS_twist05") then
    --     self:clearHYSModel()
    -- end

    -------------------第三分镜
    if stateHash == gs.Animator.StringToHash("SZT_enter01") then
        self:setInt("enter_SZT", 1)
    end

    if stateHash == gs.Animator.StringToHash("SZT_idle01")or stateHash == gs.Animator.StringToHash("SZT_twist01") or stateHash == gs.Animator.StringToHash("SZT_twist02") then
        self:showProp(1)
    elseif stateHash == gs.Animator.StringToHash("SZT_idle02") or stateHash == gs.Animator.StringToHash("SZT_twist03") or stateHash == gs.Animator.StringToHash("SZT_twist04") then
        self:showProp(2)
    else
        self:clearPropGo()
        bigHostel.BigHostelManager:setSceneProps(nil)
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOW_SCENEPROPSLIST)
    end

    if stateHash == gs.Animator.StringToHash("SZT_idle01") or stateHash == gs.Animator.StringToHash("SZT_idle02") or
        self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist01") or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist02")
        or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist03") or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist04") then
        self:checkSpineCollider()
    else
        self:recoverIKDragVo("SZT_idle01")
        self:removeCapsuleColliderEventByName("Bip001 R Calf")

        self:removeCapsuleColliderEventByName("Bip001 Spine2")
        self:removeCapsuleColliderEventByName("Bip001 Head")
    end

    if stateHash == gs.Animator.StringToHash("SZT_twist01") then
        if self.m_SZT01Twist01 and self.m_SZT01Twist02 then
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
        end
    end

    if stateHash == gs.Animator.StringToHash("SZT_show01")or
        (stateHash ~= gs.Animator.StringToHash("SZT_twist01") and stateHash ~= gs.Animator.StringToHash("SZT_twist02") and stateHash ~= gs.Animator.StringToHash("SZT_idle01")) then
        self.m_SZT01Twist01 = nil
        self.m_SZT01Twist02 = nil
    end

    if stateHash == gs.Animator.StringToHash("SZT_twist03") or stateHash == gs.Animator.StringToHash("SZT_twist04") then
        if self.m_SZT02Twist01 and self.m_SZT02Twist02 then
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
        end
    end

    if stateHash == gs.Animator.StringToHash("SZT_show02")or
        (stateHash ~= gs.Animator.StringToHash("SZT_twist03") and stateHash ~= gs.Animator.StringToHash("SZT_twist04") and stateHash ~= gs.Animator.StringToHash("SZT_idle02")) then
        self.m_SZT02Twist01 = nil
        self.m_SZT02Twist02 = nil
    end

    if stateHash == gs.Animator.StringToHash("SZT_idle01") or stateHash == gs.Animator.StringToHash("SZT_idle02") then
        self:setInt("twist", 0)
    end

    -------------------第四分镜
    if stateHash == gs.Animator.StringToHash("XQS_enter01") then
        self:setInt("enter_XQS", 1)
    end

    if stateHash == gs.Animator.StringToHash("XQS_idle01") then
        self:initTictactoe()
    elseif stateHash == gs.Animator.StringToHash("XQS_idle02") then
        self:initTictactoe()
    elseif stateHash == gs.Animator.StringToHash("XQS_idle03") then
        self:initTictactoe()

        if self.m_chessIndex > 5 then
            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            self.m_chessIndex = nil
        end
    else
        self:removeTictactoeCollider()
    end

    --离开下棋重置当前关卡难度
    local inXQS = false
    local hash = {"XQS_enter01", "XQS_enter02", "XQS_idle01", "XQS_idle02", "XQS_idle03", "XQS_show", "XQS_twist01", "XQS_twist02", "XQS_twist02_01", "XQS_twist03", "XQS_twist04", "XQS_twist04_01", "XQS_twist05", "XQS_twist06", }
    for k, ha in pairs(hash) do
        if stateHash == gs.Animator.StringToHash(ha) then
            inXQS = true
            break
        end
    end

    if inXQS == false then
        self.m_chessIndex = nil
        self:resetTictactoe()
    end

    if stateHash == gs.Animator.StringToHash("XQS_twist01") or stateHash == gs.Animator.StringToHash("XQS_twist02") or
        stateHash == gs.Animator.StringToHash("XQS_twist02_01") or stateHash == gs.Animator.StringToHash("XQS_twist04_01") or
        stateHash == gs.Animator.StringToHash("XQS_twist03") or stateHash == gs.Animator.StringToHash("XQS_twist04") or
        stateHash == gs.Animator.StringToHash("XQS_twist05") or stateHash == gs.Animator.StringToHash("XQS_twist06") then
        self:setInt("twist", 0)
    end
end

function saveMainSceneInfo(self)
    local t =
    {
        "XQS_idle02",
        "XQS_idle03",
        "XQS_leave01",
        "XQS_leave02",
        "XQS_leave03",
        "XQS_show",
        "XQS_twist01",
        "XQS_twist02",
        "XQS_twist02_01",
        "XQS_twist03",
        "XQS_twist04",
        "XQS_twist04_01",
        "XQS_twist05",
        "XQS_twist06",
    }

    for k, v in pairs(t) do
        if self.m_curBodyShortHash == gs.Animator.StringToHash(v) then
            return
        end
    end

    super.saveMainSceneInfo(self)
end

function onFrame(self)
    super.onFrame(self)

    ----第三分镜
    if (self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_idle01") or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist01") or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist02")or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_idle02")or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist03") or self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_twist04"))
        and self.m_propState == 1 then

        local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Role", 1.4)
        if (hitInfo ~= nil and hitInfo.collider ~= nil) then
            self.m_interactiveGo.transform:LookAt(hitInfo.collider.transform)
            self.m_interactiveGo.transform.position = hitInfo.point

            if gs.Input.GetMouseButtonDown(0) then
                local parent = self.m_interactiveGo.transform:Find("fx_node")
                local effect = self:addEffect("arts/fx/3d/sceneModule/3Dhostel/4530_2_h/fx_maobi.prefab", parent, 3)
                effect.m_go.transform:SetParent(nil)
            end
        end
    end

    if self.m_SZTDragDown then
        if self.m_faceValue < 1 then
            self.m_faceValue = self.m_faceValue + gs.Time.deltaTime
        end
    else
        if self.m_faceValue > 0 then
            self.m_faceValue = self.m_faceValue - gs.Time.deltaTime
        end
    end

    self.m_faceMaterial:SetFloat("_BlushIntensity", self.m_faceValue)

    ----下棋
    if self.m_curBodyShortHash == gs.Animator.StringToHash("XQS_idle01") or self.m_curBodyShortHash == gs.Animator.StringToHash("XQS_idle02") or self.m_curBodyShortHash == gs.Animator.StringToHash("XQS_idle03") then
        if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count < 2 then
            local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Physics_Move", 3)
            if (hitInfo ~= nil and hitInfo.collider ~= nil) then
                local animator = hitInfo.collider.gameObject:GetComponent(ty.Animator)
                if animator ~= nil and not gs.GoUtil.IsCompNull(animator) then
                    if self.m_lastPhysicsAni and self.m_lastPhysicsAni ~= animator then
                        self.m_lastPhysicsAni:Play(gs.Animator.StringToHash("OX_Empty"), 0)
                        self.m_lastPhysicsAni = nil
                    end

                    if not AnimatorUtil.isPlayAni(animator, "OX_XSelect") and gs.ApplicationUtil.IsPC() then
                        animator:Play(gs.Animator.StringToHash("OX_XSelect"), 0)
                    end

                    if gs.Input.GetMouseButtonUp(0) and bigHostel.BigHostelManager:getDisableFreeCameraReset() ~= true then
                        if self.m_lastPhysicsAni == animator then
                            local strArr = string.split(hitInfo.collider.gameObject.name, "_")
                            self:putChess(tonumber(strArr[1]), tonumber(strArr[2]), 1)

                            if self:checkWin(1) then --检查自己是否胜利
                                if self.m_chessIndex <= 3 then
                                    self:setInt("twist", 10 + self.m_chessIndex)
                                else
                                    self:setInt("twist", 1)
                                end
                                -- logAll("玩家赢了-----------")

                                self.m_chessIndex = self.m_chessIndex + 1
                            elseif table.empty(self:getEmptyPositions()) then --检查是否平局
                                -- self:setInt("twist", 2)
                                -- logAll("AI赢了-----------")

                                GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_BLACK)

                                LoopManager:setTimeout(1, self, function ()
                                    self:initTictactoe()
                                    GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
                                end)
                            else
                                self:onAIMakeMove()
                                if self:checkWin(2) then
                                    self:setInt("twist", 2)
                                    -- logAll("AI赢了-----------")
                                    self:setTrigger("tie")
                                    self.m_chessIndex = 1
                                end
                            end
                        end

                        self.m_lastPhysicsAni = nil
                    else
                        self.m_lastPhysicsAni = animator
                    end
                end
            else
                if self.m_lastPhysicsAni then
                    self.m_lastPhysicsAni:Play(gs.Animator.StringToHash("OX_Empty"), 0)
                    self.m_lastPhysicsAni = nil
                end
            end
        end
    end
end

-- function set_trigger(self, key)
--     super.set_trigger(self, key)

-- if not table.empty(self.m_HYSModel) then
--     for k, v in pairs(self.m_HYSModel) do
--         v:GetComponent(ty.Animator):SetTrigger(key)
--     end
-- end
-- end

-- function setInt(self, key, value)
-- super.setInt(self, key, value)

-- if not table.empty(self.m_HYSModel) then
--     for k, v in pairs(self.m_HYSModel) do
--         v:GetComponent(ty.Animator):SetInteger(key, value)
--     end
-- end
-- end

-- function showHYSModel(self, modelName)
--     if self.m_HYSModel[modelName] ~= nil and not gs.GoUtil.IsGoNull(self.m_HYSModel[modelName]) then
--         self.m_HYSModel[modelName].transform:Find("mesh").gameObject:SetActive(true)
--         self.m_HYSModel[modelName].transform:Find(modelName).gameObject:SetActive(true)
--     end
-- end

-- function clearHYSModel(self)
--     if self.m_HYSModel then
--         for k, v in pairs(self.m_HYSModel) do
--             gs.GameObject.Destroy(v)
--         end
--         self.m_HYSModel = nil
--     end

--     self.m_twistHysDic = nil
-- end

-- function onClickHYSTwist(self, twist_type)
--     self:setInt("twist", twist_type)
--     self.m_twistHysDic[twist_type] = 1

--     if table.nums(self.m_twistHysDic) == 5 then
--         self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
--         self.m_twistHysDic = nil
--     end
-- end

function checkSpineCollider(self)
    if self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_idle01") then
        if self.m_propState ~= nil then
            local drag_bones =
            {
                BigHostelConst.FullBodyBipedEffector.RightFoot,
            }

            local function dragDown(drag_pos)
                self.m_faceValue = 0
                self.m_SZTDragDown = true
            end

            local function dragUp(drag_pos)
                if drag_pos ~= gs.VEC3_ZERO then
                    self:setInt("twist", 2)
                    self.m_SZT01Twist02 = true
                end
                self.m_SZTDragDown = false
            end

            local limit = {min_x = 0.02, max_x = 0, min_y = 0.1, max_y = 0.1, min_z = 0.1, max_z = 0.1}
            self:addIKDragVo("SZT_idle01", self.m_FBBIK.references.rightFoot.gameObject, {x = 0.1, y = 0.1, z = 0.1}, self.m_DragQuadDic["SZT_idle01_R_Foot"], drag_bones, dragDown, nil, dragUp, limit, 8, nil, -1)

            local function onPointDown()
                self:setInt("twist", 1)
                self.m_SZT01Twist01 = true
            end
            self:addCapsuleColliderEventByName("Bip001 R Calf", 0.06, 0.6, gs.Vector3(-0.2, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, -1, true)

            self:removeCapsuleColliderEventByName("Bip001 Spine2")
        else
            self:recoverIKDragVo("SZT_idle01")
            self:removeCapsuleColliderEventByName("Bip001 R Calf")

            local function onPointDown()
                self:setTrigger("switch_idle")
            end

            self:addCapsuleColliderEventByName("Bip001 Spine2", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown)
        end
    elseif self.m_curBodyShortHash == gs.Animator.StringToHash("SZT_idle02") then
        local efx_time, no_cursor = -1, nil
        if self.m_propState ~= nil then
            local function onPointDown_01()
                self:setInt("twist", 1)
                self.m_SZT02Twist01 = true
            end

            self:addCapsuleColliderEventByName("Bip001 Head", 0.1, 0.1, gs.Vector3(-0.08, 0.05, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown_01, nil, -1, true)

            -- efx_time = -1
            no_cursor = true
        else
            self:removeCapsuleColliderEventByName("Bip001 Head")
        end

        local function onPointDown()
            if self.m_propState == nil and (self.m_SZT02Twist01 ~= true or self.m_SZT02Twist02 ~= true) then
                self:setTrigger("switch_idle")
            else
                self:setInt("twist", 2)
                self.m_SZT02Twist02 = true
            end
        end

        self:addCapsuleColliderEventByName("Bip001 Spine2", 0.15, 0.5, gs.Vector3(-0.05, 0, 0), BigHostelConst.CapsuleColliderDic.x, onPointDown, nil, efx_time, no_cursor)
    end
end

function showProp(self, type)
    if self.m_showProp ~= type then
        local data =
        {
            key = "KT_stand1",
            list =
            {
                [1] =
                {
                    icon = "arts/ui/pack/bigHostel/bigHostel_icon_06.png",
                    bg = "arts/ui/pack/bigHostel/bigHostel_btn_19.png",
                    state = 1,
                    clickCall = function ()
                        if self.m_propState ~= 1 then
                            self.m_propState = 1

                            self.m_interactiveGo = gs.ResMgr:LoadGO("arts/sceneModule/3d_hostel_dynamic/maobi/modelmaobi.prefab")

                            self.m_interactiveGo.transform.position = self.m_FBBIK.references.spine[1].position + gs.Vector3(0, 0.2, 0)
                            self.m_interactiveGo.transform:LookAt(self.m_FBBIK.references.spine[1])
                        else
                            self:clearPropGo()
                        end

                        self:checkSpineCollider()

                        return self.m_propState
                    end,
                },
            },
        }
        bigHostel.BigHostelManager:setSceneProps(data)
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SHOW_SCENEPROPSLIST)
        self.m_showProp = type

        self.m_propState = nil
    end
end

function clearPropGo(self)
    if self.m_interactiveGo ~= nil and not gs.GoUtil.IsGoNull(self.m_interactiveGo) then
        gs.GameObject.Destroy(self.m_interactiveGo)
        self.m_interactiveGo = nil
    end

    self.m_propState = nil

    self.m_showProp = nil
end

------------------------------------------------------井字棋相关--------------------------------------------------------
function putChess(self, row, col, type)
    local node = self.m_boardNode.transform:Find(row .. "_" .. col)
    if node and not gs.GoUtil.IsCompNull(node) then
        self:removeBoxColliderEventByGo(node.gameObject)

        if self.boardDic[row] then
            self.boardDic[row][col] = type
        end
        if type == 1 then
            node:GetComponent(ty.Animator):Play(gs.Animator.StringToHash("OX_X"), 0)
            AudioManager:playSoundEffect("arts/audio/sfx/4530/sfx_role_4530_2_h_10.prefab")
        elseif type == 2 then
            node:GetComponent(ty.Animator):Play(gs.Animator.StringToHash("OX_O"), 0)
        end
    end
end

function initTictactoe(self)
    self.m_boardNode = gs.GameObject.Find("QP_node")
    if self.m_boardNode ~= nil and not gs.GoUtil.IsGoNull(self.m_boardNode) then
        local childCount = self.m_boardNode.transform.childCount
        for i = 0, childCount - 1 do
            local node = self.m_boardNode.transform:GetChild(i)
            node:GetComponent(ty.Animator):Play(gs.Animator.StringToHash("OX_Empty"), 0)

            node.gameObject.layer = gs.LayerMask.NameToLayer("Physics_Move")
            self:addBoxColliderEventByGo(node.gameObject, gs.Vector3(0.2, 0.2, 0.02), nil, nil, nil, -1)
        end
    end

    self.boardDic = {}
    for r = 1, 3 do
        self.boardDic[r] = {}
        for c = 1, 3 do
            self.boardDic[r][c] = 0
        end
    end

    if self.m_chessIndex == nil then
        self.m_chessIndex = 1
    end

    local t =
    {
        [1] = {30, 90, 100},
        [2] = {20, 80, 100},
        [3] = {10, 40, 100},
        [4] = {10, 30, 100},
        [5] = {10, 20, 100},
    }
    if self.m_chessIndex > table.nums(t) then
        return
    end

    local random = math.random(1, 100)
    for i = 1, #t[self.m_chessIndex] do
        if random <= t[self.m_chessIndex][i] then
            self.m_tictactoeAIDiff = i
            break
        end
    end

    logAll("当前阶段：" .. self.m_chessIndex)
    logAll("当前难度：" .. self.m_tictactoeAIDiff)
end

function removeTictactoeCollider(self)
    if self.m_boardNode ~= nil and not gs.GoUtil.IsGoNull(self.m_boardNode) then
        local childCount = self.m_boardNode.transform.childCount
        for i = 0, childCount - 1 do
            local node = self.m_boardNode.transform:GetChild(i)
            node.gameObject.layer = gs.LayerMask.NameToLayer("Physics_Move")
            self:removeBoxColliderEventByGo(node.gameObject)
        end
    end
    self.m_boardNode = nil
end

function resetTictactoe(self)
    local boardNode = gs.GameObject.Find("QP_node")
    if boardNode ~= nil and not gs.GoUtil.IsGoNull(boardNode) then
        local childCount = boardNode.transform.childCount
        for i = 0, childCount - 1 do
            local node = boardNode.transform:GetChild(i)
            node:GetComponent(ty.Animator):Play(gs.Animator.StringToHash("OX_Empty"), 0)
        end
    end
end

--AI下
function onAIMakeMove(self)
    local move
    if self.m_tictactoeAIDiff == 1 then
        move = self:onAISimpleMove()
    elseif self.m_tictactoeAIDiff == 2 then
        move = self:onAIAdvancedMove()
    elseif self.m_tictactoeAIDiff == 3 then
        move = self:onAIExpertMove()
    end

    if not move then
        logError("找不到下的位置")
        return
    end

    self:putChess(move.row, move.col, 2)
end

-- 1. 简易AI：纯随机落子（无任何策略）
function onAISimpleMove(self)
    local empty = self:getEmptyPositions()
    if #empty == 0 then return nil end
    local randomIdx = math.random(1, #empty)
    return empty[randomIdx]
end

-- 2. 进阶AI：优先占中心（位置5）→ 中心被占则随机
function onAIAdvancedMove(self)
    local empty = self:getEmptyPositions()
    if #empty == 0 then return nil end

    -- 优先占中心（位置5，对应row=2, col=2）
    for _, pos in ipairs(empty) do
        if pos.num == 5 then
            return pos
        end
    end

    -- 中心被占则随机落子
    return self:onAISimpleMove()
end

-- 3. 高手AI：优先赢→防玩家赢→优先角落→其次中心→最后随机
function onAIExpertMove(self)
    local empty = self:getEmptyPositions()
    if #empty == 0 then return nil end

    -- 第一步：检查自己是否能一步赢
    for _, pos in ipairs(empty) do
        self.boardDic[pos.row][pos.col] = 2 -- 临时落子
        if self:checkWin(2) then
            self.boardDic[pos.row][pos.col] = 0 -- 还原
            return pos
        end
        self.boardDic[pos.row][pos.col] = 0 -- 还原
    end

    -- 第二步：防守，阻止玩家一步赢
    for _, pos in ipairs(empty) do
        self.boardDic[pos.row][pos.col] = 1 -- 临时落子
        if self:checkWin(1) then
            self.boardDic[pos.row][pos.col] = 0 -- 还原
            return pos
        end
        self.boardDic[pos.row][pos.col] = 0 -- 还原
    end

    -- 第三步：优先占角落（位置1/3/7/9）
    local corners = {1, 3, 7, 9}
    local availableCorners = {}
    for _, cornerNum in ipairs(corners) do
        for _, pos in ipairs(empty) do
            if pos.num == cornerNum then
                table.insert(availableCorners, pos)
            end
        end
    end
    if #availableCorners > 0 then
        local randomIdx = math.random(1, #availableCorners)
        return availableCorners[randomIdx]
    end

    -- 第四步：占中心（位置5）
    for _, pos in ipairs(empty) do
        if pos.num == 5 then
            return pos
        end
    end

    -- 第五步：随机落子
    return self:onAISimpleMove()
end

function getEmptyPositions(self)
    local empty = {}
    for r = 1, 3 do
        for c = 1, 3 do
            if self.boardDic[r][c] == 0 then
                local posNum = (r - 1) * 3 + c
                table.insert(empty, {row = r, col = c, num = posNum})
            end
        end
    end
    return empty
end

function checkWin(self, marker_type)
    -- 检查行
    for i = 1, 3 do
        if self.boardDic[i][1] == marker_type and self.boardDic[i][2] == marker_type and self.boardDic[i][3] == marker_type then
            return true
        end
    end
    -- 检查列
    for j = 1, 3 do
        if self.boardDic[1][j] == marker_type and self.boardDic[2][j] == marker_type and self.boardDic[3][j] == marker_type then
            return true
        end
    end
    -- 检查对角线
    if (self.boardDic[1][1] == marker_type and self.boardDic[2][2] == marker_type and self.boardDic[3][3] == marker_type) or
        (self.boardDic[1][3] == marker_type and self.boardDic[2][2] == marker_type and self.boardDic[3][1] == marker_type) then
        return true
    end
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
